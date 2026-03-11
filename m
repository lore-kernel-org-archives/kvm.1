Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643B21D585
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208847; cv=pass; b=N5sYSVyTcrb+nlxZ3Qx9bLudSP+S0Jovyj2oyjRKAfOe5tsv1qDL3ddGx5Ks8vh/7PvWzkx/EGj4oJdVEXqRt6EPX0FGZbLXMW7zc8BxHJQDkl4hSdk6NgSGZlT6ixvnA62EvFVyobDxMONuQWBMmDLT/P6Kl8v+rMcZVGw4Gpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208847; c=relaxed/simple;
	bh=1pU9e1VV6wQdH0AgbRuRINPzSJbE/naiF7g141qXG2U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tm/9RK8wapT79Z5VCqrdDM87SIMgAbAoEIM01nbPt4mZ42ng+9GCSa6+UIpjZcmu/dZobWaw3GS0uAk3NJDXSgmgCf72mTZa8KWgh6w7Iv243eSr3OAhjN0c0QhYJRF8hQq+LPC53Ux/ii0vPw8XkJXein6ZUNO4cs1z2nO4tJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iqse6Kir; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iqse6Kir"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so6258713e87.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773208844; cv=none;
        d=google.com; s=arc-20240605;
        b=X1WSl35cT1eJCoiEWUCbMtu7tzlRLMXH18mgYipvRvEHEckqUNsyJ4BHzUYF6rQN2j
         V1dVKfWmNOPr3kU1yuVeBwoF8LI8trUY80bIQrlf/i1q4v+loIE4rbIUkfL3ZVLX0LmX
         F6A7kOwq55ySHi/C5eBuqMJamTcrSq8fGKXJzyU8e5AWoKOLMRouAgqhmMJPPsfbfBR3
         xj/+FgYjRzERNpGyAWFalwkjpdsSbllXHf5jdt6mUUUtdWSkIZH1fwzZBUTHGBZ4P7Q7
         sH/sAidkKQt6HITlefiE7Xz6O4NT1z9+qOV0Ol6fRpeCZreeeKLD2bKXQx5rwDAsiWfb
         G3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WlV0D1/XllmyoZfK4RxM2lMbSn8Yq7S4U2C5Lb+KdlU=;
        fh=kcLhBTvHOymMOcTqiz0fP6IeTLGQzQ2xKsjLzuBJpwE=;
        b=A1ltuBURsZas4lsWAG6u9OLwJYHfpm8oqOyuCBlcK3woDsLo9X1nnaA/D+0RUxBASw
         DrTrVcpnkYlXiUFJ4Se1qr3+WX89gBFQQ6Tt3ngSgx7u8EhS5kvVS6jmX9wYZt28jZeX
         LngIMuEEe3Z4sTBdtn3dzJ/ji0s0rCUXl9IREjEB/2rTse4lHcWfm+3j7TCz3LL2XLve
         yvRPUQAi41V2j2bNo271iwnV24pfDWbCn6v5bJDZyzMlhjoZZn9a6pCnkilmIGT0feJ1
         1+WKuuQOJepztHwZmLnhu0xzPv+Zptduva8bi38xhGld6oun2ouYv3G7nkLLbFisbZas
         kD0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773208844; x=1773813644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlV0D1/XllmyoZfK4RxM2lMbSn8Yq7S4U2C5Lb+KdlU=;
        b=Iqse6Kir36nH6Lb6Ex65/EafKhcjKp+SUMVInRa3iwm+79sb5EKy+FbStq7w/90QmE
         kM6OFaKkXqSWRm3vAa1L5o5esBQNQapAoW75m9Kft9/wMvgjrgxKqx7auRaZwagNHxls
         a61L1nV1kjiQCrN9HPa9f0d8Vgzunj5ZPUetw49queagpLPUjKY368brz/yynxW0LDxp
         bT/W1Yx0WNn4wYe+Ne+sTUskUlIlI+30wWrXCyyRC1Ie+BPDbhdWRlpYUUSrJ3qqzZ+y
         vTsqIm13FfdWmAEgx9NHi+OSQc2rClEjgPcGuDp5NR2Qj/oGWk3hRP9t7UkrHwh1wlWr
         cUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773208844; x=1773813644;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlV0D1/XllmyoZfK4RxM2lMbSn8Yq7S4U2C5Lb+KdlU=;
        b=kBym0PzEbETYcmrThimJDiLKn/73J4gLz6Xg+lsX7iJ9Zmy73T2y4djuuuAx8/qeZt
         e6MLE6OOf790/uoQ1Z2DqyAg/XeS2t3X99iwW12Iyk5xupJMZiMogXbtciiqHs6x7pIJ
         1nBP0W9RChIhtEsV53hsJDBBjq8EqBa7XQYbu3LV1qKRlJSf9+3REnlCpDWf6OLsdQ0S
         wddBkxiSMRJ+wdrTum3Q9gO14VyPBWzOQ4HvGD8bSseCoXui9RYVlR8eXuachKqrKQW4
         zBOM5C9c540O/clfJeaqblCGfetFEf1guCDD9gOTOC5m2D4af1I3SLl6z0F0EkrGIa9q
         5mNA==
