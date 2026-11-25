Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620945;
	b=Cqg71PyNE5QpQiI+pKangUqhit+DQkZEGNcspJ/gYlGRwmGy/QnBMxili0DTbWaOTy8R
	 FpoabrCfZTqHjTf03l8fojllk0FHRIWmiw4FSqqZdSudG4evHemSNYxzega42VmevbsLM
	 iyzz5a9EmtbnZWv2h83CqoYl6270E2rGljQRxIy+mW7J6EyUmJu9IW+rYYNsk/NqOar6Z
	 K2fc4Rl4kP3boDzB2EpefqSetYKkHecrDDNYoQrzDoFsb9S2J6EkTT3qkr9AN7U6vHBn3
	 vgXuPYeO5RLtIOZLcsIH8Gj4kzFHWzxDNJu94xDTPZvHQzYMrrBEjMGhFx85SX/GpaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eR/tiRX9GFewYsayqztCCACOfK3phuUQmHI7BlMOyHI=;
	b=5nSsO6WJ4nhTn2e0AO06s7CNOscwYQrjXoSxTXbt8w4Roo7eQ1c6CV+NdOeMoS4TGF7X
	 abRN5Ega/2rHD5vpGnfesY/PhanVlxAduf/k9e8mEXMMSQIifVodxAbRFSshM2rBLbZ2m
	 VZxZEY4E7Us+xrSIFzU4HNu5w2MU5PKknnqq11lFhtkT5ygXHGl3WnBQBXsQUHoruhXRh
	 J8/v+F/T93+1eGu9nC+IIGHnHEra5zXkPUmxPnLoaLVf8RNUynlEaeS05ol0pcHktZ6CB
	 RDigbH5jN2hSA8fCiHQLJ7OveB0R2fvwajsy4bEW4x/v0eGFt8+Jkls6A4y7s5cY9/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=v1mFAf5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457B60A380C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3457B60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=v1mFAf5J
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so3715667e87.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620943; cv=none;
        d=google.com; s=arc-20260327;
        b=XjYvEMMvyC5SVx5IvoR0T6obitNtLNuu+dxDHM/0uX0V9mq1EzOgb3vC8GklGvgtJQ
         HVpYltjqi2G9LExztuDELDCp4IZ+32LNQwXsRW7Gq6570kZg8sVFmlKMa+s5FsmV6OjM
         GOHp6KYjPQpz7KW88hzA1Z5LWQIEXmX81aTRHKoeaD6BDDeR+ZqQq3M6LIpCmUf669/h
         V0jyyAOGvhRINLp+rxOjljDEmCqTjcl/ZKo7OF2TXMFS10KmJgebEhRsEcGmIOymHjXb
         DzYTbPMNT6VrAxgOI6mxnddihyEBtToYodx9c3YCWHS++3AfR2BxLa4KBdwCa2qBLO13
         nPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eR/tiRX9GFewYsayqztCCACOfK3phuUQmHI7BlMOyHI=;
        fh=uuWmZTJ1reGQwYl6GV/KvkVwh/TW3Fq2ZNvsC921vFo=;
        b=OMGpfpKDMc6AbI+pNRNhrNmHeyugBrXkRBo+JkL1Md9LQYq8wnthLRGgZCxLTtszPI
         C5TGYgSzb1XWK24+PNGOeRGw07MhFP15xPmzXJGHXYE+CJOMBAEWslDMnKpLJiKAhDfA
         DmQod/7CyuxcvQhVV11WE+MzAF/1XwYjJ+Hw8J46aqH7wKlb4iZuY6E4oTRyThs8lJVm
         30yWahARZJaNGjpW2wS4pLrhIrTx359lp5+tvtRAk+Lzn+kaemQRTnRcRWSJTflqgtZ5
         crYNpjkH305yLycBFRN+Bwond/qTA8XFMW15p524bg/rcw/zr7Sy9OKL/GUrRefMliuZ
         3KMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795620943; x=1796225743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eR/tiRX9GFewYsayqztCCACOfK3phuUQmHI7BlMOyHI=;
        b=v1mFAf5Jl87YzT0sEYvcgKKxSdpZMrI3/TqleME3WU7+9K/fPLgzTUr+aKMWCoHXIl
         wFLwW5JqArehUd0YMMMFxBmTJ6uLsUmCoL7htwt8A6BsLsiCA9V5nVmI2Q+SM9Owyu+Z
         YMvVI5XuvlUxDAugD9si8D8/VJIyMWqGUtzO7d2n3p6gcjjFDuq295vVPThMKrL4V5yk
         ZS40MfOqTYmPvfh1woOGAl1CMbXRoc0HLVAj4ktcMS99Mt+mOcUJHCrwG71TvFsJHltf
         +4r7AAwMFNNNbC4pCEGQKQdoOy7eEyJ4lmXWHw00yUeDZztyBUkvRTAUbhYddKp1pTmZ
         78pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620943; x=1796225743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eR/tiRX9GFewYsayqztCCACOfK3phuUQmHI7BlMOyHI=;
        b=uaF7UWoFWYZiKtGxTZATJKmuA1w4Gb2BkALLqJNjdCLNkbdhVSFOIs5L+VmlPwjDfd
         DYcGa8krRkrfR0GX7Kaa4W7NSwGxA4CyHkOrQpJfEruKSqc4SCOwdBlygevG1MpVQSJ5
         vldL4MfHL2vj19mLO0KtH0B8074iAieGcAwwD1rec9KdtecnuqeM/MaZnklcz4ariAPR
         QXNyk+7CzWnCY9NeOb8VUMvzQofEFgK8g7KX87Znl7WkkXHR9t3VR1K5pEVdzVRKOIyp
         OguXP8aTJYoe1WCuLdSaipvYcASQdKUThpUvrFrZyIIy3jp7UiT9Wfhxh1iDIbQr5Ei4
         UZ5A==
