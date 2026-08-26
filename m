Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC5231842
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734477; cv=fail; b=aPaVn0UpeZRMvWXKDzLeTVx+4Z1Fr7rgHkWifKZOWg7j2a+lCkhWlpt7lq4KOwavVMnu57N2FXtxP4smZEX006aEsqpSETQPBes8+HZBybpMOCKwAZekjFEmEucGc/640DBlsMathMACGzYmGkups2wm86Y6Ts1cA6ypscOyyFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734477; c=relaxed/simple;
	bh=vjG4B5PterAvT9RzSReCVwE4D7ReUoUgz+XMR6cpCi0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I6DIC8O9t3rZ0MPk44ccNshYuhsowJ8nIF1P9/N3kEwspt8jmXwHSpzZgRNVlCYG+TjT4RaY74ELDi6BraxGvHd/ih0yDJUbLegA1sSfSrCJ3GBo67c2eGCj31xU9d2QRBG0sdskPnqNdF2PO9Ru7LA+hdvOFfo8F/H4To+5/6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZDPBu7D0; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZDPBu7D0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljy6MN4m908N6IKKq3XTok44yhZiIcsDcw3zGGZ71NTlUfhdfRT3YgeQigGAAyKuGN1RCvGa+XdRDOhQ671i1XEk6r318uK7LrOO3vgMXIRL7pqC+n8ZSmjN1CKvtd932/lPaslJLTMf6p9mwguG7pxEqmpTjvbGcbPNeVLxYAcF3zJWBawcAOt9uiIfmYd5wcQypYKzm+KOFortEI4ClZHdcu9V84aXwXampAsaXB7G+gQTAdrx9KUmuAO9Xbui+eQNU5EnDB6JJl23zVYRMnMljG+m+1IieuAVEYtSwoep90fKot+ppvb+FH7+Vpr7g23r5IIIADPZpAem064qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM34Ll7U4bQ8d9mUxHEzOu1o4kfDevgj1rvWZ8mOKqQ=;
 b=GE0jbZvWfAxdrQMNjc8GFHXv+T4yZZ38Q3Gx1/Nd/OjlUBOM17nukRXCDEBTRjq++NTbG+VDwZf4BhNUFyb0yhBR63z8qvPVwuyJ7fxU/bNtt1SkxbB2epI4XnuJ2cHblOxuYIS9sGCdbM0Ww+LXZ+tTKoy6M950lIx7MfeG4/Hv60OCYDKAaNgZfdzK4JvFjeS0GhQY2rK/lp9E0/UFFTv9t6AB5e5nK1Tymi8XG2wFXDi7UgOjHy33uuEPRg+mdMjdKkH6XfjwruWSRiersC4WYwEM/U1haORQ7OhEZ30QJ9OGIHEFsyUUDNoOoWn47LAtxB4o59qGjTEllfcexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM34Ll7U4bQ8d9mUxHEzOu1o4kfDevgj1rvWZ8mOKqQ=;
 b=ZDPBu7D0JPCGxjLitXfBLa8V0mkvFNMLrJAeV2C+LNd71XC5A2NxiRZGtuJAP7s3cMrYvFDNGmrzWAV3/ZYY4Z+shvY5dUy1pODa1sr3Wv1k1ehSd4Rs0mraVuC0PHCBkXCICUaridrKrzNATab/DvD4KOs+w7MqAZvWiSeCZ5g=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 08:54:27 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1a) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 08:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 08:54:26 +0000
