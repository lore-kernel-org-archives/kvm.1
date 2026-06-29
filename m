Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A231352A
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720690; cv=fail; b=TN9EyhXsQa/Ri/kK23yDyG6GKGqy+mujrKO8QggrMWls/DZDDOze1n/geXlWXPguTAdKR7vFkGWP0eLn1Hqs/9KupUajyQhQdaDvDU3W7gusbfXYLNy+VdCGxjWRlcnt2TchRDnBEVgi/PwM76SPXxtsO4dTpluWwQ/+6n4hzHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720690; c=relaxed/simple;
	bh=DCKw3JMHsyTetcAyZz/sdAnUF276IEPr/abYVM9NeYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uop+8S3DBihfJ0sQoUhjJWYk6qO82oCE972YjjtLEYmuLy7bV3GDC2pC0s1/Dn79r1TNo3ez5DLtemOCY0WvdRa0CMwQIGfD6jFP7k8iLzujFWPwmibX+T3n0EJM718YEpr5ZF2r3vCoLGXRUVIqAoki8HIxD/YlqAb/o0wy9bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oItu3+Ms; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oItu3+Ms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwJwqImjBCw4m4+2TpkB4cSKXq3+oP0cWjvV/W7PrlHc8sfnqyN8YBr6d/K7cmNQxlA11YBU47VUld7WR/+zy7KSnA0SwmzcYdTxAPuaVODJj1RL9NDyOhDtdQpzd9qibWGOhknTyH9xhGX4Ku+PSLqzpQQYw4GSctRJR9nkFXnyW2UTOVXyfB++cm4xM51oPRoRC5vz1XOZNwfY72ak3g7F1ORfM1NBboso5pCCSEClpMBz2a8yrjdgJ+zpSBvE5dmvxmoKRF/D1vuXuTWc9NZm+lDJSM5I4RTbA6iPbH68pQvg8feANHjpiVNdMEbyvZoE8f1t3bFG+yUo6DwBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwnVDYQBtPBjaKYwUDZDPxaCwM5aIv4cZgP7ZdOHgVk=;
 b=CDft1VvJKIPY3EZEXS31gFidb1Td13BadvkZzOmTj0IAoGM6bk/vv52s1NbkQPedprpAvY0NpdPVhVINoFpg7RqDiOPYtIei859Otm2PYGZ3C/NY6AOXfCOg2AF6lQBzBrTpOWeiObMEyXEFxaV3e460AVseraLkR01DAFu+pL5BUiq+RlkRDnvbHccoekEO6UqkeBzG6VwBgBeuizvZ/zD3m3bmveuAbjsIpSxJklhqxjdnbZewPo3TG86VA+ODikvaoqNvGTw1mNM2ytMS2lA7sneTEoxN2b/mSiPxIzoy59IRJheUcDFAFzaGhYd1nNblhyfws1xsMgtUwNeHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwnVDYQBtPBjaKYwUDZDPxaCwM5aIv4cZgP7ZdOHgVk=;
 b=oItu3+Msj3FPdcEiXpGz0DzbzeuDktcWfA8JQfTcYQgRgDUSO2bK+GYfao63Ki+h2E1nCGKAe4bTwAfI8S61mZhpVtnxSbueJYzEzck/T5kL3lTTmQGdVLRWesrhHaNghnCIdxu9z2wR2yZzQfoLWbvIX6xn9LK37Mhnp5WbHd8=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 08:11:24 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::58) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 08:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 08:11:23 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 03:11:20 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [RESEND PATCH v2] KVM: SVM: Add Bus Lock Detect support
