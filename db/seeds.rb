
random = Random.new

10.times do
  Post.create title: 'Este es el titulo',body: 'Este es el cuerpo del post que es diferente al anterior',evaluated: (random.rand * 15).to_int,rate: (random.rand * 15).to_int
end

Word.create( content: 'feliz' , kind: true)
Word.create( content: 'contento' , kind: true)
Word.create( content: 'perros' , kind: true)
Word.create( content: 'entusiasmo' , kind: true)
Word.create( content: 'alegria' , kind: true)
Word.create( content: 'juego' , kind: true)
Word.create( content: 'divercion' , kind: true)
Word.create( content: 'bueno' , kind: true)


Word.create( content: 'malo' , kind: false)
Word.create( content: 'triste' , kind: false)
Word.create( content: 'muerte' , kind: false)
Word.create( content: 'desepcion' , kind: false)
Word.create( content: 'aburricion' , kind: false)
Word.create( content: 'soledad' , kind: false)
Word.create( content: 'depresion' , kind: false)






