module Veneer
  module Errors
    class VeneerError     < StandardError; end
    class NotCompatible   < VeneerError; end
    class NotSaved         < VeneerError; end
    class ConditionalOperatorNotSupported < VeneerError; end
  end
end