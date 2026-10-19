Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444154;
	b=v/Rdien4++cxdTLZOAmJ7QpFULGvZNEJgfmmX1mI/2CGEtOdhr4TRHSA+scx7PrCTcEO
	 b6PMcuHlRPOpsaFubIX5Nlk0Pz1GEbdOoJnycTRl7EHWgW09nuK+CpHypm0xlDgT7cymE
	 loMmb8Jbq0hKpDMQ4+78o4c1Wx+4jyUJEt9AyGR/oziUcISreqmXJLjkfK2B3j1XM0m7v
	 ZfnFF7X3HnCkNOfTskRgisxIhVsyVzkhhHofQq29QNMWGgO5zLB3vOF5tFe3DVGvmT2tU
	 R4T356u2rGGozTpnrkmhbxTBv2BdkMa0msNOMrYXdzDEvFwJLVjWNngrqaeF9QKubXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444154;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EcsZI8QB+h9ZxtUu5lgds/5Lt//AHWQvdb7iTLaIRo0=;
	b=s1XnRNu7wIH8Kk6PUSTbhp9Wk7gi7ReTy8vieT7CKuuXG1jD1qvBISt3mm8Y06YYhHi9
	 CWn9YrPpUszC7UwSk9Isdv3GCuzEwhHkJW/PmhswbzbqbhMf84zQcPvo82tpqcZPSjYaq
	 5u6/WoWN5WEsuPy2SCkMS64RiTBUqVlcuJZMk7vFEscZGGsqzv19F8LryQpTGSZGEcSSP
	 ilKbdSGhcAEddPaM+tQsECmVGS7+jUdK3ISRuoJqlvrCcc6AD5MXvgv3CgCMPQkcc12bC
	 pPXATuDPgDv3KlDWp5aszzoycsaHb9VUy0d+IRBFnTHUCJCPVI5OOwxulJPUHQpjYbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uMQnw8AG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.36
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF13606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF13606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uMQnw8AG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL86kjnlLyQP//eR4w5v7YFWvUBXn+5Jw5nj0yD3t3XzJ6Cta04FAtNsoGXCm8uwTwt6hJ5TEQwED+DHZGvttkT4BhZpSJthEpIiJTIB8Ak4/mXHIiUeUQMrt3rTHHgtV2CXTnWyDF9Fu9q0+s2W0/PmpgdZs7jvwlchPlDolK2i5VftBuuwo6vMp4cJOeo1WdUodb7WStEuG0ry0xlE1lCaoBqiV2buo++G5dkm6SbfjMhmKUmbiJ4MxSenAWSd/YEhne6vz+pKE03dAEg6iGNZilWuDG4B5q7Stmeh7dREBU62gbBKT3f0FgLnAfE+wQuW0bDrVE9zkPKezHEy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcsZI8QB+h9ZxtUu5lgds/5Lt//AHWQvdb7iTLaIRo0=;
 b=FL2YU/7ltAIHbUjwKyh7nUj3bFJLTJB0q6TnaqAt9xE/DsPPpeFuPH8Xx8QIfRF3jDBwTaI42jbwvi/g5eya5+OVr/S3JaEAeOKhLKGDeHjvn8om/GFeFSjXrkkfHAgpWOJxk5Nzc7lvMD6TPWixpNxoOTnQjji3uuDr8+TiG0Kbx8gtFy5Wea54bMh4GCD0sOT2ToeFSyI7NkDCm+7L39j6zkRD19Q9iMAbsm5AgAEBzYxfEUOmGGAhGiJQqMuS0BCqwLN0RqvadqbX9Unxw37u+8zNuiUhzxhQo171pybMBzhJVM/VRDJp3zRIdWLGCn0bDPmihKHAevAjlwEKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcsZI8QB+h9ZxtUu5lgds/5Lt//AHWQvdb7iTLaIRo0=;
 b=uMQnw8AGxKuLEzT0dyI6oFReubKifapVLQQCLt5ffb3xAssVysuNuOQmA/DMz4x/2VKvoHCtjGmje09JlnSLivB9Tx7w7k60Zv5VpnxmuTTEX2XAQJLpm3NvE2APNsx93lAtkdtknqHk63JCakTiRLAI6cZ7IFflSqwBe1kBWsk=
Received: from CYZPR02CA0005.namprd02.prod.outlook.com (2603:10b6:930:a1::19)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:09:08 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::89) by CYZPR02CA0005.outlook.office365.com
 (2603:10b6:930:a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:09:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:09:08 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:09:06 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 11/12] KVM: SVM: Add LBR/PMC freeze support
