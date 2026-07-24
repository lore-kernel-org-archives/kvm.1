Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80A30DD3C
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922831; cv=fail; b=QhqThBOLt1p/U8KTp0cf1VXIOFwOhOud8EGjtjuBKXX0FIoeA6zmhvSXZiSrWX50JoFoXuwjTlfDmhVNkW74HyfpMkwDKHVzHWV/DBb7wBftPC7flBzqfr3pdVmmwm1/7j3r7aOCMTPMuAvBKgV/L8iuiPYG+qu9EZQP7FoUi/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922831; c=relaxed/simple;
	bh=Qh2sl07PG7tIE21zJt9Eaa171KReZ/KXYWgkQxMCN8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bH8H2/HZZMghgevjx1Bz0AndklZ3vOBPIJFJGnwgshebhxKZAxRQRP1WQOr/Es4UFxOIzP2Uzm1sZ0N8P9+kzriTr72b6WVeQvoHluKb9TMoWY+DjEhwt29KV6VBWaU+PiOGugtFG8KnJp5j94piPKpmyWXrceNYFg82BZh8FZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JUd1NREm; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JUd1NREm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAhK/IZREIRj5apzA7iFx4MGol1KE7lMD5PqEoBaKQap5On7PKbGmiSrurw/Pxb3c+Pkv9GKlw0ctCh4ZfqS7rqFM/SWbiyze3zcLR6YCHNpd0dDczTZFfaNHSrwH8u34Cmn17Germ87+4nRxphQ/Yh9ni0FKcznnfZH2TTRnXNCUr33J2I1OmBgxI75U8EtvAaTdZu8cXtVee02PQrn1I+/A7fXGhg2SHN59apUCtItxT8OLYbKrAbEVJlcpqt80ZTblefCW0KtnRTOmm+YVBxU4rW51mlGX3TZ+nsFYFOPTsen/1P/mw8i5lJr8jv3+tZfHg1K3hr5Dq0uYR347A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCc6BuskxDyuGfddAjJIyNsf8H9gAwjwwVdVOLecZ+0=;
 b=HPfhtdxvIpu7ilubLIajGrG4ZFCpszfF3jZqY+2AC5WvedDUlLahwXx4wd50aGu+RGyBnlve0Oh1NOWZ4m2ItrmkIbNb6oymS0MJ9K9ampMmqGa95lJpauIQ1HZ1EiLKTeJltcLSqE6/Sv/jg9sfkfoI+dXQzwCvai7/H59BoBViRBTSAX04raWR4S4b5TCezWK1rg0IE6+7EnQuyKHD3vjRe7aFuVTXEHLjdMpx0RTSkBWkKUCIcc3Xg5GAxrKcHxa5r6nLVm1M+iA9KgEfFNgzyJr4rJMCpHEZS8wDhlkF19cYNNUEUYT81nf1wPcagUbrFAMpVkI5/lW/xSqYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCc6BuskxDyuGfddAjJIyNsf8H9gAwjwwVdVOLecZ+0=;
 b=JUd1NREmN4OQwHEIseZ7i7HPESwAlqmZDUDXnl7r7VIZnALOotmPna7QOZUjPWxSxJxiJpYGDZY26K2TyJjjFxoK6J+xDOGVMsB5JGR2PmqRVG1CfJ6p6LrBjYlwG/BuqpmiZOpkQxcKcJS8z+XH2Zfo7+wOQep9uUczWMew22Y=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:53:43 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::23) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Fri, 24
 Jul 2026 19:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:53:43 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:53:39 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 5/7] KVM: SVM: Advertise LbrExtV2 to userspace
