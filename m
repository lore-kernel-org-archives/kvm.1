Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FE385D97
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551217; cv=pass; b=USEaT1FquuOuT7gdT823AOlLFOtq2hT829TVNpPkIvg2UmWycbgU7L9w/WVkNAiHeCDA5uxpDuWW1IQTBoy7rxmSBuPt5i2k5SNSb9zEn3tIQYLhJvv1MC4AickJj5Q9HtOctnrHiHUa8ivnaa5UZvIeOjPpV+kt48hLY7PSyC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551217; c=relaxed/simple;
	bh=qmdyhWlXpg0lnc4mJROaYhc0UiwrQT/6yd0jZXWQguU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fbg0PCd901mExj9VIp3t3CkJtUXAKzYTi4YZW17OhwR6VJ9YTAhtaUQgNeCrDXF4BzeScQ63TY16JoIJkQVLtxQc5cImMt7l6eRU4fMepbaHIngpwIe5GVSixQi48+zhviIMqw6LAi/IPr07GFRREu/DB6H2C+eQ8Vg8H4OTc8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0ntrqPG; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0ntrqPG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c998fd549a8so842258a12.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 15:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783551213; cv=none;
        d=google.com; s=arc-20260327;
        b=o6NO6ojtNnH3r741LZmauynkyEFqatfUgFpnY5nCVKuOjPWeSmP8lzAOIVvupLtXnl
         9m5AUUMlmQCMV3kdu90vsEh8kGjV4D1wVggVtuXo6+z5dUJZUaqKcjfDaq72ovb0cMmk
         MJ5PTRvE6hv5eR2gg+a9MV2rBOPE2zWu+ROh+kmxJE0JnlAHzBjiT6WkXBSySXc9FXaW
         3EhVPzCs8YNgMpgAmus0/rkSKDEtEfKos1IZT4dOpxcvVUOuziVuKOTzW+vd7jgpDNwX
         wHAT7rG00WFN9plWJs+aNFmhUZeEFDTntlukrXl89SsMq6CT71vncuKx/jvVxIUKlr5+
         al5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=VpsmLVfJoWBAFXap/hXzRXdwAmXfNn02DeflvzyEpPg=;
        fh=SH9t9TFPeQ8bPdsk3rquMb8Ls+3hlsbagh6aBc008A0=;
        b=P7vzB6Sd9Sg4tBBbjy0U9UjnRf9V8r2QWADQ6BWzMB2df6qD+3ppjYqUG4Eg7lH5zE
         /hSOQH0hoRZ84Xjw+6CpBGN1y8u58XHTWlDIBoCNg8OulHKzUgviLrq+CkavgdFBaDsS
         +deED5mHQ86KdZ1fITf/hsXtcFVrspQWsvEOfhFbrOy0rdPg5w8jBQGEFi31qaTlsLUC
         xkN6S/p0Zd0pDBF9EztPGbMVX5iUbLIscko0TkguW03pYbDa3B9SbewFErix7H2gPTnN
         sUIH8sJWTo5MXF++CxiEQm+KE2b4tcQMpdd7UknBfMqyy90/Txpk2nt9yRiFZ0qO14Ss
         eIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551213; x=1784156013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpsmLVfJoWBAFXap/hXzRXdwAmXfNn02DeflvzyEpPg=;
        b=O0ntrqPGXoaraeiLI9IG7wl3UGGbHjadxj+8mxz3lRfNw6EdrvoSMObnvpVl47vSmT
         XIl4TJ0Wy8EoamRT7/YusgmOHEls0DsJZjcGSnjHj2AKMxLBdsaw7QadiZ9lIBNXi4hX
         VJfSQezGFl0bbJ2vN+3f+HxodjN4wzmVT1oTgT5kDOPk3hVAbe6RgvzCw54WQKjA1VTO
         Zh65ZmoopauWXC2C7H7owG7sfk8l6j+iyCGnJV2EW6Am6vWnYML9p/2RASvw9JVfbkoT
         diKJg2kgBsK7Q7POpIoIVtebby5uiCuV9/0dLIZyJJrJ9fM8xZ29Y2Vs4zthMS1Ic3l0
         maxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551213; x=1784156013;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpsmLVfJoWBAFXap/hXzRXdwAmXfNn02DeflvzyEpPg=;
        b=nb0UFULoY8hX4rUTNoFzOlObZ+5kvlGzPbn5PrxHcx1W8sPlRjUh4Qc1UaLcybVNZu
         l4IykSFTfMGlil+4c94q6gjo/LG5HwB3NMeVBO3xtc+IDvpgBigrO8MKNFM1JyNnrL3O
         nEV2t6zoc+fH4iUJ5KbFfTHtCPIls8AFlK671u4FU2yQDMzqqt41YDIPsTinNDPwWLp6
         2WjPZQLcR3gSL0NoTBjZ7aCMEPbEA/bS3G+gOo0GbFVwivHs4iUBG+2OypPJZ2/21kBv
         wzgp+xMuCS+AQ12Vfz8PLVMiH9W/XISxpLQZ+MSYGMJVSgAKxgQkjFXyTGUTy7MmX8et
         MiWg==
