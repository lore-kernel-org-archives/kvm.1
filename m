Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693A4A8A3F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860877; cv=fail; b=UbKW7Sbce5mTC2sEsIuA468tnuxyk76OAOpvv8+E+rORJkaFyZ8ybcfcEiwb/QKQ9QpUdVVUCALR9k9LaYf/bpE2FSssvJzBwcjZKjtayFeaOLgEe2lQYksCytp8OHnre+9kO1+PK+uzNliTrZYS2lMNE4BISCdvP3fVI2NmJVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860877; c=relaxed/simple;
	bh=7k6MWtVS5Ctz2HVA4p0Yurmp19AFP5qJJXFOyptgI1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iF2Ml1FO6LVzhwk4xlmSzmxuUbMj3c9aLEPQrudmB6sJlxUdmS5lx2gu7DxL5V5UruRbwZPjshzJNf8XEUSdpvMIu5ptXTuqBZ3kQiXzMi7y2RXHdkDkMGHRuezMrui1SOXDPW2k2CG2hGl0P7smmjexJ4wfRpC3jYn7Sd8RZjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZAB2kW6V; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZAB2kW6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCDAyLfmdxH6Nu43o/3vshnbop5/FZyf1bo47D28dlxH+cDWg+Q6X31pn0/23NaCIrBOdXCVxwRgpFhPPhNodizU7YpyX+YMZfljsHOK7ZGU21+ttpIgtz74VgYFCpbLk2vb8rkBMsmaYwzpfIXlQD8qPcDgOC9w1Y4dCIotC86f7cMM/rUFMV40Dtp4K/VyAvNfMbgqntloRItg9n+ex5UQNGllyPi1x+1JF82CVaAdt8/jxSKDrC/ymkiDYBPPsLavC5hrIU7HZQuJzj8RjVdcTmjTDQEjo80t7o78TlGQTJCZzRjE1r5A3YqLKJ6lw+UQFfshJgEPKI1jM4EQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOI3W8Vquz8jxyTeQU7v4Z5zGgCS+X80sPDkjZ5Gs7o=;
 b=iHY37bAPDjsSzveLmSkOL6mMVknn1uGzIuIbItrBzGnOV6xMqWgQVJaR9L4OVgyTIbb6Zlrg5GLQTRNIqT5FqQarwYyPy8exK2Y3Oetr8LueuqRHNFXKq5puSvtpNr4oKV6abjqkaFBLiJzLXCFs8VAQyaocugvDzIa5/XzSp+KPNsxqhf+VlsJ6RMXtU/BRqSvEfiO8RxMc+KJRBY9hN6/d3zzV6HqYbYtohLDc3SHNOj9JSG5E3IBGa2yMjW3TvgRHvOEKQSLnl8fa7Y/DYextLzwyqH6ZfJ0kuPabHMRj0xZ7PDaqiJTlEW8w812mw6bLIzjiWH8X34Pc3j/hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOI3W8Vquz8jxyTeQU7v4Z5zGgCS+X80sPDkjZ5Gs7o=;
 b=ZAB2kW6VFcIEtCuiQ/aN5IGPKtM/uWkecaMiLUHGCNZMkuJJSQnb+QVfMrzEprhQoUHC1Gliesw5p561Jf9B3SR8BsDOGKlVscHcLjnWlrwQiduy8I8UTWvQwfcMzwqokojw4F+58hEmyf2nVRgiFKQ6JIFVKgmouKKJmN+wX3o=
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 13:21:11 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::7d) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Thu, 1
 Oct 2026 13:21:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:10 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:06 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 4/9] x86/sev: Define the GHCB PMC-filter protocol
