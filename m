Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287B531B03;
	Thu,  1 Oct 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867538; cv=fail; b=oMiOTgOdQUC1gZFZc3BCNLW1tmCWkSdtV/5OEOazDNMqLcUqbAssfUNcQTVqzI774EvARySbvE+0DQpjEI8VgrrVWNUEO7aHqjHyeXT7NjgHuK3OEk5lVL5fNPiCUWcsYVquBG/IadXGKQ3mWUB3aTF+m+QJ82tciu5wh3qLVKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867538; c=relaxed/simple;
	bh=0kCL1zeZSXIY0pJpvKSsZ/aj1087+NJLyaOh8w9+VQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZwm0RZl8falx2lbz2op9Cggfa9J4sPOYZQivpDaS5mIDhFLJdsBJ8bZHCFiSqSNWQMOpgwW8KgnE4QAVv1Dj6Y+MP7PwC8OKmtg+GFn3/s9X/HZCS3+K9mohzPvg7o7C+m0RMm6Jlp/bQ77jMdJhuqwvUPvjyjlTd+9uW0HF/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lRZz1wyn; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lRZz1wyn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq9ViLdBXH3kCjlOZGHXYZ+JqZKZ68ry3Sg8+sGg3HP9VDXr5uk4UazpkFBlnChnNnTYIV1u6nUtc7mtEb4ahFKPACad+tiztkS9VV20YjSaLj2jYmLx55Ws8QmEKJ1YEy7RwDm4GM2eoDP7e3O8zFecwvJT/HhjY0BsPHK1+xeoltwxH6oZjyKyTZnSigqk3XqdLpV8UOteI7JSYL5dUQbONeTca+LxIaKnINIpfOpbF5X6CelirzvY1jGCFbMvgXyJpSN12FxzZyCMFz4cRqzvSk/GDFmC0BL3bBxLy/bvhwymH6MH6n/ZxdbQRd6E54tkKEuZJSSlS0J9L+N6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOujb6ztzYI//O78R4sIfIjH1tqrklMj8GeW0DSc3VE=;
 b=oac+ieOV5Uiienirza4VIyG3qptnQHwdDCKvfQQo2yGJ6fCEBDnP3rnm9+TdiFT6DUd+Sm/S5PX/xVm6RCAOLU05u1+MXTV412oj2jnnSv8Viv9FdBlfnhhCIGmAVO3Rskwn9P/06doAEUI+WumAcTEE0oSS13oqlzMMW7NjvU9Yp4fvmPNuJ7CTffy+Q4vUP8S2ue6t+Mt5PDlc4W9nMfDD8KZyCQTxDTYUbVWw+qV2kTCPbTY1kXTJgKGLBMvFlZfKBhoZirEFv3tSqLxzd3eP0irg8pyGU0Q6CDMUgMUAPXJFrxqBVdYBWRIsrdLgqyfcLSHMDDCH3rMGO9Ta8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOujb6ztzYI//O78R4sIfIjH1tqrklMj8GeW0DSc3VE=;
 b=lRZz1wynlKyJWKvOtOM/feEmQvR2JRg8FkKnuv34WNpoTioT2Wpuga6OF6zYkUmNyKDcx9PtVUU+GI/CB6m4o6OzinE4M/Lfb7iSb9WntwUozN2SmXFcMRvkqI5BcXZwgEGa93v6kkpSFLSN7twVTyrxYtCe5FyaLf+oYA1qIMo=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:11:11 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::7f) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:11:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:09 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <fenghuay@nvidia.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dapeng1.mi@linux.intel.com>, <elver@google.com>,
	<enelsonmoore@gmail.com>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <seanjc@google.com>, <ewanhai-oc@zhaoxin.com>,
	<binbin.wu@linux.intel.com>, <peterz@infradead.org>, <ashish.kalra@amd.com>,
	<superm1@kernel.org>, <chang.seok.bae@intel.com>,
	<prathyushi.nangia@amd.com>, <kim.phillips@amd.com>,
	<ackerleytng@google.com>, <elena.reshetova@intel.com>, <naveen@kernel.org>,
	<darwi@linutronix.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v6 02/18] x86/resctrl: Add PLZA support to command-line options
