class AddAttachmentPhotoToEntries < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :entries, :photo
  end
end
