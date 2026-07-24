Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE9445AF4
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911563; cv=none; b=ev0KZhrONV5lAvveeQNJGLzN3FBXyFWpnaRhn7cg/14h/8LXuzFCca31bxlaO9WOFhahuVgwXSqRkojNTv6OV/AdjR+5qbl+xZXUPP7AmmChavCKPISbjcGv6VpdjCbwmutyp9XPiX7DL/3vsgqL3u3lzykllmSph8vmVeK0ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911563; c=relaxed/simple;
	bh=5R6/AuE8HeovNM6gdcOrRkEF/mm9M/GJdke5wLsvJoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmSToT0xZupGN+essSASWh8+CJ2UA8L2OtfSpeYsoOR+DoHz6CXSOadxeUhfTes7laSUo7WpJfQLPXt5BZRmUv8WE8wdE/0yQNq8BcgJBe88NEAKM1oOnjjJpWhbGHfa8rMJBhz23/ZEysNx5XnqpfXU1y5XrUT9iK4F1CogCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8l4F1lX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8l4F1lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCD91F00ACA
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911562;
	bh=lwrZMckZBDFDJgN3mP5MnYzwZQdNSOM0fUVfJrhLDdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m8l4F1lXoIIG4ZGE0J1MGbpmiS7O1DWEyFWj8QxZThwlFIo/7gF71D3nPlxa0eo9S
	 ULIwErqnMvUxHy7b0B7WuV7n4jRbLyUbC3AAODb3mmom3HYP+yuF52JbPa0mTijcEJ
	 Y8kNgc4RimC950SNup13uM4VHjk0IoCZeFxlLt2TeRcxoiMhCNpk8i+6g1AX9upFNc
	 VX8dt7jBdVDbYnB5pZq2VcPY4q8+vMnBjFoQDnU1XdEqTRfPld6g4S5RcpMdxJF+kW
	 S5BsZ+4/B5Lo3Waac7Zve1O53ocG3VqWGhmQjg5CQyB4cuUmIfpao/9bQD4usCSgrw
	 /7dIhUxrlCEdQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so767917a12.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGM2UB+cObTSpGakVJVdtfY2DL9GlcqppJfDcJBupkS0DLLCA9ETmsWcdrM0yu12NnjNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jaFy05gbeCTY//iNdaI9ZUGUgomnPm/juhUdPGG+5UQIYvFB
	6nh6xVon+aJ0tQBRYr2CNBeTUIwpiC24OtMzdceBpLKtLg5f5zl1pT9DLVCl8DheA6zt1XXfRq2
	qH/WJnyBznXDip8UCGEm+8kzsWlVZZLM=
X-Received: by 2002:a17:907:3f09:b0:c15:d068:9160 with SMTP id
 a640c23a62f3a-c1c50d1c8bfmr361405466b.31.1784911561073; Fri, 24 Jul 2026
 09:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
