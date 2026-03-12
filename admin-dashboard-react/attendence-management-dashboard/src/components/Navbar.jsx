import React, { useState, useRef, useEffect } from "react";

const Navbar = () => {
  const [open, setOpen] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const dropdownRef = useRef();

  useEffect(() => {
    const userEmail = localStorage.getItem("email");

    if (userEmail) {
      setEmail(userEmail);

      fetch(`http://localhost:8080/api/auth/me?email=${userEmail}`)
        .then((res) => res.json())
        .then((data) => {
          setName(data.firstName + " " + data.lastName);
          setEmail(data.email);
        })
        .catch((error) => console.error(error));
    }
  }, []);

  const handleLogout = async () => {
    await fetch("http://localhost:8080/api/auth/logout", {
      method: "POST",
    });

    localStorage.removeItem("token");
    localStorage.removeItem("email");

    window.location.href = "/signin";
  };

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
            <span className="text-gray-600 font-medium">{email}</span>
            <span className="text-gray-500">▼</span>
          </button>

          {open && (
            <div className="absolute right-0 mt-2 w-48 bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden z-50">
              <div className="px-4 py-3 border-b border-gray-100">
                <p className="text-gray-700 font-semibold">{name}</p>
                <p className="text-gray-400 text-sm">{email}</p>
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

      {showModal && (
        <div className="fixed inset-0 bg-black/60 flex items-center justify-center z-50">
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
                onClick={handleLogout}
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