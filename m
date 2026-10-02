Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBA43B3C4;
	Fri,  2 Oct 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976442; cv=fail; b=ARnXz7xNUFKc6qzamAd/7aWrWYvy+DsE0gEBPY9wSY8fnB+K5WUMdC+Gx7ET39l9MKRv6aGQt0WkjvtmGKKFvZY2FlNf8HAalnRcnoDtANQDUfhQC+6IinVVlfOw3xBFgPTGNVWnp8D/44FrHuckCJBDITnmED5ujbkyp49GPWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976442; c=relaxed/simple;
	bh=SORkmOH6BzbMHCLFDwZST1iDdIExBEEKWuwHTqweh5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO0YhB/MBnrYUSDi+UFzPHZjeCE57jR4xCxltRzAEzw3RLWU6ZZpKoRexv5SBEMEk5ZqH+6OOJyv8czg4OcQi/D0oxa3QRUfd9jdEcHOfqzsvqSq8jQzqQ/ItGT15Zv4PineGQy6hXqJ897muuRkAT3HaJsi6R7mQfCiai4AdUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvqIvcvb; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvqIvcvb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3C/cknkFuTCkl4ZWLadY52qtbbOtT5LC4zio0JfGrx/AQfD/gUuOvYWN9jAgTMWXJaC4ouFhrQP4EBw5UqIi+qn6MYfjnXRzAUMYtwQVBDQq+kquwd/OqLqOJW0tsve79Z6SAY9/gbuNJ8WlRWUXOLnHQ6VLbAB2U45gWy7P/AGtGmIM7x1h5Gu1MC7B4ABHYstSCV0JsZyHA2op7X0BMROGn+/XR9BInOcQ1OaVqKJEryA8DUK0kLI/doC2ggRr5HbxGwoOO+AWPzIn9I/EgT/x5TibN50unoDh81kzQn+rPfbnPKCA5YW97Cj9UjX3InlxPPYxoSxBYzs4N/Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3G5jLluIQ8/dJRiHU2ADoSbpe/4zZdLHcxbfaXVkgA=;
 b=jE7mqr42DchdG4mf7bTtY9qFilDaUubD3IWE6NLS0WYvm7y5A2h5MFWB5m3RUSy4juwGbsTYuXItmf76t+9a20EDmzqHxGDSimsxf31VY66sd4T7eJqE7lPt/ix4K/K1uwMx9VWIOF/hdDq6z7uNjEPKq3n/YJSfhBTCF8OV7DhxkbCP7NSCpK1dPrOuQ6zb62852dnOCuSlzo7ovzttz5TrwbwMw+k9CzxN2hVmMbkjFrwCWWnHJw/bRlIdwR97EZcxoskVdNLW8TvIVmvAyO8IMCumzICAY/7YRPE9imPvwTcnY2kRMrypzCWtajoGIo0wNT/42r+FiaBb5U6IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3G5jLluIQ8/dJRiHU2ADoSbpe/4zZdLHcxbfaXVkgA=;
 b=hvqIvcvbELxtEYWK4tGHmIHVCP8P/7o5107zvP9aUoD+YiO5iEF4Cw/dOZdwg7g/7lsmTtNCdA96tWP13/OHnnaIJhxUUfYk7jySolwlu5VxKZxXGqooG3a+2rG+1AtOKVFMCCCI0VFsPgVl2Hp3DWAu7CEbKmRVcBM4QmGhiEw=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 21:27:16 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::45) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 21:27:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 21:27:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 16:27:10 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: [PATCH v3 1/3] x86/resctrl: Fix ABMC counter programming
