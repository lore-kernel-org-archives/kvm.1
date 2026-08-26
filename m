Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7652FE057
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785980; cv=none; b=MgxqsyEmzrQ1cPi/7s/6kIQkV0L4zB6yDKjjjIQcuMDifPpZjFZqUALWyp1w1QmdwMiBzYzu+5jMCjZm/C83sD2qQ27KODILxH6V5edE/crU+JMMFeh2LxEiQcw+a2rsMv68tciGmIePZPLXuzgpEy7jXS2+d2MZfUSoNkbVepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785980; c=relaxed/simple;
	bh=qbGr9VktsBaf+vy8z6z3s9vDcM1MW8seVhk+V9t54a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0eNulUptxrWrhVUV8ELOmTftB9JHtrHYOD/n1FuF7IxzSK0AnpmYqVuuzL5ORR48WptZQBUb9Q1kMRNLHfPCXRJn9Qv/VlbSSCGpzchBhwNdfGE0V6u20UvuCXqbJHbgu3L6Bhjb/CY4FtNEBVTOx0RXiIWrQEFQ6qdqlLZTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkJ0DvJQ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkJ0DvJQ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84857446424so2702633b3a.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785978; x=1788390778; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Vao/sFoJOVIbWTYUWR6l3TJZJPEpgeX1jEPgOktw9I=;
        b=KkJ0DvJQM7RLIel38kZyWI2PH+Zg9HiX3wPyHpK7NEx5LHBlwLlVEPTlb2pckkdij4
         KQHtmNAK+RrylFgKVlf/B4qkLc2W9/fRBZ1BB/1CRT/wn2BRnVc5R0EaB5I2iLmFFAVu
         tKkO/Al1T8GkltHNicrxgqt7cqStRtj/HHKuexxx+tQKa0bKyuU1eEibB+ne769lq/oL
         gVfITgsyI1bVDlN5Yr55TFciajMRnGaRydAwngWdYDaO65wpBvldF3oUa+T1gXpA4Xtq
         DT6aP/tl2CdRKO46Hibzy6uv7T3065OlDHXPRhOlCb23Q1Z5mrX36QayaclnEBOvldJZ
         f3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785978; x=1788390778;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Vao/sFoJOVIbWTYUWR6l3TJZJPEpgeX1jEPgOktw9I=;
        b=h+LcKqJPOo2jxjDiEtnNM6EMkSbN0JmJZxY1CXt135gQVsKPX3Gvx2cVAU6TCwEWOv
         7lnso1ha9v4WlbjxGh9uUt3iC9sdn9V7xj5OLT4jTTbCoGajWelbeP6B+Fk5UnoD5+0l
         FYbBIgc++EsFnJHPOoiAtzOgkfuNHDgAX+4emgbnDsssuLf4nO4HMJguNdwbvk7Ue4jS
         UDVRt+orZKcVH4/BCn8B0XdOxzUaS/Org/Z6XqzoWQOYEQ/g9q0Ota1s4EtrjlVaD+IP
         9gw83q24j/OKV7NE3JusEOsBRRvRpjErDq8VyQTs00+M/4x5+VbWJZEuTUg/dRFywi3x
         q6uQ==
X-Gm-Message-State: AFuF++kWo0gDcKOh6qCfF64j7Xo9b+eiV/akx1qUr+nBCbdLPnO0B6Mr
	4SqcKyJh/kxI9CdiHQGXpE3hKomQ6D1UWU/22zOERsMlpgIc5tMaDZ9UtRpESlT3ITHvg+yC7Ae
	ILqdOOg==
