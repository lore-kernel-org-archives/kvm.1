Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440897;
	b=XK3VNworGLC1J2H7/iEEtDF21nXaTufk1UGpYUDRp4uIHaS4uZ1yFcaXdTBs03JTElWs
	 +Qxut3oTeINkfBoj/2tJ5wqJnamoyughT/5FyFkLoL5jPiBG01hfja6mciHlGqITCybns
	 NDMT/MfKHC6QmyGaY0f7EZ+7rJ9e7jvG3UFvG3y7LtFy+fPBQRYrxZRda+SdMnuFgcyFK
	 P2c5BZ4L5f3rRsGShypJqTn1E4WCk5cXJBX/cQizkZGDbBXT5oIvueDTvzobBk9hwrBKb
	 Wyc0j9av9nuugFUlF9vMTcQVYcwAhGft1G0C5uGASJZaGX+SM+jbGLnNA6oUN+zZ/+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440897;
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
	bh=yhBtPLyOEqTXwsd1h6SLW0/qsqXiHUXJc6q7NowgUMM=;
	b=Yazh7hNonWiCmAHQjC6cB0phy3qC+MtDAHClmVsqW0NqCHMSGp91CfvubYLW1J8Ng4h+
	 GYrpXGxjD/cJYW6VPWWGk42P2RCrNJFwLjOI86vPosJOpDCqumwSpkZLt87rnvQz6mk3R
	 0Ex88LHiLJ3U2LMh5OA5iaLl77hKSEARylSWWtrFdvmR0ptGEZAd4KYNDVoX6yaPrjZeq
	 RXG9zvIPnxYq4s6pjJ7jkAnFr6bDTa84IzL49KhNrMgeBfhYHrAPTCvJduSJbx/XDpGl8
	 IubHB+7zS4rQyBzLJWp+8Ib9ycP0QuRpjw4gaFxpWOzLR35ukB4eSeGTdA14S4E/CmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=haUKtS6i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.22
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AA606A325
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 148AA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=haUKtS6i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhcPyWd3n5qQlpkydQamRjOrb8Esoa8UpHY2yF4+V5wBKPMw2EZCevrur717CPoZxiuVBpGpfyvm18+VWpx0KoqU2aS1dLBF+qBwu+1wm/S7HStiJXCFbFZDtTzEE5Ufgz+hC6ESMfVHndj3Al62MaUDbDhOegO96cnMcZKc/Jb9PzExeG1PQjZ4wXLDC6f0CrToPj1JD56ykfUY8GuQ0mNk6nDisufDcMJewsxXfENOoAmNchbJ9d8cgLR3cVpGgj1LFsEvzLASYjsS/+VfyaIO5zD2tX5YsGkfmRB8GJa/3MPZDGj6NClGMiwObN9pJfO5DtlZBa6mE+CK5/HqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhBtPLyOEqTXwsd1h6SLW0/qsqXiHUXJc6q7NowgUMM=;
 b=IE6XU2jK1o3QF8TmiAGgqBxUPmZlliHTbK7ldGJDtBRtrEm+sPoRNDDnJW+ZwoBQyQeIscytj2XdChatRyQxC23BN0AexTKXbdBgInsLTHdbl6i9GNTwon59TS6xJ2BqGHEaBYfnHyRVnG9SLzY3vM6ka2iQZJMgLAtyOMkzTMhIYDIqvSKVy7+J3Kj5bEiPHP4Wat2i3W4IcJ9lPaiHQTxzztnREAR8H9eN19vXyfPWsdrwReabMnViWor59jWbcuzbZ7+q2wGLpWzSpAkRElj4ETT1EmMClnDvRt4MVrn+pOlXNhTfbXdAqVYxQJzF6Ga3qwQlo4oB1oTnGyOo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhBtPLyOEqTXwsd1h6SLW0/qsqXiHUXJc6q7NowgUMM=;
 b=haUKtS6iG33MuEKzC21sRqTNGT7sKbz42UyRNBskozEOjcPQZr2TEfos4ELyaDFa/oVATrsxIXDMtOexvoEfrMaYHh1lNHP2HmeGD4FadOZ5u9KZFm7pS9St0kxYUyEVuDOTVxLWov6fvP6uLZPfleltJTR1rsM012vuMGpOY3o=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:14:45 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::4f) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:14:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:14:45 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:14:41 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<yosry@kernel.org>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 4/4] target/i386: Add support for AMD LBR/PMC freeze
