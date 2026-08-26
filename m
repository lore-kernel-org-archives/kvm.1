Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D0348883
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735839; cv=fail; b=FTWIpgN0BubXXyc+eYPEBDrSktC2fGaRuJ74TCUPuMWLLtrLa2/SrE5v+7lMysAmg61an1x4M0Qw9T+pYPQuErZ5xuVX0aR+bS6TB5tTKIvrBdZBR60s6F4qRL/1zxoCNbDQ+2j6moYNP13SWyXQHonxGTf/Q3ulkH6ZYraRkeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735839; c=relaxed/simple;
	bh=zp9xi4BwWRTxuUPu0IvGlbLFkjD/vEuEvqHitb2lR5E=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KEQVE63lqHorLwwMLn2NKm70DSYCeoDG7LQuT5RkHF+lfzGabFLeTFXg9WMLZsKRHNZuD1baOT8ZJvJAoyRQxjoEaCVMceZb4sx9G77kYhnnAVCtcIzOz1rkc9XNqTGEpkDEKvEZO24aWYIpRrsayRwaqY4RH+QMYyIuGH8UZLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kfE388R/; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kfE388R/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBMUr4HVDNuvi/AujpNfiRAdoVUjrnSEJRInnxda8WMN97x27dGUWcLyPHR0ivvz4FbZkgTgw0RacR+haFLcRmVRWmXSI7W1EztM0BEu5glQNMvk2YZixtB0r/Wo/0oCe0S4zIUtWhvwy1wjSziW8ER45wapxG1v3BMzBV0rJ5dJ8TRYkX8qzSnF63dCiPQ1cK0c1eBOFs1EHg1HGwH+aVBKLxnNzXKDjfU9O/Q1eKfdCzhQwRrJ0coxsauh5FWMmGsmflA5AB6SQVnEhMdr61cX6DrAeIibWavcd3mCxxKh8qcyY6psZcAL1TSwu2ViXnv6Yi/sGOUVuLY7qFfHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvbiTwmzXhey9lsOHgUD8DDfPjcpC7SHVSAZnzT/Aik=;
 b=vSZfTHgotLZq6YjEdoSK/0e1wAjPHVHlf+RR1HM5J20geTrcwJknZFtv7mmoJw5Eh31U/FA49n1geUaF7PQcp4IcxRIQqkUTZob+U7RgdDE7EK/lIb0Stha0N9s20uo7B1QGo3u36Xfae1bYyKb2JrszO0Rok608g+bHvW0BSl3X83UhTIoX0SbqlZ5lzATKK2U4efj4xV0JwXRWH4rmP35bEGDjv/5ItCpjIHY5ALl11rlj/AeTvP03ayrAJtpYpN9BjShdh7+IvVucCpGXYc6BfZgHGWXVdki4I5a+7WKClNZW6skCk4ECF7nnrY9vC8KJOIr68OtMAArVW/rgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvbiTwmzXhey9lsOHgUD8DDfPjcpC7SHVSAZnzT/Aik=;
 b=kfE388R/EnSii6SkdvxlMZPXL4ZBoFjJHrnft3Ln2rSga4kMU76Sv8XetNp0dhoio9bRM+CNQvsUh+4STA+2mCOTljWUU5xB0az+iGcvC8XYhWuylV2a16HxWWRdX3KKWVaAOdJtWcFB636QjH0SpL7wMvJD4K3pazhxM5pd7us=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 09:17:14 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::4f) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 09:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 09:17:14 +0000
