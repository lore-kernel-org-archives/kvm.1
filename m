Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1968456DE3;
	Tue,  4 Aug 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887843; cv=fail; b=eyYfnjs82CxzHNHwYUFtN33m2e5r4JqF2BRLmuCusUT348g3CkLOnSNrMqCcfBzXqw/dTvLGKYIR4XUM/0uvIDm1Eqeao7z7aW1vafR63KjFis9eIjr1Ahy2vgj6wEVxPiBfeVTGKe5moKDeUfGFZGGKpINwVQdkb6sgCfYz5u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887843; c=relaxed/simple;
	bh=7Ngs3HL4caSnu12Iv75zKOrQk2GiIb46B33TBHslhPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5Ja/EOxSA/7wDEOpBLVyeNt1GEN73uP9UTjWAuUEJ1kcAP8l3wqcv52Cte+fFsxSYnAKJVvZTBJLNJBpPgGJUyraWfg2TjuAL35gu9Q3kVtkpqd+b5VTvFpdJf+NVHJyh/Pu0eiLOaCHOi25yuCdNBPNH9HnTTDVP3FpsPbino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jyrQCSs0; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jyrQCSs0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kr2wn2uIaKmx4mWpr7jC6+KtHbBWI+QGmD9jdbVpDBVRWDYWAtTGv+L0DmfL0LHXSBHIilnqi43vAM/soNGazBLfk78bSlZMlFzuKERoL5C573yRdUpQjZK2sSZKobF+QqrcWJswszQcfvIxjyKqRvU48PLFy2BTUqBCfYk3eU0qlUlAHKzAXIbQ6P1OOfECT0UmgWskzqOBJbKdZdhHxZhmdvzaQVrcI0bQ1p30Z9JRXabUeH/qwAIAdrnlUmIL1hg6eR/Hbux8QYQf06BwyoclJns360eCnMX1kpLWBVO8Jok3GyF42kFeW0U6MrgJuZj217QobQhpi0faXqojzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyNLICISlrIAc58RX6mVG0RctrL+QA6sCIN49Ijn4Xg=;
 b=PO3Bl7uvnoYn+3WfuFO+nQPjyvLgZjzxMtcM5EJYuDi8/+rY7Hrp9cBT1pWdqMCJTa4GbTR/gTRPIwjmWdZQVJ3dTeQDtmkiXQcML53yE5baKUxqZysNpedNgM3kqSClStXpciRpXk/Lb7PRZj2AFSdbdW9Tc8zB1s2Xj0jmsVgQX5LPpbAOD6fKZ11kcmruX/gfPnlXZisiIhiKLlmczXMNBQ2NrfXO0bOqykMudVb0FlhETZ5t3kQtWyAOaUc4hK/mP3QzoZ3ElKQ13Atj0FwKTtxvH+sNR7WWvEabtHGILp0heBmU91TOD7J3CLSBxnr7nR3JNKE9Sl7P2P3GYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyNLICISlrIAc58RX6mVG0RctrL+QA6sCIN49Ijn4Xg=;
 b=jyrQCSs0HZshtqPu2aiTAHPAC1Q3qO1DvvMwqoDlb0sChmxb+RImLu6UI04FyaWHJa3bbXJXQksB4aNpk/RAdH3FQ/Ld+rOa9tPLJxpzT2ydEGqN6xSgdHBpat8zHxusoKLSKYxwzybxWbc23NcWmOU3Gw6UOmXP7/qjm4eJPCE=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 23:57:18 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::1d) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 23:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:57:18 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:57:17 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, <stable@kernel.org>
