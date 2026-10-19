Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440868;
	b=1asiXI2oILSIG5nIvJ7+Jpn3noWAI2PlDq+YGD7IWKFQ32yCdYWrgw9qS5IV1mMZ2LoW
	 58VkTlIeXhnTUyHh9b2rZmp0bi+x99oSvsQIYNt9DYyo2GNoBpV3FDQYlFM/PscjGju09
	 INh60Psm1/S/1a8Xz2cLWyyESvFtXkWAfnHHnQgkCB2JMgiIYSKn8pbmWwDyUjetkTtai
	 CxREUaRZPcxoQz2pDk+nou0shByAXeLa22fa7DX1c+iWTMLanDFFgbyr4rbhKw8bqNUNU
	 LVl1Grv8Yd8RQKxaB0R1SFOczqtslVAMHTWZrufLqFslF1Z1zQR7KeaIaeo2e1UQ18A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440868;
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
	bh=UXkz0u1FkwEacBnrgIJ/O8jENAzh2K4QBg1y4eXkGHs=;
	b=osglwT9a8Y3miPtQgDgxoO2XCxbrfcivY6jHimzHM2ZcX1S42NBSh4PaIE9vsSWNjphr
	 Tru12VkjNkh+QKi/4wUHn9FV2ka9f3dytvEZwGcwhRO/PstxO6WR1YLv+ZsLGVPhNcSOT
	 GsPeGj0nOZW84EgCHuDSrz2Rv1tLUXPpubEPGku8nt5IQ8oU9VWvtXRPhnseXzSzgvDT0
	 JR2vxStwJPThMf8JpUHG8KCR55t6NIr+T+o63IE4jHCpOjY+y2ByP1SaPCEGKVk4pZub2
	 GIXuXhKFL4wGVGdurEW6BxZjtA5C5P+guBFh95DaM9tRlGeS75cKi5JUJZmuRwz/gjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s4B16yRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F744606A323
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F744606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s4B16yRU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUjy/1pPdboQkXZtkMDQ873DXXl29Y6boF8Wktk+a6ID7Nk+Ztbblu6rColiIVkSHIqZXHAb1b+Uwno8/MSUWYXBw2Qm1mXdo2k1pLmY3rzQO2g3ohEYeAiMQ6EzttmxO4fB9MCETDrI7fbqgjDOTkx4sojPsyHbur6n+30N9VgTHU3fMMCh4Cindnptxog62S7cuLIN3+Kt2Md+tkAm+DIYFPSlUTwQLrRCnEpqQQ/Ir1NS05gF31/SDftW88Df+R58fwNgpJjTyVzpP33QxKUDPUk2XtQN548+17d99uUoO6nrz+eicKsY3y/HA5Ag/EpyLeLZyJWb8cHkyvw9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXkz0u1FkwEacBnrgIJ/O8jENAzh2K4QBg1y4eXkGHs=;
 b=ihkKdaefQbl9YXN4WBsNWIDs9bmggyuZx/DGZjYIxT7K3BsVkhU47T2+C2dbVkzTs+RIklGTAAAdphZj7Pn9pnqfDmvjoHI/Ih1N17MJABz2SlK83OANNzLWsHGqEU/xqNltXNK1S75atpJLnIQJDKKI19gwUfCIJyAXHCetCRdMVAGp12+0HWQm7jeKKN1Sa6ZY466EDHIjG+8amPVbWLDIwxHvwKYRZwU16v39hxZc2a5a4+qSeuUX4yrzISXVZD+1kYUSgKwB5RYVPliHyj6hQLvOjACdOM5QFgMYhYkn9h8Wf4zmzAK8/SisoFCsDKAD62A1ckD2wL8mfPcWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXkz0u1FkwEacBnrgIJ/O8jENAzh2K4QBg1y4eXkGHs=;
 b=s4B16yRUQuu3qFBTUW6sbCechcu/7Jq92hjG1sFrZaTsPiMa/9yySYoaWV/lToi7n20wJFzFMmhb/Jf8C7xELm137ae2NtRqDV3HZsNgYrn3QejuFd9lAWyoiuVxpugQuFMXjcyAJSICQYbEn3cGYwJoBkCX6mPAC6pMy4+d8mM=
Received: from DS3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::17) by
 CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:14:22 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:8:45f:cafe::50) by DS3P220CA0003.outlook.office365.com
 (2603:10b6:8:45f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:14:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:14:21 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:14:20 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<yosry@kernel.org>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 3/4] target/i386: Add support for AMD LbrExtV2
