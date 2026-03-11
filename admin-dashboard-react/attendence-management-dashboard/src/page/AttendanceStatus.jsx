import React from 'react';
import { UserCheck, UserX, Clock, Calendar } from "lucide-react";
const AttendanceStatus = () => {
  // Mock data for the live feed
  const liveData = [
    { id: '001', name: 'Sreyna Paul', checkIn: '7:30 AM', status: 'Active', location: 'KCC', device: 'iOS' },
    { id: '002', name: 'Sok Mean', checkIn: '8:15 AM', status: 'Late', location: 'Main Office', device: 'Android' },
    { id: '003', name: 'Vichea Vy', checkIn: '7:45 AM', status: 'Active', location: 'KCC', device: 'Web' },
  ];

  return (
    <div className="p-8 bg-[#D1D5DB] min-h-screen rounded-tl-[40px] space-y-8">
      
      {/* Header Section */}
      <div className="flex justify-between items-center">
        <div className="flex items-center gap-4">
          <h1 className="text-2xl font-bold text-gray-800">Live Attendance Status</h1>
          <div className="flex items-center gap-2 px-3 py-1 bg-red-500/10 border border-red-500/20 rounded-full">
            <span className="w-2 h-2 bg-red-600 rounded-full animate-pulse"></span>
            <span className="text-[10px] font-bold text-red-600 tracking-wider">LIVE FEED</span>
          </div>
        </div>
        <div className="text-sm text-gray-500 font-medium">
          March 10, 2026 | 01:17 PM
        </div>
      </div>

      {/* Real-time Statistics Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
    {[
        { label: 'On-Duty', count: '142', color: 'bg-green-500', icon: <UserCheck size={24} /> },
        { label: 'Off-Duty', count: '48', color: 'bg-gray-400', icon: <UserX size={24} /> },
        { label: 'Late', count: '5', color: 'bg-orange-500', icon: <Clock size={24} /> },
        { label: 'On Leave', count: '2', color: 'bg-blue-500', icon: <Calendar size={24} /> },
    ].map((stat, index) => (
        <div
        key={index}
        className="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 flex justify-between items-center"
        >
        <div>
            <p className="text-gray-400 text-xs font-bold uppercase tracking-tight">
            {stat.label}
            </p>
            <h3 className="text-3xl font-black text-gray-800 mt-1">
            {stat.count}
            </h3>
        </div>

        <div
            className={`w-12 h-12 ${stat.color} rounded-2xl flex items-center justify-center text-white shadow-lg opacity-80`}
        >
            {stat.icon}
        </div>
        </div>
    ))}
    </div>

      {/* Live Activity Table */}
      <div className="bg-white rounded-3xl shadow-sm overflow-hidden">
        <div className="p-6 border-b border-gray-50 flex justify-between items-center">
          <h3 className="font-bold text-gray-700">Recent Movements</h3>
          <div className="flex gap-2">
            <input 
              type="text" 
              placeholder="Filter by name..." 
              className="bg-gray-50 border-none rounded-xl px-4 py-2 text-sm focus:ring-2 focus:ring-gray-200"
            />
          </div>
        </div>
        
        <table className="w-full text-left">
          <thead className="bg-gray-50/50 text-gray-400 text-[11px] uppercase tracking-widest font-bold">
            <tr>
              <th className="px-8 py-4">Employee</th>
              <th className="px-8 py-4">Check-in Time</th>
              <th className="px-8 py-4">Status</th>
              <th className="px-8 py-4">Location</th>
              <th className="px-8 py-4 text-right">Device</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {liveData.map((emp, i) => (
              <tr key={i} className="hover:bg-gray-50/80 transition-all duration-200">
                <td className="px-8 py-4">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-gradient-to-tr from-gray-200 to-gray-100 rounded-xl"></div>
                    <div>
                      <p className="text-sm font-bold text-gray-800">{emp.name}</p>
                      <p className="text-[10px] text-gray-400">ID: {emp.id}</p>
                    </div>
                  </div>
                </td>
                <td className="px-8 py-4 text-sm text-gray-600 font-medium">{emp.checkIn}</td>
                <td className="px-8 py-4">
                  <span className={`px-3 py-1 rounded-lg text-[10px] font-bold uppercase ${
                    emp.status === 'Active' ? 'bg-green-100 text-green-600' : 'bg-orange-100 text-orange-600'
                  }`}>
                    {emp.status}
                  </span>
                </td>
                <td className="px-8 py-4 text-sm text-gray-500">{emp.location}</td>
                <td className="px-8 py-4 text-right">
                  <span className="text-xs bg-gray-100 px-2 py-1 rounded-md text-gray-500">{emp.device}</span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default AttendanceStatus;