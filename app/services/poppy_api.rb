require 'rest-client'

class PoppyApi

  def initialize
    @uri = "#{ENV["POPPY_WEB"]}/primitive"
  end

  def init(operation)
    call_primitive("init_position",operation)
  end

  def head(operation)
    call_primitive("head_idle_motion",operation)
  end

  def dance(operation)
    call_primitive("dance_beat_motion",operation)
  end

  def idle(operation)
    call_primitive("upper_body_idle_motion",operation)
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


