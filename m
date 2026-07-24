Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDE46D0B9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924011; cv=fail; b=sS0a5l8u+dq5nVDWtNNp/c4GoF3WBrzgSlhN0BjX8d2GCcHUPiPPrgIU6YnkxvX7sWr9i/ILrcfB4vre7ppIkmAY/PKj2bbcotDvViXbn0PONQgG2FpeaNg48SAJeyahVaRUgk+msCkbkLRydvPz/YJ2ZOn04IbDwDj99BCGH5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924011; c=relaxed/simple;
	bh=UI3D4DmoESTdbQUPDjJjtzx+OX1SJ8VxXEOgwr4n41I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrvfJ2G0zwxZrrJkmgNrpIpaiyuvI67k+r7LWPxgbgbh2vSHeHcgU8gW65uwU5Ng18tMNRz3o2EdL9IYL+vobNHgew1RH8jGD/7WznOVGpcBP+BBMzBOBqAggUQnpDgAFse/DJ5cmaalSUTisAdUrty1SAPw0f4mbbkKCuIbLQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J233jayc; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J233jayc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx1ENXLSJcJ3s3c3osIFNSJxoEdq1BAZIl4fGlGKeczx7iwt/gmsDdfeu7AjmqRWhusSrBUE23aJSf6rc4ixZ2GVvHRxg/KGbOMmx8ZvNLLtOjR16dTj+HgV4E1x0WaWrU5GJM9kp3fmTllEkpNqZed79rb6/hQC03MOpweSAzBwEkSAoOuUudPFGK7r/Smy0GLMzkI2ORbpRxJYBWvl2Llh4XeE+ZENyr5HbjaPRdp4iUm7lwR0mh+H+ijLu64qsAj4I/IBa/OGn+sJGodkOUcwJtYC1zrTs7S3z1sX+8pq+npqeJKfXpvVWGX2mn8zZeHryGUlEczgk9wG+DNThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltAtG+kIPpJyr+pC50fsSx4NKfpPC0CWvc8R93Av2VM=;
 b=lTyxGSTZvVcoe3YZ8ipIsn9k9UhHy6o+0UC/rxj/hppi1jcJ8KT+SrvDEV5Qwv+K7lLa4j5+bNnJBxbC7kgqHbCi/cxB/d5kYwypDriOVfNgxJphywnLK0FKeKSgmkCq4N0FOBiFLreWqxe0pC8WVTTRhUpx0ydZbqHu4ETXISnNs69uw1z+cpnu48j5KlMu3glHfv1v05dp7TnFqMMyYImTb2lHBiBZ3U2O7tQ7jQSn7s02PX6waSxNr1K/I0Ym1XwnLC1yithVrP9q130/t+rusY/fbMLWoPLaUNJr04BGi8ldUxekdJ1NUPus+aaLOO54iwTxUeA9GfDsblRasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltAtG+kIPpJyr+pC50fsSx4NKfpPC0CWvc8R93Av2VM=;
 b=J233jayc+eOvx0NQ3EXpu31K7bkpQ2Jn5Vuqucc8Ytc/9JmJ83LtM7g8e4BgDS7NGgFF/XykKhbc5xVoPebYhrQdbzJgL7u+5zyC4PgjxngezMbTRoM0rG257//1XWhNylGhpZzbYoewJP4mtuIMyMok4bFpVxmcJcIFydjBuk4=
Received: from PH3PEPF0000409E.namprd05.prod.outlook.com (2603:10b6:518:1::4e)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 20:13:09 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH3PEPF0000409E.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.7 via Frontend Transport; Fri, 24
 Jul 2026 20:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 20:13:08 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 15:13:04 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>
