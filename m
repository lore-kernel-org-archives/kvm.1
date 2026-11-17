Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959438;
	b=rPYrhuaggU2PS2v/npSdp7wT4azLoGwSeK0sQCol7gO+e7hNvXU1p2iXel093nFPXZmy
	 vNPwZcUKsPS0bC3oF/POMHtF20b6NjxFT9AXjN++te1ifWOB9wUH+Q1JcGUuXMiKuALDV
	 VRNta2Sx5c5kMeBFWSREdUuGkoMbNQkkOsapEJdjL5IpyCPnqjufm5/xI77s7CsHkXDKM
	 5sM496+qHGdVUUSxgyJo739bYI1i8zhtbcdp2e3HxoVbo89zm9t5IBEv2vl+DmM2jz82L
	 KHQh6WBOs7JRKx73zsANJrANaejjgaYATEKJD4tk6tgVK8Zj4ogDr7TH8X/v7pTgb+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6YCN415HfGSWGfj0hnTG5tobjSWA0w1qx2azX15hpbc=;
	b=XJb5kY9Vw8GwXQrfP/JFpAY4polDhK5bwtmaJe2RPBgPH451CVVLwAK3O/SosSIwbV4r
	 222N11xMOLWW4tAO+bYNjAEjnEbGKYVk9s9l5OGCOfqGC20oytsDOFGzEE1Zf4R1wTKkq
	 K94D0GCH7ovewi4zl5plnl5d5ZMSMYbDKNrCA31FhdSzIuztmciMU4NjDJft+EEaFXigJ
	 RetfRXL+APydsWFJdkaka9e+ajVk8pIvCHvnMVgVUDOQta6GRxaO7xpTZDUdUncmZS+xi
	 797ATO9Nu1BYjxbSvl7fsWuOm8pAC4mPe/i6YhgfJlR7ZLw2sragQO/MrNcwFVBZHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J90E0CXK;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D022606A331
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 23:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D022606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J90E0CXK
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so282015a12.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794959437; x=1795564237; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6YCN415HfGSWGfj0hnTG5tobjSWA0w1qx2azX15hpbc=;
        b=J90E0CXKuEfxl/3Iz0OXmvEMZpfBfG/M8fdH3I0t996+DyvA4qNYEPpwjyyEcw4izB
         Dm1v5/7xbobHzZdVUUvTmt8rHaykTDJl6IzS0j2LQhlcKNmygDCOHiy8YBUs+1nZ01Ur
         NSeie6Ywff+3E9XOLJHr8rBq+/Yn5RDKL+RyzKENPKF6REGF3T4SHhxtZkL00Kr7IANB
         eochaIfCbeShPk9iaewk6mlWQzzsqSoXg7WriPKUZ9DRh3euwKmXmkj1Eg0pJ5OGDzvK
         zy/D/IixIooD1/oSD+t/R504qU+uPxcmcO196319hk6OxCBsKziWIMHpDqTDQe0P0U80
         Z7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959437; x=1795564237;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6YCN415HfGSWGfj0hnTG5tobjSWA0w1qx2azX15hpbc=;
        b=zmucGPTerKp0uu04WFSX1GRLmcoonowBkJCT2suhr2Os89LDgNl1hpKgigq23HL0hH
         whPR9Xmabi7P/XZoy2c6a4qrvxBdjqVJ7oRdM9VZxot4RIQr3Bz8sK/Lo0N2ehXwUx65
         GA13OQrNxAvLE2nmNMxiCMUNUldOIQdL/kH3JgYq+hSc92HvWfPbQI4ni2uwVGHuMouy
         BPLB+wIm7vix9Op7hKrvnZs3xy0JbkgYPTkTFn+B0ZezlxdAXWfMox/XL7g70icgketY
         oL23k74mtIKsRSjBa7pU6lhQEQXD8nnmCZRifC6FqauB6gnyj3FDq/taXu7SrjhzrnBS
         dH4g==
X-Gm-Message-State: APuU4Z+2y6/UZf6z+8fATytTHr5RNpSo9miMKpVurMxf06MgkdkoTCVa
	mmnxxrwUiM5B0OwO7HAY8gmv/72raZuxF0XEbSz+fxUOrbLA3zhNb7YevmGvYQk7nZh6gXqbKk1
	UPWAxTQ==
