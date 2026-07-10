Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1E9443
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643016; cv=pass; b=lYYPuZMVrcDttOyNU6COOsNYr667RbPhPUlNoiX5jy2OgbpuTMPvbn9BpJwUK6zeyX2l9MKTd5fhfT4B/BfAz0RHmr2TkuvuhcPmd6ampQ2ioxKAiBOxWSEY1v9mErRLKVVrKUHA9C7By5Xv/Ns3Qf4pE5e3+RKKtCqAghv5Szg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643016; c=relaxed/simple;
	bh=hEG9UlASRQUW1/Ek7Bp1focRgkPzyR4Dh5Hvtz1uRIE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTuBRAx0zZ0ybqy6tx6B0GoQ0x2/Ndm5DUUiiMh1u3XW/tDUyZ30luUAq7hA8cJPkylXoT7AkNCFwPE1dTjYfQweYpg+NPGravRkAczP0XYfhZnMmtu5SMhmJkjWj3K+wtj7CiCymSYOFNV//U8ux0EU0naZFYvOUdp0rCQjsp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAU82VJN; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAU82VJN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37df72c9984so584872a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783643014; cv=none;
        d=google.com; s=arc-20260327;
        b=njEfgJbMsCQBfTL4LUPwokU2Jfq4GeZFTX7SdXFMYwwsVbdA03ZQ254gWDEyYDxRiE
         yfClsp5CAZYzbXpjMpMDyNq5F36vRCjcqDaIAsBzQ27NtsvVLU/5uaJpL1z8HDXQZ7QH
         0ng/gff7Bj2KqNv+dkP1v9ok3u5QjUUoYGsn/fMMoym8ZB7iBDx9nAxeOOM7zltvnjbH
         YbeHmZZT+hoOePB8h/q32wz3NUerEo9ZzPl3ztnueJGgVT+Kl9oWFYZuIDnNK67eDkCc
         5oTS++JuKDZndQINsOux+PrhO/Nk8tDvVTjq/z+Ec9Bc/uIqxSIb3YD4YOe9Rt+DttEo
         qzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=U4nqKpI/9AfExtjoOB2QAK1s1zSR0lW8GkqUQ83jroc=;
        fh=wfw0hEOlkq3EUE6azXKmcRqOiVR9wJZgs69aE8Vkuuc=;
        b=SupAdkF//MNKXD5G5mJM1xVm66uq4sZnLwCN2R1L3gyb9LcVRReOQA2YFpLQGxKauQ
         rb471XyXbip9bDMWTPlmitsARhqThJ+QncKDuepQwwKKHYXGBuAHDXlIzzAD1z/X+5aK
         VTmK4bYcSfVzi1l8G9eclHvINTlbjmEBSL8l8OxYyYVzl9W50Ahk776d3U65wHdO82qd
         fwjFGTSHY9CpbPe3Uu/v/2M0SIJPcHihQnL2WbMhHBv8/hSB/LJ1RYVJgt5e4vInei9R
         +0DQEj7OFp+7qPr2UCXSgf8Na/N1FrYkDjsfRNzHYydjLnWMRcI8TvS1lQMjYWWhba3u
         ZbpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643014; x=1784247814; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4nqKpI/9AfExtjoOB2QAK1s1zSR0lW8GkqUQ83jroc=;
        b=kAU82VJN6GnQD7fDy2z8Y02tdrWxrj6mF9q9SJyshwL3at6QeBg2Jv4iUNQWWaGs3y
         Z0hQkS3Q96IJm+J7FnJSgkrzBwmFalbAHFpRPZ2AmbPPfSjxN749a44+lOtKocyHbAyR
         BKBBBwoyKIj3fovr1lGrDM7zdN61nglrq5NzCI2ljX0qSIPiBWn0XcYbr6YWqz/GBHjJ
         LJPr2CE2RQLEDmMjTwMb0OL8hUIMkRBcUbjCE36T0VJj9+hncKjKrWnq0N6VxbWm5Ly3
         abNpySHb1QJZgdVuuoadqXqXjEiwKhSgNjTbpTwyvUrJ1nIY+ThGZwCI5PSCle8kQIhz
         9teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643014; x=1784247814;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4nqKpI/9AfExtjoOB2QAK1s1zSR0lW8GkqUQ83jroc=;
        b=Im1xz40sbxH3ouCXdFbPvnpXpatvp2jwb7b26ViU+G6y/v/yxXBL/ui8whCFBIP5LW
         IQ0FrIyLX9eHYpQJDsQ8YZ4WzuXIrAXHqDKxVylo46yQ4k0GmH9KYxXoNS9w2mHr1mKb
         pMCcSfmudO6IMIttRtn4k9GyxYhb6hscpV68J++eXhWDP4GtH1IhbAg3OVgljwmWhQ73
         Lx9uIRRBKA9sdK7M7dlTAMFtK0a2UCwv6/ppQf37kqnmLXHsgGDNegg9XAGHLWoZp5xU
         x7cAKGwPZq20pRQdBxrbp1sZQf1S8cHZW7xJPKChJwGcGWFcj9q1pWxt6YlfdXOQoNjN
         ZB8g==
