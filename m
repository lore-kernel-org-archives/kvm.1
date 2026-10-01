Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F3527597;
	Thu,  1 Oct 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867470; cv=fail; b=PNhSCce4Xy9BZ3uyUY3oE6TwwTydKd+OAwdvwfukK3dBxdNhLSVy4v6NYM7BCCCzgqe+Y0ff+OWJ2Iq28lyMtbDoY7uyO1cwRSbayB9ing8ce7iKJo0Bpd3Tbc5PsUMV/Nc4+9nzL7A2M3I+8q/3Oytz11eTgJXvb4ya/oM79oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867470; c=relaxed/simple;
	bh=lqMJmHMxPLtYEfMQM3oRZdVVW2CUEwbozjjbTDwke+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVTjpPKqBNZ9BmweI0dSce9IR0cbIEBRH5yxu9SXS7XcYF5Eo3f0bW74BAlOhIvj1xJVDkQi4P9ncJDyUR557bhm6FZ6w4jnNmQuvqpaNuv60dMtxyFtqbQmAEP05GWi1ZedG9NB/a65+ylbXm8i8HyrgMmRuPs5MEStpWRenfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=agsYYA5y; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="agsYYA5y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/AxWfaUVbmF+zgAwQc6cF6EMwaILwMrkuAK8cLNnwIZ8lR8+VlhoDle4w3l+KyLNPv+hYa5CI+61/JaLgzkei9bSy28rqDBB87+OlFSPdlbrWnPSCoa/Y1mXx6cSlySMghWO+RagWhBftIY5ZGYPFseHpaWtYKAk47Otx3YpOFxR0usItqaF/T+l0EHEO9Z5thR3tbZPjZdqRx+a8U28Tx89AAIsHLPpyryWBtbavrJdJ/uh4NXMpDWFxcTBN520y4o2H5coZ+5PAnXjGiWAOyTo7hrDRON1W4m1fcFMmUEM/bv+FaMjefORnxZwzeKOEFtkVOlDkOp5jMQlbj3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97z+xJyvGxQte61TjC0ARvnChM30FnaVSvZm15BgEuU=;
 b=qhHE/NP8UyAjqnUsTFRJBiAJ4C3g8yx7QNcfgrOXmdSG+MO5oPO1BONV0jKEtwt2+sHHMtjSImnewA7iX7uuI7f9Nwop9Tafq6PksUbHdu6jLF+/gvorVtWxo60pCDYvnpjmouJMuRVesAGc8edpq0GuwnuvAcBT16rTBO4xuoARxe73Mfqgo5HWrqclXMpzOdR9sU6JUbqhZolewWdu6xFKFjZJnrswfwbkP3G8g1TUK4FCvvKPKMT1HhZ5jsW9yhOFBMiZaj38JTmtQ4MV/QLwsVcHirWHWRLqiU8QIKHM69Z6YPl3fjv7/zZVEuwV2QH7rjKiJ7qK8OyqgXMFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97z+xJyvGxQte61TjC0ARvnChM30FnaVSvZm15BgEuU=;
 b=agsYYA5yiolA7L0cp0HsgIsOfjFB/b79egYjllZgJfF3uPXTAu+cJ3fVcg4NnGaUJ0qAafAmEPaIQyiVriFLWhGqFJAzHcixmbwrmkb0DDJgJzyazghtY0bkEOgIpBWKPvO8vaN0QOi57chKSkTud2LnCVkALZPX6ucLFNf1ryQ=
