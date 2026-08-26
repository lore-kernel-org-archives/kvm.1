Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C103AC0E4;
	Wed, 26 Aug 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783744; cv=fail; b=SN6qU2X/pZamnss2N6WsE6etw+xTGtHWZe5Zq350J5uMkR1BRiKYW2SKc8h0DeKYf/c5URzzqXz+B6UAGyaBsevRsxEikQ4npAQjEZctU1V1pokBL1uLUxfEDhWf4wUTKzxoL2QiERE+bzOYRntz1+aknm9KAn4Xpk+p3HruXt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783744; c=relaxed/simple;
	bh=UEir/nSH3bO1W46kCmG9FpD6R1R/brtHQGRJbDZmI7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTR866sTFyW45hPYNKtzC8Yk8ARKj+o8c1m7/ET8fkWFN750olVJ5h89EH1IvjOcGPzjrK3g+9dXMV/a8vN5zcGYUm6Ol2CHBQy6CEb6v6u1TwvzmkTZFcagNF2YQJAdIa7On2ggB6Dt42UlmhSwgBO/8E0MtG2+SPBTjrLXVfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mp2vcOmb; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mp2vcOmb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG+FprFR9R4QK9gWEa7Ch6RY9uSKklGxakiZpzfKJ1AfXsiVjdFWWzq/FiS2k7X+qPob70738SzeD2tDxO4b+AoCpo9zqWKEuvZ7GS5ZBBVJqgL2lFLedNdpYmrcqOCcohnPwVkmYyR5nzIGzpb+HRIQgzZCmS7mUyLR81VTa+SG9qL9ob1kUBI90pLn8P+w0fXYSnEQOvkKFMCurmH90ZqFSHOn9k+PkAFDIp1K/4YdVyRQ2ORyv5qKxX3KOlHupsYpn2ENOkYyJISCrHGcfwzN5nut9HMpqOWHzBSHwfUYic3K0+/DflDhWDDPnW8JrQxafWJocJYKLpfXe4zykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCJlwxfxiP4kCiaL3StqA6BJ4EyfxLwIgXExO2RsrqA=;
 b=aMEWjY9QKKbO2rdDWfpNRHu0osD8oLACjTnkOAr4vPKvI9m3bl9o5pvBHU0oYsEya5fiT4RX1z7KO8PpAVAr63ETTzy7xO6PwrW3gXE+jdQa0uyTfIQ9tGDu/LOaCeEAipGKHzbeqb23mpCvhPu9wiVpdKpDEMUgYnTfRhdEyL75Y/1ZfJ0aKcbXI1tQxsNw7YKlyTysWmG+zWKatd57rlUYSfuVROBzzjakpjl6dOisoDBjv03duDOP/DrgblcPjoMiJQvEJ4x8j9PVnX2mI8KeqpKRnR3jQ8EgbJHCZSqhVQZr5l0vQFkO55DUNm/UDfaAU6ZhxEWDwNCId2bViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCJlwxfxiP4kCiaL3StqA6BJ4EyfxLwIgXExO2RsrqA=;
 b=Mp2vcOmb/O9SNFKUZU25OByrBpOvP3T31VFD1PPnwqn79rL9/NcXeKhS1una3IPcCHQ6OCgwMq3uUZBmTf4NvOertWPyJMttCWxdaYKO7kRYXI9PLOftzhDGkhTZv27NNLO1ZliMbqjVFWgFmsme8mCxwn+EYQmaOEhvIsMBnKg=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 22:35:39 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::69) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 22:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:35:39 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:35:37 -0500
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
Subject: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP active using spectre_v2=eibrs
Date: Wed, 26 Aug 2026 17:35:03 -0500
Message-ID: <20260826223510.3669875-2-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 797bc31f-797b-45c9-f029-08df03c25ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8FuIYIDv0T2v8L6pqKgUjwVfkaiPEUAPQfFZVu/Pg3vH7e5uopUjxtLf5ncdkDKmmaaVPPphoixN7QpwxOyHLRCJt05PqH6kyAcABLDRlPxhzJ23mqAtGoib5uKqFXnNB9X5rAgkfEr0ua2C1mV7QjMS6GPC9emGow8Zy+HSVE6kHpQavfV/ql9YimCn7T/51Wtb/GsqnYMbwVVZbX2DrFB6eSblPKTn1DWBXXD0ZJjcwIcP/x1wrvYy5cvxcURQnptnIL5hAjjp/CFWGHBI9zHv762L9x5Fid51rjJ++xi3c6dBlfaEZKSfklc0ThoGsg0rlKxaLG9+1f08GJlNpabsfJT7yR2406bhfnRvk6h8Uqmv8Ec53hdhkEQVBH9j7Fj0cnEV0GXImdEscdaYMM3wVICjbuVCQUD/tN50Q1qOnIsQ2EEuo8uGiByzPC4JFPpw3jBObTU2ZUgCQbkXmo6o9HsArE38VvSrGqkRjzZAR42dAtlN2g6YOyX5+icc/rGR3v2Qjk7jJN/JG5724pPqXELGJalK2z37xGvRNUqlyABlN89bMqmUBSAmqWZ04C+n4yzlzbdlMBFafAKceV8JIYbz4AqXh5hViuXLlJvXa0/7tjzKToemTIN0O/4RM5Iiyz77IMiwZtvDge9ahTJCeDphkxP1zeLD26kenpZY4BRDqlu+l2dN94YvJfj/S4YgJxBHoCzLXPdRwkmMsw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9YVNFW+W5j1NAPhjIrHRvwtKUqb8o10F2Ql46ehkomWIsx16OE970FQIycnPolBdeQ7JOgUVCBtb0zeT0wc1gUodMbyrkcSXIUfpZSyF8XzCZ67ZUjmTzvV8yTGpM+T4qFG2je6RBPGxLDP63U/lGtmhxFPl5dXk5JNt8dvZ8WppM7mf+1FPWKEt4TQHnKSq03HzMIKu6O7W3Ozhe8FLHlCZ5W/foYphF1TBnDR88l80DPfYMK5ONPM8es49pB+rR1Q6eIjU0V+1cB8TB1wE6jYFQdPuQ9sGeCYAdERgaNQU1CBz7kXudIoWnIM/yNXhi4pstL5lFz0rm21Kw2Y570Wl8nZAFD4SiJBCkLaGumhdQynntoL2cHpltWMYDY95puZBPwF7hwecoQTnUaztYK5FkFmwsUT2cimP82I4hchC+Tby8v1VlP/lMMMIF3eU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:35:39.0749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797bc31f-797b-45c9-f029-08df03c25ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

