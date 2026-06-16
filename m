Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED543A8FE6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622522; cv=none; b=ohnSVOqDjixvpcUdXreLic0RR6XuyQzyYqWviQUUbrxf21zQUjib/FERJT9L0FplJCChtOE/dwAezk3yDE1A0CQ9RHP0vADW/44uiZECNjfjYYG50raaJy1jI06KMRRWZqj9erSatNOUArj+fv1gICDdx2G6LE2YI93foSA0gW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622522; c=relaxed/simple;
	bh=mir7lQ9ByqN2nifHSt6sAIYbYjvEKeEYA5Do7POwxZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BW0+x2HfGOJ+tG8D0fbSoVlAZDk4SO35fBv77210n0FaRGVBun6QyPWQJlmaymJQ6LW9BT172OuZiDe2rcpkVbpjDJlOmy5Ntgr4XSnCCIb22vSJeHcYKNF5ZPkvxtJbuYQNjNbyI7sJBfykPlUmgv/bIC2NHL4WHx18Kb2Sqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5fXVlyh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5fXVlyh"
Message-ID: <1bfa4941-b94b-410a-9b64-c13f2712edf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781622509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qi5Ric3fS1uSNx65BlDQd+25gkfQEYc/OF/he0FlxQ=;
	b=g5fXVlyhOXpYm9mHwBPDPubqtRsxZZehF4xFU8OM/g3EvLNujya/KCIDxRqdYnaMp0ZGXP
	xnSY3iIL/ggkIaOzQWhxPHhMVixhyF2iPpNaQcej9IcDQnFTYlntzpyXFtm1wJK4GeOYmH
	ngV9bflxpofTiQkrvTDdN492Tk3kReE=
Date: Tue, 16 Jun 2026 23:08:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kernel@xen0n.name, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Implement guest-side PV TLB flush
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-3-cui.tao@linux.dev>
 <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Bibo,

That's really kind of you. I'd really value the chance to work with you.

在 2026/6/16 09:14, Bibo Mao 写道:
> 
>> +            __cpumask_clear_cpu(cpu, flushmask);
> is it possible that vCPU is running however with KVM_VCPU_PREEMPTED set?

It shouldn't happen with a correct host: the bit is set on vcpu_put
(preempt) and cleared on entry through kvm_update_stolen_time(), so a
running vCPU always has preempted == 0. The guest-side race is closed by
try_cmpxchg(). If the host clears the byte between the guest's READ_ONCE
and the cmpxchg, the cmpxchg fails and the CPU stays in the IPI mask, so
no flush is missed. The only thing that can break the invariant is the
error path from patch 1, which the conservative handling there closes.
Point taken though: the design's correctness rests entirely on the host
honoring this, so I agree the patch-1 fix is necessary rather than
optional.

>> +    }
>> +
>> +    on_each_cpu_mask(flushmask, func, info, 1);
> LoongArch VM does not support post interrupt now, IPI with vCPU will trap to hypervisor.
> 
> There is another PV TLB flush method using hypercall like PV IPI, which will make a request with wait flag such as KVM_REQ_TLB_FLUSH and kick vCPU.
> 
> With this PV TLB flush method, there is not IPI interrupt in VM, and wait is handled in hypervisor, the negative effect is that it flushes all TLBs.
> 
This is the point I most want to get right, and you're correct. Since
LoongArch has no posted interrupts, an IPI to a *running* vCPU still
traps, so the steal-time path only genuinely helps for preempted/idle
vCPUs; for running ones it's no better (a little heavier) than a plain
IPI. The hypercall approach (analogous to our PV IPI) would avoid
in-guest IPIs entirely, at the cost of a full TLB flush and
hypervisor-side wait handling.

Rather than argue from intuition, I'd like to try the hypercall approach
you suggested and measure the performance improvement against the current
path. I'll share the results with you once the testing is done, so we
can decide the direction based on the numbers.

> FYI, another PV TLB flush method in arch/x86/hyperv/mmu.c ...

Thanks for the pointer. The Hyper-V path is a pure hypercall: the guest
hands the hypervisor the address space, an address-range list, and the
target VP set, so the flush stays fine-grained instead of nuking the
whole TLB. That's a good template if the numbers point us toward a
hypercall-based design.

Thanks,
Tao

