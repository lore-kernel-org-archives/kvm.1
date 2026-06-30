Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE340D563
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778148; cv=pass; b=lX9eIODP9/OVdz+ZvST+qQz82UX1rejnsF27XipTv3RRh5aJNyfcHelkEf8ZSMtEpMtCdUa/5QXrCEZRByNsxvhzC7eKfxfD9jzGKe0s6VSZ3EnxDrrGlSYQIhNv5pr0U1/abunBCDSu93uNKRdpA5Sy5LDmBk5bcrQmWaDE+d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778148; c=relaxed/simple;
	bh=cDhASOLoAtxS79kjrWKfq7PYsN1iMoEd6GzSpn/oqeM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3gVCJKr+PfW9m2yV7Dqnstdbv6p01gevNKkjoYOV6rhu7vRglyyTyVQWoDbO4YpxfMtUQT+0wk+IPQ4tLYCQ8gZwD2LGHlkPT6wTE5x35qoo+wVpePFMZuOFCUWGVPOrG4Tv3zFzjKGzT0O6PzHwemlPGEKGQHvH5hKv+aQwKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VB3gplO2; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VB3gplO2"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139f71a5201so87746c88.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782778146; cv=none;
        d=google.com; s=arc-20260327;
        b=J5gfOFNC10/pIxNfmb+i14r8qAZhmmdJbMTUdZ5VJ4MoeVyKPPfPvjNOGoJNWaZseS
         ehGADAX/2IAVpszaULWIpbSTtFlQTL90ZzLbVY8rwR68bUCW82HoU08flzBgwnYQb7rC
         ttBBo/2ljc6oguGw9BdmPEyKqHJYydie9xiUfP6BAZt2A+HMWoK5zZR/AZgdzVwkNZ7P
         CURvfdQ9gIYhROlo5BS6/cEiB+TFO6dbbjtzMvDWs8nC9BNbKq2snJo4QPoLp4Af2c2k
         67aVK03dyaWDSMEXBBar2LyHdv88LjSALeM6A4kdKs/uydo2xZct19mq8ND9Np/0Ria9
         hRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BvTQgRuUe8+D9fsAnsW9+J6fD7cKIFoX7VCj75UbmzI=;
        fh=xuP4xCHtA0J3DnvG55IqtmvsEH/CS8AmnuEgUcJEwus=;
        b=VznaDD54VmxutXUomZg75MspjsC6b21r1U0FkFSL5BRryhrC67a/E8hlak8kj1dtXN
         aiXKVOhvJgR/7MUiX9EHSWvV0mPkV5toaTeog0VEzm6tUtxHaLVT13dk0nb1Dr6CG9f4
         8WK69rk+OpWKN50LjjddJQtYLFQBKISiYPQHbJF4kar3rFr8qBDisakF66OxIOIRyEzC
         TP+KoVaymW8bsRCtDEwCZIqPOpPDV6qA0LYKPrJTwoyHqJXn5/P5f1uRphV1/tDIXjA1
         IarXSETJ9a0IuP2dTjRyyne5NbDWMh2GMdb2OtjpVziY1KUJdCt88OLr1lI8PlQxGA+3
         wsQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782778146; x=1783382946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvTQgRuUe8+D9fsAnsW9+J6fD7cKIFoX7VCj75UbmzI=;
        b=VB3gplO22GRmOCTjRrC40QhM/G8suiwxYI6zPhGFXm4sPzNIzNXR2V6Is1v/AUxkiH
         5Sg/D+s52JsFL9iY8W1iItVrY8CWIOqNmx4770WjOMmIr0Y+17E4h+7Kc/+0L2wwGAwK
         UlPIDRkg2JYd65nsIeZfcra29A9R2skPcbRrwRSJQsbYLWhL1m/7+I/d+SJONNSIVNtk
         5fI2jCQ97fELK2o+wcVBEVrkSGUI+xbrTtjHvNDIivuYVryFk4GLfbxHjLLy4yMDsIzJ
         gehIJIdUt3fDs62x9n0avQofTaoj858A2qX62gJ2zmQqFseQd71RPDFtiU1/Q5CYQOMd
         vzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778146; x=1783382946;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvTQgRuUe8+D9fsAnsW9+J6fD7cKIFoX7VCj75UbmzI=;
        b=kwjyA5DHyTh63mwtuJuI96xCCzqHAQ3bk/c2jHqj8Es0x0u6hvfbsVPdaBfFaI2dsg
         xLzfTukOkcEgVSGE8kWFE0TDyBg5+bsoVl3qUeLfokYK/CgowhML/R8J4JZTiRWSSkk4
         kcd3F5+O0rrImpGZXcJpNePWkt5xkNAJrTgnjP4m5Zp3xoBm/Cag5su3RLmbgHNbcmO5
         x3rSgI4glYqLJQoRzB1hV/uJOePGlkHRgsvzUeXmEmUYWhbq2thTLvEUwJhJg9ErgYDN
         WorRo0uy8Wf72lMpIC+vBbwDbuQAhzIXAaCgq3CKOj74c1ejYobmj1VBr0ATJOfMu92k
         mQ5A==
