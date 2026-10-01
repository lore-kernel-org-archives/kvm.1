Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65144ACC7B
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860890; cv=fail; b=sgWbg7l6a0vnMl4KyVZEtqzIydI0M0O3zRgw+0WSdDo7R7x7oZH36bnNaALNigTUPfBwOgYVGbRsw2FL/jhL2igobO0NZ6IBodX0rivctDXuS57oqXxYyY0651KnA1kBW7E+57c1zJeBkzGusnCkiksbOyFteYzhwkqf83cV3p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860890; c=relaxed/simple;
	bh=7c3TPavAZ35dQOHVOdC1iK92j/UfBqatoyAvrqF+KYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5yOLS2SWI+8GMZ2erAK95TA+4+6bLJPjuXWfUv/jQPs3xUoMHMMEMcJhpSN9eWwCaoURIiNrfQzniBZe+PjfSA2aVhaZ2JvyRWG8ybVgV3XFwsH3pnGoRLG5oH92i6a6t5Elx6bfz2lz5badfScpftPVdi7ScOTiF9Vo5wxpOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HY5sxwGP; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HY5sxwGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx+Ol1BgMGzaAPZVOjBIvZQFN5MAhj2FZ27DLtGJZb2ePu8fqt9MgUb63Sf1l2+iou3bu29eE+ro4eKqS4AEqLFuu8ie1vwZhTILGemfGnlIHnvOxKx+8kZt3/zz2Q4p6/CMlpLA4GsTMXXCgsaiGv+dxLEz9+JmZob57KO2vzcmRya8H6SE/dhj+lHwrQ8Dh0les+t3Ef8QcrEmv1POdL8PXV1QzQQO2sAZCAHL9MFSzKhDZZmFN4vPdz527K4R4S/r6m5vu2TFj+7oZzCZx0V04czAvkxBMw6KfVDyJE4jhyN5ISRMhQqoG7Q+iJD9YO43DbZukpOlVEXaw53MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bisXHmCSAt5R2WpboUp3Gb4SX5wEsv3206QdiP1jtxc=;
 b=PdDXOTFmfPOyeUlIRHUfQi4/9oSoX8Bb5obDHGnV5g2+8JO+srBZPcGeCrwm9eL69u7SiJbc1/+HgyN+rHEsv0N7+7Y4AjS1puVJanNX8y4BV7MqVORGaYKz/xUpywdrQvM/V+7/UEZIZYeMBAEv7Gh0TB130g1csHnchgT9068wdPW8pT1UQYsBTRIooZAbI38Hu+seP3UB/3z9CPie264eP9Rb0Z7van33ZEB6hQ5H1mb87udAaQRAIgxGpxVxazXvueQre0mV74vVTAZYw0GL0eRJ8HrSF0LDD6hF2anJ5F+xXJYUztnXPsyZAqRfg4lNwbb92Jco8G/vBDbJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bisXHmCSAt5R2WpboUp3Gb4SX5wEsv3206QdiP1jtxc=;
 b=HY5sxwGPX5HGyLMccyCwhD84LZYNY3YNk3eNN6AVTIqdEOdMwFbO6ROAYOo+ZFVaLdWVv8b5mH+XJ3b01wKtGtEel6fjwilqyZsfUhtFAzZ2K/wdmWmdIyXEWmp0DziMFQAsoV6irQSR40Vxkp9u4qgbNuzdoTiMyIjfZal4QCc=
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:21:17 +0000
Received: from BN3PEPF00022BCA.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::93) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 13:21:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCA.mail.protection.outlook.com (10.167.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:17 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:13 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 6/9] KVM: SEV: Add support for hardware-switched PMU
Date: Thu, 1 Oct 2026 13:20:18 +0000
Message-ID: <20261001132021.254270-7-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCA:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3571ebee-1582-48bd-5110-08df1fbee03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|3023799007|11063799006|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	dId7VQooir0SrzAzs4d56Ba+gimCc2IJ7cbA4aUjsfXTOaGVD5vjrGt2O5FDGNnx5d5Tk777tirfb9Qz/DwlHCQyv1k0UJC9/5o5vhp7rXv5Z4ybyPsw5a4/TwVYUBXTaCIQdkqonvGK8QcJK6lujTgK08Fl/MnJWM+e9hAsNPA9ZCWd0h1rDJJth0ms2sRkz9iY93gj0Xk3t7BKU7Wo+ovZQeFYSMLC0CuOulMgGEcVnHTpvRPOPNnHJAaJjLEtEnsMblMHWhdeo0QUTZiqYaDlO5HcTUBswqg2ixRcEFcR9y0uUv9ZKe9QFO1t7f8jl/9T1m50wJhu61VfBfkjRYmFPAD4OhgBXAVP/IP/qKEdqRhbZoOXWjn6HCmvURxhLvi3BmiepzzROd+LB1zZnzojbDh7HGJlXMbEmv9AXxKk+4H/omb7Z7nBakqXZq24QikKQb45ajlLv7t5w3lgoFVZO4YXNygEw8oWdhgMGZXmbpRhNu0dNGYVblQase07NMCIU9UZoCb+KQ+iFTo9RrQdeV4FUGYftvT47vU57mwsY1DK3d0Z7CW4wt+M8Mj1YcaHHdcoGV0HQtVVynhZYMCik7PEUDi5XLiSiUN3xrPMBEbVD2xj/XCJf6SW4Zg64nPN3dA4he5935fuHX0c3+wF/iWKU1wkgqlNfTurF2Mqv/TVJN89S6MaZoNid15w/R7zHUHWhlcKPccuzEwyNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EzpihH3NPkbYf4UFsK1SbK/ad0CneJwaWIxq3RzEoMZ8WTsVqC8SCKmXjBAvx5fArx7uavVnXExc0kOSqxWbMLb/ppDfMCTrwy/6cTG7iREQW3g87typ2QLendWg0HH9IH5Mz2WVrgf5W4nzwfAvq9qtNembwhC/LGaXXu6Kn6RkPyLaGPJNBMmqaTLzR6BLmQEWYrgslaU+JPIuJpXWP+53UmtzyOaFogc9on/Sw7aoj4RJWAwG8xUXatgTiwE31L33HfZAFyzLjNB6fvOmmboQnOj87YySqKDfqWYJwIajarQoABRLfDGhnFmEexh7SkivWF7DCarpIVfegsW2sAK1TLAhdf+zmTWJU3ab+oOuVREH9vL1D79tzsNCcEdxarDq6Tuc8MpyTweNpuiRpe0Js5NXn4N1b5sNjEAqi9BbJ48lWAGXBGnxvCJgGqYg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:17.5025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3571ebee-1582-48bd-5110-08df1fbee03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

