module ActiveRecord
  class Base
    module VeneerInterface
      class ClassWrapper < Veneer::Base::ClassWrapper
        def new(opts = {})
          ::Kernel::Veneer(klass.new(opts))
        end

        def collection_associations
          @collection_associations ||= begin
            associations = []
            [:has_many, :has_and_belongs_to_many].each do |macro|
              associations += klass.reflect_on_all_associations(macro)
            end
            associations.inject([]) do |ary, reflection|
              ary << {
                :name  => reflection.name,
                :class => reflection.class_name.constantize
              }
              ary
            end
          end
        end

        def member_associations
          @member_associations ||= begin
            associations = []
            [:belongs_to, :has_one].each do |macro|
              associations += klass.reflect_on_all_associations(macro)
            end
            associations.inject([]) do |ary, reflection|
              ary << {
                :name  => reflection.name,
                :class => reflection.class_name.constantize
              }
              ary
            end
          end
        end

        def destroy_all
          klass.destroy_all
        end

        def find_first(opts)
          klass.find(:first, opts.to_hash.symbolize_keys)
        end

        def find_many(opts)
          klass.find(:all,opts.to_hash.symbolize_keys)
        end
      end # ClassWrapper

    end
  end
end