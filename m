Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE34336886
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259734; cv=pass; b=Tt3WB998nBflAfsUV9YWEpkIysUDOqffcvZbxw2bqxaqu10FbJakK4kkhtq3RFiMTM181QBkQFOGb5LO8QqVsZRulz2BW4o8ZPJfXdDE2TZiNuI12TollE4TxOpzAYbw9M7wl/yeUQ5+LFIr89VSa2D6iHg6QwRs8c8XRFLw6e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259734; c=relaxed/simple;
	bh=cSHsN/QByA55pUXAbrusDOJEz5YCa2tEtCfaHQCIhCw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpolREu/IelF4j1kNuS1taVmzWfJBruhQz7GTs7NYyqvqGC7/5HC7P9X2nusy/Hj7FJX99NpVmmg1c80ydBIetN7M1RPvn+S2+z6v7pYwA/+6hVkZE+oZFu+BbZFLIR6IreMwY7Pq5ftr8lvdnvoQ7o9vwaFaSWTF/y8EHdQoiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ov9plJzz; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ov9plJzz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceae1ed204so48647235ad.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 20:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784259733; cv=none;
        d=google.com; s=arc-20260327;
        b=AE9XAIWiQ7z8gDLMAZ3WAAsGXhAee+cCXOnTZJqC1N5Jvex3Ntl0qo/X2dN1VdpJPh
         r8OYj17D0K1gLU8GwXcTh/R/MbyP6opKG1Rbv2GuAPCIC6U17Mcr8OdhlR5g4tCyhWL+
         Gk9RhHiXuaBzMKvEapdRYhJiyS/LMicZF1eas07cyHz1LFlcZO9Wyq71KFiRJG6PKJ/O
         AHi+P3SbTMHL7ALDCFzsV95ozaOk8vcxkTk2PxtPWAVMB6eO/p7dKFZeRSv9hLRNw1tb
         undBima5yHF4R+XajPaCXhIiV51I53zyTg/MWJKpx4MvHA8X2dv3f8+9vsAOFzwcqwNb
         frCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IjvV+kC1izo8ob+lKjb7UHIRcibAdgzq/FYgt+iaHzo=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=CcwwIcB6SDMfPQL4yCEJ18R5Eyg9uhjEw0B+hIDAYSUcoiAsQ0u2fkRHWhYSy1czy0
         QXGAECtPP7TYZmBUNeJ5VhHnCrsQBKxCM6N9z/g4ZS9RaaxAeo7N/26LCCx1uFt7bzHl
         fggYgL5ig9knjkKuJbu8SIveOEuXiD7KnboXw9101Y0Sx6NsWL3CxTQK2ErK2IFdv5HJ
         yYzwtYCx2OixGWH5MyoYTIeHJpUAK8JqeiA/z7RvMSC0ZbCZh8BS5EiU+XYvkXcYYWV7
         R/JHFRBl0wpLj29dqY7wVU9hpMfx3jw5YfOYct9c9W9mu4MRH9WEyftubx2Cun2tgeeV
         JZeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784259733; x=1784864533; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjvV+kC1izo8ob+lKjb7UHIRcibAdgzq/FYgt+iaHzo=;
        b=Ov9plJzz7D7bnXCHLuYJZW50MYNx0A/4yf86/1d+7Rc7tCJqSXJw7flRoqsRReF08k
         xTcdq58ffmByI3XlmN/G/m1SltsEmKJ28+KpCYFiEyf0BHR46IJKWdv4EsD9BwQ+Ht6w
         dLm+myw1rAdVt87rw5+3YF0wI1pHdhwYuAMdceQyA1AbV9pbDmwJ/74Sr9u9yvGiUXTz
         2CrBEUZc5NFLUYrUhjerKlv7PO6HB761aUAWZdBSmVc5IGQwWDDMdMHMQBiv31rkciuQ
         ops5XN6/RkoQNCtMFF1IzL4f3nBMN5Z53wQVICkoddE1cTDDmd1dePCl9ILVKiY6Qu9a
         klYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784259733; x=1784864533;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjvV+kC1izo8ob+lKjb7UHIRcibAdgzq/FYgt+iaHzo=;
        b=JlHzAP/kpxLhRpQKFTAP5FnWScXNy5DXdfX6GLtzT4R1zCWKrBuBcrK87CByTPrMS6
         JOBw+wamBYHDUV7fBVlPRL48JaPg07Rvmfu9hb/GQir1PsimkPF8I4QML8iBi0uCh2FN
         MLaij8eGOPzoSUDcp+kyV9oGZ2mHsQ5AnVMZVEAgSnuDYc/dRAXszxdaJBknVg82hKoV
         qKp+eMEqGoAHbldOY2pxruH4HPBDKudpQwLQYGBX792LXUj5V8/FAJk+0BbYrvYN0ZB4
         wR8A/1D4hP2iiygLfl5xDSfwk3Ro/Y+mB5x3WQgct5j91m+BN+G3pr/fJiK2GIVFw1J8
         CqZA==
