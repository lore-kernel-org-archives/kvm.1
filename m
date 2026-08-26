Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E86379C37;
	Wed, 26 Aug 2026 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727681; cv=fail; b=UyqcWVgjkBefJJ0nKB5Bs7VlVSDZ3UE9Hmeou69tlb5/GAoUNc9G2wTFC3pmGtzxMytou1QVIEp+XPrBrX5i2tQKqD2IdpxDB8tlY2ixCuy2eIMNXGT+R/CFVdx38h5pWFpMqaP8VH5dtnRMFjzq0txCDIyQuj9wyTyZV8/kz/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727681; c=relaxed/simple;
	bh=U9x4GJ52maFAajDMp/1G9zNEFURDlly4TPboFhOM9xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q71UQRGJw8ocfcVW4uhRgyzxtMxEIRuMk0b3KDaHk8660WI33JLcuJPfeEWSWFL7QB3vRv2kVYYBPnWZez4akQR0xbjonqzkx+YEy2M2a388Zb7wGCM8BzAGzF31idR6/W8FQTElF45XWCJP/w9VMxvYteMYPImsPgJd2UHpt3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FwI2hwR4; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FwI2hwR4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moIznvwFm5WAvvnUQnvk+BHgmwrHVdNJghYXr5E9zkccqUuobYWH07QFIRy2ag8/buv+o+qMylRnJk85K0wwO6t79s/m+/kvZjvI2jzYcRJyQJSNRPKZ5/8iyeiM53kmEO74B3tKJZMSPX7tPyfIdDneAf1fYEgp5th5Jl2A4NqJ3Q1cJ4fc16znQLS7H/4mE0ClVTcK/Tb3YEjzwJGMn7OWfv1R1Yj8wcoHvw4DWZ/uDI+0swjh+qi05ars/w6yE2EhmWg2ps15GbEnzTCKBOTRqgUA+ihAK/ZiOi727LOiRfsTDF6j2eIT76b24b2pd9YAqMkh1t2wD42wBM0/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ67TuM1C21/3IbK0KQbyrHmJ72zJPw7opvNHDOvi5k=;
 b=UzQFxKxeMJRkZtyWFH66T58p01H5cP3QD6lnTpV50LcXFSz+UFZ5lrv6LDeDD87e8hcaAFnw9yGNDdmT9OjXJ7U5s7xwgDvrjYlTiKdsYNutJh0dHHJ58BbC9TYpUUSj5U9s9juuy0T5EjWgeEHig6w5CN2Yw4MBSxS3YmjCpeV+B1244d4Mc90F6abk0H6SKootl9y8qUH14WIHpS9IUX/DCMUDs+tE/O9qD5trBU6EN89y49lWvT6duCSnY7iYu0Fbl8ozuweFTQ39eUkLAykiPXjlXUg4BVXjOCnKzYJCldh8+YV+2pbBdnZOvHr5MmsOQRIki5q9OIXVnCsuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ67TuM1C21/3IbK0KQbyrHmJ72zJPw7opvNHDOvi5k=;
 b=FwI2hwR4iMLvsclfFL0a1acmO7A24p3P67PFckGZt+ccFjmpRotgaIO7BuoXaPZBMrz1WM5OrqK73YpFM8XQz1Vs570mmbWoADHb+97Culy8cZfNTB9Uhsgc8sl1sYWAFThwElypEGfNzMCzfhPeaI6+AvATC4EWlZ0jWD5c/Zc=
