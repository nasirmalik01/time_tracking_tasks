class CompletedTaskModel {
  String? id;
  String? taskName;
  String? taskDesc;
  String? priority;
  String? dueDate;
  String? status;
  String? completionTime;
  String? completionDate;

  CompletedTaskModel({
      this.id,
      this.taskName,
      this.taskDesc,
      this.priority,
      this.dueDate,
      this.status,
      this.completionTime,
      this.completionDate,
      });

  CompletedTaskModel.fromJson(Map json) {
    id = json['id'];
    taskName = json['task_name'];
    taskDesc = json['task_desc'];
    priority = json['priority'];
    dueDate = json['due_date'];
    status = json['status'];
    completionTime = json['completion_time'];
    completionDate = json['completion_date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_name'] = taskName;
    data['task_desc'] = taskDesc;
    data['priority'] = priority;
    data['due_date'] = dueDate;
    data['status'] = status;
    data['completion_time'] = completionTime;
    data['completion_date'] = completionDate;
    return data;
  }
}
