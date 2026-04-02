Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387502DEA95;
	Thu,  2 Apr 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161591; cv=fail; b=Xb28eqrlImIdF4/wRcVuZBDctgBuz0mFhPx6IiXYD43nyrLhsMj5mpN5Bh0GVwY6FDLDQCeXISOEAZ58T4DnPcR3rtf8i7q8lL7ALRZOl/3EndePJEdLnTWqIthkYV+RQ2uQk7MaIxiBI7PVz+t0OqSp4QJAc7aKPNgq4i15c9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161591; c=relaxed/simple;
	bh=pxIoCWoY3KwTuBWqVNHSn03e6aCyKU8I2cbU2eXlyk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/XiqF3H85x7SDY8Abojg/LgjLR9rxnmStVrWU6xs7fT/cU22qWLnKE+q+m1g3qMhU5cHb8Hua9yvjEtZhrBDsw3oYqXYWZfbEECDBgF9kgBuAYIb0dGYxRL7FJ8ElrI29i8rTFiHwrq8B1EBztZqDs0prV+CbqlAM9LSvPDB4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f57EqUhf; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f57EqUhf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBZcDmqWQBdLHm8LX+OAkkp4zVZnoB4m81MP+/9YmGmnSTg/EPcG8Hz0kHNv534IyV9J28obLliWFCdnaHIOi6cI0rJvspLikbQ3mJ5Y5MkhARyd5HrK7vWXKRdarf9CoDev/Ac1LgZXI8l/UZ05eNuIygdlC7kGXg0vrSkmCnyjKzVx/WeqEe439uASOLy8oU+Vvd4HUcx5D4jqMNAmJGcpY+hhkW4WA3d11ETUCCnIR2Uucutq4XM1rwCQ9vLTQPnPneoT3q2B7gUOkH5QN2lglL9xZYrIBF2wiAQLKyrAaj6cA7PmaUIirhLv2b1Ph0Z7ZVDOKC8T+vePmnwjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25r1xYYqG2NfVn5K8Ot0Il8LDaKDiW0PpgiHh0oB44Q=;
 b=wFg/uvfId6IizQoG9b6YXTTWVpsES5ZxG2lU8WKfgQxznI2d96xLSd3KDYwrAxuhcsMcvSQExJ1CwXuaiALmEuDi5pPT11bd4M/x32Rmg4gqDH20Wg5DWac8AeWsbFJ4MJ36qkG2ucAG/L53dhNFjiMtILXG03EenuJE6og5Z+OBR/ojHJ6+OIejuv1vKe0WwSiVqdcjrMQG+1/VJ+aNGbCrpoKpZruC3KAr2VtrpvHO+7Hmh6GBHPqatYONmn8QI9e38rQEYkthKv7ptO5gWZGV/zWBapoWMls82NnaIhjXUSVwURuXWFbXo7M7Cxzwa+FWgCLjIyeVpPxS4quwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25r1xYYqG2NfVn5K8Ot0Il8LDaKDiW0PpgiHh0oB44Q=;
 b=f57EqUhfp3sOKgjV7qFiiTdEKVY1zgltuguilxiMOhNu+Krv1V3xohk9PWhQSiaIEHYcJ/RhO0KT4nZeOsdfREFGJUBkKRsoQxYC2zAYxFovqpUnWHyDeZb0pwykCA8kUC9E2F9mumAwsfPqcThimZSv9uxEh8Q/dts//XNsESE=
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 20:26:25 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::cd) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 20:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 20:26:25 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:26:23 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<stable@kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/6] cpu/bugs: Allow forcing Automatic IBRS with SNP active using spectre_v2=eibrs
Date: Thu, 2 Apr 2026 15:25:53 -0500
Message-ID: <20260402202558.195005-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b5d299-56dc-44d3-315d-08de90f61cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Vvlq2BmGMCYjN92hCZcwnE8sLNIHcMCXOJYMHYdy4kGubdMuIFBP3UnxNMos5k4tLYsKdB1fxoT5Izs//v8p5tGf0E91kW/wpz6BOyebE03MWm/eit77z2qo2MpR6H6sIYgJQAWmn4AoOdKCxixwgOX9+2/ESIvqxiZgsE0OizYsc7OiBMTYbMBLXga2MbS4FgQcI4azP5zud+bXXYQy8G/GRug8k6CXqHJwOfAkcxck9vHPVc22DdtFOxAuP9+T8U8eyR2P2uMn4BHRUi/sdCN2hMJwjvrLJERzc26A7hsI62Lh5cwCquBuFZ9rU6Y4kaQAyIMMxrr5ZaxQuiKh63v9ZNTJQloEDfGySiv7O038jZk1bNMAiRgXYxRtQsfCVwZPt6rXqX8IIS581OSXKsy5lgwkGccmwKJe9KQXGqDbSqxF382rk0+nc0dsKIGL5TMLHkwyyFnRlNcIn4+sCcnPPLzPeqpLJxcke5lTlB0THS52+pTsfrqrwFz7vsT8AAnFAp3qbXoyeW6cZHba+4dxUvQ4mFllt/xF3YFLcGM8JMVeogbvsH/Lqj70aJkwJ+qy3N4dG+M9CdS7fUe9Nhoh674F14W/S203VHLAGPWlQWju5NOZA7RFHcDhkHgVkdJmeuRr8xdFD3TCeqZAxH0F/FBGDGvsv6FAodZ9M+AyrY88MlLUbI5xkY9pok8fQKphMd3SJWcXPD7DJ7t6MyJ2+Atx0vBGW4M62DymLX5jAIzxMqQfw27qlDPxhTU4O0hTCLC2ipRL/0thqWF4TDnTPcHsVhVpp51790nuruE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cn9+mulu8UOsTdyGibxWW1R24SdZMer3iB9JQODLGNhkeOI3cs1SXANMfqhmQvd/AzYXzKNk8j3zgPPRFi8DyHSqrwnaSVwWycjtUFrcDCcGK2sREYi6p/SL872xiynP7dEiiW3fEmdb/iSlALWcLvjVg/E9abhwXOWG/xpYjV9YJOrPjFZGPnDTo7hCX9c7hMgkfXUuzwXQhsDpd+ynHoYfGo0rBy8qjIf2F2pQnZ+OgK7FBardwp/NBqjmpE930D77Q8izzSRJgXFJ5nvu0EHZV4gJq63FnBMkFCng5GaFPx2SdCIUIKug0+PLDEc1hlQqUgl4MzwlPbb0puGb6O6rm0WcWDZVSFRe5DH3A0C/+ZCr2YXwzww5NgyazPePNqBxijjA9B0OOOr4PHLsgQIYo1hAtubu1PXl6kC/ZpY1k3M5HdkjdFCmngGyOwnn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:26:25.2475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b5d299-56dc-44d3-315d-08de90f61cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

