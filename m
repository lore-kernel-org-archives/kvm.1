Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303814;
	b=tqSF3pQWyUwKerapyJMqGIZKOY/HCYpOjMIYKzGRv1977fzA5J0G8Yxl0XUHo9RXaS8H
	 trDf/2XZNA3KsV8wBREeZx8IwxqErytP2/UyuYgNWbCgOcqdmubC9LZVHC+WL3vvuofaM
	 Q7M/LyLa9JQJZWhqrGaY9DSuSGO/afvM0lhqecH7YU/eS/BlVmzMSkRxCK7CzNoPkVc/o
	 mQB4HJ6Jiw4ysLj9kwJ3xwmLGrHKQC3PlH3oIrwTZonoPx3VbXRKeui44AyXwNHaazifF
	 +bt3AX8R5snXnWDbPxfOkJku0/UjNs8MMRbgEDsDr26PziHcbjYECu6Xv5zKyixp56A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303814;
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
	bh=qjlbcxM82eJn5g3IWYz2vsib7h/e1q8R/FwhJwKizbo=;
	b=VP1IInOLgzdg8A0geysl2lxLHhrcLOnghbyMA624N2d+fehZyyBzV97HE5qnMuOzHi8J
	 qI/1GdpBnGH/VoQCtHM8wGOQ7FjmULCMpLLS/2A56S9Pbwa5q5odjxvF80N9K8P0UhTUp
	 GKA2S5T1vVgn4JTRZo01fKaxKtPZ6dl8Mto2vG1BEGuAoynRWLnwzfJJEZdFl/D5L7Gtj
	 /+1xrFY8I6EkYavstBIuWcq6IOilRiqzhqPjNL4YSslWYZv1NaC9spxW+Ab+aZiZae7Td
	 0Gi6rarvyunlU+dEhQ+Gvriy6i9B+6yGqF3llGaJzvxIFI5Oy/sZduRKIkfrfVAGE7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uQv8+X+U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF3606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BF3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uQv8+X+U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFEKAf9X9aJaP8mcnL1DnWgqU4QkBLL4a/P5yt5wWTtNn28hdy7qfP/QbVTcVJk/0q7WxzElxbLbEtBDSshlXl0zhcF9Z7nL602YtzHSU7MzPkTuBv066nWzxvDWz0KXfINB2zhxsg/y71f3qfS7bQ30rS7MFsgwoR81xFAqU/KBO9ml4EEJ4kRvO81cnrI5CRDqrSI6y8Y9VNTcMnMh49BaINnePdU0D/a4hBdqKc4tPe+idkRv8rem4SeVKd5HMBd8IO8Ln7EOdAOaoTYjXV1lqi8SjkmaIi37IJl05GQ0HObphQrC7TF60nWTNV/PijZz61EnhGSDQOICFvCfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjlbcxM82eJn5g3IWYz2vsib7h/e1q8R/FwhJwKizbo=;
 b=jEdR47bmo2oGDpvo6N7j2pn17ttf7/GMVVeIdmtaGr2gcLRqjANyBh75+6cA/3KIusYelEo2RuoXKfWYVr875Xt9efmBEK6kUhbJVSSCH966DKZhD5bO4phjwBegWvgS2kgBQbzJGNWlL7oY6Pau7akjwo4o2f/jq1iFwEnov+qh4RgRIr6tfYF0E+1xEwsb84Numq/xaYT8a618dyJPfShNPEIfnEVJX7xijk9xyiAB6f/4oA2Xj0m5REGKR2/IFmQxVrBAyB6fA9nFLpn9tTFsBDJGuhHSuSF1EGi4BQGSOxIqWWXrnVGdhjIfDKLcFYJfaqRVODWFmzpBrvVTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjlbcxM82eJn5g3IWYz2vsib7h/e1q8R/FwhJwKizbo=;
 b=uQv8+X+Uc9woB9SlXtL0VlrQeYs+/H0D7e6Nl1W462w/faGj8OzctOLMjb5/AM7dKMw7tk68SbPCiyXvsUHy2qtEf/mJ1r3jSozjIt9NrybpgRyuPVgRPtZW1qcbIrL/xF81PZCR8seHanLQAC4+bKqWO9UF968BxcBKb2mtSDU=