spectre_v2=eibrs currently enables retpolines when SNP is enabled,
instead of AutoIBRS (EIBRS) because the commit that disabled
AutoIBRS if SNP is enabled stopped short of enabling
X86_FEATURE_IBRS_ENHANCED.

Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
decision to switch to retpolines in the default/"auto" case in
spectre_v2_select_mitigation().  This allows the existing
spectre_v2=eibrs logic to work as intended.

Condition that switch on CONFIG_MITIGATION_RETPOLINE being built in.
Otherwise spectre_v2_select_retpoline() returns SPECTRE_V2_NONE and an
SNP host with AutoIBRS available would be left completely unmitigated
against Spectre v2 in the default/auto case, which is worse than the
userspace indirect branch performance loss AutoIBRS costs.

Also emit a performance loss warning for using AutoIBRS with SNP
enabled.  AutoIBRS is activated for all three eIBRS modes via
spectre_v2_in_eibrs_mode(), so use that helper to cover
spectre_v2=eibrs, spectre_v2=eibrs,lfence, and
spectre_v2=eibrs,retpoline uniformly.  Word the warning in terms of the
eIBRS mitigation enabling AutoIBRS, rather than naming AutoIBRS as the
selected mitigation, so it reads correctly for the ,lfence and
,retpoline variants where another component is also active.

Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/kernel/cpu/bugs.c   | 15 ++++++++++++++-
 arch/x86/kernel/cpu/common.c |  6 +-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 56eac5611c31..48eb1872af18 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1672,6 +1672,7 @@ static inline bool retpoline_seq_enabled(void) { return false; }
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
 #define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
 #define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_SNP_PERF_MSG "WARNING: eIBRS mitigation enables AutoIBRS on SEV-SNP enabled CPU, this may cause performance loss\n"
 #define SPECTRE_V2_IBRS_PERF_MSG "WARNING: IBRS mitigation selected on Enhanced IBRS CPU, this may cause unnecessary performance loss\n"
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -2194,7 +2195,15 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		fallthrough;
 	case SPECTRE_V2_CMD_FORCE:
-		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		/*
+		 * Prefer retpoline when SNP is enabled because AutoIBRS
+		 * degrades host userspace indirect branch performance.  Only
+		 * do so if retpoline is actually built in, otherwise AutoIBRS
+		 * is better than leaving the system unmitigated.
+		 */
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
+		    !(boot_cpu_has(X86_FEATURE_SEV_SNP) &&
+		      IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))) {
 			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
 		}
@@ -2286,6 +2295,10 @@ static void __init spectre_v2_apply_mitigation(void)
 		}
 	}
 
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    boot_cpu_has(X86_FEATURE_SEV_SNP))
+		pr_warn(SPECTRE_V2_EIBRS_SNP_PERF_MSG);
+
 	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
 		return;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7352827f491..c568d74282a8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1496,13 +1496,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	/*
 	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
 	 * flag and protect from vendor-specific bugs via the whitelist.
-	 *
-	 * Don't use AutoIBRS when SNP is enabled because it degrades host
-	 * userspace indirect branch performance.
 	 */
 	if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
-	    (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
-	     !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
+	    cpu_has(c, X86_FEATURE_AUTOIBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
 		    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
-- 
2.43.0

