class Response
  def initialize(code:, data:)
    @response =
      "HTTP/1.1 #{code}\r\n" +
        "Content-Length: #{data.size}\r\n" +
        "\r\n" +
        "#{data}"
  end

  def send(client)
    client.write(@response)
  end
end