Received: from BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::16)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 07:01:13 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::aa) by BY1P220CA0040.outlook.office365.com
 (2603:10b6:a03:59e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 07:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 07:01:12 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 02:01:05 -0500
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
Subject: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
Date: Wed, 26 Aug 2026 12:30:03 +0530
Message-ID: <20260826070004.8100-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826070004.8100-1-sarunkod@amd.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5914a0-cc61-4fbf-af51-08df033fd093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|7416014|376014|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	hrUloijk4C9EX2CVHlWquzU2yjEcmOOGBQKx8p9aDM/73bIblI4meg/SyuGcR6J/2JHrPF21J8jYbsJy1Wv+DWgU7zPfToIp0z40endq4MfHtR9X6QbJwXbteQqAI5RKRdmTz/iy5lJaxM9GQzF4O77woV0s4CyC4cKumudCSF42QHLK1LYhPsFX+cWgqOlH3CsheaOAytEBBopooHS3XOAm48cEWW5wVoA8IWwivGg0I6ngocE7tRsepOqYbqvqSeSG6M9ywsCbRbceuns5rh99cN7px9ThKZK4z4FX20SvkhwynxflM/yCzqbUB6iYz52ihXcLjP/fN5Oo0EKPSWEaYJbwlJZfemZYVFqB962z1cxCaJ8nm1He82osPiq+p5JFe3CiUO5QKBGepaxePShCH/oJFqUiiIgOFciril5Ug9O21YQfGhcHN0K8ku79FRhdDeKglZwzEVMVxIGi64DyUTCH4cZPl57O4EXM7+NPCYiVnsMtt3J2Btaxt1ekPxKfyHYez2Img3BHX2amT6IMTggwkzBKe6pw3gBPgCczwT5mqKQfkNnrACgYN9NgWp6m/sElJ0ed3tyEtztBwWYOV47W4hxcHiyJd5spVEZmgtxCBWjrvVxhgr/9gNFYhA6EPE7e+EMNbLxZvXh/KA+gCFX3b1r0fNsPEe4MG2/DRwesNJo3z/qS+mDRkszRk89WT9kcrMABjb0NTyqVe4NDl4VtuQarrhXCYZHW5MDCcMc6m93CYuLaMlNgNvpl
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pKEANe7C68pZeaUW0Wk3ro25m1T3FS8CihxQAPUYcXNKdfrZ3fnwj1jod/+bmSOAIwo04IWBSsQmw0/FXNk+6dEgxtc0zfR34tLaLyP6dr1p6Ahws0XakRUCvpAnvOEyXNoaHuuQOuqV3SfbtM43cFH0lqpuG5CrrQ2d/Vv4b13BT25hrM50QUMi3Gl3fId+/mXXf4SusXYMKRYnFQX/hLHZJkZ7179wTSq+mXDBlZxa1cDVcHGdnFGnjKDD2pyXiadbgaS3mpp/CDBAyHJsXEeJolO5RV6x3lMYIE2qyLLlZMWKomr4evAgXpEPHDtYxqRkaUPL+DvJO83x+1n7bltLGpq/s2Is2cfD975E21eO0YXEn/SMbBbBB13j7P1RmMpBUU0lvRPkcydFP7aOo0GIoi95VR/+G6JTahnpRWVzgvxzamAJkDqdpaj8x1UQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:01:12.5799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5914a0-cc61-4fbf-af51-08df033fd093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

Extend the existing user CMPXCHG helpers to support 16-byte operands on
x86-64, using LOCK_PREFIX "cmpxchg16b".  This mirrors the existing
__try_cmpxchg64_user_asm() / cmpxchg8b path provided for 32-bit kernels,
where KVM needs an atomic compare-exchange wider than the generic
cmpxchg helper can provide.

On 32-bit kernels, stub the helper to always return failure because cmpxchg16b
requires 64-bit GPRs and is not available.

KVM uses this to atomically emulate guest cmpxchg16b on guest RAM mapped
via userspace addresses.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/include/asm/uaccess.h | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..39bcf327664e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -407,6 +407,25 @@ do {									\
 	if (unlikely(!success))						\
 		*_old = __old;						\
 	likely(success);					})
+#else // !CONFIG_X86_32
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_goto_output("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : "=@ccz" (success),				\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u64)__new),				\
+		       "c" ((u64)((u128)__new >> 64))			\
+		     : "memory"						\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
 #endif // CONFIG_X86_32
 #else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
 #define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
@@ -463,6 +482,30 @@ do {									\
 	if (unlikely(!__result))					\
 		*_old = __old;						\
 	likely(__result);					})
+#else //!CONFIG_X86_32
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
+	int __result;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
+		     "mov $0, %[result]\n\t"				\
+		     "setz %b[result]\n"				\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[result])			\
+		     : [result] "=q" (__result),			\
+		       "+A" (__old),					\
+		       [ptr] "+m" (*_ptr)				\
+		     : "b" ((u64)__new),				\
+		       "c" ((u64)((u128)__new >> 64))			\
+		     : "memory", "cc");					\
+	if (unlikely(__result < 0))					\
+		goto label;						\
+	if (unlikely(!__result))					\
+		*_old = __old;						\
+	likely(__result);					})
 #endif // CONFIG_X86_32
 #endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
 
@@ -551,11 +594,18 @@ do {										\
 
 extern void __try_cmpxchg_user_wrong_size(void);
 
-#ifndef CONFIG_X86_32
+#ifdef CONFIG_X86_32
+/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
+ * instruction).
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
@@ -580,6 +630,10 @@ extern void __try_cmpxchg_user_wrong_size(void);
 	case 8:	__ret = __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_oldp),\
 						 (_nval), _label);		\
 		break;								\
+	case 16:								\
+		__ret = __try_cmpxchg128_user_asm((__force u128 *)(_ptr),	\
+						  (_oldp), (_nval), _label);	\
+		break;								\
 	default: __try_cmpxchg_user_wrong_size();				\
 	}									\
 	__ret;						})
-- 
2.34.1

