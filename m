Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41403358C6
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657585; cv=pass; b=alTeDGh9yv+lsaXKk4y3lF0e8r1wfVmAIaJ6VfcuLIHTigQX7hgSl+9Ok9hBBcVdYlDGu/L7vG0BCReeAMVJktHfwfcpUkG3LJwGMtInj2qmreBYrDSwUgiasslMNicsijtlBJ4OnpSy5j8N8WNHU/tOmADxPEcqYXZ/8J3qtX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657585; c=relaxed/simple;
	bh=qEKQ2TtDvTntId0bswa6Kfzj96HVJwY/kAcBceY/P9A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi5D13ffCXP8iyofv1KxU/l+N9q8D/NcIO3eT3EurVWyBUjPdBX0rFwGYI3h5+B6v5LlxNqOWG6JcR2Nn+L2PCXW7tlGiPJrn+n44m/mj46XGPflqBOm0E/9F7EYZ1mib/Q/BvvIH4vnuEDuNouhXui+Dak8LJRQGFi/tsa5okI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqQ+Nwpx; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqQ+Nwpx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c998fd549a8so7685091a12.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784657583; cv=none;
        d=google.com; s=arc-20260327;
        b=p9bgNzhrYI2CvoMyrkxSirppK4xdGKL5kVoMEi1m593NXIc+GR7DqhV50gQMqM9jjC
         5o9u0x0hSNM2Kq081IQqFZnMYIj1V7FftLjTalaLJlj3jYiKR8WImywMRwOEoy6GmFFD
         qVM8JWxV5nhzNBALX5ePhqXl9p9o0FpcdHw8NcTewPsmgAoC2i2gc5c7F3jOUAE/5IBL
         rpOgJaneW4cXW05joHfSKCUS6d/SqBbtsjIeYL3wrw7NL+jc2YBw52yR/XbTK6hPdeua
         wyNZ+hdcHSgUAywi9pMab+hK3Ws9SBQU1cGlj50fRFVif6gQxOrfc5wJ/BmQhQa1u/ku
         yiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=4n8TRzsrop6CsPjdlLO+QkZvK6zpfD0Lxio19Oq56To=;
        fh=P2aFYXzzBRirKoqsvDvvgkfieeJph83wFfvxrlDmWk8=;
        b=e3OagJsm9zCKnoZ/Ng6nuq7EkHfc/E9e2CNm+t/kq//aVY589GEsQfznPC0gv52pTv
         slFsxU8d24Abc5fHoMfVErZyP9Crg/U5RF4VVDYkgJrGTVOmlAKt9wckDTnklO80JAvQ
         q+q532reHsSjFIKLlxJtKl3TaWH4SH9+0/IdoE8BlQLvOZ3m76YC3JCgk2+tPXtixhuc
         x9dI8EJqt/y2avpKc9hP+34tZrphQoVFtv4QnzuqRrOkp6izLynqiYa9nUYWf1U87/tE
         ElO2CybYGtdjWrTJTcgjj9vFuAl8COGsJ2mOH7QKyfbprT4dp+ArDg8PyHtVaIUvkLdQ
         Y23Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784657583; x=1785262383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4n8TRzsrop6CsPjdlLO+QkZvK6zpfD0Lxio19Oq56To=;
        b=nqQ+NwpxbBkgEOrkqaOeiZxmFeQxzuig/xBK+qhiBtdZDTGfZVTuXCgGAa5a52RhNh
         9S1ETQ3F2Kgvopx4N9IaLkq5iaUL5Zua5xzVJa42KClqWxTPpNg6KyAMX70uY4TfyjB5
         9Ayo992JkEacGmTJEIYM8QyOvSTc57wM8ZW73YerJiaSE8MeU4hIpZz4kqa15rdyrKuB
         ysoSIWzdnqJCGvgm9ZbcZwKx7vNtOD2YqRAqh7pqsNnkBSgh7+IlOkfKZhSkpnP+U9qg
         2W1vYAOdydI89ibzbEmuXLg6TfICF9g+Qy2utcEKGm0OCT8RFfc1lPHkHcdLVG2flneX
         hxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657583; x=1785262383;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4n8TRzsrop6CsPjdlLO+QkZvK6zpfD0Lxio19Oq56To=;
        b=CtYtzidOPb0hbw2bMWnt6gifsdsIuiJLkAQICRgN7P30wXtAfsOsJxriNMnDnOlZYD
         NnghLzidOVkBYmVxuYlZREcj8WnLk8Im1EK+OedaaGSBfgAQ+Rjg3jCnp926IJlFDAnb
         latPzngp3W+8+DY70aKQaTZ+ynPhd/Y4AhxJzpNwRIxhzDUrHkjxZ0zDF4v6NfY+1mGM
         EoAPPkfuvthz6k4e00aUKLmiMz2XTLoqj9Ef+3bplG/hWPBWXmnO+yR3n7SvOAqg8tYV
         lnaA1rtPbz1vo7BFKPTyodoyXoVhYTnfaE0oxRG1HiIzy2DjjmlHgVLWO+TwHsM8vPhk
         flYg==
