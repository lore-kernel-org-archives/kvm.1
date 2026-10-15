Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7904FECD8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060814; cv=fail; b=JuFxovV33v1+0P0lmsAZIh+pC25IJcBYh3lWFbGGV6LeGS5yEIpb+wM/6ABSLefx7C9GL03wAPydByUr3KBdd9wFKfS3UY2zwy/+M7Avoy4a87T1zSCgZszCTmPpPlPlpGuXSb7S4wzOLmIe5qAOBzCDjZe31VYEpfsANBRAgOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060814; c=relaxed/simple;
	bh=HN5wuPPtc8W7cBzVuG9ivpm20m8oEJwrzD3BtVENYS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeYh5DYGlp8IQgCIMrAdppSnirREn9+3D1XygEs3vTIJTHl/WbXnGGGBEbCPbD3flGDt/Yg2sW1xJaYhz7mc4FUnqOOuAmV9VGeW8Q/R9tsQdwxTpXpfvoRiKr/88wOkEXR2RuJubNcAuqEohfmjn97+KdnSqERqpTay7VezqWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUutgS0w; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUutgS0w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plm73N1QxtavAtNFBaVjsccIdG7qmYeIY31Op25SP33TswfRpsar4/W5UdSoekbKsNiN6PCMYncSP9jnEl7A+q02qoAeWsLxN4IAnuqzN1xLxMufxZ2IbVI5faky/5jcss98rs6uqkoORXGoIfeB6F6LKPFiRzYsQfjkpTPcg5ZWpCr3TDjL3lHfWcnc/6UMcypeB+EoiNWluK20XBCR+jMDniH3h4ozusamq1WEYITqVyaCjR6USyxuWLiHORagDEUyjW90LBhCSb/fC1d/gHbMPTjqOMzfvZJz3Hur3iouudDV+Xkt0AXmOsSk7G3cxTDeGOWkC7Du17EG5ySJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu53eZqmm+JO5KE0biatrP8NQcGu26uUJxg478BGC3o=;
 b=lXEaUdaili2bIUiVIk20AyY33hZVOnMHoFy1Ey8MbEpKNLsqu1tNXCfbwB1CXnSLk1YKVb5IxtdtRdapt45atBvPNdIVQsQBFVY7YG4WOo6okvJIIqT+/oz+Wv0pSrBkWE2JI/ZSa0qsvNorIzQB8LZTIHQgIruZzo/8Bau9euOIsQyKjVk7zg1Ifz3oPG28QHXRzNkqfG5AsgqgtgxPj+yAEOd5ODFoKMFbqBpkYF2y8PbAp828SAvnMJIShqm2pw29MFzcwGVd4iudzrd4BxiJ5Iba+eFcAM7magJUfJOP31T6r03ToI53p+XG6AxCi/fyfC7d6K1lYnyihByQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu53eZqmm+JO5KE0biatrP8NQcGu26uUJxg478BGC3o=;
 b=oUutgS0w/wCBhR+fC6sDy+Mrs06Y4JZGuoHG7k0wfpGqNeAmcL9xxeMMfST3p/8IeEDM68e8PR64xFnDZO+sal7vg6y0BSISbzA41LcOtdw3w38rfhx19sjJ3qRBvN1APIhA7v4ElgTI4Jk2E2d1uEVc2KD84j/CKzeh8vdWKok=
Received: from BN9PR03CA0502.namprd03.prod.outlook.com (2603:10b6:408:130::27)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 10:40:07 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::47) by BN9PR03CA0502.outlook.office365.com
 (2603:10b6:408:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 10:40:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:40:07 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:39:57 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 3/5] KVM: nSVM: Advertise PML to L1
