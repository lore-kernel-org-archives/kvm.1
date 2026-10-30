Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392160;
	b=nHjObcJex1jJWsDuuy1DFfB4NG11fB/TnRDWKZhZBJJ32OJWrnCNWF4lq+KkYjcyw8Mv
	 tssknTQ2c4bJwYHUv6p/T1mCGsWkfqS3urNW1i9fKCcpj8qxPRIh9wGD/cOq1XqnR5kFn
	 JqogmZXP3i6XxwGTs+0yzo/t/YeP7D1GIauAeP7ekzo/boAKhEGL2iT3/6elmirPtigOz
	 Zx70n3PzYHehbupIwdlVOsUEy1rhaz9sGh3PCpYFSuFOyL4Zz9r/ppc5GWV2HtDk8OFCg
	 nx8zwSfrnXyl55uqH0RH9t67y0KC9I1S83sSVjCPh4/i1wQWEm82M8FmiG6tObzESXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392160;
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
	bh=gOAKYplRAVGpqSRIoBikQrmnJiVXtEJLIS4oj6XG2cw=;
	b=Rgolz/R/OOwWN69NzvG4cNwxSvgpdZMGk3u6kClFa/5Cr+fB9qpu1wArd2MSpBTv49IH
	 h9zY3qglJKh483g3PVuudbZkahGes/vZjQxePDXKOo4vi26avCH97dYhWMC9xLIFpU4gp
	 /EjJLydqPMt93OxdSTF1U7HlXDAyJX8Yt3vZhFkRLRYckRDXHT3ZoSA9crymZiE5TrvMp
	 9/IoqDmuo7RCVkRz62dRddd5kJ3nn/GbsVCdtfV5uaSmjnIGpIFrBU78u5DT9ghTgCOBs
	 s2jT9RSXRO/OTK+sZ1EBrkPb/K5B4GksembemIJE1Gl2nOsiJBeypQFOV5cahyI/KPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k1LDP6xu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEB606A31A;
	Fri, 30 Oct 2026 20:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBEB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k1LDP6xu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s22vpCcrpt8/03i5EuaXzLZ7AiIycNPAxNlpxsABiaFCoNJvdJCQEykwN7MLb9+ZpGGBnXsAoxvIWQgB4g8uZjrr5ZNVk08BeEaP6ObTYbj+sHVvHGel01ZHRlUjbYmiemPetjXEeygVPrkLzIizeRkwI/4JDbtQly1/jFz5gNr6NuQrfCtdWpkXV05kmLMz24qUqzZ0e/mjaTg4muOa0e5ZccfAadylMMhUKts2egcQe15k+pefOf36lmsWlHFnF96dFLM9+Qjn7MZiFI98gYm5TYGYaobhmd38/F2unI/Z2yPQHiaundE3iDabq23OxuZSeh34wQXjlfWkKg4xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOAKYplRAVGpqSRIoBikQrmnJiVXtEJLIS4oj6XG2cw=;
 b=di2M1Y8ywW94EIqTyekpo9lJWpy409nOp/Aeumg9ybRuKwGEjIRvgh9c2iD6MispPa/LZXj2G+7ApLh7Ie4QXmklAohfB068vd/t2hh5AJ/xmS2RCMAjgRl2A3bdYScFAyHYbLn13RYAjNPiomJEbDvdYZpuO303+3BmaBwzXkF8pVxeqiOwy/qqTZHfY0E18G16+sTZiXNSR1zXQcJHcvE/f+rqXp+OpTfSuyeEGUbv0GxiYCNbHNJ7ZCAmFo/vlJM7NCMChJHRnl4aHdc28jr8y1jXC8eannM3YoVcR9oZEG7rzzBs7+DDrlq0J2ON7HpwJ1V9ETV0GnYT6eJ2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOAKYplRAVGpqSRIoBikQrmnJiVXtEJLIS4oj6XG2cw=;
 b=k1LDP6xuCUPQpV+E7B4tGuzdqfwxk8P9pOnYXWCRRo0go6XhL0LnzfPh55T/sTtZe6TFQJZZZOe5FcfR0Gm7/VU9j84fRH46IqVVx/RUFI/bF4G+RKDFJRzzR3395ouLWKU4+4hevOETzK8PCAR0+FMVVjuxHQfaHGXpVab+Uys=
Received: from CH0PR03CA0313.namprd03.prod.outlook.com (2603:10b6:610:118::34)
 by LV1PR12MB174264.namprd12.prod.outlook.com (2603:10b6:408:50d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 20:29:14 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::3c) by CH0PR03CA0313.outlook.office365.com
 (2603:10b6:610:118::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 20:29:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 20:29:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 15:29:11 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v6 1/2] x86/resctrl: Fix ABMC counter programming
