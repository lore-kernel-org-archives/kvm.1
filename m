Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA9381AF;
	Fri,  9 Oct 2026 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589484; cv=fail; b=eX0j1+DVS+VAktGX3CI2RIrksrmptoP5zIw2L6Z/5Bl/AxPA5EfJ1pWaZgYO0mPbloMxhMzFALc2g1RUrAXwliCW/hfzwEIiD5a96t25KPR/T3QY+StY2jLcbzwgVh8FBemdXR+XtzU67zrTnjDMRDuMcnHjaMNoz6fHsEiU9mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589484; c=relaxed/simple;
	bh=cVsvvLRa+USnLksTujjvPRmF1U4I7wDoVpkr5Y13CdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb9n511yMkk4pmNIVmqnJCG653tWQMqdSazVQpFr0FmSIanqQ0SbHq6wiOQ0GsX/i6GGzw3BKnlxBV4vRawXoBfy1OXh/M6/bh8wWAAOdrTSfNv0gzA5KfcIuwRMbCnfQ0rYpVyo+72+Z3JU1EmJGFc8THAz+Klg9RPLiELZnoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+eXIAFv; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+eXIAFv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swSeI1fVofir21NYKhZtB11vvV5bIZ7EV0+xWhqJzybTNABQ/gyE20fY5oQ4JuzCmJ+9g1x9HVIW1H5OtOMefBQcQEVdpQR/tzGFVbbZRwi0998RcLX81NINyRpi5esGLIAZ7QilKb9yITvqM4wPeZmUORmihhC70xoYWqjJ67E+W9zC5TAtM9izpIeafjtGpyfoEr1y5JdvrDM8o2aj7fJJ78jYMbv2VhCnEzaPMBat1qj8lBc3bkd2W4bSJfcT0Nfkdfnlqwf2ClendnFg6KXtcTWxOG/q9p7Vhir9Ky2u70LtmetpkX2pWs6BlPJ+18MDzuuQhkayGlM24kMpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3Z9E3SDJxgJsxAg+5+o+WSGazRrTvJvqziRLDmkS98=;
 b=JsOQRzx8XUMz6eql/ztVisjBSRqVAV7vhIS01Rn4P3q8QXQ5NokZLO3ZvC3Tk86d8rwhcCASw8cia2ADmCpcU18PcseX/WeDSIVM2OG00/NjhHcAAy44pNALubrGZuR8+eXxAUt35kiMUtlo2KuHUx/c1WodUKgfFSeDQU561pmQsb//dsiAeDPLHG1mgR8eF8WEcLJp3gnEcqJiZIu0PPpCETzHu+iE15WPxejA/j4JJSzeMkXX1kU7RVZcZzXuIKg0ONzGTQa+DWSivibI+3bPaa5MgoZq78bJac4/RR0QDDYXR5/nDW8/K25zl3P7ue5E4ZjkyBrrL3CmwMXBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3Z9E3SDJxgJsxAg+5+o+WSGazRrTvJvqziRLDmkS98=;
 b=G+eXIAFvasxeaJ54Z1XSrwhFVGfikO7iAwFJdtmqEuVUWoK2qrtvn076bt2uvIshyH7WBFId5tp3ptOU7Xq1LE+K4Zcz+ih6uQuLjdl1RVuRQIfrJTP0i4Nn6wns4a1CPLGo0F4hnUaneS0F6niwrQ5fqW3KSBC98TvAn2BUT+A=
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 9 Oct
 2026 23:44:34 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::6) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 23:44:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 23:44:34 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 18:44:28 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v4 1/3] x86/resctrl: Fix ABMC counter programming
Date: Fri, 9 Oct 2026 18:44:07 -0500
Message-ID: <94c453ca762ef0c32680ac1163099c30866a99c0.1791589412.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791589412.git.babu.moger@amd.com>
References: <cover.1791589412.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e356ac-64f9-496c-8227-08df265f45a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|7416014|56012099006|260925021911599003|6133799003|10067099003|260925021311599003|3023799007|260925022911599003|261009223027099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6q+5vdn3sOzMxBlrnlTync+VTwVDbFqXTdJmhNKRuu5kHunvI53IrKLKEUUvHMDEnROGBgtcyiTtMTeZk4JhsX2SiL4T08/MEUBovXvwBn/mJa4p7YfjJJjrH9x49c7Z24Gxhz25SBrJOEyc9NhwQntbXR8TFgjg6UnGap27yI45DrCAcNWCoRpm8xkBdR0Ah3JiaaIxQyQ0DgdsIhnnWnz54e2jsT/QS5cu8RTunZXj9+e3LYXW5LUIqYJVaJ/UxLy8gH7NdSvkv3syBGbUf5FaYZPqTj7hiWnaOqLsg11UgBbFjfUcInMmpRl6DuSeyVSaxhZaNaeuNCJhZZ/cqgdhwKEcAInzT13CA9uUzWihvPgVQmFO9mEFQbbq/QZ081KbsV8EmuL6N6N/WOyob0LNrTe6N6RFxHHWDR8R55VmMNpCrJn3tuTI/m3VT0HNuMhQtGqB653vZYIcnlmL9n7riG34cqPHvEJcouBykEp6JpsYEOhGd78TbDhhQ2W2leefydo/pz019Vx6b/x2iPFWkZK+eztdyS1c1KoSLSI9OUggkS7Q5jTE1Ypsye0jPmo5cmHlQGpDY86BP2XvsGhW/jc2jNxFbiIvV1AT2FBd/k00ew97T2aPcGHxHqxyADYdPxPYcSrPPjBIXViSXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(7416014)(56012099006)(260925021911599003)(6133799003)(10067099003)(260925021311599003)(3023799007)(260925022911599003)(261009223027099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ze0qduxO5hfyMyXPBMIem8N01fXnJPVBdqGuFfx3GvhnxIGAxnl2oNDaUrxUrbFqIWQ0CWzno8og28IwlQHEeg0gLlGu3s2Yx4/XD17CaJoY+EqOW5OYCcVGfZYEnk3CxIhc4WO+1bsoinpfNsKV+HmJn3Q2Zz/GoCRVf/3SLa7QPfPAGHUjwIYvxqCt5/1bcx2Xy5HMLty6ZmpHy9HgVGr4YqrGdfeOfa/Xzk+SKGvvOp+cjsOkpsASZ4VU9w5VdAPsCYv2agg7azPNGUI5/35JERT1OUEus0gfRFT/TrSezJpnebusu6M7mZcgkTTCEhkh2NyjknoPzgq9RH7X6WzNiXqbW5QcBYg+WEXLRwisbIF2pZROmFWuyh+aaM3+Or5eXE/iedg/WBtPIj0rXkJIX6XxFQQHBXo2/izJ6WQm5otd8CnfUzN6P3LfBG9j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:44:34.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e356ac-64f9-496c-8227-08df265f45a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003

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
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
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

