Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A82DB7A3;
	Mon,  6 Jul 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319584; cv=fail; b=QW5/g0k5a0yHge/KtpYVlY9ET20l9YQluG6ZEhuTyRvEgNcVbS9N6I7F7SVSVZ7S07W2F144+ByknTIiAfsIwDW96HdkFv7/YtJKpxuNo59BHARCez4cqaaa6nmwxS2uAscl8K+b/5mMCRWC5F0SkF2/uZY+7uvrb6OhaLAy1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319584; c=relaxed/simple;
	bh=wOBiGV98nxWbXO9RiVlA8bEwaILXEQu8MtREo9JPgKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kont9Ue7Y8HTAAyw8OD80Z1i13GEmU+WTd1EEGi6U812CrOpmhnfggQl/Pm1QaVdXWt8NoxhAlhTXX8Sl64T3aVSAvEx5ubqdOVi5qRv+LL0XtYxHn9Ta1LCRVhk2bDljQjHZrCbp+qaT2wY5JQY/aNSsNhAw+jHA+iURs9Zhqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCz/WxvF; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCz/WxvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6AfbIe40QEZogT79gw1jm0bFgLC7bHvfuaSTbWu15YyHNd2L/gkbOgW1deCw59pRMy/apyYBFpspLVRLSB5iDQrv+GMWtJmXPyaX3RwGs3PmfT6AsCjigB+SvylwtnGXgspdf3Kh7LQIxfHwoTPExlEyaEBnQU18dvFzg0OcWWBTeUAnSy04xOuaJ+uT2qzIVJ+kV4q8rKHYmP8/00H7W59x0B3vW7PIbtIkpiDFUB7F/XqO/LYOyJHr8Eo4X0cDf080Rhi1bnRqQ/EQD3GIcjjKbplqVzNZdYPTuVqQMsNS8sAHI4nsvV4MywE/1+EUcAqcReX/mXZxY5Apu9atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA3I//XJ/uwVENIWI/A5w/yeJmAFHbH7kFVl32OPez0=;
 b=vNJBfGoI346xGLJqCw2cTpBLwXPvtRGeW7O+oyYYJcVhgPyF5sJ2CgTRrUg18qTqoqDrGPAI6V0owD+Uco+IMBw1qcRYM0C6nJqLkqrXlBHbJAsyWHZJQaN2f15vurNehqPTZ4zli5psMdx5+UiNXQqitr8NyIWDG/C4av8xSw0JpRX6XUTb7EqUueeULKAD+M1gryEguJg5xAyl283ZFbQVzNTr2HJwHyq/QrhR3+xJsIThXvjAMjB4Zs1Tkny6YyF0XZ25Pj75fIT/n57BHc7LJ95kfHLMdzWsm1xI94Lmo338Kluq8BzFp47zpnFh1G1xZLlZ/eoXtx/j4JhUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA3I//XJ/uwVENIWI/A5w/yeJmAFHbH7kFVl32OPez0=;
 b=ZCz/WxvFH8rzW7RQtRDY6/whR2M2hVO3HwcyubpKiLcPdgq+ucNARHiO1v0c5oLslY2G5xeK5rHDR0zl6r84BAXiIC4A0OQB9eRk8rqICt4fL1wWy55Nqx2ZSx1g+twHGQLUF0wetd3LYskEnMs6hZR+51aughzZ+iD1GSiw8pk=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 06:32:38 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a5) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 06:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 06:32:37 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 01:32:07 -0500
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
Subject: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
Date: Mon, 6 Jul 2026 12:00:34 +0530
Message-ID: <20260706063035.1139-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706063035.1139-1-sarunkod@amd.com>
References: <20260706063035.1139-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: df5ef11c-ca2e-4067-1bb0-08dedb285f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|921020|18002099003|3023799007|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6W7pm3yNFE/J/7oXHCQcVbTgWHiYqn8zuvmfP+YfS0LM9jdMAcPJl8c5gbpmH30Cb9P5sCw6iidBZUsWH+FaRjHQLMcDk/aJw+/ZAZ9qtM0UXvoHWc1AWPpsPd8FcUuzJ6f83Skqk7Pqbwy4B2r4uo4cv1tQ6BOewRhi98UKJA+XWW3bfEu2QonklMTcLsq7VgzovzcFbZFtZoL7EDGx/M/mDpKlIpBwBEXTkd19MTvpE/C6L8JFL0SZK5egVRoTsEe2fF8xviRVxeXW0hVs+hwvYm0vD+z7yzq6Zd8x+OT/txT0izJv4Wud1Y0a5PnuYNNx/xA8DBuDP/obUqVuendogI/Kt+N3AHr3tdWieN4x+QnKKUtVZac//yDPvbR9gV0gPUY01i0Uy2rbKI+SXDDg9WSzyWWgsBkfUpMWt+OgPMLpj8GqA/VeAlpUesma+OVrppW1izz3hv2f2+Mz17k2N5HuVLhxM6+YC2qDOxz2ZseR+GuLonIxrCphspWwGFcEm7xnJPlhaCnVwd4yj1gsUMR1qS8G+hWlgFpVQwuvmPR4EEjEESiFEbjlWgJgpSPTyB/d9IUNGf8O1vP0moTtgjwHFqYJFr92kXuQKt01xWovq2hrz8HZ4QjZBRFBp/vs5rirfD2ntPvoFDF/Hwp5BEOWJWGjssAT82iPGIsy7ieVfMrLEI9OhkBJRTEPpj65NEWPnBZweHPI6vT6w67ED55F+B+2DYSp04zEqIwVKhWIN3fbBnlhWEKOLTOs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(18002099003)(3023799007)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmgVuxm/GDlhYGJBgGMIlNDmaHXbF1Y2Lgp+D9iCfalhhf8JLGlmFp9M3Um7nat8/JRTsMC8jhgFVDDeDw3Blk5KhpRMX6H2iX9SeWjyKgXpcfQkgZqTod8ZqOND/ulDDSfC1WsDKCL3KIh42RM3WxDfOKasQEwgtpPC2Avz7iivnR3JOTS8omn7HX68+1YxDMWCH9g0UAl3jW6oPxD8dyVqRRk/fph8LkAnlCpcTiXPwAs7RNWwO4YHeAICAazq2zcLVjqEJERUIl/pQcknsYXe37hshJiOEhzZi4dtzfoYuPDOkZRcQRWtLSD7cJPSjJwGUobFaR7izLNzU3TxRwjVejx8+qom1d2X+wrHJIrWwhax5+WqzzjSdOlHA+E/uOKfv86GrA6DpA1GDuipDsonNRmyu3jh3l+oiydSosWwjH8Ke79Ji38yc4C0Ya3k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:32:37.2079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5ef11c-ca2e-4067-1bb0-08dedb285f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612

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
index 367297b188c3..123755d47109 100644
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
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
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

