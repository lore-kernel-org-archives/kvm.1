Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1E41A506
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737204; cv=none; b=V378AYmVV1PRo3LhmTo2jst1A32GJeDidpVRQwFbOUmoDRwrdTV9wBtn7S0gd287JI1qKDvuNKsbjmz4UZ/iJk03GjZS6bO8/RxDLKSjg/PAWPZY/UT2SZUF+90yiIDNm4H9px1sKY3jFhwyayzQC3bSXXOQpMXgteL9DPP8hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737204; c=relaxed/simple;
	bh=UrewZhvj67OD5/PiVQn1ohfUYivZXx+MgCmwrexV93o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOFQTrJQ/oaQ7b091UognAUpziJLv2E4mzrjWb+R+QEwzBWrAn9iLUGIcNZbc6BygMhfiTVQw/p0k+8rt1MF1/o6QfZFhTR4UJMxagzxPq44QlfPEjefS9VRaimWv9D7/nq3WyUke7Lx8JI0Fhhy7SDqTLqu7qw7lRX5+7YiDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+jKs4mz; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+jKs4mz"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so898081a12.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737202; x=1790342002; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ud9IADFECmv4ypdoomkuAdmOaYSroln0xj23hEJBkE=;
        b=Y+jKs4mzo8Xj8k7MaTbKPyzpkybyRGdqlxTCFg1qa3tBnQudimL04mJMIQa6vmzlAY
         9EmEQzTg7YO0DJXKJuMBFn7wbgJ2WGeB8GQiVX4NukMnlSGHv0B+EoEfwa4DM5/SPuW5
         Cd3wMmBT3kmOHWOShsXEWdGqs6dQpwokHjtPP9CoBQnMUSuJOeXVJZPOhu9zovutDWsF
         6+mNsGvilg3K2cb2fIquXAOU06iWkaRCColHJ8EkD9wbCRAkBYDLzEkQCAyoVL1XizET
         rfyJ1xO1EXvp9wucvroROsRht1IbUKGakZKjeDsrtycBNYFDANTe39AUQ/ggr3fHW1KD
         cMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737202; x=1790342002;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ud9IADFECmv4ypdoomkuAdmOaYSroln0xj23hEJBkE=;
        b=z8rBpUD742rfvB3sIXfHQT3TZNK7ENL32JGliYt9LPEU6x8Oq5PltvJ81rhH9v6aBn
         J8q8+5ZQ2xZE+xKmc/Echmm7AcsJ45r+R20+shFqGUyG6DIg21m6PWB3VznWmbWJmxnP
         dspLu2U4K8K8qliRWIbflJ7FG4qc/HERB1RUYn7e66u2mm1LRc9Ccyb8+PEFY3u01HAa
         0DCag2vED3Dr2HYc8+4C/v+gt34HI4D8VxB8p65BNHXrvzuTeziMsMNPLQ0CNQbBgzWI
         RBkd7eZJHJ7SvU3IGJFt6o8X3TRXaePfX+UxvPm/WpwtmoCbWU+7a9rrKm59ASxoKxef
         U+8w==
X-Forwarded-Encrypted: i=1; AKwUvByCQdWnDTfxhmIJgCwwkTAvGzF21IW1yydIMVCzMdso9SR8+i/LRg8MFuxtIoqO1gi42bc=@vger.kernel.org
X-Gm-Message-State: AFuF++k/8F6cL+83bp3uc4bsMnYKIDTNZHpxnzYdTrrUawXBo47kktyN
	5x8vjBsYLko26qJ6SEyGWtFRjuK6DvYkuhjwgZ3qZ8bNJM/ihVlPePG9NYz7krnsfwQmA7x5K4x
	eXMe3Ew==
X-Received: from pjbju13.prod.google.com ([2002:a17:90b:20cd:b0:39e:2369:7399])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d47:b0:39d:f4fd:8075
 with SMTP id 98e67ed59e1d1-39e54c9c7b7mr6090144a91.19.1789737201416; Fri, 18
 Sep 2026 06:13:21 -0700 (PDT)
Date: Fri, 18 Sep 2026 06:13:20 -0700
In-Reply-To: <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
Message-ID: <aq048KmPN5WPQ4sQ@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-09-17 at 17:04 -0700, Sean Christopherson wrote:
> >   If supported for the specific request type, the host VMM can request an
> >   interrupted request to be aborted.
> > 
> > Though per the above, apparently whether or not that's going to be supported is
> > TBD?
> 
> So extension aborts are a whole 'nother topic. And "support" has a nuanced
> answer to boot. I'd be very glad to hear your thoughts on it. Should we leave it
> for a later topic or get into it now? I *think* we don't need it, but the more
> we get into the details here, the more it's a notable thing we haven't covered.

How is saying "I no longer want to complete this quote" at all complex?  I can
see how aborting a request to the S3M might be somewhat pointless, but inserting
the equivalent to signal_pending() in a long-running operation doesn't seem that
difficult.

