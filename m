Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9D3515C9
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675728; cv=fail; b=om+stDPdth2Ae6kDrfEHjVgfyM2wQzbX9XjH9DQj4h+MHyI48umKKYbJhhvrhCRURI+zN3AKhCCPdcRO+n/XRldDF8WccqoJ94gse/N0PVzUTP/Z5wUqNwC9jDsjavTRAGnI4f+pSN6P5tgAL/otb27DTETZvCbPByuv+kacLBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675728; c=relaxed/simple;
	bh=zvyUnAXW5rmE5dMbuoG905w1hFewi7MfBVAboz0v1e0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dgy9zom+VrrIlsblgNDUzvPyoDlNGxXirIRh6IRJ9GJEIwN+UxPd2W/0JViRcFSWkk5g/Z5Iq09nzLecV9o47QHBsAWB8lDeTL1EysJ2m/5xc6SWaPKH6lfWtd1shQHsXD7zljeLeDwuwE5a5sz80jQybk8cp0QarAdn6nI2HiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwiEM5F9; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwiEM5F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdQsUf7yrXHqFUEc1h7S5EC9jugAQTE8jv5IdY503ULCdWR4bMeJatR+5gxQdNV7xyIGLdauKHQkxFXTuQGtTM9kwHsaJt+6MdRfRj7QuCEgAnQTNXqym9Ch44u6Ob7pcnNFmZjvRGsPriEa83vhFR4lLJ8F+DJMHlFhNqpD72/K8L96yueJH1aYU16ZlXFehcFZCKkDhOn3DZ4R4fOsspAmuiUnA6od2Iu6jHztff72RFDZLq5EpSzOBKtv0ORpyB+pete55UUZwZ6UCQSC1tjClTf3RlQwarhPgyzobpdk0nO/zF4rfnOJ/58sliv2Vq7zyTfn5xFwMXHnOq7dYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvbIB2+9aYz7o5jkUy8YAyp79g3NEHhO/xaTp74Z0zM=;
 b=SYdg03H3csYZIevEO3Ngr2c7oRDg1HJK65Kut/Z7mvyrJOF2QyI1NokCfEnEoz0coDldbMu45/IT0JV9LfMkGZ1ZorJ+N+zBIQDYmG64AdZ7w0LjWAF5YGCaTCigoZxxtrZFnIwcNN01o+Rqk+1YC4cmiV+7rMTvY3uBCzjD5K31nDeMi9VjR54d7ie0jHjZhusnQbytruClfE6EwP81HkZK4FnAlz3cb3QIBX+YvaLXVr8tY+FT82+MaJwv17OPlAmjrvwKHSHhzsYLoFYg4iuAPMF8+G6OLUSiPDShyIZPDEf61mhbcdBT2XV1dbPkHeQlXX87MtDtJ98Rh+jiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvbIB2+9aYz7o5jkUy8YAyp79g3NEHhO/xaTp74Z0zM=;
 b=BwiEM5F9HVOWxo0jTIADCc2rVaEPv9ivdE5xZNIRd69EIr4gCeCRX3mdlH23lgyLzqAjLNE4Vot9PP0S4A8+8ixAgj5U/jKEBrNf79RaC2y9cdhKLS4v/2X+3pelHmdy+a0NqVyhdttxzQnzVWsL7tsh8ZuQ4u0YnfYLORDUiJY=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:35:19 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::7) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 16:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:35:19 +0000
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:35:16 -0500
Message-ID: <221341e0-2657-4cdf-9ce7-3857e5195a47@amd.com>
Date: Tue, 25 Aug 2026 22:05:13 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <sashiko-reviews@lists.linux.dev>,
	<kvm@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260706063035.1139-1-sarunkod@amd.com>
 <20260706063035.1139-2-sarunkod@amd.com>
 <20260706065212.CCD741F000E9@smtp.kernel.org>
 <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com> <anpsjpCQHjJCH7TU@google.com>
 <327c7769-8ef6-40c3-869a-93c29ec9fa9f@amd.com> <ao20mmzg6dMLukMo@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <ao20mmzg6dMLukMo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 030de3dc-7cf6-4f0c-abf7-08df02c6da03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|4143699003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z2PsGVb/w2yyYQCXtOacuSuc13iXxFblViSLZLsfpf3CJrA2BimOoLR50Zb80+dQ6dClsAaoBXWm8e9jMpcH0b6BVASNwbelmiSku7MKM7cAfiicT0CQBACZ8fSjs+NrVXt79nbI3psIIJaQsKSjJaNoHER5FwL/E5iFCLyPZwa6JyTuOucojw2fPGgyu6e4LfWpF1U1s7w8+fs24bcbsX4jJLv/3tygowW4f7Cabu6dz4732BBALcwOJCDTirZvVQLFGRCX0ZAK/Q6RCZJiSrE9YufkJ8PsHuuQmzE1EOTYncjARUlP5Eipax9PxIa1TdDxYgvLintCjNMgSqxzg2AZrTsQK6ps2nhfRHmbGz7SjgDrb02hetWqOXd+Juq5JcpRjwo3KM2MlzgInrjz9D3T47EXVGEoZNW89PPCdzBpT/jwj7dhw0jEvLJMDza/kyNz34cdNDg67Nl6Awbm9IRK31LVHbr1QhXiwDMFMadqnetpC8F7qYvpG405WgMqSo2TlFxNbqFna7kCTYLVpAVr4CfjHNCmdZsPQpzNqbzMZvaWm3V8HXWYvYannbpgrjXJhVWO49CTPGMEqyar0EqYO7ontYqq9yNiHu8PTExJohAaPP3xCTk8/iY4UveBt/zSMKPW3UewnvOs1pp9lA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sFqph4vv8Bcj9p5criHKBXl7iJ0SFkK5VLAWaHl4lvc5y5av70rrEVZD5Ek0oYGweuevD60T5GlNNh6Iu3jZE3fJxljbYv9TgUi1fxsKX+jZ7OKv2BQVACxzU+2vZyuUDhddpxnZaSEXlookRnwtTB7PQSGo59jDORpqJyy6IEjnntX5bQeDykINzdB/BsMOfK+BT/xOEkP5u/9uZAB1ru+ORMvoWTUCi9jyk0BOdWnJQc1g7+IDWiYne4ZSboxN9c/jsjUNfb1ojGINeodQxHi9kkePEHvHuiEDBJ41hY0e9rZP/VhIp5SVnF9XFiGg0/9FyuNPmYpKgGRHCpCkJCaez7WHIwdcqIB0W6cvPyTgY+SPvLj+ccXCpBt6Cj8Qd8Co7/5ObZCoeAM9Jv5VajMiEEf8poI3947/QCawHka26eFUId4rVV9uCLTIJlGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:35:19.2605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030de3dc-7cf6-4f0c-abf7-08df02c6da03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033