X-Forwarded-Encrypted: i=1; AL+hErEUPWO9W1Qz8a9I1LY9fYj+gIQYvc1ns6QN5wuxpvExJTWTp907400hlzFA4hXbxzStgxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/05NWtl/onpaAmnrj7G0dg3LA9A1glF69sDgfw5kXOXV7kRPMI
	3aDMzn38kG9bbGCgKomRjBakJfeu6vJg23GdrVToBqHCuWp8d1pko3xrWPwCLwQ+ympXW/X15B+
	dNGbexSXV1BqXv38ZBCoLdiRsdATSJZaGhRr9jtzZSQ==
X-Gm-Gg: AZFdTZe2kDmqsn86NtEdwx7PuDFHfSt08OZ40Abb0tkgt9dL4UuxDx2y2aFN71OkRFq
	IrW5nfHFerShZfH8IQL3ooCq6LLBocrXrOAjXmibG9bEyy2ZDjPWuwtN9+rVg7/kLJuycGpGwSh
	cABb3O5J+ng37zHnIkg7GL4jzJmgQYGZLQEtPGkxcYIt8voXIfMSSU7/CGoedaowmCKUqKlsMS0
	EEloRMSNqBPZe4O43svd5usReN8MYYPy9HeNXpeKQfjM2hb0UQDLidbT6KIAZF5twJ8I0IT0rIl
	TEGavp8xsjt6b+JmqiWC0RU8Tdb5NDEOcnTk0HBdL4rpn6DvwvdOqM2VmQh9RWzP1tmav7mC3RT
	rgHwFbXpzbSQvFoR3BLUvKpIlvuABKKG06x5oS67L2JufWG+rKN/Nwram8iP9Aa45XpCztP+WNT
	2PXi8lNM4KnSvlcFoVzFE/7TKw1BAhSJrBLp6uDKdknybS4OEKJ3Lq
X-Received: by 2002:a05:6512:688b:20b0:5c0:a4e:5cf5 with SMTP id
 2adb3069b0e04-5c1bc7d10c3mr3567435e87.26.1795620943192; Wed, 25 Nov 2026
 07:35:43 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924-free_bitmap_initialized-v1-1-4cfb73a0d04b@kernel.org>
In-Reply-To: <20260924-free_bitmap_initialized-v1-1-4cfb73a0d04b@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 21:05:30 +0530
X-Gm-Features: Aa3M54oJBm-fP-yPqacXbdiaITq6or3sIYt9H8e38Vy7GvqmmY_G97lMunRikYo
Message-ID: <CAAhSdy0cfbfufYYhVCz6Tq0_1RrS0DEi5yfKyBJr=WhUnd+QZg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: AIA: Initialize per-CPU HGEI free_bitmap
 only once
To: "GUO Ren (XuanTie)" <guoren@kernel.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:34=E2=80=AFAM GUO Ren (XuanTie) <guoren@kernel.o=
rg> wrote:
>
> kvm_riscv_aia_enable() may run more than once on the same CPU.  The
> per-CPU free_bitmap only needs to be initialized once, from the HGEIE
> width discovered on that CPU.  Perform the HGEIE probe and bitmap
> setup only on the first call, and set free_bitmap_initialized after
> the bitmap has been populated.

The per-CPU free_bitmap for HGEI lines only one unsigned long so
I am not sure what you are trying to save by skipping one unsigned long.

Regards,
Anup

>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
>  arch/riscv/kvm/aia.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index b3b466e4db33..a65748321f7d 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -610,6 +610,9 @@ void kvm_riscv_aia_enable(void)
>         lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
>         hgctrl =3D this_cpu_ptr(&aia_hgei);
>
> +       if (hgctrl->free_bitmap_initialized)
> +               goto skip_hgctrl_init;
> +
>         /* Figure-out number of bits in HGEIE */
>         csr_write(CSR_HGEIE, -1UL);
>         hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> @@ -634,12 +637,11 @@ void kvm_riscv_aia_enable(void)
>         } while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei=
, hgctrl->nr_hgei));
>
>         raw_spin_lock_irqsave(&hgctrl->lock, flags);
> -       if (!hgctrl->free_bitmap_initialized) {
> -               hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(h=
gctrl->nr_hgei, 1) : 0;
> -               hgctrl->free_bitmap_initialized =3D true;
> -       }
> +       hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->n=
r_hgei, 1) : 0;
> +       hgctrl->free_bitmap_initialized =3D true;
>         raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
>
> +skip_hgctrl_init:
>         csr_write(CSR_HVICTL, aia_hvictl_value(false));
>         csr_write(CSR_HVIPRIO1, 0x0);
>         csr_write(CSR_HVIPRIO2, 0x0);
>
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260924-free_bitmap_initialized-abdc94a528fb
>
> Best regards,
> --
> GUO Ren (XuanTie) <guoren@kernel.org>
>
