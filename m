Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256560;
	b=HUMxwrFfmor4E6Q9gNycYxCl818YvzBhQs+9w6GKhxXZtp2odR0BIYfalUw+PrKLH0OI
	 4O7Yl/OibJwAHDNLnCxv8MzeuneptLlB/YnN2D5pV7MyK4kJRMazx8TMrFCZNRRkyQR8G
	 2GAwOTgZhy0eCAERVdP2OfoJRkOSMqgltT87C0LSDTksZB5QtX2p1Whz4sR13ZJ02Vgy7
	 E5r1/PeskCCYeF37PulKCE40wlQ6g9tu6CZ2Gmcwq9rLZf5CeIYErGLXMLen1LDw/Gzu3
	 93yd6Zp44nEY4+yU3fuiPs1O8oI95zu6one6xtXXMWz34GAs7L4jcJnhi6jcejShtoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256560;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HHK2j6C70814ed+SeZ72BzLXfkGIHDIDnhaf+wnb4K4=;
	b=unDBRSMkQyW8Yt3Vpms8OPmIVHFkfHqgaR9GoCaKJtx97PooqQ9mWMcNMnV8+i2o7J3f
	 0JAaOhs6sPDNLLL1sJj14iHLrtgph6Gm/LzxjK3SB63T5r6BJlsVbAj9rKol8sLGbdKVz
	 6O4G8T0jgKOtR33l0HWalSSH/K8yvmWBcJAi17sbB+rq3RbOF5X+++hLmoZGF3KddgIuh
	 6lLy4rcjmFkkqzVtC1eMl0CjriAOlAP7a+SSi17gpHp9fHL1OccXfR7EQNRaRy5SKcGkN
	 5aTnurE2LEsQJJaKHNYL5koNLhyAbPCx089im5aErF/N/MVVd5LhnFthva3iHRepoiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=COcyqUh0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.54
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC21606A321;
	Mon,  9 Nov 2026 20:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC21606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=COcyqUh0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBg3S+uAiWM3pys09JuNM1P5RTsxzJJP1OlWiPREzU0/jYmC7Y82gYDEbHbQCNPL/4KFQx4rz8Vdvr0gGvVIgU2migct9XAX19fu+SokByE8zoNGQd8WRfw7G04T+UEVPY3Da9r7Zwr4DkrwJCm0Be2Rs9cTXKybLv9R15RvsjWqqw9qRE/V8DnwuaV+4XeydIWbPo2hOqg9ju2hgEAU1yaYeXtlccp9rVg+vyejPh38qO9mRnx6SvmUeszpCC+hL2q7+owcr6LFKe2qbrh4ClIdTykXWRf0fspfMylGslNErLSy+Rj5I1cqplqJJLS6rYTiX6ipfgBzr9elstFuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHK2j6C70814ed+SeZ72BzLXfkGIHDIDnhaf+wnb4K4=;
 b=IbbRNmsuhNnQjM3NDoxjV73VIu+ucFhu4m+VHEp5BKPpUMllXxLR7+a41IQTCrpH1sELpZ75yctTG5xGwnltKVF4WPWM9d5bmMDXcUs2IBLSy+tjc6ldlg9YJ6nDI5fzNHxXPaaj+9YCn6Sk/Kc2mKuOOn3ZXTtFJQJsUKaJ9wqJbKlWqzE/jFP8JWOpvGj10q7OWt8ocgB3cimZADkV+9LivnRPNT9/pjWGb7+uBdl8FGcrF9RonpkKL2N1ZSPZNKooR7ovtx84svVUdXqmM/Kw0sHUlYFo6wBFv59u5WqDUcE7pHUpY4jl9Z5Py+BotXH3ysMYH97WsuTLhpnT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHK2j6C70814ed+SeZ72BzLXfkGIHDIDnhaf+wnb4K4=;
 b=COcyqUh0QBHdtKigp8E6e6e9vCjdHSEvLJIZLKixCcNIlLqLt+7dmBKlaNRuIwRoe78W+p18KusrLjEVUDqFxCYlgCMJjQmSAIK0ftX11s7Ar65gxzrXm19/4UIUJR/f1/M300xJyGrHUYZyOnSIP9NcJFYTHY/EbrUIKHg7Eyw=
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 20:35:50 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ab) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 20:35:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:35:49 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 14:35:47 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v4 2/4] KVM: SVM: Add host support for Enhanced SMT Protection
Date: Mon, 9 Nov 2026 20:35:12 +0000
Message-ID: <ea20a52f49c15a4b59fc64f7791c9834e52d757f.1794244450.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ad171d42-ce4b-4d69-5949-08df3ea10a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|6133799003|20046099003|22082099003|10067099003|18002099003|3023799007|261102123227099003|261021121427099003|261009223027099003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|56012099006|11063799006|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Dtr7GUJNsagWGEr9rkhTvx2+o775TVKkLzX9FLmRZ+4XZWD1IAr0HCN02CgehWrxTOAXFjYnbFGRDhaJbCKPcQTQaZjjiHTwdXcRHAcZpdE9lQsS4xU1rkIFg/ruFpTb/V6mRYePonBGn3PmQmMhXJDLQRKA/dOlByQGlpG2FxYfUrFNxxTkkj868yUsj1OL+ZoSr8JtdkiQa8SvvVL0W9f5AtoTnAWVgfky4hVx3F4aEgYYX634mQAGyHJYT9lCNmHDLB/s6BorEQMuE5bPuAWZsy1WYRQMmp8l6UJuugSjUr14tl/QqzH+Mzpu/GcMIkb0/ISO4vJZwM2o3uGP/FO4q3eqeW97gc6tEarJji7QM717fBJO2d5/ZK1AceCG73emWPs+WP5THN+jPfP+E9Gb9Tdrw5M3NBBFf2OnTE1mHHQUKNxKrTb8/BctFKdOzCumazppjDCxterdHzZqfAozTvXc/y9bIJl8esy/sJsx6SaLNud3cArNtABkTogpSyHqATXYy6q2HIZE+zEHVSxAjgMogY/b1YEYtXcX1my11jiPrfTyTTQWQSF5K32gjrZ2vplbDY0LH0HSyLfDsY0vYGfqIRqJKcs0/axhpNzdkKZ9M7SysST5V47snZHmch/fOMhp7dZ9U8zOe0ElTcqQ4nek43P/XeNlb7M1j1F+G8PDB2gEKTMSuhW+FzR5avQQ8fBfhCUbIb+f+prMIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(20046099003)(22082099003)(10067099003)(18002099003)(3023799007)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(11063799006)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bc9MTeWBuwMNh4yVoZ/gvmbl1w9Qs0VwJw2GE+GFZy2JPikWwG5WM6pOEE7nJ+DLE2RQvk8RrXYrNrPm2FhyYVqYt1Wu/soraCZzP8prbuTmKeMzOhbjDVlOR1WEho0DTqwKmLUI6v9iJ2KUT66ts97ti6JjF6yjXSEMpngbEkJse0AyWAY4plXl5LWQ5Fv+NgmGiAHH+xEIjCSgY4laH/oOsFfZiROhLYmRg1YsTHqwIbaZAa8TYgZft0WZNxY5RbPsEj7hGfxIM7StwOP08rWUGAje14ZjR6r6oo8hvWdArye8td1mJupRymBjweftrmsl+Hxzc/E7JU0mz4dA3IcSnTLEpbkXBgqJUZERkGZ1WFpeBduv58PIx9jkPdREKJen39TOAHmF6m+JO2deZxhBlrH0Om3KXlJFBePoCnTWuVpXxIOIFLBYGv0VeFE6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:35:49.1999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad171d42-ce4b-4d69-5949-08df3ea10a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