Date: Mon, 19 Oct 2026 20:13:12 +0000
Message-ID: <20261019201314.269798-4-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 6929ad62-ce93-4c9a-a146-08df2e1d9034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VrRQ5e3UwCYbWiNmi0KxGiZweLG21uQNeblt/1jdjRO1zJhbWxTiJkAem/F9En7JqPCieSkrMpoIqZgYhvXfyVy1nEmI/283mlWYvsksC719b0UytqLgw1mHMitaDmH6dZBdEefSVLXxWg9RCf5nwMZdLAAOzUlHBlqH7kYcNx2BrcPTLuIEo8W9/cHBu7bAtXWhg5U8vb7DaziGTVL/W7QTq0uOnxxvUhOJOW0ESpAHAqjjg50CWQkPB92Mkj3dFQriDZDexSXYivZoN6j7u69feMO0gWRlevlXTlSPOLLnGp7ILJ6BJgek/BcwVnffxkD6uRFfivHjCh7fnebPu7yi463VNppjg2HCclyo1PjXzxRm0C3nDKExaViyZdN8ipkjjO0AqpBxAxzHWc2NpD8+cCGvM3KfkzX9MzFH6Jar4wJUgMJOM7UhQq1rE7WfCVIAijO1WlvSLuvuHjz78HvXFmf0wHy7wEXo2sZ/symjBWBodZXcxdlmZs/31RYNhCH/BBQsLu6spg8ITlI2f4UXEm41Ugg9kcchEUS+SpS6J118az6jkDDn2QoegzXUg6CC1kCPtxcUXOwk7l8DyKdpbmwVvhyyi2vGWTMOE9HI8p9ZyKshtQfixLKSn/JEe0lJTL/yTJ1EgmnW4gF6hV8Kg5rG64briBF/n38+JgMZ8DBjnjE5TvRjbQ7auK6luLJF9AkJCRxIKvDHZHuNtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	odFU9vuIswOdOWq/fTZ9bItQAlp+MEoELVtbnm1wIFqnUuFqj04zIL24wlL0HLk4Vxnr+2RFGdqmKpawpcBEz/3JFuGCf/G5xGLPnPkHpSethQTYX4ZTR3n1JGQvHq9ZW6f28KhrVL5mC02Xod9rascgb14zMLm6tMxmTcYlOzumjkuRurO+tX2VHrqTVWxvKJH9tVuvsE9X45BFveQF2grdos4jerJRPOkeIWpPpTYVFs7hhIeMy8ELROo2Hm5M7uWcQak7T0cYGNQyCSa4CUO9WUihVFs19DMVY5UQZ1ILwaeilA7Uoc59tCGpOkLl3ql1NQ5eBdMEuoZVfXA9uRspH38K1yNCtzIjB7bItg0FD0wtMzUSO5VLOzz8sJ/ZO6lsSlanqTYYhVPa3QRgshcpyOY0O8DleweIfh3FkxEc/8f7SvVB6VLM6W8s1aOZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:14:21.7354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6929ad62-ce93-4c9a-a146-08df2e1d9034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

Add the "lbrext-v2" CPU feature (CPUID 0x80000022.EAX[1]) and report the
16-entry LBR stack size in EBX[9:4], allowing guests to use AMD's Last
Branch Record Extension v2 when KVM virtualizes it.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Moved the CPUID_8000_0022_EAX_LBREXT_V2 definition to patch 1.

---
 target/i386/cpu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92d..f718bd02df0a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1468,7 +1468,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "perfmon-v2", NULL, NULL, NULL,
+            "perfmon-v2", "lbrext-v2", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -2048,6 +2048,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
         .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_LOAD_IA32_FRED },
     },
+    {
+        .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_PERFMON_V2 },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBREXT_V2 },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -9306,12 +9310,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
-        if (kvm_enabled() && cpu->enable_pmu &&
-            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+        if (!kvm_enabled() || !cpu->enable_pmu) {
+            break;
+        }
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2) {
             *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
                                                  R_EBX) & 0xf;
         }
+        /* Dependency PERFMON_V2 => LBREXT_V2 enforced via feature_dependencies[] */
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBREXT_V2) {
+            *eax |= CPUID_8000_0022_EAX_LBREXT_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0x3f0; /* EBX[9:4] */
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
-- 
2.43.0