Received: from YT4PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::15)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:56:46 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::a8) by YT4PR01CA0031.outlook.office365.com
 (2603:10b6:b01:fe::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:45 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:41 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 6/6] target/i386: Add EPYC-Venice CPU model
Date: Thu, 29 Oct 2026 14:56:23 -0500
Message-ID: <20261029195623.2209-7-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 223591fb-ac20-4e52-be6b-08df35f6c2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261028144727099003|261026121527099003|11063799006|261022105027099003|56012099006|261009223027099003|261021135927099003|261021121427099003|261021123027099003|10067099003|261026140227099003|261022075727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YQvclFOSiZ0PdCnknWmhJXT7xGswhFbkLIH3Glc6/Mat7ocblBiDYMunN6epyRtkxJwMCCfy2j45MZ72yIN4zKmiYTjyLesdWpfv2Rq3wlPLCaB6yxP3iGYBoCB4CypPPF3zm51V6lc3Ymzf6t8kVNOFjipdC8BZrBxWOPaXV4E8DIBGUNW2biRAv/ZzLrzAqFPDnh0pkJXSSAtgWwe3xQ7B5To+x3IRZy/c2aIGfHKegknviZaznI+c+KfGVOFmGal5wxfsj3CMweDHelfJGYGZuum+qLD/CaPb6sy0Bf71WtIgOUpe/aIVFtnhB09a1T1aonxLydhQjGAxNcYY3cV+es+tj4BDU4BF1BrCVEId6fsZ7jdH7FLYF1O6ycbuXWEP2xcjqdokZWEQuqw4xtYfiZhIHoh202/VdgwXyBumQ4gQ9WsWBGc2u0GQ4jiwa8tCkvRFXTtDJAeh3viV+koCrUIY/sdsWPmfQO2STA35t6wipR6QTz3O0M7ev2IpXiZ83l593vL73NeruEu6QA0uIQ3WX+JW9dvnBNASpN0OwpP35FoPwCBEO+fG8cy8W9ucsR4Re2zN4eUTcYZcL7r8JEyDIMDeTB6MbhCQamWnEsk2Dxc0bl1LlHN4/JTOrg19Ef0nQOGOzOAMydBU8FMHTZgV8jcZJb4JYP7+LzaXfw+dsq27ibOELFaWLQYRsQPrA69mNuz6HCsrmjdhDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261028144727099003)(261026121527099003)(11063799006)(261022105027099003)(56012099006)(261009223027099003)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(261026140227099003)(261022075727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ygqa60eJrEolSuz1vJMIbx9Xy8Xslh4Tn1Bie2ODKDhdzrgPNANWgDDJeTtS/QOAZs1xQcGC3xXszzJuEng+02rtHBmt6/l2l1/95MPGMi2eOqGbyZNt6+ePydi61Wbqi74Ve87K1lhKXFWaASXIGAAPVhiBRNby91EaavZW4kY37zvIf9Z/crm3uzuDz3jHQuZMw4ztcCI4EkE2aZdoLKUr2Kqix3b+TCJQ3VZ1Cowy25D8cZDuhnzuTO+Kd7mLq/7L2KagpV/Tb8NkUXNCulKutFNm2ZrcLD1fLC/dJ1hV7hCIi0SG8Q/2cnzll8H3Kou/JffGQb9LS5375msqc3dWFy+g2hgUlK7Cdx4tgnfuf5fKuN0VgfhNJMek7ZQ2u1+dGjhTwrZ8C2ZMtVv3/yi/Otnu/3/rurqxvfMjGuiWALVSeov3TmZGkfFVD3G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:45.5750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223591fb-ac20-4e52-be6b-08df35f6c2ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

Add support for AMD EPYC Zen 6 processors (EPYC-Venice). Add the
following new feature bits on top of the feature bits from the previous
generation EPYC model (Turin):

avx512_fp16		: AVX512 FP16 instructions support
avx_ifma		: AVX512 Integer Fused Mul-Add instructions support
avx_ne_convert	: AVX NE-CONVERT instructions support
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
index 69f6bbb2e99b..531d3d8acbdd 100644
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
+            CPUID_7_1_EAX_AVX512_BF16 | CPUID_7_1_EAX_AVX_IFMA,
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

