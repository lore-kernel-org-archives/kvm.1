Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673163;
	b=dr6XcbunsjDZ/+XU7NXy+AgO+k2jroI/GhVatikccnc0frazYxySb03EXBd8SKmJ98bV
	 fI6DHIkal8Bown4DgKnEiaMIyTe7eKCwx9c8g70iBfWX7pXfehn4Z4ZhlR4dlYkh0HSZL
	 kRVgKMqLBOwpQx+xIjrXaXwR/ohzoJkBtQvwHgDvcW0bIZV+2oBDPoTbGC6K5Hpq5v058
	 GaGjyoDCbUePQo3ucfPHmm3P6/elujJBnIZUmeXYVS5pq5z9xXCTbLbGI6QtkRzVbmNSB
	 LledWVyJ2nS7c1+S37PglsBofPKENSYYcwhxii3yEEsRG2ciegOlh0PkdXK/Ql2UKbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673163;
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
	bh=14eckfhp0LTPLZUTZG6g4rSxk3ZEsGGfyzSCv/zSX8U=;
	b=oH53KcleG1Vo/yG1RxTeqpw0CkqLZATwT7ZRHgy3E09GQkI+8qWRm2fV5+YLuY2WEh9l
	 5sN+abNv63/8eG8amvdqFz1rsCfZjvJ3N4v2ROT3EhLaSjvDwC/4kgo951AwsvMJJq+g4
	 IURGmR4diJn83O5+RxZeUZHuu/fieAfPKrJopxSeSdrBI1IvguQ/cI6W09qDPhzpTgtuY
	 oCS8BF6U3ZqNZn0eERIvYKGvfrls7FaZZ1QiWjmUUhDMGN7o2dxtfhISqYIt1Op9zaDLp
	 EpMzpYnE5fHWgWIslM1IzaPA7UByRH3o9G+MIXORntkp/Z886ORwnpW2FgMZG7wdtEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ufHeEozy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2998606A326;
	Thu, 26 Nov 2026 06:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2998606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ufHeEozy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPTYGBZ7bIVVVXGU/RYK3C8EhF2I7ZDDoDMMENIb4h0+4w4PoGQpDVXdN8LvfHyEZqwZyjmN1R0BfKUQuc9IbimwakHA3VXMSFdadEuE2/w4WI2UiTmjh5tLcPcT33o20sshkhcmSw+QYEOUk4lyK8hLkuAhmWmcmdTtrx6MqlHHMWJ/kd9vewKDLkRZUmZokZqrRx7A7Bpy8Rq0loRAnI2ooxaRVJizb6XiZDLlytTsquWuNgfGYYti1Qwvmco8P8skvqx1STakP2GFNdKT7Wu1KGbTUnJDngU2K1SUSBAQyhQUDvUs74rNI5DlpxBwPTgMVkxw/dGbOWztk/yLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14eckfhp0LTPLZUTZG6g4rSxk3ZEsGGfyzSCv/zSX8U=;
 b=dejmXMPSfvjcMIhjdx32KJpi3eeJV9EAhxesjyW5iAHWqVN1cNuX2I9twRXsnz62b6oqOPW2yrRKhOAQgUkvylImL0qbqN+DNimGwUvIMPZ2QD93i9aXMi0yaGArqg6uysOVhKInesk5mVR+zswZF1L6V1nvmkb5nz/TPDeCsdROB67NB15ycpAFaDqMpEYQA+yJjEjLRWC51HXIsOWei+3EfJ8rImiMVFAvt9OXE1OJV4iew7FGHPBPYhI8XpHRMLyHT9I3E8XwzGBDAslA8WwbCQoH23SGXaIjT8alBk6R/4Mg3TUuptN7rGqPpYhZGwWUdpvcb+xKRW5a5GmBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14eckfhp0LTPLZUTZG6g4rSxk3ZEsGGfyzSCv/zSX8U=;
 b=ufHeEozyL/fcxu7tEAdCxtjT24aEZuYc39VuqZ3dHDgxaQw3dVvOZEbVPpUDN0TwXasuPEmm11Jnnlos9agU1EQP9pxt4HdVxestslKs1ofl6LlggUsbdeAJZ7bu8qUEfxLDZBA0CrulGU9AswfzCQ1yHB4mZnK9Mx43C3I8GF0=
