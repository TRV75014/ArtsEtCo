module UsersHelper
  # Retourne le nom d'utilisateur
  def username
    current_user.username
  end

  def is_admin
    current_user.is_admin
  end

  def session_user_id
    current_user.id
  end

  def note_moyenne_sans_ml
    @rates = Rate.where(rater_id: session_user_id)
    @note_moyenne = 0.0
    i = 0
    @rates.each do |r|
      is_ml = Painting.find(r.rateable_id).is_ml
      if not is_ml
        @note_moyenne = @note_moyenne+ r.stars
        i += 1
      end
    end
    @note_moyenne /= i
    '%.2f' % @note_moyenne
  end

  def note_moyenne_ml
    @rates = Rate.where(rater_id: session_user_id)
    @note_moyenne = 0.0
    i = 0
    @rates.each do |r|
      is_ml = Painting.find(r.rateable_id).is_ml
      if is_ml
        @note_moyenne = @note_moyenne+ r.stars
        i += 1
      end
    end
    @note_moyenne /= i
    '%.2f' % @note_moyenne
  end
end
