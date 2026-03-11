import React from 'react';

const EmployeeModal = ({ isOpen, onClose }) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      {/* Backdrop with Blur */}
      <div 
        className="absolute inset-0 bg-gray-900/40 backdrop-blur-md transition-opacity"
        onClick={onClose}
      ></div>

      {/* Modal Content */}
      <div className="relative bg-white w-full max-w-2xl rounded-[40px] shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
        
        {/* Modal Header */}
        <div className="p-8 pb-4 flex justify-between items-center">
          <div>
            <h2 className="text-2xl font-black text-gray-800 tracking-tight">Add New Employee</h2>
            <p className="text-xs text-gray-400 font-bold uppercase tracking-widest mt-1">Personnel Registration</p>
          </div>
          <button 
            onClick={onClose}
            className="w-10 h-10 flex items-center justify-center rounded-2xl hover:bg-gray-100 text-gray-400 hover:text-gray-800 transition-all"
          >
            <i className="fas fa-times"></i>
          </button>
        </div>

        {/* Form Body */}
        <form className="p-8 pt-4 space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            {/* Full Name */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Full Name</label>
              <input 
                type="text" 
                placeholder="e.g. Sreyna Paul"
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            {/* Employee ID */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Employee ID</label>
              <input 
                type="text" 
                placeholder="e.g. EMP-099"
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            {/* Department */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Department</label>
              <select className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 appearance-none">
                <option>Sales Department</option>
                <option>IT & Development</option>
                <option>Marketing</option>
                <option>Human Resources</option>
              </select>
            </div>

            {/* Role/Position */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Position</label>
              <input 
                type="text" 
                placeholder="e.g. Senior Manager"
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            {/* Join Date */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Join Date</label>
              <input 
                type="date" 
                className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all"
              />
            </div>

            {/* Status */}
            <div className="space-y-2">
              <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Work Status</label>
              <select className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200">
                <option>Active</option>
                <option>Probation</option>
                <option>Contract</option>
              </select>
            </div>
          </div>

          {/* Action Buttons */}
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
              Save Employee
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default EmployeeModal;