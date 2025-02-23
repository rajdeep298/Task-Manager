<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Task Manager</title>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e1e2e, #23232e);
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 80%;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        h1 {
            text-align: center;
            color: #fff;
        }

        form {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        input[type="text"], input[type="date"] {
            flex: 1;
            padding: 12px;
            margin-right: 10px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: #fff;
            border-radius: 10px;
            outline: none;
        }

        button {
            padding: 12px 20px;
            background: linear-gradient(135deg, #ff8a00, #e52e71);
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(135deg, #e52e71, #ff8a00);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        th {
            background: rgba(255, 255, 255, 0.2);
        }

        a {
            color: #ff8a00;
            text-decoration: none;
            transition: 0.3s;
        }

        a:hover {
            color: #e52e71;
            text-decoration: none;
        }
        .edit-btn {
            background: #bb86fc;
            color: white;
        }
        .edit-btn:hover {
            background: #9a67ea;
        }
        .delete-btn {
            background: #cf6679;
            color: white;
        }
        .delete-btn:hover {
            background: #b00020;
        }
        .edit-form-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Task Manager</h1>
        <form action="/tasks" method="post">
            <input type="text" name="title" placeholder="Title" required>
            <input type="text" name="description" placeholder="Description">
            <input type="date" name="dueDate" required>
            <button type="submit">Add Task</button>
        </form>
        <table>
            <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="task" items="${tasks}">
                <tr>
                    <td>${task.title}</td>
                    <td>${task.description}</td>
                    <td>${task.dueDate}</td>
                    <td>${task.completed ? 'Completed' : 'Pending'}</td>
                    <td>
                        <button class="btn edit-btn" onclick="openEditForm('${task.id}', '${task.title}', '${task.description}', '${task.dueDate}')">Edit</button>
                        <button class="btn delete-btn"><a href="/tasks/delete/${task.id}" class="btn delete-btn">Delete</a></button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- Hidden Edit Form -->
    <div class="edit-form-container" id="editFormContainer">
        <h2>Edit Task</h2>
        <form id="editForm" action="/tasks/update" method="post">
            <input type="hidden" name="id" id="editTaskId">
            <input type="text" name="title" id="editTitle" placeholder="Title" required>
            <input type="text" name="description" id="editDescription" placeholder="Description">
            <input type="date" name="dueDate" id="editDueDate" required>
            <button type="submit">Update Task</button>
            <button type="button" onclick="closeEditForm()">Cancel</button>
        </form>
    </div>

    <script>
        function openEditForm(id, title, description, dueDate) {
            document.getElementById('editTaskId').value = id;
            document.getElementById('editTitle').value = title;
            document.getElementById('editDescription').value = description;
            document.getElementById('editDueDate').value = dueDate;
            document.getElementById('editFormContainer').style.display = 'block';
        }

        function closeEditForm() {
            document.getElementById('editFormContainer').style.display = 'none';
        }
    </script>
</body>
</html>
