import React from 'react';

const SignIn = () => {
  return (
    <div className="min-h-screen bg-[#D1D5DB] flex items-center justify-center p-6">
      <div className="max-w-5xl w-full bg-white rounded-[50px] shadow-2xl overflow-hidden flex flex-col md:flex-row min-h-[700px]">
        
        {/* Left Side: Branding/Visual */}
        <div className="w-full md:w-1/2 bg-gray-800 p-12 flex flex-col justify-between text-white relative overflow-hidden">
          <div className="z-10">
            <div className="w-12 h-12 bg-white/10 rounded-2xl flex items-center justify-center mb-6 backdrop-blur-md">
              <i className="fas fa-shield-alt text-xl"></i>
            </div>
            <h2 className="text-4xl font-black leading-tight tracking-tighter">
              Manage your <br /> workforce <br /> with precision.
            </h2>
          </div>
          
          <div className="z-10">
            <p className="text-sm font-medium opacity-50 uppercase tracking-widest">Enterprise Portal</p>
            <p className="text-lg font-bold">CNP Company Co.Ltd</p>
          </div>

          {/* Decorative Circles */}
          <div className="absolute -bottom-20 -left-20 w-64 h-64 bg-white/5 rounded-full"></div>
          <div className="absolute top-10 -right-10 w-32 h-32 bg-blue-500/10 rounded-full blur-3xl"></div>
        </div>

        {/* Right Side: Form */}
        <div className="w-full md:w-1/2 p-12 md:p-20 flex flex-col justify-center">
          <div className="mb-10">
            <h1 className="text-3xl font-black text-gray-800 tracking-tight">Welcome Back</h1>
            <p className="text-gray-400 font-medium mt-2">Enter your credentials to access the admin suite.</p>
          </div>

          <form className="space-y-6">
            <div className="space-y-2">
              <label className="text-[11px] font-black text-gray-400 uppercase ml-1">Work Email</label>
              <input 
                type="email" 
                placeholder="admin@cnp-company.com"
                className="w-full bg-gray-50 border-none rounded-2xl px-6 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all outline-none"
              />
            </div>

            <div className="space-y-2">
              <div className="flex justify-between items-center px-1">
                <label className="text-[11px] font-black text-gray-400 uppercase">Password</label>
                <a href="#" className="text-[10px] font-bold text-blue-500 hover:underline">Forgot?</a>
              </div>
              <input 
                type="password" 
                placeholder="••••••••"
                className="w-full bg-gray-50 border-none rounded-2xl px-6 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all outline-none"
              />
            </div>

            <button className="w-full bg-gray-800 text-white py-5 rounded-2xl font-black text-xs uppercase tracking-[0.2em] shadow-xl shadow-gray-200 hover:bg-black transition-all transform hover:-translate-y-1">
              Sign In to Dashboard
            </button>
          </form>

          {/* <div className="mt-10 text-center">
            <p className="text-sm text-gray-400 font-medium">
              Don't have an account? <a href="/signup" className="text-gray-800 font-black border-b-2 border-gray-800 pb-0.5">Contact HR</a>
            </p>
          </div> */}
        </div>
      </div>
    </div>
  );
};

export default SignIn;