Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736B51FCB7;
	Thu,  1 Oct 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867487; cv=fail; b=muNMLcGJoqlCE1mMCDeuvvW3RqcWHSzBE8vQVkGpmam0PW5RkLjqo2SLkFGz5+uF8ri1QnvndDwpVgH26NNyfNRI2+0TE4c9VBY8Ms0cw3PdcAZ++aO4r1b3wqUmiMODLm+dZ2tdSprsH5AF8kUb8eAldI70fvluJa+bAKtyiOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867487; c=relaxed/simple;
	bh=mwPmlG+fBh6mzX/VgbO+CHbdWZ0O2BwqZMANgMYuTLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDhNLxD09LZieC90w3c0FVerP9iO0AOKyBK/J6mjryHbIBSUBko7EkAoBwZ7Vv9iq43qtzvtJlLqnyejYqcAol3zwus1y5dm1DjqitJQ9fGWKSLdkeCCdzdahOQ3WVEY+5s+YFHR5c94BAUN0lMPicynhvY0s4RBbBd7PWAX46A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CkSQjiv+; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CkSQjiv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBgL8BMMZtrl68z7rPO0lWuthNYhfscaffl1s6eJMij2K2N+AYzK7hfTJ2e8HOZBdKcXY/TW3ckJkeD4BDg25Wv5CKood8nw7y+7/VuC+AapbsjJr1+P7kY6g1VnQ/1cTwR3TTETsJPX40ecwE/TjzX3O1Oms/nHMIqpSbL3L9uVpIoMyBU/uAIMNOrKpDbFe/a/La/5rwTA8E8Q1fYyP9XLNBUsqSOqxrfYHb+ZUbMT5suu7lgY75WWG1v6RVWB+H21IpsNLEZ5IIF4f0pWJd8TpCXNvdPpEXWOKKiJgKeenkaGhDOEfkOoqVBZlh3x93SGzksfsRrryglDgk+r8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUpN4Aky5qliWztSUigp/wWrbIB8a6slNWmjlTMzaDk=;
 b=br0o3+bMDkOA1lNaMmpdBtmfqx1hwYDAcm2dfQwuD2Sn2MjZsn6wqoVV3FIOkmNeotaq1OQyM9KbVcJqvuwNJEAbJWoDczoXmy1QtkyTxrdIK2FszYABFtwB9fWaPiesCizTBi3YYRQG4V12/f85QXxHLhKMN91YzmaBpbGC5QkFVvaAMVPZb6nYKFSjtLSJkkf1tUE2izs4sEAFRUco5ziC+Mk1jtGjOfJAFmw7kUz215dMYvbNM0kuGWrxgQiuHCWkQqqUdwwOyyrBlbU1twmD9VrIFlIdb9cxuWxiFwlb1BWRuc/GXStNLcbNIHCobrXSLjKTT4OhGhY2U2hS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUpN4Aky5qliWztSUigp/wWrbIB8a6slNWmjlTMzaDk=;
 b=CkSQjiv+g42qunVVQHNMZGc9AGNiNZeV0cOXlCqtjkO8xWD1gEF9qMXmEL7gTI6p/qYJUq92e8tteBZMaJ30jtqK7pPt0UWkVWITDYnO/kQp+tW/K+AwYzcAp2IPPPFHp/F9mnGqOE2/llh3IbwBPmUXmCZXPuONLQ2M0ETnMR4=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 15:11:22 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::29) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:11:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:17 -0500
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
Subject: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions and data structures
Date: Thu, 1 Oct 2026 10:10:26 -0500
Message-ID: <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a6fbda-b08d-4865-552d-08df1fce3f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|260925021311599003|10067099003|11063799006|260925022911599003|3023799007|56012099006|22082099003|18002099003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	qYRsQpp1E1xS+jyp9LT28N1T+2RIqahxHk/5LETeuRA/z/DCKre8KWzVcFOYnkeLSTureoLn8fsH8a2Q9+mTrwG3wm950/uw12idjdRZnqFMcozuAw8k7coYYy1gCfxShVfb8xz6Q+hzDLHnHLCdvLZVED+QNJsJCIceN0V88VA2udCi9IA/IKOZeLgA/4yHj3SzlqEzqFcpYSWgF7l1ZWmW6A6j4DJ3FRHLdG4/nc9Iwf2TMtwvnfcP2vKa4nYKOTRo2YYmiIDADCdqJbnykiBCiq5EYrZ1shKV3daPet9hFiWnRDzWsRifTlEQYQz/cNcb11nYTB+muoL+BECxUwjEYutKLkNsVfYy7GB4I1bkX1poldL3OENTzmM/3zE8SGm92+MzqXl6HcjSAzqR3hssIIW8le65w/YVtPWMYXguqkG/mkUdAdCtEyo0ilBTP0YT5yCO5tW8nHhyz2wlnKACPKliRJUemv86mRsc2g2C9/QQdzj1F74i7+dIAnZiV5DZ8Ux38onpB6jbCFDMHluE+y9BrArO1xwUJx6pnStZ06FnmpZECt53SoW00htK7RIyqbUwcjEW8vGDj+Ji8R6AQ7fX0z0g0T2bY8csjU9PpDWT/DgulKE9TWIlDFUCeiP5L0kgmUn8+OzA3uVM9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(260925021311599003)(10067099003)(11063799006)(260925022911599003)(3023799007)(56012099006)(22082099003)(18002099003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QaQxsXlj2t0dLvzALDKaK+6dMnE4KnrDIKqJKQlold8xiRpxQSWFh2ftDKsfvlWMP0v8sq+ExMiAxJY68DFBfFnZ01fAPUIZvOkqzXnu5WFTErNuggvnpUtI+j/17y7O3HfCBBzHDALg225GNN4WfRfhwq/Q+Fr1G8C6RVq3ZGgyMYrYSsr31vbnf7CyT4apAGMpgM8aJ8Eu60i+iUTVkbMSV/DHgF0VCxJPoNdCzcpN/1mRVitxvnc1XzCt5s0OqqF1drtYMI9kl5jQWrqkkxOP3pNPXzIGbkWEn6N4p/+qdDkc6SQ+L9Yrm0h/fH+VNOHB4acPKSfCCpcxHr3KEe7TkbjGhdCJxCMfoUffOq3iPUAeObLzeTs0e1OXuFimrqT45yAip80W4A/49d9+Hd7I+fVU4AXVLkDQPs6y1SpmWMPJLioogvEOrA9zRjki
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:19.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a6fbda-b08d-4865-552d-08df1fce3f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

Privilege Level Zero Association (PLZA) enables the kernel to switch to
a different CLOSID and/or RMID than those used in user mode when entering
kernel mode. CLOSID and RMID selection are independent and can be
configured separately.

PLZA associations are programmed on a per-CPU basis through
MSR_IA32_PQR_PLZA_ASSOC (0xc00003fc), which contains the kernel RMID and
CLOSID values along with their corresponding enable bits.

Make the register and its field layout available so kernel mode allocation
and monitoring associations can be configured independently.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Updated the code comments to match general format (members first and
    details after).
    changelog update.

v5: Sashiko reported:
    https://sashiko.dev/#/patchset/cover.1783461016.git.babu.moger%40amd.com?part=3
    Fix the union truncate issue on 32 bit systems by using u64.
    Updated the changelog and code comments.

v4: Re-wrote the changelog and code comment.

v3: No code changes. Patch order changed. Improved changelog.

v2: No changes. Just rebasing on top of the latest tip branch.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 49 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 82ca6356dc62..1331291f7a36 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1304,6 +1304,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_PQR_PLZA_ASSOC		0xc00003fc
 #define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e3cfa0c10e92..44ecde20b1b4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -222,6 +222,55 @@ union l3_qos_abmc_cfg {
 	unsigned long full;
 };
 
