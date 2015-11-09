


3.times do
  Post.create title: 'Este es el titulo',body: 'Este es el cuerpo del post que es diferente al anterior'
end

Word.create( content: 'feliz' , kind: Word::KIND_HAPPY)
Word.create( content: 'contento' , kind: Word::KIND_HAPPY)
Word.create( content: 'perros' , kind: Word::KIND_HAPPY)
Word.create( content: 'entusiasmo' , kind: Word::KIND_HAPPY)
Word.create( content: 'alegria' , kind: Word::KIND_HAPPY)
Word.create( content: 'juego' , kind: Word::KIND_HAPPY)
Word.create( content: 'divercion' , kind: Word::KIND_HAPPY)
Word.create( content: 'bueno' , kind: Word::KIND_HAPPY)


Word.create( content: 'malo' , kind: Word::KIND_SAD)
Word.create( content: 'triste' , kind: Word::KIND_SAD)
Word.create( content: 'muerte' , kind: Word::KIND_SAD)
Word.create( content: 'desepcion' , kind: Word::KIND_SAD)
Word.create( content: 'aburricion' , kind: Word::KIND_SAD)
Word.create( content: 'soledad' , kind: Word::KIND_SAD)
Word.create( content: 'depresion' , kind: Word::KIND_SAD)