X-Gm-Message-State: AOJu0YxoplKUj176X/Ob8g0/y9qGc5xpG01H+d25XVW+BkobKi5PKw9y
	4K/cp28JLNP8rYT7xNhcVeN3SiE4d2LZcVUqjximVo4q8Vjsc0fQAieK7MA8ls7Kl9lvQezCsr+
	EGylKTc7K6JoL0YVYPdUDJFO6efAb6uOGN3RM4H1w
X-Gm-Gg: AfdE7clpZ3CGeoz/FAconvZaLl/sHpmfR7Nv4d6/98XFNGlujcZ7MCZgq2gPmu3ALIV
	SGwmoTRfcxsH7m0U++N18ISb+YkvHZJhA9juJHAlusSngskh0X2xqQXnSdNFnTzem/6aYFB0Uuf
	LmNsKSRfTkTRcm8TDQl6hInkdYOy82kZZBVgya9rC/0+Cx4K8hyUZi1zjhkC7revyXJvBPvSOTD
	FjwdElorEdKkBFB+4wGU9wGHePFN3AfCgKNGFBZmMo+sYAfhWqPizY5Bom4BY+Eent6jBx/ei0Z
	iKAt+E66iuVBKJHRGwToJodqqKA8qW7/BPGE6IWaikKKkhrRLZHWl4Loy6IAl+i97eMOqQ==
X-Received: by 2002:a05:6a20:d708:b0:3bf:e761:6285 with SMTP id
 adf61e73a8af0-3c0bc9e3763mr11182161637.29.1783643013610; Thu, 09 Jul 2026
 17:23:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:23:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:23:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709204948.1988414-17-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-17-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:23:32 -0700
X-Gm-Features: AVVi8CeiGn97SLpqHdPUtNb7ZMExMtOy6pIhGUUKZCGIJyopDpeEsz4KwUOJXIM
Message-ID: <CAEvNRgEcuhTym+x8vHjKPxYZTMBYyRem2M2Ywf3ac9Df7iEiqw@mail.gmail.com>
Subject: Re: [PATCH v4 16/18] KVM: guest_memfd: Explicitly pass number of
 pages to kvm_arch_gmem_prepare()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Tweak the guest_memfd prepare() hook to explicitly pass the number of pages
> to "prepare", so that the prepare() and invalidate() hooks can be combined
> into a single convert() hook, and because the existing code is outright
> broken if a guest_memfd folio is comprised of more than one page (which
> can't happen, yet).  guest_memfd aligns the pfn down, and the SNP code
> *tries* to create a corresponding huge entry, but if the RMP must use 4KiB
> entries for whatever reason, KVM will only "prepare" the first pfn, and not
> the actual pfn that needs to be converted/prepared.
>
> Alternatively, @max_order could simply be repurposed as _the_ @order, but
> that will fall apart when in-place conversion comes along, at which point
> KVM will need to deal with conversions that aren't strictly bound to a one
> folio.
>
> Note, kvm_gmem_prepare_folio() still mishandles hugepages, as it aligns
> only the pfn, i.e. would pass the wrong gfn+pfn pair.  This will be fixed
> shortly.
>
> WARN in the SNP code if the number of pages to prepare is anything other
> than '1', i.e. if guest_memfd is trying to prepare/convert more than a
> single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
> greater than order-0 folios.
>
> Opportunistically convert the existing WARN in the prepare flow to a only
> fire once, e.g. so that a guest_memfd bug doesn't unintentionally Dos the
> kernel by spamming the log.
>
> Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
