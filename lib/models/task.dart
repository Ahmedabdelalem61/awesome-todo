class Task{
  String? title;
  String? date;
  String? start;
  String? end;
  int? reminder;
  int? completed;
  int? favourite;
  int? id;

  Task({required this.title,required this.date,required this.start,required this.end,required this.reminder,required this.favourite,required this.completed,this.id});

  Task.fromJson(Map<String,dynamic> json){
    title = json['title'];
    date = json['date'];
    start = json['start'];
    end = json['end'];
    reminder = json['reminder'];
    completed = json['completed'];
    favourite = json['favourite'];
    id = json['id'];
  }

  Map<String,Object?> toMap()=>{
    'title':title,
    'date':date,
    'start':start,
    'end':end,
    'reminder':reminder,
    'favourite':favourite,
    'completed' : completed,
  };
}