Enhanced SMT Protection (ESMTP) protects an SEV-SNP guest from SMT side
channels by requiring that, while a vCPU is in guest mode, its SMT sibling
thread is either idle in host mode or executing a vCPU the guest has
declared to be a legal sibling. A legal sibling is another ESMTP vCPU of
the same guest that carries the same VCPU_SIBLING_MASK and agrees on
VCPU_ID outside that mask.

Hardware enforces this at VMRUN, which no longer enters guest mode right
away but stalls until the condition holds. Three new exits report that it
could not be met, all of them non-fatal:

ESMTP_ILLSIB: a sibling thread is running a vCPU that is not a legal
sibling of this one.

ESMTP_TIMEOUT: the stall exceeded the timeout programmed in the VMCB. The
timer bounds how long VMRUN waits for the core to settle. A module
parameter exposes an interface to program this timer.

ESMTP_RETRY: If DBREQ is detected, VMRUN exits. ESMTP_RETRY indicates an
internal event and the hypervisor should execute a VMRUN.

Refer to the AMD64 APM Vol 2, section "AMD64 Enhanced SMT Protection".

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de> # non-virtualization changes
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v3..v4:
* Fix conflict of reserved bits introduced by PML support in
  vmcb_control_area 
---
 .../admin-guide/kernel-parameters.txt         | 19 ++++++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/svm.h                    | 12 ++++-
 arch/x86/include/uapi/asm/svm.h               |  9 +++-
 arch/x86/kernel/cpu/scattered.c               |  1 +
 arch/x86/kvm/svm/sev.c                        | 48 ++++++++++++++++++-
 arch/x86/kvm/svm/svm.c                        |  8 ++++
 arch/x86/kvm/svm/svm.h                        |  2 +
 9 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42ff19defe16..55a5471cc88f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3269,6 +3269,25 @@ Kernel parameters
 			max_snp_asid == min_sev_asid-1, will effectively make
 			SEV-ES unusable.
 
