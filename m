Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76830DD3C
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922847; cv=fail; b=Vh/yExprJA7KR1gziy9bmYgw9/NIR8KnSxA9pm/H9nXOLkQdeh8eIEHP/9r1ZmNTYaZILh5leOx3uCiyaMJAlRyiQlLCcVDVVj4CkmMtvTBB5SK4AfHjeUgWWmKx/YdA10UTyZxaDC1P2oqK79yKXhDQexD6T3Hpq58yB5tfk9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922847; c=relaxed/simple;
	bh=6xjZpccraii1j+XTbVq9pR6QpjU4Nn1W0Lbt8KGWBrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arBISxzU1i0Akp7evy2p6nJ/zcyrfN6jaZNihrIUupsUW+FUD9rxFJExkh8mRlFLAjg0CRJTWYzmB1uVY9YkJpd2ltHPBnQw00i0bs0jShzN/XwEQ6tHUuRdXwacuLvGEJzF4l5J3h9Yr7QsoauqrAnHDmQ9GEXR5IOZI4uXpsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kog6AGD/; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kog6AGD/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9cN6aqxs6ljLqafnuYqw7gGcy0ThVJqeND+2E4ODiHfmGoECTztby2o+I0PsoRLAd5TSUPVCJKCn3DtRF1kU1ghf+iNNvdaMIcXmjx2OHCvAsjqChws+cp3pXf4+cLAiGZnbGXZ1W/UeaxHOqazvrGjJKutGjha2Y7tgj0oD9ELyL9jwFUXabu9zXQFImwnyod9F+Hbr63JJMCBD7wNvTX+mfgKPwTXd0ptiw/TwnAs0hz9K/96WZjwInNQrlUdlvBOFfnnybWV2IgIa1fnIR1ZSO/v7YH+srANOrg7Rm2R0DR3xMWc2pm05y1aaI88ExJQziwipyGtkQd4qHsUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro0oylACv4QpsP6hWPbSuZiDYKe84I2YhM927nWLAjk=;
 b=f0ohXJOpH+/Soyk0scCC/7iX5uDhie8TQGvx6mlACgj0p7f48ewUU7mr5ZLnnKSz54DXGxtwvVvb8fAde958qAfDavn+QFPSOlnZJbjqsQ4M3hbq/oOXYIEznw7LXI4fVfQzL1c1znNEcz6ozEYxvmfz6YipB0UxhWMfpYznlNSikZg3/D/v8d7ttevFdthwpqqodvoOc7uHmQzspIpcarrXdGOWfzecglZLCgoSzh3dfukUPttOavlkgVuTaRXpJ8kWTgkgBi8ORj1OYNdQbUwS1ZNouVLgFo3SKcXCDNlf70DOQpfbZKAoz+S5O3xPf/Wxz+ks+IspzJ9luhlEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro0oylACv4QpsP6hWPbSuZiDYKe84I2YhM927nWLAjk=;
 b=Kog6AGD/DfrBqiqBW0K6hSsF1Rbb9NuBgBEOddEXVqb58v8vWhPQsSNYVMWp1fmp7t52uryawJGYib6YvNtR5JfF7i/IoryZxUJP6cThb6OBGCh6dF1Kmx7+jFjwdQN7CeOsJsKFadXiBq9ngXiV/yKkb1I2NrwSvHdC8PiCCFA=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:54:00 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::4f) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Fri, 24
 Jul 2026 19:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:54:00 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:53:55 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 6/7] KVM: SVM: Add LBR/PMC freeze support
