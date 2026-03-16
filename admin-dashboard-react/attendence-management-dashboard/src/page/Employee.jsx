import React, { useState, useEffect } from 'react';
import EmployeeModal from './EmployeeModal';
import { Toaster, toast } from "sonner";
import Swal from "sweetalert2";

const Employee = () => {
  const [isModalOpen, setModalOpen] = useState(false);
  const [employees, setEmployees] = useState([]);
  const [editingEmployee, setEditingEmployee] = useState(null);
  const [searchQuery, setSearchQuery] = useState("");

  const fetchEmployees = async () => {
    try {
      const res = await fetch("http://localhost:8080/api/employees");
      const data = await res.json();
      setEmployees(data);
    } catch (err) {
      console.error("Failed to load employees", err);
    }
  };

  useEffect(() => {
    fetchEmployees();
  }, []);

  const handleDelete = async (id) => {
    const result = await Swal.fire({
      text: "Are you sure you want to delete this employee?",
      showCancelButton: true,
      confirmButtonColor: "#e8000c",
      cancelButtonColor: "#5682e8",
      confirmButtonText: "Yes, delete"
    });

    if (!result.isConfirmed) return;

    try {
      const res = await fetch(`http://localhost:8080/api/employees/${id}`, {
        method: "DELETE",
      });

      if (res.ok) {
        toast.success("Employee deleted successfully");
        fetchEmployees();
      } else {
        toast.error("Failed to delete employee");
      }
    } catch (err) {
      toast.error("Network error");
    }
  };

  // Filtered Employees for Search
  const filteredEmployees = employees.filter(emp => 
    emp.fullName?.toLowerCase().includes(searchQuery.toLowerCase()) ||
    emp.employeeId?.toLowerCase().includes(searchQuery.toLowerCase()) ||
    emp.department?.toLowerCase().includes(searchQuery.toLowerCase())
  );

  // Stats Calculations
  const totalStaff = employees.length;
  const totalDepartments = new Set(employees.map(emp => emp.department)).size;
  const activeStaff = employees.filter(emp => emp.workStatus === 'Active').length;
  const newHires = employees.filter(emp => {
    const joinDate = new Date(emp.joinDate);
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    return joinDate > thirtyDaysAgo;
  }).length;

  return (
    <div className="p-8 bg-[#D1D5DB] min-h-screen rounded-tl-[40px] space-y-8">
      <Toaster position="top-right" />
      
      {/* Top Action Bar */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800 tracking-tight">Employee Directory</h1>
          <p className="text-sm text-gray-500 font-medium">Managing {totalStaff} team members</p>
        </div>
        
        <div className="flex items-center gap-3 w-full md:w-auto">
          <div className="relative flex-grow">
            <span className="absolute inset-y-0 left-0 flex items-center pl-4 text-gray-400">
              <i className="fas fa-search text-xs"></i>
            </span>
            <input 
              type="text" 
              placeholder="Search by name, ID, or dept..." 
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full md:w-80 bg-white/60 backdrop-blur-sm border-none rounded-2xl pl-10 pr-4 py-3 text-sm focus:ring-2 focus:ring-gray-300 transition-all outline-none"
            />
          </div>
          <button 
            onClick={() => {
              setEditingEmployee(null);
              setModalOpen(true);
            }}
            className="cursor-pointer bg-gray-800 text-white p-3 px-6 rounded-2xl flex items-center gap-2 hover:bg-black shadow-lg shadow-gray-400/40 transition-all">
            <span className="text-lg font-light">+</span>
            <span className="text-sm font-bold">Add Employee</span>
          </button>
        </div>
      </div>

      <EmployeeModal
        isOpen={isModalOpen}
        onClose={() => {
          setModalOpen(false);
          setEditingEmployee(null);
        }}
        employee={editingEmployee}
        refreshEmployees={fetchEmployees}
      />

      {/* Stats Overview */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Total Staff", val: totalStaff, color: "text-gray-800" },
          { label: "Departments", val: totalDepartments, color: "text-gray-800" },
          { label: "Active Now", val: activeStaff, color: "text-green-600" },
          { label: "New Hires", val: newHires, color: "text-blue-600" },
        ].map((stat, i) => (
          <div key={i} className="bg-white/40 border border-white/60 p-4 rounded-3xl flex flex-col items-center">
            <span className={`text-2xl font-black ${stat.color}`}>{stat.val}</span>
            <span className="text-[10px] uppercase font-bold text-gray-500 tracking-widest">{stat.label}</span>
          </div>
        ))}
      </div>

      {/* Employee Table */}
      <div className="bg-white rounded-[40px] shadow-sm overflow-hidden border border-gray-100">
        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead className="bg-gray-50 text-gray-400 text-[10px] uppercase tracking-[0.2em] font-bold">
              <tr>
                <th className="px-8 py-5">Employee Info</th>
                <th className="px-8 py-5">Department</th>
                <th className="px-8 py-5">Position</th>
                <th className="px-8 py-5">Status</th>
                <th className="px-8 py-5 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {filteredEmployees.map((emp) => (
                <tr key={emp.id} className="group hover:bg-gray-50/80 transition-all duration-300">
                  <td className="px-8 py-5">
                    <div className="flex items-center gap-4">
                      {/* Profile Image or Initials */}
                      <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-gray-100 to-gray-200 border border-white shadow-sm flex items-center justify-center text-gray-400 font-bold group-hover:scale-105 transition-transform overflow-hidden">
                       {emp.profileImageUrl ? (
                          <img
                            src={`http://localhost:8080/${emp.profileImageUrl}?t=${new Date().getTime()}`}
                            alt={emp.fullName}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <span className="text-sm uppercase">
                            {emp.fullName?.split(" ").map(n => n[0]).join("").substring(0, 2)}
                          </span>
                        )}
                      </div>
                      
                      <div className="flex flex-col">
                        <p className="text-sm font-bold text-gray-800">{emp.fullName}</p>
                        <p className="text-[10px] text-gray-400">{emp.email}</p>
                        <p className="text-[10px] text-indigo-500 font-semibold uppercase tracking-tighter">
                          {emp.role}
                        </p>
                        <p className="text-[10px] text-gray-400">ID: {emp.employeeId} • Joined {emp.joinDate}</p>
                      </div>
                    </div>
                  </td>
                  
                  <td className="px-8 py-5">
                    <span className="text-xs font-semibold text-gray-600 px-3 py-1 bg-gray-100 rounded-lg">{emp.department}</span>
                  </td>
                  
                  <td className="px-8 py-5 text-sm text-gray-500 font-medium">
                    {emp.position}
                  </td>
                  
                  <td className="px-8 py-5">
                    <div className="flex items-center gap-2">
                      <div className={`w-1.5 h-1.5 rounded-full ${emp.workStatus === 'Active' ? 'bg-green-500' : 'bg-orange-400'}`}></div>
                      <span className="text-[11px] font-bold text-gray-700">{emp.workStatus}</span>
                    </div>
                  </td>
                  
                  <td className="px-8 py-5 text-right">
                    <div className="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                      <button 
                        onClick={() => {
                          setEditingEmployee(emp);
                          setModalOpen(true);
                        }}
                        className="p-2 text-gray-400 hover:text-blue-500 hover:bg-white rounded-lg transition-all shadow-sm">
                        <i className="fas fa-edit text-xs"></i>
                      </button>
                      <button 
                        onClick={() => handleDelete(emp.id)}
                        className="p-2 text-gray-400 hover:text-red-500 hover:bg-white rounded-lg transition-all shadow-sm">
                        <i className="fas fa-trash text-xs"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {filteredEmployees.length === 0 && (
            <div className="p-20 text-center text-gray-400 text-sm font-medium">
              No employees found matching your search.
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Employee;