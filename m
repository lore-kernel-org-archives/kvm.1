Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679F456DE3;
	Tue,  4 Aug 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887822; cv=fail; b=BNTTgnG2NsjGKoclf0fw9zBRHrNU3wFUDivhyiHaGPGfc74imLdJaOBBn5PBxxzUaISvLXdI6NRjrEwntLDH17ve3FQEh5w0F2xPUv0jBS5HpfuY3SgTTt6ocA0T33KiU870/yLK2FunJcb9IIABECABVo2PjWnojE+re/Ovzs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887822; c=relaxed/simple;
	bh=p3tBq/rEX6/LaBei5RzQNN/cymPHYOB3s6exCj4/dRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB5NIn+gmYaWRPirpgtimn5gRlSHBu548UbE+lCIG24DMD6+Y6bWDHc0LGCc7oGBs4n5Ob3hhEZOMN4q3YIpp1h2mhmQchP0ES+RDUFCB+VQ1neuNJ1+fap7eTCk4uCS41swnK2sCR9/qIiYrK8WWdjMuw7GsPYgDhiJLvH242E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WQnFV07r; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WQnFV07r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHy3h9UeqlUdtlD289NsIHOSfyasfQq205tI13qsMcm6kjynGWfgEKijJvd+pXuakNk9tiBPE/Y1bj7vr4sbcBGOq/kXLr+1a8eR6OZUMeNios16xcUbXoRcVAZclkr1pLVz559pAV8cXbZCxCv4Lu/mbIwL7nsZpUCdrI5XFWq38xQTLR81KIAvOXlRa5tDcA89a9cLSBgQmLH7NTdc1oCIoVGWegnbxmr+Zdxd+o7FxMvcJqrC4ZjtQhk5FsJ2LlBQH4Cap2qDt+H0jvkZ93L2WMG8x+SVbZsUHvIHNnCJjf0vvAVOBNcuH+XQNfire4Nyjdr0QUk7cyog2Dnvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSoWikgNAFv2gM1dsj6n/flTgM62hGufwugZZy+EGIc=;
 b=rHum24FGvTZ8+zDUcPuhoPW7FVGK8DdhA2H3+fMNL6oFVGTj91NJJEhHNzpDcZVYQvPyXrabfI5KO5MDLPFSAFicKTaIR5FtuNtdn8Wuw65e2YtKRCjzR+TbSqfD9osihlTxhnyiJeWoo48SkG7YbM4O0Qz3qFfj1i8PKIvGAbokV0eXlM9ipwp16brfjh2gAmlG5A9tQBtoBbyzrhj83JvZAvJMBzPdS2U2hUeS5m4PxVdRSYaj4J9oe+N8pdZU09b68XL0Fea10nfNYKHdQ01LhOaXw/dudv04BgoK+Kp3HlGP82Z0GolzocIlEAhDCVAXv0ES/5uVaVvsdRhI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSoWikgNAFv2gM1dsj6n/flTgM62hGufwugZZy+EGIc=;
 b=WQnFV07rvcmqJuw9ltKTW/JMll/XQDQqBECZaJzUzTT3FkCOR1Qrp2rYg9MT7OU7WgA0Rcm00PTJ7ukJQxjUH7Zjw516ueXD/4wdqTQh2qv8K874mMZZzUCZjlybX2GswZEdEbn/Jew4uhlDehnhqXiqNgUceNhankYl+g1e0X4=
Received: from BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Tue, 4 Aug
 2026 23:56:55 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::af) by BL1PR13CA0418.outlook.office365.com
 (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.13 via Frontend Transport; Tue, 4
 Aug 2026 23:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:56:55 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:56:54 -0500
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
	<kim.phillips@amd.com>, <stable@kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v4 02/10] cpu/bugs: Allow forcing Automatic IBRS with SNP active using spectre_v2=eibrs