Date: Fri, 2 Oct 2026 16:26:39 -0500
Message-ID: <95bbc2e322ac18e2566c4963b7e6d13ac8485e20.1790976400.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790976400.git.babu.moger@amd.com>
References: <cover.1790976400.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8eafc5-5695-46be-5738-08df20cbeea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|13003099007|3023799007|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+wgX0734L2qWzgSsKkFLIvTeTvoNkC/ie1l3K9G/hA5cJ02f8GNBNFR93ruc74FmqQSca3tlZYwkrTfutG6uzOUCfyEuGJ6u3p3L6o77yC/HQ6lhu01HCUD8A6RX36Hm0C78BQq0rEoB/+KWuVdVvjQLOZS9k4qqmJcpGCfeM+5QBVtZfU2m5Inif3hoa61JitIask6ZhJwBO6UOhcLRGIZyNMYmw1U4MtKYTJYWjx5VgEEkPl2Oh1e/ozjtu5Ut8kacQdot5qA5b6r2kdHm8Xw1lvgB/TZ6Zoko16TIHlDaVHnjlHuvBnCcovtGlwD36UuRecF5nJp+5Y+6esqAIrxIYxDpl3EjWxbHnvheOsQJqyZ6AF6VE/3ffNUCG7C9+8XJI1BxjXaT7lx/9w0z9rclRe4hit0vYLSFm6jvySNjFLheOZLOVpCIncF/FtfJEVCuMOKcrjqPim308EMLqwOIH6+6NgbN+icWx34T0U8ZDfhbQJ4RKVPWSeCk6tHCgWAL9S//oscJZEQlqK3BMsciiBc5i24+OGeaTCGKhjlOTM+/R5NH0aVwnjcAO6+uSUMC8mJLwsF73PuuRb5p7+2ga7e65ifJ93s7pjEQHP4BMGaSgwK5sBg0rJq3UyM04nxTf5FWcDMTSH7nQ3vxSxvHwthtvPInmd1fItR4SuY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(13003099007)(3023799007)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JhLGTb3KMAPciC2IQ4jf8CH3Ps4f1avoQVk96KZxHxgO7Ktz3JazVa0eX/q1UgROQqGRHx65RQTB7yfZerNsCeFqenHGK/r3un/RCsDe+rm6AMaADiXLZRJBvUaS521CjILTeEDC/0HfD0q9eaujimgtNvRRK3upcetmsyRRxs5ohjMQg1PUEytPEdB/hGrPp6lazIPfxjkdiEymNrWD3y8Iss2j3yve2+cJ/mtmOO4Nj17I8bGTmOJr2ZGoWycJeJZ01YbBH7ClYbcJvIXGcuoks/sXIEfI3VQvlBEZF6K1bfJCSARw+sM2a/bDmrjVHicJ15Fw3FNc90u2KPENMGvujLhjBGzyy2W548ump6C2eXT9tZauuNRqtn61k+aXvufnG8XEKCGiboecOWaqrLU2qHaD3bIHN8q3bKwKGhkUelsLLSYPZ4ygypTD2a7P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:27:16.2889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8eafc5-5695-46be-5738-08df20cbeea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
MSR_IA32_L3_QOS_ABMC_CFG. The architecture [1] received an update that
expands the counter ID field (l3_qos_abmc_cfg.split.cntr_id) from 5 to 12
bits.

Use the updated field width. The number of supported counters is enumerated
separately. Mark this as a fix to the original ABMC support to avoid
misconfigurations caused by truncating counter IDs on hardware that
supports a large number of counters.

Also limit the number of supported counters to the maximum value that can
be represented by the 12-bit cntr_id field if hardware reports more than
12 bits.

The AMD64 Architecture Programmer's Manual [1], available at [2], will be
updated in a future revision to document the expanded cntr_id field.

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
    Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
    Bandwidth Monitoring (ABMC)"

Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v3: Dropped the fix for truncation on 32-bit x86.
    Removed the change bw_src field(RMID) width to 15 bits.
    Added new check to limit the number of counters to 12 bits.

v2: Moved the link tag to the last.

v1: https://lore.kernel.org/lkml/980f39d3a0e0d9f73925e362f835aeef070a1bc5.1784322818.git.babu.moger@amd.com/
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e3cfa0c10e92..ffd74a68671b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -214,8 +214,8 @@ union l3_qos_abmc_cfg {
 			      bw_src   :12,
 			      reserved1: 3,
 			      is_clos  : 1,
-			      cntr_id  : 5,
-			      reserved : 9,
+			      cntr_id  :12,
+			      reserved : 2,
 			      cntr_en  : 1,
 			      cfg_en   : 1;
 	} split;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3838e0a13d36..5d0d3b18f9b8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -470,7 +470,8 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable = true;
 		r->mon.mbm_cntr_configurable = true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
-		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		/* cntr_id is 12 bits and can only encode 4096 counters. */
+		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
 		hw_res->mbm_cntr_assign_enabled = true;
 	}
 
-- 
2.43.0

