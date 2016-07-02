module HumanDate
  include ActionView::Helpers::DateHelper
  extend self

  def date_distance(from, to, long_form = true)
    seconds_in_day = 60 * 60 * 24    
    #days_difference = ((to.beginning_of_day.to_datetime - from.beginning_of_day.to_datetime)).floor
    days_difference = ((to - from)/seconds_in_day).round

    case days_difference
      when -2
        "antes de ayer"
      when -1
        "ayer"
      when 0
        "hoy"
      when 1
        "mañana"
      when 2..6
        "this #{day_name(days_difference)}"
      when 7..13
        "next #{to.strftime("%a")} (#{short_date(days_difference)})"
      else
        if days_difference > 0
          "en #{distance_of_time_in_words(from, to)} (#{short_date(days_difference, long_form)})"
        else
          if days_difference >=-7
           # "#{distance_of_time_in_words(from, to)} ago (#{short_date(days_difference, long_form)})"
           "Hace #{distance_of_time_in_words(from, to)}"
          else
             "Hace más de una semana"
          end            
        end
    end
  end

  def short_date(this_many, include_day=false)
    format_string = "%-b %-d"
    format_string = "%a, #{format_string}" if include_day
    this_many.days.from_now.strftime(format_string)
  end

  def day_name(this_many)
    this_many.days.from_now.strftime("%A")
  end

  def days_left_in_month
    Time.now.end_of_month.day - Time.now.day
  end

  def days_left_in_week
    Time.now.end_of_week.day - Time.now.day
  end
end