Received: from BN9PR03CA0169.namprd03.prod.outlook.com (2603:10b6:408:f4::24)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:05:59 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::78) by BN9PR03CA0169.outlook.office365.com
 (2603:10b6:408:f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 06:05:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:05:58 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 00:05:55 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v5 1/2] x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
Date: Thu, 26 Nov 2026 11:35:14 +0530
Message-ID: <20261126060515.2198-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126060515.2198-1-sarunkod@amd.com>
References: <20261126060515.2198-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: fb352917-c54b-4ec3-867d-08df4b83576d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|7416014|1800799024|22082099003|18002099003|3023799007|921020|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+lgIXt7TfYu0EUjHGRrbVu9ps83tlPjly7IfVIk4KRf42UM7oCZ3Lv7dPW+BGjtmKdqvU+z/vfHrALgoUV/69hpMtAOQwGabFaMERNQkVXUpR8+FiqeXz5jwaDOjM4ALBcKdMSCMv1di5Xm+CEqwvR6p3GK+q6jyA7gPus53gllNW6tdR7hKD1x4hfS3L2W+ENv6Vmp213wIDWr3OsxR/0/rp5dNM59SrYTzM2bvzw1q5U8F+TjRsUJILm56HHNKC5zRqfZDMmghiDgDd8UCvlhlpu4kRANczFbabmhSRoSA8dxpJNEpHgXo1pWk9N9diwDzcKuOAA3Ty7tty7NNw4DncpVvlPqyLqvChDPzgElNGqEMe7dV8HJ8CpOgNDWZcsHAclHI3q6BwATOh15bIZRil1l5fiHKPwFrUKGsvieaNbiIwyGmQrmgms+Y2CIifXYS9U6EEuNPGqdPyUK1nAhZ7K3+/nXbvGffFWhAeWVUPNDduV3VrsLu4ke559lOomJE5Ro3+j3VE4gmPiP4q7BuNkAbM1Px4U8fJYfAL7FSGX+pRsjv++GnnBhn8E/dd3RyPeiypQ/1PtOOSbyYxbWIb7F4hXEa6MYnWrrSWslpHKzJwVJ660QIBu77zJnRd+HZgxTtJiJnJeqyaYSHA6AVIEc5vwfl9BVbW0PO8LXrDPEwoZ+zl1pK5DcI6bukxYbVXv9BPrZnNPoWExZJvtiskwTnFUrU5Kdp9YEsyqUoW2RICr2XrFs/JInFe+y0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(7416014)(1800799024)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	33Ox1fl1yvGhMa3xI7cw6/Uo+Aym9YK5+Crs20v6z5GpYbzrAklOi42Dlf7uECMIeEGRhpzBV61X9/pzapXUD0A+zVyrq7KV8p0HT8BttxYbeXDZ/kqLkc/dqADHMUibBoo9v25dDihyOYeVionFjtjd80j3UdEdGeCOKY2RmHzx5JnSHSdcMd3NuBxMqkhZu+kcwv6ne53E48WZPxfDbhLCpdhvaU2d7sWms0Ab1EXePE0STBodgOaZZDEsAb/g/6SqSwC+YfFZ4U/kEIjSdFLkKLfi4/kBAEhj0UWiyrCie2+KDiWEog6Gxf/3yeqG6FEjN4c5Bn9vtYtT4HK1R/3nryLVQBk6USeK65mklNGU/v/IGiLIcu4jM9OAqW7WnqnYCRhJvnspUJiW1e1szDWfT7zsvp59j0dYecwN6ZuPkZfAA5XrSAO1RJOB5x38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:05:58.9093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb352917-c54b-4ec3-867d-08df4b83576d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

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
 arch/x86/include/asm/uaccess.h | 63 +++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f4700ad6b5ec..2c1418c6d61b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -353,6 +353,27 @@ do {									\
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
@@ -409,6 +430,32 @@ do {									\
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
 
@@ -497,11 +544,17 @@ do {										\
 
 extern void __try_cmpxchg_user_wrong_size(void);
 
-#ifndef CONFIG_X86_32
+#ifdef CONFIG_X86_32
+/*
+ * Always fail on 32 bit arch or 64 arch without 128 bit cmpxchg support
+ */
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG_ON(1); 0; })
+#else
 #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
 	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
 #endif
 
+
 /*
  * Force the pointer to u<size> to match the size expected by the asm helper.
  * clang/LLVM compiles all cases and only discards the unused paths after
@@ -526,6 +579,14 @@ extern void __try_cmpxchg_user_wrong_size(void);
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

