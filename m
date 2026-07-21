Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2639A06B
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610441; cv=fail; b=PVTO2i9oqBX0kQNo9XDi2IkarIXUqBlSrxC/LZRjLLT5FZtLEAUIkJ8OfzFQDe/y7tnWTUmAT43D5k9ejt2F2o2tWEViqHv1vTlbCYl2UILf6eAHeIfeL05IXD7S+PtUWn068FzD6uGKj/8NsWL3+DF59/OlZ8itro/gqqlV1YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610441; c=relaxed/simple;
	bh=KjAe+h7D1T506wMs6ZAuruA9Mc35x3yzmjoFwGbvjhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6gvgsXdq7msJYpTdbwLBtNZW9yFder1vOuxOe0+4YIuQQij0iI/xuEQB+ngf7Lhl1EjJ0BfiUBE/o4X9BaAUY8hVeJGH2uGc5z2v7hSYrSrxdaqmBLJEgX8pDoVOpZuf7NQgT8uyGUMlT2hmtkrLGh6eCTPk5cIsys7qQ5MXD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o0ZEWj+V; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o0ZEWj+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJNWH3IhuyKIiE3RM1ajEMrCPCcG8se4my/eOc357gBHrhjqtM3ZZuwUkpxmyYzDvx7+mPQmDff0peqXI+PrrPrQvz5W0Ggc1eZlI61ODcs0O5YcJ1Sy7C8E5IlsHdvXB9Sr17QoJqDYGgm77uUmAMAOFjpjp2LLAfiZ/KPVbMiTEuAvTsBv0/ZSOyRIYUEAPh+sWVkfbluO12By9aBFdyWuNT+mlhNDQUAc+tOhemB8ZdiFeSJgIRoOcpcGjFikEbRjtrtsgV2ISSV0z0RiFOYrJZTIwI0VSpEHTEyvuI13a07ZD+e050HlM6+hpI1eXA3pruO6Kf1uXgBpFmwrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Edwmg1d6lhH8B2Wl2vaD6bYA+Wlcal1b3mcweFKdbw=;
 b=pAP+AZHgCPFjXsTTU/JAXtFlnr+XBzIHRY8wIA7rqErBy7H5qCw76gneS8GlPqglEYAkM/uSVv9ucYD2QiLONrVB46gng+A2SU+QKnqFocJWiOSNVh1deMLoXcDodXRDkY4ypV1vpli2afVpuYOYVxsQljFrVl4e2jrOX3o1weTbHGFNQakTRkuWbaNr6WMj6TuNaKcW6dV4M1qtzHiKEwzaQsjjXwVLJe9VnPIepbjvmZhjW3vErHShNgmJp0RfyvmxOmoci6YWUcfNgjXPi1zQhcSHB5r1EJHzDXGCxsh9659TdabEMkl++1rOq1XgQ1eVfEwvup3hFNIxBZk7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Edwmg1d6lhH8B2Wl2vaD6bYA+Wlcal1b3mcweFKdbw=;
 b=o0ZEWj+Vm7wAuxSPQILr8Zy72MXbjD7yLqZQ9Y2npbrM2uUgknTeaNI2AYhmbibDVa67ZbLU2jFY72LmVZY25aCvFfHzNw4jQvyPyPgTpKJvqNersDiWsK1Rg7di5tm0/LTKnwwnBuOVSKDxccvvw3DUBKKaysJz6TR1toZcyX8=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:07:11 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::73) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:07:11 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:07:07 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
