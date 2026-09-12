"use client";

import { useEffect, useState } from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  BarChart,
  Bar,
} from "recharts";

type RevenuePoint = { date: string; total: number };
type TopDrug = { name: string; quantity: number };

export default function AdminReportsPage() {
  const [revenue, setRevenue] = useState<RevenuePoint[]>([]);
  const [topDrugs, setTopDrugs] = useState<TopDrug[]>([]);
  const [error, setError] = useState("");

  useEffect(() => {
    fetch("/api/reports")
      .then(async (res) => {
        if (!res.ok) {
          const data = await res.json().catch(() => ({}));
          throw new Error(data.error || "Could not load reports");
        }
        return res.json();
      })
      .then((data) => {
        setRevenue(data.revenue);
        setTopDrugs(data.topDrugs);
      })
      .catch((err) => setError(err.message));
  }, []);

  const totalRevenue = revenue.reduce((sum, r) => sum + r.total, 0);

  return (
    <main className="p-8">
      <h1 className="mb-6 text-xl font-medium text-[#2C2C2A]">Reports</h1>
      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

      <section className="mb-10">
        <div className="mb-4 flex items-baseline justify-between">
          <h2 className="text-sm font-medium text-gray-700">
            Revenue — last 30 days
          </h2>
          <p className="text-lg font-medium text-[#0982e8]">
            KES {totalRevenue.toFixed(2)}
          </p>
        </div>
        {revenue.length === 0 ? (
          <p className="text-sm text-gray-400">No payments recorded in this period.</p>
        ) : (
          <div style={{ width: "100%", height: 260 }}>
            <ResponsiveContainer>
              <LineChart data={revenue}>
                <CartesianGrid stroke="#E8E2D6" strokeDasharray="3 3" />
                <XAxis dataKey="date" tick={{ fontSize: 11 }} />
                <YAxis tick={{ fontSize: 11 }} />
                <Tooltip
                  formatter={(value) => {
                    const numericValue = Array.isArray(value)
                      ? Number(value[0] ?? 0)
                      : Number(value ?? 0);
                    return `KES ${numericValue.toFixed(2)}`;
                  }}
                />
                <Line type="monotone" dataKey="total" stroke="#0982e8" strokeWidth={2} dot={false} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        )}
      </section>

      <section>
        <h2 className="mb-4 text-sm font-medium text-gray-700">Top 5 dispensed drugs</h2>
        {topDrugs.length === 0 ? (
          <p className="text-sm text-gray-400">No dispenses recorded yet.</p>
        ) : (
          <div style={{ width: "100%", height: 260 }}>
            <ResponsiveContainer>
              <BarChart data={topDrugs} layout="vertical">
                <CartesianGrid stroke="#E8E2D6" strokeDasharray="3 3" />
                <XAxis type="number" tick={{ fontSize: 11 }} />
                <YAxis type="category" dataKey="name" width={120} tick={{ fontSize: 11 }} />
                <Tooltip />
                <Bar dataKey="quantity" fill="#0982e8" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        )}
      </section>
    </main>
  );
}