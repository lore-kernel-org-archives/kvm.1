Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780327E05F;
	Thu,  2 Apr 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155481; cv=fail; b=G9h+QDx/YH1CWdnWu+vrG/q4E3sH0WXT8tRJcQGT8Tc8+I/HNt8qGktQhYsF1eMKKmqPGkiygxg2WMmpb3S5dUetI7SFeZcTcWf0v6y/ydjV4vK+0DXgnFDMRs3i9ondtu3ffc8SZl6qyhB9UQ1ZEo1Ohmp87xK7/2dWlKvDwJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155481; c=relaxed/simple;
	bh=7YocVnoypeU+Wcr1Srj/BogJAXbzGJvx5ZYGmIcuu5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZY9n3bIV1G3jHXggif+MtRMvc5j6gy7GgDW/36gSBi6p1CtsaJcgwlEywR8kkwLjLzpJUEpBDk3H5dVXoitPro1+aKcunAJtVAc83BGoE12w3tQhvpV4jrmv3505iUEiittN1xXAcU/CipSQojeXGx39ef4rhC0C7EmGTu9HrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z6KkQJL0; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6KkQJL0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBGsDHQf57ghpcMBOdUUWn6RedNsDLBY2N6mOoo9u2tSYVvZspN2NGa+fFOMtTNMLsyjAJUav6hFK/BbXas3MSn2/tNuz+Y2zY9i08yMfgvJ8i23quKMVg1pEQWcNHKrluMh6IvduYR+zknVfIiEKADjOAz7OCmrzOkdsTTZA7Jk6VSrXYHE4m1pPBbwNQ+o/zd3QmcMI//29fdYZ47KtwVnEHjuVxfSa1WCmcShKMenZEIJYyEom0p0Azd8Fl2YdPWWzQJD1ndx6LMyKVSUZZ066DdB/ypj41V9Sss8XyenqbWNQluIMC8mm/uA74K4bxKDVw0VhvW861gm3UXw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOtIeEr4lY22weknO02MJjYqICGa/Yd6cMWtQmCP45w=;
 b=BNJMV+1USOkhgL3R1gnMWEZf0dGxVZTAqYE1i/5x/9/DbnpIWC3RNqFvGlp+OiD+KxOM5GkVSyrBPgBEhV+gEP6q1cHcL5Ld3f7UJoW/kwrKRLnusX7h4FiILO8ZFCwNgl7WUuaj75xkyCxd+Rl7mQ4g1NgrGJvU0u5ZEkh8gJfNjEzXNEmeDCFl7PK3jocAfP+/VFQw1I4wb0KylMjR1VrgzBLBntcJj1vmcjTHGOVSwaGsIQ/NNa77ccPIAmNQTMIYqPNNCp1tYJZ1WYzb9IIev2mF7hAX/VffnJmEwILb7k5+8CP23DZvzEUKWqX+940mce0+YgK0sDq/HQ//vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOtIeEr4lY22weknO02MJjYqICGa/Yd6cMWtQmCP45w=;
 b=z6KkQJL0zdsTPC/sFs1r5Uv/LkrESuzazxItS/WbkN/On6NbCFI6u3TvLfLTEKrEdD/WR0jmzvClIxos6IenmPrfNail8mqsT7zwQ6qaDB+gc5zJAV3AmNCPm4XLEV4uZpSJalwwVo/WZ0X+Al6vD6zCcgBwohvA9OMWPPqoUd4=
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:44:30 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::c8) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:44:30 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:44:26 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 5/7] KVM: SVM: Support FRED nested exception injection
Date: Thu, 2 Apr 2026 18:42:38 +0000
Message-ID: <20260402184240.1939480-6-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef5a07c-472a-4148-5a61-08de90e7dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xjbANF7fnvu9erkcqzLa9rQ13/zRE2rHM3re3+urPgw4L0dj2AhKauw2WjSH67shit2Pn1kDdt8rOvh/I0TGXovHIRErCwzdzML+RuBVaXAUFX9j+VGOZdO0+XlkQ8mY+GdgGa01MWfgmSrnrMigOhTqHOFDVrjTc11XsSw5+gDklJGR1tB1ZGGYT5G4lNboHkSaY/xGYn4ol0WqcwC+bwGlVhkX7KJf2VUMYJrsZ9cHPw0MuoTOCO7zfT6n9e+TL//nTRt4039QQuXpBJyUwrfMDpkS2Iyt/gsZa85k/DcPSg49nsK6A41KaqHovFlVf4Ii2N+fp+LiiiD8KdRJnnTQhUjsEv09gnGftcmoRgO/iyDvbHuTdpeDt1YgyVrxoZlbwqW9+mM01hQ50qq64FAYIZAvd/P0v2bYKBzJb0tpFOiZAlqMfr+CbVnkUXTHTa/xZXLbHHMUVe/2T9n0ljDX5UMbuzhNT09lEqAZRnSFpKRqDHPf3JubA9tut3HSQpFSaxll7O8sPnoN32Ol1j2qphLqI+eZs52PcSxxQV3og+5oL15Id/65FPwVVjvJhHaicc6F7VAbOm17pMfKG+zAluzXatBnuAGjBns5I/ZwWSXK11WFFpozZrFpZSUdrKFHy5LArFv+SDn0X3IopIl6Ir4nZjbq4sIrB8Iq9tJYeZgJIRMh59n0Cv02Uf/UkzMBa2/762hRIjRkgx+4vK9QOUdT5V/djELjPwMV58Juny613NdO4ejeA6x1vw+nForEQHNPycg62EoIU5TE2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rqdjO80Q+yvLCmeL6W95NRpcEDGXTpIC7Agj/o91WnaHYSFjQ+l1NyYQ8hcOpKUKLGCNY7JVBVnnFNdmDCwuJ1tE19E7DW7s5aRJJqbm5OLrj6nGM60DVqS8YFHoOSvrfG4zE2iEVofAzKgp/uTRrRu7B90FsZU6FRfi1wIDgT0IK5ULBvYLGiYeb/L4qe0rlM0HIXch3YMaxh0ZCaW5fo1wcBUauirsGC2EPhDFJ4nTYSIBN2FbMDPb7Detv663MuLR9BybHFZF+os1p9sOil9NGcoh9/O/l0a3gWTdwN6BMrN7OoW3iIpamiouc5eyGfs4rLIKTY1K0jImCv4qW9PQWgo+iYwZCj9iQFwMfnmIZ6EItWC1dvNVhk0nVJ9EL+vSCtQpu4YJhAjT3GdBfPH9lK+BrsUw3z9HfmSwxQjEwXdWxBFR++n7JsjjAS1L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:44:30.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef5a07c-472a-4148-5a61-08de90e7dff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Set the SVM nested exception bit in EVENT_INJECTION_CTL when
injecting a nested exception using FRED event delivery to
ensure:
  1) A nested exception is injected on a correct stack level.
  2) The nested bit defined in FRED stack frame is set.

