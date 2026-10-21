Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627103;
	b=E3kZwrxSEIViiCX0YAJpKLJyKaza4+VI+Tsjg2tIN3LC+Ru1AxOvgojpSdbEswmrf6uG
	 wieTevGFSVB1mVMOVHR7arnBFQjwUWnP0XYVKzkhDzzrDceSBQWwyeTsKBrCbddV9ZcmO
	 AQmDVaebBsVfMZgk6whePgmVwKHXG7mzHOUFT2NIRSFlk7p1tXI6bqsePBlmlVs46pmpZ
	 wjhRdZJ/P3EAMjduyd7LkOINeckPi/mFesQQgaq75o+tuYdhgCIx818dV7ZUuE1RiM+sX
	 ZCMuGpkSo7el6uqqVDBuKe9cEI5DTn9acBp6lslLTZhDCQQc0eNFkaPoBDiwx1ICscg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627103;
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
	bh=YKDWrSyAr85twzSizjDrl0/tcwlYSDd6+lwYSeaxkbc=;
	b=uqvWybrMfUXP7GJ95w8HH2WccOt1vjnDUPWj4hzS3fh6ILtCveHq/hmPvd8adqPZUt9/
	 LIYAs3lA/aoFiHvG2cMIkm9ba9AWZX3FYEON9EK8BpDZVLRvCFLbMXRLmtQ75b+TzPZSt
	 xnq6yhKHEbbLt23Mzrp+MTCBzLsNFgeSiEtngKYX/O01tGXOLau5a/Xp8YfEMZgEkYMRQ
	 0IfG/neW7g0xwHwvWOtQrdZ5O17D/lC4DvXlTHDPp0ed31wNvt9CbnI/VBXnvg+ZjiPsS
	 TkXpXLq2v8WNbthFckcVUiCkRw/77lviSx8qoCamDSC/drU2oLSm8VvYGv9RGDNw4Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lFsrYNOx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE4606A31A;
	Wed, 21 Oct 2026 23:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEBE4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lFsrYNOx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKcMj0CYUWgBKQE0yE6ZbG7DJwWxBhcusCKGBbsDM+p4UsS2P+Py885frdjfyrt6pkMesdA+B0o4ibC61YRb1Juh0ukfa7qLdxQlvZvZ2OpN6OW8y0/VI2cjSBibOmBpKIkSMxdI/TIYLweKCgW+47cDnHI/ecuCF3S7yrCyx5ONLAd3Z7WC28qg/hQj7T9HczYAMrZgi1tHowcdqkJGFasANoIaBc2jv5r3Cl5OfcqeGSBZqMbqO8ucQ9HAk2y+Tgb77Gh8GVglwsNQ1hEPxqyR3vmaUZ9aSxp1uDgtLtvmqxZ+aZh883bodI52FP6rOLhh8A96CFvG1Vqw8mOcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKDWrSyAr85twzSizjDrl0/tcwlYSDd6+lwYSeaxkbc=;
 b=mV9sJ+qm4Ro8cO2zaZVVZ7fVWsSzMggqp1IOFB4Jelz19NKygGaJ14VyWXASKS/qnrynLpMZQ8NDwZtlNCFEWVm5ZiETOnWIZftFSp+DKSLAnUIpflYoNAklsqEcDM/EK+S/8AXPgrwg9N2ZetjBXmSpe/V+x16X4GriXkSvY5YMEIjZ4kgx+WY1e9dioD7HEAmBdJ5vdlBCAo2aOk4JCRpqwLQxy+rNHM6/r/gFOxyH0h/0om8cV+FNM4p3nPUVYqlo/0yAlwoy/6HaBWuuMfpw3QrVUKFyRp6yY3Jc8XonxFysshvJ7KvMdtG4mVX0tWfDx6gkTI4jmjrHJzd9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKDWrSyAr85twzSizjDrl0/tcwlYSDd6+lwYSeaxkbc=;
 b=lFsrYNOxf7hxPZgbIzouH/IEeDGrmjw4gG015PTXjPRDEIIOSp+bS16U0axHJHdv+C9Oq6ZEGQV3WfT+fe3BOlWqhjLs73/liC6obrVDnxC/US2NNxE68YdcCu/hT+TtPrhz2gxl/U7aPrQ3KubofPBtTAIg0Jy5VBNK72Mv7rY=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 23:58:17 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::5a) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 23:58:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 23:58:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 18:58:15 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v5 1/2] x86/resctrl: Fix ABMC counter programming
