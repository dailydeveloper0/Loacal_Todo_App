enum TodosStatus { initial, loading, success, error }

class Todo {
  int? id;
  String title;
  String description;
  bool isCompeleted;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.isCompeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompeleted':isCompeleted?1:0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      isCompeleted: data['isCompeleted'] == 1?true:false,
    );
  }
}
