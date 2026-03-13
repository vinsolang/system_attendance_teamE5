import React, { useState, useEffect } from "react";
import { Toaster, toast } from "sonner";


const EmployeeModal = ({ isOpen, onClose, employee, refreshEmployees }) => {
  const [profileImage, setProfileImage] = useState(null);
  const [preview, setPreview] = useState(null);

  // Form fields
  const [fullName, setFullName] = useState("");
  const [employeeId, setEmployeeId] = useState("");
  const [department, setDepartment] = useState("Sales Department");
  const [position, setPosition] = useState("");
  const [joinDate, setJoinDate] = useState("");
  const [workStatus, setWorkStatus] = useState("Active");

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setProfileImage(file);
      setPreview(URL.createObjectURL(file));
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    // Ensure names match your Backend @RequestParam or DTO names exactly
    formData.append("fullName", fullName);
    formData.append("employeeId", employeeId);
    formData.append("department", department);
    formData.append("position", position);
    formData.append("joinDate", joinDate);
    formData.append("workStatus", workStatus);
    
    // Only append the image if a NEW one was selected
    if (profileImage) {
      formData.append("image", profileImage);
    }

    try {
      const url = employee
        ? `http://localhost:8080/api/employees/${employee.id}`
        : "http://localhost:8080/api/employees/add";

      // If PUT doesn't work, try changing this to POST just to test
      const method = employee ? "PUT" : "POST"; 

      const res = await fetch(url, {
        method: method,
        body: formData, // Browser sets Content-Type automatically
      });

      if (res.ok) {

      toast.success(
        employee ? "Updated Successfully!" : "Added Successfully!"
      );

      refreshEmployees();
      onClose();

    } else {
      const errorData = await res.text();

      toast.error("Failed to save: " + errorData);
    }
    } catch (err) {
      console.error("Fetch Error:", err);
    }
  };

  // CORRECT: Move this BEFORE the "if (!isOpen)" return
  useEffect(() => {
    if (employee) {
      setFullName(employee.fullName);
      setEmployeeId(employee.employeeId);
      setDepartment(employee.department);
      setPosition(employee.position);
      setJoinDate(employee.joinDate);
      setWorkStatus(employee.workStatus);
    } else {
      setFullName("");
      setEmployeeId("");
      setDepartment("Sales Department");
      setPosition("");
      setJoinDate("");
      setWorkStatus("Active");
      setPreview(null);
      setProfileImage(null);
    }
  }, [employee, isOpen]); // Added isOpen as a dependency to reset when opening/closing

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      <Toaster position="top-right" />
      {/* Backdrop */}
      <div
        className="absolute inset-0 bg-gray-900/40 backdrop-blur-md transition-opacity"
        onClick={onClose}
      ></div>

      {/* Modal */}
      <div className="relative bg-white w-full max-w-2xl rounded-[40px] shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
        {/* Header */}
        <div className="p-8 pb-4 flex justify-between items-center">
          <div>
            <h2 className="text-2xl font-black text-gray-800 tracking-tight">
              Add New Employee
            </h2>
            <p className="text-xs text-gray-400 font-bold uppercase tracking-widest mt-1">
              Personnel Registration
            </p>
          </div>
          <button
            onClick={onClose}
            className="w-10 h-10 flex items-center justify-center rounded-2xl hover:bg-gray-100 text-gray-400 hover:text-gray-800 transition-all"
          >
            <i className="fas fa-times"></i>
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-8 pt-4 space-y-6">
          {/* Profile Upload */}
          <div className="flex flex-col items-center mb-6">
           <div className="w-28 h-28 rounded-full overflow-hidden bg-gray-100 border-4 border-white shadow-lg">
              {preview ? (
                // Priority 1: New upload preview
                <img src={preview} alt="preview" className="w-full h-full object-cover" />
              ) : employee && employee.profileImageUrl ? (
                // Priority 2: Existing image from server
                <img 
                  src={`http://localhost:8080/${employee.profileImageUrl}`} 
                  alt="existing" 
                  className="w-full h-full object-cover" 
                />
              ) : (
                // Priority 3: Default icon
                <div className="w-full h-full flex items-center justify-center text-gray-400">
                  <i className="fas fa-user text-2xl"></i>
                </div>
              )}
            </div>

            <label className="mt-4 cursor-pointer bg-gray-800 text-white text-xs font-bold px-5 py-2 rounded-xl hover:bg-black transition-all">
              Upload Profile
              <input
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className="hidden"
              />
            </label>
          </div>

          {/* Form Fields */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Full Name
              </label>
              <input
                type="text"
                placeholder="e.g. Sreyna Paul"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Employee ID
              </label>
              <input
                type="text"
                placeholder="e.g. EMP-099"
                value={employeeId}
                onChange={(e) => setEmployeeId(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Department
              </label>
              <select
                value={department}
                onChange={(e) => setDepartment(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 appearance-none"
              >
                <option>Sales Department</option>
                <option>IT & Development</option>
                <option>Marketing</option>
                <option>Human Resources</option>
              </select>
            </div>

            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Position
              </label>
              <input
                type="text"
                placeholder="e.g. Senior Manager"
                value={position}
                onChange={(e) => setPosition(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Join Date
              </label>
              <input
                type="date"
                value={joinDate}
                onChange={(e) => setJoinDate(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">
                Work Status
              </label>
              <select
                value={workStatus}
                onChange={(e) => setWorkStatus(e.target.value)}
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200"
              >
                <option>Active</option>
                <option>Probation</option>
                <option>Contract</option>
              </select>
            </div>
          </div>

          {/* Buttons */}
          <div className="flex gap-4 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 bg-gray-100 text-gray-500 font-bold py-4 rounded-2xl hover:bg-gray-200 transition-all"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="flex-[2] bg-gray-800 text-white font-bold py-4 rounded-2xl hover:bg-black shadow-lg shadow-gray-300 transition-all"
            >
              {employee ? "Update Employee" : "Save Employee"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default EmployeeModal;