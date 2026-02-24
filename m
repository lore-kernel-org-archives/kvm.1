Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993B1DFF0
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894938; cv=none; b=A1cFcUYjkUqiit5HojrzGxIkr6L24uUpIuWf1FwhsH+KCYC0iFplyo7nRCg9oHlnQm8FL67xOnEtfAM35N2Zq5GMmkr0ymYd9UjSxyE1j5PtJX7IAmWgfbyNLpBhWPnD10r+Xn4oUQFr8bzR9I1ipmoO+YIYUjnel9/ub3jNQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894938; c=relaxed/simple;
	bh=s8JIpnu8OntIfRHiECUY96A5mR3QpMa8WB+CmIPbyT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E76NaxrrC8JrJ2pXETk7QYhRZrqOLZBRaLOeqXJkyv2Pe9rL+2JTvNjN/M0N3i4tFEiR8pCxrrupCPBak42ZcFEOgeQTPT5dorxzkcCLYUqAk3VING2dTYuWXD5OsYa5FNKuCvEy3WLIaoLK1hbNo5giw7A6nLjrTMWFUg9WP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWgQcPu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWgQcPu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB70BC19421
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771894937;
	bh=s8JIpnu8OntIfRHiECUY96A5mR3QpMa8WB+CmIPbyT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWgQcPu3CY3n0gBLYFlq+odV9K/BwmJsMPVjKgq96elApybTk23RlaaTGfXQYKLpM
	 E4OrRw4JzuaQqQboCWPDB8bK0E7YAmi+pK8BYCGDLnuWZdJ66d7VLL/wpe0qr39H9b
	 Rd6PJmBQYc8MLTTH0Ko6w4SGh2y/rDCYwAHtskL6woLy6vaVjnyTxnVtbBBNbxQVnZ
	 5zGgDwIiqzMoPu54Gp9biwWq+jekq6LerKWZQwrrBFGrIS9TggRdqyg3rraGlmAJ5h
	 eauUD9vKZQH3LjL4k1MmhigcNZWaLE7ulWdXVI7wl4nSsEb686ItH9z1QvpL1jyHHB
	 IE342pJDg1fWQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65a380b554bso9679501a12.2
        for <kvm@vger.kernel.org>; Mon, 23 Feb 2026 17:02:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7xmoSrEb6V9OKuO2qdeqqbzknnOrfRtBqsCJ+0NS7ZXsm/eFU40zA+0BakEyDWWnNcR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdaq2JMi/c44kiG5WRy9n4bJ2V6KvwVCY7YRDjhnZ2zeM3G22
	uagoSVqJv/nXQt/usfQGxKeYC6j03L+nJ3RYT5Qh0A2xeQNF/uxRmeYgo7epsdBk3k6z/JSd0bQ
	lhMolRsxgwP9Cw1uZ3U+ul2fQ172dp/Q=
X-Received: by 2002:a17:906:eec4:b0:b91:949a:721 with SMTP id
 a640c23a62f3a-b91949a077emr64726566b.50.1771894936615; Mon, 23 Feb 2026
 17:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
 <20260206190851.860662-26-yosry.ahmed@linux.dev> <aZzfhY1qigh71n2e@google.com>
In-Reply-To: <aZzfhY1qigh71n2e@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Feb 2026 17:02:05 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP1hwzgX3iXDu3TuYQAiqdKrSOw6yuLL+PQFwm=CH0Lug@mail.gmail.com>
X-Gm-Features: AaiRm51nu4nsH-U0iKHQ2hvIXzsAlCUD6RyD8qPwLpLX0_8SHlGNaHTyULP2gCc
Message-ID: <CAO9r8zP1hwzgX3iXDu3TuYQAiqdKrSOw6yuLL+PQFwm=CH0Lug@mail.gmail.com>
Subject: Re: [PATCH v5 25/26] KVM: nSVM: Sanitize control fields copied from VMCB12
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > For the remaining fields, make sure only defined bits are copied from
> > L1's VMCB12 into KVM'cache by defining appropriate masks where needed.
> > The only exception is tlb_ctl, which is unused, so remove it.
> >
> > Opportunistically cleanup ignoring the lower bits of {io/msr}pm_base_pa
> > in __nested_copy_vmcb_control_to_cache() by using PAGE_MASK. Also, move
> > the ASID copying ahead with other special cases, and expand the comment
> > about the ASID being copied only for consistency checks.
>
> Stop. Bundling. Changes.
>
> This is not a hypothetical situation, bundling small changes like this is quite
> literally making review take 3-4x longer than it should.
>
> The interrupt changes are trivial to review.
>
> The I/O and MSR bitmap changes are also easy enough, but I wanted to double that
> PAGE_MASK does indeed equal ~0x0fffULL (__PHYSICAL_MASK is the one that can be dynamic).
>
> I disagree the the tlb_ctl change.
>
> Moving the ASID handling is _completely_ superfluous.
>
> Combining any two of those is annoying to deal with.  Combining all of them wastes
> a non-trivial amount of time.  What should have taken me ~5 minutes to review is
> dragging into 20+ minutes, because I keep having to cross-reference the changelog
> with the code to understand WTF is going on.

Sigh, I kept it as-is because these changes have been together since
the first or second version. You did mention cleaning up the
definitions being split into a different patch (which I did, and then
we dropped it entirely), but I thought keeping the asid and tlb_ctl
changes here were fine.

[..]
> > @@ -499,32 +499,35 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
> >       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
> >               to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
> >
> > -     to->iopm_base_pa        = from->iopm_base_pa;
> > -     to->msrpm_base_pa       = from->msrpm_base_pa;
> > +     /*
> > +      * Copy the ASID here because nested_vmcb_check_controls() will check
> > +      * it.  The ASID could be invalid, or conflict with another VM's ASID ,
>
> Spurious space before the command.
>
> > +      * so it should never be used directly to run L2.
> > +      */
> > +     to->asid = from->asid;
> > +
> > +     /* Lower bits of IOPM_BASE_PA and MSRPM_BASE_PA are ignored */
> > +     to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
> > +     to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
> >>      to->tsc_offset          = from->tsc_offset;
> > -     to->tlb_ctl             = from->tlb_ctl;
>
> I don't think we should completely drop tlb_ctl.  KVM doesn't do anything with
> vmcb12's tlb_ctl only because we haven't addressed the TODO list in
> nested_svm_transition_tlb_flush().  I think I would rather update this code to
> sanitize the field now, as opposed to waiting until we address that TODO.
>
> KVM advertises X86_FEATURE_FLUSHBYASID, so I think we can do the right thing
> without having to speculate on what the future will bring.
>
> Alternatively, we could add a TODO here or update the one in
> nested_svm_transition_tlb_flush(), but that seems like more overall work than
> just hardening the code.

I will drop the ASID change.

I honestly don't know where to draw the line at this point. Should I
split sanitizing all different fields into different patches? Or just
split the tlb_ctl change? What about the I/O and MSR bitmap change?
