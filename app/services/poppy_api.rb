require 'rest-client'

class PoppyApi

  def initialize
    @uri = "#{ENV["POPPY_WEB"]}/primitive"
  end

  def danse(operation)
    call_primitive("dance_beat_motion",operation)
  end

  def call_primitive(move, operation)
    uri = "#{@uri}/#{move}/#{operation}.json"
    response = RestClient.get uri
    raise
    # case response
    # when
    #   "OK"
    # else
    #   "KO"
    # end
  end
end


