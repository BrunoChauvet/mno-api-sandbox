class Api::V1::Account::UsersController < Api::V1::BaseController
  
  # GET /api/v1/account/users
  def index
    @entities = []
    parent = current_app
    
    if (gid = params.delete(:group_id))
      parent = current_app.groups.find_by_uid(gid)
    end
    
    if parent
      @entities = parent.users.with_param_filters(params)
    end
    
    logger.info("INSPECT: entities => #{@entities.to_json}")
  end
  
  # GET /api/v1/account/users/usr-gf784154
  def show
    @entity = current_app.users.find_by_uid(params[:id])
    
    if !@entity
      @errors[:id] = ["does not exist"]
      logger.error(@errors)
    end
    
    logger.info("INSPECT: entity => #{@entity.to_json}")
  end
  
  # POST /api/v1/account/users/authenticate
  # Simulate invalid password by passing "invalid_password" as a
  # password
  def authenticate
    if params[:id]
      user = current_app.users.find_by_uid(params[:id])
    elsif params[:email]
      user = current_app.users.find_by_email(params[:email])
    end
    
    logger.info("INSPECT: user => #{user.to_json}")
    
    # Decrypt password
    begin
      iv_64, enc_pwd_64 = params[:password].split("--")
      decrypted_pw = Encryptor.decrypt(Base64.decode64(enc_pwd_64), key: current_app.api_token, iv: Base64.decode64(iv_64))
    rescue OpenSSL::Cipher::CipherError => e
      logger.error("INSPECT: decrypt error: #{e}")
      decrypted_pw = nil
    end
    
    if user && decrypted_pw && decrypted_pw != "invalid_password"
      logger.info("INSPECT: password considered valid")
      @entity = user
    else
      logger.error("INSPECT: password considered invalid")
      @errors[:password] = ["invalid password or non existing user"]
    end
    
    render 'show'
  end
end