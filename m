Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D0331209
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860872; cv=fail; b=uKBgnrmGJLF6k586bzueqP/ozcvNYYBkbQPfngZQfYBDlpoUAdrdO/9xh7UocEWXeYJtgVnS5BkL9+i2EHlIGKycePVeV3P2wsv4I6619g5t1AoaYG3pS42Xcxd1q++GZfYEMqYWNQ7Lcrk2da82CwND0E6E7FbFmJRhtODi4ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860872; c=relaxed/simple;
	bh=NUAIx+lW6l7SZ8Wn3+FQd7tL9vePdeuSTCHUIbnBbmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8Cif2kEqy4jLzvAf9J+MWRgVO3ptqdpPlcga1Z5fzwLtKOjoz9cX0k49snsFg0QBnYqSzhOzyLN9qrumRDbKHn5Jd3rx1IcPQFcw1cuTfE+lq43zCAPCKEVTMzOCd47SRbOQZwnriPgGcce1iOBKjxyX0LqQPzHnGQ8GKwT00c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eboVXvSr; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eboVXvSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwVG5WAIa5QxplL+DCHoGjLxk1GsgZDVRqTUNVDzvp02p61sAe8DHfm2Au9GR5Og9jdSf6e78ds06zz52uyNLICRSr/hb5/9ayp41hWV/E/XswC0fnuXYXcF1uoY1ZH7ILXcUouYye3LVq3/KvHRydrqhTcNZNnzf+hJmV2Vrnbfwriee9+gxZbqXnMVZ+CXcMUpEeBp8LWNgiEqfzL7w4fQny7MC+g2omzyiI43rl35dNsnd+Uf6C2DkjPL2qhviiqP71M/Vkuu7SJSQ7TDbFtvGWc0WXps2qhcs2OHQiF5WiCLYekVJPmAGjXmOUzAoXqYH+BUfywB/GicTaZLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi+4hzW6IJ6/9klLx/wcBOWoFDSlbswfB91ym3exD+0=;
 b=eHIYx1Zn4oHQWB3TgnzpvoM6ZiyXZ7RVVTflRuI2QWs6kx6Asqdmf+jtI0Ys+2Mznlbbq7HXwbEHMC224dsDLh3uLdwThx1O8tH5mMc1M78djK6Uv3isd66wnU1La7lf1X3X6TusCnIHy5tQEQQGTKb3NlLCL64GgO1uA8s2nyFwF2r1Q32gCkaPw+qjA46egmOcOWiladGIer6Sp699HK+5YeR+WCNZoVkRGxebodpOrszBBXI8niuF/OTvZ+LfeA1kgJ/RijVCClBV1TFZ9nnZdsbDGSLztKo1Pg2pnmGDb5EWNsFx/RWY2pafFvHtvkJB+BzR+E+7oCqEV3aPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi+4hzW6IJ6/9klLx/wcBOWoFDSlbswfB91ym3exD+0=;
 b=eboVXvSrIJAjXd/SKZHokgH3lsrwmQ3SbJpn6g8W+EubtlfhDUeQgiW3GTeTHTfy2P7IHKWMi6+9bxul1RQcCsI1YZMahvcXXO+xHRW+EVwrB0Q4qostcJwtiT4knLKgmgwzW6+PhC5kVcf9bX2QK2lgjx9DKly/ue7E1V+e/ps=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 13:21:07 +0000
Received: from BN3PEPF00022BCA.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::4a) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 13:21:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCA.mail.protection.outlook.com (10.167.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:06 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:02 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 3/9] x86/sev: Add PMC virtualization support for SNP guests
Date: Thu, 1 Oct 2026 13:20:15 +0000
Message-ID: <20261001132021.254270-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCA:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: de661301-6836-48d8-6d02-08df1fbed9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RY3rUDsxy3jfG5AkWAKsXY6CccSJneab17XdZ3HKd9oVHGOHFm24FvwOi5/GlsUnqwumNXbie5HkWCa9RuSUdMtbzuU9zYbfaVoZ6ASbV7f5AoE7Kl8n7p3cdWkgZAHRWsmtX32gtB+gJZUoB6XBYUKu0oGkphMWLg5Kwvawbi0nSkgEkwxLkffC7MzK/Wb9LZrMDWLjAo0Ng950gb2BpiTuQk6DDW5tH5JkR+je2302hclMyvaFiBsRWL/euCm8j2WNhhStGIdsDkJ9ETSJtkUmvcNYxtbO2Rxb5L1dRH/om+mFKyMuHY77CS4qDoDwXEaWp87Cs3ZeLttSSyGlypvM9jeqgvi2n6dBaqbLW0xCkYmJd7onpqpgOPICuxDTc9DEX5vk2XFIbhBrpayzrba+bBgH54/cc5OV6YQXD5AK4lkY3i6FRq2p/w/899f2lDMLy+Q0Hyfwmy3I3ChdfmITcPcwg5KYsduOl2wlVisGzOI6rOfvKNiAyi9lE6+9el8CcgiwuVoPs89hbpNLeIr0+BIrRQJ9TSBsf2zXCSX15L8n88t5AzOcO7Xmrm6YchI88KeHCGSGS8QUg4m9zRWxQM6DJYyLyAf6L4RmqI6OpXjB3PQ+kamoeXtX1rVFj/gUZBh/DZow3WnKKbYdH6nDxy6olVXsrzsJUyWxOJ8DN1m8tU1BJJqxFNggLVIq22vx/9XH+Jwh1S9UXhzRJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ryvk1QHseiMVer0KtjXwVoSMWLs+09OzRPShgIsxmRp9mc5a5sJa+Cn67tqQDSKNlSD8WRd3mENLJ/Hip3OyjDPEzBZEC7AHTB7qNm6WyByxqXVlgJoe5lPvVbt79ve4tbgsi+KGlTz9ymUcmY3SHM/83Eu0AGs5k4yfyifAo51v3pX/9sYOeQjwmn05dkRZAfXqlIP6FCbWd6ymqXr4+iQiBFdibRsHJU4gDjQo8x/QBri4QakuVIu2EtAaY26mLhSe8pubWTxwkroPYwCvJuWQ6GQAkvZhXEvbR9BFr8QCQCQYVJK06qT5xzyVxp7FUY2UFwRA7UfHbzhOu7rLfe88ekgJ0PKLMW1A4kq9VUieZjFpWkVDeRFD6J4wmCCRbScVu7p5khA0b81MbbwJYa0QMQSt9S2AfQWhfNcoPhHgCTLwFNuj9OPmLJOdl5fW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:06.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de661301-6836-48d8-6d02-08df1fbed9ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169

