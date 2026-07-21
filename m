Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68E3E49C3
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650256; cv=none; b=VWrwp7P2Cq8ZI6Jc7fSE3JFM/2CUWaxnzRA/5w8C2ke86vzd2tV1lhC0y26KZF2Uur2Af4YIfeHlYHlgjN18Sc4ch6/yUBbAblb5HdoC4o/oNhMSrD/ClvnfQQzUAJK4IdGrSI2beGHk8jnvjDu4MZL16TprorvCYQZvpjMHRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650256; c=relaxed/simple;
	bh=cYUYwc7xExaylEbRReKR8WGgqDZ922BzHxOJkybE2jA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KcwCA5JGyFqLwrXEjGlK7KpsRjcMgxHSfS7P9k+snXlP0JP3FuwVyl1hr++5g1H1vqdM8OqoF7X9l5ZEGXkNaxouKbceluB+1NASfnWmVxCaMmyQaVf8cldEFL0VGs51+EIb+8iRnL3Mu7/MamGUpf9fUOZ044BMgtBKfdpsSqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whWAtOT+; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whWAtOT+"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so8697461a91.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784650255; x=1785255055; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWcnFcVmJhLs/PJEHyp6/95iFzsPnruaaz9EWTtVRX8=;
        b=whWAtOT+n/+HR8EUMmlPCICFLjzIOqU7owBuLlf9oGyuxCQpPrbZIcfs5cibgapqRm
         bcMsJzdL5YqkUG43OzuCsLmDc+OlLjwwWo+vJiMRC9ysTCoDJmN9RV9VFCcxUBFIak5I
         ScT4bGgDGNsCTQ0oci+3sMOhWu9JtHfOCYzf3NxbppzI3oSMKXrJOM9CE7MAEkeXBI1Q
         gEc+4l7qsRhbdlCpIwpb2h3fOvRH40S9bcVGBLU+N6x2bMQBaCrIGKEWkO0/hUO8RYlA
         XIG/W255EjYsM4w1jlek3++H/HP6k4X351Ow7IdQRHilRVyZUZKUV0ryWPMdQD1Fkfk5
         WDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784650255; x=1785255055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWcnFcVmJhLs/PJEHyp6/95iFzsPnruaaz9EWTtVRX8=;
        b=nHJKGADXqTejNZ0MpHbRKsKRR7Yqw/PIiZjIwGdqWnD8fv0zPEkc9/RsXZhYuKBc5F
         ikk4aINJsJPSS+2onQgFE0QeOxKO/Cs00EKkoZsrNiU0WXe2PBFPpBZ7vcSUUwiIWsJ/
         yWJOk2dL8RNRTvhDwDqntswuEZV3PxsDRfyKhwuyAkfKddxA2+n8v1FolpH+GN3DPEds
         a5UIx9P64CHN3HXYsBTcWL5HYQiOMR8WfOenZerMZavaUfLV+zIXwZot3FcLC+unw2zT
         hRNEHYiJlAPfZ5tZgfJoMDanQhGPr8F6UqCqAejlZXSnnZLz5g3cOAQOb8sKTa39xWKX
         ko2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqIlkwvqU8HsxOktMb2kHZYYmJkslfNcNPGQq/hSPf51AvRKkVMMYhmq+GCnzcAa2cUTmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrO4zqCCUV1GXJWQOS/tj0Z6m/A4PwCY9ibSGnTQVur+pehbv
	cr80v3aMF5J3Up1ZmkvnG/xqGijgD2rIFTPzpFr3kli+dUTb54zVl0VnjAbu+wm9M7jYx+ixvCv
	1UiZgTg==