Date: Mon, 29 Jun 2026 08:10:18 +0000
Message-ID: <20260629081018.60618-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 91004e18-496f-4f63-9168-08ded5b602bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|13003099007|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XaqJb58XxDJaS20ewHpKYtYOs9y8IW+uiegId8X45hSpBsESQOpC40It9MUiaYNw19Cv/Rx/K+DeljqHB6Mz+Wd8XMYyJOiiirQ2Yboj3RkMG8J+qfN1Z7ItO2hs1WfoyY+XhMBIBsL5STrurMR//uWuIZXlI3MFblujjsjGobx+01bklDtgoXhilaXRhRmM+8euWSLpccy+dFpbbS6IqgVqbxBP0ZHAo1ArZTPqUWP7I/4XysgpJeSGYx3pZtfOKw9QSyr7IngycYP7elsqZTi1gr/v+ZSxAbrufwZ+9/UXiuHx3WUIC6xoj12KXwtHMQIBQUdF+V1RD/mBspwKTRHggAdWyz4L3zuAW6dOtP7kp5femi6s8m+mCbss7iX0pOex7MH8+7IredccqmcMOxgk4YD89foAEtjBtbUU9W8PkQURDwcCgFPGe3HP5CsAxVwAfwVPXThXSs2nw/kKAGIgSBmq5iJ5OPhpcG3ijSOgSf8JZieYFFM60aQbatmnxmNoWSZ59SowwBTGfytR1epnxLjd+mdBndEKxzE6vY5HCBHVfD6XQdj01e+AS1P2Pj6uf3ZJjI3Vxlo7UzMnW2NrlmlQmqre9gfeexVcHVDwIPP55TQmdYMbVohzlwy0cupjceUrA3Zb3zOvJvuw927xWo7Ns3xrRomrUtW97WWN6Tf3hhwVyTmExm40pNaCrPGQOlPtcWfuNIfnjbebdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(13003099007)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hjSKJ6k9ijR2Unfj0VdkOYRzxIsMQUSZQyQY4x6Fc3O821Gu0Q9vtrco1+rs3y6U9Zj0LTy892Fj+1Pgc95QD3X3iPTrq8fI43V6b7xTyGfYq0opcuMH45pYMcsHBi8S+ghfjCkOiYJy9lmabRL7B/SEaMOSJJtYgHy78HWWYDVRIdxNwbkRhAJhFGvkxX7XxxfgNNzF3shxAimVSDn1mJrXjjXx4bWYa9PYR/GmvtuUo5ggtRxJSmsJaemH1Mt0ppCpwPRiOWRwSFNgFGU21BLX7h8Y2aqlFiuR4H9B93jZdkoAYqacdSi8iI3q4e2/O734Awb909smUpRsfKW6+b5rHsSze10SguTErzAPlFTjC+3FEAx9gC7t9Km27NdP3qkLmxxWU+IQqrupad6ZLuu66vDyIINE4T/uQmOdxsFJSuQNzSY33qwPfWl723Mc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:11:23.8789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91004e18-496f-4f63-9168-08ded5b602bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

From: Ravi Bangoria <ravi.bangoria@amd.com>

Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
Virtualization is enabled. Add this dependency in the SVM.

While adding Bus Lock Detect support, also fix DR6 handling in nested
virtualization. Using DR6_FIXED_1 to prevent reset of BLD bit (bit 11)
between VMRUNs. However, it preserves DR6_RTM, which is a reserved bit
on AMD processors. So, DR6_RTM bit must always be set to 1.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v2 --> v2 Resend
 * No functional changes.
 * Rebased on top of tag: kvm-x86-next-2026.06.24.

v1 --> v2
 * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().

 v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
 v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
---
 arch/x86/kvm/svm/nested.c |  3 ++-
 arch/x86/kvm/svm/svm.c    | 17 ++++++++++++++++-
 arch/x86/kvm/svm/svm.h    |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c1485c3e691c..4fdc58d38afe 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -808,7 +808,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
 		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
-		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
+		/* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
+		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..b4b0fa730916 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -884,6 +884,9 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
 			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
 
+	/* Bus Lock Detect depends on LBR Virtualization */
+	enable_lbrv |= (svm->vmcb->save.dbgctl & DEBUGCTLMSR_BUS_LOCK_DETECT);
+
 	if (enable_lbrv && !current_enable_lbrv)
 		__svm_enable_lbrv(vcpu);
 	else if (!enable_lbrv && current_enable_lbrv)
@@ -3160,6 +3163,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
+		if ((data & DEBUGCTLMSR_BUS_LOCK_DETECT) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+			return 1;
+
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
@@ -5591,9 +5598,17 @@ static __init void svm_set_cpu_caps(void)
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
 
+	/*
+	 * LBR Virtualization must be enabled to support BusLockTrap inside the
+	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
+	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
+	 * enabled.
+	 */
+	if (!lbrv)
+		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..c65dc3acb5d1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -783,7 +783,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
 
 /* svm.c */
 extern bool dump_invalid_vmcb;

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.43.0

