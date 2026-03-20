import React, { useEffect, useState } from "react";
import axios from "axios";
import { CheckCircle, XCircle, Clock, Calendar, Search, RefreshCw } from "lucide-react";

const LeaveRequests = () => {
  const [requests, setRequests] = useState([]);
  const [loading, setLoading] = useState(false);
  const API_URL = "http://localhost:8080/api/leaves";

  // ================= FETCH DATA =================
  const fetchRequests = async () => {
    setLoading(true);
    try {
      const res = await axios.get(API_URL);
      setRequests(res.data);
    } catch (error) {
      console.error("Error fetching requests:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRequests();
  }, []);

  // ================= UPDATE STATUS =================
  const updateStatus = async (id, status) => {
    try {
      await axios.put(`${API_URL}/${id}/status`, { status });
      fetchRequests(); // refresh data
    } catch (error) {
      console.error("Error updating status:", error);
    }
  };

  const getStatusStyle = (status) => {
    switch (status) {
      case "APPROVED": return "bg-green-100 text-green-700 border-green-200";
      case "REJECTED": return "bg-red-100 text-red-700 border-red-200";
      default: return "bg-amber-100 text-amber-700 border-amber-200";
    }
  };

  return (
    <div className="p-8 bg-[#F3F4F6] min-h-screen font-sans">
      <div className="max-w-7xl mx-auto">
        
        {/* Header Section */}
        <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
          <div>
            <h2 className="text-3xl font-black text-gray-900 tracking-tight">Leave Management</h2>
            <p className="text-gray-500 font-medium">Manage and review employee requests in real-time</p>
          </div>
          
          <button 
            onClick={fetchRequests}
            className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-200 rounded-xl hover:bg-gray-50 transition-all text-sm font-bold text-gray-700 shadow-sm"
          >
            <RefreshCw size={16} className={loading ? "animate-spin" : ""} />
            Refresh Data
          </button>
        </div>

        {/* Beautiful Table Container */}
        <div className="bg-white rounded-[2.5rem] shadow-xl shadow-gray-200/60 border border-white overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead>
                <tr className="bg-gray-50/50 border-b border-gray-100">
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400">Request ID</th>
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400">Type</th>
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400">Date Range</th>
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400">Reason</th>
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400 text-center">Status</th>
                  <th className="px-6 py-5 text-[10px] font-black uppercase tracking-[0.15em] text-gray-400 text-right">Actions</th>
                </tr>
              </thead>

              <tbody className="divide-y divide-gray-50">
                {requests.length > 0 ? (
                  requests.map((req) => (
                    <tr key={req.id} className="hover:bg-blue-50/30 transition-colors group">
                      <td className="px-6 py-5 font-bold text-gray-900">#{req.id}</td>
                      <td className="px-6 py-5">
                        <div className="flex items-center gap-2">
                          <div className="p-2 bg-indigo-50 text-indigo-600 rounded-lg"><Calendar size={14} /></div>
                          <span className="font-bold text-gray-700">{req.type}</span>
                        </div>
                      </td>
                      <td className="px-6 py-5">
                        <div className="text-sm">
                          <p className="font-bold text-gray-800">{req.startDate}</p>
                          <p className="text-gray-400 text-[10px] font-medium tracking-wide italic">to {req.endDate}</p>
                        </div>
                      </td>
                      <td className="px-6 py-5">
                        <p className="text-sm text-gray-600 truncate max-w-[200px] font-medium">"{req.reason}"</p>
                      </td>
                      <td className="px-6 py-5 text-center">
                        <span className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-[10px] font-black border ${getStatusStyle(req.status)}`}>
                          {req.status === "PENDING" && <Clock size={10} />}
                          {req.status}
                        </span>
                      </td>
                      <td className="px-6 py-5 text-right">
                        <div className="flex items-center justify-end gap-1">
                          <button
                            onClick={() => updateStatus(req.id, "APPROVED")}
                            className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 rounded-xl transition-all"
                            title="Approve"
                          >
                            <CheckCircle size={20} />
                          </button>
                          <button
                            onClick={() => updateStatus(req.id, "REJECTED")}
                            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-xl transition-all"
                            title="Reject"
                          >
                            <XCircle size={20} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="6" className="px-6 py-20 text-center text-gray-400 font-bold">
                      {loading ? "Loading requests..." : "No requests found"}
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default LeaveRequests;