+/*
+ * Privilege Level Zero Association (PLZA) is configured via
+ * MSR_IA32_PQR_PLZA_ASSOC.
+ *
+ * @rmid		: RMID programmed for PLZA.
+ * @reserved1		: Reserved.
+ * @rmid_en		: Enable RMID for PLZA.
+ * @closid		: CLOSID programmed for PLZA.
+ * @reserved2		: Reserved.
+ * @closid_en		: Enable CLOSID for PLZA.
+ * @reserved3		: Reserved.
+ * @plza_en		: Enable PLZA. When enabled, PLZA applies to the
+ *			  given CPU.
+ *
+ * The MSR_IA32_PQR_PLZA_ASSOC must be programmed on every CPU in a QoS
+ * domain. Each domain supports a single PLZA CLOSID and/or RMID
+ * association, and all fields except @plza_en must be programmed
+ * identically across the domain to ensure consistent behavior.
+ *
+ * CLOSID and RMID selections are controlled independently. When PLZA is
+ * enabled (@plza_en = 1), CPL0 uses CLOSID and RMID values from
+ * MSR_IA32_PQR_PLZA_ASSOC depending on the corresponding enable bits. When
+ * PLZA is disabled (@plza_en = 0), the CLOSID and RMID are always taken
+ * from MSR_IA32_PQR_ASSOC regardless of privilege level.
+ *
+ * - @rmid_en = 1: use the RMID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
+ * - @rmid_en = 0: use the RMID from MSR_IA32_PQR_ASSOC.
+ * - @closid_en = 1: use the CLOSID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
+ * - @closid_en = 0: use the CLOSID from MSR_IA32_PQR_ASSOC.
+ *
+ * This allows PLZA to override only RMID, only CLOSID, or both. If both
+ * rmid_en and closid_en are clear, the effective behavior is the same as
+ * when PLZA is disabled, with RMID and CLOSID used from MSR_IA32_PQR_ASSOC
+ * irrespective of privilege level.
+ */
+union msr_pqr_plza_assoc {
+	struct {
+		u64	rmid		:12,
+			reserved1	:19,
+			rmid_en		: 1,
+			closid		: 4,
+			reserved2	:11,
+			closid_en	: 1,
+			reserved3	:15,
+			plza_en		: 1;
+	} split;
+	u64	full;
+};
+
 void rdt_ctrl_update(void *arg);
 
 int rdt_get_l3_mon_config(struct rdt_resource *r);
-- 
2.43.0

