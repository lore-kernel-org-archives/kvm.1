Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE1282F21;
	Wed, 26 Aug 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783762; cv=fail; b=NWAl0ZAAxtUwwPwt8F2UKUczkxCWzK8Q4iDPLuk9FVS8owL9pT5rx/1pLuOBZVJvbS2PY+HLP8t3yT4EszA7TQSMLmrgzNF9xu9UWm1lrQKZHJmL/Ag1CIyKYgQtDE4x7pPt4E32YR8q4HEW7I/6tlxzzDAifUrBV9SzKkPOPXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783762; c=relaxed/simple;
	bh=Xve535GNuHbgDwzKurttal/ADXobYUY61d6wJ1aLC5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1BwbxKDJy/06TNPT5qdb1ztTckcKFeQEBa7k7zIF8UcIBcQiwXE9nBuK45GtFvcK9c0qr5lDe+ZfkYBtihNGRRD5Pkg3mdOL8OIaP21o/vKGHdpfZIO1aylbZ0SSND1N0oqpSGJN7rPvZQp79aI2FICsT0floIdOo3MouFUF/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zUruKPes; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zUruKPes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAdDRUZhyY6LuUlGIFdr+fwHMVJEZj78g97jipB613WOKr9Xg0Eh9HzCg78YHgCdFtvMSp+79h3XXHDdGTjKmd+AIGzj6IuqTSC2iCQy03Jis0pIujG0oJrQ9MQ7UXM5YUkziV5G7R5KGZatEeFwibAw0qTfU7oygSRDfwJj9jEO6BmwTxZzUeLh7L+dHtxbyxzBX3yeUHAGp2yqUTtnKC5wPST4U4YsyI3dtGPZPhPMJ/c67HBPzEkcLItC2OwSSRWpE9B49qWc6LtzPPTboaZ3S9QbxWTHQdLwuauf2TW9i6k5xpmHxsDRTsrYSAtQHZRvNR0OYupmLh+OdIlG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SabmJBjtvEqPvdS3M58fLOHsMAiWgTF+dwWVG5awNE=;
 b=o0xYRbo+eB6JNyXOObOyAFTB5DtBTaxFIdM2ivDJfSMSt76Sp6zBdw+Jq8p3WVne94HfNydqoGh6EJM85vXooAYfpl2IAPFPbRK5toYrmkQB7Tel9FzUimxdAzpnVTIivGR5mnsMLlRqnjLtyJRjNzzmPOHSSK9pkO7pmsSzrvmZuWaLm+a/ji+SKnnFoAf1s9wY6cN9taTb/AeYgvPnYL+uZjhVg1YbD7q6sVihuE+WYnoVxmDin/PY0FAqXZevruCUny3WldeFJ/k9TTw4AL9E0cXBOijMJYjmZhJd4l2rCYzeUBeotP/VYoeqwzfst+MVvm0cLVaR7YcWplPhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SabmJBjtvEqPvdS3M58fLOHsMAiWgTF+dwWVG5awNE=;
 b=zUruKPesKSG87NXqbsFFHgS3cIttuHbVYCrBujXFwS9LgXsSriJ8f00E25tNqrtVJ2cnFLDe7AtdG0GQaUiOGbSo/2QanlbPzqfXpr1wTvCwQ8wUdTt+wwG8Uglg7/KK6XchNV3s9HhunbmBgZZ44PnMie4vmd7KQCSUX1EzK3g=
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 22:35:56 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::63) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 22:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:35:56 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:35:54 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Subject: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
Date: Wed, 26 Aug 2026 17:35:04 -0500
Message-ID: <20260826223510.3669875-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826223510.3669875-1-kim.phillips@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7424f6b7-cd4e-462c-88a6-08df03c264ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7lkb8rZBCnRpQGWOW86rwYM1nDTN3DQGJTQanLgUHQOi3RHHyR+8dQUBwO6Ymg8DG6/HQlZ1PleKeIp8y1EP1cf63Cd3kMHKalhrDi8wkYwCbLy9oUhGKf2CbF+Zo/OCeMJqU5p9Q4Zd1aJ0JlySpge9hpe50olalB6+N+rizG6zls8JShwXd/UnlA14cFz9PlvHZyKyKcyniwMrc1IUNfAA2vXGjswWtQGqjuqW7VmJdNitC2oFaJZ/Lj8ewO3AyXzId1HMtBG1hR1ukEfW5GzUUDtnWyAXK/L9OKovb8vNPoV7Ky4DGB2BcmubqMsqy3GPc/YipleVYHrD0GfeVXNQ79LRW8zIgvbJykuRykYw3Bwps/4bu6/V4n4MEHGQyMrzxoroXCs5GBO8ix1STl6NJWx04qn6kkPNSQv7+xnBf9wYN2pSz/PJhvYxuCrz2dISYMVsbx+IVWREBM5i1i41TM8jodHblvqWOKHhdwSCmz3Hik/iKh2sOeE7AjaSVf+Prxd+GS5uxm6Uhqcq6apOqsQqVJROb8XIcPnMCKL1H43OpyQRhtYNUofueMRLayf6lsGvaMqkUiVBterS3VJUL4Tww089BznGkU6voBVUUpmvXt/zTb2jp2p4vlPBKCeo4cTLWixhogSn7qe8JR3VAlsFejCeZrjhEtVac16VkTRSX/h3nS+CXJhV9iLwnWI098zD6yC1CyI6sqUcQg==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C1w30POt13Zv4da0LxbQfDd912dsyx/KYV7ftc9QRFJVeFG1CfHrUArWGLSM2Xu5wqIvHn6hjRQ8JgiqulKRvvIoFKzh2Cz0AkU+ZocN/8LVyuBkZf1BUYNdOsfDZBkgVRf5890yu+KVUE01qRSbThS3i4DKkTsc6p4+I2Pxer1WEbGMYZ6YhdzPsIAOwMdxny9MIQ8jjeacITnj7/LgJyAl7hyPbBT6dg6dgvlohQ+5zim3fUrGwwv9EXekIg8FZd5mDO+TzlZ6ki+dF7qxGk1vlRsFGzyWEBDaznd6Jo+k/VR24/pCGugmFQXvGljLkFqOobEiH0mztiNsA1v9+2JaPNjO2e8Hf6gu/oAo5De8E7KCV6CAFmUr0y7daIa2mGbMqkNe2ichV5T7l/Sg5OeSbe8d5kYdrrOjgu+035uw0WsfG+fa/zycf8Ijm6bJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:35:56.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7424f6b7-cd4e-462c-88a6-08df03c264ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

