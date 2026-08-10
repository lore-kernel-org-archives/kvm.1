Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5A3B95F0
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356968; cv=fail; b=jKFsaUywoVP9BriC5qn11MwbRnkybYV8CWffFb3ZYX6TF3DVR630p/w687A9pHQaxbUUFFyxjutH/tv3JzKtGE2LFKmtzvr5FUA3gutozdtPR6pXGjgCCUO4fdxPIhhuNiZ/d62C+6zfZx/B329Cb+CcdiNTsM+9+GzpCtM3E0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356968; c=relaxed/simple;
	bh=FVJkuR6MX7w/XJ4ztpIpK9tDFOpgaA0B3u1O1mrjZ5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1dvrw7N6tzDKOM67GeuUZv9I5sL8klWhEgaLmc/BB6Gk3oKagH61YK8y3vIETCr0GFzbLN/42FcL3uOTwK3rZn+KB5ldDKbPfq0Zqy59w4jO9FfYXnBnyjKccq99lFn1MyoC464HoBlEzfL3Y56t8o0Dh0bMOjvTFO65QFlKLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pg+bmBh9; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pg+bmBh9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMneu81a410o+DBbecAgu8fGDyQJSb+jqfnwaL27VkUcMANzU54ncym3A2Cgn5TeouCUewkCdadDBdMb4V30PYu2PhQtsAfbZlaN0pqXimaFZnHVUSrswK2SsWO19JtuQ4Gcem61uhD0EJWfWUGMzo8bLgpXe/VDDZg08CjMzsGUGy6Qjbar80NZY/Hz2bbHzQ2Ts+6+p6pSD9S6vPh5AcNPO6xeaJAxyHT0F3yGev70qMdJzl+nxjhtF8CcVCwTT3RSDOhvNaW6yzGqhkCeLu5lyWABNVG9/RQEGcaGB8XLk2CRAc82Oci47zbMWQZ9s6asT9oaeFobhs52eH2hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4HOsb0XzQ352pAahsoLEDN8TH95Fs+ExHQL3hbszow=;
 b=lWDMKvRBlLdt5q2jWhbTSvuyh0wnP/jSqrMXSo7WiAIXBJtuxUNSt3X7YpmMn/qQJ0AeGH+F951qSuthwewpm5ENgqh1ZzMLde3I+hRIAMi6EGKFf8PXkfiOdxx0tSb98qeTDKo92UJgM+0e3EXNfGxx9ZQriZ98BfVq5D3atmoUHPBXa7PMZ8yyYSF24UIVku8cq5GBl/dF1uzEZspbd0R3AnQiurRkC1tvEh/+lF1DYAi1xZJZzJ8Pc4BetozVc+Cs+HHpisbvJVCkuZdZ+cdIpNfj936TamuKGi1LhTBVHVuyu2+TxYsRDgexyammU0L2KneThopkFERwLqvXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4HOsb0XzQ352pAahsoLEDN8TH95Fs+ExHQL3hbszow=;
 b=pg+bmBh976B/lQCMaYAYMsokkQbXhpok5xjCMUzRNIyOfVQW53w817m3hMLWIfUldQTNxdAPWbwuGXwcdJVvuQeL8GkFST9M1bji4niUfnDPTBYpTY/B8LxQgZKZwr9w69v17rxai441sCbz0tQMV1c18HsxeRCxxF39DuQXaPo=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by DSVPR12MB999125.namprd12.prod.outlook.com (2603:10b6:8:38a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:16:03 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1d) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:16:02 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:15:58 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/8] KVM: x86/pmu: Add mediated PMU capability flags
Date: Mon, 10 Aug 2026 15:44:49 +0530
Message-ID: <6ee8548572f74a2ded7e2904e222045c257a9812.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|DSVPR12MB999125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f03f493-d4dc-40cd-d101-08def6c8619a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	jHM4qtQRKge7uc6jzLxVF8P29Bc1Db1RiSF4+Pta7INkN7g2lwAt2WafsQW4zIwZP641D5mYzzuGw3WD1uytzIqo1rPMb5UDtxjjI8OoM+EqGFNus7vOML67LNJMufRepPeyoCSRmV2DdtwYnPfsuWnnwQZC3VN2sXVvxqNDFGurSV0AKCk0wi46A/L2E8V7WerJWOw9YQizgbzJNpVtVIFwQKcuacPH51KkuJncHeMZW+Ubh5XhhJzc7GBJcfa6yWuxvH2Hlum+JQuKy+w+Aj25M28z17MU0gmB+8HgFX019n5WC632Spx3f+H8dDwKiPUP6vaWL0tgeLSprdOuzEOowtCtpoSGHnlmHnwCKDaVdcNjV1JlE3ja4e1YTe0L5AZBPC7mfzUt3ifext+FpNBeFpTKXZDbT3lpeW9xvHp7/PnhOvpGt5BMAQLL//SU4mWLMHxUeee6WFscqSZ8eO29UmsCDJ1EVFXoOxhyUfcgMmylmXZvfyjepYwKnQ3dtFQrcVa2sIiZ+Ew6JvVrNIQ974IUgXGA7hLIEURm7Tk8FTpzkRriDLi8pB3cdlgV0ozgaC0P+iML2AF4F7wkc0yP3/nzx6n5u4A7fUur260z/wB9A37MisvatUve2QTCSbLhvWJU6ST90sW/bX3pLt92B428EWP6agjXTABb+kfLJORchtxTPQJWLP/FYD5oZPr7U5Got6KS9Stsm8gPFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nK+BH6yFvn3JMo6ct1GGx9E53Dead78U17tAtGOXHTbnCwaUMxHH95DxO5vv+jjiQ/YbK+bTpCz3zM2mFLpaXfaKfYzwwK+yYvjVZ7TJ4ZjHCvIDTCYGI1IWTApuIeXw97JRgKCB9lavuKy0z5txwJ64HEj6y/XI6bpL+vbBvX0O7oFOi59heUwp2wGY1X+7zZRhmbvxbfMh3LXHvYnAwm+w//kLCm6oBWViTL2pZ4WkB4OAEqjr7F+msS5DIuDB/BoBlu9vf45bT6TBCrGLtT3Zhe/TtQDyX/0uh0PFncuGLu/2F/ZWF5AjyZDNT+hH2LQbyDJy5MBWRvHAekWHdNNc27MOsU3yniO0fti0C5yKVWOGUEwFWi9PrSwbDQdkB68qseQ8hf5xwMzguURJcpL4aTXDiqfpShgjXDDlnqqjuoErISLxA9nygI/IchBQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:16:02.3277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03f493-d4dc-40cd-d101-08def6c8619a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999125

