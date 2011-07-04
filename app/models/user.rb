# Модель (класс для работы с данными из базы данных) редактора, который может
# изменять тексты на сайте
class User
  include Mongoid::Document
  
  field :name                  # Имя редактора
  field :email                 # Эл. почта редактора
  field :role                  # Сфера деятельности редактора.
  field :auth_provider         # Сервис, с помощью котого пользователь входит на
                               # сайт (например, с помощью аккаунта Google)
  field :auth_uid              # ID пользователя в сервисе, с помощью которого
                               # пользователь входит на сайт
  field :reset_auth_token      # Случайная строка, чтобы пользователь мог
                               # изменить свои auth_provider и auth_uid
  field :session_token         # Случайная строка, которую мы записываем в
                               # сессию, чтобы знать, что пользователь уже
                               # вошёл на сайт. Как бы «пароль» от сайта
  field :signin_at, type: Time # Когда пользователь последний раз входил на сайт
  include Mongoid::Timestamps  # Добавляет поля created_at и updated_at,
                               # чтобы знать когда мы создали пользователя,
                               # и когда последний раз изменили
  
  # Проверяем, что эл. почту указали, указали правиль, и что она уникальна
  validates :email, presence: true, email: true, uniqueness: true
  
  # Во время создания пользователя генерируем токены
  after_create :generate_session_token!
  after_create :generate_reset_auth_token!
  
  # Создаём индексы, чтобы быстрее искать по каким-то полям
  index :session_token,              unique: true
  index [:auth_provider, :auth_uid], unique: true
  index :name

  # Генерируемновый новый случайный session_token, по которому проверяем,
  # что пользователь уже вошёл на сайт
  def generate_session_token!
    self.session_token = SecureRandom.base64
    self.save!
  end
  
  # Генерирует новый случайный reset_auth_token, чтобы пользователь мог
  # доказать, что это он, ещё до того, как выставил auth_provider и auth_uid.
  def generate_reset_auth_token!
    self.reset_auth_token = SecureRandom.base64
    self.save!
  end
  
  # Открыл ли пользователь ссылку из пригласительно письма и выбрал ли способ
  # входа на сайт
  def confirmed?
    auth_uid and auth_provider
  end
end