Date: Mon, 19 Oct 2026 21:05:31 +0000
Message-ID: <20261019210532.378628-12-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a4e52f-1be6-4f9d-42a3-08df2e253726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|7416014|18002099003|22082099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B/hYCrAy1aSkfaZ8ZstdetgY4vkiWrCWkdcODxReJuSiYNBXOIALzBuoshJ0eRa3+/dECbkqcyh3jlP7MbeP+hiaS+ga2Qno8zNPeN4J1t0bzBykHqer8qZpPnEpGCTF58m2QxkdqjhjmcSODpElI5n8WEBp3QVEJIgALSc4x4hxcX+rvaqw9/LVGerDQtH5YFy4eBZhE1ErHVAYoimLLp7Z5KufJy+lbnU6Q+6bS92V0s4JAmYL/9ohLOsljS3NfSKjHIt8Qo+y7yJKsIgGfxtgyJjwtfB80nB+itfJ2vb57v0W2z5F+/owpJ+rf+tN4jy6IPAp9JJSb3pOVxXM0npnJJaMFEmGHa1kaYwyrjTfTs916ooYQspt7beJ4wxlwxFgVOPB6U6eSeTk2eWjLHgS6Ag0uoTS7MyDQi+N+NZld9zHxVU8yC3gka9fv1Upd8exYfh2bvWPhD6/2HwoMdxlRNRVryJ5NKhQn5Sfo30Z3xqr/mKCLjWEjKH+RGXrkY/vL3rG44zJDI6DyIcLQYqYBnelTTblPbUw+bGS2c4MECEGn2JG8bq0VG1j4DwuIA7gqhPl1OI+YbHCg1QQUIOW4UKdhq78uCLyeqtVf75S6KyJBaXfmX1Moc6ZGG/rTSYyjo2fHdZbdgm1Bj80+UD90wiFf/HeSoW7Q//DjliUzWkA4gK0kVmHanK7xpozPifF52w6d7/buX4B3aQQVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(18002099003)(22082099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1TtgXo+qYmy2dq0N31wbFYjNh9DrcyJ2B41EdFjqMzOX5706w4rqw4aNEc3KGxZ6l6LOAeVUliPTaAXxJE3jjjiqsG1QzB3GSX/j5RR/VRgMAkTOvvv4SLYDXI124N/yExr33ZhojDqLKdKN1jQMBG0NNzsXY4xwvOU+yz3AKDFqcLnUheBELgKCsPiVEZm4Fb2SorohWKPHFDhGKKdjfEXzX89vRYlO8UksqYwO2Db1T5704qYRvYcY7eqWgZT4EWK5qpPInwdedxkGZLe52HQNPeMX4TCI/15vsYz4G3wvhLCEekccokMiupOhJHTKNONr13EJhnhUdRT4p76xrNJF23DxdiRjEo9G+tgQCHm2b5gdb3/s82yujclMvt6vObEcAY0nzbSOQ+hG1Qs4ZUI6anpYcSbI1LZOIev/BuYxAlNt5SSEZwfXJbXyBVjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:09:08.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a4e52f-1be6-4f9d-42a3-08df2e253726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

Add support for the LBR and PMC freeze-on-PMI feature (CPUID
0x80000022.EAX[2]). This feature is very often used with LBRv2. Permit
the guest to enable freezing via DEBUGCTL only when the feature is
advertised to it, and advertise it accordingly.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Add the freeze bits to svm_get_supported_debugctl() when the guest has
  AMD_LBR_PMC_FREEZE, in place of a separate check in svm_set_msr().
* Removed DEBUGCTL_LBR_PMC_FREEZE_BITS.

---
 arch/x86/kvm/cpuid.c         | 1 +
 arch/x86/kvm/reverse_cpuid.h | 6 ++++--
 arch/x86/kvm/svm/svm.h       | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index bb24d8362132..37da587ede71 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1259,6 +1259,7 @@ void kvm_initialize_cpu_caps(void)
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
 		F(PERFMON_V2),
 		SCATTERED_F(AMD_LBR_V2),
+		SCATTERED_F(AMD_LBR_PMC_FREEZE),
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 8cb8af2d8c70..418d6f59d7d7 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -72,8 +72,9 @@
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
 /* CPUID level 0x80000022 (EAX) */
-#define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
-#define KVM_X86_FEATURE_AMD_LBR_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
+#define KVM_X86_FEATURE_PERFMON_V2		KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
+#define KVM_X86_FEATURE_AMD_LBR_V2		KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
+#define KVM_X86_FEATURE_AMD_LBR_PMC_FREEZE	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 2)
 
 /* CPUID level 0x80000021 (ECX) */
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
@@ -150,6 +151,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
 	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_V2);
+	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_PMC_FREEZE);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 01be2fc05d70..9b65728ee0d2 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -801,6 +801,10 @@ static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
 		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_PMC_FREEZE))
+		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
+			    DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI;
+
 	return debugctl;
 }
 
-- 
2.43.0

