Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01175342C80;
	Mon,  1 Jun 2026 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357125; cv=none; b=nCD0HRNGPf5CScxRILtt8K5CgpgAF9wyzJd/YJbDbO3rXhlz7V7+0+GHfyeM7L9PZq3bO4J4h7i1Nbix7bkJz0ICkMl8wNki1OTMbomnRJePvAioAoh2K9KRnRZ8VRAjCmWlqjecxoTuLUpmwO1Ir7pHSPaS3RtvNuCjE2Wif+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357125; c=relaxed/simple;
	bh=q/jTq3FK9vyBfysq8ZyNXe1W+b/yDwhIPtdDwfcEadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOWmwn7MC9cde5fFpen9GJzb15jG3pjPkqqShZ0jBkaH5R/2JCWuRB38velEQ/xTsPF7pzblyw/7yh1k1EZ18u7onocAR60eGQxnLRBjjCKas7Ehlh9hLZapkSNdV80xCSvoV3HT6Wn+H4OJvHOpNCcKgHNoFDNUHCM0iJ+0UyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeuroXxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeuroXxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338251F00893;
	Mon,  1 Jun 2026 23:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780357123;
	bh=lkqnyfNb1zN981hebcWavOL0eM1NE8Z/ix2kL8qLHnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZeuroXxbuoNOpLCKnNk2B8mPMFKQhLxlIxMswWQV3KAcqFHCeBe2rg3Z66PoXksjR
	 zl/68tAYnxHuuCBbYpaDg+pLXW+gyLmigkpMRTdt8dsSmWi875HIC7HBKrF228Q3qU
	 Xu+N4wM1LLQUhi6YJxT6PupASO8/dEd7iT1CcLE5krg6gpLDsN/SJKVUjrZtugEwWm
	 ETwVUTk+Uufkc2Kqqi28WL1jtY89BCcCM3imhTnv4DXrbMX78cRXXCnRJsBGo4LsZe
	 x7JuqcGdH0tK+UOGMHHnO4pRxGIutHmQjU7yma3LXg2/5InSyEt7vvcyQ/wl2WWblr
	 C7rh8pMdZuiJw==
Date: Mon, 1 Jun 2026 23:38:41 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
Message-ID: <ah4X-wgIj98hxmGe@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-31-seanjc@google.com>
 <aho2Pcc5p-HUUKji@google.com>
 <ah2cOnXIgjKj1iv8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2cOnXIgjKj1iv8@google.com>

On Mon, Jun 01, 2026 at 07:50:34AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:22:13PM -0700, Sean Christopherson wrote:
> > > Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
> > > x86's kvm_host.h to msrs, to continue trimming down kvm_host.h.
> > > 
> > > Deliberately leave the funky read_msr() where it is, as it will hopefully
> > > be removed entirely as part of a broader kernel-API cleanup.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h | 26 -------------------------
> > >  arch/x86/kvm/msrs.h             | 34 ++++++++++++++++++++++++++++++---
> > >  2 files changed, 31 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index a861c0d70be0..1143140592df 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -2094,7 +2094,6 @@ struct kvm_arch_async_pf {
> > >  	u64 error_code;
> > >  };
> > >  
> > > -extern u32 __read_mostly kvm_nr_uret_msrs;
> > >  extern bool __read_mostly allow_smaller_maxphyaddr;
> > >  extern bool __read_mostly enable_apicv;
> > >  extern bool __read_mostly enable_ipiv;
> > > @@ -2278,18 +2277,6 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
> > >  void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
> > >  void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
> > >  
> > > -void kvm_enable_efer_bits(u64);
> > > -bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> > 
> > Patch 15's changelog makes me thing EFER will belong to regs.[hc] not
> > msrs.[hc]. Did you change your mind?
> 
> Not really, patch 15's changelog was always "bad", even in the previous version,
> before msrs.{c,h} was added.  The bulk of EFER handling was left behind in x86.c,
> only the {G,S}ET_SREGS accessor/mutator logic gets moved.
> 
> I updated patch 07's changelog between v2 and v3 to better reflect reality:
> 
>   Move *very* select EFER functionality as well, but leave behind the bulk of
>   EFER handling and all other MSR handling.
> 
> But I missed patch 15.  For patch 15, how about this?

LGTM.

> 
>   Introduce regs.c, and move the vast majority of register specific code out
>   of x86.c and into regs.c.  Deliberately leave behind MSR code, as KVM's MSR
>   support is complex enough to warrant its own compilation unit, and doesn't
>   have much in common with the other register code.
> 
>   Note, "struct kvm_sregs" has fields for EFER and MSR_IA32_APICBASE, and so
>   the {G,S}ET_REGS flows technically contain a tiny amount of MSR code.  
>   MSR_IA32_APICBASE is already managed by lapic.c, and so doesn't require a
>   "placement decision".  As for EFER, leave all other EFER handling in x86.c
>   (later to be moved to msrs.c), as the primary interface to EFER,
>   set_efer(), is very much MSR specific, even though EFER is arguably more
>   of a Control Register than an MSR.
>   
>   No functional change intended.
