import React from 'react';
import { Overview, DailyRecords, AttendanceStats, AttendanceSource } from '../components/DashboardComponents';

const DashboardHome = () => (
  <div className="space-y-8">
    <div className="grid grid-cols-12 gap-8">
      <Overview />
      <AttendanceStats />
    </div>
    <div className="grid grid-cols-12 gap-8">
      <DailyRecords />
      <AttendanceSource />
    </div>
  </div>
);

export default DashboardHome;