Prepare for legacy IBRS toggling on AMD, where the BTB Isolation
SEV-SNP feature uses it to optimize the VM exit-to-re-entry path.
Commit 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to
support Kernel IBRS") restricted the option to Intel because that was the
only vendor that needed it at the time; nothing about the mechanism
is Intel-specific.

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

In spectre_v2_apply_mitigation(), route AutoIBRS-capable CPUs to
EFER.AUTOIBRS only for the eIBRS modes.  Previously any IBRS mode used
EFER.AUTOIBRS when the CPU had AutoIBRS, which was unreachable while
spectre_v2=ibrs was Intel-only, but would now hand spectre_v2=ibrs the
always-on AutoIBRS behaviour instead of the toggleable SPEC_CTRL.IBRS
the option asks for.

Finally, clear EFER.AUTOIBRS at the top of cpu_select_mitigations(),
alongside the existing SPEC_CTRL kexec cleanup.  head_64.S preserves
incoming EFER bits, so a kexec from a kernel that ran in AutoIBRS mode
carries the bit into the new kernel; without an explicit clear the CPU
stays in AutoIBRS mode while sysfs reports e.g. "Mitigation: IBRS" or a
retpoline mode, diverging from the actual hardware state.  On a normal
cold boot the bit is already clear, so the msr_clear_bit() is a no-op
there.  Clearing on the boot CPU suffices for APs, since it precedes the
init_real_mode() EFER snapshot used by the AP trampoline.

Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/Kconfig           |  7 +++---
 arch/x86/kernel/cpu/bugs.c | 44 +++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..b9a7ddef4cba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2496,12 +2496,13 @@ config MITIGATION_IBPB_ENTRY
 
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
index 48eb1872af18..08780e0d37ec 100644
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
@@ -2166,11 +2173,6 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -2286,13 +2288,18 @@ static void __init spectre_v2_apply_mitigation(void)
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
-		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
-			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
-		} else {
-			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-			update_spec_ctrl(x86_spec_ctrl_base);
-		}
+	/*
+	 * On AutoIBRS-capable CPUs, eIBRS is enabled through EFER.AUTOIBRS
+	 * rather than SPEC_CTRL.IBRS.  Legacy spectre_v2=ibrs keeps using
+	 * SPEC_CTRL.IBRS even there, as it needs to be toggled on kernel
+	 * entry/exit.
+	 */
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+		msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
+	} else if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
+		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+		update_spec_ctrl(x86_spec_ctrl_base);
 	}
 
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -3297,6 +3304,17 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	/*
+	 * Likewise for EFER.AUTOIBRS: head_64.S preserves the incoming EFER
+	 * bits, so a kexec from a kernel that ran in AutoIBRS mode carries the
+	 * bit into this one.  Clear it and let the mitigation selection below
+	 * rediscover it.  This also runs before init_real_mode() snapshots
+	 * EFER for the AP trampoline, so APs inherit whatever this kernel
+	 * settles on rather than the previous kernel's choice.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AUTOIBRS))
+		msr_clear_bit(MSR_EFER, _EFER_AUTOIBRS);
+
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	cpu_print_attack_vectors();
-- 
2.43.0

