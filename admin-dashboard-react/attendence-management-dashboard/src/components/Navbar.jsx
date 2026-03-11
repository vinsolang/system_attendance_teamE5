import React, { useState, useRef, useEffect } from "react";

const Navbar = () => {
  const [open, setOpen] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const dropdownRef = useRef();

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  return (
    <>
      <div className="fixed top-0 left-64 right-0 bg-white shadow-sm flex justify-between items-center px-8 py-4 z-40">
        <h1 className="text-xl font-semibold uppercase tracking-wider">
          Management
        </h1>

        <div className="relative" ref={dropdownRef}>
          <button
            onClick={() => setOpen(!open)}
            className="flex items-center gap-2 focus:outline-none"
          >
            <span className="text-gray-600 font-medium">Admin</span>
            <span className="text-gray-500">▼</span>
          </button>

          {/* Dropdown */}
          {open && (
            <div className="absolute right-0 mt-2 w-48 bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden z-50">
              <div className="px-4 py-3 border-b border-gray-100">
                <p className="text-gray-700 font-semibold">Admin Name</p>
                <p className="text-gray-400 text-sm">admin@example.com</p>
              </div>

              <button
                className="w-full text-left px-4 py-3 hover:bg-gray-100 text-red-500 font-semibold"
                onClick={() => setShowModal(true)}
              >
                Logout
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Logout Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black/60 bg-opacity-40 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-lg w-96 p-6">
            <h2 className="text-lg font-semibold mb-4">Confirm Logout</h2>
            <p className="text-gray-600 mb-6">
              Are you sure you want to logout?
            </p>

            <div className="flex justify-end gap-3">
              <button
                onClick={() => setShowModal(false)}
                className="px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100"
              >
                Cancel
              </button>

              <button
                onClick={() => {
                  alert("Logged out!");
                  setShowModal(false);
                }}
                className="px-4 py-2 rounded-lg bg-red-500 text-white hover:bg-red-600"
              >
                Logout
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default Navbar;