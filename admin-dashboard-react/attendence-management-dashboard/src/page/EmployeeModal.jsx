import React, { useState, useEffect } from "react";
import { Toaster, toast } from "sonner";

const EmployeeModal = ({ isOpen, onClose, employee, refreshEmployees }) => {
  const [form, setForm] = useState({
    fullName: "",
    employeeId: "",
    department: "Sales Department",
    position: "",
    joinDate: "",
    workStatus: "Active",
    email: "",
    role: "EMPLOYEE",
    password: "", // Keep empty unless creating/updating
  });

  const [profileImage, setProfileImage] = useState(null);
  const [preview, setPreview] = useState(null);

  useEffect(() => {
    if (employee && isOpen) {
      setForm({
        fullName: employee.fullName || "",
        employeeId: employee.employeeId || "",
        department: employee.department || "Sales Department",
        position: employee.position || "",
        joinDate: employee.joinDate || "",
        workStatus: employee.workStatus || "Active",
        email: employee.email || "", // Direct access: no more .user
        role: employee.role || "EMPLOYEE", // Direct access: no more .user
        password: "", // Usually don't show password on edit
      });
      setPreview(employee.profileImageUrl ? `http://localhost:8080/${employee.profileImageUrl}` : null);
      setProfileImage(null);
    } else {
      // Reset form for "New Talent"
      setForm({
        fullName: "",
        employeeId: "",
        department: "Sales Department",
        position: "",
        joinDate: "",
        workStatus: "Active",
        email: "",
        role: "EMPLOYEE",
        password: "",
      });
      setPreview(null);
      setProfileImage(null);
    }
  }, [employee, isOpen]);

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setProfileImage(file);
      setPreview(URL.createObjectURL(file));
    }
  };

  const handleSubmit = async (e) => {
  e.preventDefault();
  
  // Create FormData object
  const formData = new FormData();
  
  // Append fields manually to ensure they match the Backend naming
  formData.append("fullName", form.fullName);
  formData.append("email", form.email);
  formData.append("employeeId", form.employeeId);
  formData.append("department", form.department);
  formData.append("position", form.position);
  formData.append("workStatus", form.workStatus);
  formData.append("joinDate", form.joinDate);
  formData.append("role", form.role);

  // Append password only if it's a new employee or if changing it
  if (!employee && form.password) {
    formData.append("password", form.password);
  }

  // Append the image file if it exists
  if (profileImage) {
    formData.append("profileImage", profileImage);
  }

  try {
    const url = employee
      ? `http://localhost:8080/api/employees/${employee.id}`
      : "http://localhost:8080/api/employees/add";

    const method = employee ? "PUT" : "POST";

    const res = await fetch(url, {
      method: method,
      body: formData, // Browser automatically sets Content-Type to multipart/form-data
    });

    if (res.ok) {
      toast.success(employee ? "Profile Updated!" : "Employee Added!");
      refreshEmployees();
      onClose();
    } else {
      const errorMsg = await res.text();
      toast.error("Error: " + errorMsg);
    }
  } catch (err) {
    toast.error("Network error. Is the server running?");
  }
};

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-gray-900/60 backdrop-blur-sm" onClick={onClose}></div>

      <div className="relative bg-white w-full max-w-2xl rounded-[40px] shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
        {/* Header Section */}
        <div className="p-10 pb-6 flex justify-between items-center bg-gradient-to-b from-gray-50 to-white">
          <div>
            <h2 className="text-3xl font-black text-gray-900 tracking-tight">
              {employee ? "Edit Profile" : "New Talent"}
            </h2>
            <div className="flex items-center gap-2 mt-1">
              <span className="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
              <p className="text-[10px] text-gray-400 font-bold uppercase tracking-[0.2em]">
                Human Resources Management
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="w-12 h-12 flex items-center justify-center rounded-2xl bg-gray-50 text-gray-400 hover:text-red-500 hover:bg-red-50 transition-all duration-300 group"
          >
            <i className="fas fa-times text-lg group-hover:rotate-90 transition-transform"></i>
          </button>
        </div>

        <form onSubmit={handleSubmit} className="px-10 pb-10 space-y-8 max-h-[80vh] overflow-y-auto">
          {/* Avatar Upload */}
          <div className="flex flex-col items-center">
            <div className="relative group">
              <div className="w-32 h-32 rounded-[35%] overflow-hidden bg-gray-50 border-[6px] border-gray-50 shadow-inner flex items-center justify-center transition-transform duration-500 group-hover:scale-105">
                {preview ? (
                  <img src={preview} alt="preview" className="w-full h-full object-cover" />
                ) : (
                  <i className="fas fa-user-astronaut text-4xl text-gray-200"></i>
                )}
              </div>
              <label className="absolute -bottom-2 -right-2 cursor-pointer bg-gray-900 text-white w-10 h-10 rounded-2xl flex items-center justify-center hover:bg-emerald-600 shadow-xl transition-all duration-300 border-4 border-white">
                <i className="fas fa-camera text-sm"></i>
                <input type="file" accept="image/*" onChange={handleImageChange} className="hidden" />
              </label>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-5">
            {/* Full Name */}
            <div className="relative group">
              <i className="fas fa-user absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-gray-900 transition-colors"></i>
              <input
                type="text"
                placeholder="Full Name"
                value={form.fullName}
                onChange={(e) => setForm({ ...form, fullName: e.target.value })}
                className="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-900 outline-none text-sm font-semibold text-gray-800"
                required
              />
            </div>

            {/* Email */}
            <div className="relative group">
              <i className="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-gray-900 transition-colors"></i>
              <input
                type="email"
                placeholder="Email Address"
                value={form.email}
                onChange={(e) => setForm({ ...form, email: e.target.value })}
                className="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-900 outline-none text-sm font-semibold text-gray-800"
                required
              />
            </div>

            {/* Password - Only required for new users */}
            {!employee && (
              <div className="relative group col-span-2">
                <i className="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-gray-900 transition-colors"></i>
                <input
                  type="password"
                  placeholder="Set Password"
                  value={form.password}
                  onChange={(e) => setForm({ ...form, password: e.target.value })}
                  className="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-900 outline-none text-sm font-semibold text-gray-800"
                  required={!employee}
                />
              </div>
            )}

            {/* Employee ID */}
            <div className="relative group">
              <i className="fas fa-id-card absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-gray-900 transition-colors"></i>
              <input
                type="text"
                placeholder="Employee ID"
                value={form.employeeId}
                onChange={(e) => setForm({ ...form, employeeId: e.target.value })}
                className="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-900 outline-none text-sm font-semibold text-gray-800"
                required
              />
            </div>

            {/* Position */}
            <div className="relative group">
              <i className="fas fa-briefcase absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-gray-900 transition-colors"></i>
              <input
                type="text"
                placeholder="Position Title"
                value={form.position}
                onChange={(e) => setForm({ ...form, position: e.target.value })}
                className="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-900 outline-none text-sm font-semibold text-gray-800"
                required
              />
            </div>

            {/* Role & Department Dropdowns */}
            <div className="relative">
              <select
                value={form.role}
                onChange={(e) => setForm({ ...form, role: e.target.value })}
                className="w-full px-5 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-800 outline-none text-sm font-medium text-gray-700 appearance-none cursor-pointer"
              >
                <option value="EMPLOYEE">Standard Employee</option>
                <option value="ADMIN">System Admin</option>
              </select>
              <i className="fas fa-chevron-down absolute right-5 top-1/2 -translate-y-1/2 text-gray-300 pointer-events-none"></i>
            </div>

            <div className="relative">
              <select
                value={form.department}
                onChange={(e) => setForm({ ...form, department: e.target.value })}
                className="w-full px-5 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-800 outline-none text-sm font-medium text-gray-700 appearance-none cursor-pointer"
              >
                <option>Sales Department</option>
                <option>IT & Development</option>
                <option>Marketing</option>
                <option>Human Resources</option>
              </select>
              <i className="fas fa-chevron-down absolute right-5 top-1/2 -translate-y-1/2 text-gray-300 pointer-events-none"></i>
            </div>

            <input
              type="date"
              value={form.joinDate}
              onChange={(e) => setForm({ ...form, joinDate: e.target.value })}
              className="w-full px-5 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-800 outline-none text-sm font-medium text-gray-700"
            />

            <div className="relative">
              <select
                value={form.workStatus}
                onChange={(e) => setForm({ ...form, workStatus: e.target.value })}
                className="w-full px-5 py-4 bg-gray-50 border-2 border-transparent rounded-2xl focus:bg-white focus:border-gray-800 outline-none text-sm font-medium text-gray-700 appearance-none"
              >
                <option>Active</option>
                <option>Probation</option>
                <option>Contract</option>
              </select>
              <i className="fas fa-chevron-down absolute right-5 top-1/2 -translate-y-1/2 text-gray-300 pointer-events-none"></i>
            </div>
          </div>

          {/* Actions */}
          <div className="flex items-center gap-4 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="px-8 py-4 text-sm font-bold text-gray-400 hover:text-gray-800 transition-colors"
            >
              Discard
            </button>
            <button
              type="submit"
              className="flex-1 bg-gray-900 text-white font-bold py-4 rounded-[20px] hover:bg-black shadow-xl transition-all transform active:scale-[0.98]"
            >
              {employee ? "Update Records" : "Confirm Registration"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default EmployeeModal;