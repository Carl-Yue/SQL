set wrap off
set linesize 500
set pagesize 30
COLUMN CONSTRAINT_NAME FORMAT a35;
COLUMN COLUMN_NAME FORMAT a25;
COLUM TABLE_NAME FORMAT a20;
COLUMN constraint_type FORMAT a10;
COLUMN search_condition FORMAT a45;

CREATE TABLE tblCourse
(
    CourseID Number(38) PRIMARY KEY,
    CourseCode Char(6) NOT NULL UNIQUE,
    CONSTRAINT tblCourse_CourseID_ck CHECK(CourseID > 0)
);

CREATE TABLE tblStudent
(
    StudentID Number(38) PRIMARY KEY,
    StudentNumber Char(11) NOT NULL UNIQUE,
    StudentFname Char(20),
    StudentLname Char(20) NOT NULL,
    CONSTRAINT tblStudent_StudentID_ck CHECK (StudentID > 0)
);

CREATE TABLE tblInstructor
(
    InstructorID Number(38) PRIMARY KEY,
    InstructorNumber Char(15) NOT NULL UNIQUE,
    InstructorFname Char(25),
    InstructorLname Char(25),
    CONSTRAINT tblInstructor_InstructorID_ck CHECK (InstructorID > 0)
);

CREATE TABLE tblSemester
(
    SemesterID Number(38) PRIMARY KEY,
    SemesterCode Char(11) NOT NULL UNIQUE,
    SemesterYear Number(4) NOT NULL UNIQUE,
    SemesterSeason Char(6) NOT NULL,
    CONSTRAINT tblCourse_SemesterID_ck CHECK (SemesterID > 0),
    CONSTRAINT tblCourse_SemesterYear_ck CHECK (SemesterYear > 2000),
    CONSTRAINT tblCourse_SemesterSeason_ck CHECK (SemesterSeason IN ('Fall','Winter','Summer'))
);

CREATE TABLE tblCourseDetail
(
    CourseID Number(38),
    StudentID Number(38),
    SemesterID Number(38),
    InstructorID Number(38),
    CourseGrade Char(2) NOT NULL,
    CourseFinalGrade Number(5,2) NOT NULL,
    PRIMARY KEY (CourseID, StudentID, SemesterID),
    CONSTRAINT tblCourse_fk FOREIGN KEY (CourseID) REFERENCES tblCourse(CourseID),
    CONSTRAINT tblStudent_fk FOREIGN KEY (StudentID) REFERENCES tblStudent(StudentID),
    CONSTRAINT tblSemester_fk FOREIGN KEY (SemesterID) REFERENCES tblSemester(SemesterID),
    CONSTRAINT tblInstructor_fk FOREIGN KEY (InstructorID) REFERENCES tblInstructor(InstructorID),
    CONSTRAINT CourseGrade_ck CHECK (CourseGrade IN ('F','D','D+','C','C+','B','B+','A','A+')),
    CONSTRAINT CourseFinalGrade_ck CHECK (CourseFinalGrade BETWEEN 0 AND 100)
);

ALTER TABLE tblCourse ADD CourseDesc CHAR(35) NOT NULL;
ALTER TABLE tblSemester DROP UNIQUE (SemesterYear);
ALTER TABLE tblCourseDetail RENAME COLUMN CourseGrade TO CourseLetterGrade;
ALTER TABLE tblStudent MODIFY 
(
    StudentFname Char(25), 
    StudentLname Char(25)
);