The event stack level used by FRED event delivery depends on whether
the event was a nested exception encountered during delivery of an
earlier event, because a nested exception is "regarded" as happening
on ring 0.  E.g., when #PF is configured to use stack level 1 in
IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on the stack pointed by FRED_RSP1
    MSR when encountered in ring 3 and ring 0.
  - normal #PF will be delivered on the stack pointed by FRED_RSP0
    MSR when encountered in ring 3.

The SVM nested-exception support ensures a correct event stack level is
chosen when a VM entry injects a nested exception.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---

Changes in v2:
- Replace variable 'nested' with 'is_nested' (Sean Christopherson).
- Formatted variables in reverse fir-tree order (Sean Christopherson).

---
 arch/x86/include/asm/svm.h | 1 +
 arch/x86/kvm/svm/svm.c     | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index a42ed39aa8fb..c0f6523e2b2d 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -656,6 +656,7 @@ static inline void __unused_size_checks(void)
 
 #define SVM_EVTINJ_VALID (1 << 31)
 #define SVM_EVTINJ_VALID_ERR (1 << 11)
+#define SVM_EVTINJ_NESTED_EXCEPTION    (1 << 13)
 
 #define SVM_EXITINTINFO_VEC_MASK SVM_EVTINJ_VEC_MASK
 #define SVM_EXITINTINFO_TYPE_MASK SVM_EVTINJ_TYPE_MASK
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2da493f9dd8b..39d1177a24f0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -362,6 +362,7 @@ static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
 static void svm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
+	bool is_nested = is_fred_enabled(vcpu) && ex->nested;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	kvm_deliver_exception_payload(vcpu, ex);
@@ -373,6 +374,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	svm->vmcb->control.event_inj = ex->vector
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
+		| (is_nested ? SVM_EVTINJ_NESTED_EXCEPTION : 0)
 		| SVM_EVTINJ_TYPE_EXEPT;
 
 	if (is_fred_enabled(vcpu))
@@ -4158,7 +4160,8 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, false, event_data);
+				      error_code, exitintinfo & SVM_EVTINJ_NESTED_EXCEPTION,
+				      event_data);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
-- 
2.43.0

