require 'rest-client'

MOTOR_NAMES = []

class PoppyApi

  def initialize
    @uri = ENV["POPPY_WEB"]
  end

  # Primitives Methods
  # ------------------

  def init(operation)
    call_primitive("primitive/init_position", operation)
  end

  def head(operation)
    call_primitive("primitive/head_idle_motion", operation)
  end

  def dance(operation)
    call_primitive("primitive/dance_beat_motion", operation)
  end

  def idle(operation)
    call_primitive("primitive/upper_body_idle_motion", operation)
  end

  def primitive(operation)
    # Poppy API
    # GET /primitive/list.json
    #   json: {"robot": {"get_primitives_list": ""}}
    #   answer exemple: {'primitives': ["stand_up", "sit", "head_tracking"]}
    call_primitive("primitive", operation)
  end

  def running(operation)
    # Poppy API
    # GET /primitive/running/list.json
    #   json: {"robot": {"get_primitives_list": ""}}
    #   answer exemple: {'primitives': ["head_tracking"]}
    call_primitive("primitive/running", operation)
  end



  # Motors Methods
  # --------------

  def get_register(motor, arg)
    # Poppy API
    # GET /motor/<motor_name>/register/<register_name>
    # json: {"robot": {"get_register_value": {"motor": "", "register": ""}}}
    # anwer example: {"present_position": 30}
  end

  def set_register(motor, arg, value)
  # Poppy API
  # POST /motor/<motor_name>/register/<register_name>/value.json
  #   json: {"robot": {"set_register_value": {"motor": "", "register": "", "value": {"arg1": "val1", "arg2": "val2", "...": "..."}}}
  #   answer exemple: {}
  end

  def get_position(motor, arg)
    call_motor("motor/#{motor}/register/#{arg}", "")
  end

  def set_position(motor, arg, value)
    call_motor("motor/#{motor}/register/#{arg}", "value")
  end

  def get_speed(motor, arg)
  end

  def set_speed(motor, arg, value)
  end

  def get_load(motor, arg)
  end

  def set_torque(motor, arg, value)
  end

  def list_motor
    # Poppy API
    # GET /motor/list.json
    #   json: {"robot": {"get_motors_list": {"alias": "motors"}}}
    #   answer exemple: {'motors': ["l_elbow_y", "r_elbow_y", "r_knee_y", "head_y", "head_z"]}
    call_motor("motor", "list")
  end

  def list_alias
    call_motor("motor/alias", "list")
  end

  def list_alias_motors(motor)
    call_motor("motor/#{motor}", "list")
  end

  def list_registers(motor)
    call_motor("motor/#{motor}/register/", "list")
  end

  # Primitives API call
  # -------------------
  def call_primitive(action, operation)
    uri = "#{@uri}/#{action}/#{operation}.json"
    response = RestClient.get uri
    if response.body.blank?
      { result: response.code, answer: "" }
    else
      { result: response.code, answer: JSON.parse(response.body) }
    end
  end

  # Motors API call
  # ---------------
  def call_motor(action, operation)
    uri = "#{@uri}/#{action}/#{operation}.json"
    response = RestClient.get uri
    { result: response.code, answer: JSON.parse(response.body) }
    raise
  end
end



# REST-CLIENT
# -----------
# https://github.com/rest-client/rest-client

# Call examples:
#   RestClient.get 'https://user:password@example.com/private/resource', {accept: :json}
#   RestClient.post 'http://example.com/resource', {param1: 'one', nested: {param2: 'two'}}
#   RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}

# Response objects have several useful methods. (See the class rdoc for more details.)

#     Response#code: The HTTP response code
#     Response#body: The response body as a string. (AKA .to_s)
#     Response#headers: A hash of HTTP response headers
#     Response#raw_headers: A hash of HTTP response headers as unprocessed arrays
#     Response#cookies: A hash of HTTP cookies set by the server
#     Response#cookie_jar: New in 1.8 An HTTP::CookieJar of cookies
#     Response#request: The RestClient::Request object used to make the request
#     Response#history: New in 2.0 If redirection was followed, a list of prior Response objects

# Response handling
# -----------------
# RestClient.get('http://example.com')
# ➔ <RestClient::Response 200 "<!doctype h...">

# begin
#  RestClient.get('http://example.com/notfound')
# rescue RestClient::ExceptionWithResponse => err
#   err.response
# end
# ➔ <RestClient::Response 404 "<!doctype h...">

# Response handling with blocs
# ----------------------------
# Don't raise exceptions but return the response
# RestClient.get('http://example.com/resource'){|response, request, result| response }
# ➔ 404 Resource Not Found | text/html 282 bytes

# # Manage a specific error code
# RestClient.get('http://my-rest-service.com/resource'){ |response, request, result, &block|
#   case response.code
#   when 200
#     p "It worked !"
#     response
#   when 423
#     raise SomeCustomExceptionIfYouWant
#   else
#     response.return!(request, result, &block)
#   end
# }
