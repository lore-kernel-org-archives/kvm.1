Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6945C6E1
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341191; cv=pass; b=cnUrr0nCIP1JsCe2yV90TOxclbga+1RfTZRWW1M9xX2IORYCQ5j69GEOqGDs0/voFrTUBgsl8wvsqM2DGQgRygqY+GC2f0hf5/b7XqMWx57KaUF9PnjG+bO2NUHZXTB8w7aQlv1yoz0Zxw+XF/3DPN704qXJsb8DJEgKbT3HNJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341191; c=relaxed/simple;
	bh=OrwyfV74x4bYYJftIgMTXaC+/cQ3WeJ0wBEnzr8oB/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAULfVuBgg3PPm4OJqghxPf2EIu0JXRPH4izgz+VNfylAyQujIJcF20b0agKZ8ehnBYTMhuvntK0N/6lE0KdLgozLKSNXAuJrAfP67jzS21lNze7Wd9B0h14dPuBv8K2Jmnp/HIpDS/JC2ibllB2N7avzQFTglzyR4WFVqno8Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=AQIKyWht; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="AQIKyWht"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f7027ca11so770825f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 09:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341187; cv=none;
        d=google.com; s=arc-20260327;
        b=cPYYXcFqnGY16VwkC0/ZsiHtzdfxeiFkqkK+xF/++A8x0iB89tpeNTjsJgyKo2RaKc
         Q6N38kqHLJrBHzNSTvfQGPuElHQR6rXWD+YQziVa4Z3qKdPwDMLi33MgBGjGNBgZQXnm
         uiwnWK0EhjnKYYJ5DKgQTImKZkkVaUDtnzsDQZe5IGiVhP7VZ8ra/xbj6aF1BVUH9aJH
         G47qGiZIjBBzCb/96TxUxrcK92AEgLcfveV15SI8f9FtvnCgtDKs9NvOBRqjKK+H3xFN
         lxDp/bxXMB+9LhOukI4gSpJF6sgVB0WhhW/j/2z25YUnpytAuMZQjC1tvOzN6nzSos8y
         WUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        fh=71q3un+i7jYZY4rKi2FH4XkS3V2uJJuHasQC7khLFKI=;
        b=e4CCCGuqqlLZJHePEobaBaQiOttVB0aPJC6yc8vl72KrgKw0DMcldMtxL4soT9awAr
         g93tb3Ngx0qKiyuLAfZ9sjfJU1w9PH5IyR9zKCQuu6UkMTmQfKmc6jI3ieDKcrV9GQ0a
         zlnWy20JUVwv5pq7mXCWpikjuNco4Bzx0y4GYrYfaaHKdGZM3JhKDgw5heJCrYppDDPL
         s5DI0HQwU+aPN4jXd5eM7THsX+HgAZBKvmNdOSXtTtLtrl0akZSivRZR80gLuHW5+lpa
         Ee+Td2H6aB5rH4WtPnivfQHYtAA/MB+mDJpWO7TrN5vMK/ny76a9QBdJeQBj+EaFv9UU
         xlqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785341187; x=1785945987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        b=AQIKyWhtCqrwkOhI16aUTnWVNuDGQ+V8I9MiU85et5TlcYpi0D8Nl8hThfcf/JwzHt
         dC56g4GWa9IFFO0ixLNjc8wQ6VUw81j5aWmzYExU14EYLNfAFxTtryNfPIpXRk0l0l0C
         yo8EltW5nocE1d1ecXCJzQZsH3+iN7z745jKi/JWhzPsb2dQ7TL9LujnXBMQt3ywZXJr
         6aMkC6DgvERAkHrHvboq8FqBXelc9+dH3vwaxMvzMq3TroxJjCQI4B9x+q3KkKvoStzr
         b06VStPDMmqckRBKSnJmCgN9tdfcOAhY2UfFrEXNVfPuu6iWvwnFgNWQ2fdoey7fjNVd
         GKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341187; x=1785945987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZCxNpAkNUCXAcRdhLTO0d6tb8+6Q3Nj0sfDnYlByPI=;
        b=JIExL9sNy03McpAf9X6Hhc4bpsD7YIur70p++OPRsz4z2evkTVegbPTdLzK7MBld5u
         JtbVyKPOyRCMxkOCNpD7gTDUTgYphn8BxZrPoyOnybIlU8oveOUWJM95BzdFjqtR96/0
         RgxdqwViyHdVXE9RYkNfLvKBDp1M9tG0aheI1anskkIep7OXfE1xOl0gbjwuuhKDpHUw
         feKTSMpN78M1sp3t1fAl6yM/AFFMGxa4M/z7UUO7tETEKDiodK/34wrFnCjeaP7KKsbb
         flJpi5rFk6P+SFEWw1rqgpljM1+WoJsNfMvzpq/oUWyd0zkCTUSPPziXD78sCMqXpWVn
         5h5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxLxpUjOGmDPQo8o+ysnLy4jfvArvFg/x/sXd5kLJG/Ia5iszDe6iOjJAlafUzlFvb+Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwMWbVKaEedx5mTrUzJjxawdZiw0WiMLbt/nDgb4L+HYi7Fxc
	1b7hzFPlAR1r/DSyLRZLlw47VhLeH6DHgGxvydvhDMXiMC3J9LTOfqHQpENoDUW4Vo/6V7W21w+
	3rKn0/CSR31b43HcMV5lXbgVaVM+ThM34PJvytHja/w==