Date: Thu, 1 Oct 2026 10:10:25 -0500
Message-ID: <bc2e144788fd42fdf2a3b4920e3d9a5b79c175fa.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dca8463-779e-4209-17ae-08df1fce3a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	z0rNGE75QuhWoyBlpvSP66goGc1r+V813t5c84L6ZBSdMJQlBACI+4Du3+fJrC8Byt9oIzLXUGwiyEAQMcUqfZLtE3v+zV9+qle+9rFfLG/jMQpdK3n5X5PpL6F3HxCkqI3O9A21YBB4bTrjjgW62xlaFQTPew6aEJRnEoy0J8ydE9b+A64v9BCbaXM2ZrkfXP1uMB6aEePFsXchvwP1Cg4Wxm4gt/7NfryX7Jgli3vfHnuKS7JJsUZF6JRHaHR9BuC/kjZPFR1oi1VrfMSIVSdOUHM+Vi0VWCKDhiU7NBCV/s44VrnK6SlI3d/hNtXPUfYy03L67CC6eRtSiXf7brsCabwUY4J5ZLpdmZNl2xoyE3kTQHihaVz4JC+P74kM9zV/SlUr2i6Iwi/fB5ry3aUnRXfGVc/Sft2m9QAzfQ4I67KjrKCjlBkDP8byLoeG/g6IZpSwP1oMEN9E8sv19dWjTbRsrJIS7gsDy3k7ejWfESETBJgd/Rbd4b7xqD915Q9uFdC7EY0v0Z2h4209xtxnew9FmC9rzCJyIairFHWJZAZKRsFH+ywfbHqhr3gssbr4DeIWw/W0WOZWUj9yj1i6EzEZsk2fI1aWJgknfYHi2Ow7wFhpT+6jlgpBcktaQIKn+nYhDGQvzckT/rouPSbV/J/Go4NdTbQU9PPw86SLbEXiJsnjLI0+qOteTaY+I9G1BqAT5e7YVjZuGSUo2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ukbSfHPoBf9bgE3J27pkD1OmIOR2vFIkVTMJlmVpYVg+ypKSFDEM2mW9YROnPz5+mzNsE+fqn5BZvaCCYg1olD9xIc1sAzpZgqeugvcvH1tP6FDN+DAVzcdH8z3R4lueTvM9sD77ihz0I7qYbRAYJHj1hNKyqnRd3XqnQdt31r2J/h2cEkzalgnNLnVWj4C2C0pnPuYAtOcISsMNfl+3aRwLsOcSkrEpTWE8y6Z/14phR91v48f4Wff9LY6KcMC82uIpeWvyzcmn6i6iJlyBZucp+mPpYGWdAIpjxp7ioHLMiYw9sWc95KNaaGHN+2rbsxnkqXcdEDraHD+c1mKcNIOBXz0eq4Fv/YNwMPPd7yHD+y6699Ey6OVDoa4JkGivW3vqe3sRiQpCKSr7qgaJ+Krc4Mq9uPMOl0azJhdezDJYPG0wXVx4H6641xntQBcH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:11.2881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dca8463-779e-4209-17ae-08df1fce3a65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB

Add a kernel command-line parameter to enable or disable the exposure of
the PLZA (Privilege Level Zero Association) feature to resctrl.

This allows administrators to control PLZA visibility at boot time via the
rdt= option (e.g. rdt=plza or rdt=!plza).

Add "plza" to the rdt= command-line parameter so PLZA exposure to resctrl
can be enabled or disabled at boot. PLZA is exposed by default when
supported; rdt=!plza suppresses it.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Updated the changelog.

v5: Updated the changelog to mention about rdt= options.

v4: Split the patch 1 from v3 into 2 patches.
    This patch contains changes for resctrl subsystem.
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/filesystems/resctrl.rst           | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..ee39a39ee9cd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6449,7 +6449,7 @@ Kernel parameters
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc, sdciae, energy[:guid],
+			mba, smba, bmec, abmc, sdciae, plza, energy[:guid],
 			perf[:guid].
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index dd4f80da419c..73bf89d0ac83 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -28,6 +28,7 @@ SMBA (Slow Memory Bandwidth Allocation)				""
 BMEC (Bandwidth Monitoring Event Configuration)			""
 ABMC (Assignable Bandwidth Monitoring Counters)			""
 SDCIAE (Smart Data Cache Injection Allocation Enforcement)	""
+PLZA (Privilege Level Zero Association)				""
 =============================================================== ================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 55214d6fdc49..4ca8bedeb995 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -803,6 +803,7 @@ enum {
 	RDT_FLAG_BMEC,
 	RDT_FLAG_ABMC,
 	RDT_FLAG_SDCIAE,
+	RDT_FLAG_PLZA,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -830,6 +831,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
+	RDT_OPT(RDT_FLAG_PLZA,	    "plza",	X86_FEATURE_PLZA),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.43.0

