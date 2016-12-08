csv_str = CSV.generate do |csv|
  csv << @books.column_names
    @books.all.each do |book|
    csv << book.attributes.values_at(*@books.column_names)
  end
end

NKF::nkf('--sjis -Lw', csv_str)