Date: Fri, 24 Jul 2026 19:50:39 +0000
Message-ID: <20260724195040.630468-7-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: fd405a5e-b40a-4a9d-ea8b-08dee9bd4e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hPKlOeR9cSKNB2H2J6/RsKV8g+hncYkPVkLutaIAHfV+KWqxQPiIpSavuor00/LrBzIvHrhjD62/HtsUdBsppXIbmEKde61ZATRti4liTLKBQuwvDsNiLn3FUAFCQ/G/bwfhayb55/RmY7IPQWJLZJUZcLhWqxt2NuSOJUg0Un3DkQh3kCK8SCfVNqfImJ0LczEHeA+vrjExDUE4dXx8hBRRlBJ+DzsIIbOorXkNCgm1fD0kjb89tFN18buf3WA2S5VzqeqHtymAHDEvwALPMPx/r0fz0bZWViFJNxlJ1qmLyOLVowHOfgvlUYkwODvOPF04jdn99V5XPLETumpokS/Tzo12re4kln4hF4pBnczRBll+e1irDWPhYNRpVLSMwwwgLiMn9HMwmCdYqsKMYpVdxVks5CtiV1hBViElu5fc2okP01WtSyYRkUlW0grl4P76RCgYSHGcs2s9YUlp5d4FyZjJjm9JwATThNTGSiM32i96sBSsho8x+miQ+EqcrrmTBGmT5DxcfoZUNk9o9cGRhlXPqYLGAkQphIzMLdunjwkFpRAxmrazWM3aQxvvi22G1xytVQdQQlbgNKmX5XlVrBF3ihw1w9KZPiU7W/501GhwE5EZXlOpL+D6RKmDM0Rrrg2S8OF3sur+hkku1tQM2PP4NXwHmsn+Vd83t1TZcbJ/6FMrleNxb+x1j+HkaJPA6TsdO/UOYqM9DfkBow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TpZikwC5fIho0I2Xr3qp99HDA5tBKAZyN94D6HDOR1h73MzLXOqb/D0V7bKhw5RLUMkYwh1HOxJT/TtUI5e1dN/zTm8eQ6PBb+FTqN4q7ZmAvJMmtqUwfkCzkuh9ODWlFxJyZ9m3Bs8WTz9ZA0fppmrS13GCeltnpEULpF1NepUIU0IDuq10q7VuBRNMkFWSmkuo05bzHleAWuE/J0yTh/If2erd2uMAlHtGjRf3dInN8BUvn+9TBusoP+o3dehvJik3rp2neq7JVs791bTCfeFUhGq7hxPswMjP2MxYeWxuhvuiyP/zxF3qavn0hvf0DXagVKrCsniImwKj/iO3YsBix22lWFB0KBoKqs81iJkxXUQmp9OiaTu+swG9TFR/5gT9SYlo17FS/POhWPqqnJuZnWZNyXSdOA1OX/X+BvJ5zL62WLRgJVGlGELdelL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:54:00.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd405a5e-b40a-4a9d-ea8b-08dee9bd4e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153

Add support for the LBR and PMC freeze-on-PMI feature (CPUID
0x80000022.EAX[2]). This feature is very often used with LBRv2. Permit
the guest to enable freezing via DEBUGCTL only when the feature is
advertised to it, and advertise it accordingly.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/kvm/cpuid.c         | 1 +
 arch/x86/kvm/reverse_cpuid.h | 6 ++++--
 arch/x86/kvm/svm/svm.c       | 4 ++++
 arch/x86/kvm/svm/svm.h       | 4 +++-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d450a5b2499d..03501b3145eb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1268,6 +1268,7 @@ void kvm_initialize_cpu_caps(void)
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
 		F(PERFMON_V2),
 		SCATTERED_F(AMD_LBR_V2),
+		SCATTERED_F(AMD_LBR_PMC_FREEZE),
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index b4abd839af1d..9a58f91eb173 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -70,8 +70,9 @@
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
 /* CPUID level 0x80000022 (EAX) */
-#define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
-#define KVM_X86_FEATURE_AMD_LBR_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
+#define KVM_X86_FEATURE_PERFMON_V2		KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
+#define KVM_X86_FEATURE_AMD_LBR_V2		KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
+#define KVM_X86_FEATURE_AMD_LBR_PMC_FREEZE	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 2)
 
 /* CPUID level 0x80000021 (ECX) */
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
@@ -148,6 +149,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
 	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_V2);
+	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_PMC_FREEZE);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4b84498e93be..3ec91c1c58dc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3236,6 +3236,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
+		if ((data & DEBUGCTL_LBR_PMC_FREEZE_BITS) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_PMC_FREEZE))
+			return 1;
+
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 01dae3828a7a..105a71d69d68 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -784,7 +784,9 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+#define DEBUGCTL_LBR_PMC_FREEZE_BITS	(DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |	\
+					 DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI)
+#define DEBUGCTL_RESERVED_BITS	(~(DEBUGCTLMSR_LBR | DEBUGCTL_LBR_PMC_FREEZE_BITS))
 #define DBG_EXTN_CFG_RESERVED_BITS (~DBG_EXTN_CFG_LBRV2EN)
 #define LBR_SELECT_RESERVED_BITS (~GENMASK_ULL(8, 0))
 
-- 
2.43.0

