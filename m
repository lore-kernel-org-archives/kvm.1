Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E89432E84
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073339; cv=pass; b=KfM2PvUlCnX6IYRmUXJlejZYDztxH1IMAWCF3a3b6NUqEaTQCF/cENfh0QpjPl2M1Y4dcTENzzKD2xAasPZnXa6nvaScQfc4qJ+Zyd3zGbY9lVko+wv4oRdUTW9RGmHuPMeCcXFTgcCjzMYyFus7k+lFE1SWQtNyZRHO09/VPr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073339; c=relaxed/simple;
	bh=e9EVozH8PUHQv8weMiLPRknw67pORp8HUbAAwldWUp0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2VYSkU+NYLLJIN17+UxkWArT6TCtcW6lPkR5M82lZ1r94b7mDJ56n3gH2Aq2o+hR1ed+9o+ooW6wS5/aQztNqvQYIjB9ediW1oVp5G6CWGOh6DbDPu6loKo2hOKlh+EBrGhmdqbRUWyBfLDN2NL8o9H+mXjJ2j1XtJ+j2qDYc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0t/BTlL; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0t/BTlL"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso19686385ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073338; cv=none;
        d=google.com; s=arc-20260327;
        b=KwFtViPFmXZ/BUeKVL/Kl4JbpToMJHRjFycr0N6PfGc4yNnpLPsJzUdNflrm3Wi+g0
         UdiGJtktT+g7UNyQALS+FnlZHz43UaNxxncwQA0tTkpc0agUjUi8kfVuy2i5NSz+/+tf
         gOWJ2VaBkY/LSo60mB7wAgLHhrMxZLyUGf8slZDxt9Am1hApfMacUztoSRJ4qHM4nvEs
         AGlKaTaPMs8HuIL8l69a90AlouCxDPsIts2W/ypfrfygZ2/RigUGh0+WWRdBKAqyIZ9u
         g0UNMEluonhDjVuBW/u49BFV2UldbqBFQD0ogQDxWeFHDTxXAiXtgAYsuMPoautveB99
         3r5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Z8kBUh9BX0v+zbVppkVnRqwWhzPsTEaBhWYA1LuDPBc=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=FB19ovEXWtagHT11u3HixzIIsST8HDeY74dN0a8KjEcO9/Mhdh8GQauQarPMwYFeyl
         sWbB0pGXAMYVA8Qnjdcc83NPx0quAXs1301/opKyxWQa5eGd2whxtWJUWyilihU36Pny
         RrV4b+hmZbdiDKA+49s07vUo7g5Jj7pyyzk7XuhKsi6tpgSE2LkteQIu1s4+M5Di3wQC
         OBkNtrl5weHObYc7bhcDZtRb90pUNNkwg0gPp36SDZwd7KFg3rY3QJjUqZOVZlSjqGkw
         FMbFxm36DGRG1+LA18nx+si03TEjQ9M1N+5X4HRFEa/f8Rj6uGMNd9PBFA5NvtyP3yQy
         HHlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784073338; x=1784678138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8kBUh9BX0v+zbVppkVnRqwWhzPsTEaBhWYA1LuDPBc=;
        b=f0t/BTlLkpjHiTvZlzaCh5deYQbtnQx3aOV5taaTrr3B0fHhjGnqJq4zag2ItyJB5h
         THUjNBdAh4OABY+ei/d+gJ4FAgAMcD/P5aiYKkj/ZivUcQTvsNr9XD99eEiaTQirhus6
         RccnxAfA50vhDhJHShb8YPWWYccITgd5jH7JhbaKNzZ9S1u6K4FZFpYYnDhrAbqbCLV1
         jClVM29advMnE39KLOUf/Am2DXmFXbjJpQV286fdD/WHIsZ5MqYEM3cfeMgs5Dt3Bjpl
         7gOlNxnxCGDajogAcacmV++7ZHr+NkSRtVMWqRfQnt0g0113t9CpRseSZlknx4WbiyDm
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073338; x=1784678138;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8kBUh9BX0v+zbVppkVnRqwWhzPsTEaBhWYA1LuDPBc=;
        b=JuGNCdaTLtaSfLJDBM995cN/VpchE/oze2h2jPd/SiOnMYnYvf8SUVIglWJCNBAsOq
         a6Gmc/QE7D+TZ9xCDypMXFQxcVju7v0I5QeUuiLN0HphKg/5cU+4S4lQgj9rgYSwjNVT
         mxx4hQz6SN2+FVbvzHa0Jfctj49o8XD8qdQK2HnUessWvkvNx8dsSzIheHFJ2O780bUL
         74H/3zAHfqs31qV3UHVVOejJPYZzAsH26xqoSTIsIRHDilCyTd1USvwDBKAz81/eg5OF
         eFbhY16X+e0miOHpEAJW29800TSOXfmKFd/s+Rn5WcCM1rBoek7Ajw2L91PisGzFiHT0
         G+Nw==
X-Gm-Message-State: AOJu0YxFyiXjUGVWk1I4yvxU5SV5Rqv53oPnt162MuF2YqXTYisOspV3
	T5AKEQbxwmHOVI5nSoOLnJGjxJg1PYi0CFbRMbksgKDiYUPApoQ9poolIMVd3ecDBg1RjI7SAfQ
	0slg/sxkWCratdtxed6s7kPFRwFqKZhYhsmxhyxN+
X-Gm-Gg: AfdE7cmlEbB57yLgIeGdT6hcAAX0maiescK15I+p2/jukc5nhN35XiNQ2k8r5T6HhkI
	1icJl+x36CEZu6wBJ3jZOAySsdUy756xm4z9Ofch1MqS58J480Jvo1TgalBXMgHN/W8qr3GjIRz
	8URkqbTCgZHD79DAAro/ipakxsf6Qk6UJ66XGDhWLcO8aXhZ2QkhX9sbdM0AMobBHudcOJ0l1IV
	E6mFqDWAGEOcnPVCNb+ZHNprm9KXm7fSOTu7SDu5cj79I4T3i1sLULatr7w6dXNHtC2OYwVpFBo
	+q3Hr2sQ6GWRFgM20tuNkq/3hTH0OdLoFQGdm0omUN1YDAF1yW/OwMJK7is=
X-Received: by 2002:a05:6a21:398d:b0:3c0:b3f7:e5dd with SMTP id
 adf61e73a8af0-3c110a74439mr16405523637.42.1784073337693; Tue, 14 Jul 2026
 16:55:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:55:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:55:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-5-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jul 2026 16:55:36 -0700
X-Gm-Features: AUfX_myqHlSzO8xm3yTSh7xxi1465fSJTHE_l3BKcFMzeW6a8cmBA8q6u9K30Jo
Message-ID: <CAEvNRgEuTG3k_iKFMLtqGXXQ5tW6X6+8BsCB=Z1WGgqOcPV5Vg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] KVM: guest_memfd: Fold __kvm_gmem_prepare_folio()
 into its sole caller
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> @@ -97,11 +85,15 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	 * The order will be passed when creating the guest_memfd, and
>  	 * checked when creating memslots.
>  	 */
> -	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> +	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
> +	gfn = ALIGN_DOWN(gfn, folio_nr_pages(folio));
>  	index = kvm_gmem_get_index(slot, gfn);
> -	index = ALIGN_DOWN(index, folio_nr_pages(folio));
>
> -	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> +	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),

Could this just be folio_pfn(folio) since this function is
kvm_gmem_prepare_folio() and guest_memfd will always try to prepare the
entire folio?

> +				     folio_order(folio));
> +#else
> +	return 0;
> +#endif
>  }
