Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC9346FB3;
	Thu, 12 Mar 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347915; cv=fail; b=OM1DAHyne9YVHwD9GBvZRa9dTnJwWMmIwQUe+iuQkZy2XkxMVudJBMzcYQYsVRdBXQrXXLMU2VpI1r5kuk51QDKT6EQ+a3iW/ijK0vN02Tj9Ho0eRoXdOuWSPWZyen038E1vTJD8n0Ws1EzStnr+fg366MoLly2/NdM5ayS2LAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347915; c=relaxed/simple;
	bh=suVqO3JluZG5wAdLYqot3yCldlOMJAnU3st64TbEOi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewnW8TFfHI0RumH1kAIhl/arCISr+YRcXBXw/hZqnJjZ+5bwVugNIOwCGdribfUeTJSNZRFvIqrSrIXfQvZl+3/fQcvv+XQCl9v0QpbF3UooQjjVijbA1I57YZiP3lfBKUIMVYAAC6lgt4796XNwSWgbTKDN5ZsShBcHH3qzjzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGPtF+qe; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGPtF+qe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+2Gh5vuk52qeyqv2IgxcexVO5IWfLB5sve7VAoeCoR859725hvA7zADC/x4gd8RiGXKHM+4Xk+XZ5L0LI0E2VuzwVkSIHUMqPL8P2N4NchAcupNyHs9ANsL9sD6qxVOaWkmKnr+EstP4FewMC47x8m2EKi+y7BqAlUcGDu5EbNjDCjbAF+tv/nthiIiJIicm67H4f05Fo8XXxFj3bX59xyIh31GRi/zflVOIwaRmWLK+6EOINk0BgMVNaPp+bkhaOSYzJ/mOjHPECABEOEn+Km1sEt186XM2zt0z6a4GqKvBc4A8r88tCDwPEP75cyhIAHMJ5fGxcLXWwJTETaodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB9oQICxIcUkeXvBHmmDI3MKY4TAwlsE+z/G2OqGoYU=;
 b=Xq3J8qc2lybhXHS2wV+y/7hV8uGCrqEUdIp8Cz1AhdAf0Ks7PGNKG9UU181tLYSdT07eHbTHIXiBnjlFWNgQIzaMLpBzPfIOmPfageML57f7UDCwrv8v4ZUS1OgdI7BgP9qtkyL2PsSlDubmqIPqCaDdpboZgw0WjbxpAlnVSS8JS7vxWBJJS1vPUtmYD5vPnmwKZNoWUrErh/DaXEFpqGL9G0bgvCyCBeSLCWIGZqyW1pVxfKdTinN84m5+c4BzJKtRu5jGKrFJkqxzaDU2ESNUcEYRXFqeK5Jdq+g5Uk0upJD5/G0yeDUAfGbXvCtv1MRxdA04yeqoyDXuFYDKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB9oQICxIcUkeXvBHmmDI3MKY4TAwlsE+z/G2OqGoYU=;
 b=rGPtF+qeGM/2m7YxsUZ0NllZunB8KcXQydNHj6pZBjB577nWhudn4TjxgblAgP8WU7eMm4DEjsZVf13ZWnOZpmEnoxfBGC0VkjNklDfDtD/INhMhnTmKo38bQLjH9g9PpyraPPAcPPstkmGZHEMf4oBz/SY3izfTFHefQSF8f9M=
Received: from BYAPR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:e0::48)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:38:24 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::ea) by BYAPR05CA0107.outlook.office365.com
 (2603:10b6:a03:e0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Thu,
 12 Mar 2026 20:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:15 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <babu.moger@amd.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v2 07/16] x86/resctrl: Add data structures and definitions for PLZA configuration