X-Forwarded-Encrypted: i=1; AJvYcCUBG1MHCLqOqXHVcwPIeb5ybnpQH5qtjDlkm+Jr/QvlN4D3VSqmMhowTS9eZOVeiZC9NfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqmh4+68dAfuZ2C2et2YJn/sqehHKOm5OdHp47QRxOiY0ZQtOc
	t9+ER1GxbcehuqFIiQjLOfYl/5fFy87qsv9ad4Wch7sCIfxGdkoFS3SvvbAVZApzOyG6QgjTDDx
	VOi5IC7K9UgNLlZ+XtjyRDUx07AOfFjSZ000qhOj+
X-Gm-Gg: ATEYQzyVZbPbmdLyXlRLyJu6/M4aQqKJJPLEZhOkzylrZB673HVUbiaR0WqvpSVFUCc
	dElFoNCbXdx9CIPFEgUy6PzVc3iayQTVIstOjNjk7TPwZYfNIYpWGiFCZiBGL3fiKt7f1YO3z+L
	+5wvvaNxZLBLp4bbJnWXvf6ugsDhqTyaW1Zb0Y7TeGsvEJCAyxRj6ixQpDry0xSzXNHc6J1FMBf
	yG8vATN0SB8IEt7D1NH3jvcd8TpAXkwvkoP2H1SNsPZOk0D2FMh0lPzfAjb+6l1vCDqTMuVkK5O
	QcphkvZ8LSTD2T9qeL1cShSJ+c6M/Zie4rfrSuHSl7oCsXa/OhfL9sqeqKyVyVa1XY5b+g==
X-Received: by 2002:a05:651c:210d:b0:386:ee99:6cb3 with SMTP id
 38308e7fff4ca-38a67dd524emr4828161fa.9.1773208838986; Tue, 10 Mar 2026
 23:00:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 23:00:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 23:00:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <98313534-af6a-4c00-a016-9d9010f145da@amd.com>
References: <cover.1772486459.git.ashish.kalra@amd.com> <ce99dc548000b5a1f4486cdd3efe510b3874684b.1772486459.git.ashish.kalra@amd.com>
 <CAEvNRgFCTNr=LUR_RM7+A4z+qHCWBZOYKe_Cbokwx0UsCtzaVw@mail.gmail.com> <98313534-af6a-4c00-a016-9d9010f145da@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 23:00:28 -0700
X-Gm-Features: AaiRm52f972dUARRHKzijDgoVU81dxtGZgEikl-nl7dIcDPZ6xeiqW2WuI2S4xg
Message-ID: <CAEvNRgGdaA1ynF8jxQDPh9U0U8Q0RkE0=KJx4FNrh_=+dVRaLQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] KVM: guest_memfd: Add cleanup interface for guest teardown
To: "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Kalra, Ashish" <ashish.kalra@amd.com> writes:

