module Fog
  module Kubevirt
    class Compute
      module VmAction
        def start(options = {})
          # Set runStrategy to 'Always' so that the virtual machine controller will take it and
          # create the virtual machine instance.
          vm = service.get_raw_vm(name)
          vm[:spec].delete(:running) if vm[:spec].key?(:running)
          vm = deep_merge!(vm,
            :spec => {
              :runStrategy => 'Always'
            }
          )
          service.update_vm(vm)
        end

        def stop(options = {})
          vm = service.get_raw_vm(name)
          vm[:spec].delete(:running) if vm[:spec].key?(:running)
          vm = deep_merge!(vm,
            :spec => {
              :runStrategy => 'Halted'
            }
          )
          service.update_vm(vm)
        end
      end
    end
  end
end
