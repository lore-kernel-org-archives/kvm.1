Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD423D349F
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610478; cv=fail; b=JDELYggkzLobKAhWqvUpmZl86hI5neCv2wq1HlKd+8Wo4fefY5CnpfnItH+gobpO+POiRQWsLIPK+f8XI7P62r6hdJ1sJEUWUa+rQAfl3Kl0n2NOndX9yyvY0X2yt64OC9YuT4ZpnU8eWbpbiE0zXf6TgRiFfEzD3F4L8t/kLkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610478; c=relaxed/simple;
	bh=XeXyluRz+Ora4E8bo/wKQgvBVyAWWEqtTOjPbhzbqhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhGPPuyZLTDWxvO2kuNKlY2+i863BUh1rPgm9igrc653M5RLsymCByBb38ydgvN+AOHfuo52V1YEXyZemRZfqqrlMnM8Lqsf51x7OnAZ2czCAsE7ed0VWtTYvqHcG7Cy91HRvvq7XJZRNgmUKfC7YBwb121Feo5DpTvwK+QKYZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oZSOP8fE; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oZSOP8fE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx7nqj8niz31AgVzOhT9aAhOcQqj2PTjdHYsEGVTvd+vqddlRFTsGJcBBLdKw7qEZ1Md5+GYsit9ShCD00k9zv6WgCKgvWfis35/jx+4Qj7+Vx7UaDk2GOdXiBpyjNfe81oBJbrKCdqhSGrZIonlfoQXL98TqpMwvYETh2+9yQIBo2Ig2svdmHQ6IhyY6c8lsnELAxHTWgL1/Bj7Xh7T8NEanJFYz+O+Kapahgpzmn/rWSvSrUIanByIa3cotNOt1wpGKZbcayOBWqQDceL7Smh27X2g3YZeJTI7+/hdxyXSssVPEJz3ufwX9GsfVBVe27yldLI5yQCufdV1OEZCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBE/cmQP5h50UXmE7z1RTD0lL5d82TlIiznAdttr94U=;
 b=e0378LbLXYz0hEYplujQlIAOqmejlXj8fSiFe17KJkp/FejT0RCPOjNi9Q0WOitMpyJvlVHZWVpxB7VAZ+w4CeJZiSGc/0oXy3hDmd6skCvafj2EIQ1cq+WkJ/bXMSGi5SKkLmoR4f2mYqTLnaAHMUIcrGriqquAWFQMAHdiqjAD5cX5Js+BJHNRMVeeMNk595UXNdFqJ3YfFdX0DeB8frIO2yGBKA1o1zLFWVgrpjPUK0egin/KBYBRJzu4coT0YKlTSItqW3iuUb2Midn+mBpFhAJ0q8jw8dPQmjHZoG3ih7Nm7OTei3kT2dAfwNfibZnuy8YC9D4aF0yS6v4/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBE/cmQP5h50UXmE7z1RTD0lL5d82TlIiznAdttr94U=;
 b=oZSOP8fE5OiDrgfoNbNfZyOztgwW+EkSVLuP+fGjh6aZ53mJG5WwYkBbSIss71HWe6dKTnNO3EaplrBJt9i3SudWc3vOxUN67P9ybIV7NAFQ5Dhpx3OhMPT5rc3JESQHrYRAzg5s1aw9Uqq7FJP6Lh2sKhR1iV43lCttpby3+ZY=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 05:07:44 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::8) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Tue, 21
 Jul 2026 05:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:07:43 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:07:39 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 5/5] KVM: SVM: Add Bus Lock Detect support
