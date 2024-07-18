import 'package:flutter/material.dart';




class WipTasksScreen extends StatefulWidget {
  @override
  _WipTasksScreenState createState() => _WipTasksScreenState();
}

class _WipTasksScreenState extends State<WipTasksScreen> {
  int _currentIndex = 0;
  Task? _selectedTask;

  final List<Task> _tasks = [
    Task('Task 1', 'Task 1 description', 'In Progress', 'User 1', '2024-07-10'),
    Task('Task 2', 'Task 2 description', 'Pending', 'User 2', '2024-07-11'),
    // Add more tasks here
  ];

  void _onTaskSelected(Task task) {
    setState(() {
      _selectedTask = task;
      _currentIndex = 1;
    });
  }

  void _onAddTask() {
    setState(() {
      _selectedTask = null;
      _currentIndex = 2;
    });
  }

  void _onSaveTask(Task task) {
    setState(() {
      if (_selectedTask != null) {
        // Update existing task
        int index = _tasks.indexOf(_selectedTask!);
        _tasks[index] = task;
      } else {
        // Add new task
        _tasks.add(task);
      }
      _currentIndex = 0;
    });
  }

  void _onCancel() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WIP Tasks'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildTaskList(),
          _buildTaskDetail(_selectedTask!),
          _buildTaskForm(_selectedTask),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: _onAddTask,
        child: Icon(Icons.add),
      )
          : null,
    );
  }

  Widget _buildTaskList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search tasks',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(_tasks[index].title),
                  subtitle: Text(_tasks[index].description),
                  trailing: Icon(Icons.more_vert),
                  onTap: () => _onTaskSelected(_tasks[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDetail(Task task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8.0),
          Text(task.description),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(task.status),
                backgroundColor: Colors.blue,
              ),
              Text('Assigned to: ${task.assignedUser}'),
            ],
          ),
          SizedBox(height: 8.0),
          Text('Deadline: ${task.deadline}'),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Comment 1'),
                  subtitle: Text('Comment details'),
                ),
                ListTile(
                  title: Text('Comment 2'),
                  subtitle: Text('Comment details'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _onCancel,
                child: Text('Back'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Edit Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskForm(Task? task) {
    final _titleController = TextEditingController(text: task?.title);
    final _descriptionController = TextEditingController(text: task?.description);
    final _statusController = TextEditingController(text: task?.status);
    final _userController = TextEditingController(text: task?.assignedUser);
    final _deadlineController = TextEditingController(text: task?.deadline);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _statusController,
            decoration: InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _userController,
            decoration: InputDecoration(
              labelText: 'Assigned to',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _deadlineController,
            decoration: InputDecoration(
              labelText: 'Deadline',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Task newTask = Task(
                    _titleController.text,
                    _descriptionController.text,
                    _statusController.text,
                    _userController.text,
                    _deadlineController.text,
                  );
                  _onSaveTask(newTask);
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: _onCancel,
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final String status;
  final String assignedUser;
  final String deadline;

  Task(this.title, this.description, this.status, this.assignedUser, this.deadline);
}
