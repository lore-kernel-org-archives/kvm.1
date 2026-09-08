Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1239FCCD;
	Tue,  8 Sep 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853708; cv=fail; b=UJ/EzEzlPY8hGDTPUt1rQEZbopwYG47JImCxFc+ThlEftKalOH0LN8e7MKaKALtfy9m9L9XYrh7JJSAqJJcykVCV0jKa2E1xRedU5QcVOmn5DE+ck39CNiZPRMeUfBCmN4mp9hXJDt4dBQ1vQ/tZfJKzoId0MhaKfCV7wT14ZBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853708; c=relaxed/simple;
	bh=pQwCmIzCVgaXoEaFIz+Ol66f8UjODTgXkjr5JL27TRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6tJQOC1NQkYry8/w9pnIUm1B5VVMZkvKJ/wpWUfzcwd/OPcZ/V/L4Cv5Z/eaLePbbwbeD+iEHdVrgEjb0zBGxU8KaXM3FknsU2s38tVM4QNkHKxQdLHaPlNhYX0+7jvzfcQPwa6lZtFGrr/PToHOw1KyZxZhz4+aBGZoHul50A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AbBo9reX; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AbBo9reX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqR0NnGFj73wjzuk0h/bILjER/u6C422J/z934uvpGW3zZ1D0HMM/Y3NSLiRsUE/jPa6/LqZvqkGsxkqS6be7hr/KopOHpSgA1X84owz1xuF9/w5CoTYoAAstl/RvbHvTQxhCJAzGnvODIl9T2N/1UbfgLG8xPwSY12bKUDnOrSp1MgkuQRPsiC5a6y5IGqTkZ8bsOSLtkyquPeWPv5jr0u8afcbLbU8B46gLKKmik4qe+ARy1aRUE1P3+5SndrQn70hNLJubbMEJ4n4Av6u+dPl11dhsomyha/J0iydHsz+m5Vjlw4a7IZ3FS5TgkS0agPzInSRdofKYfMcCsLQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FohchD1g/5xVdBrUXpDGCAzle6Fmxr5lQdON8S7B+qQ=;
 b=PpA1FbtDddm4SKAXzee/U9KdV8DW2VVKrrevmKeKqJNtxDiYAd/kpnzAW0R4zQAzCZQ10BZtCdlv9hzZUW0OE62NNu4EGDPqVr1ypQgNefMppSyTvUIWVaHJ3hjtivHwFRaMArqeCcHLR9ohOlPoXrvNLEIv0/zevFipSvdDXY7JHPiXMGIvbBtyp/SVZmGlkgRJB2VPlBuihNSTDSYPJPB9mga0DRqbXsTk88tL2KLWfJpW4SwjswhzzHk7/tM1TnqIMtdXfbeQcDmI6BBNFsXq1/VSQkdWrwQoKLwoueCuabiAtu9aycBvzMH+baO3p6nOuQQWBymDGqLmI1cGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FohchD1g/5xVdBrUXpDGCAzle6Fmxr5lQdON8S7B+qQ=;
 b=AbBo9reXYtwheLLQIejCivy6gMOogkR6cqRicj+cnqWc8KWKFYhfSWvLg+v3PTI61zXVKniNh7IkdhMagyOH8yRGSs0e/z154aNCKqwVCgZptOldfGrANPx9bVZME0loag7oS3EDjeu88I4tdm9PbPpFP2ttRr5RKMuUyxoF/to=