X-Forwarded-Encrypted: i=1; AHgh+RpOrPPg45WFhU3uU+mFm1s4WrtlQQH3zfp2xG2lcC+Uroim4TT4fbMfw8mKFs25P7lu7Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSopsEoJRDn/C8ce8qH+8l1mZ0iIXu8cDiGS9V52h4/5MnEwx
	SfUVO1bIxqCmUSC/JJvh0UbVm9iwB2lcaizvXTesIc1/igkzav3Sr8WJfXi78MqDBJgF4hxM090
	DoemjBUKUapzo8gBfn5BW/mSe9HxanprH3NO47oC82kTVkEqWGcc/+8p6
X-Gm-Gg: AR+sD13w3LOapcTGJM4CaQzzjZMyG3mmqQ9mSc10MIKjM1UOTPnS0Wk4AYYvFdWamsB
	dwifOIJokgyVrSJHDPu3fSWLto/zWtvGWgvPAIPSPt5s1gpuAZ1s1c5O8U5p5S1Dq34k7S9pTE5
	pmyWgaj0PeQYwXaPf7eNow8q34uzv8cjfwNQV6pxpGT/PSxGEpooiFunfq5eMGpLHni7dR4Pq30
	BvBWW3oasmtWtzzIXSqJrb4JAgV83yamZ9nAgGe1PFNLtsUWnJk1sdedaiI7EirOuda0iWG0Vyj
	ruOw4pHcDaKl7BtE0NRsTL1/6ZNEiH7U5rD4rpUYyvm0f+CI
X-Received: by 2002:a05:6a21:6110:b0:3bf:a0e5:999a with SMTP id
 adf61e73a8af0-3c3ad947e07mr22455025637.48.1784657582261; Tue, 21 Jul 2026
 11:13:02 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 11:13:01 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 11:13:01 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <al-aDRTbDOPT1UbM@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
 <CAEvNRgFFEfHZTZOi_anSJDhqPvncuRiXxJt9hcRnAW9FPdFY+Q@mail.gmail.com> <al-aDRTbDOPT1UbM@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jul 2026 11:13:01 -0700
X-Gm-Features: AUfX_mzaAaIu_bpaDnlckBcmELIoCSoOxCQf7nCHbK8wSmePP7PZeI_vwN-WkAs
Message-ID: <CAEvNRgHjLmQcUSDKKp6jpsEiCyn+Cxnr-m5jweb=ZLAT8eh2kg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 16, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > Smush x86's prepare() and invalidate() hooks into a common convert() flow,
>> > as they are effectively two sides of the same coin for SNP: they're invoked
>> > when private/shared memory is about to made accessible/visible to the guest
>> > or host.  I.e. prepare() is really "make private", and invalidate() is
>> > really "make shared".
>> >
>> > Using a single hook will yield more intuitive code when in-place conversion
>> > comes along.
>> >
>> > For all intents and purposes, no functional change intended.
>> >
>> >
>> > [...snip...]
>> >
>>
>> I just tried this out with in-place conversion and I'm stuck trying to
>> make a call to kvm_arch_gmem_convert() in the conversions ioctl.
>>
>> I think we wanted to have a single .gmem_convert callback rather than
>> .gmem_prepare and .gmem_reclaim, but it turns out that it's not quite
>> easy to just call convert, because I need to pass both gfn and pfn to
>> .gmem_convert().
>>
>> The conversion is called on the inode:
>>
>>    __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>  			     size_t nr_pages, uint64_t attrs,
>> 			     pgoff_t *err_index)
>>
>> Then guest_memfd would call
>>
>>    kvm_gmem_convert(inode, start, end, to_private);
>>
>> It is easy to get the kvm pointer for .gmem_convert(), but then to
>> always pass something for gfn and pfn, I have to make sure that
>
> As I stated somewhere else, conversion to SHARED does NOT and *should* NOT require
> a valid GFN.  Conceptually, a SHARED page can't be strictly associated with a
> single GFN.
>
>> + the folio was allocated (to get a valid pfn)
>> + some binding exists for the index (to get a valid gfn)
>>
>> So for each folio that exists, I would check if there is a valid
>> binding. If there is a valid binding, I compute the gfn, and if there's
>> no valid binding I pass -1ull for gfn.
>>
>> I think this is a little complicated and not actually all that
>> intuitive...
>>
>> Looking at KVM_AMD_SEV's Kconfig, it selects 4 gmem lifecycle callbacks:
>>
>>     config KVM_AMD_SEV
>> 	bool "AMD Secure Encrypted Virtualization (SEV) support"
>> 	default y
>> 	depends on KVM_AMD && X86_64
>> 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>> 	select ARCH_HAS_CC_PLATFORM
>> 	select KVM_VM_MEMORY_ATTRIBUTES
>> 	select HAVE_KVM_ARCH_GMEM_CONVERT
>> 	select HAVE_KVM_ARCH_GMEM_RECLAIM
>> 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
>> 	select HAVE_KVM_ARCH_GMEM_POPULATE
>> 	help
>> 	  Provides support for launching encrypted VMs which use Secure
>> 	  Encrypted Virtualization (SEV), Secure Encrypted Virtualization with
>> 	  Encrypted State (SEV-ES), and Secure Encrypted Virtualization with
>> 	  Secure Nested Paging (SEV-SNP) technologies on AMD processors.
>>
>> So actually smushing .gmem_prepare and .gmem_reclaim doesn't really save
>> us CONFIG flags, and results in a kvm_gmem_convert() that needs to find
>> the intersection of folio and binding existing just so the .gmem_convert
>> call is valid for conversions in both directions.
>
> And I'm saying don't do that for the to_shared case.  If passing a NULL @kvm
> and -1ull for @gfn from guest_memfd is too ugly,