X-Gm-Message-State: AOJu0YyHy/yb2TUB601atUO98U22Tj09Wgtaeh12C/+3iJWchHcirDJX
	VioZOsdoZnGEJ62TBhOl2Y4SYFfs5sOTkdHtoFMKWcb2xWNhgQL7X8SYHwSxr4bL+1TPJqbmZXk
	lqG5XMR57k+4g1+NEg1X6K8/fL1Y6uPRfibCYR2eF
X-Gm-Gg: AfdE7cmQpBDPfLiUAemFfazomT0krCaA8eu5QWTlqSV896mdKLKh7+OCNPuGR69J2tu
	JSmVHANa7w4H0iJUjQsx0AlEZkN97L0QzxjD6btv7llabtY7AzzdgR7SM/RTAAXZxkPldVhilRP
	H4AP0banP706s2wPon5UaAede5K9ZtJjBUx6rRZgeq8esub4s+c73t0yrND7Eefyv0g0JeJuhrQ
	fxtVnQWCGTgIW9tAcFPTvTLe5tApOOphjXGZdEbGP7JghQ2FolNS6Nevk6NL5BXfqbCyHt5wClu
	AWdRlXUhMiaKyO0Sug==
X-Received: by 2002:a05:6a20:4310:b0:3bf:bde7:d679 with SMTP id
 adf61e73a8af0-3c3ada190aemr787849637.40.1784259732193; Thu, 16 Jul 2026
 20:42:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 20:42:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 20:42:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-7-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jul 2026 20:42:10 -0700
X-Gm-Features: AUfX_mx26S6D0P9wrkT7oExBx4M-OPBgfG2_Qnvd66C8_9gz0Ttc_33YBo0mWrA
Message-ID: <CAEvNRgFFEfHZTZOi_anSJDhqPvncuRiXxJt9hcRnAW9FPdFY+Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Smush x86's prepare() and invalidate() hooks into a common convert() flow,
> as they are effectively two sides of the same coin for SNP: they're invoked
> when private/shared memory is about to made accessible/visible to the guest
> or host.  I.e. prepare() is really "make private", and invalidate() is
> really "make shared".
>
> Using a single hook will yield more intuitive code when in-place conversion
> comes along.
>
> For all intents and purposes, no functional change intended.
>
>
> [...snip...]
>

I just tried this out with in-place conversion and I'm stuck trying to
make a call to kvm_arch_gmem_convert() in the conversions ioctl.

I think we wanted to have a single .gmem_convert callback rather than
.gmem_prepare and .gmem_reclaim, but it turns out that it's not quite
easy to just call convert, because I need to pass both gfn and pfn to
.gmem_convert().

The conversion is called on the inode:

   __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 			     size_t nr_pages, uint64_t attrs,
			     pgoff_t *err_index)

