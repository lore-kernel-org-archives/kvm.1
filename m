Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52239C005;
	Wed, 22 Apr 2026 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888208; cv=none; b=ohNArc8kzz7s2h812KwO2H7r3wGav4hYRPYyluiVc4+jKaX/F80rhaXlGnAxToMzheZw5Q5U10unRbKK6wv/AQbNY/oeT/2mYfh6kzxel4o/EMS1PhYOPuO9PVQvKKsHxdXXpKfgqL0vo9p586j6ck2Qe3/Z/JH12b7jZXCN8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888208; c=relaxed/simple;
	bh=y1gijm26YtikRwAvJdabwconR7KTfgs+W6W1zsNDTeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYoZyssiV/WKi5qllhuHJtKdzbwg1X6C6wdW6BW7yHR4qti6wYjBmXRM1F15hCokwU0Sc9DqUmqUj82ZILbGblTSQV8tPzW2lbmYDizQEUIpive/JXEbcarK2bAFk5tfeJ1x9Y7E4XrfgTUkBgCiML0Ag5K7M0mjYvJFelME3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1TOHJEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1TOHJEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AB4C2BCB4;
	Wed, 22 Apr 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776888208;
	bh=y1gijm26YtikRwAvJdabwconR7KTfgs+W6W1zsNDTeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1TOHJEONdoVHrhfK3awt7a9rFOI7tURj4MgSm5+QKtZoAvqJQmfIZ9yBVM3o8Axp
	 Z6yzVBzt0dJYx4nXBhVevcl8gy9cLDKwcFz1FT4uu/CoppPjbAEjGAdFYgcUJ2Xb4z
	 FjTg81AgDzZ4W3wwzZtpfxAkDowZpzS5cGNI6IHsmbTG3doEDLnqTp40RBi4FC6jrt
	 BNOZdS6TPWSR9hea9OEW6IWgJWc59/vyBfbIww2NtZ2HEtZgGDIn5j9MIaHnF/+3MD
	 3acEt9GanTHY5TRgMDZnBcgZxUIQu709NUJ+9JwPfDR0kKl3BeDiSCw4nkUtGJE8M7
	 l+oSl7ud5Qt1A==
Date: Wed, 22 Apr 2026 20:03:26 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] KVM: x86: Move kvm_<reg>_{read,write}()
 definitions to x86.h
Message-ID: <aekooHTCPGN84ckq@google.com>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-7-seanjc@google.com>
 <aegIHrL1pqnRkhDh@google.com>
 <aegY4FF2n2t5B4pz@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegY4FF2n2t5B4pz@google.com>

On Tue, Apr 21, 2026 at 05:40:00PM -0700, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > On Thu, Apr 09, 2026 at 04:56:17PM -0700, Sean Christopherson wrote:
> > > Move the direct GPR accessors to x86.h so that they can use
> > > is_64_bit_mode().
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/kvm_cache_regs.h | 34 ----------------------------------
> > >  arch/x86/kvm/x86.h            | 34 ++++++++++++++++++++++++++++++++++
> > 
> > That's a shame, register accessors semantically fit in kvm_cache_regs.h,
> 
> Sort of.  I actually had the opposite reaction.  KVM very specifically doesn't
> do available/dirty tracking for GPRs, in large part because it's not a caching
> behavior per se: vcpu->arch.regs[] is _the_ source of truth for GPRs (modulo
> RSP on Intel).
> 
> > but taking a step back.. is it even worth having kvm_cache_regs.h
> > anymore?
> > 
> > At some point I needed to move guest mode helpers out of there too (as
> > they should be):
> > 
> > https://lore.kernel.org/kvm/20260326031150.3774017-3-yosry@kernel.org/
> > 
> > With this patch and that one, we'd have <200 lines left. Is there a
> > reason why it can't just be merged with x86.h? I don't see any of the
> > headers included by x86.h including kvm_cache_regs.h.
> 
> What if we go in the opposite direction?  I didn't try moving e.g. is_64_bit_mode()
> into kvm_cache_regs.h because that reaaaaaly stretches the meaning of "cache regs".
> 
> But if we rename kvm_cache_regs.h to something like kvm_regs.h, then I think we
> can move more of the simpler accessors (and mutators?) into kvm_regs.h.  The
> motivation would be to keep x86.h from becoming a chonker.  One of the regrets
> with x86.c is that it became a dumping ground for everything that didn't have an
> obvious home, and now it's sitting at nearly 15k LoC.
> 
> Naming is hard, but if we can come up with a kvm_blah.{h,c} pair, maybe we can
> kill two birds with one stone?  Or at least kill one, and injure the other :-)

We can do that, and name it kvm_regs.h or even kvm_accessors.h or
something. But then we'll sink some time into figuring out what needs to
be moved from x86.h to that header, and we'll occassionally need to move
things back. For example, the patch I mentioned above needed to move
guest mode helpers to update the PMU from there. We may not need that
anymore, but I think it's possible we run into this situation in the
future again.

We'll also spend more time nitpicking where new definitions need to go.

I understand wanting to split things up as much as possible and keeping
the files small-ish, but for headers specifically I wonder if it
introduces more problems than it solves, specifically because of
circular dependency issues becoming easier to run into with a larger
number of smaller headers.

So my (very unimportant) opinion is still to merge kvm_cache_regs.h into
x86.h, and we can always revisit later if that starts becoming a real
pain.