It is ugly, but I thought the point of providing a single .gmem_convert
callback was so the conversion path could just call convert with kvm and
gfn arguments that work for both directions.

I like Option B below better, which should also resolve my issue.

> I'd be a-ok with providing
> separate kvm_arch_gmem_make_{private,shared}() under GMEM_CONVERT.
>
> I guess at that point I don't have a strong preference betwee having a single
> kvm_x86_ops hook versus also having kvm_x86_ops.gmem_make_{private,shared}().
>
> I.e. Option A:
>
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> 				kvm_pfn_t nr_pages, int max_order)
> 	{
> 		return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
> 	}
> 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> 				bool to_private)
> 	{
> 		return kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false);
> 	}
> 	#endif
>
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> 	{
> 		WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
> 	}
> 	#endif
>
>
> Or Option B:
>
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> 				kvm_pfn_t nr_pages, int max_order)
> 	{
> 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> 	}
> 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> 				bool to_private)
> 	{
> 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> 		return 0;
> 	}
> 	#endif
>
> 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> 	{
> 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> 	}
> 	#endif
>
> Typing it out, option B does look prettier...
>
>> If we set kvm_gmem_convert() up to do handle make_private() and
>> make_shared() separately, then I don't think there's much value in
>> collapsing .gmem_prepare() and .gmem_reclaim() just so we mux on the
>> caller side and demux on the SNP side.
>>
>> How about this:
>>
>> 1. Retain .gmem_reclaim() for "host reclaim" aka "return to host" aka
>>    "make shared" for x86.
>>      + Rename the make shared function to sev_gmem_reclaim
>>          + .gmem_reclaim = sev_gmem_reclaim
>>      + pKVM will defined kvm_arch_gmem_reclaim() to do what it needs
>>      + TDX and ARM CCA don't use this callback.
>>      + From __kvm_gmem_set_attributes(),
>>
>>          if (!to_private)
>>              kvm_arch_gmem_reclaim(pfn, nr_pages)
>
> NAK, pKVM doesn't want to "reclaim" on conversions to SHARED.  reclaim() and
> convert() are two similar but distinct operations.  Irrespective of pKVM, IMO
> it's also very useful to differentiate between "this page is being shared with
> the host, but KVM still owns the page" and "this page is being freed back to the
> host".  E.g. reclaim() *must* succeed or take evasive action, whereas convert()
> can gracefully return an error.
>

Makes sense to distinguish reclaim and make_shared. Thanks!

>>      + From .free_folio()
>>          kvm_arch_gmem_reclaim(folio_pfn(folio), folio_nr_pages(folio))
>>
>> 2. Rename .gmem_prepare() to .gmem_grant(), or .gmem_assign(), something
>>    that is the opposite of "reclaim", that indicates the host
>>    granting/assigning/linking (other names welcome) the gfn <-> pfn
>>      + Only SNP will define this
>>      + .gmem_assign = sev_gmem_assign(kvm, gfn, pfn, nr_pages, order);
>>      + From kvm_gmem_get_pfn()
>>
>>          if (kvm_gmem_is_private_mem(inode, index))
>>              kvm_arch_gmem_assign(kvm, gfn, pfn, nr_pages, order);
>>
>> I think it is fair that "assign" or "grant" is only called for private
>> pages, since only private pages need to be "given" away.
>>
>> On the reclaim side, it's also fair that only shared pages need to be
>> reclaimed.
>>
>> And with this, we still have 4 CONFIGs just like above, except that it's
>> now
>>
>> 	select HAVE_KVM_ARCH_GMEM_ASSIGN
>> 	select HAVE_KVM_ARCH_GMEM_RECLAIM
>> 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
>> 	select HAVE_KVM_ARCH_GMEM_POPULATE
>>
>> And I guess it's more straightforward that one CONFIG selects one
>> callback, avoiding having either of the CONFIGs select .gmem_convert():
>>
>> > +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
>> > +	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> > +			    kvm_pfn_t nr_pages, int max_order, bool to_private);
>> >  #endif
>> >
>> > [...snip...]
>> >