spectre_v2=eibrs currently enables retpolines when SNP is enabled,
instead of AutoIBRS (EIBRS) because the commit that disabled
AutoIBRS if SNP is enabled stopped short of enabling
X86_FEATURE_IBRS_ENHANCED.

Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
decision to switch to retpolines in the default/"auto" case in
spectre_v2_select_mitigation().  This allows the existing
spectre_v2=eibrs logic to work as intended.

Also emit a performance loss warning for using AutoIBRS with
SNP enabled.

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
---
v3:
 - Addressed Pawan Gupta's comment and remove wrong SPECTRE_V2_CMD_FORCE ("=on") check
 - Addressed kernel test robot's !A || A && B is equivalent to !A || B warning
 - Preferred to add new AutoIBRS with SEV-SNP enabled performance warning instead
   of muting legacy IBRS in use vs. eIBRS messaging in the context of SNP, since
   SNP users' IBRS performance varies whether they enable SNP BTB Isolation

v2: https://lore.kernel.org/kvm/20260311130611.2201214-2-kim.phillips@amd.com/
 - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
   Intel feature flag also for AutoIBRS.

v1:
 https://lore.kernel.org/kvm/20260224180157.725159-2-kim.phillips@amd.com/

 arch/x86/kernel/cpu/bugs.c   | 10 +++++++++-
 arch/x86/kernel/cpu/common.c |  6 +-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..dfefbde10646 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1658,6 +1658,7 @@ static inline const char *spectre_v2_module_string(void) { return ""; }
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
 #define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
 #define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_SNP_PERF_MSG "WARNING: AutoIBRS mitigation selected on SEV-SNP enabled CPU, this may cause unnecessary performance loss\n"
 #define SPECTRE_V2_IBRS_PERF_MSG "WARNING: IBRS mitigation selected on Enhanced IBRS CPU, this may cause unnecessary performance loss\n"
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -2181,7 +2182,12 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -2257,6 +2263,8 @@ static void __init spectre_v2_apply_mitigation(void)
 		return;
 
 	case SPECTRE_V2_EIBRS:
+		if (boot_cpu_has(X86_FEATURE_SEV_SNP))
+			pr_warn(SPECTRE_V2_EIBRS_SNP_PERF_MSG);
 		break;
 
 	case SPECTRE_V2_IBRS:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4e1f0c4afe3a..0cdcbbedf883 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1485,13 +1485,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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

