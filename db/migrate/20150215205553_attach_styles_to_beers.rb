class AttachStylesToBeers < ActiveRecord::Migration
  def change
    beers = Beer.all
    beers.each do |b|
      #b.style = Style.find_by(name:b.old_style)
      #b.save!
      sid = Style.find_by(name:b.old_style).id
      execute "UPDATE beers SET style_id = '#{sid}' WHERE id = '#{b.id}'"
    end
  end
end
