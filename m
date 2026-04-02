Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E037287503
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152337; cv=none; b=I0X7cdmPd1pDAGJsH4kSE4cD2EbuxUqKT4VHfHhcd7Uk5HKJ0UN3CWZL8b+FDRW8NQEVndZHDYOwBYH2VBqGRKc4UwIU0YWNC37m5B0AI1sj71EBzmWTyshEF+XjGu1soMt7v021ovB9DKByez3Df/9DZbuRKcWSCQQ1RWH7CzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152337; c=relaxed/simple;
	bh=Ad8mA6CcVmN7s1faVf+ztuQF3tWgYZmGqIjKEOXoWsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyhwHQPyasYZ3hmmSIKEBjkldR2o3lHCHrviqLRMlkUBSzwojs/uFrob0c/esQi607kLwC0VQhBNdJaUbeXXk8nY3UU+R9LYKNzkVs0FP7uLaV++UFEkI+oVLLC6kYyW3fhMcQ03tiXiimdtXW3vFT/XdFz1TYFq/TZ4PXmPp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQ3d5soq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQ3d5soq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c649dc145so631358b3a.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775152336; x=1775757136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r89fuvNKa4MTX8mZxF1YzmAzE0YPpremThL3RO0uraw=;
        b=QQ3d5soqwAaJIirURXIJi4UNmsh+SaNF4lM5mwAy4HTHZALagJSgCST4fK6kszjMC8
         2pW8eKsGHT19QXbjVL5LiliilmW7AvpzSOl5gZLn53WggqadhsmWePbbmBz/jnDi6014
         XnTC7IH5Rv6iV90iTBodVd+x5yPjG0+tTwb9MO2ua6olIv41oeV3YCsLoutEuEawFnkP
         JZt7ylJp5bq+GHqYZJGdHvsPmH35vNDNqSeRpvBaju/9kF7sx4FyiwdWXn2cRjitYKsx
         HnWcO7GaE0XIehUYVYAC95+/ccpc1KW7rDFMnUPS20hVHnT0/0fa9TRtJkckGlllYPAR
         6pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152336; x=1775757136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r89fuvNKa4MTX8mZxF1YzmAzE0YPpremThL3RO0uraw=;
        b=pdi5R5ApQWCqc8xPme4xB/ZbVna+3teAmPbO2OVO4wRoOHWPYjzVH4HExONM7QetdA
         jRioq12y0MNsY7qqIlsV+TDXOBMnI7QepOag9kG0A6si/uTM9uzYOU5PdIsET9uDNN4q
         5SUX52E/0P10BepEmDwir8AXI/JCF4C0vde+OFD3LprZtCWfz0Tb5PWHczGl8XZS9TH4
         v7Mc0+oFP2TdQ7wcrZwVMXzZ6+GEvLe1uois99xK06h9+PPiQ3+EWD7XZGI2KG/a66i1
         0i67T+CSz69n+dvk2nTexVeNyug93SUllExfiAmYQgEgMemeNK6uPkw70Wy5YHlWLQ4h
         sP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkDkGwsH53hU1YXuM8Mu5eMqJPIOTs8cWdkzJAt0S7k6v8o1aiQChLnAPxWY4YIx4rek4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+5dKhZGH1ZpG9OweBSNymOFLpa3RjuSNiMHGB/J86cEMdEeY
	lpzv0Q1yCS+fv5IUKprLYnlv6/0PBuUcDLMwOW85+0nWbbg0mEJgr/IafOX3QUqKOoZQQsBUNEH
	MzhXlYQ==
X-Received: from pfblr27.prod.google.com ([2002:a05:6a00:739b:b0:823:b9a:9230])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c9c:b0:82a:1499:263b
 with SMTP id d2e1a72fcca58-82d0dbdbc9fmr62969b3a.52.1775152335546; Thu, 02
 Apr 2026 10:52:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:52:14 -0700
In-Reply-To: <ac20s-AAvqIreILG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-4-jrhilke@google.com>
 <ac140E1-ZeVg9mq_@google.com> <ac20s-AAvqIreILG@google.com>
Message-ID: <ac6szjc0iLohWhwT@google.com>
Subject: Re: [PATCH v2 03/14] KVM: selftests: Add vfio_pci_irq_test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Josh Hilke wrote:
> On Wed, Apr 01, 2026 at 12:58:08PM -0700, Sean Christopherson wrote:
> > On Tue, Mar 31, 2026, Josh Hilke wrote:
> > > +int main(int argc, char **argv)
> > > +{
> > > +	/*
> > > +	 * Pick a random vector and a random GSI to use for device IRQ.
> > > +	 *
> > > +	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
> > > +	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
> > > +	 * defined NMIs and interrupts.
> > > +	 *
> > > +	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
> > > +	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
> > > +	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
> > > +	 * KVM_MAX_IRQ_ROUTES is exclusive.
> > > +	*/
> > > +	u32 gsi = 24 + rand() % (KVM_MAX_IRQ_ROUTES - 1 - 24);
> > > +	u8 vector = 32 + rand() % (UINT8_MAX - 32);
> > 
> > Ahh, now I see why you included "Reproduce tests that rely on randomization" in
> > this series.
> > 
> > I think I'd prefer to tweak guest_random_state() to drop the "guest" in favor of
> > "kvm", and then use that framework in host code as well.  Then you wouldn't need
> > to open code the % fun.
> > 
> 
> How would using the guest_random_state() library remove the need to calculate the appropriate ranges using %? 
> The library (tools/testing/selftests/kvm/include/test_util.h) only provides:
> 
> uint64_t guest_random_u64(struct guest_random_state *state);
> uint32_t guest_random_u32(struct guest_random_state *state);
> 
> I could avoid using % by adding a new library function that picks a
> random number within a range:
> 
> uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min, uint64_t max);

Yes, please.  I was thinking that in my head, but never typed it out.  The original
plan with the pRNG code was to build out the set of APIs for doing random number
things, it just never picked up steam due to lack of need.

> > As for the get_irq_number() and get_irq_count(), those need to be much more clearly
> > scoped to /proc/interrupts.  E.g. "irq" in KVM context most often refers to the
> > guest IRQ vector, not the host Linux make-believe IRQ number.
> > 
> 
> How about I rename these to get_proc_irq_num() and get_proc_irq_count()?
> And then rename the library irq_util.h/c to proc_util.h/c?

Works for me.

> > > +	/* Set a consistent seed so that test are repeatable. */
> > > +	srand(0);
> > 
> > And using a pRNG instead of rand() should make this unnecessary.
> > 
> 
> We shouldn't even need a pRNG if we follow your suggestion above and use
> the guest_random_state() framework for the host, as it would provide the
> guest_random_u64() function.

Heh, by pRNG I meant guest_random_state itself: "struct guest_random_state" is
itself a pseudo-RNG implementation.
