Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E9306741;
	Fri,  3 Jul 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096025; cv=none; b=DveUIZZWd60s6vMYDygpc6ZDHe6H7Q4N8aZGZdbgK6Un+CLIsaYos7JiH3hPBl+f5NnSaX52dxUpoafuGdhD91pBWZExox36/8Bq53XOqn0QAD74jbU7IkWD+THb0LzTlHEkz+9v1y1my67fs/hmgUScxX7gFgTZINGJrmpItQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096025; c=relaxed/simple;
	bh=gLeOgg/2mAvuSCeDLWBTYJFSaCUYFfJrn+Q4vi1oE68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHjhaKpRHTkiNg3B9TLmMKAH2Wwlfvu8g3DyM8khIZZhVlv7gt9hIhmH1tYgS1adhwZ231p6t0rzUzXhE9ljdNo695xSrwypSr11qr50qeMDs+3WDRFsaOPUyLX8X0b1YwJ4TIeS/ogjdFsl2MKrugGr7+ZBnQuYy9Iz9CjKaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoP8GF0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoP8GF0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098941F000E9;
	Fri,  3 Jul 2026 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096021;
	bh=iiWETOTAKsGjM8rBgE5AKDzmVl21CrkTLVqjKQ5RK2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HoP8GF0mJGEjchRGDoOrIVv7qVo6tMkdEYDyxeVuQn8phd2o1qDuZwyUfFx3qFh+w
	 BM3lZqndsZAEp8FiMB9pfKfQV0F2SP37G9eXmEHYvT2FVqoqo9XPRwVauKhlE+lyBW
	 8vNYr9rEkSJSRvFN1T7hTrxLDGX0bT8hAZsBnoE6+bD/OGh1xg0ugFz0ZY0YTqulUQ
	 QdUTdEBUJfRAjay7a6tJE0tC6SpqlLj3U6pMs2NRf+ywweMw5k+hFZC6aveoIOPFCU
	 c5493LtAHCVxDLGIzfqlxZTWj7l1NUxe6Htzntwo6CkPFTy0JlAf5TESjcB58Ptlj/
	 mUFUJCblrFv2w==
Date: Fri, 3 Jul 2026 21:51:59 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: SVM: Drop unnecessary avic_vm_destroy() call on
 init failure
Message-ID: <akffsFoCvlyz5y9S@blrnaveerao1>
References: <20260625220933.3357733-1-seanjc@google.com>
 <20260625220933.3357733-3-seanjc@google.com>
 <akJw3nXeWO-Xavc5@blrnaveerao1>
 <akMLDayXmzhmvJBG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akMLDayXmzhmvJBG@google.com>

On Mon, Jun 29, 2026 at 05:17:17PM -0700, Sean Christopherson wrote:
> On Mon, Jun 29, 2026, Naveen N Rao wrote:
> > On Thu, Jun 25, 2026 at 03:09:33PM -0700, Sean Christopherson wrote:
> > > Don't bother calling avic_vm_destroy() when allocating the logical ID table
> > > fails, as there is nothing to clean up now that the physical ID table is
> > > allocated later, on-demand at first vCPU creation.
> > > 
> > > For all intents and purposes, no functional change intended, as calling
> > > avic_vm_destroy() is a big nop in this case.
> > > 
> > > Fixes: 54ffe74cc4ab ("KVM: SVM: Move AVIC Physical ID table allocation to vcpu_precreate()")
> > > Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/svm/avic.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > This LGTM, though I'm not sure this deserves a fixes tag.
> 
> Yeah, it's borderline.  Because KVM (x86) doesn't do AUTOSEL, i.e. requires an
> explicit "Cc: stable@vger.kernel.org" for the vast majority of cases, we can be
> very liberal with Fixes.  And so I like to use Fixes to create a paper trail for
> anything where a commit did something that would have necessitate a new version
> of the patch, had it been caught in code review.

Ah, that's the reason for preferring Fixes: tag over Cc: stable, got it.

> 
> > FWIW, I have had a patch (part of a larger series I am going to post 
> > soon) to move the logical_id_table allocation alongside the physical ID 
> > table allocation. I'm fine if you want to queue your patch first, but 
> > this is what I have locally:
> 
> Ah shoot, I should have read this mail earlier.  While floundering around, trying
> to figure out how to deal with kvm_arch_pre_destroy_vm() not being called when
> VM creation fails after kvm_arch_init_vm(), I ended up with the same idea, though
> I moved *all* of avic_vm_init() to the vCPU-precreate phase.  Because what I
> needed was to defer adding the VM to the GA Log list until the VM is fully
> created.
> 
> > @@ -303,10 +303,16 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
> >  	if (kvm_svm->avic_physical_id_table)
> >  		return 0;
> >  
> > +	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
> > +	if (!kvm_svm->avic_logical_id_table)
> > +		return -ENOMEM;
> > +
> >  	kvm_svm->avic_physical_id_table = (void *)__get_free_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
> >  								   avic_get_physical_id_table_order(kvm));
> > -	if (!kvm_svm->avic_physical_id_table)
> > +	if (!kvm_svm->avic_physical_id_table) {
> > +		free_page((unsigned long)kvm_svm->avic_logical_id_table);
> 
> Freeing the page on failure is "wrong".  To keep vCPU creation idempotent from
> userspace's perspective (well, not truly idempotent, but close-ish), KVM
> deliberately doesn't unwind if .vcpu_precreate() fails.  E.g. so that if
> allocating the tables succeeds, but a later stage of vCPU creation fails,
> subsequent calls to create vCPUs won't fail at the earlier stage.
> 
> The nice thing is that since the VM has already been created, there's no need to
> every unwind on failure, because it's no different than if KVM had successfully
> allocate the assets during VM creation.

Understood - I see there is a comment about this in 
kvm_arch_vcpu_precreate() which I missed. Thanks for the details!


- Naveen