+	kvm-amd.esmtp_timeout_ns=
+			[KVM,AMD] Enhanced SMT Protection (ESMTP) VMRUN
+			timeout, in nanoseconds, for SEV-SNP guests that enable
+			ESMTP.  When an ESMTP vCPU executes VMRUN, hardware
+			waits for every sibling thread to either be idle or
+			run a legal sibling vCPU of the same guest before
+			entering guest mode.  If the wait exceeds this timeout,
+			VMRUN exits with VMEXIT_ESMTP_TIMEOUT and KVM retries
+			the VMRUN.
+
+			The value is converted to TSC cycles and programmed
+			into the VMCB when a vCPU is initialized, so changing
+			it at runtime only affects vCPUs that are created or
+			reset afterwards.
+
+			Default is 0, which disables the timeout, i.e. VMRUN
+			waits until the sibling condition is met or a physical
+			interrupt arrives.
+
 	kvm-arm.mode=
 			[KVM,ARM,EARLY] Select one of KVM/arm64's modes of
 			operation.
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e2c21e58190d..64ca8cc723c6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -532,6 +532,7 @@
 						      * and purposes if CLEAR_CPU_BUF_VM is set).
 						      */
 #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
+#define X86_FEATURE_AMD_ESMTP		(21*32+21) /* AMD Enhanced SMT Protection */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..fbcb3313e946 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -761,6 +761,7 @@
 #define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
 #define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
 #define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
+#define MSR_AMD64_IDLE_WAKEUP_ICR	0xc0010137
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 83fd49b26a4b..8adf9b3cb08f 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[128];
+	u64 esmtp_timeout;		/* Offset 0x148 */
+	u8 reserved_10[120];
 	u64 pml_addr;			/* Offset 0x1c8 */
 	u16 pml_index;			/* Offset 0x1d0 */
 	u8 reserved_11[526];
@@ -314,6 +315,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_ESMTP				BIT(17)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
@@ -486,6 +488,11 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	u8 reserved_0x670[560];
+
+	/* Enhanced SMT Protection */
+	u32 vcpu_id;
+	u32 vcpu_sibling_mask;
 } __packed;
 
 struct ghcb_save_area {
@@ -558,7 +565,7 @@ struct vmcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		744
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2216
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
@@ -593,6 +600,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x670);
 
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0x0);
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0xcc);
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index e80676185092..141386d680a0 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -136,6 +136,10 @@
 #define SVM_EXIT_SW				0xf0000000ull
 
 #define SVM_EXIT_ERR           -1ull
+/* Enhanced SMT Protection VM exits taken during VMRUN sibling sync */
+#define SVM_EXIT_ESMTP_ILLSIB  -5ull	/* Illegal ESMTP sibling */
+#define SVM_EXIT_ESMTP_TIMEOUT -6ull	/* ESMTP_TIMEOUT expired */
+#define SVM_EXIT_ESMTP_RETRY   -7ull	/* Internal event; retry VMRUN */
 
 #define SVM_EXIT_REASONS \
 	{ SVM_EXIT_READ_CR0,    "read_cr0" }, \
@@ -248,7 +252,10 @@
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
-	{ SVM_EXIT_ERR,         "invalid_guest_state" }
+	{ SVM_EXIT_ERR,         "invalid_guest_state" }, \
+	{ SVM_EXIT_ESMTP_ILLSIB,	"esmtp_illsib" }, \
+	{ SVM_EXIT_ESMTP_TIMEOUT,	"esmtp_timeout" }, \
+	{ SVM_EXIT_ESMTP_RETRY,		"esmtp_retry" }
 
 
 #endif /* _UAPI__SVM_H */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index b18cc9c88dd5..5648a632e6d0 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -68,6 +68,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_ESMTP,		CPUID_EDX,  1, 0x80000025, 0 },
 	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6427db390b1c..71f22356c4c5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
