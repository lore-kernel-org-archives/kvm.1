Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D22363C74
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769843; cv=pass; b=T6060YgOGeYVkY90JXKRSCYwK6mJDZo9G1AcXYHH5L7S+nARjXMoKkv3f+9pgf069xkYgWSR8xMxc8LXv4wKgiN0QEkwGOTiO6zIk16X59pNAPRQXkIIB/U6B6/uhVuJ1roJAcyX9SII+TrY+WYB8BUH3Ag99J2VwTF5O3yYlwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769843; c=relaxed/simple;
	bh=QzK1RoRFVkKh61OAw/0OpRvNpZc0v2tBsIqFw96k+bc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8LOrVEEPuB1lZOdjDpgPDghcRo1B+ZlRILGXrmrcWwz7Gi2Q7I5hvh2uhJBpj/hs+avfGY6j5AClfeCx08bz6NwiBZMjuPgpVk9Po/gmCRKuQCiNVc/g53u2rCbrmTuuKMWx2jGg4lZWMPmeyy9aRUfHR2CX+SA1HceHy1B6Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/VEYJS1; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/VEYJS1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139e498e428so640473c88.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 14:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782769842; cv=none;
        d=google.com; s=arc-20260327;
        b=GXRSjogBLDWABpm26H80CIFs4Jz/Kw7GDOyZYWyLthb6nFm8G72LPDyuKriyxoAZOc
         pbwTULQ7k19KYPK9ZNb2G+Zoo2nrVpbyWvc8TzAlNL2hxyicTRF9/fZkPGqnQCV+whNt
         kZmv2H1WsNG9TSNJjCKxd08b3qpEh7VpWtdpyGUJGKorZFzj7qTrN5Fry/jJI9j02r9w
         gpUBi3Gwuk5mij9hXRv/THcQbc8RTb6p+wAzJ7uxoTw+u/O0J3RHxuModwMdQerqk+oT
         XzNrOZ3Zgq9nLWvmNBKvZWYYsB9ZcuWY8GBIyRFPRIb37mAS5JrnsGnlHqZ3oqUQD5Zx
         h8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=upyLTP2WM0GJNTGGmZkcjRuL1dri28pEKw8qNdBs39s=;
        fh=SH9t9TFPeQ8bPdsk3rquMb8Ls+3hlsbagh6aBc008A0=;
        b=pxTn/gOda7IxJamcyzkXVjq2OEv3Asgpe65vJoyXLAtAobhed2FSwRk4QVjmFHRpkh
         RlJFqLhEpfODbGBUUjBSDjUmjYQa6hvEecZsS3IDjHvhH2UVA8pMCeEBroKyNiJL1Ny0
         V0H0jONd1F4s3T8375n8zi7hTZwtOveikr69zUBoFo8/utnqtwBxW92RTECyVgz7W0AT
         wvOgOzsWDyZKSkjlvhQooaLwtxlSHs0zCiat8wR3feRLAw/Ep17m9s3qZlKVPYgn5soL
         EkVtdjIxyIINKoELBfKjwOqg0HNZzeist68hBUUtE6kHDIXkCPXVHjkhKcbXKCuK692f
         il5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782769842; x=1783374642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=upyLTP2WM0GJNTGGmZkcjRuL1dri28pEKw8qNdBs39s=;
        b=B/VEYJS13nkN59yQqxKa2Q7Yb5QjoN+Wa/6wlxQjvg3gjWZvudxvV2JqD0v8MGdE/t
         e+ZXQMderVR47noupwStDA4FQLltYcScHnaoxC01E1XMKZxxJ8NC3xnBOf+kdbRsEPH3
         KsEXuhqPkbcLVLtsASM8yqbu3V/j1RUaGgUSnlUD6xZIfjErf4A2G32O36hAP53PXMRd
         Dvs4+k42T9FEEPNTCkHE37HEPb/DV2WUHx8LM6StDdUXwgCU8rVKE/4LUYgBjdzpYhku
         qZehuaT/+r6A/j2lLs14boIDWrdMi5+dlqUoahaUBkFIpc20mw/t0w32uFWy/IdsuN2G
         ZXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769842; x=1783374642;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upyLTP2WM0GJNTGGmZkcjRuL1dri28pEKw8qNdBs39s=;
        b=TotZwT0XufHdiz2NiZau3tvSPgX6mNFF+zW+zZS+ZNpiPLQls+gN17r5lHS8cqPrPG
         C5NUOWSdgk0u4ApIOik72gzih6MQQNVPFG2xZ1TU4fHzmFp/i8fuW2mHQ4uBgWBeehJ7
         Yc2cDUzcfehyMvvNwWezkWPzscRdqy3Hzr+IYoLAB1IjE40YU2HfbW7ePwifjML43KLD
         t4w7Xupdwn01AeKY8E3M0aIhHlRoLsOF0mmkMMllQgDR8PiQBRcvqwngkHCrXMKN8PmP
         NAGUGpjG1UWoeso/ceAiVAHeCKnCku3gtJFwKtRyOgNd+RxoL09v2dsSM5HbFVePWTmy
         STUg==