Received: from [10.85.33.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 03:54:24 -0500
Message-ID: <3adb04c2-a35e-4b9d-ab06-2408fabd0a89@amd.com>
Date: Wed, 26 Aug 2026 14:24:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-2-sarunkod@amd.com>
 <20260826072350.8D6991F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260826072350.8D6991F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 640102f2-20d9-4891-7c9e-08df034fa23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PZuzXWYfX95ScA/Rhxg/+ZsmBNpb3egmCL7ZlLQzCD4ChTkDMZhW892+28zAA+b+WN2VpTt2yoaYYTCprG2uzNgKRsIP2CkHy7abWsWxV/Tw/dogR06gJUyqwaak2tTWImyOs4NT6+G9dpKmsbnf1Ppl5Om2ZdhNIHFz9T5pxtRbi/C13fT++XZRmoP8bFdjRuB5827vX0gMjR/Jty+3yJDBnlhnyzluEGjwWkrz/YoOx9zHzZ7IG0sz7LgLxU5q0H/u3STgUfThF0LLpJ1RaRL4XkLVJei7hXTubcQqipqQXIK4jhV9tI6DiS7eEqr/h2oiAuzA73No4SSvMHemutukh4mxmvzFbj8v21eL49HrdHzwKhAxTqBj0aIYbOh0ZILGG9SPHV2iY9P9qNX4oJxExl6cmWDEQTR1DTiktu5iFj2WoQfLumcn4Xq9AufD5/uJ1Vkc3fLo9cvjl76Rry9cke5oU0QyDjZk/uyAeNBlKr8NU650w5PNIMrV9VjgfPWOBfDk+P1WpVGP9YFFLDssRD99+mot4ea2R4z/7h38Iv2yBonz1US2PLsz4v3ChtPn6XK4BVes93EfE8PLVICUv6aMxp65S+9qJjR2NcQDxsmaljxmG4YHTcHLp0NQerC9QM10taX/T500ZsThbAqi7V0CBO5FZE6ZsIMFJrdZIFxEM6xb3GHHam3ze5E4o5BeLLV8T2hDv3OGoAuU0Q==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sh0IAi9rxYdP9XrQMo6hUFaq6Sd8WLW9lZDleByEfxOYaJCPreTBMuOseqAwgXsISJck6srcTA8SZBGLe0Di+Fjc5MrQOs/FYrLDb6wIFx14iTJ+Bch6EyD9KUpFsWK35gR+i4J5U0ubtndJjl9HYydcLohKDQqWF392tklEV43Pi7Ze8cPAlHtmaB1/GTDt9A5JsxG94PMa4DRPgor+cNbLC9nmKM7pWjbqcXAKxffxl5nBupLnTbnli6gvv2TrK9FjyF2zpDs7CMms9jo9qWdvaXyxJlgOrNPGYTgWwULOPK47kn9ae8jryZNigjEMInEpOto+ksT4kjZjkd5doNI1816tT8rN1iIkYIQ1WdFj9eiWCxvv7hJQwE7H++MQdhxhE5wKyQ4NHpxbX+PQFOhgxxdVg2E4OzvgRYSoDJSrF0FZe1WF2V7lqaLlaz+4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:54:26.7716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640102f2-20d9-4891-7c9e-08df034fa23c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775



On 8/26/2026 12:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The inline assembly for 128-bit cmpxchg uses the unreliable `+A` constraint on x86-64, risking silent memory corruption or build failures.
> - [Medium] The 32-bit stub for `__try_cmpxchg128_user_asm` relies on `BUILD_BUG_ON(1)`, which will break the 32-bit build for all callers of `unsafe_try_cmpxchg_user`.
> --
> 
> commit 778924f40bf568ddfaeffc09239d3c0e2a09bba6
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
> 
> This commit extends the existing user CMPXCHG helpers to support 16-byte
> operands on x86-64 using the "cmpxchg16b" instruction. On 32-bit kernels,
> it stubs the helper to fail, as cmpxchg16b requires 64-bit registers. KVM
> uses this to atomically emulate guest cmpxchg16b on guest RAM mapped via
> userspace addresses.
> 
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 3a0dd3c2b233e..39bcf327664ea 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -407,6 +407,25 @@ do {									\
> [ ... ]
>> +#else // !CONFIG_X86_32
>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
>> +	bool success;							\
>> +	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
>> +	__typeof__(*(_ptr)) __old = *_old;				\
>> +	__typeof__(*(_ptr)) __new = (_new);				\
>> +	asm_goto_output("\n"						\
>> +		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
>> +		     _ASM_EXTABLE_UA(1b, %l[label])			\
>> +		     : "=@ccz" (success),				\
>> +		       "+A" (__old),					\
> 
> [Severity: High]
> Does using the "+A" constraint for a 128-bit value provide the strict
> rdx:rax register ordering required by the cmpxchg16b instruction?
> 
> The kernel documents in arch/x86/include/asm/asm.h that the "A" constraint
> on x86-64 means rax or rdx, rather than the rdx:rax pair. If the compiler
> does not guarantee the rdx:rax ordering for __int128/u128 with "+A", could
> this lead to silent memory corruption with swapped operands, or outright
> build failures on compilers like Clang?
> 
> The standard pattern used elsewhere (like __arch_cmpxchg128 in
> arch/x86/include/asm/cmpxchg_64.h) splits the 128-bit value into a union
> of two 64-bit halves and explicitly binds them to "+a" (rax) and "+d" (rdx).
> Would it be safer to use that pattern here?

It is easy to misread/misunderstand the official gcc documentations [1].
It specifically mentions that
"Single word values will be allocated either in ax or dx".

Here on x86_64 arch, the __old is 128 bit (i.e. it cannot fit in single
register) so the compiler will always split it in rdx:rax pair.


>> +		       [ptr] "+m" (*_ptr)				\
>> +		     : "b" ((u64)__new),				\
>> +		       "c" ((u64)((u128)__new >> 64))			\
>> +		     : "memory"						\
>> +		     : label);						\
>> +	if (unlikely(!success))						\
>> +		*_old = __old;						\
>> +	likely(success);					})
>>  #endif // CONFIG_X86_32
>>  #else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
> [ ... ]
>> +#else //!CONFIG_X86_32
>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)	({	\
>> +	int __result;							\
>> +	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
>> +	__typeof__(*(_ptr)) __old = *_old;				\
>> +	__typeof__(*(_ptr)) __new = (_new);				\
>> +	asm volatile("\n"						\
>> +		     "1: " LOCK_PREFIX "cmpxchg16b %[ptr]\n"		\
>> +		     "mov $0, %[result]\n\t"				\
>> +		     "setz %b[result]\n"				\
>> +		     "2:\n"						\
>> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
>> +					   %[result])			\
>> +		     : [result] "=q" (__result),			\
>> +		       "+A" (__old),					\
> 
> [Severity: High]
> Similar to the asm_goto_output block above, this fallback path also binds
> the 128-bit __old variable to the "+A" constraint.
> 
>> +		       [ptr] "+m" (*_ptr)				\
>> +		     : "b" ((u64)__new),				\
>> +		       "c" ((u64)((u128)__new >> 64))			\
>> +		     : "memory", "cc");					\
>> +	if (unlikely(__result < 0))					\
>> +		goto label;						\
>> +	if (unlikely(!__result))					\
>> +		*_old = __old;						\
>> +	likely(__result);					})
>>  #endif // CONFIG_X86_32
>>  #endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
> [ ... ]
>> @@ -551,11 +594,18 @@ do {										\
>>  
>>  extern void __try_cmpxchg_user_wrong_size(void);
>>  
>> -#ifndef CONFIG_X86_32
>> +#ifdef CONFIG_X86_32
>> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
>> + * instruction).
>> + */
>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG_ON(1); 0; })
> 
> [Severity: Medium]
> Will this BUILD_BUG_ON(1) break 32-bit x86 builds that call the
> unsafe_try_cmpxchg_user() macro for perfectly valid 32-bit or 64-bit sizes?
> 
> Because unsafe_try_cmpxchg_user() dispatches via a switch(sizeof(*(_ptr)))
> statement, compilers like Clang/LLVM eagerly evaluate all branches during
> semantic analysis, including the 16-byte branch. If evaluated on 32-bit
> builds, BUILD_BUG_ON(1) will trigger a compile-time error regardless of
> whether the 16-byte path is actually reachable.
> 
> Since the commit message says "stub the helper to always return failure",
> would it be better to return a runtime error code here instead of using
> a build bug?
> 

The BUILD_BUG_ON(1) will only cause compile failure if there the code is
getting used. As sean mentioned in the previous version, compiler
elimiates this code if it is not used.

Thanks
Sairaj

>> +#else
>>  #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
>>  	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
> 