X-Forwarded-Encrypted: i=1; AFNElJ9U/VqGM7o4UXYSS23SdVIjaX0/Da7yLIH8HQp/RWBD52UU+a+ymKi6VjU0I8cSmQU8vCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsChFZoECkxlGVzTakBeD2KAe7aCsdXNlUOiEaZ0jH21CSBQU5
	jVrkpK6OFBu6cfl5lZs1SD5cKq6gvbNL8GJxBbjRCem8zfxbRpZ/LvGgEaxl/s4Z2Dl7A93pZ2K
	qmsL4pFrCUlEwYqv/nVMhZvOYllDxCe5/JugP1o0n
X-Gm-Gg: AfdE7cl6ZfljmBEm4fv9gceoF+kNvt+bZWPgWa50R7zQqlxe4P+qP/rKZPY4rKZbxX/
	UaUZL1Hqo7U0ulN4qZW6q/nHQejIWlFmPacHEp31Ay5zhbu5YAABm6YhYRlHuP5TDNlI8oMz/Uz
	E4CFCZRmytIZjQOwYpbEZYM2IL1C+dOyek1CeAMqkNXgYi7PWtPw+dX03kB8DfbOOIVMzMrdjKX
	7OeGoRAPA17ujP0Zw43fWSHUD0WdelS8nw/ndecXdVg6tXlObmmjFHcDPCmql7VXlf42AyTVZ1t
	U1GkYfG8UjXvRttf9n3pyjWcFXXaCEMrK4E0fcbNEZtaIYNDS0kmmAcO+6XPbHjSLiwkgQ==
X-Received: by 2002:a05:7022:4384:b0:139:fe25:a53 with SMTP id
 a92af1059eb24-13b2a70aa60mr795727c88.21.1782778145422; Mon, 29 Jun 2026
 17:09:05 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 17:09:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 17:09:04 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <akLrd4esRyuyrrGC@google.com>
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-5-seanjc@google.com>
 <CAEvNRgFt=pPi1XpwiaZm1-EWyZKa-1qm=QWOhFwBZ2ab_-oFVQ@mail.gmail.com> <akLrd4esRyuyrrGC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 17:09:04 -0700
X-Gm-Features: AVVi8CeCiY_ALqoySbu-IdLaugh4Gm2nqLWj2vF53UR-w9qB-g949PmwqqWCdFI
Message-ID: <CAEvNRgEW4WBXB+WGo=g7tNHDALc8=usHCHky-bPbhpRGgyp2Yg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] KVM: Rework .gmem_invalidate() into .gmem_free_folio()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jun 29, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >
>> > -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
>> > +void sev_gmem_free_folio(struct folio *folio)
>> >  {
>> > +	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
>> > +	kvm_pfn_t end = start + (1ul << folio_order(folio));
>> >  	kvm_pfn_t pfn;
>> >
>> >  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>>
>> I thought we intended to draw the line such that the platforms don't
>> reference folios, and so this function should be parametrized by pfn.
>>
>> I think we should still stick with
>>
>>   .free_folio = kvm_gmem_free_folio
>>
>> and kvm_gmem_free_folio() translates the folio to pfns and calls the
>> arch function, named something like .gmem_LIFECYCLE_ACTION_pfn_range.
>>
>> Now for LIFECYCLE_ACTION, one way to think of it is that this should
>> represent the point in the lifecycle of guest_memfd memory where the
>> memory is removed from guest's private use, so perhaps "host_reclaim"?
>
> kvm_arch_gmem_reclaim_memory()?  I don't want to include "host", because the
> "reclaim" may or may not be host initiated.  I don't want to use "pfn_range"
> because it's too close to "gfn_range".
>

kvm_arch_gmem_reclaim_memory() is good. It'll take PFNs pfn_start and
pfn_end? If yes, I'll wait for your next revision before I make a v9 for
guest_memfd in-place conversions.

I think Fuad and Suzuki should be good with this too wrt conversions,
based on their responses to [1].

>> Then kvm_gmem_free_folio() becomes:
>>
>>    kvm_gmem_free_folio() {
>>        pfn_start, pfn_end = translate folio to pfn range;
>>        kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
>>    }
>>
>>
>> And in conversions
>>
>>    if (!to_private) {
>>        pfn_start, pfn_end = translate guest_memfd offset range to pfns;
>>        kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
>>    }
>>
>> (and now it is right for the !to_private check to remain in guest_memfd
>> since we're explicitly using that to guard a *host* reclaim function.
>>
>>
>> [...snip...]
>>
>>
>> [1] https://lore.kernel.org/all/CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com/
>>
>> >
>> > [...snip...]
>> >
