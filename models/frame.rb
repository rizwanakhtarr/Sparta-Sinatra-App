class Frame
  attr_accessor :frame_id, :name, :description, :price

  def self.open_connection
    conn = PG.connect(dbname: "appdb", user: "postgres", password: "rizwanakhtar786.")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM frame ORDER by frame_id"

    results = conn.exec(sql)

    frames = results.map do |data|
      self.hydrate data
    end
    return frames
  end

  def self.hydrate frame_data
    frame = Frame.new

    frame.frame_id = frame_data["frame_id"]
    frame.name = frame_data["name"]
    frame.description = frame_data["description"]
    frame.price = frame_data["price"]

    return frame

  end

  def self.find frame_id
    conn = self.open_connection

    sql = "SELECT * FROM frame WHERE frame_id = #{frame_id}"

    frames = conn.exec(sql)

    return self.hydrate frames[0]

  end

  def save
   conn = Frame.open_connection
    if !self.frame_id

    sql = "INSERT INTO frame (name, description, price) VALUES ('#{self.name}', '#{self.description}', '#{self.price}')"

   else
   sql = "UPDATE frame SET name='#{self.name}', description='#{self.description}', price = '#{self.price}' WHERE frame_id = #{self.frame_id}"
   end
    conn.exec(sql)
  end
  #
  def self.destroy frame_id
    conn = self.open_connection

    sql = "DELETE FROM frame WHERE frame_id = #{frame_id}"

    conn.exec(sql)

  end
end