Date: Fri, 30 Oct 2026 15:28:47 -0500
Message-ID: <3a5e99300f1309ae279beb058ef0438516b2bdcd.1793392128.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793392128.git.babu.moger@amd.com>
References: <cover.1793392128.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|LV1PR12MB174264:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb69e7a-a73d-4c22-def8-08df36c475e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|6133799003|22082099003|18002099003|13003099007|3023799007|11063799006|56012099006|261022105027099003|261022075727099003|10067099003|261021123027099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	gYMIXCtWfnCaAGHMZ3C1ottxDQ3CgoCarYIfgjmx0QBn85c8W8EC0jLCGFeEApOmxF9TUhowNsHPg77nv3NJOSkEzFrJafn6ekJRGK2Tw0wbfJKhWzAfbjBIO/Sl9vh4TKQs6b4jdC8s4qTfsqkzFxiaGZu6vjGfbcDmL8XCD1e/ES93I/UFb87XXlH5iFOmYSmPOGRPJ33R58a36+KsvWmPp/DCpwv60Cdp1WPiUwiC7crk/byMhP87ySEcLYLDcWiq9HGj4Vs2VNIYU6lpk1DzAphegmbwHpDmNK5eCP7749XDC2rvFtOHDr6nbT/pBaeGsLvfKjepk3Pt9IW+At4l/+fEevUGux6ETNuSo8rQ0KwFtZmpOzKKOYkbhPaXvK+kVPDzIa0N012z3A8jBRgdT45/TNONQVpzPHj+z4R/C6gCb7VGcGhJhKR2GeRK5WqF0bKE2Tp/DW1nt4pppZ/43gxTwWk9AZCwavyiT0n6yhAX44MiljEUcMJY4QRqikvGjkNAqoD33PPwnVQAu9wPrnFL63w30RdLLXIL4FIGekUo+Ax/Ws34MLjtW1kEklmFTZeYjztYxOuuXh5lS6Nc3htPUU2Lwnw73oZWTkdd8Yvb0rkyJc1cQjSCJouokfQxW5EISrqJ/opoAu5t1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(13003099007)(3023799007)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rnEIHbL1bitkubZeagS6I6d55xIdmjrSaKtf+f40pO0+V9Gwti0bm/jNiBNgnCz/70J/OlxV/eYKiQt74GtIqeCiSsOiQLLQ+79aN2/T5REhHw2u9Mya3zSDOeOmvpsBGE6bW9IiAputOBrpnQCAeQ50CKqsRgsJHicMwzrYrXgDLqhN8uJejLwMXGG08Sq29d4uXmkDTXTB/IW472mwb3AE2QFws7NU7jrXDYv6+AD1Hfw72IFYB+Z+hQRTkkOa1FW0M6KI+jom8sOTyt3NxzR2VqXS3AlsAJp/eJlxQEukcVtWHFey7OqQY4HX3jT+gAcKldBToqQEBu3gwWG9fv/IQSjcx6HdDK7GSZIxahi/HtM6RrIFQovxCXJT4hRtRkwVbZq5ZcNSes8ZplsSCWd+SCud7cHwFCYXvvlK6oY/RPg69mP5A9+D6KIBwSrL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:29:12.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb69e7a-a73d-4c22-def8-08df36c475e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB174264

AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
MSR_IA32_L3_QOS_ABMC_CFG; MSR_IA32_L3_QOS_ABMC_CFG.cntr_id selects the
counter the configuration applies to. The number of counters a platform
supports (the number of possible values written to
MSR_IA32_L3_QOS_ABMC_CFG.cntr_id) is enumerated separately via CPUID.

On platforms that enumerate more than 32 counters, the current 5-bit
encoding truncates the counter ID and misprograms ABMC.

The AMD64 Architecture Programmer's Manual [1], available from [2], has
been updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12
bits (the published revision 3.41 does not yet reflect this; a future
revision will). The CPUID enumeration reports the maximum counter ID in a
16-bit field and may therefore report more counters than a 12-bit
MSR_IA32_L3_QOS_ABMC_CFG.cntr_id can address.

Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the
architecture. Cap the enumerated counter count at BIT(12) so every counter
ID used by resctrl can be written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
without truncation.

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
    Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
    Bandwidth Monitoring (ABMC)"

Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v6: No changes.

v5: Added Reviewed-by:(Reinette).

v4: Changelog update(from Reinette's input).

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

