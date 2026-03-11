Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878843D88EF;
	Wed, 11 Mar 2026 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227927; cv=fail; b=ZuyQfPDHvzw+hhqoKvsjR9YNWzWxVLp23srEaPBIsd4UgeShBGMtt0qQirSlPTQ+NCG7gXvRTWxBNrGi4NWOlZIAzXNj1GQ4c5cNP2kQADiX5pqPEHXoPa1kEocWjv+IOnoE75uFcCRcaCnh5DdSK49ZPSlo4ykgX6q7XOEOU24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227927; c=relaxed/simple;
	bh=mMwVcp7aTFyhKbWa7ixu/Vu4Pnc+vVGYWmYLZCdxRMA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LWDknEqBaP6XTnQh5Fp44TBCh/+HHPJhfEBa+hI80cwivxii/TJShrpUCYP5RHfOAVPG8n2dEX+bzBVtu9i+oaD1/maNaVqq7HpTxiLdOwmHE0SQnXVXBsREUPZ1DwytOcl+hRCS/oNbgVm8IlPXamkbMORMik1JCT63k5aYdkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=liB+UAHt; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="liB+UAHt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crRHNPp99mxgmmh0baHGJ1kLrOy1rqGxUajchkBeGrMFziwXxUomyZar2jBTm1VK82XaFsQUm0dF67Ro95owhn6fuAITn6x4jZBv4CqeT7OPo8kLChcrw4vUb+yaR3dt4LSjFHDIAnYm7rXqJ1PrrbuY1/5q7Q8I8yJ77+9vWI7+ZIDi275NchkdW3emHe2/uymV4o10ByQ+sWewhaWvRK9sPTj5IDJXz8/+sNIkUGxROBNoub6yZKbJDzigfHGyxuMzZnP355PoqV7PiF3x0TCoxPVh+uo1GhtmPRg6YMapkZ4OnxrnrLvNV+efAa2EiICXNCnJ5/RCKyQc6Kfzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACNtZvRAuMBeiBHEmrFBFX/XNXbozaPecIDjMARI+gI=;
 b=m7hk2bBdoY7h0k8FIogz/f6EzJMz8tNsDBCh2YGmINz/4XsKOBPhS1Sjw0iNiM7PwRmyw/TBkSkybn6kqfTlGKlP3UMPkSdJahaoZojRCdqDyop8x1W/c88CmJSK5u+pp8TaOTp5k0K6Vt9BXnBugRqG9smXlV3IartucTxG2v2JPrsRyy7SyzMxwmLrZA9V6w8THfd7dCJzbjN+WHIpTFJ8jDSTzabyv4/9sUHCTq1f6KkLwYEOKUMUuP+TV1UDVXsOaSo550DcEyn4UShWRGi/pwHIE32pLRUfV5hxMDchm13d08SplKF5mD5xu/WfHZtzzL3z2mdSbiU3NB24UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACNtZvRAuMBeiBHEmrFBFX/XNXbozaPecIDjMARI+gI=;
 b=liB+UAHtZfp8qokpwh2Sv4YCmn6yO+bxjSR8ANRTFFoW2Vbo7FIkLCXSZ4IKQrV2oClGqY2Q/LZLceWpIumDJOIe/98oKJJXhfWx/MFAVBh72+6uk7B69dAC/T+UdRLlo5i/R5gMJd3KK/tfIQyCMuLqosks0dW4NLXc/yWfvTw=
