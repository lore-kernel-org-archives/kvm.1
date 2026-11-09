Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794258378;
	b=xQ7blWcApXzvf1XneAak48c4DfK/deI2WsjkzZo0T5AD5HwFm0Xfn91S6xN9wD24ELT6
	 x1OJ4eRF+SDKX7VvtJ6WLtT/M96JPNMzDbTZlKm3C152UpZYLLnC79rKUeWW5e6DjqIYM
	 2Ia22P+AphFj72Y3G1Z1BpciH0N0gsgXIgZD1pbO0lFqhu1J7UUv/rFGd8pLMTSF4pffz
	 n23HxYeJ/4hS7WTaf8zp1Dp2vfowuh8mON6rB0VJSHi008+buIVa7jIYgyQ252lodJYJG
	 bhvWGgSnBEFKk7eUIYyQRhapVdBu1Uts+ND/2eBa+4KxpTUTP4S71GEQwCgCpjQCtSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258378;
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
	bh=MscitEMeG9GDxZ5LtjEz8Trpc6fAAD7rddyzAqzfE28=;
	b=M1Siv8DOSATr3iq6siuTHoKe/25ZazLKpUDuKuyz2aSMvZs8raJA0XXhPBIgwg9GdDk6
	 9cMbsNviZ9MslJyXiTRL0x+YdY/hUiipXilJqllm/oLRuAAl37rCc6sajftz/YaHUkYCl
	 bngAnyi2ALq4Lohybzp3I4qtccBrFnNawHm8kCwccXOJXSfhP/1yZdk3PBvoGBEhqrxXw
	 lP2MNxu9b9uZqgLu2bpgltjLfV7nf5WP6HjKfEd9SUY2W0j/zb00Q5b9Bi+h6RVKIHzTh
	 n1oZHWGjZdBkdhZh+iaMQuaVBTz/do4y8OsR8dP4Otd5nGhzC0tGcFhVCUL4qpBXnGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MvQ10RKt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.4
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBC606A31C;
	Mon,  9 Nov 2026 21:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MvQ10RKt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnMgop2ZOgP/pQ60xeb51Yt4gDxR4/EIoW4+gsausv/0oLuQXwAtb9QQubJDANgAJR2B6toa84Dl45V81F5ErxWJhGFV2S9MVq9NaQg23+NlYWrUnAuVNp4Vk3FGHdW4chalP8KP98M2e6fhrjnOznDPO3zRXfcZyBWQDe9B5sZOfXXyrjaN4JhHFH0juWvUY0I3Oyj902q26McKhkNT6fJFqtCE/jOiaybgdapMl4/CCQFmojG8lvZB4IlrzfatEcRHzl4zTdl8KhUZGThX4j7+AW6vb1xVqDezGBPqdDf9AO6Z1W9Y7f7I+M0UT1hU2PFJgL8Yost8PU8lashOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MscitEMeG9GDxZ5LtjEz8Trpc6fAAD7rddyzAqzfE28=;
 b=gvLpwUGo11MnxnEDS7Xc9k19vlpx4dQqOuyENLmKNDMz7ORP/S4CVDPRQFmzWNjpdr5TEkCuXuQV7FdrmCs2+QHuUvlyeFWpe8CVXISoBd+tY1oWnBA1WTR6VCq8+SorwGC2/m4gQ6N1pXTdy9Hkw6TVBXxT7GKSsscNrhLYCXzLS9DNqRzOLCTajHrB0j2OPT3jkCamgkESFGxg/aiLp4KCoR1c1cZD5yTtrL49YLvrfUt1AlQ6XkSdmrhtCYL9JHB550bGajRHd6t0moy6MREIuj3mftt47HQM/0SZs/JHmhARkMZRHwu5x9uCnhidlYmTs+m1ITbi/IZK5wygIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MscitEMeG9GDxZ5LtjEz8Trpc6fAAD7rddyzAqzfE28=;
 b=MvQ10RKty2OpXzQiPhHBkAfDelTl3cGhe7p8YVVdQdLL2hFqUjQmKdIkD0n47MffxtwBouz6o5aEr0/kSmlz1D6tua2lcQEp95VOV82tuTyInuDf2vZc8JEqXFKhhSFp8Yles76EwV6kdDL5ATwuXum9jzr0I3i+6N2NY6AMHGE=
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 21:06:08 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::9d) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 21:06:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 21:06:04 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 15:06:03 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <peterz@infradead.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>
CC: <pbonzini@redhat.com>, <aik@amd.com>, <Michael.Roth@amd.com>,
	<KPrateek.Nayak@amd.com>, <Tycho.Andersen@amd.com>,
	<Nathan.Fontenot@amd.com>, <ackerleytng@google.com>, <jackyli@google.com>,
	<pgonda@google.com>, <rientjes@google.com>, <jacobhxu@google.com>,
	<nikunj@amd.com>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH 1/2] x86/sev: Scan each core's own RMPOPT window