+static unsigned int esmtp_timeout_ns;
+module_param(esmtp_timeout_ns, uint, 0644);
+MODULE_PARM_DESC(esmtp_timeout_ns,
+		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (default: 0, timer disabled)");
+
 #define AP_RESET_HOLD_NONE		0
 #define AP_RESET_HOLD_NAE_EVENT		1
 #define AP_RESET_HOLD_MSR_PROTO		2
@@ -520,7 +525,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~(SVM_SEV_FEAT_SECURE_TSC | SVM_SEV_FEAT_ESMTP);
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
@@ -1035,6 +1040,15 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 
 	save->sev_features = sev->vmsa_features;
 
+	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP) {
+		save->vcpu_id = vcpu->vcpu_id;
+		/*
+		 * All vCPUs of a guest are put into one group and can be run
+		 * co-resident on the sibling thread of the same core.
+		 */
+		save->vcpu_sibling_mask = U32_MAX;
+	}
+
 	/*
 	 * Skip FPU and AVX setup with KVM_SEV_ES_INIT to avoid
 	 * breaking older measurements.
@@ -3281,6 +3295,9 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP))
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_ESMTP;
 }
 
 void sev_hardware_unsetup(void)
@@ -3312,6 +3329,31 @@ int sev_cpu_init(struct svm_cpu_data *sd)
 	return 0;
 }
 
+void sev_esmtp_enable_wakeup_icr(void)
+{
+	unsigned int cpu, sibling, shift;
+	u32 core;
+
+	if (!(sev_supported_vmsa_features & SVM_SEV_FEAT_ESMTP))
+		return;
+
+	cpu = raw_smp_processor_id();
+	shift = topology_get_domain_shift(TOPO_CORE_DOMAIN);
+	core = per_cpu(x86_cpu_to_apicid, cpu) >> shift;
+
+	for_each_present_cpu(sibling) {
+		u32 apicid = per_cpu(x86_cpu_to_apicid, sibling);
+		u64 icr;
+
+		if (sibling == cpu || (apicid >> shift) != core)
+			continue;
+
+		icr = (u64)apicid << 32;
+		icr |= LOCAL_TIMER_VECTOR;
+		WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_IDLE_WAKEUP_ICR, icr));
+	}
+}
+
 /*
  * Pages used by hardware to hold guest encrypted state must be flushed before
  * returning them to the system.
@@ -4835,6 +4877,10 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 		svm->vmcb->control.allowed_sev_features = sev->vmsa_features |
 							  VMCB_ALLOWED_SEV_FEATURES_VALID;
 
+	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP)
+		svm->vmcb->control.esmtp_timeout = mul_u64_u32_div(esmtp_timeout_ns,
+								   tsc_khz, 1000000);
+
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
 	svm_clr_intercept(svm, INTERCEPT_CR4_READ);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 61e798d02db8..03547d007811 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -603,6 +603,8 @@ static int svm_enable_virtualization_cpu(void)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 	}
 
+	sev_esmtp_enable_wakeup_icr();
+
 	svm_init_os_visible_workarounds();
 
 	svm_init_erratum_383();
@@ -3853,6 +3855,12 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 	}
 
+	if (svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_RETRY ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_ILLSIB ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_TIMEOUT) {
+		return 1;
+	}
+
 	if (exit_fastpath != EXIT_FASTPATH_NONE)
 		return 1;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b9f7786bf17c..55d530d9e7fa 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1020,6 +1020,7 @@ void __init sev_set_cpu_caps(void);
 void __init sev_hardware_setup(void);
 void sev_hardware_unsetup(void);
 int sev_cpu_init(struct svm_cpu_data *sd);
+void sev_esmtp_enable_wakeup_icr(void);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
@@ -1048,6 +1049,7 @@ static inline void __init sev_set_cpu_caps(void) {}
 static inline void __init sev_hardware_setup(void) {}
 static inline void sev_hardware_unsetup(void) {}
 static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
+static inline void sev_esmtp_enable_wakeup_icr(void) {}
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-- 
2.43.0

