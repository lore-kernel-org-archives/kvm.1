Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3840DFD0;
	Wed, 11 Mar 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234443; cv=fail; b=ig7H1W8Ltaw8sp/a77DrntBVKqImoNTMxSPe8V4CWEoLPxGtvApYpmehVioJkxM/dS+7g22F45GNvcHgGG09IFX/U1fT+ckesaaXa6Llo/5QQvYBfkQxMuE30gRAJERQiL4X/grV5tkUnxSSlmPf2UKITEPaJS8QRnm1Vqdk0pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234443; c=relaxed/simple;
	bh=55hDm+85cz5T37kZZnXiO3N+aUVNMyjspgABGPOXxCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBPSaFPTr4CIPDyK9DEzGQMMUb30gHZmnEWFEpeKFCYUPUptMVfVZM/JVy327pcUDTvqo+JtrQiUa2OxKG1gtPGWkAeFtm2F+RJkBscdVmPetHfxGFi6cma/aBF+INywpXUUi83qXST7hxNU+0Auog+/8xzLBgswQfq35PlsUS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ch9dQ3U; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ch9dQ3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIn/w2w2wrhjMTSBLFzLem5f31y7lHrPg9gA0oCHMYt/dvihGdnYhSEPYuoOOlQ8wxJyxT6a0dVqg2oL494qC9Hyg+tuqZ4JWy7rcnPec/DK9602kELhs7g7OMkfZAyuP9khF+BHG8m7nJy26QYrWJHoZQWyLo11PGudu+HQ5ZwJUCNbwE8yOEW3ULbEPmywX6ug5N3qhlZmLc2RwnJEdPeYoYw71O8JKT8L8dUn0R2I94MNARNoQUlhoNE4ybz6KI65QHXm/nXQOGw3VI0z6dirCd5/1RvzNzrwxskej3zxdyCiUp3e+Gv2goGNR1by1XM61bwWIHmRUoBoFDjJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMIP0WdmGv0vGnKZx5wkU20a/hGDhwpaLJlv7eDuzS0=;
 b=BSChhpQEbK7RhzdZ0P+3QosBvSdKX+DREkE/4LP1TNG0z5gu2McmpgmbRcf9LSpILfuEb5uciDrVPIfk67st+L7Jt+YIO8a5T3c+Rz445gMlzoVSXnCR7Q9j+/C7pAM9GEUB692G2u+z5A3wrvVYQm2HH1uJiJVdJicp0BKtfGZLcaDpadMeObXS8uXP2JbSIvxfPfZyqafT13J0IkIoBYrdFUEKsJV63gJdwYyswzRqD3KGutdzWPK8dL/BMvUzc11JRdQpxxgwXS/tSN/FBe/fXfZc0mu8Iav7kxDOxXzWh8EOM/sNR2mmvDrK0b+kQbY9kcfyFXcKWxrofQAiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMIP0WdmGv0vGnKZx5wkU20a/hGDhwpaLJlv7eDuzS0=;
 b=4ch9dQ3UIab3g6yFkt4jE0AS8Ax2PwEmGh1EwmfUEI4q9BIcK3Whpg8L1JNGo9yNmfayJGNt0ktd65SU2dOAccMnbUbcJA9rtcUH+8KFK6I1PR9vOdnqscTrKJbqmwdYGAvSIC9PwZBk6UNnCIwSS/wm/oO0EKlnwHIufP8XRFg=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 13:06:35 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::ab) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 13:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 13:06:35 +0000
