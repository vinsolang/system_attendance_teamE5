import React from 'react';

const SignUp = () => {
  return (
    <div className="min-h-screen bg-[#D1D5DB] flex items-center justify-center p-6">
      <div className="max-w-5xl w-full bg-white rounded-[50px] shadow-2xl overflow-hidden flex flex-col md:flex-row-reverse min-h-[700px]">
        
        {/* Left Side: Illustration Area */}
        <div className="w-full md:w-1/2 bg-blue-600 p-12 flex flex-col justify-center items-center text-white text-center">
          <div className="w-32 h-32 bg-white/20 rounded-[40px] flex items-center justify-center mb-8 backdrop-blur-xl animate-bounce duration-[3s]">
            <i className="fas fa-user-plus text-4xl"></i>
          </div>
          <h2 className="text-3xl font-black tracking-tight mb-4">Join the Admin Team</h2>
          <p className="text-blue-100 text-sm font-medium max-w-xs mx-auto leading-relaxed">
            Create an account to start managing attendance, geofencing, and system security.
          </p>
        </div>

        {/* Right Side: Form */}
        <div className="w-full md:w-1/2 p-12 md:p-16 flex flex-col justify-center">
          <div className="mb-8">
            <h1 className="text-3xl font-black text-gray-800 tracking-tight">Create Account</h1>
          </div>

          <form className="space-y-5">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1">
                <label className="text-[10px] font-black text-gray-400 uppercase ml-1">First Name</label>
                <input type="text" className="w-full bg-gray-50 border-none rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-gray-300" />
              </div>
              <div className="space-y-1">
                <label className="text-[10px] font-black text-gray-400 uppercase ml-1">Last Name</label>
                <input type="text" className="w-full bg-gray-50 border-none rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-gray-300" />
              </div>
            </div>

            <div className="space-y-1">
              <label className="text-[10px] font-black text-gray-400 uppercase ml-1">Company Email</label>
              <input type="email" className="w-full bg-gray-50 border-none rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-gray-300" />
            </div>

            <div className="space-y-1">
              <label className="text-[10px] font-black text-gray-400 uppercase ml-1">Admin Role</label>
              <select className="w-full bg-gray-50 border-none rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-gray-300 appearance-none">
                <option>HR Manager</option>
                <option>IT Administrator</option>
                <option>General Manager</option>
              </select>
            </div>

            <div className="space-y-1">
              <label className="text-[10px] font-black text-gray-400 uppercase ml-1">Password</label>
              <input type="password" placeholder="Min. 8 characters" className="w-full bg-gray-50 border-none rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-gray-300" />
            </div>

            <div className="flex items-center gap-3 py-2">
              <input type="checkbox" className="w-4 h-4 rounded border-gray-300 text-gray-800 focus:ring-gray-800" />
              <label className="text-[10px] font-bold text-gray-500">I agree to the Terms of Service & Privacy Policy</label>
            </div>

            <button className="w-full bg-gray-800 text-white py-4 rounded-xl font-black text-xs uppercase tracking-widest hover:bg-black transition-all">
              Register Account
            </button>
          </form>

          <div className="mt-8 text-center">
            <p className="text-[11px] text-gray-400 font-bold uppercase tracking-wider">
              Already have an account? <a href="/signin" className="text-blue-500">Log In</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SignUp;