> > Regardless of where we end up with quoting, whatever RFC is sent next needs to be
> > a million times better.  My expectations are that someone with core TDX knowledge
> > and a basic understanding of attestation would be able to get a full and complete
> > understanding of the design and tradeoffs from the RFC alone.  If I have to
> > rereference a spec for anything other than double check params and magic values,
> > the entire series is getting ignored.
> 
> I mean. Confidential compute in general is trying to reinvent decades of
> virtualization solutions with one hand tied behind it's back. There *are* a lot
> of design choices.
> 
> Besides a rushed RFC, I think another factor is that this is the first TDX
> feature we have done that you don't already have at least some exposure to. The
> level of background delta need is way higher than S-EPT management for example.
> 
> And I'm less and less sure we are going to be successful distilling things like

It seems like part of the problem is that you're trying to "distill" into abstract
concepts.  I don't want abstract concepts, I want a description of what the TDX
Module code will literally do, using verbiage and terminology that a KVM developer
will natively understand.

> this down in a way that doesn't leave you frustrated. But if you want details
> there is just going to be a lot of them. Hmm.

This is what I want.  Note, this description is apparently wildly wrong, because
I wrote it before reading about whatever NRX modules are.  But I'm leaving it
because it highlights my point about not wanting TDX jargon rephrased as abstract
concepts.

  Under the hood, TDH.GET.QUOTE uses what TDX calls a "virtual thread pool".
  That just means there's a pre-allocated pool of "thread" memory that can be
  used to service interruptible requests (it's not true interruption, it's
  basically voluntary preemption).  The number of threads in the pool is
  configured by software during ??? (TDH.QUOTE.INIT?), and directly controls
  how many in-flight TDH.GET.QUOTE operations there can be at any given time.

  Each thread consumes ??? KiB of memory, and <reasoning>, so we chose to set
  the pool size to 1, i.e. to only allow a single quote to be in-flight across
  the entire system.

  TDH.GET.QUOTE is "interruptible" because the bulk of the quote crypto is done
  by the TDX module, i.e. on the CPU that invokes TDH.GET.QUOTE.  We don't have
  numbers for TDH.GET.QUOTE yet (why not?), but the very rough ballpark is that
  it will takes 1-2ms.  Note, the S3M is used only during ??? (TDH.QUOTE.INIT?)
  to get the platform key used to generate quotes, i.e. generating a quote is
  fully synchronous relative to the core.

> > As for guest-driven quoting, to me there is a fairly straightforward solution.
> > Assuming using guest-donated memory is too complex for the "virtual thread":
> > 
> >  1. Drop "virtual thread pools" from quoting and support at most one in-flight
> >     quote per TD.  I doubt whatever memory is needed for a virtual thread is so
> >     insanely ridiculous that we can't burn that much memory per TD.  32KiB is a
> >     no-brainer.  Above that and we'd have to reconsider, but if quoting requires
> >     more than 32KiB of scratch space, I have to wonder what on earth it's doing.
> 
> I think the abstract descriptions are not helping, so I'll try some more
> details. Today the "thread" involves something like a vCPU in a TD. You can see
> some references in the TDX base spec like:
>    Currently, TDX Module extensions are implemented as guests running in SEAM non-
>    root mode, called NRX Modules. Technically, each NRX Module is similar to a TD.

So my above statement that "it's not true interruption, it's basically voluntary
preemption" is wrong?  Because if the quote crud is running in a TD, then events
will trigger VM-Exit, and it will be impossible to make forward progress without
SEAMRETing to the host.

If that's true, then that changes my understanding of this just a bit, because
it means the quote operation isn't manually saving state at a "good stopping point",
it's relying on the VM-Exit to save/restore at whenever it happened to be.  But
given that you say "This idea came up before actually", maybe chunking the quote
operation isn't a big lift?

But the original mail says this:

   -- Guest Interrupts --

   It is not nice to keep the guest from running for too long. The TDH.QUOTE.GET
   SEAMCALL monitors for host interrupts, but not guest ones. Similarly, the SGX
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   quoting enclave doesn't know what is happening in the TD. So, to help reduce
   guest latencies, the GHCI exposes a way to register for a notification
   (SetupEventNotifyInterrupt) when the quoting is finished. A quote TDVMCALL
   handler can start the quote operation on another host thread, and resume
   guest execution waiting for the quote to finish.

which strongly suggests active polling.  Do you see why I don't want abstract
descriptions?  Similar to changelogs, there's a balance between "too detailed"
and "too abstract", and right now all of this is firmly on the "too abstract"
side of the world.

> >  2. To avoid having to check for guest interrupts, for the "SW based" synchronous
> >     method, simply resume the guest after processing a fixed amount of state.  Yes,
> >     that will increase the best case latency for a single quote, but *best* case
> >     latency isn't a huge concern, and I doubt the overhead of a VMX roundtrip will
> >     significantly impact that.  It's the tail latencies that will be problematic,
> >     and a forcing the serialization into the guest (the aforementioned mutex) means
> >     the tail latencies will only be affected by host activity on *that* CPU, which
> >     is more or less the status quo.
> > 
> >     E.g. even assuming an absurd 20% overhead for the VMX round trips, having a
> >     quote take ~1.2 *every* time is would be a far, far better experience than a
> >     quote taking 1ms - 10ms to complete.
> 
> Dave will probably not get a chance to respond this week, but we should maybe
> discuss what acceptable guest latency actually is.

Yes.  But it's not necessarily about "acceptable" guest latency, I care more about
*predictable* guest latency.  E.g. making up numbers to illustrate the point,
achieving 50us latency for the happy case is meaningless if the P99 latency is 10ms.
