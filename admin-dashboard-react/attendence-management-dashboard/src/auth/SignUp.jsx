import React, { useState } from 'react';

const SignUp = () => {

  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    role: 'ADMIN',
    password: ''
  });

  // Update input state
  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleRegister = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch('http://localhost:8080/api/employees/signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });

      const data = await response.text();

      if (response.ok) {
        alert(data);
        window.location.href = '/signin';
      } else {
        alert(data);
      }

    } catch (error) {
      console.error("Error:", error);
    }
  };

  return (
    <div className="min-h-screen bg-[#D1D5DB] flex items-center justify-center p-6">

      <div className="max-w-5xl w-full bg-white rounded-[50px] shadow-2xl overflow-hidden flex flex-col md:flex-row-reverse min-h-[700px]">

        {/* Left */}
        <div className="w-full md:w-1/2 bg-blue-600 p-12 flex flex-col justify-center items-center text-white text-center">
          <h2 className="text-3xl font-black mb-4">Join the Admin Team</h2>
        </div>

        {/* Right Form */}
        <div className="w-full md:w-1/2 p-12 md:p-16 flex flex-col justify-center">

          <h1 className="text-3xl font-black text-gray-800 mb-6">Create Account</h1>

          <form onSubmit={handleRegister} className="space-y-5">

            <div className="grid grid-cols-1 gap-4">

              <input
                type="text"
                name="fullName"
                placeholder="Enter Full Name"
                value={formData.fullName}
                onChange={handleChange}
                className="w-full bg-gray-50 rounded-xl px-4 py-3"
              />

            </div>

            <input
              type="email"
              name="email"
              placeholder="Company Email"
              value={formData.email}
              onChange={handleChange}
              className="w-full bg-gray-50 rounded-xl px-4 py-3"
            />

            <select
              name="role"
              value={formData.role}
              onChange={handleChange}
              className="w-full bg-gray-50 rounded-xl px-4 py-3"
            >
              <option>ADMIN</option>
              <option>EMPLOYEE</option>
              <option>General Manager</option>
            </select>

            <input
              type="password"
              name="password"
              placeholder="Min. 8 characters"
              value={formData.password}
              onChange={handleChange}
              className="w-full bg-gray-50 rounded-xl px-4 py-3"
            />

            <button
              type="submit"
              className="w-full bg-gray-800 text-white py-4 rounded-xl font-bold hover:bg-black"
            >
              Register Account
            </button>

          </form>

        </div>
      </div>
    </div>
  );
};

export default SignUp;