Date: Mon, 9 Nov 2026 21:05:48 +0000
Message-ID: <2f541fd5481938bf2604397dc7bd554eb5c884c4.1794257678.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793921823.git.ashish.kalra@amd.com>
References: <cover.1793921823.git.ashish.kalra@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1ece82-5631-4883-730c-08df3ea54459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|921020|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	2CEDbSieOw43c9vY6IHVsUn8JsQ1KmsFn1Z1nrt1Px+9JQ4C4adGcM80XgvoG45eLQrbRcR3BU077HBrfV2gukI8ftEx7uPzLeRYbq1mybLS0w+jeYuPQr0fnRHLGvxnnAPY1r69+kZUnVBFBk4vmUy5dCEc8dF38FVoxFpgrKwswW6Wl5N4wiYPpGt5SDUrnerxQpDXsT3QIboQlclMH2Zkhw7B0LvjG5cbFZoQQwE2p0mxIbfrpFTE1f5Ey3JADid9t5IVzzTlFqRt8fNio9dInYILyX/2glU+T1vGLAwmR9/yTNS+7p06UeEVRG87G1h3pzzXu4dXE461GXgecfrYAJYLfZkWXNygYpW7EqEBOE3QxaY+fpwYtURoOIyDQzbpcxsd1j4R9WFxfmPuT5MQsB4pJKi2v2vrFHpnTGVdT9sPCmaCNwRW2jI4txB25hNNUCwO1xLKl89kM5HDBJq77ljqBgqKhfsPiT46+bYcrSwKHtPO26vfsvbtfNWTEjvYGt5RXB+hsTWaMUBSKp/L0kE+u/EVNIzfK0tunoOmWMuggyWdrC0JxKIiXwLRT3IFVDmPp+iGTWohGXOwAHHpyB9rzMqOIpwqFY3096HNQ7h12sMphuWX/iAW8XemOZADk2hjmwbQeMbNE9tcD//2w2Lm6/79OAe1KebPJJKgGMx4O47ubPpfsiyLHQYMvssZvsx9fJ+HPgswL2tKRsJe9d96tIUSPi07uDaHVrSr/Bd92FG7ECGrenTIbWoa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F6zEvqckECtvjIPNXNZYPRZjIouMJqaaDwFuLkNPAGe81pCyhP2HiHCR1USYib2PcsAVwo4eu9AiPaKF2T9BQl2nruwgxk6Pzs1NHqJxK5eFGMwRsvVv4UFltvIys4b3NwGTymj5rAmKbqEOU+rU2oy0dfj/ZpwOkdDDgZ8tY1TrOHsqatu1CMqMSsWE+VlWdAt06JvJ4BA3ezFY9zh2LTLVXdltb2gmv2rznaSYlTdy+OD/lP8OfBwa2XdFDRCQqKAIlWd07HTJ0Ye7j5lqHJUPFPVw8y0H3Jb7gAxsBU+lglsBG7ftC/Zg4BZdRMbx9hLbll9INuKRzZreCGB4B/EJkWUKjxl0GZsP0JpFvjtsYTjqXObjBoy42Jxf0WwWtLIGAVqSL97bOQOFgKfW0e2CKKJdZXcgpyj9GlDh976Y6SoNmGNA97/O+kF9nP8Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:06:04.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1ece82-5631-4883-730c-08df3ea54459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

From: Ashish Kalra <ashish.kalra@amd.com>