On 8/25/2026 8:58 PM, Sean Christopherson wrote:
> On Tue, Aug 25, 2026, Sairaj Kodilkar wrote:
>> On 8/11/2026 5:57 AM, Sean Christopherson wrote:
>>> On Mon, Jul 06, 2026, Sairaj Kodilkar wrote:
>>>> On 7/6/2026 12:22 PM, sashiko-bot@kernel.org wrote:
>>>>>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>>>>>> index 367297b188c39..123755d471099 100644
>>>>>> --- a/arch/x86/include/asm/uaccess.h
>>>>>> +++ b/arch/x86/include/asm/uaccess.h
>>>>> [ ... ]
>>>>>
>>>>>> @@ -551,11 +594,18 @@ do {                                                                            \
>>>>>>
>>>>>>   extern void __try_cmpxchg_user_wrong_size(void);
>>>>>>
>>>>>> -#ifndef CONFIG_X86_32
>>>>>> +#ifdef CONFIG_X86_32
>>>>>> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
>>>>>> + * instruction).
>>>>>> + */
>>>>>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
>>>>> [Severity: Medium]
>>>>> Does this 32-bit stub correctly signal failure?
>>>>>
>>>>> Since this macro evaluates to 1, won't the surrounding unsafe_try_cmpxchg_user
>>>>> macro treat this as success (true) rather than failure (false)?
>>>>>
>>>>> This could cause the wrapper to negate the value and return 0 (success) to the
>>>>> caller, falsely signaling a successful memory exchange without actually
>>>>> updating memory or the old value. Even though there are no current 32-bit
>>>>> callers using a 16-byte operand, should this evaluate to 0 instead of 1 to
>>>>> ensure theoretical future callers don't encounter a silent atomicity break?
>>>>>
>>>>> --
>>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260706063035.1139-1-sarunkod@amd.com?part=1
>>>> Hi,
>>>>
>>>> Right, It should return 0 instead of 1, will rectify this in the next patch.
>>>
>>> Is it possible to fail the build instead?  Attempting to generate CMPXCHG16B on
>>> 32-bit should straigt up fail.
>>
>> Hi Sean,
>>
>> A compile-time failure in __try_cmpxchg128_user_asm would unfortunately
>> break i386 builds even for callers that never use a 16-byte operand.
>>
>> unsafe_try_cmpxchg_user dispatches on sizeof(*(_ptr)) via a switch, and
>> the 128-bit path is one of those cases. As noted in the comment above
>> the macro, Clang/LLVM tends to compile all switch arms when expanding
>> this macro, and only discards unused paths afterward.
> 
> If that's actually happening, then this code is already broken, because u128
> exists only on (some) 64-bit kernels.
> 
> A straight static_assert() will fail, but BUILD_BUG_ON() (or more precisely,
> __compiletime_assert())  and all of the associated magic exists for these exact
> scenarios.  Unlike static_assert(), __compiletime_assert() relies on dead-code
> elimination, i.e. does exactly what we want.

Sorry, I got confused between static assertion and compile time
assertion. BUILD_BUG_ON() should work. Will update and repost the patches.

Thanks
Sairaj

> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index a58d50d7a219..710a0b42eeef 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -595,10 +595,7 @@ do {										\
>  extern void __try_cmpxchg_user_wrong_size(void);
>  
>  #ifdef CONFIG_X86_32
> -/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
> - * instruction).
> - */
> -#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG_ON(1); 1; })
>  #else
>  #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
>  	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
> 