X-Received: from pgfv11-n1.prod.google.com ([2002:a05:6a02:874b:10b0:cd8:b4f6:1c8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1493:b0:3e8:b7fd:628f
 with SMTP id adf61e73a8af0-3fe890efb36mr911730637.22.1794959436641; Tue, 17
 Nov 2026 15:50:36 -0800 (PST)
Date: Tue, 17 Nov 2026 15:50:35 -0800
In-Reply-To: <sashiko-outbox-219682@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117205428.3717-1-seanjc@google.com> <sashiko-outbox-219682@kernel.org>
Message-ID: <avzoSx9ukQecCGq-@seanjc-mac.roam.internal>
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls
 for non-waiting requests
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Oliver and Marc,

FYI on what I think is a pre-existing TLB flush bug (that can affect other
requests as well).

On Tue, Nov 17, 2026, sashiko-bot@kernel.org wrote:
> KVM: Send reschedule IPIs instead of SMP function calls for non-waiting requests
> 
> This commit sends a reschedule IPI to each target vCPU instead of batching
> IPIs via smp_call_function_many() when making non-waiting multi-vCPU
> requests, allowing non-waiting requests to be made with interrupts disabled.

...

> [Severity: High]
> Can a non-waiting request in interrupt context clobber the per-CPU
> cpu_kick_mask of an in-progress waiting request on the same CPU?
> 
> kvm_make_all_cpus_request() and kvm_make_vcpus_request_mask() only disable
> preemption via get_cpu() while building cpu_kick_mask, leaving interrupts
> enabled for waiting requests, and still clear and populate cpu_kick_mask
> even when KVM_REQUEST_WAIT is not set:
> 
> virt/kvm/kvm_main.c:kvm_make_all_cpus_request() {
> 	me = get_cpu();
> 
> 	cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
> 	cpumask_clear(cpus);
> 
> 	kvm_for_each_vcpu(i, vcpu, kvm)
> 		kvm_make_vcpu_request(vcpu, req, cpus, me);
> 
> 	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
> 	put_cpu();
> ...
> }
> 
> If an interrupt fires mid-loop and makes a non-waiting multi-vCPU request
> (for example on arm64 via irqfd_wakeup() -> kvm_arch_set_irq_inatomic() ->
> ... -> vgic_queue_irq_unlock()):
> 
> kvm_flush_remote_tlbs()
>   kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)
>     cpumask_clear(cpus)
>     kvm_make_vcpu_request(vcpu0, ...)
>       kvm_vcpu_exiting_guest_mode(vcpu0)
>         cmpxchg(&vcpu0->mode, IN_GUEST_MODE, EXITING_GUEST_MODE)
>       __cpumask_set_cpu(vcpu0->cpu, cpus)
>     <hardirq>
>       irqfd_wakeup()
>         ...
>           kvm_make_all_cpus_request(kvm, KVM_REQ_IRQ_PENDING)
>             cpumask_clear(cpus)  <-- wipes vcpu0->cpu from cpu_kick_mask
>             kvm_make_vcpu_request(vcpu0, ...)
>               kvm_request_needs_ipi(vcpu0, ...)  <-- false (EXITING_GUEST_MODE)
>     kvm_kick_many_cpus(cpus, true)  <-- misses vcpu0->cpu
> 
> Because the outer request already transitioned vcpu0->mode from
> IN_GUEST_MODE to EXITING_GUEST_MODE, the nested non-waiting request sees
> mode != IN_GUEST_MODE and neither sends a reschedule IPI nor re-adds
> vcpu0->cpu to cpu_kick_mask.  When the interrupt returns,
> kvm_kick_many_cpus() skips kicking and waiting for vcpu0, so the waiting
> request (such as a remote TLB flush) can complete while vcpu0 is still in
> guest mode or reading shadow page tables.
> 
> Only touching cpu_kick_mask when KVM_REQUEST_WAIT is set (and tracking
> whether any CPU was kicked with a local boolean for the return value)
> would avoid this.

Unless I'm misreading this, clobbering cpu_kick_mask and dropping the kick for
a waiting request is a pre-existing bug.  I'll address this in v2, and make sure
the series is tagged for stable@.