In-Reply-To: <amIx9Ki6gv-wgBnX@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 09:45:47 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com>
X-Gm-Features: AUfX_myAjVEFqUMfYEQem3GUZw9uIvGsdTwoxnHAujhl6B1ZnMtmwkBdddzOVjw
Message-ID: <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > > index 65c35ed8f4a01..3feb75732f7b4 100644
> > > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> > > > >         write_unlock(&vcpu->kvm->mmu_lock);
> > > > >  }
> > > > >
> > > > > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > -                            u64 addr, unsigned long roots)
> > > > > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > +                                     u64 addr, unsigned long roots, bool flush_gva)
> > > > >  {
> > > > >         int i;
> > > > >
> > > > >         WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> > > > >
> > > > >         /* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > > > > -       if (mmu != &vcpu->arch.guest_mmu) {
> > > > > +       if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
> > > > >                 /* INVLPG on a non-canonical address is a NOP according to the SDM.  */
> > > > >                 if (is_noncanonical_invlpg_address(addr, vcpu))
> > > > >                         return;
> > > > > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > >                         kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> > > > >         }
> > > > >  }
> > > > > +
> > > > > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > +                              u64 addr, unsigned long roots)
> > > >
> > > > Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
> > > > kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
> > > > to have the "in_root" version to a quad-underscores helper, and IMO it's more
> > > > obvious what's different between the one-line wrappers and the inner helpers.
> > >
> > > Hrm, or maybe I'm not understanding what "flush_gva" means.  At first glance, I
> > > was assuming you were using it to differentiate between GVA and GPA, but IIUC,
> > > it's literally skipping the flush for the current context, which just so happens
> > > to be done only for GVAs.  I'd still like to avoid the "in_root" helper, if at
> > > all possible.
> >
> > Yes, it's skipping the TLB flush that is only needed for GVAs. The
> > alternative I had in mind (but thought was worse) was to refactor the
> > TLB flush part out of kvm_mmu_invalidate_addr() (or
> > __kvm_mmu_invalidate_addr()) in this patch instead of adding a boolean,
> > but this still requires adding a wrapper and the possibility of a
> > quad-underscore helper.
> >
> > What's the main objection to kvm_mmu_invalidate_addr_in_root()?
>
> I don't love the __kvm_mmu_invalidate_addr() => kvm_mmu_invalidate_addr_in_root()
> callchain.  It's not at all obvious that the in_root() helper shouldn't be called
> directly.  I don't hate it, but I do think we need better clarity on what all this
> is doing.
>
> E.g. when looking at __kvm_inject_emulated_page_fault(), since it hardcodes a
> single root, it's a bit headscratching to use kvm_mmu_invalidate_addr() instead
> of kvm_mmu_invalidate_addr_in_root.

Coming back to this, I agree it's confusing. I think this can be fixed
with a better name though. Looking at
kvm_mmu_invalidate_addr_in_root() (or __kvm_mmu_invalidate_addr() in
current code), seems like what it does is find SPTEs for that address,
sync them, and flush the TLB if needed.

So maybe mmu_sync_addr_sptes() or mmu_sync_and_flush_addr_sptes()?

I think this would make it obvious it is not a direct alternative to
kvm_mmu_invalidate_addr() that just operates on a single root.

> Hmm, and arguably, the way invlpga_interception() handles the ASID is flat out
> wrong.  KVM doesn't need to flush *all* roots, rather it needs to flush L1 roots
> for ASID=0, and L2 roots for ASID!=0.

I wouldn't say it's wrong. It syncs more roots than needed, yes, and I
did document that in the comment. I didn't want to spend time
optimizing this because it only matters if NPT=0 in the host (and
probably L1 will only use INVLPGA if it also has NPT=0).

I think KVM generally over-syncs in multiple cases. For example,
emulating INVVPID on a single address flushes the entire root (see
handle_invvpid()), and I don't think anyone cared enough to fix that.
Also, emulating INVLPG and INVPCID syncs all roots, arguably it should
only sync the ones' matching the vCPUs current guest_mode?

> If we can figure out an elegant way to
> express and handle that, it should naturally handle the "flush GVA" aspect.

Hmm how? I think the way to properly do this is to filter roots based
on role.guest_mode, like kvm_mmu_free_guest_mode_roots(). I'd probably
refactor that logic out of kvm_mmu_free_guest_mode_roots() and reuse
it if we go this route. But this doesn't really help with the "flush
GVA" aspect.

One way to actually tackle both is to pass "guest_mode" to
kvm_invalidate_mmu_addr() as a boolean (yuck). Then, it can do the
root filtering inside kvm_invalidate_mmu_addr(). We can then plump
guest_mode into flush_tlb_gva, and handle flushing L1's ASID vs L2's
ASID completely within flush_tlb_gva.

But then we'll have to figure out what's the right value of that
boolean to pass from all callers of kvm_invalidate_mmu_addr() and
there's more things we can get wrong.
