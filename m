Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793389100;
	b=rMvtH9IXJLzb32vc9M32KfqM/I05fJQwpH/qfcp8hsTL1UlSJC89vrGIx9M+Ya/pMuuH
	 ncI8+Err4NIqimkgQb+07wkuGFf9AfpPzvNHawII+ZRyP6PYei4Lnhbg1PczPMYWpXdho
	 FDt8bmim+sjmEWPOY+ez/HGmZ3lJMZ+LKKcrLSr31VEQ8JBOluxjfYeffGGQYTmV1sdi2
	 DybgM/chS+YoAju1l3axk7uXR3ian70UPgEYohips9GzcPDxPz06bqiyalmTwIyd2uhVb
	 CWWNTC24We3A5F6wO5cocrPZfoK7Zuapt5Iz3gBSj5Tm7PSfCLUBZ8yRyTYdLVX0zUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=cB40AUKmwOWZ4JzPGdA2/FpDQOUY1PEow6Alffs9CDg=;
	b=nUtWX9ckji5nC8qRKQWmFRs+T4N2NM1Sxq6pvy9a95aQE90qOCYM9e/VtX/AAv95pR9K
	 6SnWuGTUNIRJhBW0GIJ0zbbpyrxeOy5AgOErvYKtZPGtOLGCE7dsz3O2sRemaIGa87NBG
	 OBO7BRt2p3U2fWn2CuKbhU8OdpgbcMjI9pSTzfeFOVNPgcXdlMaTGEfDJb7P2QJQM0ork
	 RCk2nUP5BZXA0JkwMgkVBCVKpowPYM0YyGYV+JxCw8u2psuPIS97J7uhUarQBQ9AA8MoS
	 FLhJJRgGxaCfajnc6YxbDJ6zPK4VYWFHWesQDr2ynfM/3ehaequLk8gzGX7+aLsM+lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mTg6mboV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.55
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89631606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 19:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89631606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mTg6mboV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCuwv4OlgQUPnKz47I5qtmhhSU9JMSfm7RdyQSJh2I+dMdBJerJbjDa4KpGe8On6aVtmEZHCyYb5hdHYY26zxoNBCVVf2pn3VOUSR/wpkh53fSqQ8uxuYeuJUtXho9KtQq+W1OOSyRWSDAurzfyG+cFb1HU8mi+ftJgxERHn8vlrKMD3WxR/hDFYJWFJ+JsD0CpsTG3F6J7VcyULYdx6QtMJJg2jGNd5ZXtORlHAegp0/lzd7vs6udyM9c3NXCvGwWL4FA7KSwTlCfFaXQwdEIef+a0yEF2ma/0Im1usK2CfmFFIt38Kkv5hkrJ3Co0gvODU2IinFB9THJwm7tNOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB40AUKmwOWZ4JzPGdA2/FpDQOUY1PEow6Alffs9CDg=;
 b=ZpQClysLLlf0zetmh2MBCwzAq68k1BpzYIvE9doGr8+EbYo/P2JuCCkHB4DpC6lB6ni8KEdfRaV1qnfzFNPZ6gv21DEyJZNyvmap418Yw+J94XT7cU3iEpVgSYWYiT/sJz9Eqp47g6dC3kFTKhvaG5dF/iTCxVxpob5PozHtKsHXDBwyS+wa56XEf2fpG0wx3MsY0sGlI9U7JNaDmaUQ06kt3Ah73CHN/tq8qwroVlizHI01XLT5jHDM+7BsjCQmnVR3L1NGqNS3+VU9TcKCe7/acXikgvXihvrCi1aa4CGCRWpb8AD4/OuAL+ENTMPa9clTqyhCtkk/Rp1QF1Uvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB40AUKmwOWZ4JzPGdA2/FpDQOUY1PEow6Alffs9CDg=;
 b=mTg6mboVUwhi4hgvO4Qc3eQWJ+dumjwB61RIw99UK318ulKC9Fp/IKiX7P0WpYknxsMMv+QBmRCro/H5F21wkNkKteJId3CkcGLE57K9pH3shZ1LvNDjlAfZ1ZlPrMaOZTVk58RkIya8/ETbwKXC9OwDWehXux/xIJeBsQXB7Io=
