class CGI::Session
  # create new session
  def self.create(request, options = {})
    session = self.read(request, options)
    session.delete if session
    options['new_session'] = true
    CGI::Session.new(request, options)
  end

  # read session if exist
  def self.read(request, options = {})
    options['new_session'] = false
    begin
      CGI::Session.new(request, options)
    rescue ArgumentError  # if no old session
    end
  end
end

class CGI
  attr_accessor :session
  alias :initialize_orginal :initialize

  def initialize(*args)
    initialize_orginal(*args)
    @session = CGI::Session.read(self)
  end

  def create_session
    @session = CGI::Session.create(self)
  end

  def delete_session
    @session.delete if @session
    @session = nil
  end

  def session_id
    @session ? @session.session_id : ''
  end
end