Date: Fri, 24 Jul 2026 19:50:38 +0000
Message-ID: <20260724195040.630468-6-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 841806c1-99a5-4659-427a-08dee9bd444c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	D6Jsyy5ucpxwCssZqRiMQRgq2GLkTPSSlRqJpk6iGcCITrWZ8urbwfUF1TwhSPNMSgw1s3yZA8kSyvO8D10BIKTxMuQXNOQENKZf7qfySY6ytguguoBtKspOJ7x2xZPBHPcG8V/1SqtmiUFCzapxPN8FvbVYLtd2wcciQowZfYpDoflJvJxTW8YbnSmFefdpwcUn50OusFnkR/WNJVyhaQwn1DJJrDmiHL+r+lzEA5DH5a9YKuXRTWjrvFmX0OLxwxWZ0UKAeKHlRu6cAJ9csOgI4ZnhcNlIKGYWimpi2vc1tNOP9rr+QTSAWSaRO/rgE6242XDrMYIJk2rbsX2ZVWYihml2y6vDbVriwZBEuBkGVOXpFFq/kggI9UIBg5VQdgJuSEsO6Pyh0mwX+NvQ06h5mUy5V9PiSeVLJWv7bdt+kgvoo1D8Wge0gdQZek5kn04/vFBvNhox9bzfq93rsT9/BUjx5Xe+Dlwk+xADRbijlR/oJcVgT1pbGPUjl+yek1cHWetb7QD4sFMM02+0CGLJ7DcAl3F3mtox3EJr/PB87JtLHsKNgbHMBLeA4Y8JlgeataXk5q1tuZW2uTaFA1nHRjfS5mYLYkDrOzw3N6bjsBZ+rk4c92hliOyeFv3OQx1gpkPHFcG2ecFYvIS2udg0nHjsXbQoMyqM7zFirynTphi1osGD33uWvCdZJvvnTuAX80/5hq0TsqMZJUwQgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3wsA/WfeJcb099/1+aGUThCE3zKcxuR1pCwMUUG7EaZ2MGCr9GMHsjW/XGMJxNiZ5ePihpD1q1vmAx/CEtNXdkucJdpIdWGghDOTuOzwCVRGArgT/ADaCgMCtWZx7WjEQCnazOP6tyNJP2YNadl94KZNXgRwPeeGkfn1IM7XckF6BDPdLoft7xgUj9uXt6CaotrcIaRM6k3B8+UIdnkUkHOfCOOZp6fHbvi72926PZSBzPMoIkltsuaqg6H4whShTdLHhY9cNBj8/3w2FzuJgdGWlACCWbNZFWM+en+lQMSFPsyTVutg26YhpoIUJyto6GrFzpzukhevtZuQjYNif8htfw2NGCyoi+dwKsYSL6oejAH4YpEYF1KIe/O5s69dq25rms6DEAhQoVNuBU/cuY+wNQN9PZ/z8yXar+8Xl1outMmsf8YGp41E1fipil0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:53:43.5785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841806c1-99a5-4659-427a-08dee9bd444c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134

Now that LBR v2 is fully virtualized, advertise it and report the LBR
stack depth in CPUID. Gate the advertisement on LBR virtualization, the
mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never exposes a
configuration it cannot faithfully virtualize, and drop the feature for a
vCPU whose CPUID is set with an unsupported stack size.

Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/kvm/cpuid.c   |  6 ++++++
 arch/x86/kvm/svm/svm.c | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2698fa42cd97..d450a5b2499d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1267,6 +1267,7 @@ void kvm_initialize_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
 		F(PERFMON_V2),
+		SCATTERED_F(AMD_LBR_V2),
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
@@ -1883,6 +1884,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
 
 		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
+
+		if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
+			ebx.split.lbr_v2_stack_sz =
+				min(kvm_pmu_cap.num_branches_lbr, SVM_LBR_V2_STACK_SIZE);
+
 		entry->ebx = ebx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 04e386b838d3..4b84498e93be 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4820,6 +4820,20 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 	return true;
 }
 
+static int cpuid_query_lbrv2_stack_size(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = kvm_find_cpuid_entry(vcpu, 0x80000000);
+	if (!entry || entry->eax < 0x80000022)
+		goto not_found;
+	entry = kvm_find_cpuid_entry(vcpu, 0x80000022);
+	if (entry)
+		return (entry->ebx >> 4) & 0x3f;
+not_found:
+	return 0;
+}
+
 static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4846,6 +4860,10 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
+	    cpuid_query_lbrv2_stack_size(vcpu) != SVM_LBR_V2_STACK_SIZE)
+		guest_cpu_cap_clear(vcpu, X86_FEATURE_AMD_LBR_V2);
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
@@ -5692,6 +5710,10 @@ static __init void svm_set_cpu_caps(void)
 		if (kvm_pmu_cap.version != 2 ||
 		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
 			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
+
+		if (!lbrv || !enable_mediated_pmu ||
+		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
+			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
 	}
 
 	/* CPUID 0x8000001F (SME/SEV features) */
-- 
2.43.0