Date: Tue, 21 Jul 2026 05:05:58 +0000
Message-ID: <20260721050600.87268-4-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721050600.87268-1-shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd7c4e8-d684-4cc9-48b3-08dee6e5ebed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z3nJMkEI8F6lwThNH8k7r3PqaErwITE8t9OLxb2ebTHoZFkw5SrV+1tzGin2KBlZXGWrVgERS05ZP3f7FSfV7q/gujsxZRSnmLQMOobhRPl0zMqoMflsIiXYdfm1fXD760/EhME8T8OJo/sa5Tz/NxOXp1O0Zxe2f1w57bTkjD56aKknIWE+mhlnM+ZslVAU3O1V6B9eFIJjTmPMO5Vw+XqfTmcvZK+P9V/5NCSQDjretjpRoX2WeK2YUV8SENvpVbEP7JUHDSX4QyFc5n4o7qHeZzH1nPrcMNwNrW+A6YvObRFlMVt0/TaNLPSd8GEVKWbI8O8d33Tyf2aQXOJK7GKO45ClUBDM2j3n5o4lutpAhXhOTgOxbZNFzG3sTOkoxmg1l2kh/iptQzOeGc5zN621QVgl161gKRAU16/O+DyqR2f5WMFqwKqk3q8d+7NGT/W2t69IQU2rTfZcvUM1uxSpA611kriOUzcYLebj8/U1Juknv5Lkhb5wgRTeGJANl0UsBBrei+5wQNYtREV+GSwmF2q6YvVKJXAgEkdgEPPdkNpcrdG8ozwxzSHItu5ctYdYdiDU3Yhg7u8JBvhbY8BrdPQZsqaXG4gSiiEWSwCSgMSCsSev5d3cfbTqO1pef8ivg/+x8EveZElXSACvomP3UaKAK1RRRgLmUzPeT7+YXg1TDrFsfT+u32L300qw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BpKtZbz/gnbtl9rOijXeqPVRU23a2Ds/s+s+C0LTe5FAeLvcO3/tHjRvgG5DGlLCYqQBJAu32v9KdfsEihIYuk9qmbRsMMYgPXR66nfaAdeSsexcDg50pwaVVkhJh3eEx3qtsgZn9nGu8Epybo7CZbu3lEs5V5zKUse9sPqyF+bmHza42dUV+xKdmMP/6dgycmOxLsA1k9Nv+63EuWcFSFovvmHdRuuzi4nhsvMtJqFs07lmkbVrpvpv6l3u2mCQSHcjox+ZUPNUJPpWt5XZydUQPRaTkUDPJdWY9WyFUnfpqpu4M/PX1K6SUkHc+iszoTcskZJ0ZGV8ve7exP4Kye0OadnkoaFNJGJQe6e034PZtRfzjin4xjmxBeHtyYw9sRohHBD8x9T0LkEkTm52kmG9Y70CL5tV2qQxz8Jp+P4XVL9nHA/Gfe3oiq5M3EZg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:07:11.2272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd7c4e8-d684-4cc9-48b3-08dee6e5ebed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
(DR6_BUS_LOCK) to 1 unconditionally.

DR6_BUS_LOCK is active-low (the CPU clears it to 0 to report a bus lock), so
forcing it to 1 unconditionally would prevent an L2 from ever observing a
bus lock (DR6.BLD == 0) across a nested VMRUN.

Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on
the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
Detect.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3 -> v4:
 * Spell out what breaks when DR6_BUS_LOCK is forced to 1 (Nikunj).

v3:
 * New patch.
 * Use kvm_dr6_fixed() instead of open-coding DR6_FIXED_1 | DR6_RTM.

---
 arch/x86/kvm/regs.c       | 3 ++-
 arch/x86/kvm/regs.h       | 1 +
 arch/x86/kvm/svm/nested.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index d2caf5a67dba..1b5dfa765140 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -764,7 +764,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
+u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
 {
 	u64 fixed = DR6_FIXED_1;
 
@@ -775,6 +775,7 @@ static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
 		fixed |= DR6_BUS_LOCK;
 	return fixed;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_dr6_fixed);
 
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 {
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 94fd86728fed..e85c3ff3e120 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -23,6 +23,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
 int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
+u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8d1967f5c099..9b1afa47c54c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -810,7 +810,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
 		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
-		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
+		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-- 
2.43.0