Received: from [10.85.33.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 04:17:09 -0500
Message-ID: <59242bff-f597-4f49-99b9-8f31675e63da@amd.com>
Date: Wed, 26 Aug 2026 14:47:07 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] KVM: x86: Add support for cmpxchg16b emulation
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-3-sarunkod@amd.com>
 <20260826073159.B37641F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260826073159.B37641F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e008bf4-e0b0-4ec5-c3c6-08df0352d144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XGLa03z6dyVq1k6us7foy7i/Ht8TYvWwEf6r8wkAGO1uXAIR/hU6/kTM4XJTSn6jQPlyl2hXil88U4MxwYO1Jdl4e7kwm8QN6pvy9TOX/tQZAh91JBOUcJLJ2KOxBLK0Hkv+aUyVjK4FMRMKhHYmFU3O3gZRhgU6nkI3Ur4RDCgos19GzGAQUiPe+967SAJaf4MsnoaAf5KFcOk5qCX4nIfcOuMRm/acL+iqCTdrS4RcvX4v8f8QzQBlpX4fpMiLA+31ann60Ai1nbfXppimZ+qdAEyMa7ANxzU84zsvdZ5dO7RpQKgdhzb4qURyVFvPsjfNEoCK8l01q7QVssAYqTP1O7sOcgcb2RpedQA2Swkg/+birqdD+hLDBkQciCg+Ug7TTL+ItieToeoHK/7+2+IxxavJ1toAo4TG3qSyRK8MOjD3470+prOFOt6qd0dPUUYQHsAsVk7fZKtVpWFINr3+gyht3FQTC0+kRYgG3uPc2hsOs0OUl+w8C3KAJYgAIl1tnTnIwGcfO3OUGL3vjp37nYJ0W/mKyF0ZDRKxGILi0TNlrbfYVXnZ42YaW4Fntij7d0r5UvOZaQ9IYYSuXa1d/ouSnB+t7BZVu9KK+lIZ+XNthwi2rzc2oZM8ibCFwEIkVUF9jQoDIs5ttW4pOwRjGDrdLf9uhm//tasj0O3uZ1FsO2jkOEeVJ+chjgS1k/mEhKLnyvSexeQDFiMzbw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RbW6UwKSKKOWdXCrG8ftm5AoFx8UHgQ2FL02laPfJiWY70s9BwWZ+WROt+q/5cmiOftCLX3t8jjfeqrfM1XbbNRJ/IROh3CXvPRQaqei5dV1edFqY6sJyL8l/Q36D7PMQLm9ZMn+umBvp67yl2MUiefiOWmTxvldsL86LLbfvPpvAyDjH3vn5krG9dIJHsiNsXx4LjQMzjbY6loo8y0MZNVdei8CvXB8rUjAVBmfe4PfTzdA9xE44geCPz/y9nyQxdh1+aFuRZ8/OSsDgN3Pv1QMFSYaIXFzElzCkwdZkz0iRV0Uovev48tEL2Cnq1U/5e9BWQw19/8OM2bsDPTKJOrM8J82v7Y8bw3PF+/ISv+RO1WhKRrcsg6VrzdwAWL8a5ZvlB1wSHbWV2CPa1b5uF+tFTw5znAPxqh94bVWlGcquRqBlGzwp3ciTnNMzzHK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:17:14.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e008bf4-e0b0-4ec5-c3c6-08df0352d144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5