Date: Mon, 19 Oct 2026 20:13:13 +0000
Message-ID: <20261019201314.269798-5-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019201314.269798-1-shivansh.dhiman@amd.com>
References: <20261019201314.269798-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: a82e34e4-1b0e-4a14-2e8e-08df2e1d9e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eW5N3yl6fkYZRpsGUvt2O5igToOP7rFD2G0RcpRWfltfZ4Kpc3MOJXi/NrSaFHsswpJ2YTaPq+9jcwXPrD+acuQXfqjOE7q7LcBJfcnb9WQ6PmZsNtd6myDVegE3R8j9ybVSj6U4BLJE2WmDAUil5Fm/byoCqGdsk90OaGw/5XQQAxKqJWZnQywWDA5+gGqmdsUo3u3PnW7SOsdfdoiKHfyVGKDw3V4ANN5Ma5XSnF6zL6XjSofsRrMheYeBZR+NHPxHvfu2u0+ryHC6JRtXCMCXUZqWF5XC+WMsDDKeu1OVFcMvNGy+uiPtf2kA7ZHkhCk7IspwQM1V2Rbq10KJ+ngTWkG5SAYrdjH9Mxh23F6Ah5TEhyU4qoFSEN1TMno8uq84JIRlZ4PKDEQAGYFu7MuSXhZYLwQRTBg38gvJztxpKl14iCB7NXsqHViOhA+gT2nG1zAsZdNC464d66iTh0NP2rJP+jTsKj0IZeziE1xKCP/erStEw76pDw69IRSJsTIlofW8qub9L6Ee61L4aGWm4UzA1tEhpFN5VwaDQgiOTpwcl+cEJ8Xzs5RT7MuLzmFqpZSKFBO2hbxwPdWbUTHklHG5cbaPSO0PU4hWE753dBxCyRlYlrleBbkKRHRgFcq8REz0XM8jAe3N9ikeGRK1P0Wd873kVCJWraFh+xuSkU4GIP+NBrT/wMGgnNJBWAeUrl7jlrooV5HcUmTMSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9UXaClLvvQB47MWkvByS37H3F6fuzP5ertN/qyo2OPTq+IV4MkMSkqioNSLpdKNNMpNwf3S6OqdQ85gAdTBmEgu6MLBrnahSFl7kXPzoNdRPSinTQeVKU/pwLtp5cBiECg7v2KLxxO6/60ixUYzGjWZyhzUz8HSTp/aPmlvQ+iI1tIcbwJkeyHV9WBp4YYxFiBaDPD5Efbgv68pQ+nhlmbfX969KyetWLNHKEgnrESBMr5a28Mzoyz2oJm2UoCpcnWtZYB3VEwwWe669Rh/M+bu8llHMVjWWLZhkprCuxQR311e6kOrfAU/FCAv2k2ujrJcfLD8lGe1kCu2O88abWckRX23yIR7c4dlceC4RseRwJIu7qD3kLZLNKUeadLzFc+XDK/3sF1mDXFctcOQN+APv0vS0eEtXwDEMBAiJlu7lBU2xqRHUXEPdcLAWfT8Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:14:45.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82e34e4-1b0e-4a14-2e8e-08df2e1d9e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add the "lbr-pmc-freeze" CPU feature (CPUID 0x80000022.EAX[2]), which lets
a guest freeze the LBR stack and performance counters on a PMI. As it
operates on the LBR v2 stack, make it depend on lbrext-v2.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Rebased, no changes.

---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f718bd02df0a..ed88b391221a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1468,7 +1468,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "perfmon-v2", "lbrext-v2", NULL, NULL,
+            "perfmon-v2", "lbrext-v2", "lbr-pmc-freeze", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -2052,6 +2052,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_PERFMON_V2 },
         .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBREXT_V2 },
     },
+    {
+        .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_LBREXT_V2 },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBR_PMC_FREEZE },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -9324,6 +9328,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
                                                  R_EBX) & 0x3f0; /* EBX[9:4] */
         }
+        /* Dependency LBREXT_V2 => LBRPMC_FREEZE enforced via feature_dependencies[] */
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBR_PMC_FREEZE) {
+            *eax |= CPUID_8000_0022_EAX_LBR_PMC_FREEZE;
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59bc1c46e243..6555221e3366 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1229,8 +1229,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_ECX_TSA_L1_NO  (1U << 2)
 
 /* Performance Monitoring Version 2 */
-#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
-#define CPUID_8000_0022_EAX_LBREXT_V2   (1U << 1)
+#define CPUID_8000_0022_EAX_PERFMON_V2      (1U << 0)
+#define CPUID_8000_0022_EAX_LBREXT_V2       (1U << 1)
+#define CPUID_8000_0022_EAX_LBR_PMC_FREEZE  (1U << 2)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
-- 
2.43.0

