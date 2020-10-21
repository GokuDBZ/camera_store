module Auth
    # included do
	# 	skip_before_action :authenticate, only: [:login, :signup]
    # end

    def authenticate
        authenticate_or_request_with_http_token do |token, _options|
            User.find_by(token: token)
        end
    end

    def current_user
        @current_user ||= authenticate
    end
end