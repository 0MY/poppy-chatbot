require 'rest-client'

class PoppyApi

  def initialize
    @uri = "#{ENV["POPPY_WEB"]}/primitive"
  end

  def dance(operation)
    call_primitive("dance_beat_motion",operation)
  end

  def call_primitive(move, operation)
    uri = "#{@uri}/#{move}/#{operation}.json"
    puts  "=========== #{uri} ============================="
    response = RestClient.get uri
    # case response
    # when
    #   "OK"
    # else
    #   "KO"
    # end
  end
end


