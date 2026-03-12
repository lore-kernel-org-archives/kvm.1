Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F428C009;
	Thu, 12 Mar 2026 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347883; cv=fail; b=FFT3hb7iRzFbFBQAo4wCfaLEH6E0i5inQrg5DxlAlQlqQXo8WxxmaTZaDP7SEJVnj/7BxZpQ2pR9gFdhZ9wGy+pKOUS63uVcneRCAbVT2W5dqTZj9r3pTlfn9RMN7X2awIlWfrWkmFNswxf+CnfBVBHmsgV4EAFJqdtQX27STX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347883; c=relaxed/simple;
	bh=80l7OmSYZiP1v8jH6fJ4zGz9Rtnh5YKNo9/Ad/8hxog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL9qe9m2HVYJcnNErK/RNL0y1IrHO7emDIXNjsja6eXBpIXWHcQWrkeB7afEom4EUGAjL/eTViwNVtLOzuQ3rgvvLaeDfFOVOkbRUc1d4mDv8nopJuUIhcCwkm3UVlY0wzVRQLfoHCx48e4v4gT1adNGze8AUzZ7NUxVS4DDhq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Os6Z+4V; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Os6Z+4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8NmYrt7bdb8LDvH3IGcN/kEHhBjf3O/+vV53ohXEqBTgaMp72XFPeHK5r3xJIOV5+2wHdXcvUXdfPSBoU1B1B+DIcD48TEDZLeQuqYGV3a3l/WGDOvpWwpQ4Taf7LWgFQx13Qd3VUcW81B2lBGF3EUGZgOxT28skjyOC5i1r//P5EKk4IS1QOIRiAFAbE1DSCrgXVVZV49RN1EVMCoae4oT54heBLT5HsdPLmG8CyA+zxRPYOO8dLkPfehr3213+FKrVtaDEdVpggFqvb6BeHjvVbyuis2wQgjOT61Xp+iPbuRTktEr/o8/9AA8vwwqe98TS1a3a/FWY/LXtAvLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De2fZTivtAXGHuU4t6XRp2aZvUjl93Z0to+QVh22+yE=;
 b=NGPfR5xjOXbzRVqFdt948+O3RbsVmhSMBAJu/7EfDjJsNK0BLR/bA9ixT6OXiYiumXlICO9TE6ZuIDLceZAQB9dC9kFSbcQz/qTR4DKfpR2PCHyd5dBVR3GD2PnmuoduZRSGXZOs+2JI1gbpCvOf5GhgzsteZEy4ksTQK4gSj+t4qCGxGenRMm2OOUft7HgPUuxJncCHzTsNDJhxFEke+NUr+muJMCiZGynL5lo0Of9B35H94LOzDTt2SpUG9c/i3Eii9ldGoR8ruRYMWesEdvBeBFAoOQzpkCRNLdTz+xFmbuPcvXN5o6DYNNoB20hbinEUYA6TSRV2XKn7d+Wl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De2fZTivtAXGHuU4t6XRp2aZvUjl93Z0to+QVh22+yE=;
 b=4Os6Z+4VINEcB8kQfijoZIkhpMYjPciZ585mO7p2zTtH9dNyKSQVt/GJ1csKtRBRO+aX+oYjkFwTiKgKvVsenykHfiENptwsWEypFdV5xOhayD25mhtHQ0xW+Svr5aqcS3UFmEJIXDm4nrXoHdbWAjB30xznaNPoajzg4vsMnhg=
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:37:53 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::8) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Thu,
 12 Mar 2026 20:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:37:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:51 -0500
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
Subject: [PATCH v2 04/16] x86/resctrl: Support Privilege-Level Zero Association (PLZA)
Date: Thu, 12 Mar 2026 15:36:49 -0500
Message-ID: <36b849d6548e8ec16db1013e551e4d199795f048.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d467b3-c3b1-432d-6513-08de80773c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qf8w092WzACH1LIVYysJrh9nsQw0ECBok0eDOCVgNk38IZRtqPVNvjpNmwQ0LlITwbE52yVU0BZ5v+aVn5BGu55Cxk/1VbQY4gylP3k7N9MC3H4QLocnaTsSQNjFI8+XyUVYOc5OTSET7RW4SdOobckeOsErsrruToTKneLfJLpjC8mz8JGTTuxKu6cowF/fpxCrWCQUM+nYY5vIunHBZ0zYzE635G8vwhP2JBO+0S1pdm19WJ3WcWyof14sWRXRzOK42SYEJZeSCseTI8/+7AgNufIybbuXwelEwqCEKeBygVl4qnVg4mzVBz4U2OQTFr9NPIaNNej1eVkE/VChEeteXW6QVEhW89cG/yckpWLoh/CIls1CEPQiSkcYlRTE5rPFj1xA7MgN8ki8mWobpgEmNFOCet3kvW6DFGM9UQVGPFigbT95loXWxKHiB8cUdodSLXpfnnCJ+/1/KOpQ8odKDuaSGevtBpdqIWquoVAxlhGGS1TPoOBZUVhfsIWKZt6HV2Qj9Rmygw0wZg5N3VO4XEQRJ6d9lb7dVsFgyqNvgAmbxIoDGb2sBBgK7hmiu+a4G4cJ+HkIND/0/D45Tvb1d0iVZQgvAV8u3hzPk/HyroFK5bFcRFZ2SH4gI5ImfC/SGSWAEnJ92Up9/UdOJdb5K0DccgwytSb6p4i7HL8bV8gLw0jWCtoxkWE1GXlQzysaBgpgeqyXFnWlJG8W+vkDGlwMU3kAAziYppH9BgUmT9PxJ+HArWMNbLINPBw92th99+K3y69RbZ/oDOsZeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f/8gLUdWXw+Cx+R13VP5asRVBF4f4xhRH5Ea6iCXjzxa4EJozo8fGwSpHQNim8jlc07xPHIJfeG8noSsEStEmYAaY+n3yr7VyuvTQfa7W+W5E4Ips+BwQaoHO2wHRUZvByumrHDBz7KlDciIX/ZyPvkFA7QVsCuzqdo8RasnyBe2w0Wcjs7OrAJMsEFqSKhWyhljm+wuE2wNeP/SG0Z/P/fmzEhuDK0wUK9GPjCdJYeDS/Ee07hSZkdCeOU0WgQY9aYFrM3gGeEcK2rPqmx2o/hQnQoDfXyfSDQE3QbP6Bffy/8AKPsjPOQ+ad/FfdOjaYMwyN4JXmvrGuI1NncqlRI5XLZBoBSxmMx/RjViK9pR9lvwYHgiEuk2ve2PTsk9yy9WV0BMY4qN1MXH9KBu/AAsGuYHzamH4NcY20T6eJzDsts1o38LR8YfCvQyqBuW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:37:53.1299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d467b3-c3b1-432d-6513-08de80773c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