Received: from CH0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:610:e4::19)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 15:11:04 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::69) by CH0PR03CA0194.outlook.office365.com
 (2603:10b6:610:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:11:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:00 -0500
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
Subject: [PATCH v6 01/18] x86/cpufeatures: Support Privilege Level Zero Association (PLZA)
Date: Thu, 1 Oct 2026 10:10:24 -0500
Message-ID: <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 989f4b5d-3a97-41ff-c737-08df1fce35d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HyMQtolePHKPPUZS6/PAo87tFZHjV/NArYkBxvtAIS1auyPJuRWqiYdo6SwPlNITFatOJeOgjyRJNlMg3Rm/wreQf3zrHSv3uz5dDbhmk1MKVp2TAW3g2tfQOheNYbTMTKfP3A4Z7mr3HSd05ZXFBdFAp19PsPAMMgPoKNtd8nEKMWCpoAq3uO6k1R2e3QO2VAmwXoPjPdBrccGLH2mPO/ukPmb+o+MEhWk67fmtCm/g5hPKrr7Lbd6Iy0y9JbMyoLKMhqOabO9NDT2qCwPKNV5qu4teJuHZXe5ojzPmWJf47Tohu4o6AqeZviW9hNtF3FX4fnhG9eY3y8xaxnNoXODvHfuVRA4sR3nk1TgjLcnNNsc47Xy+LWyYSl0dxVVgV0V1pXETLP4vXlz/w11buwBys6NDIM+n/U2Ya47YHObZkoJWuKomtyKWEMU2FEgBmi8qLLWxuCaEUUZIJIv3QBtraUepkktEi93oP7UPEKDSIDS9N1ZM90xm9ceqTx6BGyJAK9W+3ofPO3TUm8LlDoLg0iAYoZcUnKHGoTBiZE+rnI6PHmzoq2LoQ4JAgudg1bemQMy+/clsYcNkI7EsKGiapNEma7FTvkJxMUwKfXkTPTJr81C2i7HUB2dT7EfMj+JS8JqZs3+26CqwSLItGuLtN9S3TOSD+5CFV7kdfCs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q9wdRmhHwkxOKoB5RAbTx24N7UqHsC/v4aMETgAfrUpSNrqDAix98q3U862+sfEL7w6SDW9vGmCG/bZSEwEeqeU/zC3WhWiC+/CWjFDDPaK8txcEl2RAgX0g7Baurd74mIvjZbT19oUfrKidloSWNeWErnBffIskrtKzYASGZuOyaKl6pHgFreAgceBxxjvwXLNcU14q8thKHrpmAydgOsMMAzeU9YFkqMVlAWLJX2MtEafAcE0r9J0IeTD4si7QIhiwo52ufbBc9I4GzBQ51C2L6/+6fj6rFA90LSO8NZIJ8UjXKvzFvYdIpFEiQPyLK9Yxhr7smA++Zdzbx/z76up1dNR/OjzyJFj9jWC5vUUs7Kyp2ZOriFBongpn40fFtNTPhn5wTe5xYuK0Af1hXQtCTbBfT2heEl7ti6sC9X7g42t6lh5euwsUsKSfkudu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:03.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989f4b5d-3a97-41ff-c737-08df1fce35d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

When memory bandwidth associated with a CLOSID is aggressively throttled,
and a task with that CLOSID moves into kernel mode, the kernel operations
are also aggressively throttled. This can stall forward progress and
eventually degrade overall system performance.

AMD hardware supports a feature Privilege Level Zero Association (PLZA),
which allows the CPU's CLOSID and/or RMID association to be changed during
the transition from user mode to kernel mode. This allows the kernel to run
using a different CLOSID and/or RMID than user space, which can improve
system performance and/or allow kernel work to be monitored separately.

Note that PLZA feature associates CLOSID and/or RMID to kernel work, and
therefore influences resource allocation and/or monitoring for all
resources, not only memory bandwidth.

The feature is detected via CPUID_Fn80000020_EBX_x00 [Bit 9]: Privilege
Level Zero Association (PLZA).

The PLZA feature details are documented in [1] available from [2].

[1] AMD64 Zen6 Platform Quality of Service (PQOS) Extensions:
    Publication # 69193 Revision: 1.00, Issue Date: March 2026

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v6: Highlight that CLOSID/RMID association affects all resources,
    not just memory bandwidth.

v5: Added Acked-by from Boris.
    Updated the changelog to include cache allocation and monitoring.
    Moved the Link tag last.
    Updated subject line for cpufeatures.

v4: Split the patch into 2. This patch only handles x86 changes.
    Re-wrote the changelog along the ABMC changes.

v3: Code did not change. Patch order changed.
    Added documentation link.

v2: Rebased on top of the latest tip.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bce3cc6bbadd..64ad09084766 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -532,6 +532,7 @@
 						      * and purposes if CLEAR_CPU_BUF_VM is set).
 						      */
 #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
+#define X86_FEATURE_PLZA		(21*32+21) /* Privilege Level Zero Association */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 580b252e07cc..e103ea8b62df 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -61,6 +61,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_SDCIAE,			CPUID_EBX,  6, 0x80000020, 0 },
+	{ X86_FEATURE_PLZA,			CPUID_EBX,  9, 0x80000020, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
-- 
2.43.0

