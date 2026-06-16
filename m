Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF04369211
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619312; cv=none; b=A7dWM6QZzi23NEqGa0WxxojWuJCD7KRSVT9zJWJHtdInOJjfQF4+0xz1nhWqfiiLeQciz1Rynhgpq6TIYP2rUIf2K0xcdNDj8FaRzu4uk5qjz7SU3Mmp7fzlse3NubWFYEP38gN2O41vXlFtv0t/CBEqTaCHs7PG2COTRGDs60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619312; c=relaxed/simple;
	bh=uiQDbcf0aT5w+Afx/p+EuRgxXAqzqXWGjMT6GSV9b2U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o3hZhs8jINHc9VLNv83NAf/bUa1eVorwE6yjNpMYdKZHrZV/ARqBF6gRFOMdYR4aP9MrBiQBQzQJNvQIxwCCEuCfgPEbebVvYUlsL2QGFuLrWNCboiTcGOBybbu5N/c+qFUa/XKjlarn7ca+skvjpn8XwLe7qebcmHv6hsIC41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6yIluMe; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6yIluMe"
Message-ID: <b359f414-efb6-4204-96fe-0690e0d92d6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781619299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoFnPCp9ysZH1cuDgoFgBBe67UyEoQFP/n6AHwL/O0w=;
	b=J6yIluMe8KKnS2sh5gRClySxSVtH+CdIz3Q6rpUysjzdOvQKwtT1NT2GdPAmSEIqlpFOBc
	KveZMBvfMU05rbeKTdXGbqJWh082vLOyEwEvYDj3q6Ng4AUulj2nLmLDQ97CiU+a/A7Cis
	zeSVyzIG4+OguobxzCXph+fUYg1DOzc=
Date: Tue, 16 Jun 2026 22:14:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kernel@xen0n.name, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Add PV TLB flush support via
 steal-time shared memory
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-2-cui.tao@linux.dev>
 <7bb86447-c5d3-7a81-5578-b1ac2419fa32@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <7bb86447-c5d3-7a81-5578-b1ac2419fa32@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bibo,

Thank you for the review.

You're right, and honestly I didn't think the
error path through carefully enough here.

The current handling leaves the preempted byte uncleared and skips the
flush, which is exactly the cascade you described: a vCPU re-entered on
the error path keeps running with the bit set, so later flushes keep
deferring it and its TLB stays stale until some later entry happens to
succeed. A stale TLB is a correctness issue, so this path needs
conservative handling even though the fault itself is rare.

I'll drop the VPID on error so the TLB is flushed conservatively and the
logic self-heals:

    if (err) {
        vcpu->arch.vpid = 0;    /* be conservative: flush anyway */
        goto out;
    }

The byte isn't cleared on the fault, but the TLB is clean this round;
the next successful amand_db.w reads the still-set FLUSH_TLB bit and
flushes again (redundantly but harmlessly), then clears the byte. The
same covers the unsafe_get_user() priming-load failure.

I'll fix this in the next version.

Thanks,
Tao

在 2026/6/16 09:03, Bibo Mao 写道:
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -173,7 +173,39 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>>       }
>>         st = (struct kvm_steal_time __user *)ghc->hva;
>> -    if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
>> +    if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
>> +        u32 old = 0;
>> +        int err = 0;
>> +
>> +        /*
>> +         * Prime the cache line with a normal load before the coherent
>> +         * atomic below; it was observed (when the line was last dirtied
>> +         * by another core) to be needed for amand_db.w to see a current
>> +         * value.  amand_db.w overwrites `old` with the real pre-AND value,
>> +         * so this load contributes only its cache side-effect.
>> +         */
>> +        unsafe_get_user(old, (u32 __user *)&st->preempted, out);
> If there is a failure, it does nothing and go to out directly, however guest TLB remains stale without flush operation.
>> +
>> +        /* Atomically read and clear the preempted byte via amand_db.w. */
>> +        asm volatile(
>> +        "1: amand_db.w %1, %3, %2    \n"
>> +        "2:                \n"
>> +        _ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)
>> +        : "+r" (err), "+&r" (old),
>> +          "+ZB" (*(u32 *)&st->preempted)
>> +        : "r" ((u32)~0xffu)
>> +        : "memory");
>> +
>> +        if (err)
>> +            goto out;
> Ditto, if there is error, guest TLB is not flushed and vCPU continues to run with preempted bit set. The next TLB flush will be skipped with this vCPU since its preempted bit is not clear.
> 
> Regards
> Bibo Mao
> 

