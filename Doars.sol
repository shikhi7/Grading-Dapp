pragma solidity ^0.4.0;

contract Doars{
    
    string courseID;
    address chairperson;
    address instructor;
    address[] students;
    mapping(address => string) studGrades;
    uint nextStudId = 0;
    
    function Doars(uint _numStud, string _courseID) public {
        chairperson=msg.sender;
        students.length=_numStud;
        courseID=_courseID;
    }
    
    function setInstructor(address instrAddr) public {
        require(msg.sender==chairperson);
        instructor=instrAddr;
    }
    
    function getInstrAddr() public returns (address) {
        return instructor;
    }
    
    function getnextStudId() public returns (uint) {
        return nextStudId;
    }
    
    function enrollStud(address studAddr) public {
        require(msg.sender==instructor && nextStudId<((students.length)));
        bool flag=true;
        for(uint i = 0; i<nextStudId; i++){
            if(students[i]==studAddr){
                flag=false;
            }
        }
        require(flag);
        students[nextStudId]=studAddr;
        nextStudId+=1;
    }
    
    function getStudId(address studAddr) public returns (uint) {
        for(uint i = 0; i<nextStudId; i++){
            if(students[i]==studAddr){
                return i;
            }
        }
        return students.length;
    }
    
    function awardGrade(address studAddr, string grade) public {
        require(msg.sender==instructor);
        require(keccak256(studGrades[studAddr])==keccak256(""));
        studGrades[studAddr]=grade;
    }
    
    function viewGrade(address studAddr) public returns (string) {
        require(msg.sender==instructor || msg.sender==studAddr);
        return studGrades[studAddr];
    }
    
    function changeGrade(address studAddr, string grade) public {
        require(msg.sender==chairperson);
        studGrades[studAddr]=grade;
    }
    
    function statistics(string grade) public returns (uint){
        uint count =0;
        address tempAdd;
        for(uint i = 0; i<nextStudId; i++){
            tempAdd = students[i];
            if (keccak256(studGrades[tempAdd])==keccak256(grade)){
                count++;
            }
        }
        return (count*100)/(students.length);
    }
}
