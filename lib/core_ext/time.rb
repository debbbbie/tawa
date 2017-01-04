class Time
  def human_display
    st = Time.now.beginning_of_day
    nd = Time.now.end_of_day

    case
      when self.between?(st + 1.day, nd + 1.day)
        "明天"
      when self.between?(st + 2.day, nd + 2.day)
        "后天"
      when self.between?(st, nd)
        "今天"
      when self.between?(st - 1.day, nd - 1.day)
        "昨天"
      when self.between?(st - 6.day, nd - 2.day)
        self.strftime('%a %H:%M')
      else
        self.strftime('%y-%b-%d %H:%M')
    end
  end
end
