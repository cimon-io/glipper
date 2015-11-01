module Glipper
  module Descedants
    extend ActiveSupport::Concern

    module ClassMethods
      def descendants
        descendant_files.map { |i| File.basename(i, '.rb') }.map(&:classify).map(&:constantize).select { |k| k < self } + [self]
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

      def descendant_path
        engine_root.join('app', 'drappers', '**', '*_drapper.rb')
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
