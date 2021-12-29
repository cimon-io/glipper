module Glipper
  module Descedants
    extend ActiveSupport::Concern

    module ClassMethods
      def descendants
        descendant_files
          .map { |i| Pathname.new(i).relative_path_from(descendant_root) }
          .map(&:to_s)
          .map { |i| i.gsub(/\.rb\z/, '') }
          .map(&:classify)
          .map(&:constantize)
          .select { |k| k < self } + [self]
      end

      def descendants_with_targets
        result = []

        self.descendants.each do |d|
          d.object_classes.each do |object_class|
            result.push [object_class, d]
          end
        end

        Hash[result]
      end

      def find_drapper_for(resource)
        object_klasses = ->(klass) {
          return [klass] if self.root_classes.include? klass
          Array.wrap(klass) + object_klasses[klass.superclass]
        }
        key = object_klasses[resource.class].find { |klass| self.descendants_with_targets.key?(klass) }
        self.descendants_with_targets[key]
      end

      def root_classes
        [ActiveRecord::Base, ActiveRecord::Relation, Array]
      end

      def engine_root
        Rails.root
      end

      def descendant_files
        Dir[descendant_path]
      end

      def descendant_root
        engine_root.join('app', descendant_folder_name)
      end

      def descendant_folder_name
        'glippers'
      end

      def descendant_file_mask
        '*_glipper.rb'
      end

      def descendant_path
        descendant_root.join('**', descendant_file_mask)
      end

      def decorates(*object_classes)
        @object_classes = object_classes
      end

      def object_classes
        @object_classes
      end
    end
  end
end
