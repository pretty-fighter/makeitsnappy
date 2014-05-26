class User < ActiveRecord::Base
  has_many :questions
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { in: 4..12 },
                       format: { with: /\A[a-z][a-z0-9]*\z/, 
                       	         message: 'can only contain lowercase letters or numbers' }

  validates :password, length: { in: 4..8 }
  validates :password_confirmation, length: { in: 4..8 }

  def your_questions(params)
    questions.paginate(page: params[:page], per_page: 3, order: 'created_at DESC')
  end
end