When mediated PMU is enabled, the guest PMU state is currently saved
and restored in software. On capable processors, this can be offloaded
to hardware. Hence, introduce the notion of VM-scoped mediated PMU
capabilities to help KVM determine the available hardware assists.

When set, the KVM_MEDIATED_PMU_CAP_HW_SWITCHED flag indicates that
hardware is responsible for switching the guest PMU state. When
software-switched, the guest PMU state continues to reside in struct
kvm_pmu. However, when hardware-switched, the guest PMU state resides
in a vendor save area.

While KVM_MEDIATED_PMU_CAP_HW_FILTERED remains unused currently, when
set, it indicates that hardware is also responsible for assisting in
guest event filtering for further reduction of overhead resulting from
intercepting event selector writes.

The capabilities are expected to be set in the vm_init() call. All
capabilities are cleared if kvm_arch_vcpu_precreate() fails to create
mediated PMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 11 +++++++++++
 arch/x86/kvm/pmu.h              | 20 ++++++++++++++++++++
 arch/x86/kvm/x86.c              |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..338df11e2a4d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -715,6 +715,16 @@ enum kvm_only_cpuid_leafs {
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
 };
 
+/*
+ * Track how the guest PMU state is saved and restored, as this can be done
+ * either by software or, if capable, by hardware. When hardware manages the
+ * guest PMU state, the state resides in a vendor save area.
+ */
+#define KVM_MEDIATED_PMU_CAP_HW_SWITCHED	BIT(0)
+#define KVM_MEDIATED_PMU_CAP_HW_FILTERED	BIT(1)
+#define KVM_MEDIATED_PMU_CAP_VALID		(KVM_MEDIATED_PMU_CAP_HW_SWITCHED	| \
+						 KVM_MEDIATED_PMU_CAP_HW_FILTERED)
+
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
@@ -1284,6 +1294,7 @@ struct kvm_arch {
 	bool bus_lock_detection_enabled;
 	bool enable_pmu;
 	bool created_mediated_pmu;
+	u32 mediated_pmu_caps;
 
 	u32 notify_window;
 	u32 notify_vmexit_flags;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..1aa46d3e2339 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -88,6 +88,26 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline bool kvm_vcpu_has_mediated_pmu_caps(struct kvm_vcpu *vcpu, u32 caps)
+{
+	return kvm_vcpu_has_mediated_pmu(vcpu) &&
+	       !!(vcpu->kvm->arch.mediated_pmu_caps & caps);
+}
+
+#define kvm_set_mediated_pmu_caps(kvm, caps)				\
+do {									\
+	BUILD_BUG_ON(!__builtin_constant_p(caps) ||			\
+		     ((caps) & ~KVM_MEDIATED_PMU_CAP_VALID));		\
+	(kvm)->arch.mediated_pmu_caps |= (caps);			\
+} while (0)
+
+#define kvm_clr_mediated_pmu_caps(kvm, caps)				\
+do {									\
+	BUILD_BUG_ON(!__builtin_constant_p(caps) ||			\
+		     ((caps) & ~KVM_MEDIATED_PMU_CAP_VALID));		\
+	(kvm)->arch.mediated_pmu_caps &= ~(caps);			\
+} while (0)
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..4287982638b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9326,6 +9326,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 		if (irqchip_in_kernel(kvm)) {
 			r = perf_create_mediated_pmu();
 			if (r) {
+				kvm->arch.mediated_pmu_caps = 0;
 				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
 				return r;
 			}
@@ -9334,6 +9335,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 			kvm->arch.enable_pmu = false;
 		}
 	}
+
 	return 0;
 }
 
-- 
2.53.0

