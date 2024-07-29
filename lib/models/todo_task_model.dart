import 'package:flutter/material.dart';

class ToDoTaskModel {
  String? id;
  String? assignerId;
  String? assigneeId;
  String? projectId;
  String? sectionId;
  String? parentId;
  int? order;
  String? content;
  String? description;
  bool? isCompleted;
  List<String>? labels;
  int? priority;
  String? priorityLevel;
  Color? priorityColor;
  int? commentCount;
  String? creatorId;
  String? createdAt;
  Due? due;
  String? url;
  String? duration;

  ToDoTaskModel(
      {this.id,
        this.assignerId,
        this.assigneeId,
        this.projectId,
        this.sectionId,
        this.parentId,
        this.order,
        this.content,
        this.description,
        this.isCompleted,
        this.labels,
        this.priority,
        this.commentCount,
        this.creatorId,
        this.createdAt,
        this.due,
        this.url,
        this.priorityLevel,
        this.priorityColor,
        this.duration});

  ToDoTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignerId = json['assigner_id'];
    assigneeId = json['assignee_id'];
    projectId = json['project_id'];
    sectionId = json['section_id'];
    parentId = json['parent_id'];
    order = json['order'];
    content = json['content'];
    description = json['description'];
    isCompleted = json['is_completed'];
    priorityLevel = priorityLevel;
    priorityColor = priorityColor;
    // priorityLevel = json['is_completed'];
    // if (json['labels'] != null) {
    //   labels = <String>[];
    //   json['labels'].forEach((v) {
    //     labels!.add(new Label.fromJson(v));
    //   });
    // }
    priority = json['priority'];
    commentCount = json['comment_count'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    due = json['due'] != null ? new Due.fromJson(json['due']) : null;
    url = json['url'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assigner_id'] = this.assignerId;
    data['assignee_id'] = this.assigneeId;
    data['project_id'] = this.projectId;
    data['section_id'] = this.sectionId;
    data['parent_id'] = this.parentId;
    data['order'] = this.order;
    data['content'] = this.content;
    data['description'] = this.description;
    data['is_completed'] = this.isCompleted;
    // if (this.labels != null) {
    //   data['labels'] = this.labels!.map((v) => v.toJson()).toList();
    // }
    data['priority'] = this.priority;
    data['comment_count'] = this.commentCount;
    data['creator_id'] = this.creatorId;
    data['created_at'] = this.createdAt;
    if (this.due != null) {
      data['due'] = this.due!.toJson();
    }
    data['url'] = this.url;
    data['duration'] = this.duration;
    return data;
  }
}

class Due {
  String? date;
  String? string;
  String? lang;
  bool? isRecurring;

  Due({this.date, this.string, this.lang, this.isRecurring});

  Due.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    string = json['string'];
    lang = json['lang'];
    isRecurring = json['is_recurring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['string'] = this.string;
    data['lang'] = this.lang;
    data['is_recurring'] = this.isRecurring;
    return data;
  }
}