Date: Wed, 21 Oct 2026 18:58:01 -0500
Message-ID: <d6d1937713754d56d051a687748b8b1a6b3ed190.1792627082.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792627082.git.babu.moger@amd.com>
References: <cover.1792627082.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: bb176802-0c60-449b-4364-08df2fcf2cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|6133799003|22082099003|18002099003|261021121427099003|13003099007|3023799007|261021123027099003|11063799006|261009223027099003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UUmIpZy1/Fx8Cx/XMOhDnHyr3YXtRUe1UA/IuoZVfNF1d5RPQUxv2G7vc4zHkFx7CWLy2CufWvLMCX/1FOmuiXseqNe+SVpMkvFAKRHrA2vNE0XvQ25n789zGVnXpdyC5DUMT1HcClA01BCMD5PGhxc8xpqk1R9L5VO9rmaqPlBGnKWzY1SxqxdwcZ+2K0cmwjq44LO0Mlv/XUdYEGZJmiWbYYS5tancFAajWq4DAvFB0WHHyrwpEhTRhF1PBIujuW9CnbuqeZJiEC18UNA/VmwuNMBSalkMJn6jAXAW+RmctGg8rSmPAEElEfjY0lP8j+f0ukN2UH6imiJ/Oq9RkP8q9gqpypgEwTxoHRpyH4rIodGZGQyMXoy3jQb8kWVXQXn40dte1YpF7iyhC0gBMr/F34LWdIUTHakQqAnaAVF4M/Bf8NfMV+uZUT1d3m8P4O9+8LFM2RVL4Uo8qcz+Qlz4mK2J7HhGKujlquvmzhGpvGStGzj6aWEJulmULJAxUurmYRtZF9afoZ5lyRMQtRwux4aR3c4PFHHCxZR5obrOGGU9BADNgioDfr8yYx3++hi6DqaF+MYrW3E2Ttm9Ml5OPowoOCcE1KixoZ1yF/3YYxuPliVj4VKKoI+Ab6ame0tHDZw0Xk3NPfEAOr6BHsXjsrWaSIZly/Dx9BA5ctQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(261021121427099003)(13003099007)(3023799007)(261021123027099003)(11063799006)(261009223027099003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8iCc+HudUCtAFVoMNG3ootK1ddO/ACs/xoXocFjNmDgUKBxnuN9/93cXpWoVF+G0yJepx0Y13pQfTRC+izQMpyrxQwNU62kEI8hJB/ToUXYBq0ZYQiAw/z+387J8iag/H1ZlfQ2XD6hkEvuJNksb6hZBSeNP2YvjgQDbilXmo9ou+H8g7AtVXoL3E88WwLlIS4KdxKZ0XEga8JJepqiW187rMyu7a2ew2daLVVbytPk6XCmUU7yECGpJczPAR8Y4iCf1y62Zm3TqkyBqVQoSl3o5oPaJcSsd0xS/l6mrZ24rV9RZxIokyT8nzw1qZikaWEnkY2JlQW5oDGlcpwaSnyLTAEBdMcnFv8vIzslw00RnlAT78xQg5Ix/H4DqphqWa8vrFY60j2m/CBEuQ0S4wzDFQaTCLBiXc5jM+9BVrxZ7VeQ6yIuPvMSsOLrcd+hY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 23:58:16.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb176802-0c60-449b-4364-08df2fcf2cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641

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