> Hello Ackerley,
>
> On 3/9/2026 4:01 AM, Ackerley Tng wrote:
>> Ashish Kalra <Ashish.Kalra@amd.com> writes:
>>
>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>
>>> Introduce kvm_arch_gmem_cleanup() to perform architecture-specific
>>> cleanups when the last file descriptor for the guest_memfd inode is
>>> closed. This typically occurs during guest shutdown and termination
>>> and allows for final resource release.
>>>
>>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>>> ---
>>>
>>> [...snip...]
>>>
>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>> index 017d84a7adf3..2724dd1099f2 100644
>>> --- a/virt/kvm/guest_memfd.c
>>> +++ b/virt/kvm/guest_memfd.c
>>> @@ -955,6 +955,14 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
>>>
>>>  static void kvm_gmem_free_inode(struct inode *inode)
>>>  {
>>> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CLEANUP
>>> +	/*
>>> +	 * Finalize cleanup for the inode once the last guest_memfd
>>> +	 * reference is released. This usually occurs after guest
>>> +	 * termination.
>>> +	 */
>>> +	kvm_arch_gmem_cleanup();
>>> +#endif
>>
>> Folks have already talked about the performance implications of doing
>> the scan and rmpopt, I just want to call out that one VM could have more
>> than one associated guest_memfd too.
>
> Yes, i have observed that kvm_gmem_free_inode() gets invoked multiple times
> at SNP guest shutdown.
>
> And the same is true for kvm_gmem_destroy_inode() too.
>
>>
>> I think the cleanup function should be thought of as cleanup for the
>> inode (even if it doesn't take an inode pointer since it's not (yet)
>> required).
>>
>> So, the gmem cleanup function should not handle deduplicating cleanup
>> requests, but the arch function should, if the cleanup needs
>> deduplicating.
>
> I agree, the arch function will have to handle deduplicating,  and for that
> the arch function will probably need to be passed the inode pointer,
> to have a parameter to assist with deduplicating.
>

By the time .free_folio() is called, folio->mapping may no longer exist,
so if we definitely want to deduplicate using something in the inode,
.free_folio() won't be the right callback to use.

I was thinking that deduplicating using something in the folio would be
better. Can rmpopt take a PFN range? Then there's really no
deduplication, the cleanup would be nicely narrowed to whatever was just
freed. Perhaps the PFNs could be aligned up to the nearest PMD or PUD
size for rmpopt to do the right thing.

Or perhaps some more tracking is required to check that the entire
aligned range is freed before doing the rmpopt.

I need to implement some of this tracking for guest_memfd HugeTLB
support, so if the tracking is useful for you, we should discuss!

>>
>> Also, .free_inode() is called through RCU, so it could be called after
>> some delay. Could it be possible that .free_inode() ends up being called
>> way after the associated VM gets torn down, or after KVM the module gets
>> unloaded?  Does rmpopt still work fine if KVM the module got unloaded?
>
> Yes, .free_inode() can probably get called after the associated VM has
> been torn down and which should be fine for issuing RMPOPT to do
> RMP re-optimizations.
>
> As far as about KVM module getting unloaded, then as part of the forthcoming patch-series,
> during KVM module unload, X86_SNP_SHUTDOWN would be issued which means SNP would get
> disabled and therefore, RMP checks are also disabled.
>
> And as CC_ATTR_HOST_SEV_SNP would then be cleared, therefore, snp_perform_rmp_optimization()
> will simply return.
>

I think relying on CC_ATTR_HOST_SEV_SNP to skip optimization should be
best as long as there are no races (like the .free_inode() will
definitely not try to optimize when SNP is half shut down or something
like that.

> Another option is to add a new guest_memfd superblock operation, and then do the
> final guest_memfd cleanup using the .evict_inode() callback. This will then ensure
> that the cleanup is not called through RCU and avoids any kind of delays, as following:
>
> +static void kvm_gmem_evict_inode(struct inode *inode)
> +{
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CLEANUP
> +        kvm_arch_gmem_cleanup();
> +#endif
> +       truncate_inode_pages_final(&inode->i_data);
> +       clear_inode(inode);
> +}
> +
>

At the point of .evict_inode(), CoCo-shared guest_memfd pages could
still be pinned (for DMA or whatever, accidentally or maliciously), can
rmpopt work on shared pages that might still be used for DMA?

.invalidate_folio() and .free_folio() both actually happen on removal
from guest_memfd ownership, though both are not exactly when the folio
is completely not in use.

Is the best time to optimize when the pages are truly freed?

> @@ -971,6 +979,7 @@ static const struct super_operations kvm_gmem_super_operations = {
>         .alloc_inode    = kvm_gmem_alloc_inode,
>         .destroy_inode  = kvm_gmem_destroy_inode,
>         .free_inode     = kvm_gmem_free_inode,
> +       .evict_inode    = kvm_gmem_evict_inode,
>  };
>
>
> Thanks,
> Ashish
>
>>
>> IIUC the current kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
>> is fine because in kvm_gmem_exit(), there is a rcu_barrier() before
>> kmem_cache_destroy(kvm_gmem_inode_cachep);.
>>
>>>  	kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
>>>  }
>>>
>>> --
>>> 2.43.0