Date: Thu, 1 Oct 2026 13:20:16 +0000
Message-ID: <20261001132021.254270-5-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c80a4d7-8928-47ab-1445-08df1fbedbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M4AdBZSW83cM3zpDFj8NLHezD/eTRKj3GuPbr8vEbB7+RNCmUBEPsYe4MAl2Q4r40h+f6Siz0bo0LF8jsOz7U5wjU8Ub/+AO4k8fLPrut0/2eIW65Q/MyfPkiGhck8y3ji/6K2HabMTbb5ztzbIjavbosapP2GQde7Mx8fMc2ZYgYTtbzoocuiQtbKj3XX6m/zqeUdl5+L03KpLNGRtB5zmS5994yYSvEijAJz2UX/CsU6L/QtJ8ks3CsHFMOAcrwd0bqQWWkRrx+ESWew9vT912a1qgoe/rBWy33DpaF3/x9P7vnkDGmT1n+f3CrapXQyD4SbeIKRNS8+WSHr6vizBfmMJzFEaI4XvW+qF9QFNiSUkeiKztLR1H/HC6t1u5YF+AvhOEgUR5vU70Ca5TAb/swbqjry3YtEOxgq6fscqO+RO78KuTKhUDYWQEJJEo8TbwC1Zb1Grc/bnKE9/NurM7w/vsXSty06ZP+KKd7r7zjk6bM/XsrDm/DJSTfmbHPOVvcfThGNn/SmACDsvWAIKVYxwDXNifKz3mtZavUWLMJGdWj9HX2C1S7958d358bueMY/i2mGBTryYjHdwrvSEZRYDH3WeRSxWefxfGIMqS2ge1om8rRelUz/XkCxsZCnk6F4BeU400k68Pu5XQ2iQBDaRXwOs5Qg4eFDUvHD8iRMAkbbF3HNZ4cgG4MyGpR4nhYWlOyZ92Ga4PvwHzkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B2geynVUTD4u7md8Ea43ZFDXHz5fwodd1krlxPqsxI/MuWfcaDzo57LhS0heOVZPHAJiKldwfYHdTvHDj56HqRG60Ywi1TiS0AalqmEzI1vFCCfuL2mTEmzwVjHW1ehbk/PhOWrTKZuSiT+Y2MkUu2C2Lf/+gt8MTvwqglmNvbh4NW8erZ4CcAx8v1fgRPey8o+VCH1hoMiy5tjLTsc2vMUBMsNy8AD0ZLwKtvhCjulfQuC0M1ml89jIy5kF69+ifW2cobAgarWFxdoKrHRouXpH0+niK4xoE1bhT3f6RXJiBb4gz4GYseGVKUDOv9+kf95vWufJAPA7RpXIZM1OfSupdF6JyVthZL8o47w7+KYL0DeXE+k55HMzk7QyDIoVV+Psx4fkphBEOMRvzgNLt1JnM7TEt3YkfbwWsB2Qg1xDQciITJjfalRbdh3Dtlmj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:10.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c80a4d7-8928-47ab-1445-08df1fbedbf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

With hardware-assisted PMC filtering, a write that enables an event
missing from the hypervisor's allow list raises a #VC in an SEV-ES or
SNP guest.  The hypervisor can't read the guest's event-selects from the
encrypted VMSA, so it can't vet the write on its own.

Add a NAE event for the guest to forward the write: RCX holds the MSR,
EDX:EAX the value, and the scratch buffer every event-select.  The
hypervisor returns the value to program in EDX:EAX, and the value of
each event-select in the buffer.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/sev-common.h | 12 ++++++++++++
 arch/x86/include/uapi/asm/svm.h   |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 01a6e4dbe4235..bab705f6ddfd7 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -176,6 +176,18 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
+/* SVM_VMGEXIT_PMC_FILTER buffer, one entry per event-select. */
+struct perf_ctl_entry {
+	u64 perf_ctl_idx;
+	u64 perf_ctl_val;
+} __packed;
+
+struct perf_ctls {
+	u8 num_counters;
+	u8 reserved[7];
+	struct perf_ctl_entry counters[];
+} __packed;
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f6147..fb917d0384fb5 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -122,6 +122,7 @@
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
 #define SVM_VMGEXIT_SAVIC_UNREGISTER_GPA	1
 #define SVM_VMGEXIT_SAVIC_SELF_GPA		~0ULL
+#define SVM_VMGEXIT_PMC_FILTER			0x8000001eull
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffdull
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffeull
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
@@ -245,6 +246,7 @@
 	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
+	{ SVM_VMGEXIT_PMC_FILTER,	"vmgexit_pmc_filter" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
-- 
2.43.0

