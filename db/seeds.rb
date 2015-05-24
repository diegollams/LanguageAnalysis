
random = Random.new

10.times do
  Post.create title: 'Este es el titulo',body: 'Este es el cuerpo del post que es diferente al anterior',evaluated: (random.rand * 15).to_int,rate: (random.rand * 15).to_int
end