Subject: [PATCH v4 04/10] cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
Date: Tue, 4 Aug 2026 18:56:05 -0500
Message-ID: <20260804235611.4053375-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804235611.4053375-1-kim.phillips@amd.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 936dfc12-4319-4fbd-0826-08def2841ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MOwcnXMhPzQypbZjkfxHEnho/1bieVOkkznQ8vrl7HyzMen7HY/DP4GkVdvV/H5/+B0cdBYwrRVOu07STCR3vzJaNVlwOLBRR4m8HuO9Z8tOt7sVKZarGVxDmNeuVof6rI+VQZH0cahM9c8PG7achWHONJ/9AfmddoubNMWYUwBaXh4AJAi0kfmVu6+k/kHlXIsLSf8Q4+S8wc9SLDRsnEmphbXNme7adbK32Jwh2qWKF9hcWP8MTLIGrTs1hHS0sjSuSQ8vPeYTcth/h0h1wSP/aoIJnjuZ7KYjogAafOSK9YnMhCP6gi2lbvfNOQNgWjuxfzjLF7+ZfUzmteKs7UKZMiH4tI5tNB3+kRW7nvgjJ9fELtoDNTzxAQR91V4XjeIaLpKvD9vNpX0LCHv+ly3ERAMK57hMtISjmpIrHtsJ+bTxc3BP27Zy6ilFJIwGdLswJ3G9AF2AL3VKKkmkmjCDgxZty6kyfe8mnJFFx60JihLDwNm7HrsT/zHX/1gzSz4HxhRDb0GvFhudCfj5D7n0Z9WDqSWD6S1eMMlRFMAVd4PpfPuuDmeX7I0QQtTSxLn6PNCa2ZzR/utQwGxGM4BnuRe/XeQhSEwl9wDvPfgv030AG6VuujPxEcLRR814C90jz8+NY3JzwQW5pHoco987QUGktjUQIPy+6gzhRUz9JJ+Nq7yNG1XqO8kU1Ewfd+Wv9d3eWzeCzjJHJRAZjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v8eOm+FX156dpZfuHtlBAy7r2K5SwebnRjPl/Gu1w/z1qGXxsnl49EgRZqXyot7ZCZl2YJYCj8W7MZX2beDhBZsLiCWIu07dXnrUiDBXrj4DUyIHz1a1DWYknpEB1Fjarlc8c+oJXLBJYe2YaEbET1iioQKyOA8oRfU3f2SzOsjnbiydlDHXr10ZhFTx3cxSuyg41a5tKDNVZaxKKYNWKgEN8BVQjQNvth1s4DoXkcilrUlt0WZ/aapBiPE81BUBhwu4UNd/c2R5EUpGbH/9R+2t3WKdy2yFInCdFqghgeyU7MftyRnnsa3uI0qN4bomxpCOR+Qw9e011GkUsfad04WdQW8LIv2rt1AVytkkG//qe+fPyVBO9PU4ptqjn5Gjrc656byvgStK3JlPmXAnA5NqGHi+yjx9hRIKJGALbIgPyG6EVm+w19sG8OLZtgTe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:57:18.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936dfc12-4319-4fbd-0826-08def2841ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716

Prepare for legacy IBRS toggling on AMD, where the BTB Isolation
SEV-SNP feature uses it to optimize the VM exit-to-re-entry path.
There is no reason this wasn't allowed in the first place, hence
the Fixes: and stable tags.

Keep the IBRS-trumps-retbleed logic in retbleed_update_mitigation()
Intel-only.  Legacy SPEC_CTRL.IBRS does not mitigate AMD's Branch
Type Confusion RETBleed variant (RET prediction uses the Return
Address Predictor, not the indirect branch predictors IBRS
restricts), so letting SPECTRE_V2_IBRS trump retbleed on AMD would
silently drop the UNRET/IBPB mitigation that does cover it.

On AMD the decoupling is total: retbleed mitigation selection never
consults spectre_v2=, so spectre_v2=ibrs neither adds nor removes
RETBleed coverage.  A kernel built without MITIGATION_UNRET_ENTRY and
MITIGATION_IBPB_ENTRY already reports RETBleed as "Vulnerable" via the
retbleed sysfs node and boot log regardless of the spectre_v2= value,
so there is no silent gap in the spectre_v2=ibrs path to warn about --
and a warning there would wrongly imply the Intel-style IBRS/RETBleed
coupling exists on AMD.

