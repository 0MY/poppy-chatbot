require 'rest-client'

class PoppyApi

  def initialize
    @uri = "#{ENV["POPPY_WEB"]}"
  end

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



  def motor_list
    # Poppy API
    # GET /motor/list.json
    #   json: {"robot": {"get_motors_list": {"alias": "motors"}}}
    #   answer exemple: {'motors': ["l_elbow_y", "r_elbow_y", "r_knee_y", "head_y", "head_z"]}
    call_motor("motor", "list")
  end


  def call_primitive(action, operation)
    uri = "#{@uri}/#{action}/#{operation}.json"
    response = RestClient.get uri
    { result: response.code, answer: JSON.parse(response.body) }
  end

  def call_motor(target, operation)
    uri = "#{@uri}/#{target}/#{operation}.json"
    response = RestClient.get uri
    raise
  end

  # Poppy API
  # POST /motor/<motor_name>/register/<register_name>/value.json
  #   json: {"robot": {"set_register_value": {"motor": "", "register": "", "value": {"arg1": "val1", "arg2": "val2", "...": "..."}}}
  #   answer exemple: {}

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