From: Sandipan Das <sandipan.das@amd.com>

Extend hardware-switched mediated PMU support to SEV-ES and SEV-SNP
guests. As the guest PMU state resides in the encrypted VMSA, PMC
virtualization has to be negotiated with the guest through a new SEV
feature bit, SVM_SEV_FEAT_PERFCTR_VIRT. Don't advertise it yet: a guest
with PMC virtualization programs its event-selects directly and would
bypass the PMU event filter.

The requested VMSA features are only known once the guest has been
initialized, so set the KVM_MEDIATED_PMU_CAP_HW_SWITCHED capability in
the guest init path, gated on the feature bit.

Once the VMSA is encrypted, KVM can no longer access the guest PMU
state. Hence:
  * Don't load or save the guest PMU state in the VMCB, it lives in the
    VMSA.
  * Do not intercept RDPMC, as it cannot be emulated after the VMSA is
    encrypted.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
[Manali: Keep PMC filtering off and PERFCTR_VIRT unadvertised until KVM
 can filter the guest's events, don't WARN on a protected vendor state]
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h |  1 +
 arch/x86/kvm/svm/pmu.c     |  8 ++++++++
 arch/x86/kvm/svm/sev.c     | 28 ++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.c     |  3 +++
 arch/x86/kvm/svm/svm.h     |  1 +
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 6272ebc955d32..0e4a01e36e54a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -316,6 +316,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_PERFCTR_VIRT			BIT(11)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 52da247e23050..3ef05b651de21 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -198,6 +198,10 @@ static int amd_get_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
+	/* A protected guest's PMU state is in the VMSA, there's nothing to do. */
+	if (vcpu->arch.guest_state_protected)
+		return 0;
+
 	/* MSR_PERF_CNTR_GLOBAL_* */
 	switch (msr) {
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
@@ -233,6 +237,10 @@ static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
+	/* A protected guest's PMU state is in the VMSA, there's nothing to do. */
+	if (vcpu->arch.guest_state_protected)
+		return 0;
+
 	/* MSR_PERF_CNTR_GLOBAL_* */
 	switch (msr) {
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 28bc15def6a2c..1cf2260423573 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -212,6 +212,14 @@ static bool snp_is_secure_tsc_enabled(struct kvm *kvm)
 	       !WARN_ON_ONCE(!sev_snp_guest(kvm));
 }
 
+static bool sev_es_is_perfctr_virt_enabled(struct kvm *kvm)
+{
+	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+
+	return (sev->vmsa_features & SVM_SEV_FEAT_PERFCTR_VIRT) &&
+		!WARN_ON_ONCE(!sev_es_guest(kvm));
+}
+
 /* Must be called with the sev_bitmap_lock held */
 static bool __sev_recycle_asids(unsigned int min_asid, unsigned int max_asid)
 {
@@ -534,9 +542,11 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (snp_active)
 		sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
+	if (es_active && !sev_es_is_perfctr_virt_enabled(kvm))
+		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
+
 	if (es_active)
-		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED |
-					       KVM_MEDIATED_PMU_CAP_HW_FILTERED);
+		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_FILTERED);
 
 	ret = sev_asid_new(sev, vm_type);
 	if (ret)
@@ -4744,6 +4754,20 @@ void sev_es_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 				  !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES));
 }
 
+void sev_es_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		return;
+
+	/*
+	 * RDPMC cannot be emulated after the VMSA is encrypted. If a guest has
+	 * fewer counters than the host, the extra counters will continue being
+	 * readable via RDPMC (no #GP) but they will remain in the init state.
+	 * Access to the extra PERF_CTLs and PERF_CTRs remains intercepted.
+	 */
+	svm_clr_intercept(to_svm(vcpu), INTERCEPT_RDPMC);
+}
+
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d48286faeb50..ac8f06e1f5a10 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1148,6 +1148,9 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_RDPMC);
 	else
 		svm_clr_intercept(svm, INTERCEPT_RDPMC);
+
+	if (is_sev_es_guest(vcpu))
+		sev_es_recalc_instruction_intercepts(vcpu);
 }
 
 static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3a5e9e4ecaa90..1f3cd12e44c46 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1001,6 +1001,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
 void sev_es_recalc_msr_intercepts(struct kvm_vcpu *vcpu);
+void sev_es_recalc_instruction_intercepts(struct kvm_vcpu *vcpu);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
-- 
2.43.0