X-Gm-Message-State: AOJu0Yy2smZB6wc8gjGlQKvPTPICe7Rij7k0YhAFnUYnetHxGSFDxmXn
	uCDH+vaOmQNHGspnv1Jl25GzKNLRL+ueVMcg3awctQsNQ2Nh4B04tet+UWoUqVd0yRXHBsWyfLC
	UfIJOe7FfNEDEAguUJ+bmv91fpnWaasVIUD6JQgHY
X-Gm-Gg: AfdE7cmHNuMpaNnivZPzC7KLx4Kkx+DFlM7w7o/khPb2Trwk441VVnJYa5sRG95rBme
	9qA/HR5mh27x8lrKCPPH/HcmENBZmIyHyyQOhuDNLnk5uGOYOk9T8RflNj6QELw8F/ru1fMeRLz
	B57lcizg4I0yjZNatjn7Hs7lELfGTsSdfLCVo1Pb7vcAfkj2AvxIKCKHyL3FYuEvZDd5oFTlOqY
	5PymTTIOxUW0VZxnaiSPMvgm16XH5/YA6uHX2v+o6NX6TVPNx9XEu1LPiVc0utm8aNKHYynCCFM
	axqe3EaWdVgmO1E7RbEg40JhQiZ9xlY2V+JstZAd05Dj18LUKoCDpDiEQ6E=
X-Received: by 2002:a05:6a21:4910:b0:3bf:aff8:f572 with SMTP id
 adf61e73a8af0-3c0bd06a68emr5556584637.32.1783551212907; Wed, 08 Jul 2026
 15:53:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:53:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:53:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260630222607.497895-11-seanjc@google.com>
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 15:53:31 -0700
X-Gm-Features: AVVi8Cc4QkzH7H57bOEy1Erexnjx9xcY60lAN_V3_1EbN2LzwTFi4SD7BSMfVik
Message-ID: <CAEvNRgEFvh8T=v9jzxyYcc3NQzS2-uJctNuZix+mNQO8gwc-RQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> @@ -1902,6 +1905,7 @@ struct kvm_x86_ops {
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
>  #endif

I suggested CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY before looking at
this patch.

Considering this, it seems like gmem_invalidate_range is a true
invalidation request and .gmem_reclaim_memory is too late for
invalidation as you explained in the commit message of the renaming
patch.

Perhaps the new .gmem_invalidate_range should take over
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE, and .gmem_reclaim_memory should
use a new CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY?

Are they both invalidations in your opinion?

If we're clumping SNP configs together,
CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE is also only enabled by SNP...

>
> [...snip...]
>
