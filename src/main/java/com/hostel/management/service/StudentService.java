package com.nishantwrp.institutemanagement.service;

import com.nishantwrp.institutemanagement.model.Student;
import com.nishantwrp.institutemanagement.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {
    @Autowired
    private StudentRepository studentRepository;



    public Student getStudentByRollNo(String rollNo) {
        Student student = studentRepository.getByRollNo(rollNo);
        return student;
    }

    public void deleteStudent(Student student) {
        studentRepository.delete(student.getRollNo());
    }

    public void updateStudent(Student student) {
        studentRepository.update(student);
    }
}
