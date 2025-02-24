package com.example.taskmanager.Controller;

import com.example.taskmanager.model.Task;
import com.example.taskmanager.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tasks")
public class TaskController {
    @Autowired
    private TaskService taskService;

    @GetMapping
    public String getAllTasks(Model model) {
        model.addAttribute("tasks", taskService.getAllTasks());
        return "tasks";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        Task task = taskService.getTaskById(id);
        model.addAttribute("task", task);
        return "updateTask";
    }

    @PostMapping
    public String addTask(@ModelAttribute Task task) {
        taskService.addTask(task);
        return "redirect:/tasks";
    }

    @PostMapping("/update/{id}")
    public String updateTask(@PathVariable Long id, @ModelAttribute Task task) {
        taskService.updateTask(id, task);
        return "redirect:/tasks";
    }

    @GetMapping("/delete/{id}")
    public String deleteTask(@PathVariable Long id) {
        taskService.deleteTask(id);
        return "redirect:/tasks";
    }
}