Date: Tue, 21 Jul 2026 05:06:00 +0000
Message-ID: <20260721050600.87268-6-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: e34c225a-40ff-4e84-00e7-08dee6e5ff1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|6133799003|56012099006|11063799006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lUClqbKrmGYeO/59SVRW8af5kOjZAIcJ4KMhanF4ZLRAlKNiM4QRp/743zIku/7ANY1e9iW6j2iGQow9jVZXFA4vmzLoF5NCD3eCRDr3hBZfpY9y3fZuYT4rE5wSrV3mI48GOwSCsKZwXJvV8R+tIVAfuBsjIIJpOmLKl/zEKFxXe2cetemoKIztvXOxqZ4SNn4tVVnunhIRKh3CSqshY3/bXmeWWxACxwcOuZBF09mYkQdCN/YB7wTa6l32X2y0XCvUbe3hyI68zPUha+R/PdXhoNNwIiNDfWfNOBhUBt3vfRYXQgt0bFbSGHErqSotQ6I5noLoXry4aG/PcEW4XGLlf2xi3T26vo00u8q+ww1PXLDpxOVOagCho6xCoA3mMJW/ooTbRl4BvgsyrexTNEfHt3UUgXK0xUV8ULAtpOpn/mPsyp1c26qosnmZeoSZbSvuHy04T59Q9QteGpTUgRxQUq7+AYU5jDtqjU8aU58/4p4vNP/H33gPnLnecRIlARMD8CCL3xed23tNHGlPMIEnEaLwm7z/GZ++Xqxx/feXQKx8CSdd0EoIm5cqPRO3UztXg+djdxNNk+sFOxX6GMHdJDAsL6xFvl/pyXhYNtZNr6UhHJ55tAWrfwDiFhz74MooiBwO2+ODc+aV+K8vCOPDM/7BjmuPexg5H8HoMEneHM/jQabUsiix+gBb09CVk2336gY9dboRxigVbr8xTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(6133799003)(56012099006)(11063799006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x4uuuGMqp6KoktkUNLceq6c1rSU9rSAAWPb/N8OZHqS5kKD23b4PIKUG1HuamQYTNYEZr6JLfXiUIOE6D+5kCOEXbKHulhiLTKS9kVIG1N3rD2YUOjGCbhaFvMkeBNXZEekxjkX/sIH0PCy4d8slJ2QauHTMFyDfW21UQIy8Rs25QS4kTmWL2wmq8DXKx/Wuk4OnGSy6Gslndy+7t9+VWIDjBNWt9ckguf4LK+zqcTdStGpdiMNlC5AvvmzvAkaH/fm3acgyIi1dVDJUHq76eZS8rXB1DdQq++L1Wmse9w865MDPhNou4gN1rL5lonO5RPq5YkikqEWiU5vGOmrc2lkujBOFhAxJbLup10U4xru4kEzJGqJxyfwuDTloB44GHuNr2Yki+4lpAMIliaOLU42+ojb+yyBAN7Q6L9I0Wv9g+fZS5hTh0L4lD8nJac7Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:07:43.4258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c225a-40ff-4e84-00e7-08dee6e5ff1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
Virtualization is enabled. Add this dependency in the SVM.

Also, allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the guest supports Bus
Lock Detect.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3 -> v4:
 * Fold in the DEBUGCTLMSR_BUS_LOCK_DETECT gating moved from patch 4.

v2 -> v3:
 * Split refactor and prep changes out into patches 1-4; this patch now
   only wires up the LBRV dependency and exposes the capability.

v2 Resend:
 * Rebased on top of tag: kvm-x86-next-2026.06.24.

v1 -> v2:
 * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().

 v2 Resend: https://lore.kernel.org/kvm/20260629081018.60618-1-shivansh.dhiman@amd.com/
 v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
 v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
---
 arch/x86/kvm/svm/svm.c | 13 +++++++++++--
 arch/x86/kvm/svm/svm.h |  9 +++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ccf85ea79d37..b0f217721873 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -882,7 +882,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 	bool enable_lbrv = false;
 
-	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+	/* Bus Lock Detect in guest depends on LBR Virtualization */
+	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
 		enable_lbrv = true;
 
 	if (is_guest_mode(vcpu) && nested_lbrv_enabled(vcpu))
@@ -5594,9 +5595,17 @@ static __init void svm_set_cpu_caps(void)
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
index 696f1b4b8f8f..1d1ff6ed1049 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -783,9 +783,14 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu __maybe_unused)
+static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
 {
-	return ~DEBUGCTLMSR_LBR;
+	u64 debugctl = DEBUGCTLMSR_LBR;
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	return ~debugctl;
 }
 
 /* svm.c */
-- 
2.43.0