Then guest_memfd would call

   kvm_gmem_convert(inode, start, end, to_private);

It is easy to get the kvm pointer for .gmem_convert(), but then to
always pass something for gfn and pfn, I have to make sure that

+ the folio was allocated (to get a valid pfn)
+ some binding exists for the index (to get a valid gfn)

So for each folio that exists, I would check if there is a valid
binding. If there is a valid binding, I compute the gfn, and if there's
no valid binding I pass -1ull for gfn.

I think this is a little complicated and not actually all that
intuitive...


Looking at KVM_AMD_SEV's Kconfig, it selects 4 gmem lifecycle callbacks:

    config KVM_AMD_SEV
	bool "AMD Secure Encrypted Virtualization (SEV) support"
	default y
	depends on KVM_AMD && X86_64
	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
	select ARCH_HAS_CC_PLATFORM
	select KVM_VM_MEMORY_ATTRIBUTES
	select HAVE_KVM_ARCH_GMEM_CONVERT
	select HAVE_KVM_ARCH_GMEM_RECLAIM
	select HAVE_KVM_ARCH_GMEM_INVALIDATE
	select HAVE_KVM_ARCH_GMEM_POPULATE
	help
	  Provides support for launching encrypted VMs which use Secure
	  Encrypted Virtualization (SEV), Secure Encrypted Virtualization with
	  Encrypted State (SEV-ES), and Secure Encrypted Virtualization with
	  Secure Nested Paging (SEV-SNP) technologies on AMD processors.

So actually smushing .gmem_prepare and .gmem_reclaim doesn't really save
us CONFIG flags, and results in a kvm_gmem_convert() that needs to find
the intersection of folio and binding existing just so the .gmem_convert
call is valid for conversions in both directions.

If we set kvm_gmem_convert() up to do handle make_private() and
make_shared() separately, then I don't think there's much value in
collapsing .gmem_prepare() and .gmem_reclaim() just so we mux on the
caller side and demux on the SNP side.


How about this:

1. Retain .gmem_reclaim() for "host reclaim" aka "return to host" aka
   "make shared" for x86.
     + Rename the make shared function to sev_gmem_reclaim
         + .gmem_reclaim = sev_gmem_reclaim
     + pKVM will defined kvm_arch_gmem_reclaim() to do what it needs
     + TDX and ARM CCA don't use this callback.
     + From __kvm_gmem_set_attributes(),

         if (!to_private)
             kvm_arch_gmem_reclaim(pfn, nr_pages)

     + From .free_folio()
         kvm_arch_gmem_reclaim(folio_pfn(folio), folio_nr_pages(folio))

2. Rename .gmem_prepare() to .gmem_grant(), or .gmem_assign(), something
   that is the opposite of "reclaim", that indicates the host
   granting/assigning/linking (other names welcome) the gfn <-> pfn
     + Only SNP will define this
     + .gmem_assign = sev_gmem_assign(kvm, gfn, pfn, nr_pages, order);
     + From kvm_gmem_get_pfn()

         if (kvm_gmem_is_private_mem(inode, index))
             kvm_arch_gmem_assign(kvm, gfn, pfn, nr_pages, order);

I think it is fair that "assign" or "grant" is only called for private
pages, since only private pages need to be "given" away.

On the reclaim side, it's also fair that only shared pages need to be
reclaimed.

And with this, we still have 4 CONFIGs just like above, except that it's
now

	select HAVE_KVM_ARCH_GMEM_ASSIGN
	select HAVE_KVM_ARCH_GMEM_RECLAIM
	select HAVE_KVM_ARCH_GMEM_INVALIDATE
	select HAVE_KVM_ARCH_GMEM_POPULATE

And I guess it's more straightforward that one CONFIG selects one
callback, avoiding having either of the CONFIGs select .gmem_convert():

> +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> +	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			    kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
>
> [...snip...]
>