Received: from CH0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:610:11a::22)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 11:18:35 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::a8) by CH0PR03CA0331.outlook.office365.com
 (2603:10b6:610:11a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 11:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 11:18:34 +0000
Received: from [10.143.201.55] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 06:18:30 -0500
Message-ID: <69dde1be-dd3f-454d-9b5e-a27cb67b9936@amd.com>
Date: Wed, 11 Mar 2026 16:48:27 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<nikunj.dadhania@amd.com>, <Manali.Shukla@amd.com>
Subject: Re: [PATCH] KVM: x86: Add support for cmpxchg16b emulation
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260306102047.29760-1-sarunkod@amd.com>
 <aar082uQQhXKNiSQ@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <aar082uQQhXKNiSQ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c9c36e-6c24-48c8-5b1d-08de7f5fef7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|30052699003|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qotjMr741GdfV30UsxBCYNjYdHzAnb7qVCJpjEYFvwKLz0bnIiIBqIDhvZGgQSnweB8eU+DOeElb/EOGoGJjOA32OcnGgKPdVoHSLP5Xls/wBpwNiZznANv963rvM/ncNh0TrmMXEoFicaxxtgqO+H3p/ZwiF7QxnFKemCP6jFwZm2EH3tqVzKOkV0rRIqbFp5GX7IKr+8NtQGhrpK8pjTS3dU8KXoNG9E4kSuHbNe6BjRNXaEmbYeo+vJ6y1JlEvdttgu+F0HN0kNxuIZs5JZwAEp3sARn8/phav5Q2LQ2GSxs6QsqKU2IuJyCttzXzdlqKCJZK7NCoBHU0c6qG6b5E30gXf5DYzjmSjd8H6o7DduC0guB0n/O4KTynpjE9TDRrGPXi4PaSKhu540+OeSaqlFf/JNDdfkRy3Bd4j0/0N2t/lgPML9hJXyN03ayRWcm4GByjbYioUY7ldfC0GefqzXOal2mrT97ZF20/QfKmFoa+J7TSYlsOIYdlKM0oL6UxwlkkG7Ysi9kl4BJsO2op3BXihCeKgkHu/Mm6gI+Q3F5BKX1C+ep+eSA6sBs0x4Tlmj2QdkIrIsz6JEsOimlu3odnpo3OfI7FZLN+8aJTL4bCVD4ZT969DkSgq0iEeAI5VVCQEomPzbC3h8uSwaBVRUm/EmgaU+0cRAyB4Oo79s0KviRHEx6jOhw0+2NLD1Kai5ZaVjwPaYR7khA+hXqsDuADDUUr0ff9ODxeSac=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(30052699003)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cgx3ROCFzg+4+tWTfNt+b1FS/nOp5aXK56rgwkNvttiDonwf6kZFVs7oWGdFhRvRI5g1OpU+2qxsg5xqzE2hYOF5BA/aM8/8aBOcrPDTrqZShmXe3MgJUT2ApqgMgBu0CjbdI6OCkyffwC2qrXE3kTzuH8Z7LwyUYzAqHHhef/xbKPoOBmxAnbO1m+5s96JGOg8Zy8vL8cV7qM8D4KcDgRQacJKVEou5gs3VwZUnCU/HtzkVAZrRCRT2pgDQPIyqtOdAq9sgTaKoCsmynqLgMoyEqQrjGy90e29344pw1TSZS0WVzjp76mWRnd4KAgVDW6ihlDnQ96CISdu+kVEoitkjsQoZshEWzqhBQ/sOH7SLWi8pXo51fRj/rn6bcqB3c312icqUfyvPWvNTmjT9kQE0bGOhyxbdYF5OedZvjU1wWaQf6S0woamI29WPt5O+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 11:18:34.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c9c36e-6c24-48c8-5b1d-08de7f5fef7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878



On 3/6/2026 9:08 PM, Sean Christopherson wrote:
> On Fri, Mar 06, 2026, Sairaj Kodilkar wrote:
>> AMD and Intel both provides support for 128 bit cmpxchg operands using
>> cmpxchg8b/cmpxchg16b instructions (opcode 0FC7). However, kvm does not
>> support emulating cmpxchg16b (i.e when destination memory is 128 bit and
>> REX.W = 1) which causes emulation failure when QEMU guest performs a
>> cmpxchg16b on a memory region setup as a IO.
>>
>> Hence extend cmpxchg8b to perform cmpxchg16b when the destination memory
>> is 128 bit.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>> Background:
>>
>> The AMD IOMMU driver writes 256-bit device table entries with two
>> 128-bit cmpxchg operations. For guests using hardware-accelerated
>> vIOMMU (still in progress), QEMU traps device table accesses to set up
>> nested page tables. Without 128-bit cmpxchg emulation, KVM cannot
>> handle these traps and DTE access emulation fails.
> Please put this paragraph in the changelog proper, the "why" matters greatly here.

Sure.

>> QEMU implementation that traps DTE accesses:
>> https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8_amd_viommu_20260106/hw/i386/amd_viommu.c#L517
>> ---
>>   arch/x86/kvm/emulate.c     | 48 +++++++++++++++++++++++++++++++-------
>>   arch/x86/kvm/kvm_emulate.h |  1 +
>>   2 files changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index c8e292e9a24d..e1a08cd3274b 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -2188,17 +2188,18 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
>>   	return rc;
>>   }
>>   
>> -static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>> +static int __handle_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>>   {
>> -	u64 old = ctxt->dst.orig_val64;
>> +	u64 old64 = ctxt->dst.orig_val64;
>>   
>> -	if (ctxt->dst.bytes == 16)
>> +	/* Use of the REX.W prefix promotes operation to 128 bits */
>> +	if (ctxt->rex_bits & REX_W)
> Uh, yeah, and the caller specifically pivoted on this size.  I'm a-ok with a
> sanity check, but it should be exactly that, e.g.
>
> 	if (WARN_ON_ONCE(8 + (ctxt->rex_bits & REX_W) * 8 != ctxt->dst.bytes))
> 		return X86EMUL_UNHANDLEABLE;

Sure I'll update it.

>>   		return X86EMUL_UNHANDLEABLE;
>>   
>> -	if (((u32) (old >> 0) != (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
>> -	    ((u32) (old >> 32) != (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
>> -		*reg_write(ctxt, VCPU_REGS_RAX) = (u32) (old >> 0);
>> -		*reg_write(ctxt, VCPU_REGS_RDX) = (u32) (old >> 32);
>> +	if (((u32) (old64 >> 0) != (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
>> +	    ((u32) (old64 >> 32) != (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
>> +		*reg_write(ctxt, VCPU_REGS_RAX) = (u32) (old64 >> 0);
>> +		*reg_write(ctxt, VCPU_REGS_RDX) = (u32) (old64 >> 32);
>>   		ctxt->eflags &= ~X86_EFLAGS_ZF;
>>   	} else {
>>   		ctxt->dst.val64 = ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
>> @@ -2209,6 +2210,37 @@ static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>>   	return X86EMUL_CONTINUE;
>>   }
>>   
>> +static int __handle_cmpxchg16b(struct x86_emulate_ctxt *ctxt)
>> +{
>> +	__uint128_t old128 = ctxt->dst.val128;
> There is zero chance you properly tested this patch.  Please write comprehensive
> testcases in KUT's emulator64.c before posting the next version.
>
> In writeback(), the OP_MEM case quite clearly operates on "unsigned long" values
> *and* consumes orig_val in the locked case.
>
> 	case OP_MEM:
> 		if (ctxt->lock_prefix)
> 			return segmented_cmpxchg(ctxt,
> 						 op->addr.mem,
> 						 &op->orig_val,
> 						 &op->val,
> 						 op->bytes);
> 		else
> 			return segmented_write(ctxt,
> 					       op->addr.mem,
> 					       &op->val,
> 					       op->bytes);
>
> And then emulator_cmpxchg_emulated() should be taught to do cmpxchg16b itself:
>
> 	/* guests cmpxchg8b have to be emulated atomically */
> 	if (bytes > 8 || (bytes & (bytes - 1)))
> 		goto emul_write;
>
> That might be a big lift, e.g. to get a 16-byte uaccess version.  If it's
> unreasonably difficult, we should reject emulation of LOCK CMPXCHG16B.

I think its not a too much of the work, I have a prototype ready which
implements cmpxchg16b access in uaccess.h. Tested with a KUT as well
seems to be working fine. Will post it once I cleanup the series.

> And this code would also need to be updated to copy the full 128-bit value.
>
> 	/* Copy full 64-bit value for CMPXCHG8B.  */
> 	ctxt->dst.orig_val64 = ctxt->dst.val64;
>
> Maybe something like this?  Or maybe just copy 128 bits unconditionally (I'm not
> sure if that could read uninitiatlized data or not).
>
> 	/* Copy the full 64/128-bit value for CMPXCHG8B/16B.  */
> 	if (IS_ENABLED(CONFIG_X86_64) && ctxt->dst.bytes == 16)
> 		ctxt->dst.orig_val128 = ctxt->dst.val128;
> 	else
> 		ctxt->dst.orig_val64 = ctxt->dst.val64;

Yeah thanks, I completely missed that cmpxchg with lock prefix
consumes original value. I'll update the code.

>> +
>> +	/* Use of the REX.W prefix promotes operation to 128 bits */
>> +	if (!(ctxt->rex_bits & REX_W))
>> +		return X86EMUL_UNHANDLEABLE;
>> +
>> +	if (((u64) (old128 >> 0) != (u64) reg_read(ctxt, VCPU_REGS_RAX)) ||
>> +	    ((u64) (old128 >> 64) != (u64) reg_read(ctxt, VCPU_REGS_RDX))) {
>> +		*reg_write(ctxt, VCPU_REGS_RAX) = (u64) (old128 >> 0);
>> +		*reg_write(ctxt, VCPU_REGS_RDX) = (u64) (old128 >> 64);
>> +		ctxt->eflags &= ~X86_EFLAGS_ZF;
>> +	} else {
>> +		ctxt->dst.val128 =
>> +			((__uint128_t) reg_read(ctxt, VCPU_REGS_RCX) << 64) |
>> +			(u64) reg_read(ctxt, VCPU_REGS_RBX);
>> +
>> +		ctxt->eflags |= X86_EFLAGS_ZF;
> IMO we should use a macro to handle 8b vs. 16b.  The code is going to be heinous
> no matter what, and so to me, duplicating everything makes it twice as ugly,
> whereas a macro makes it like 10% more ugly.
>
>> +	}
>> +	return X86EMUL_CONTINUE;
>> +}
>> +
>> +static int em_cmpxchgxb(struct x86_emulate_ctxt *ctxt)
>> +{
>> +	if (ctxt->dst.bytes == 16)
>> +		return __handle_cmpxchg16b(ctxt);
>> +
>> +	return __handle_cmpxchg8b(ctxt);
>> +}
>> +
>>   static int em_ret(struct x86_emulate_ctxt *ctxt)
>>   {
>>   	int rc;
>> @@ -4097,7 +4129,7 @@ static const struct gprefix pfx_0f_c7_7 = {
>>   
>>   
>>   static const struct group_dual group9 = { {
>> -	N, I(DstMem64 | Lock | PageTable, em_cmpxchg8b), N, N, N, N, N, N,
>> +	N, I(DstMem64 | Lock | PageTable, em_cmpxchgxb), N, N, N, N, N, N,
> Eh, I vote to keep it em_cmpxchg8b.  _If_ we want to capture that its size is
> variable, maybe em_cmpxchg8b_16b?  em_cmpxchgxb just looks like a typo.

Yeah ok, I was not sure how to represent variable size hence used the x.
Will rename it.

>
> Sans correct writeback() handling, something like so:
>
> ---
>   arch/x86/kvm/emulate.c     | 44 ++++++++++++++++++++++++--------------
>   arch/x86/kvm/kvm_emulate.h |  2 ++
>   2 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 6145dac4a605..3ec4555571fa 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2201,24 +2201,33 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
>   	return rc;
>   }
>   
> +#define em_cmpxchg8b_16b(__c, rbits, mbits)						  \
> +do {											  \
> +	u##mbits old = __c->dst.orig_val##mbits;					  \
> +											  \
> +	BUILD_BUG_ON(rbits * 2 != mbits);						  \
> +											  \
> +	if (((u##rbits)(old >> 0)     != (u##rbits)reg_read(__c, VCPU_REGS_RAX)) ||	  \
> +	    ((u##rbits)(old >> rbits) != (u##rbits)reg_read(__c, VCPU_REGS_RDX))) {	  \
> +		*reg_write(__c, VCPU_REGS_RAX) = (u##rbits)(old >> 0);			  \
> +		*reg_write(__c, VCPU_REGS_RDX) = (u##rbits)(old >> rbits);		  \
> +		__c->eflags &= ~X86_EFLAGS_ZF;						  \
> +	} else {									  \
> +		__c->dst.val##mbits = ((u##mbits)reg_read(__c, VCPU_REGS_RCX) << rbits) | \
> +				       (u##rbits)reg_read(__c, VCPU_REGS_RBX);		  \
> +		__c->eflags |= X86_EFLAGS_ZF;						  \
> +	}										  \
> +} while (0)
> +
>   static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>   {
> -	u64 old = ctxt->dst.orig_val64;
> -
> -	if (ctxt->dst.bytes == 16)
> +	if (WARN_ON_ONCE(8 + (ctxt->rex_bits & REX_W) * 8 != ctxt->dst.bytes))
>   		return X86EMUL_UNHANDLEABLE;
>   
> -	if (((u32) (old >> 0) != (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
> -	    ((u32) (old >> 32) != (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
> -		*reg_write(ctxt, VCPU_REGS_RAX) = (u32) (old >> 0);
> -		*reg_write(ctxt, VCPU_REGS_RDX) = (u32) (old >> 32);
> -		ctxt->eflags &= ~X86_EFLAGS_ZF;
> -	} else {
> -		ctxt->dst.val64 = ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
> -			(u32) reg_read(ctxt, VCPU_REGS_RBX);
> -
> -		ctxt->eflags |= X86_EFLAGS_ZF;
> -	}
> +	if (!(ctxt->rex_bits & REX_W))
> +		em_cmpxchg8b_16b(ctxt, 32, 64);
> +	else
> +		em_cmpxchg8b_16b(ctxt, 64, 128);
>   	return X86EMUL_CONTINUE;
>   }
>   
> @@ -5418,8 +5427,11 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
>   			goto done;
>   		}
>   	}
> -	/* Copy full 64-bit value for CMPXCHG8B.  */
> -	ctxt->dst.orig_val64 = ctxt->dst.val64;
> +	/* Copy the full 64/128-bit value for CMPXCHG8B/16B.  */
> +	if (IS_ENABLED(CONFIG_X86_64) && ctxt->dst.bytes == 16)
> +		ctxt->dst.orig_val128 = ctxt->dst.val128;
> +	else
> +		ctxt->dst.orig_val64 = ctxt->dst.val64;
>   
>   special_insn:
>   
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index fb3dab4b5a53..0e9968319343 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -255,6 +255,7 @@ struct operand {
>   	union {
>   		unsigned long orig_val;
>   		u64 orig_val64;
> +		u64 orig_val128;
>   	};
>   	union {
>   		unsigned long *reg;
> @@ -268,6 +269,7 @@ struct operand {
>   	union {
>   		unsigned long val;
>   		u64 val64;
> +		__uint128_t val128;
>   		char valptr[sizeof(avx256_t)];
>   		sse128_t vec_val;
>   		avx256_t vec_val2;
>
> base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
> --

Thanks
Sairaj