rmpopt_scan_range() walked a single global [rmpopt_pa_start, rmpopt_pa_end]
range, which is only correct while every core shares one window.  Read the
executing core's own RMPOPT_BASE instead and walk only that window, so each
core optimizes the window its own RMPOPT_BASE points at.

The window is described entirely by the RMPOPT_BASE MSR: RMPOPT_BASE_ADDR
(bits 51:30) is the 1 GB-aligned base and RMPOPT_TABLE_SIZE (bits 22:1) is
the window size in GB.  Walk [base, base + size), clamped to the top of
populated memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/virt/svm/sev.c          | 29 +++++++++++++++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c0914829a925..6d453bb13621 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -773,6 +773,8 @@
 #define MSR_AMD64_RMPOPT_BASE		0xc0010139
 #define MSR_AMD64_RMPOPT_ENABLE_BIT	0
 #define MSR_AMD64_RMPOPT_ENABLE		BIT_ULL(MSR_AMD64_RMPOPT_ENABLE_BIT)
+#define MSR_AMD64_RMPOPT_TABLE_SIZE	GENMASK_ULL(22, 1)
+#define MSR_AMD64_RMPOPT_BASE_ADDR	GENMASK_ULL(51, 30)
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 4de9681cc2f8..a2756b18d5f7 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/cc_platform.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
@@ -125,8 +126,6 @@ static void *rmp_bookkeeping __ro_after_init;
 
 static u64 probed_rmp_base, probed_rmp_size;
 
-static u64 rmpopt_pa_start, rmpopt_pa_end;
-
 enum rmpopt_op_type {
 	RMPOPT_OP_VERIFY_AND_REPORT_STATUS,
 	RMPOPT_OP_REPORT_STATUS
@@ -618,11 +617,18 @@ static void rmpopt(u64 pa)
 		     : "memory", "cc");
 }
 
+/* A core can only RMPOPT within its own window, [base, base + size). */
 static void rmpopt_scan_range(void *arg)
 {
-	u64 pa;
+	u64 msr, base, end, pa;
+	unsigned int size_gb;
+
+	rdmsrq(MSR_AMD64_RMPOPT_BASE, msr);
+	base = msr & MSR_AMD64_RMPOPT_BASE_ADDR;
+	size_gb = FIELD_GET(MSR_AMD64_RMPOPT_TABLE_SIZE, msr);
+	end = min_t(u64, base + (u64)size_gb * SZ_1G, ALIGN(PFN_PHYS(max_pfn), SZ_1G));
 
-	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
+	for (pa = base; pa < end; pa += SZ_1G)
 		rmpopt(pa);
 }
 
@@ -650,12 +656,6 @@ static int __init rmpopt_init(void)
 
 	INIT_DELAYED_WORK(&rmpopt_delayed_work, do_rmpopt_work);
 
-	/* The optimization range is fixed at boot; compute it once. */
-	rmpopt_pa_start = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
-	rmpopt_pa_end = ALIGN(PFN_PHYS(max_pfn), SZ_1G);
-	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T)
-		rmpopt_pa_end = rmpopt_pa_start + SZ_2T;
-
 	pr_info("RMPOPT optimizations enabled\n");
 
 	rmpopt_soft_init = true;
@@ -665,7 +665,7 @@ static int __init rmpopt_init(void)
 
 void snp_enable_rmpopt(void)
 {
-	u64 base;
+	u64 base, pa_start;
 	int cpu;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
@@ -678,14 +678,15 @@ void snp_enable_rmpopt(void)
 		return;
 
 	/*
-	 * Per-CPU RMPOPT tables cover at most 2 TB.  Program each core's
-	 * RMPOPT_BASE with the start of RAM to optimize up to 2 TB.
+	 * A core's RMPOPT_BASE covers at most 2 TB.  Program every core with
+	 * the start of RAM to optimize up to 2 TB.
 	 */
+	pa_start = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
 	rdmsrq(MSR_AMD64_RMPOPT_BASE, base);
 	if (!(base & MSR_AMD64_RMPOPT_ENABLE))
 		for_each_cpu(cpu, cpu_primary_thread_mask)
 			wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE,
-				      rmpopt_pa_start | MSR_AMD64_RMPOPT_ENABLE);
+				      pa_start | MSR_AMD64_RMPOPT_ENABLE);
 
 	mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
 			 msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
-- 
2.43.0

