Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909133CE80
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852943; cv=none; b=m5Bfey4my0DMQD0GGw/oUY1kSojovoLgW5TEhyjOt/gpDPaxwkq1RRQcsdXADXgiWbDbNPtkj7IG6in/ifpZDGIvTvHoNVn/6WBbc3ZsrYtJyrkSMoV0JRDHxx2temeTv4Xo5IPdgfOKOCTV3ONcnT9AGlpqsqwqKT7WDrSvNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852943; c=relaxed/simple;
	bh=ZCnKqSef0aqr+81xVS1JE4n3VLRsH2+hOAI5+W0cJww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEXltVdO14Y+q2OdiDBnI9yInr2qCFUWpphe/Pq/HecJl0jYhNUq3Xnib1c9mVXatuiEKz3axUfNasfZzDySpLfoXXQiyn6aFkEdWrk7FZwyjIQDycIow7Qi3KGT0yjqiZSsZS3MI/AVdp8U8lx4MQEkSIkS9gPWI/zxXN8k4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQgOpyBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQgOpyBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29541F00A3A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787852941;
	bh=ev6jidi1QREvbxSu6OdcvcMl8MWG3QwkEno5tcVFAtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DQgOpyBXuR41Nr18lIdfT4gFngCpqEi09PdMwcabkzlaXA7hCGvz62C9WJhWrI61W
	 ATTx9Vw3kODA5t1UsToiVSbdjDd5ijcd6Rtt98c+O2G+cLp0cmiLkPylKNNaxU7Ow5
	 cDvf6cqBxUCNsCxK8RZoeXh9qTv7Q3lGFLp5iPBxHLdDinTylf415DNY8CozJM9ssi
	 OeDI97/c9RcmPt0nKB/D3YFlPwMRPlEEEJyXE2i3gxOh0oVs0U060fs3Xw2qMwYqUp
	 4da8rf7sAYQtVd4lWskm3rYsL6ws8lkm/vCUR15PMaAa8JAFwW8Kn9m4hGeFR6xSXL
	 7pXDXXCSn9z7g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e2dab83eso20663366b.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:49:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpb2ntJ6OQYxVycfpQPCH2Eou3j9EoMusBRs5jTsjRmidFA8gZKsTNlJ2MY5dVtWOd/4Nc=@vger.kernel.org
X-Gm-Message-State: AFuF++mV1JrEJJfd7z8wT0s+29eEPk8tH4teVA2boT4PSafJB/urdTXi
	NwwScQQns9WkUFuNXkQxjgH8S+UUtfGZkHIfpjM2HMy3qttSHH6WJtj630zXCFDdg9ydLRkiBn1
	qSRDn93sLknJyRvKWNUyDstLd9KdG6Dc=
X-Received: by 2002:a17:906:6a29:b0:c20:9447:bd6d with SMTP id
 a640c23a62f3a-c25574337a0mr33261166b.11.1787852940696; Thu, 27 Aug 2026
 10:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-4-seanjc@google.com>
 <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
 <apBQYmmBC8lE-KiQ@google.com> <CAO9r8zOiPc=AdSZov9w5EN-WogpSTR54z8UuTd3oqKHiWCfNmA@mail.gmail.com>
 <apB0FLZGZPmAEk8o@google.com>
In-Reply-To: <apB0FLZGZPmAEk8o@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 10:48:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMbhEg76dKSXWtyKf_=HFvNC3f1gX3xFZ5iPmA=9L1JVg@mail.gmail.com>
X-Gm-Features: AcwNN1XNbyC6SdYR4LPRNtrKJhyQFyhXQyG8HbPIQ4j8qhaddcgCK1KumBHFbjs
Message-ID: <CAO9r8zMbhEg76dKSXWtyKf_=HFvNC3f1gX3xFZ5iPmA=9L1JVg@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

> > > OMG, I hate SVM.  I resurrected the selftest hack I used to verify this bug, to
> > > demonstrate that Sashiko's "technically that's undefined behavior and this is
> > > useless" complaint is wrong, because even though it's undefined behavior and the
> > > compiler *could* ignore the change, in practice the compiler probably won't ignore
> > > the change.  And since this is defense-in-depth, it's "fine" if the paranoid
> > > hardening only isn't guaranteed to kick in.
> > >
> > > And in doing so managed to trip this KVM_BUG_ON() in *L0* when running the test
> > > in L1, because as you kinda sorta noted in patch 1, KVM doesn't ignore EFER.LMA
> > > when loading L2 state.
> > >
> > > I had actually tried to do exactly that, by having nested_vmcb_check_save() clear
> > > EFER.LMA if EFER.LME=0, but that doesn't work because svm_set_nested_state() uses
> > > the "cache" only for the checks, not for the actual loading of state.  *sigh*
> > >
> > > So in addition to patch 1, we also need this to guard against configuring L2's
> > > walk_mmu with bad state.
> >
> > Hmm wouldn't it be simpler at this point to let KVM_SET_NESTED_STATE
> > and nested VMRUN have the invalid LMA/LME combination and just ignore
> > EFER.LMA if EFER.LME
>
> Definitely not a straight "ignore", because that would end up being an even worse
> game of whack-a-mole, because very path that checks vcpu->arch.efer would have to
> account for that possibility.

All paths that check EFER.LMA/EFER.LME only, right?

Don't get me wrong, it's still a lot, but I was hoping it's something
a couple of helpers can help with. Looking at the code, maybe not so
easy because it's not just vcpu->arch.efer.

> We could forcefully sanitize EFER in flows that write EFER,

Hmm that's exactly what we're doing here, except that we sanitize when
creating the vmcb02 and reject in KVM_SET_NESTED_STATE.

> but (a) that's still
> a (must smaller) game of whack-a-mole and (b) it would actively hide KVM bugs for
> flows that are supposed to reject the invalid state.  And if we WARNed to address
> (b), we'll be right back where we are today: playing whack-a-mole to prevent the
> WARN from being triggered.

Either way it's a game of whack-a-mole, unfortunately, whether it's on
the write side or the read side. What I am hoping is that if we do
miss one case, we don't crash or corrupt the VM. Ideally, we can just
ignore EFER.LMA if EFER.LME is not set in these cases?

>
> > (or just always check EFER.LMA && EFER.LME)?
>
> No can do, because we can't disallow the combination for L2 on VMRUN without
> violating AMD's architecture.  And practically speaking, we *are* doing that,
> just in a bunch of places because there's no one rule to rule them all.

Well, "always" except for this one case :P

>
> > > Because there's a lot of code between here and checking KVM_VM_DEAD in
> > > vcpu_enter_guest().  And has been proven far too many times this year, detecting
> > > a flaw doesn't automagically mitigate true badness.
> >
> > Interesting, I always assumed we can do whatever we want after KVM_BUG_ON() :P
>
> Nope.  In addition to KVM_VM_DEAD not being checked until vcpu_enter_guest(),
> more broadly it only kicks in for cross-task behaviors on the next ioctl.  E.g.
> if KVM_BUG_ON() guards against bad VM state, as opposed to bad vCPU state, i.e.
> if *other* vCPUs could consume the bad state, then it's especially important to
> take evasive action.
>
> KVM_BUG_ON() is as much about protecting the guest as it is about protecting the
> host.  E.g. if KVM *knows* it fatally screwed up, then continuing to run the
> guest risks corrupting guest state and thus causing far worse problems than DoSing
> the guest.