Also drop CPU_SUP_INTEL from CONFIG_MITIGATION_IBRS_ENTRY's depends
line: the IBRS_ENTER/IBRS_EXIT macros are vendor-neutral, and the
Intel-only restriction would silently redirect spectre_v2=ibrs to
AUTO on AMD-only kernels.

Explicitly set or clear EFER.AUTOIBRS to match the selected mitigation
on AutoIBRS-capable CPUs: set it in eIBRS mode, and clear it in every
other mode -- NONE, retpoline, LFENCE and the legacy IBRS path alike.
head_64.S preserves incoming EFER bits, so a kexec from an
eIBRS/AutoIBRS kernel carries EFER.AUTOIBRS into the new kernel; without
an explicit clear the CPU stays in AutoIBRS mode while sysfs reports
e.g. "Mitigation: IBRS" or a retpoline mode, diverging from the actual
hardware state.  On a normal cold boot the bit is already clear, so the
msr_clear_bit() is a no-op there.  Clearing on the boot CPU suffices for
APs, since it precedes the init_real_mode() EFER snapshot used by the AP
trampoline.

Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/Kconfig           |  7 ++++---
 arch/x86/kernel/cpu/bugs.c | 39 ++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e725b439d0a2..4bd91d41dbba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2492,12 +2492,13 @@ config MITIGATION_IBPB_ENTRY
 
 config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
-	depends on CPU_SUP_INTEL && X86_64
+	depends on X86_64
 	default y
 	help
 	  Compile the kernel with support for the spectre_v2=ibrs mitigation.
-	  This mitigates both spectre_v2 and retbleed at great cost to
-	  performance.
+	  This mitigates spectre_v2 at great cost to performance.  On Intel,
+	  it also mitigates retbleed.  On AMD/Hygon, retbleed mitigation
+	  requires MITIGATION_UNRET_ENTRY or MITIGATION_IBPB_ENTRY.
 
 config MITIGATION_SRSO
 	bool "Mitigate speculative RAS overflow on AMD"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a036b509f0b..245de4ea8d60 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1305,7 +1305,14 @@ static void __init retbleed_update_mitigation(void)
 
 	/*
 	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option except for call depth based stuffing
+	 * retbleed= cmdline option except for call depth based stuffing.
+	 *
+	 * On AMD/Hygon, legacy SPEC_CTRL.IBRS toggling does not mitigate the
+	 * Branch Type Confusion RETBleed variant: RET prediction comes from
+	 * the Return Address Predictor, not the restricted indirect branch
+	 * predictors that IBRS controls.  So keep this Intel-only and leave
+	 * AMD's software return-thunk mitigation (UNRET/IBPB) in place even
+	 * when spectre_v2=ibrs is selected.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 		switch (spectre_v2_enabled) {
@@ -2164,11 +2171,6 @@ static void __init spectre_v2_select_mitigation(void)
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
-		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
-	}
-
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
 		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
@@ -2297,13 +2299,26 @@ static void __init spectre_v2_apply_mitigation(void)
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
-		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+	/*
+	 * head_64.S preserves EFER.AUTOIBRS across boot, so a kexec from a
+	 * kernel that ran in AutoIBRS mode carries the bit into the new kernel.
+	 * Explicitly set or clear it to match the selected mitigation, regardless
+	 * of which mode is in effect.  The boot CPU does this before
+	 * init_real_mode() snapshots EFER for the AP trampoline, so APs inherit
+	 * the correct value too.
+	 */
+	if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+		if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
-		} else {
-			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-			update_spec_ctrl(x86_spec_ctrl_base);
-		}
+		else
+			msr_clear_bit(MSR_EFER, _EFER_AUTOIBRS);
+	}
+
+	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled) &&
+	    !(boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
+	      spectre_v2_in_eibrs_mode(spectre_v2_enabled))) {
+		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+		update_spec_ctrl(x86_spec_ctrl_base);
 	}
 
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
-- 
2.43.0