X-Gm-Gg: AR+sD10ggjA/2znZtSmQQPqYPzvLWWfUIqiu8HInuc/YHKE7YhEXe/zkXjKDWRTSw4/
	O3tqbOz9ELPl4UWXUNrLGpRql58lsy3tK+lp3E9rFZp40NQDKrTPwIAdSKVVNwgBLL4c8l/GGgm
	+KNDibhL771zBfQ4l5cf4dG43xNhA2QLfhj3eJAIMrL0o1ig64zPnr54Qgnxf/jRn+MPhbzVZI8
	y+XY3F18NEuDRHqQR5TrReJzu1vDI/yLeh5XP1THvT67rCEmYUcMB3Z4QByX6aHSDFNGqWfvgk7
	dvYY9JKBXRYMDp6lNMsC/R5L9Sx4zE0Bld2yh7dhWpHQ1sEnLzpCtNwJb3ftz6JEFGzCYwXE82g
	hNUh9RLJEmmTvsPcHNE8+81eOMPCq8+ZVRnb2COCphMdQ/NlhaKwt+qi3iCDCbbWf
X-Received: by 2002:a05:600c:8b2e:b0:495:6e68:39bd with SMTP id
 5b1f17b1804b1-496c6597a0fmr96285485e9.28.1785341186425; Wed, 29 Jul 2026
 09:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-2-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-2-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:36:14 +0530
X-Gm-Features: AUfX_mwiSOUOFP2TPHe4Inq1CQye-PgTV4ubVFK-FDwozFalkW3VgzVL7PEKoxM
Message-ID: <CAAhSdy3ziS_1iiUjC5HSVqX9iMgckyS7Yro=xwZyomxXC=MC7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] RISC-V: KVM: Treat -EEXIST from G-stage map as success
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com> =
wrote:
>
> When a concurrent vCPU installs the same G-stage mapping while we are
> waiting for mmu_lock, kvm_riscv_gstage_map_page() returns -EEXIST.
> This is not an error -- the page is correctly mapped and the faulting
> vCPU can simply retry the guest instruction -- but KVM was treating it
> as one: printing "Failed to map in G-stage" to dmesg and propagating
> -EEXIST all the way to userspace.

The kvm_riscv_gstage_map_page() return -EEXIST only when a leaf-PTE
of higher-order already exists. It does not return error when leaf-PTE at
same level already exists so this is an invalid fix.

Regards,
Anup

>
> Align RISC-V with x86 and arm64, which already swallow -EEXIST in
> their respective fault handlers.  This also lets kvm_release_faultin_page=
()
> drop its "ret && ret !=3D -EEXIST" special case: with ret normalized to 0
> the regular release path is correct.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
> ---
>  arch/riscv/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216..943d8dc72105 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>                                                 vma_pagesize, true, true,=
 out_map);
>         }
>
> -       if (ret)
> +       if (ret =3D=3D -EEXIST)
> +               ret =3D 0;
> +       else if (ret)
>                 kvm_err("Failed to map in G-stage\n");
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, ret && ret !=3D -EEXIST, writ=
able);
> +       kvm_release_faultin_page(kvm, page, ret, writable);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
> --
> 2.54.0
>
