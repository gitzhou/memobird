require 'memobird/version'
require 'erb'
require 'json'
require 'addressable/uri'
require 'http'

# Memobird API wrapper
module Memobird

  HOST = 'http://open.memobird.cn/home'.freeze
  API_RETRIEVE_USER_ID = "#{HOST}/setuserbind".freeze
  API_PRINT_CONTENT = "#{HOST}/printpaper".freeze

  class << self
    attr_accessor :api_key, :user_id, :memobird_id, :user_identifying

    def print_content(content = {})
      raise 'Please set up first' if not_ready?
      load_user_id if user_id.nil?
      puts content
      response = http_get(build_url(API_PRINT_CONTENT,
                                    userid: user_id,
                                    printcontent: build_print_content(content)))
      puts response['showapi_res_error'].to_s + ' ' + response['printcontentid'].to_s
    rescue StandardError => e
      puts 'Print content error. ' + e.message
    end

    private

    def not_ready?
      api_key.nil? || memobird_id.nil? || user_identifying.nil?
    end

    def http_get(url)
      puts "Call #{url}"
      JSON.parse(HTTP.get(url).to_s)
    end

    def load_user_id
      File.open('user.id.txt', 'r').each do |line|
        self.user_id = line.delete("\n")
        puts 'User id ' + user_id
      end
    rescue StandardError => e
      puts 'Load user id error. ' + e.message
      puts 'Retrieve user id from API'
      retrieve_user_id
      save_user_id
    end

    def retrieve_user_id
      response = http_get(build_url(API_RETRIEVE_USER_ID,
                                    useridentifying: user_identifying))
      self.user_id = response['showapi_userid'] if call_ok?(response)
    rescue StandardError => e
      puts 'Retrieve user id error. ' + e.message
      self.user_id = nil
    end

    def save_user_id
      File.open('user.id.txt', 'w') do |f|
        f.puts user_id
      end
    rescue StandardError => e
      puts 'Save user id error. ' + e.message
    end

    # response of json format
    def call_ok?(response = {})
      response['showapi_res_code'] == 1 && response['showapi_res_error'] == 'ok'
    rescue StandardError
      false
    end

    def build_url(url_base, params = {})
      params[:ak] = api_key
      params[:timestamp] = ERB::Util.url_encode(Time.now.strftime('%F %T'))
      params[:memobirdid] = memobird_id
      url = Addressable::URI.new
      url.query_values = params
      "#{url_base}?#{url.query}"
    end

    def build_print_content(content = {})
      build_text(content[:text]) || build_text(">> NO CONTENT <<\n")
    end

    def build_text(text)
      return nil if text.nil?
      'T:' + Base64.encode64(text.encode('GBK')).delete("\n")
    end
  end
end