CC: <zhao1.liu@intel.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <yosry@kernel.org>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <sandipan.das@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH 2/2] target/i386: Add support for AMD LBR/PMC freeze
Date: Fri, 24 Jul 2026 20:12:03 +0000
Message-ID: <20260724201203.633799-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724201203.633799-1-shivansh.dhiman@amd.com>
References: <20260724201203.633799-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b9bb8b-6359-44cb-1d37-08dee9bffa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1AODY5NMZWuJDHY3An+8nHl/Zpkaz+eR+0p9i7pCCxbwDhBbr6lqXKEYIf05N8dCBCcYem5xlP5XugqB7CsWv4b1himouBPuo55JvF1jBN5QLTPgWkBl7tfO1Xe4Cx4Z2BJ5vcROSacRXfH2id/VTAAKSB106tAJNgsuBbzdFfjfI9Db5THLO6okOZIp2fdQv/i67rdDg8U6stGvOgFG9C5ku6Pg+kC563ZFhHRUnsNxtndAfKO40y2LuVFuL5tVwB5brNqDC477ph/d3WSTLC1W003pi9PW69JfTyLGBXeeHFbdrP4fgt+AqKtEryiUNUoPDiGO5BTEfzTiEBYSQcykGUVdSyUojtbENfGUE8RCTpPiZU+NXqBN9iPFX6NBSBPajDnA3rmXyxU2V77ELleO0L8udI9CRKxQWWlfRcj+ZjlyRJKpS4Vj1uPUm3UHl7LIAxnQQi4N+FwYiVFw7SO7dW8Vsi5kCZVt00ijSxWf9p9wY67B8GHRwP3IkpP7R0kRG95Z2JEbG8LGFh9X924Z2jy4L7mO6E0kLs80XT3ywOuAgSPJgthxg1ATeBmXNP7TBW1cBqfonkB0MI2f89nMRkHprHHlveUbRPVWEX0b5P/e42yygeenabI1/zxVt3n0Q2Nx9MGqML3BXVbr9JJW1/4CI6shsShGFPffx4JF4P3LiSPDkSNafgAGrEdyxSRpDdwP/Aq9oK+zcTd5SA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SZadiJD+SpCcmRx76a3FImpsIn4LLeAoUzmyAi90odwijjIGxWmqFGDxpPYJcW7RxqJZ0KzvuwbpeBlJJo8Bcf5M1nqcmDi+TIx9ZY0aalOsIdSHBOY5VaJDzO9EY/9yi87W7tgecRQapPj2AfdNCxaY0mpq5CDftB9L57RM65iavKnqWb/yh2pwiUgaIdvH6VfmSxX+gJacMFnbDoVV7/NdysAEIseMBpe8Q1ZgINQQB/ZzyzQAwmMeV6oHeLPHB65GCf/T4MED86PqNXz7wHCBiTb2ilowxHkkuTVBQw4h0wF5RqvD20Sa4162FaKCgbYs5IYmYXGbHrcuwDvGyNvTcEneyMw1hFk07B+2UHvDu8PWB0rYk0Pa/K6BEXaS3td1Qr2zvnH5r0mgo3u9kkqRRYQkX8hPTUyYtekHXqDV2TB81AQvt3WsVtVQl+Nk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:13:08.3876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b9bb8b-6359-44cb-1d37-08dee9bffa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

Add the "lbr-pmc-freeze" CPU feature (CPUID 0x80000022.EAX[2]), which lets
a guest freeze the LBR stack and performance counters on a PMI. As it
operates on the LBR v2 stack, make it depend on lbrext-v2.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 678863de68d5..b22a2a9314ac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1464,7 +1464,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "perfmon-v2", "lbrext-v2", NULL, NULL,
+            "perfmon-v2", "lbrext-v2", "lbr-pmc-freeze", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -2048,6 +2048,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_PERFMON_V2 },
         .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBREXT_V2 },
     },
+    {
+        .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_LBREXT_V2 },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBR_PMC_FREEZE },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -9156,6 +9160,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
index 64e40a654260..c8f51531ba85 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1220,8 +1220,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
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