Received: from PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::6)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 19:38:15 +0000
Received: from PH2PEPF00048919.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::85) by PH7P222CA0011.outlook.office365.com
 (2603:10b6:510:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 19:38:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048919.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 19:38:15 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 14:38:13 -0500
Message-ID: <ce171e11-a5ee-422d-80a9-24029d715b1f@amd.com>
Date: Fri, 30 Oct 2026 14:38:13 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/i386: Add EPYC-Venice CPU model
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
 <20261029195623.2209-7-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261029195623.2209-7-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048919:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6a0800-ee2a-4747-6767-08df36bd5797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261026140227099003|10067099003|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|261021135927099003|261021123027099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bzzqQ7czVKtzknD/eUEARfO3VFqUcgMLkFDCtd8LEsffxNTvpQhgLgu1czedeQfRDMp70l4XM9zGsM2HiEVAsPO/5MQm9yeo/2H3c/ySMvIF1i9OxdYptNiFZ74zcoJoRQjTZTNXoE1+QZESZ3OJAT8JvvN70jEo2eZwKDtO9y0gU0BEP14xwavS2C6CapzGzrx2dIx5AKg1wjiv7vic/ymUWlhG6FMU6Z4BlHQLRcKVe/mHfi8A7aZF5wFV4ygagOmCVaANkGDmsAOyGBpSV0L/zqqMzI7b+veLifAF60rMszDi1SaMqDvBu5vZl6pgLyZnXA+WlDgjr5VFsi4CFGGVj++rG+DujgJ5hDPilWv4WUKdh9ULR6IR0CpxC4ONUEJFdlhPgtYH1Zei1tbcC8s9icYEFUvBwownO9u3KYwnBhlAN+dFVc+4VxO5wDqkmJOUNWSmg/gIMwbMuJMlnsQowHl/diHBp68tqW85XLLHys6tyY7zQizxKPwNrU89/phlVu6sPwvQsAgUbuqUl9FV7MygtuKApiW2aduWAZRijxTFJaKNL7ZjNpRYaLgQBm44SwC7IHt8uxSNCI17EH++TzGgrALqykmXVOvi6ZxvaEhdFKKSxKXLGBANXOFzH3SytQle8v6M/wTA6UPXj4EuqUi3yLAbGE1np4mopiV/cEUhcdlq5ci3N+4h9Nscdf+e5qZdHFi2psYJZ1s48Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261026140227099003)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021135927099003)(261021123027099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P0WTvoEEhv2JKi0KTYAqbewwOJRdu9bBIBeFowwXLbtUXh8X3jk8V6KZqqQrmohwZUTXOeiz8D4oxW8Yhb60vl1nx2DKdx9kbjQLSZ3be5biGyfOWdwQQr5/wQDtsNvf2Tag7a4SDN7uELJFekCimMTVM+66ZbYkwhU6v/WZuH3DCVB9HAcdkFwMBeNnJktW1SZD3xXe4lc/6fkmrMFW5X1jUynSOmbvhV80KH/Mu89Rr/6Y+Ag4mtR1VJDbfovjs71Yu48QpZII3OlyVPIgs+WRpyIfbbKDH4/vntvxTFt0iWnNB60uY4xnPFgWk7bX7PyYravCHmBtsjeWp5MUJgcZ+ksXhgM3tl7j/gp/VyGr0SEIAiZj5wu1H9/VL6TRjxGfLMiZgzzNGaTbkHP1MxNJerLNZQ0zbIO+26SP+SntufeUd4KBCfbsHi0KrjQ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 19:38:15.5035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6a0800-ee2a-4747-6767-08df36bd5797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH2PEPF00048919.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

Hi All,

I realized I forgot to add the AVX_VNNI feature bit (CPUID_7_1_EAX_AVX_VNNI). I don't want to
send out a whole new version for a single line change, so please use this patch instead of
the original 6/6. I'll have it updated for the next version, sorry about that.

From bcdc92aa84e36f691a862336ddac024a3a5ca4e0 Mon Sep 17 00:00:00 2001
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
Date: Mon, 9 Feb 2026 14:06:25 -0600
Subject: [PATCH] target/i386: Add EPYC-Venice CPU model

Add support for AMD EPYC Zen 6 processors (EPYC-Venice). Add the
following new feature bits on top of the feature bits from the previous
generation EPYC model (Turin):

avx512_fp16		: AVX512 FP16 instructions support
avx_ifma		: AVX512 Integer Fused Mul-Add instructions support
avx_ne_convert	: AVX NE-CONVERT instructions support
avx_vnni		: AVX VNNI instruction
avx_vnni_int8	: AVX VNNI INT8 instruction
avx512_bmm		: AVX512 Bit Matrix Multiply instruction
eraps			: Enhanced Return Address Prediction Security support
				  (see also: rapsize)
tsc_adjust		: Time Stamp Counter Adjustment support
cet_ss			: Shadow Stack support
bus_lock_detect : Bus Lock Detect support
flush_l1d		: Support for flushing L1D in FLUSH_CMD MSR

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Add bus-lock-detect and flush-l1d to Venice model

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f6bbb2e99b..c4179b2f2d85 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3049,6 +3049,59 @@ static const CPUCaches epyc_turin_cache_info = {
     }
 };
 
+static const CPUCaches epyc_venice_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 48 * KiB,
+        .line_size = 64,
+        .associativity = 12,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 64 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 65536,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    }
+};
 static const CPUCaches xeon_spr_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -7322,6 +7375,94 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
+    {
+        .name = "EPYC-Venice",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 26,
+        .model = 80,
+        .stepping = 0,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_PCID | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
+            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_CET_SHSTK |
+            CPUID_7_0_ECX_GFNI | CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_BUS_LOCK_DETECT |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_AVX512_VP2INTERSECT |
+            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_FLUSH_L1D,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 | CPUID_7_1_EAX_AVX_IFMA,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0007_EBX] =
+            CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
+            CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
+        .features[FEAT_8000_0021_EAX] =
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_FS_GS_BASE_NS |
+            CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
+            CPUID_8000_0021_EAX_AUTO_IBRS | CPUID_8000_0021_EAX_PREFETCHI |
+            CPUID_8000_0021_EAX_AVX512_BMM | CPUID_8000_0021_EAX_ERAPS |
+            CPUID_8000_0021_EAX_SBPB | CPUID_8000_0021_EAX_IBPB_BRTYPE |
+            CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO,
+        .features[FEAT_8000_0022_EAX] =
+            CPUID_8000_0022_EAX_PERFMON_V2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_LBRV | CPUID_SVM_NRIPSAVE |
+            CPUID_SVM_TSCSCALE | CPUID_SVM_VMCBCLEAN | CPUID_SVM_FLUSHASID |
+            CPUID_SVM_PAUSEFILTER | CPUID_SVM_PFTHRESHOLD |
+            CPUID_SVM_V_VMSAVE_VMLOAD | CPUID_SVM_VGIF |
+            CPUID_SVM_VNMI | CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x80000022,
+        .model_id = "AMD EPYC-Venice Processor",
+        .cache_info = &epyc_venice_cache_info,
+    },
 };
 
 /*
-- 
2.53.0
