module UsersHelper
  # Retourne le nom d'utilisateur
  def username
    current_user.username
  end

  def session_user_id
    current_user.id
  end

  # Retourne le nombre de tableaux notésca
  def tableaux_notes
    Painting.where('users_id = ?', session_user_id).count
  end

  def note_moyenne_sans_ml
    @paintings = Painting.where(users_id: session_user_id, is_ml: false)
    @note_moyenne = 0.0
    @paintings.each do |p|
      @note_moyenne = @note_moyenne+ p.mark
    end
    @note_moyenne /= @paintings.size
    '%.2f' % @note_moyenne
  end


  def note_moyenne_ml
    @ml_painitings = Painting.where(users_id: session_user_id, is_ml: true)
    @note_moyenne = 0.0
    @paintings.each do |p|
      @note_moyenne = @note_moyenne+ p.mark
    end
    @note_moyenne /= @paintings.size
    '%.2f' % @note_moyenne
  end

end