Date: Tue, 4 Aug 2026 18:56:03 -0500
Message-ID: <20260804235611.4053375-3-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f879fd-25f4-40b2-e5d8-08def2841007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|18002099003|11063799006|56012099006|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Sj1ilI2rbR+61ndeuQ7WjbaBWuxmK7kL+DDPfj8eoHSMHUO1LfFnvwNlboFHM8Ur3nLjY/QzZ/tRK/kUjB0OaldQ0a2+piAen5wJdpbuVshAlo1+ykrwKlv/GjzoydZvwBc1R7c/7Dw4EWdSV5pWU5x9x49vKCKs2FawEH/tEM2qifXA1auY1aF1VThjeiaI1akF8ofRFoWMYUO+0jlJkt3pru4CWqnFZG/6X3w+cFs0n+VsrpuR0ltslyez1ADrNP8ufKF+pRzyj71X0QfrkUWvEpm/qLwDqMNdHVP5UDTWlclCSPtAWLiwWLGdnAL6Na73t8YJ2im5YQG1Lzzng5XIslHf+OyfrM4NHX2chqf/M431jsDikHq6oB4FVLVMBP+EQBYqLrDEU7SolWqWPt3uw/YR0yw+4QfC/cgv9XZFQvbBgod6sSWZc5aMBFVGqSVDtp5vkP8dKBA1ObIIV6sr2Uf0CzeQOsX2LnAJ2KTRloF10+R00hn3Mcg0WtwYsh8AowPiIPIZTKzV1D3Al1rtBzCcd37Qd3BHvNLJaRUrMCSCXLcGIQkK3bFF0xCFCgouVg0UpqzPdgD3ns7G+Ep5C8RlxL/U8Dq6bfRB5WdHJuPlybFGMFiZR/nkbLRL4jgPc4r1iKk04aDfij408n1SYZeHu1OA1vKREJJCnwFk/lasX/2kNpCPHwVlhJDSQsH2Yv+tB2pawP0tjpwY7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(18002099003)(11063799006)(56012099006)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r2FF7eUT7ZHYJ3ZoHPiTZtmYghjFJecZKv94Jo17sEvR9cBvu5yIDAn6biTsXGA0ssLyZDk+J7yee7yg4Pt9EaRjdkepRNa90bNoKNwfY6OgF4e0PDsgor26yYpRTQ55fS9/SIlPxQ33oRcZIa541lAyR2SokNWhqDd1el0EutfZqMpIztoP6BVRPC26girYRJJtryk9d9Gw0E4BP2QCTqCTL071TalTJ3AZPydyI/8GwHFEkOO6ziuenRQFVXQHApcdBPnh8xJ18OxrEMlMwUzwzjiJRYuSwdu9mvL/PDPpMpRNmbav0uvlQ8UCF9UGbm9eUt9VPHlLxqatS4OPOsN1oeWc9Jqslxp2Iv5xfSVLS9kFaj9HoQ2LSUOQirUeiZe5I1Y4dNxZWENpDkpr0X8IaHcwH0COo/mh5mvc7OscYYF5E0XRNRNZEK8MKAAl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:56:55.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f879fd-25f4-40b2-e5d8-08def2841007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056

spectre_v2=eibrs currently enables retpolines when SNP is enabled,
instead of AutoIBRS (EIBRS) because the commit that disabled
AutoIBRS if SNP is enabled stopped short of enabling
X86_FEATURE_IBRS_ENHANCED.

Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
decision to switch to retpolines in the default/"auto" case in
spectre_v2_select_mitigation().  This allows the existing
spectre_v2=eibrs logic to work as intended.

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
Cc: stable@kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/kernel/cpu/bugs.c   | 12 +++++++++++-
 arch/x86/kernel/cpu/common.c |  6 +-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b345f64f4258..a813a98ac5bd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1672,6 +1672,7 @@ static inline bool retpoline_seq_enabled(void) { return false; }
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
 #define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
 #define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_SNP_PERF_MSG "WARNING: eIBRS mitigation enables AutoIBRS on SEV-SNP enabled CPU, this may cause performance loss\n"
 #define SPECTRE_V2_IBRS_PERF_MSG "WARNING: IBRS mitigation selected on Enhanced IBRS CPU, this may cause unnecessary performance loss\n"
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -2192,7 +2193,12 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		fallthrough;
 	case SPECTRE_V2_CMD_FORCE:
-		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		/*
+		 * Don't use AutoIBRS when SNP is enabled because it degrades
+		 * host userspace indirect branch performance.
+		 */
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
+		    !boot_cpu_has(X86_FEATURE_SEV_SNP)) {
 			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
 		}
@@ -2291,6 +2297,10 @@ static void __init spectre_v2_apply_mitigation(void)
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
index fa429f04f003..8387d3a49c43 100644
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

