class IntroduceStyleObject < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    current_styles = Beer.uniq.pluck(:style)
    current_styles.each do |s|
      Style.create(name:s,description:"empty")
    end
  end
end