X-Received: from pjbbf5.prod.google.com ([2002:a17:90b:b05:b0:381:9084:d57a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1345:b0:38e:21da:9257
 with SMTP id 98e67ed59e1d1-38e4b56ed6amr20955842a91.37.1784650254437; Tue, 21
 Jul 2026 09:10:54 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:10:53 -0700
In-Reply-To: <CAEvNRgFFEfHZTZOi_anSJDhqPvncuRiXxJt9hcRnAW9FPdFY+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
 <CAEvNRgFFEfHZTZOi_anSJDhqPvncuRiXxJt9hcRnAW9FPdFY+Q@mail.gmail.com>
Message-ID: <al-aDRTbDOPT1UbM@google.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 16, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Smush x86's prepare() and invalidate() hooks into a common convert() flow,
> > as they are effectively two sides of the same coin for SNP: they're invoked
> > when private/shared memory is about to made accessible/visible to the guest
> > or host.  I.e. prepare() is really "make private", and invalidate() is
> > really "make shared".
> >
> > Using a single hook will yield more intuitive code when in-place conversion
> > comes along.
> >
> > For all intents and purposes, no functional change intended.
> >
> >
> > [...snip...]
> >
> 
> I just tried this out with in-place conversion and I'm stuck trying to
> make a call to kvm_arch_gmem_convert() in the conversions ioctl.
> 
> I think we wanted to have a single .gmem_convert callback rather than
> .gmem_prepare and .gmem_reclaim, but it turns out that it's not quite
> easy to just call convert, because I need to pass both gfn and pfn to
> .gmem_convert().
> 
> The conversion is called on the inode:
> 
>    __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>  			     size_t nr_pages, uint64_t attrs,
> 			     pgoff_t *err_index)
> 
> Then guest_memfd would call
> 
>    kvm_gmem_convert(inode, start, end, to_private);
> 
> It is easy to get the kvm pointer for .gmem_convert(), but then to
> always pass something for gfn and pfn, I have to make sure that

As I stated somewhere else, conversion to SHARED does NOT and *should* NOT require
a valid GFN.  Conceptually, a SHARED page can't be strictly associated with a
single GFN.

> + the folio was allocated (to get a valid pfn)
> + some binding exists for the index (to get a valid gfn)
> 
> So for each folio that exists, I would check if there is a valid
> binding. If there is a valid binding, I compute the gfn, and if there's
> no valid binding I pass -1ull for gfn.
> 
> I think this is a little complicated and not actually all that
> intuitive...
> 
> Looking at KVM_AMD_SEV's Kconfig, it selects 4 gmem lifecycle callbacks:
> 
>     config KVM_AMD_SEV
> 	bool "AMD Secure Encrypted Virtualization (SEV) support"
> 	default y
> 	depends on KVM_AMD && X86_64
> 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
> 	select ARCH_HAS_CC_PLATFORM
> 	select KVM_VM_MEMORY_ATTRIBUTES
> 	select HAVE_KVM_ARCH_GMEM_CONVERT
> 	select HAVE_KVM_ARCH_GMEM_RECLAIM
> 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
> 	select HAVE_KVM_ARCH_GMEM_POPULATE
> 	help
> 	  Provides support for launching encrypted VMs which use Secure
> 	  Encrypted Virtualization (SEV), Secure Encrypted Virtualization with
> 	  Encrypted State (SEV-ES), and Secure Encrypted Virtualization with
> 	  Secure Nested Paging (SEV-SNP) technologies on AMD processors.
> 
> So actually smushing .gmem_prepare and .gmem_reclaim doesn't really save
> us CONFIG flags, and results in a kvm_gmem_convert() that needs to find
> the intersection of folio and binding existing just so the .gmem_convert
> call is valid for conversions in both directions.

And I'm saying don't do that for the to_shared case.  If passing a NULL @kvm
and -1ull for @gfn from guest_memfd is too ugly, I'd be a-ok with providing
separate kvm_arch_gmem_make_{private,shared}() under GMEM_CONVERT.

I guess at that point I don't have a strong preference betwee having a single
kvm_x86_ops hook versus also having kvm_x86_ops.gmem_make_{private,shared}().

I.e. Option A:

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
				kvm_pfn_t nr_pages, int max_order)
	{
		return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
	}
	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
				bool to_private)
	{
		return kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false);
	}
	#endif

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
	{
		WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
	}
	#endif


Or Option B:

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
				kvm_pfn_t nr_pages, int max_order)
	{
		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
	}
	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
				bool to_private)
	{
		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
		return 0;
	}
	#endif

	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
	{
		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
	}
	#endif

Typing it out, option B does look prettier...

> If we set kvm_gmem_convert() up to do handle make_private() and
> make_shared() separately, then I don't think there's much value in
> collapsing .gmem_prepare() and .gmem_reclaim() just so we mux on the
> caller side and demux on the SNP side.
> 
> How about this:
> 
> 1. Retain .gmem_reclaim() for "host reclaim" aka "return to host" aka
>    "make shared" for x86.
>      + Rename the make shared function to sev_gmem_reclaim
>          + .gmem_reclaim = sev_gmem_reclaim
>      + pKVM will defined kvm_arch_gmem_reclaim() to do what it needs
>      + TDX and ARM CCA don't use this callback.
>      + From __kvm_gmem_set_attributes(),
> 
>          if (!to_private)
>              kvm_arch_gmem_reclaim(pfn, nr_pages)

NAK, pKVM doesn't want to "reclaim" on conversions to SHARED.  reclaim() and
convert() are two similar but distinct operations.  Irrespective of pKVM, IMO
it's also very useful to differentiate between "this page is being shared with
the host, but KVM still owns the page" and "this page is being freed back to the
host".  E.g. reclaim() *must* succeed or take evasive action, whereas convert()
can gracefully return an error.

>      + From .free_folio()
>          kvm_arch_gmem_reclaim(folio_pfn(folio), folio_nr_pages(folio))
> 
> 2. Rename .gmem_prepare() to .gmem_grant(), or .gmem_assign(), something
>    that is the opposite of "reclaim", that indicates the host
>    granting/assigning/linking (other names welcome) the gfn <-> pfn
>      + Only SNP will define this
>      + .gmem_assign = sev_gmem_assign(kvm, gfn, pfn, nr_pages, order);
>      + From kvm_gmem_get_pfn()
> 
>          if (kvm_gmem_is_private_mem(inode, index))
>              kvm_arch_gmem_assign(kvm, gfn, pfn, nr_pages, order);
> 
> I think it is fair that "assign" or "grant" is only called for private
> pages, since only private pages need to be "given" away.
> 
> On the reclaim side, it's also fair that only shared pages need to be
> reclaimed.
> 
> And with this, we still have 4 CONFIGs just like above, except that it's
> now
> 
> 	select HAVE_KVM_ARCH_GMEM_ASSIGN
> 	select HAVE_KVM_ARCH_GMEM_RECLAIM
> 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
> 	select HAVE_KVM_ARCH_GMEM_POPULATE
> 
> And I guess it's more straightforward that one CONFIG selects one
> callback, avoiding having either of the CONFIGs select .gmem_convert():
> 
> > +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> > +	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > +			    kvm_pfn_t nr_pages, int max_order, bool to_private);
> >  #endif
> >
> > [...snip...]
> >