Date: Thu, 12 Mar 2026 15:36:52 -0500
Message-ID: <74ec176dc5595378739d07caaf95f55d859d30a9.1773347820.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773347820.git.babu.moger@amd.com>
References: <cover.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ccff87-8210-43f3-058e-08de80774eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RwA9FBkH9/XQ1bI8eLjHXXSMinMFlULSJA8nVZTQxSQ8BCUBGxoCJBnabTZYAIH07DET9u2hSfr79pdqpkZXd96/nrGQk+JzEYmh95UjnEsiRgJ/imtSKUfN26EYUcmJEBP1oTn09OS0QOJbCMww97/0QlUGoRukiitxvpqYkWfSJsK9guUkU5vFsgQg2uUgRWnLuRDCECJ0A5TWuJF6ug8OXhTNZMpY38ZW0dwKvB/WzaHVYIgys67vhINLKSxkSmDamuzTkmgSJcDwv2ty5qoUM0CnK5cl+/4RhrL0Q2Idbrl4rygfsgaTWj8+9YF2yQmISvnS4iUWXyPQ/7y4dvY7VcHJJNrQDrmy2RzGADS/iaibZ39Ez+EcbgO/gfnjOVgwUHRcEEsUWANU01VWZ1detT3XGAE3Gumo6UH58sjcg/ipghtiK153LwzFyAJYzOxjLhiFOF45mnpSyZ+q/VpnKFg39oyJqry6Rte/poPtSDVBLoTMZO6VsofrNy6k3AE9WbgqScRQjzD+c3lvV3uzIXOr+S4WC3HrMvkFef3xbzs8d6dIpaDCxvaY41dB48hEm37NrwbW3NDDl8CggHmUqwSHtcejE1Hay51Q58b98sxiTxsErXZp78xDMVAkjGLWsccC2VlO4oU9lJ064PR4E+87MQmAyXith1Dr/jVWANZFNOFgSL7IDzTC6K4pbJdx5n84g5OVQ+5828HyFDcWeaQlBsN78JUIrF9s5LLy6putjbWFgLdExacD9a/p+8drx0RwqZGF0ZDHJ3vPfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UAkktgPSpRKefK/zO0svwdyRtoEjxiLKFc9ld4pbxGl6crkmkf+uK1X3utJvZSOgtkA/4LxYHyDGYeGQ4vHpFRukm0ES6OERsJbM+Y0tD23BXgMdpYYKlhoOpGb2sLTjW0d8ZD54+pPa99D5IXWhR9derIOUPCrWQqmy6nlziLmfynATDNNlIqQWv+TSYvoG3TZVF0TIMVfZPHPLmtKP7gFS1wf4ObJsrYRisDGrsXwNlbJUmB/RuhjLRxmf4y4VFUhNQ5DLPFgaw3ELmm44EU7EKHwExHO6Ru0c3FAwSYLc0oaK9amf7cL0Uqd/2TzjEUV7I2SlBic563/kJLAifkaEjwtTq2mG6m+IJV80VXu5qESTf1FOpFfX7/eRO0mgucKEM3PjxdsDFoAI97DHxLhqGxUhP7TyWGuGyLS/K5HikygPfgSGtD1xyJXF7mAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:24.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ccff87-8210-43f3-058e-08de80774eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

Privilege Level Zero Association (PLZA) is configured with a Per Logical
Processor MSR: MSR_IA32_PQR_PLZA_ASSOC (0xc00003fc).

Add the necessary data structures and definitions to support PLZA
configuration.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: No changes. Just rebasing on top of the latest tip branch.
---
 arch/x86/include/asm/msr-index.h       |  7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index be3e3cc963b2..c96fb7db3ca9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1282,10 +1282,17 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_PQR_PLZA_ASSOC		0xc00003fc
 #define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
+/* Lower 32 bits of MSR_IA32_PQR_PLZA_ASSOC */
+#define RMID_EN				BIT(31)
+/* Upper 32 bits of MSR_IA32_PQR_PLZA_ASSOC */
+#define CLOSID_EN			BIT(15)
+#define PLZA_EN				BIT(31)
+
 /* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
 #define MSR_VM_IGNNE                    0xc0010115
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e3cfa0c10e92..403849a22e91 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -222,6 +222,32 @@ union l3_qos_abmc_cfg {
 	unsigned long full;
 };
 
+/*
+ * PLZA can be configured on a CPU by writing to MSR_IA32_PQR_PLZA_ASSOC.
+ *
+ * @rmid		: The RMID to be configured for PLZA.
+ * @reserved1		: Reserved.
+ * @rmid_en		: Associate RMID or not.
+ * @closid		: The CLOSID to be configured for PLZA.
+ * @reserved2		: Reserved.
+ * @closid_en		: Associate CLOSID or not.
+ * @reserved3		: Reserved.
+ * @plza_en		: Configure PLZA or not.
+ */
+union qos_pqr_plza_assoc {
+	struct {
+		unsigned long rmid	:12,
+			      reserved1	:19,
+			      rmid_en	: 1,
+			      closid	: 4,
+			      reserved2	:11,
+			      closid_en	: 1,
+			      reserved3	:15,
+			      plza_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_ctrl_update(void *arg);
 
 int rdt_get_l3_mon_config(struct rdt_resource *r);
-- 
2.43.0

