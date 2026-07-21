Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F03403E1
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610453; cv=fail; b=q7pdLVXliqKpisfJ3juWagRP9XXe8fqaVJsxE0ZENLZ0lWNUvsvRMYmw/MkDQsTU3LcjIPauUzT0JddkfdVq4luXTV/7fEgoj2wiUw1tY663Gq6aKf4ZdNTabhih25JaQHGuLci3AZrbNJ1uRrQV0SlQdOZZh3gyzzbL2XZfAKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610453; c=relaxed/simple;
	bh=Rn4bL06Mt8RI08GuIiqo+yrAvbZj7dfVbZEfxhIxqvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdHMDqF9sS94IVPqS9ZVwch9f8PqLS5b7TKPG3wda76hE1cGyK1oYAYWyb2fFt4KUs/3+oQyGzWpL+WQMwKOK5gWFaXSLybsMMaAbk/JRFH6Rf40B3QX6WVzPtJFwggNzYguEvqz98kf/v2heeqEj5559DSJ+7EXNJkhubUtPjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0rK5ZgE3; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0rK5ZgE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkreOn7hIxEBBUjWzG91Cq2eJB5zZ3XJDRdZcmx6zk/EFBS4gbdOkVDPPEYHl2/4GWGdjp0uiCCggEpyw8GqIS/zSKavA7bthakZiVYED+8tFE7xsmaY2hHWnCOh1B5QH+ZVCuqu+O8/WfgC3Yw02v//XKnCbw5Ru3TplFHXp3M2oBILjazk+fp0hPUJp/EdDEUaINFaT2NyjWgKUQFb2frWF4TDmLA0qfoTz6ex4leVI1dzALONwAg8QXIbu2i0hUlq94nOzpYPwSQCVZzSaeM/BINEsVJCIUtTwzwmqhr3Q8hwLjiJR21p8teVg6qQApb+j4Gg1rtq8weoh2Firw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6HEm2IonIm8ZxjjNyz/Rw5sKEbbspjN3njft0LDm8k=;
 b=ChAp/l+AmNOyIo32WlICNN6Iyl7dHPHVVKU6usXJGnT4LY1FcSP6+XtxZYYAsuikdlaxzY/LhX6VrjG/iN+WU03vCfqi4fKdTrpcjJgcgCRwWv3S3EPpCLm6cdeduPdslmjYxSAmX013zmqb9TaBcw31YluE5sqpD/P2RUF8r2dweOKwtnNniJ7SfOqDJbIcEDulS2geDwE1mJsA+cUa727MgsrfFh8xxIU8+/M6Am6AzGVEatR8RgV0H+6jW3GqQ/lWMzrDnCKsZZv98kAZ9iD+KxRm6ab8hPJ7X0H744pky0pwJGucpFGselPIBTOXh5+9tJBlSKoWIVXif3md1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6HEm2IonIm8ZxjjNyz/Rw5sKEbbspjN3njft0LDm8k=;
 b=0rK5ZgE3Us6eLtCqMk+NOZWO1Fb13uziPp9dj2vdodhr2sOgf2EaEo2ZNKbmHGZNxCpYwBhf4akgecqbqZwtbmknn/4gGbD6OJObvYbPxFnPnqiagpMySU5Yd3nHnQFftDLF0qfxq+dqAEs/7THjl35rOPKWrjWG8YO0ho9PKOM=
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:07:27 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::9e) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 05:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:07:27 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:07:23 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 4/5] KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
Date: Tue, 21 Jul 2026 05:05:59 +0000
Message-ID: <20260721050600.87268-5-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ff6b6c-b479-4fa9-0fa1-08dee6e5f58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9yAjJwWKcY/UUrESMvq9J548Vcsl/WrM/9kbFZwxiBkffhn67sAULf96EJDzp96RoF3AS7g+i0baOmnaQHvRcyT/s1bldo2vH/Rc/vWuFngzZ49dVkTft5l5KFZViyz1HIKIO+SucTywLRZsZRyYyTBWHSk/gkGyI9WPDR5XXSm7ybORuCeVt4f/iM83lwjLmEEUvgWiBfo7dUISMjbD7x6xXsjIrpRBhTF2ksJt6UgojE/sjwWw8hkR4T6H/RBJx6Cd+mJSQNzKyPkH7oEaNgt3bl1BGGfpmwSXfpCySWjDJLS45+Iu6ts+FSvMNXUAYJ0gC8rIxOOzQpuRWEWMhxvmZ+HUDC2VU7lCSSPSG/B0IyaLNgOo+3fyC6cI2hiBI+Bg8e/N4KA3gayQmhh3GhA+eFfL7ak1ui8bFTgXyFLtoxoIdYskYoJgEwHxIhgRyvU7fDhuSRkMbUzFZPvNjVyNI+eT5hLunKR5gJo5c6w04qrjp192woPCC/mRaTt3Ik28tGIcxaSLrglR1+sFAgQBljGhOPHO2fTi2ScSaOB8FDmZmgfmPRfARjyU9kjidqXXTVhNhLfkBLYga5Dan7+r3i0V11wYi5zmGNivjCBgMVmxDXT9BJl8Z19aH4HOFvwfCdt5mKsb5XeUKkl4vczsNWBb5jBwU/bAi3Dg4gW88foYM0h9jNYkJgZznFQl5j+Zm1/YPVsT+wPk0PsyYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3rnrUpl2wew3xQy3T1RQ8bkAer8XrsyXhKZyskMW1ilyOMmRKW3fJ86dg02kOp27MS4R0k8/6CdsCTMAPc99BsH/TP3ENykh2eXYdqJiEtT3SOeZ0NnqRsXg5nmUDtBsWWrsK5SMwaZdvihGJtFIvosaa9MX3jGI2ZvvKv1v0uy/ybmDlt3hbc4MP11TkkIQB3g1XtdmlCrXmTbA9sSt5WaqQmNGHpWOAus+DmvhLXMDr6x46asLu2qGhpPpRjbae6N3TFYQfTiKkgqvnZ9Lx6vgXmtXdFYg2/wBfxZDx+qvACfaJCTGqjpyGBuzG6IoNdGpwrbEzNwAnX8QxrDPSh/+3OA83ak3slLzkWe4sm/O3ZVe9OYcaoBnjxoD8kkTIwJ0TPpxjnfnoqkzBDi4ed4RjKYSgVweIVGsEj747vWhOTLiTebN7ClQAM4rOVI4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:07:27.3425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ff6b6c-b479-4fa9-0fa1-08dee6e5f58c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015

Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
svm_get_debugctl_reserved_bits(), and plumb the vCPU into
svm_copy_vmrun_state() so it can be passed to the helper.

