Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611902E06EF
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992489; cv=pass; b=iS3bkJjg+KjtPOzlfGW8UdM7ZjzLR010XGueBemNjYrduoz7ER1GqwlUtSVRa26e2fWySIOXYq4xOSdLrG7vS24t31cgdQwESQs+sD2xm546wyOzRAh/2dQhCfBhOTfbrUWrzwvrCi43TAned+iQksPt3YBP+byEDhxasxIPi0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992489; c=relaxed/simple;
	bh=OACypNh5EZOzcrAuN1VlNd5ub5MuIZEEN1YHFNP/Z1E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3FsW6/SRd+aT1ZwikvWu9bHvm7gi2+6S8Fynudxsp+iES88sxpqvr/w46j4GT3sdEYkH9GgRf1N5aUW9GOUTd4WQNg3ObuOKAhAO8sAQF3SEHzBY+gokZIIXyPhd0aNYgHDtXw4glGuw2djbP9SILIkosOFXt79Zz1eHVRCGGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzRkM+su; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzRkM+su"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f47e6297so139383966b.0
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784992486; cv=none;
        d=google.com; s=arc-20260327;
        b=P6tGWYNMsLlvbN12EsAm1qEkatDAOFekXHmBFLOEFfOL9rQwxdtV/4nZu+/4uCYDu9
         K82b8IefhQOaj4zVLD9Lxx1GbqtE6RF/eV7w6eYQLobjLahrgRLuBByh0GMx5mvSP6xT
         1k2rwe7eUbA/7uklQ/2TfK4t4ysJDISv9+FmshmUVszwGjsHO0SYjH0x5a5smh7mdV9c
         Md5SDq5OMkFd5i0Ic18hFCRHzGjFbUMxt0fQLB8TnSxNAuKvVzPUQAcEhvPQXQGVZhJf
         bCuCMRloc1ZMANezMLmvlveHYParzpYSP3Hlixe6TVYl6ppBjUcTnQRIVvk5WdVexQMm
         frZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wTBwE5zHUDRlM8zyhqfHwXDgjIVeVk+Yo4GwmVB6KBg=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=K84td09IV686o6q5HIBQnGbz8FVFgz9f99qx2bnpu/5ViYQXxdtow3hPQd58KFGj1R
         2FkENwlviOcleApeBS/CXBQoBCNxjZ7onwGYYSUS4On5p/BMJPgGyyLpE5pisZkQdaeZ
         2aHTVUO74TOHNDymSAM9Lu5hKMkesoWg9nQ58WCOy5mlZ4jcSpmeV3wgJbhY3VTBEptv
         66N5B9z9/o0Ud1B29YxWgE7evtLdOSfoTRHCOlH7PRnxy5zzBu6MOiHGxmdkhgXyUKNO
         WBfWJaH3WtR4sqzak6StrQaSMC4jsWHXkOIFmkvAsn+vIOB4pp/AV+oOuz0VPi0ZdlBd
         UzRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784992485; x=1785597285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTBwE5zHUDRlM8zyhqfHwXDgjIVeVk+Yo4GwmVB6KBg=;
        b=RzRkM+sufVW5bCbmm8gLZYwOG3nw53PixxHYeoAubZuAudihb7dlY8b2vrG3y9hPyx
         79F2E9kJ4Oh5ePjNIIGYwrPc2AF8a8xrwWiWAyWUDHmAo6vbZVdKTry2D4eNCHMvbFBr
         FaE7qoXC4mXpOfxOdrX53ZVxdNM+BoEG19NRhevET9NPZL7f6XEls89V6rqmRgIXmBYS
         c1ZaqUQuZFw+mDszhXJfC2FSiKcNkY4Dm0YCG6rCi8Zkq/4RCipGCe+2g9JvRKRVNAXg
         cgzwemBB/nlT6wchlt8Qntgh9UWI3Xq3TkA3ZsZL/FgJGVI2i8YITEX0Ifnu7w7GHX6t
         LDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992486; x=1785597286;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTBwE5zHUDRlM8zyhqfHwXDgjIVeVk+Yo4GwmVB6KBg=;
        b=nzxzAOqAEK6GY59xz37zxdeylmwQBjqx3gLVTQOahn+s4C23pIOidgcOFJt/0vFSE4
         +kyAFzMKI75T+fVy6y3d9H8IcirRqv49SBGby6WjGf4nlbHGorc0NSJXn/zGmfh/ZXNJ
         lSUT4+wWUlHqI4FP3twfO3xHgwmja0IcmQKdKo3HQntObewPxXp7YZlttTsV3WfNWXld
         WKOqtff4ZbYf+1T5eiAyQQEOYW23VPV8t/AUoim71ryNkogAi3qc80c0xSf15PQXPb9w
         4jr2yrXBiDXVhUN+5TamRyDd1cHFKes2Jy1B+i9hK2RTakRaZCCifVdhm7GDZIi7gUpg
         m9Xg==