On 8/26/2026 1:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Emulation of CMPXCHG16B lacks the mandatory 16-byte alignment check, leading to a guest-triggerable VM crash.
> - [Low] The macro `em_cmpxchg8b_16b` incorrectly captures the variable `ctxt` from the surrounding scope instead of solely using its argument `__c`.
> 
> Pre-existing issues:
> - [Critical] TOCTOU vulnerability in atomic CMPXCHG emulation leads to silent data corruption in the guest when a native compare fails.
> --
> 
> commit f6a8a67f38b03c4522f119ac54d63d97691e1289
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> KVM: x86: Add support for cmpxchg16b emulation
> 
> This patch adds support for emulating cmpxchg16b when the destination memory
> is 128-bit and REX.W = 1. This prevents QEMU guests from hitting emulation
> failures during 256-bit device table entries accesses on AMD vIOMMU.
> 
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index c1b21282187f3..f38c4f1a99c31 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
> 
> [ ... ]
> 
>> @@ -2184,24 +2184,36 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
>>  	return rc;
>>  }
>>  
>> +#define em_cmpxchg8b_16b(__c, rbits, mbits)\
>> +do {												\
>> +	u##mbits old = __c->dst.orig_val##mbits;						\
>> +												\
>> +	BUILD_BUG_ON(rbits * 2 != mbits);							\
>> +												\
>> +	if (((u##rbits) (old >> 0) != (u##rbits) reg_read(ctxt, VCPU_REGS_RAX)) ||		\
> 
> [Severity: Low]
> Does this macro intentionally reference the unpassed variable ctxt instead of
> the provided argument __c?
> 
> This uses ctxt to read registers, which makes the macro rely on the specific
> variable name ctxt in the caller's scope instead of its parameter.
> 

Its a bug, the macro should use __c instead of ctxt everywhere.

>> +	    ((u##rbits) (old >> rbits) != (u##rbits) reg_read(ctxt, VCPU_REGS_RDX))) {		\
>> +		*reg_write(ctxt, VCPU_REGS_RAX) = (u##rbits) (old >> 0);			\
>> +		*reg_write(ctxt, VCPU_REGS_RDX) = (u##rbits) (old >> rbits);			\
>> +		ctxt->eflags &= ~X86_EFLAGS_ZF;							\
>> +	} else {										\
>> +		ctxt->dst.val##mbits = ((u##mbits)reg_read(ctxt, VCPU_REGS_RCX) << rbits) |	\
>> +					(u##rbits) reg_read(ctxt, VCPU_REGS_RBX);		\
>> +												\
>> +		ctxt->eflags |= X86_EFLAGS_ZF;							\
>> +	}											\
>> +} while(0)
>> +
>>  static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>>  {
>> -	u64 old = ctxt->dst.orig_val64;
>> -
>> -	if (ctxt->dst.bytes == 16)
>> +	if (WARN_ON_ONCE(8 + !!(ctxt->rex_bits & REX_W) * 8 != ctxt->dst.bytes))
>>  		return X86EMUL_UNHANDLEABLE;
>>  
>> -	if (((u32) (old >> 0) != (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
>> -	    ((u32) (old >> 32) != (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
>> -		*reg_write(ctxt, VCPU_REGS_RAX) = (u32) (old >> 0);
>> -		*reg_write(ctxt, VCPU_REGS_RDX) = (u32) (old >> 32);
>> -		ctxt->eflags &= ~X86_EFLAGS_ZF;
>> -	} else {
>> -		ctxt->dst.val64 = ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
>> -			(u32) reg_read(ctxt, VCPU_REGS_RBX);
>> -
>> -		ctxt->eflags |= X86_EFLAGS_ZF;
>> -	}
>> +	if (!(ctxt->rex_bits & REX_W))
>> +		em_cmpxchg8b_16b(ctxt, 32, 64);
>> +#ifdef CONFIG_X86_64
>> +	else
>> +		em_cmpxchg8b_16b(ctxt, 64, 128);
>> +#endif
> 
> [Severity: High]
> Are we missing a 16-byte alignment check for the destination memory when
> executing CMPXCHG16B here?
> 
> The x86 architecture strictly mandates that the memory operand for CMPXCHG16B
> must be 16-byte aligned. If it is not, a #GP(0) exception is generated
> unconditionally.
> 
> Without this check, KVM will later attempt a native unaligned lock cmpxchg16b,
> which will raise a host #GP(0). The host exception table catches this and
> returns -EFAULT, translating to X86EMUL_UNHANDLEABLE, which immediately
> crashes the VM via KVM_EXIT_INTERNAL_ERROR. Can this regression be used by a
> guest to trigger a denial of service?

insn_alignment checks for any alignment issues. Its comment explicitly
mentions that

"Also included is CMPXCHG16B which is not a vector instruction, yet it
is subject to the same check.  FXSAVE and FXRSTOR are checked here too
as their 512 bytes of data must be aligned to a 16 byte boundary."

Hence kvm will raise an #GP(0) to guest before it performs cmpxchg8b.

Thanks
Sairaj

> 
>>  	return X86EMUL_CONTINUE;
>>  }
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 79468ddfe4736..60be16f05d794 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
> 
> [ ... ]
> 
>> @@ -5311,6 +5311,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
>>  	case 8:
>>  		r = emulator_try_cmpxchg_user(u64, hva, old, new);
>>  		break;
>> +#ifdef CONFIG_X86_64
>> +	case 16:
>> +		r = emulator_try_cmpxchg_user(u128, hva, old, new);
>> +		break;
>> +#endif
> 
> [Severity: Critical]
> This is a pre-existing issue, but does the emulation of atomic CMPXCHG suffer
> from a TOCTOU race leading to silent data corruption in the guest?
> 
> When emulator_try_cmpxchg_user() fails due to concurrent memory modification,
> emulator_cmpxchg_emulated() returns X86EMUL_CMPXCHG_FAILED.
> 
> However, in x86_emulate_insn(), this failure appears to be silently swallowed:
> 
> arch/x86/kvm/emulate.c:x86_emulate_insn() {
>     ...
>     if (rc == X86EMUL_CONTINUE)
>         writeback_registers(ctxt);
> 
>     return (rc == X86EMUL_UNHANDLEABLE) ? EMULATION_FAILED : EMULATION_OK;
> }
> 
> Because rc is not X86EMUL_CONTINUE, writeback_registers() is skipped and the
> guest registers are not updated. Because EMULATION_OK is returned, KVM retires
> the instruction as successful, advancing RIP and leaving the guest with a
> stale ZF=1 flag. Doesn't this cause the guest to mistakenly believe it
> acquired a lock?
> 