Date: Thu, 15 Oct 2026 10:39:31 +0000
Message-ID: <20261015103933.2088307-4-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015103933.2088307-1-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0bb68c-9e50-4599-4876-08df2aa8ae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|10067099003|6133799003|3023799007|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5SBQQqHOePJFsO8SWE9fLQ6zA75dP95qOQ2OTAw48JkJapxMSLK2MvvIiIEB6VdqLSRas9acI+C4gRoGq5qZ5H4fUeZFn13/pyDSA68kPPoO5FlQJ13JW9i8rqBVNgg831ssCjv5iV9tU5YACDu2hfjNY0DNDe6FFBUSg025sKy6sYPdi3Q6uOl65hbgz53nlMPFNF6UGPUwP7XR4aZ5JUaHBXLWFMqUEbr0YhnHHkqdUanGkYsBLQdJCXbubEOW10zKLj3b0m1Xl3E+Hf2F+W1Nrh/EczGYOheMue0dHOHizQsM6P02B/2IhisLaeDoiEygQKpj7XUepfBG4YbuI/7y4f6Vg3FSaqLtCSMJ8g4EAlHOd070/+NPhVonPAnZH550551hyOhVrtUPlhbuk0tcMZVPIElaArJA/sPt0OalJx3qzp6HdFKW7qOQSgaccbbIsjISvvOnZsS7rJJrHWRZ3Dp1AykuYof1NAVKFTtF5bA01DYZQRMqS/H7Aiw6bYThLqM93bOO4lwYRO+KbYA4xlDWGmtUeOkYk1M7PV/I/DmVRmboOGP4SoQFgviQom84BYLGZWTNki1DP8+D4JmqGqH3WfeqoNJ9k8gujuxSeyFJQ6AQXygS5jxZ0pttWSG/RZJqzKBYIILvktVqer3hNic3/5yvQt3bYwRdBcVS2tPzt1QrLejrs+3W+gk5WVTOHSl7G2hFGv3FZRaqbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(10067099003)(6133799003)(3023799007)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vO2Hp8MWuxXxXTsN80V+7au8zMh2B6OD+yIXrygvqMWCYhlRmpz4LZ82gWpZ+Bahm0I0o8gb64ppGOOetJl/4AQ0mEekZsVEIa3D1R3TIQOGXLoNVHrBBaS2uHosPJtHxQy0lRUu6CXQo6pO/tJ8jRdks/Idx+tVrBlLT5VdUBlqCXg5LHsrI2ZhiEvN4QFLMBsz9jLfdIxFoSwrdBViFKpcpPpbzsYrgH49kzcR5MGnHwEdo/NhPNSXEnAdnDlFAcWc8IraCgNTqITX6Eq62MuDyvtC3hprMqAeMcvZba71NbIWBRSffD59mueF0bbaGlNRtveQH2LAQDHGgKtuAxOZJdhVo8iXfJQMJY7AOvxTpXhyjrY4v7NXhc+ZHQ+p7LFsV4WzlgKkH55G6ahTLRqyQi9rIfkXThsk76I/AJutHfbCBNhCsAULjOtbh1Lm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:07.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0bb68c-9e50-4599-4876-08df2aa8ae01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

Enumerate PML to L1 via CPUID 0x8000000A ECX[4] so that an L1 hypervisor
can use PML to track dirty pages in its L2 guests, and clear the capability
when the host lacks PML in hardware.

Honor the capability on VMRUN by stripping PML from L1's VMCB when the
feature is not exposed to the guest.

Assisted-by: LLM
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 6 +++++-
 arch/x86/kvm/reverse_cpuid.h    | 5 +++++
 arch/x86/kvm/svm/nested.c       | 3 +++
 arch/x86/kvm/svm/svm.c          | 3 +++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..aaddac3c20e3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -711,6 +711,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_8000_000A_ECX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..bc81e906082f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1195,6 +1195,10 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
 
 	/* All SVM features required additional vendor module enabling. */
+	kvm_cpu_cap_init(CPUID_8000_000A_ECX,
+		SCATTERED_F(PML),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_000A_EDX,
 		VENDOR_F(NPT),
 		VENDOR_F(VMCBCLEAN),
@@ -1848,7 +1852,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = 1; /* SVM revision 1 */
 		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
 				   ASID emulation to nested SVM */
-		entry->ecx = 0; /* Reserved */
+		cpuid_entry_override(entry, CPUID_8000_000A_ECX);
 		cpuid_entry_override(entry, CPUID_8000_000A_EDX);
 		break;
 	case 0x80000019:
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 89345af0f7ad..2ec5aa715777 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -71,6 +71,9 @@
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
+/* CPUID level 0x8000000A (ECX) */
+#define KVM_X86_FEATURE_PML		KVM_X86_FEATURE(CPUID_8000_000A_ECX, 4)
+
 /* CPUID level 0x80000022 (EAX) */
 #define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
 
@@ -111,6 +114,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
 	[CPUID_24_1_ECX]      = {      0x24, 1, CPUID_ECX},
+	[CPUID_8000_000A_ECX] = {0x8000000a, 0, CPUID_ECX},
 };
 
 /*
@@ -153,6 +157,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
 	KVM_X86_TRANSLATE_FEATURE(TSA_L1_NO);
 	KVM_X86_TRANSLATE_FEATURE(MSR_IMM);
+	KVM_X86_TRANSLATE_FEATURE(PML);
 	default:
 		return x86_feature;
 	}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8251b38d1479..dd3226e83b70 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -552,6 +552,9 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
 
+	if (!pml || !guest_cpu_cap_has(vcpu, X86_FEATURE_PML))
+		to->misc_ctl &= ~SVM_MISC_ENABLE_PML;
+
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
 		to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..a8609f860415 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5751,6 +5751,9 @@ static __init void svm_set_cpu_caps(void)
 	if (!lbrv)
 		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 
+	if (!pml)
+		kvm_cpu_cap_clear(X86_FEATURE_PML);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
-- 
2.48.1