From: Sandipan Das <sandipan.das@amd.com>

Redefine the previously reserved bit 13 of the SEV_STATUS MSR as
MSR_AMD64_SNP_PMC_VIRT, to advertise the availability of PMC
virtualization on supported processors. Without this, the guest will
refuse to boot if the hypervisor enables PMC virtualization.

Enabling PMC virtualization requires guest-side support since the guest
must seed the reset state of PerfCntrGlobalCtl in the VMSA of each AP it
brings up. Otherwise the AP's counters come up globally disabled.

The boot processor's VMSA is prepared by the hypervisor, but AP VMSAs
are built by the guest. Initialize PerfCntrGlobalCtl for APs in
wakeup_cpu_via_vmgexit() with all of the available counters enabled.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
[Manali: Cache the number of counters, capped to what the VMSA holds, and
 don't build an invalid mask if CPUID reports none]
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/boot/compressed/sev.c   |  5 +++--
 arch/x86/coco/sev/core.c         | 35 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h |  3 ++-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c6512f2ea31e8..4571e2c3a1087 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -185,7 +185,7 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_SECURE_TSC |		\
 				 MSR_AMD64_SNP_VMGEXIT_PARAM |		\
 				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
-				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
+				 MSR_AMD64_SNP_PMC_VIRT |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
 				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
@@ -204,7 +204,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
  */
 #define SNP_FEATURES_IMPL	(MSR_AMD64_SNP_DEBUG_SWAP |	\
 				 MSR_AMD64_SNP_SECURE_TSC |	\
-				 SNP_FEATURE_SECURE_AVIC)
+				 SNP_FEATURE_SECURE_AVIC |	\
+				 MSR_AMD64_SNP_PMC_VIRT)
 
 u64 snp_get_unsupported_features(u64 status)
 {
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd77d3217f3c..60a0403898e4f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -44,6 +44,7 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 #include <asm/msr.h>
+#include <asm/perf_event.h>
 
 #include "internal.h"
 
@@ -85,6 +86,7 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
 	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "SecureTSC",
 	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExitParam",
+	[MSR_AMD64_SNP_PMC_VIRT_BIT]		= "PMCVirt",
 	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
@@ -754,6 +756,36 @@ static void *snp_alloc_vmsa_page(int cpu)
 	return page_address(p + 1);
 }
 
+static unsigned int sev_pmc_nr_gp_counters __ro_after_init;
+
+static int __init sev_pmc_init(void)
+{
+	union cpuid_0x80000022_ebx ebx;
+
+	if (!(sev_status & MSR_AMD64_SNP_PMC_VIRT))
+		return 0;
+
+	if (cpu_feature_enabled(X86_FEATURE_PERFMON_V2)) {
+		ebx.full = cpuid_ebx(0x80000022);
+		sev_pmc_nr_gp_counters = min_t(unsigned int, ebx.split.num_core_pmc,
+					       AMD64_NUM_COUNTERS_CORE);
+	} else if (cpu_feature_enabled(X86_FEATURE_PERFCTR_CORE)) {
+		sev_pmc_nr_gp_counters = AMD64_NUM_COUNTERS_CORE;
+	} else {
+		sev_pmc_nr_gp_counters = AMD64_NUM_COUNTERS;
+	}
+
+	return 0;
+}
+early_initcall(sev_pmc_init);
+
+static u64 snp_get_perf_global_ctl(void)
+{
+	unsigned int nr = sev_pmc_nr_gp_counters;
+
+	return nr ? GENMASK_ULL(nr - 1, 0) : 0;
+}
+
 static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
@@ -849,6 +881,9 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
 	vmsa->vmpl		= snp_vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
+	if (sev_status & MSR_AMD64_SNP_PMC_VIRT)
+		vmsa->perf_cntr_global_control = snp_get_perf_global_ctl();
+
 	/* Populate AP's TSC scale/offset to get accurate TSC values. */
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
 		vmsa->tsc_scale = snp_tsc_scale;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e9271..b356e19da07bd 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -735,7 +735,8 @@
 #define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
 #define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
 #define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_BIT)
-#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
+#define MSR_AMD64_SNP_PMC_VIRT_BIT	13
+#define MSR_AMD64_SNP_PMC_VIRT		BIT_ULL(MSR_AMD64_SNP_PMC_VIRT_BIT)
 #define MSR_AMD64_SNP_IBS_VIRT_BIT	14
 #define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
 #define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
-- 
2.43.0

