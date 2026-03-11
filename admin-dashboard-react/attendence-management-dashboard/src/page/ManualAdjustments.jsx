import React from 'react';

const ManualAdjustments = () => {
  return (
    <div className="p-8 bg-[#D1D5DB] min-h-screen rounded-tl-[40px] space-y-8">
      
      {/* Header Section */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Manual Adjustments</h1>
          <p className="text-sm text-gray-500">Correct attendance logs and override status entries</p>
        </div>
        <button className="bg-gray-800 text-white px-6 py-2 rounded-xl text-sm font-semibold hover:bg-black transition-all shadow-lg shadow-gray-400/50">
          Bulk Import (.csv)
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        {/* Adjustment Form Card */}
        <div className="lg:col-span-1 bg-white p-8 rounded-[32px] shadow-sm border border-gray-100 h-fit">
          <h2 className="text-lg font-bold text-gray-800 mb-6">New Adjustment</h2>
          
          <form className="space-y-5">
            <div>
              <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">Employee Name/ID</label>
              <input 
                type="text" 
                placeholder="Search employee..." 
                className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200"
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">Date</label>
                <input type="date" className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200" />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">New Status</label>
                <select className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200">
                  <option>Presence</option>
                  <option>Leave</option>
                  <option>Absent</option>
                  <option>Half-Day</option>
                </select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">Check-in</label>
                <input type="time" className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200" />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">Check-out</label>
                <input type="time" className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200" />
              </div>
            </div>

            <div>
              <label className="block text-[11px] font-bold text-gray-400 uppercase mb-2">Reason for Adjustment</label>
              <textarea 
                rows="3" 
                placeholder="e.g., Forgot to clock in..." 
                className="w-full bg-gray-50 border-none rounded-2xl px-4 py-3 text-sm focus:ring-2 focus:ring-gray-200"
              ></textarea>
            </div>

            <button className="w-full bg-gray-800 text-white py-4 rounded-2xl font-bold text-sm mt-4 hover:shadow-xl transition-all">
              Apply Adjustment
            </button>
          </form>
        </div>

        {/* History / Audit Log Card */}
        <div className="lg:col-span-2 bg-white rounded-[32px] shadow-sm overflow-hidden flex flex-col">
          <div className="p-6 border-b border-gray-50">
            <h3 className="font-bold text-gray-700">Modification History</h3>
          </div>
          
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead className="bg-gray-50/50 text-gray-400 text-[10px] uppercase tracking-widest font-bold">
                <tr>
                  <th className="px-6 py-4">Modified Employee</th>
                  <th className="px-6 py-4">Original</th>
                  <th className="px-6 py-4">Corrected To</th>
                  <th className="px-6 py-4">By Admin</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {[1, 2, 3].map((_, i) => (
                  <tr key={i} className="hover:bg-gray-50 transition-all">
                    <td className="px-6 py-4">
                      <p className="text-sm font-bold text-gray-800 tracking-tight">Sreyna Paul</p>
                      <p className="text-[10px] text-gray-400">ID: 001 • March 10</p>
                    </td>
                    <td className="px-6 py-4">
                      <span className="text-xs text-red-400 line-through">Absent</span>
                    </td>
                    <td className="px-6 py-4">
                      <span className="px-2 py-1 bg-green-100 text-green-600 rounded-md text-[10px] font-bold uppercase">Presence</span>
                      <p className="text-[9px] text-gray-400 mt-1">7:30 AM - 5:30 PM</p>
                    </td>
                    <td className="px-6 py-4">
                      <p className="text-[11px] font-medium text-gray-600">Admin_SokNy</p>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          
          <div className="mt-auto p-6 bg-gray-50/50 text-center">
            <button className="text-xs font-bold text-gray-400 hover:text-gray-600">View Full Audit Log</button>
          </div>
        </div>

      </div>
    </div>
  );
};

export default ManualAdjustments;