Received: from CY5PR15CA0205.namprd15.prod.outlook.com (2603:10b6:930:82::23)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:48:21 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::28) by CY5PR15CA0205.outlook.office365.com
 (2603:10b6:930:82::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 07:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 07:48:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 02:48:15 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, "Uros
 Bizjak" <ubizjak@gmail.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 1/2] x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
Date: Tue, 8 Sep 2026 13:17:38 +0530
Message-ID: <20260908074739.10748-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908074739.10748-1-sarunkod@amd.com>
References: <20260908074739.10748-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f44e31a-48ed-4d35-f204-08df0d7d8da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|921020|3023799007|10067099003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	CQwgG9Z5VCovOTLrLOcUdJaT9A0BAuClSZM/F0vvRYNU/peSODXhB5yIKm2wnZS/tR4/7RTUPW0V4WNdutSGvgxPlZLYWGCSTZgZ8iPFBOtHBqrj8Au+tc+Z8zMMyb0/BjVYbfz7Sx/H08EUgUWGceUDYquxbF2t+NYkZnXYYNuIa3Td47D15RQDDCAqg2mGwm3YrrzFBmde5s836PbpyYCH34/CJiKBZlJGfEpS+UqE1GVPCbcrehPwyPqzVhap794oAYYuVaDuLBt1UWES4MSXL4mWIX45hnUbZaSFH+j2KXhrTYZFmavw42NHhiUoViIlGHLMrgilpy2P0CQQa55wSQAHNj5JBRjcjv1HPpOpOx7QsW+vA+haufe8+j0+raCiE0yswXgXle5rtNWS7raJgb+roDe9vQyxSgOIsUPING3w/3wiUMWpde2Ju0FbCYEMhCuUlAZc5i72FDZkiIiQvD4JnMpMPJGwjCbojAxM0aOWCvtb7+I5Szqq+FOAkRQ9u5aUspGRUu77gwI4YnSXi5VA7uHD00AwhPqDf3Pq+KZighV38/09kl2c9pxACtRYgW07eAWNIwOVe41CofhkhTZN/A16rQmDxN4Uxp2IzMt9cqlalyGGJU/aA4AGGc0r6XoTnkR4Qv2Efxdat02XbV16fXPVHR1Xx8ZZ4RFHEPlCQLTOuJee4F4FL60iih+FaCFdSVAN8XqB7XNbqXwDQDvxc3N3iZLSYPo509dP0hkF+65ouFMC3tLIM3A+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(921020)(3023799007)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x/jxf11XZ3ieiIDasTe0dleONMePJb/TkwUi7aEhMs0nC33uaWe9T6H4EhCO/An+ayW0VTQ64Jvmsu9uS5RYSc2zw2ylgaKE3MUm1XBXzd/GJaQbzikPkXKa6kuHORy8drH5Jl/U/xJBrsGlZTLrUWeEZ+DiQk+i3adJ5BxZ7RBSOWhRLHqfqIIrqKl4JErF9APvXGseXxdQg+jq8ufgI+H24W++f+zUodp+AQZRIYHK5jvj4jehCQzkmee8Xq0vtWm32ZQoPdPkwBX36flpV2UppCElHp3lkXGayQXo4+gRD+R2onpkVfOkDKaWYaxFnJk6e8VwGGebwy0G3qECKSJGtcA9EaTv1RjTt+TZidDA2GjaxNTZCHy/Loi7V5af4MSN92YPQZUWWs+SkZnSss6NVxgGbXOi510efSx7wou9mPkpOA2kzfb5SyIRwIam
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:48:20.7745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f44e31a-48ed-4d35-f204-08df0d7d8da8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

Extend the existing user CMPXCHG helpers to support 16-byte operands on
x86-64, using LOCK_PREFIX "cmpxchg16b".  This mirrors the existing
__try_cmpxchg64_user_asm() / cmpxchg8b path provided for 32-bit kernels,
where KVM needs an atomic compare-exchange wider than the generic
cmpxchg helper can provide.

On 32-bit kernels, stub the helper to generate build failure because
cmpxchg16b requires 64-bit GPRs and is not available.

KVM uses this to atomically emulate guest cmpxchg16b on guest RAM mapped
via userspace addresses.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/uaccess.h | 64 +++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..6e10a8a3ba4d 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -407,6 +407,27 @@ do {									\
 	if (unlikely(!success))						\
 		*_old = __old;						\
 	likely(success);					})
+#else // !CONFIG_X86_32
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	u64 __old_low = (u64)*_old;					\
+	u64 __old_high = (u64)(*_old >> 64);				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_goto_output("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : "=@ccz" (success),				\
+		       "+a" (__old_low),				\
+		       "+d" (__old_high),				\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u64)__new),				\
+		       "c" ((u64)((u128)__new >> 64))			\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = ((u128)__old_high << 64) | __old_low;		\
+	likely(success);					})
 #endif // CONFIG_X86_32
 #else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
 #define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
@@ -463,6 +484,32 @@ do {									\
 	if (unlikely(!__result))					\
 		*_old = __old;						\
 	likely(__result);					})
+#else //!CONFIG_X86_32
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
+	int __result;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	u64 __old_low = (u64)*_old;					\
+	u64 __old_high = (u64)(*_old >> 64);				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
+		     "mov $0, %[result]\n\t"				\
+		     "setz %b[result]\n"				\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[result])			\
+		     : [result] "=q" (__result),			\
+		       "+a" (__old_low),				\
+		       "+d" (__old_high),				\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u64)__new),				\
+		       "c" ((u64)((u128)__new >> 64))			\
+		     : "memory", "cc");					\
+	if (unlikely(__result < 0))					\
+		goto label;						\
+	if (unlikely(!__result))					\
+		*_old = ((u128)__old_high << 64) | __old_low;		\
+	likely(__result);					})
 #endif // CONFIG_X86_32
 #endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
 
@@ -551,11 +598,18 @@ do {										\
 
 extern void __try_cmpxchg_user_wrong_size(void);
 
-#ifndef CONFIG_X86_32
+#if defined(CONFIG_X86_32) || !defined(X86_FEATURE_CX16)
+/*
+ * Always fail on 32 bit arch or 64 arch without 128 bit cmpxchg support
+ */
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG_ON(1); 0; })
+#else
 #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
 	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
+
 #endif
 
+
 /*
  * Force the pointer to u<size> to match the size expected by the asm helper.
  * clang/LLVM compiles all cases and only discards the unused paths after
@@ -580,6 +634,14 @@ extern void __try_cmpxchg_user_wrong_size(void);
 	case 8:	__ret = __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_oldp),\
 						 (_nval), _label);		\
 		break;								\
+	case 16:								\
+		if (boot_cpu_has(X86_FEATURE_CX16))				\
+			__ret = __try_cmpxchg128_user_asm(			\
+					(__force u128 *)(_ptr),			\
+					(_oldp), (_nval), _label);		\
+		else								\
+			__ret = 0;						\
+		break;								\
 	default: __try_cmpxchg_user_wrong_size();				\
 	}									\
 	__ret;						})
-- 
2.34.1

