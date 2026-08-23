export const PERMISSIONS = {
  registersPatients: ["ADMIN", "RECEPTIONIST", "NURSE", "DOCTOR"],
  managesPharmacyInventory: ["ADMIN", "PHARMACIST"],
  dispensesDrugs: ["ADMIN", "PHARMACIST"],
  managesBloodStock: ["ADMIN", "LAB_TECH"],
  issuesBlood: ["ADMIN", "LAB_TECH", "DOCTOR", "NURSE"],
  recordsPayments: ["ADMIN", "BILLING_CLERK", "RECEPTIONIST"],
  dispatchesAmbulance: ["ADMIN", "RECEPTIONIST", "NURSE", "DOCTOR"],
  recordsVisitNotes: ["ADMIN", "DOCTOR", "NURSE"],
  managesStaff: ["ADMIN"],
} as const;

export type PermissionAction = keyof typeof PERMISSIONS;

export function can(role: string | undefined, action: PermissionAction): boolean {
  if (!role) return false;
  return (PERMISSIONS[action] as readonly string[]).includes(role);
}