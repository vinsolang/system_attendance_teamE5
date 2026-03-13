import React, { useState, useEffect  } from 'react';
import EmployeeModal from './EmployeeModal';
import { Toaster, toast } from "sonner";
import Swal from "sweetalert2";

const Employee = () => {
  const [isModalOpen, setModalOpen] = useState(false);
  const [employees, setEmployees] = useState([]);
  const [editingEmployee, setEditingEmployee] = useState(null);

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
        text: "Do you when to delete employee this?",
        showCancelButton: true,
        confirmButtonColor: "#e8000c",
        cancelButtonColor: "#5682e8",
        confirmButtonText: "Yes, delete"
      });

      if (!result.isConfirmed) return;

      const res = await fetch(`http://localhost:8080/api/employees/${id}`, {
        method: "DELETE",
      });

      if (res.ok) {
        toast.success("Employee deleted successfully");
        fetchEmployees();
      } else {
        toast.error("Failed to delete employee");
      }
    };

  // Calculate the Stats
  // 1. Total Staff: Simply the length of the array
  const totalStaff = employees.length;

  // 2. Departments: Create a Set of unique department names and get the size
  const totalDepartments = new Set(employees.map(emp => emp.department)).size;

  // 3. Active Now: Filter employees with 'Active' status
  const activeStaff = employees.filter(emp => emp.workStatus === 'Active').length;

  // 4. New Hires: Assuming "New Hires" are those joined in the last 30 days
  // Or, if you prefer, filter by a specific status like 'Probation'
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
          <p className="text-sm text-gray-500 font-medium">Manage your workforce of 200 employees</p>
        </div>
        
        <div className="flex items-center gap-3 w-full md:w-auto">
          <div className="relative flex-grow">
            <span className="absolute inset-y-0 left-0 flex items-center pl-4 text-gray-400">
              <i className="fas fa-search text-xs"></i>
            </span>
            <input 
              type="text" 
              placeholder="Search by name, ID, or dept..." 
              className="w-full md:w-80 bg-white/60 backdrop-blur-sm border-none rounded-2xl pl-10 pr-4 py-3 text-sm focus:ring-2 focus:ring-gray-300 transition-all"
            />
          </div>
          <button 
            onClick={() => {
              setEditingEmployee(null); // Ensure we aren't in edit mode
              setModalOpen(true);       // Open the modal
            }}
            className="cursor-pointer bg-gray-800 text-white p-3 px-6 rounded-2xl flex items-center gap-2 hover:bg-black shadow-lg shadow-gray-400/40 transition-all">
            <span className="text-lg font-light">+</span>
            <span className="text-sm font-bold">
              {editingEmployee ? "Update Employee" : "Add New Employee"}
            </span>
          </button>
        </div>
        {/* Render the Modal */}
      <EmployeeModal
        isOpen={isModalOpen}
        onClose={() => {
          setModalOpen(false);
          setEditingEmployee(null);
        }}
        employee={editingEmployee}
        refreshEmployees={fetchEmployees}
      />
      </div>

      {/* Stats Overview */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-white/40 border border-white/60 p-4 rounded-3xl flex flex-col items-center">
          <span className="text-2xl font-black text-gray-800">{totalStaff}</span>
          <span className="text-[10px] uppercase font-bold text-gray-500 tracking-widest">Total Staff</span>
        </div>
        
        <div className="bg-white/40 border border-white/60 p-4 rounded-3xl flex flex-col items-center">
          <span className="text-2xl font-black text-gray-800">{totalDepartments}</span>
          <span className="text-[10px] uppercase font-bold text-gray-500 tracking-widest">Departments</span>
        </div>
        
        <div className="bg-white/40 border border-white/60 p-4 rounded-3xl flex flex-col items-center">
          <span className="text-2xl font-black text-green-600">{activeStaff}</span>
          <span className="text-[10px] uppercase font-bold text-gray-500 tracking-widest">Active Now</span>
        </div>
        
        <div className="bg-white/40 border border-white/60 p-4 rounded-3xl flex flex-col items-center">
          <span className="text-2xl font-black text-blue-600">{newHires}</span>
          <span className="text-[10px] uppercase font-bold text-gray-500 tracking-widest">New Hires</span>
        </div>
      </div>

      {/* Employee Grid/Table */}
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
              {employees.map((emp) => (
                <tr key={emp.id} className="group hover:bg-gray-50/80 transition-all duration-300">
                  <td className="px-8 py-5">
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-gray-100 to-gray-200 border border-white shadow-sm flex items-center justify-center text-gray-400 font-bold group-hover:scale-105 transition-transform">
                       {emp.profileImageUrl ? (
                          <img
                            src={`http://localhost:8080/${emp.profileImageUrl}`}
                            alt={emp.fullName}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <span className="text-lg uppercase">{emp.fullName.charAt(0)}</span>
                        )}
                      </div>
                      <div>
                        <p className="text-sm font-bold text-gray-800">{emp.fullName}</p>
                        <p className="text-[10px] text-gray-400 font-medium tracking-wide">ID: {emp.employeeId} • Joined {emp.joinDate}</p>
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
                      <div className={`w-1.5 h-1.5 rounded-full ${emp.workStatus   === 'Active' ? 'bg-green-500' : 'bg-orange-400'}`}></div>
                      <span className="text-[11px] font-bold text-gray-700">{emp.workStatus }</span>
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
        </div>
        
        {/* Pagination Placeholder */}
        <div className="p-6 bg-gray-50/30 flex justify-between items-center border-t border-gray-50">
          <span className="text-[10px] text-gray-400 font-bold uppercase tracking-wider">Showing 1 to 4 of 200</span>
          <div className="flex gap-2">
            <button className="w-8 h-8 rounded-lg bg-white border border-gray-200 text-gray-400 hover:bg-gray-800 hover:text-white transition-all text-xs font-bold">1</button>
            <button className="w-8 h-8 rounded-lg bg-white border border-gray-200 text-gray-400 hover:bg-gray-800 hover:text-white transition-all text-xs font-bold">2</button>
            <button className="w-8 h-8 rounded-lg bg-white border border-gray-200 text-gray-400 hover:bg-gray-800 hover:text-white transition-all text-xs font-bold">3</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Employee;