X-Gm-Message-State: AOJu0Yzgc5Id9lMDgS2wrpNJiuWW4EY7iXcC9ftq0S7GaLmrJUvu/iTK
	Jm2uo86gYu68Bzf1jb1DBCwlb8kCHDbKVcfsZvo1ODFoZ340ciMugkWQwRXX3MScYjXd5nMGOYR
	bWoNFxo6Sy+0c2ilIh+DYRbNwATzdpi6Abusou67N
X-Gm-Gg: AfdE7cmlZWxmiZA5Bp7yuLk6rikNuCmQjNqsyblrIzDyMCl8t4Mlsvp1ZIEcH/VqoZG
	klc9iUa4nWXvAiY5U+BaVL0tbCoE0ggU2A/IEZd2DnJ3GlgJf1Y/ZkNHW+4VdVPGYZvn5bFqLNZ
	6m5oBNAernJqBT6z24VbUnyAh3R2HMdufADT1DJl5JRv0LRiSc9mjiUftO6eFFggnUouWuHeYLK
	mxbUkfYc9ZZTt4E2+BQRk5kxqmY+Dq81ao4mKRIXHDkkdpnh+f4Lc5PNSr56TRSLr+Dkb8b09TQ
	fnJl2YOdaq49p2yQ4PQW9Vt3x7pP4mC64hOgL/0SqrZ0W/UasxFUVj7OaMg=
X-Received: by 2002:a05:7022:1b07:b0:139:ed5d:1b56 with SMTP id
 a92af1059eb24-13b2a70b2bfmr516237c88.23.1782769840889; Mon, 29 Jun 2026
 14:50:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 14:50:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 14:50:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260626231416.3943216-5-seanjc@google.com>
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:50:39 -0700
X-Gm-Features: AVVi8Cf-k9O-wGQpZxgD980Z9YsVYFRA_rTt2-c7DA1hfIMZgZy1hkotHq2cNcE
Message-ID: <CAEvNRgFt=pPi1XpwiaZm1-EWyZKa-1qm=QWOhFwBZ2ab_-oFVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] KVM: Rework .gmem_invalidate() into .gmem_free_folio()
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
>
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void sev_gmem_free_folio(struct folio *folio)
>  {
> +	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
> +	kvm_pfn_t end = start + (1ul << folio_order(folio));
>  	kvm_pfn_t pfn;
>
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))

I thought we intended to draw the line such that the platforms don't
reference folios, and so this function should be parametrized by pfn.

I think we should still stick with

  .free_folio = kvm_gmem_free_folio

and kvm_gmem_free_folio() translates the folio to pfns and calls the
arch function, named something like .gmem_LIFECYCLE_ACTION_pfn_range.

Now for LIFECYCLE_ACTION, one way to think of it is that this should
represent the point in the lifecycle of guest_memfd memory where the
memory is removed from guest's private use, so perhaps "host_reclaim"?

Then kvm_gmem_free_folio() becomes:

   kvm_gmem_free_folio() {
       pfn_start, pfn_end = translate folio to pfn range;
       kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
   }


And in conversions

   if (!to_private) {
       pfn_start, pfn_end = translate guest_memfd offset range to pfns;
       kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
   }

(and now it is right for the !to_private check to remain in guest_memfd
since we're explicitly using that to guard a *host* reclaim function.

Another way to think of LIFECYCLE_ACTION is to have the hook represent
the point of time where the memory's attribute is being set. Perhaps
"set_attributes"?

Then kvm_gmem_free_folio() becomes:

   kvm_gmem_free_folio() {
       pfn_start, pfn_end = translate folio to pfn range;
       kvm_x86_call(gmem_set_attributes_pfn_range)(pfn_start, pfn_end, SHARED);
   }

because when freeing a folio we want to set the attributes to SHARED.

And in conversions

   if (kvm_x86_call(gmem_should_set_attributes_pfn_range)(SHARED)) {
       pfn_start, pfn_end = translate guest_memfd offset range to pfns;
       kvm_x86_call(gmem_set_attributes_pfn_range)(pfn_start, pfn_end, SHARED);
   }

This is biased towards conversions (related proposal at [1]).

[1] https://lore.kernel.org/all/CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com/

>
> [...snip...]
>
