class Book {
  final String id;
  final String imgSrc;
  final String title;
  final List<dynamic> author;
  final int publicationYear;
  final String mainField;

  Book({
    required this.id,
    required this.imgSrc, 
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.mainField
  });

  @override
  bool operator ==(covariant Book b){
    if(identical(this, b)) return true;
    return id == b.id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ author.hashCode ^ publicationYear.hashCode;
  }
}
