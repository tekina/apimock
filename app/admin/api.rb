ActiveAdmin.register Api do
  actions :index, :show, :new, :create, :update, :edit
  permit_params :endpoint, :required_params, :required_headers, :success_response, :error_response

  index do
    selectable_column
    id_column
    column :endpoint
    column :required_params
    column :required_headers
    column :success_response do |api|
      div class: "response" do
        api.success_response.present? ? api.success_response : '-'
      end
    end
    column :error_response do |api|
      div class: "response" do
        api.error_response.present? ? api.error_response : '-'
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :endpoint, as: :string, label: "Endpoint (eg: /v4/home/cities) - leading '/' required"
      f.input :request_type, as: :string, label: "Request Type (get, post, put, delete etc.)"
      f.input :required_params, as: :string, label: "Required params (eg: platform, version) - comma separated"
      f.input :required_headers, as: :string, label: "Required headers (eg: auth-token) - comma separated"
      f.input :success_response, as: :text, label: "Success Response (JSON format only)"
      f.input :error_response, as: :text, label: "Error Response (Work in Progress, not functional)"
      # f.input :submit
    end
    f.actions
  end

end