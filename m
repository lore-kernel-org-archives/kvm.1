Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87B224B1E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875822; cv=none; b=AYuVp4UQ2gA1/6baIPCODV857V4xa3ShGOrfLx046WhiPSlgB2ifJBW54u/tbKTLcAJe+Pu6sSOHaHkwLZd2rX2Il1ji2u+0qcuSBVXHswGs39FBThOQNSracyRowlYf9jL0CQXv1ErfOMrCFfV5hWMB7ZVPZg6N+3DMnEXDl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875822; c=relaxed/simple;
	bh=mPfE5COvL/4kniYRUGLFCnJupgzhu9P7lYQWzKpy3Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQsVnE7Ba5cojKWlv3A0oXhDZ+m1IY3bcCRzosBah5ZyxYy1OhSccDrVZd4b2bPnMQ5Y3TqFzMoYca1l3qv8mo7YlvYIHL/CdYrl33D2fbD5YADwDGpuee81bBsForQdAO2HuUkfJWLMemG81OsgE88D9UIKZvP7qIyaWrHAWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ldi3VX3C; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ldi3VX3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lWwRiyO3VXhd18jZXfAb9P+Z2tKbPqiqyunsPVI7yEQ=;
	b=ldi3VX3CJQFy81UopRhWjA4CPvinOkbZ7/Gq2VTjhssR6w6beqm9uTEpbIaq8O
	yKLItFglJfkC/fmU8WN/TkqNaqRdDb1ctwf2HGrTjm4VpJg2ST8P29fBII0OzwTa
	ihC1l9QpZm2x5AuL7fq+jm5FnTditJ8PWYHXWglUhp0aE=
Received: from [10.42.12.49] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCnEJMdC2NqghdIKQ--.22734S2;
	Fri, 24 Jul 2026 14:50:05 +0800 (CST)
Message-ID: <d6c5a945-219f-42af-a707-c46a90d7f146@163.com>
Date: Fri, 24 Jul 2026 14:50:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry
 allocation
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260716073756.44153-1-min_halo@163.com>
 <20260716075510.B14BE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <20260716075510.B14BE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnEJMdC2NqghdIKQ--.22734S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF13Gr4UWr4kZw1rXFW3trb_yoWrKF1UpF
	WrGayDtws5Kr97t3s7ZF4kJr18Aa1rWFy5Gry5CFy5Wan8Xw1Fvr43trWj9FWkCrnY93WI
	vr4jgFWvvF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zROyCLUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0R096GpjCx1a3QAA3B


在 2026/7/16 15:55, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Silent drop of critical guest TLB flushes when the shared memory queue is full
>
> Pre-existing issues:
> - [High] Unsafe usage of this_cpu_ptr() in preemptible context leads to lost TLB flushes and data races
> - [High] TOCTOU race and memory ordering violation in NACL shared memory update
> --
Thanks for the review. Let me address the three points:

1. Silent drop on queue full:
The pr_warn() + return fallback was introduced in the original commit 
d466c19cead5
("RISC-V: KVM: Add common nested acceleration support"), but it was dead 
code
until now because try_count was never decremented. The primary purpose 
of this
patch is to fix the soft lockup; making the fallback reachable is the 
direct
consequence of fixing that bug.

A host kernel hang is strictly worse than a dropped hfence entry. 
Furthermore,
the entire hfence execution pipeline (__kvm_riscv_nacl_hfence and the
kvm_riscv_local_hfence_* family) returns void, meaning no error-propagation
path exists today. Rethinking the error-handling guarantee for HFENCE is a
broader API redesign that should be handled separately.

2. TOCTOU / Memory Ordering & 3. Preemptible this_cpu_ptr:
Both are pre-existing issues (as noted by the bot) and are neither 
introduced
nor modified by this single-line fix. They are valid concerns that deserve
their own standalone patches to keep this soft-lockup fix minimal and 
backport-friendly.

I will follow up with separate patches for the pre-existing issues if 
needed.
> --- Patch [1]: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry allocation ---
> commit 30204e283205d026c21e76906b9dab006ad09704
> Author: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> KVM: riscv: Fix infinite loop in NACL hfence entry allocation
>
> try_count is initialized to 5 but never decremented in the retry path,
> making the if (try_count) check always true. If all NACL shared memory
> hfence entries remain in the pending state after sync, the function loops
> forever, causing a soft lockup. Decrement try_count on each retry so the
> fallback warning and return become reachable.
>
>> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
>> index 08a95ad9ada2c..54a0158bd38a9 100644
>> --- a/arch/riscv/kvm/nacl.c
>> +++ b/arch/riscv/kvm/nacl.c
>> @@ -33,7 +33,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>>   	}
>>   
>>   	if (ent < 0) {
>> -		if (try_count) {
>> +		if (try_count--) {
>>   			nacl_sync_hfence(-1UL);
>>   			goto again;
>>   		} else {
> [Severity: High]
> Does this silent return leave stale translations in the hardware TLB?
>
> By making the fallback return reachable when the queue is full:
>
> 		} else {
> 			pr_warn("KVM: No free entry in NACL shared memory\n");
> 			return;
> 		}
>
> the caller is unaware the flush failed. Missing a mandatory guest TLB flush
> violates core memory management invariants and could allow the guest to
> access invalid physical memory.
>
> Should KVM propagate an error to userspace or fall back to a synchronous
> local flush instead of silently discarding the request?
>
> [Severity: High]
> This is a pre-existing issue, but could the subsequent write sequence cause a
> TOCTOU race with the L0 hypervisor?
>
> Looking further down in __kvm_riscv_nacl_hfence():
>
> 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> 	*entp = cpu_to_lelong(control);
> 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
> 	*entp = cpu_to_lelong(page_num);
> 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
> 	*entp = cpu_to_lelong(page_count);
>
> The CONFIG field, containing the SBI_NACL_SHMEM_HFENCE_CONFIG_PEND flag,
> is written before the PNUM and PCOUNT payload fields without any memory
> barriers.
>
> If the compiler or a weakly ordered RISC-V CPU reorders these writes, could
> the L0 hypervisor read the PEND bit while the payload is incomplete, leading
> to incorrect or missing TLB invalidations?
>
> [Severity: High]
> This is a pre-existing issue, but does the TLB flush processing happen while
> preemption is still enabled?
>
> Looking at kvm_arch_vcpu_ioctl_run() in arch/riscv/kvm/vcpu.c:
>
> 	ret = kvm_riscv_check_vcpu_requests(vcpu);
> 	if (ret <= 0)
> 		continue;
>
> 	preempt_disable();
>
> If kvm_riscv_check_vcpu_requests() processes TLB flushes via
> kvm_riscv_hfence_process(), it resolves the shared memory pointer using
> nacl_shmem(), which relies on this_cpu_ptr().
>
> If the VCPU thread is preempted and migrated to a different physical CPU
> immediately after the pointer is resolved, will it write to the old CPU's
> memory and cause lost TLB flushes?
>