X-Gm-Message-State: AOJu0YwDIrpib6ZD5/2fIC8EuompwsQUGAZHhTPK1GG+oyj4ZN0Y78fm
	rLPLeKsZMNbk0+eA1zPLTQzME8yhPoI1M8Y2StRkX5tLS3e9Uo6+Yn+RnOBwEnuKmxTDEykPtTH
	i6yi0cN89N4f9Ms0Wtz0HH/joQnMxJq2q1W1+uPYi
X-Gm-Gg: AR+sD10th/yNCvB2qwgrBNOD9jTn9La6rjx080yfz8bDBgMQeCNOS4BkJMqx7gH7csE
	oz0iagqKBvHHJR6sZiN+oQu8vS7+UTPuoAM9G+jzIbLMs6nxeK08F3K+x6HZu7l2FtKk9qswU02
	JCDi0qBqQoMT9fmYdAcj2M5sKZtzikAc1U5wKQJKNNUlDXLlG1PFWOVno/hJnlIKPiOkuWrCOYs
	JiRvsVNHsgvMSGMXd0snok1WzcJrt0NUdeke0XzcFRoTGKW8cJPn0iI8EJbFmRmHoojUIYu54fH
	2HzF7I7QAGmTogPRrQ==
X-Received: by 2002:a17:907:1caa:b0:c05:abc0:dc7c with SMTP id
 a640c23a62f3a-c1f1eecc2d8mr129716966b.40.1784992485032; Sat, 25 Jul 2026
 08:14:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:14:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:14:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-9-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 08:14:43 -0700
X-Gm-Features: AUfX_mzw4RrqKArl3uSRCkq28MDs2Ia0VLEHWbq3DYkFKYQbPJWFiJVM8JPTXLc
Message-ID: <CAEvNRgG=j7_FEGmE8NV9DaENQTJXn50aQepFaQZjn4zh4d8DFQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] KVM: guest_memfd: Explicitly pass number of pages
 to make_private() hook
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Tweak the guest_memfd make_private() hook to explicitly pass the number of
> pages to align with the signature of the make_shared() hook, and because
> the existing code is outright broken if a guest_memfd folio is comprised of
> more than one page (which can't happen, yet).  The SNP code *tries* to
> create a corresponding huge entry, but if the RMP must use 4KiB entries for
> whatever reason, KVM will only convert the first pfn, and not the entire
> range of pfns that will be mapped into the guest.
>
> Alternatively, @max_order could simply be repurposed as _the_ @order, but
> that will fall apart when in-place conversion comes along, at which point
> KVM will need to deal with conversions that aren't bound 1:1 to a folio.
> I.e. the number of pages to convert may not be exactly be a power-of-2 (and
> folios don't strictly guarantee power-of-2 pages anyways).
>
> WARN in the SNP code if the number of pages to prepare is anything other
> than '1', i.e. if guest_memfd is trying to prepare/convert more than a
> single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
> greater than order-0 folios.
>
> Opportunistically swap the ordering of @pfn and @gfn params for
> kvm_x86_ops.gmem_make_private() to match kvm_arch_gmem_make_private().
>
> Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/kvm/svm/sev.c          | 27 +++++++++++----------------
>  arch/x86/kvm/svm/svm.h          |  2 +-
>  arch/x86/kvm/x86.c              |  5 +++--
>  include/linux/kvm_host.h        |  2 +-
>  virt/kvm/guest_memfd.c          |  2 +-
>  6 files changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4be57157136b..230267b2203b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1725,7 +1725,8 @@ struct kvm_x86_ops {
>  	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> -	int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +				 kvm_pfn_t nr_pages);
>  #endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0ecba768c153..bf7f94d1d7f9 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5090,15 +5090,7 @@ static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
>  	return true;
>  }
>
> -static u8 max_level_for_order(int order)
> -{
> -	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> -		return PG_LEVEL_2M;
> -
> -	return PG_LEVEL_4K;
> -}
> -
> -static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
> +static bool is_large_rmp_possible(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
>  	kvm_pfn_t pfn_aligned = ALIGN_DOWN(pfn, PTRS_PER_PMD);
>
> @@ -5107,14 +5099,14 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>  	 * PFN is currently shared, then the entire 2M-aligned range can be
>  	 * set to private via a single 2M RMP entry.
>  	 */
> -	if (max_level_for_order(order) > PG_LEVEL_4K &&
> +	if (nr_pages >= KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) &&
>  	    is_pfn_range_shared(pfn_aligned, pfn_aligned + PTRS_PER_PMD))

This could actually just be return (everything in the if condition).

Thinking more about this, asking is_large_rmp_possible() of a pfn and
nr_pages is perhaps the wrong question, since if nr_pages stretches into
the next 2M range, then you might have a different answer for the start
and end (and in-between) 2M ranges.

We can solve all these when we get to huge pages :)

>  		return true;
>
>  	return false;
>  }
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