The vCPU argument is currently unused (marked __maybe_unused).
It'll be used by features like Bus Lock Detect.

No functional change intended.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---
Changelog:
v3 -> v4:
 * Make it a pure NFC macro-to-helper conversion, and move the
   BUS_LOCK_DETECT gating to patch 5 (Nikunj).
 * Dropped Ravi's Co-developed-by/Signed-off-by, because the
   entire BLD gating is moved to patch 5. Collected Reviewed-by
   from Nikunj.

v3:
 * New patch.
 * Replaced the static DEBUGCTL_RESERVED_BITS macro with a per-vCPU helper
   that gates the bit on guest CPUID.

---
 arch/x86/kvm/svm/nested.c | 8 ++++----
 arch/x86/kvm/svm/svm.c    | 7 +++----
 arch/x86/kvm/svm/svm.h    | 7 +++++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9b1afa47c54c..dbde186ccb81 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -820,7 +820,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		 * svm_set_msr's definition of reserved bits.
 		 */
 		svm_copy_lbrs(&vmcb02->save, save);
-		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		vmcb02->save.dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
 	} else {
 		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
 	}
@@ -1203,7 +1203,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save)
 {
 	to_save->es = from_save->es;
@@ -1230,7 +1230,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 
 	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
 		svm_copy_lbrs(to_save, from_save);
-		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
 	}
 }
 
@@ -2071,7 +2071,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e9f2456982d4..ccf85ea79d37 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3164,7 +3164,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
-		if (data & DEBUGCTL_RESERVED_BITS)
+		if (data & svm_get_debugctl_reserved_bits(vcpu))
 			return 1;
 
 		if (svm->vmcb->save.dbgctl == data)
@@ -5037,8 +5037,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(map_save.hva + 0x400,
-			     &svm->vmcb01.ptr->save);
+	svm_copy_vmrun_state(vcpu, map_save.hva + 0x400, &svm->vmcb01.ptr->save);
 
 	kvm_vcpu_unmap(vcpu, &map_save);
 	return 0;
@@ -5081,7 +5080,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, map_save.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d52010e4de97..696f1b4b8f8f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -783,7 +783,10 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu __maybe_unused)
+{
+	return ~DEBUGCTLMSR_LBR;
+}
 
 /* svm.c */
 extern bool dump_invalid_vmcb;
@@ -873,7 +876,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct kvm_vcpu *vcpu);
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
 void nested_svm_vmexit(struct vcpu_svm *svm);
-- 
2.43.0