X-Received: from pfmu26.prod.google.com ([2002:aa7:839a:0:b0:853:30cf:bad9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:330e:b0:845:cdc1:a803
 with SMTP id d2e1a72fcca58-85373eb6f22mr19900529b3a.11.1787785978156; Wed, 26
 Aug 2026 16:12:58 -0700 (PDT)
Date: Wed, 26 Aug 2026 23:12:57 +0000
In-Reply-To: <CAL1mVc0W0oirnpd-im6r+Vewo6yfsWuXQB7UecEenYnE4BOJ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAL1mVc0W0oirnpd-im6r+Vewo6yfsWuXQB7UecEenYnE4BOJ4A@mail.gmail.com>
Message-ID: <ao9y-cJfL-F9K4gV@google.com>
Subject: Re: x86/KVM: host reads guest IDT gates after VMexit on Cascade Lake
From: Sean Christopherson <seanjc@google.com>
To: Yaohui Hu <yhu@digitalocean.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

+Chao, who has helped with errata in the past

On Wed, Aug 26, 2026, Yaohui Hu wrote:
> Hi,
> 
> We are chasing a host crash on Intel Cascade Lake that we believe is a
> CPU defect, but the exposure changed sharply across a kernel upgrade
> and we would like input on the kernel side.
> 
> Symptom: nine hypervisor crashes over ~120 days, all the same shape.
> On a KVM vCPU thread, shortly after a VM-exit, the host faults at an
> address unmapped in the host, then faults again on every subsequent
> exception delivery, recursing until the #DF stack is exhausted.
> 
> The phantom handler addresses are not random. In one dump we located
> the IDT they came from: it lives in the tmpfs-backed guest RAM of the
> VM running on that CPU. The host read gate descriptors out of the
> *guest's* IDT and tried to deliver host exceptions to guest handler
> addresses. A second dump shows this in software rather than by
> inference, with the oops registers caught in vmx_do_interrupt_irqoff()
> having read a garbage gate from host_idt_base.
> 
> Linux maps the IDT through the CPU-entry-area alias at a fixed
> virtual address (0xfffffe0000000000) that KASLR never relocates, so a
> Linux guest and a Linux host use the same address for their own IDTs.
> With VPID enabled the guest's translation survives the VM-exit, and a
> host access tagged VPID 0000H must not match the guest-tagged entry.
> On these parts it appears to.
> 
> Environment:
> 
>   - Xeon, family 6 model 85 stepping 7 (Cascade Lake-SP), microcode
>     0x05003901 (latest public for this stepping) on all nine hosts.
>   - Two server vendors, three datacenters, VPID enabled.
>   - 6.1.51 ran this fleet without such a crash; 6.12.51 produces
>     them. Microcode and hardware are unchanged across the upgrade.
> 
> There is a documented precedent for the failure class on a different
> part: Arrow Lake erratum ARL029, "Incorrect Core TLB Entry May be
> Retrieved Following VM Exit". Cascade Lake has no public equivalent.
> 
> We diffed the relevant paths between the two versions. The gate read
> in handle_external_interrupt_irqoff() is functionally identical, and
> the TLB/VPID/EPT invalidation layer is byte-identical
> (vmx_flush_tlb_*, allocate_vpid, vmx_vcpu_load_vmcs, and the
> INVVPID/INVEPT sites), so we do not believe KVM changed its
> invalidation behaviour. The one change we found that plausibly alters
> exposure is 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area",
> v6.2), which changes the paging topology of exactly this region. We
> can see the effect in our builds, but we have no mechanism that
> predicts its sign.
> 
> Questions:
> 
> 1. Has anyone seen this signature? A host faulting after VM-exit at
>    an address that turns out to belong to a guest seems distinctive
>    enough to be memorable.

I don't recall seeing anything like this in our fleet, but I don't think we have
much exposure to v6.7+ kernels running VMs.  I.e. we may not be seeing anything
purely because we haven't picked up the "bad" kernel, yet...

> 2. Is CEA randomization a plausible amplifier, or is there a better
>    candidate in the 6.1..6.12 window that we have missed? We think
>    this is a hardware defect either way; we are trying to explain why
>    the same silicon and microcode behaved differently.
> 
> 3. Would moving the host IDT off the fixed CEA address, or
>    randomizing it per boot, be acceptable upstream as defence in
>    depth? It removes the guest/host virtual-address collision the
>    failure depends on, and unlike the KVM-side change below it also
>    covers hardware event delivery, not just the software read.

Without knowing what's going wrong, hacking around something like this probably
isn't going to be a viable option.  :-/

> 4. Suggestions for making this reproducible? We have a rig: a
>    kvm-unit-tests guest that maps a recognizable IDT at the CEA
>    address and drives ~7e7 VM-exits/s on one host, plus a host module

What types of exits, and what is the guest doing?  If this is more or less the
same thing as ARL029, my read of the erratum is that it requires the CPU to be
reading the IDT at the time of exit, so that the TLB fill completes after VM-Exit
(and presumably gets tagged with VPID=0).

And given that at least one splat specifically traces to vmx_do_interrupt_irqoff(),
and that generally speaking KVM will only be forwarding events to the host via the
IDT when handling IRQs, I think it's a safe bet that the VM-Exits need to be IRQ
exits.

So, maybe try having the guest generate a horde of faults that along with INVLPG
opreations (or full TLB flushes?) to purge the IDT translation from the TLB, and
then spam the guest with IRQs?

>    that validates the gate KVM reads on every exit. It sustains
>    ~4.2e9 validated checks per minute and has not yet produced a
>    mismatch. Our own estimate puts the target near one event per
>    host-day, so this may only need runtime, but advice on which
>    conditions to stress would help.
> 
> We are aware of 28d11e4548b7 ("x86/fred: KVM: VMX: Always use FRED for
> IRQs when CONFIG_X86_FRED=y"), which removes the software IDT read for
> external interrupts and which we are backporting. As it was motivated
> by CFI and does not stop hardware from reading the IDT at the same
> address, we treat it as hardening rather than a fix.
> 
> Thanks,
> Yaohui Hu