Received: from gaul.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 08:06:33 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>, <stable@kernel.org>
Subject: [PATCH v2 1/3] cpu/bugs: Allow forcing Automatic IBRS with SNP enabled using spectre_v2=eibrs
Date: Wed, 11 Mar 2026 08:06:09 -0500
Message-ID: <20260311130611.2201214-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311130611.2201214-1-kim.phillips@amd.com>
References: <20260311130611.2201214-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ea5731-d5eb-4b52-591d-08de7f6f0646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bg1w0rCqeZ6eeI2cNcLLUIjD8mGDtK1H3o0TPDKYK0NIw9oiK8937hmvEBn2WyQswnCOspNTzC3LT0abGZQdi4yr45zRx1cx+uLE/cAy/ECalMrk06mOEr3kfOsFxM+nemea4bfix3sCK4fbYa1nPCTcu8M3NPSbbR9qemDDCU9SH7LUJDqKaQoO8w0VJNlA7KeUYCpiDAjY0N3Xp5P5aVdXMU3aFTKHzAlfM+les4EFwXIfPNWhf6ycqqDZnzl5An20C98irad4W4XOUj/Drfh8Yoffon6XAdqbLUoBZz8fXRyhxiaFP491mrKh87+aR94ScTbmVIBPyMDuPej+vFJWFGAi6KOAaCs1fflPAwCfeDe/qB11OcznU2x+fhBpkshhqdJcZ3jW/Nc3JM4omMU7SPuRS0hLkucNiehkk0aGEL7w9D1lzeYvxCFNT57mkP0/N6xcZD0IUk3lCoeMrY53yIIxYFHA/kuOfjzpHNODeg4dw/Yn/lfak4SoBXQwKdTvF7uLmLXEPjKkNxFA0C45eIQK0HBq9MTtSZ+NtX3nh1EA9OwQUZrkJ3riW9bLv85xbjufjmmKvO66cMJ0N8zMkuUGSwUFbpnQbv9PekveT8PgizFLUSkCApBNHKvXip/S7mrelPP/jNS4c1MOByIgWnPRT0Q3FOcgHhOBIICFSU4r9rzNwbI08UsL+BS1n/WDAJr3Z7eWMnUx7fE7wOiezzfxQcqjCWEaoLF+caMCKJyPb6+w8bx206RHsPPea9942tKTmu+tK9qa+XAyzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y9zd8t07F+IZ/ow9d8pqM88k1qdaNqJSIWwhzYP7Kp/R1Jl1GfkkaOfP/WVNMKzR/1ZPwpIXBN/NFA/0kfxK3WU3lbchsSasoKoEd1W2S7VLHEiLC3XHcv0sqnYIQJBXAD/AU/DRyeTewzg6z0YRA3xNwRD7OPwDXacyLGxtqN3EMbc85+o/h98dN0DRj+I/hXZ1IwlpVJ4kLh54aBu/jxpzWjTMF3sSFsBy504wh4M01yqQKSL5p1NPq88jfqnbrhV346jat6FzmImIAfOeF7M05lfxOoCAtTPdcdv2LGttZOt+gOD/lw2g3xzEOBe4XywrTbkonbfhto6uNO2qB4/2p79EdebtzHoXgqYEhJXH/3ZzJKkN/qkzWvKeFqviWFrjJqapY+MY6FGiPFyUbMW9A2WMau/jThZ9zCeFR70g5+zPy8u+b4JUv05e6TnD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:06:35.6124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ea5731-d5eb-4b52-591d-08de7f6f0646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

To allow this, do the SNP check in spectre_v2_select_mitigation()
processing instead of the original commit's implementation in
cpu_set_bug_bits().

Since SPECTRE_V2_CMD_AUTO logic falls through to SPECTRE_V2_CMD_FORCE,
double-check if SPECTRE_V2_CMD_FORCE is used before allowing
SPECTRE_V2_EIBRS with SNP enabled.

Also mute SPECTRE_V2_IBRS_PERF_MSG if SNP is enabled on an AutoIBRS
capable machine, since, in that case, the message doesn't apply.

Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2:
 - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
   Intel feature flag also for AutoIBRS.

v1:
 https://lore.kernel.org/kvm/20260224180157.725159-2-kim.phillips@amd.com/

 arch/x86/kernel/cpu/bugs.c   | 12 ++++++++++--
 arch/x86/kernel/cpu/common.c |  6 +-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..957e0df38d90 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2181,7 +2181,14 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		fallthrough;
 	case SPECTRE_V2_CMD_FORCE:
-		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		/*
+		 * Unless forced, don't use AutoIBRS when SNP is enabled
+		 * because it degrades host userspace indirect branch performance.
+		 */
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
+		    (!boot_cpu_has(X86_FEATURE_SEV_SNP) ||
+		     (boot_cpu_has(X86_FEATURE_SEV_SNP) &&
+		      spectre_v2_cmd == SPECTRE_V2_CMD_FORCE))) {
 			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
 		}
@@ -2261,7 +2268,8 @@ static void __init spectre_v2_apply_mitigation(void)
 
 	case SPECTRE_V2_IBRS:
 		setup_force_cpu_cap(X86_FEATURE_KERNEL_IBRS);
-		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED))
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
+		    !boot_cpu_has(X86_FEATURE_SEV_SNP))
 			pr_warn(SPECTRE_V2_IBRS_PERF_MSG);
 		break;
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bb937bc4b00f..5aff1424a27d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1486,13 +1486,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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