Customers have identified an issue while using the QoS resource Control
feature. If a memory bandwidth associated with a CLOSID is aggressively
throttled, and it moves into Kernel mode, the Kernel operations are also
aggressively throttled. This can stall forward progress and eventually
degrade overall system performance. AMD hardware supports a feature
Privilege-Level Zero Association (PLZA) to change the association of the
thread as soon as it begins executing.

Privilege-Level Zero Association (PLZA) allows the user to specify a CLOSID
and/or RMID associated with execution in Privilege-Level Zero. When enabled
on a HW thread, when the thread enters Privilege-Level Zero, transactions
associated with that thread will be associated with the PLZA CLOSID and/or
RMID. Otherwise, the HW thread will be associated with the CLOSID and RMID
identified by PQR_ASSOC.

Add PLZA support to resctrl and introduce a kernel parameter that allows
enabling or disabling the feature at boot time.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: - Rebased on top of the latest tip.
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/x86/include/asm/cpufeatures.h              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 arch/x86/kernel/cpu/scattered.c                 | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..b1ea28505835 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6439,7 +6439,7 @@ Kernel parameters
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc, sdciae, energy[:guid],
+			mba, smba, bmec, abmc, sdciae, plza, energy[:guid],
 			perf[:guid].
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..b7932ffc185b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -515,6 +515,7 @@
 						      * and purposes if CLEAR_CPU_BUF_VM is set).
 						      */
 #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
+#define X86_FEATURE_PLZA		(21*32+21) /* Privilege-Level Zero Association */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4c3ab2d93909..8fb9029fe547 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -799,6 +799,7 @@ enum {
 	RDT_FLAG_BMEC,
 	RDT_FLAG_ABMC,
 	RDT_FLAG_SDCIAE,
+	RDT_FLAG_PLZA,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -826,6 +827,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
+	RDT_OPT(RDT_FLAG_PLZA,	    "plza",	X86_FEATURE_PLZA),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 42c7eac0c387..acc137d327b5 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -59,6 +59,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_SDCIAE,			CPUID_EBX,  6, 0x80000020, 0 },
+	{ X86_FEATURE_PLZA,			CPUID_EBX,  9, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
-- 
2.43.0

