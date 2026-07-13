Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B123392F
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920047; cv=pass; b=l5IuEEiR+RZsiQiMlFaRowyLGpRhktNLfcfc9KjGEB6io9ezc0ieoGBfc6mHwnZjY+Bs/vmPruFuKENjHSQ9cY3VKPzG08fBSYm957r9TCEgaB7gUpHD5prVIvXBoKOybJ4a0OuTpua+IWO0rfIx7mwzuDz+KbxDSr/Jh9uIu5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920047; c=relaxed/simple;
	bh=3ixt09FeQ0GjinjMXgzWXUfCsr1DrjcHFj9M9APbUow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaCZZdckEm9nCPcEubGFXjCFOHlBI/mFqAgFm2zUaM6px+GQd3rGYp/jd19EmN3KTQO/aHoJD0OmdQxI/uGyX8510zZuCfjI0EaONOenNd2xXp5xVT7/h36Z4tXR9tGpkWGHX5/7U2qctTiuqn08Vq7Io8RpiEaN3kgiVEvxkZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ad4MJmVY; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ad4MJmVY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4720d22c94aso2216939f8f.1
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 22:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783920044; cv=none;
        d=google.com; s=arc-20260327;
        b=aAnlOaQa5eY2tGb+ACf/MqTyueOXlgbklQU6HgEExIDQWuc3VTwaY6J2sIQFxwxTJm
         JMDSqPM4OXmsxFF8KYZpqj1IckJ3yK8Xcf+IIORZWpzGqMKpOiRRHHAWiAED21auoGcq
         lNlqFDOJ6fY/Ouc5TquGn9pEXdySKrPGjPuvDPMM/OT35fCm9ftTKXWdzDGkLknUehwj
         C0aHAMxfbIPNTMYVZuNwn95bTNYByPKIrZNXU8h7CfCOvrH8VnVvddArxnk+h1GAp6if
         T7rTkbrJ9/01tta1flwaCCEOelHaZolptiR54bMil51oJ7SRSNVQyLN2B8xcuFlurnyo
         4sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vtAiO3GAOtWbZl83N5tUcn9I/FK/tuLB8pt/tT+Gqe4=;
        fh=3XRDq6A83pdqoNMCRm+EICEBPk1Xfl3nPOjv75WRA/U=;
        b=p3ht6xjs1JBiuf4kef4tCpJCEjHPTPf21b240oySIu3ohZfflevKnQSWdpk3+UaIVc
         r0PBJKyCmxAlGeHheytf4654UivTT9HS2JeooPvVLABBibBr5JyAIGLBxi+znjpzeU0E
         VgNksVwBdk2iR6aE0Ld1TxznlDdIGiKwflMOWKTsB7m4ab3tslJvEoi3lZgI5yVN+S6F
         mLFOm0fGlKktA7KcDUVIhG+tUrAJvQ36NLa0tkQn0j1YidRHVrzwB1gw6eecteu5XNnr
         uTWdc/2Ub/kX3SBB8XEabp4qPDBfuavekeXoZNt5GVu/15ntkQKd3r2SP8zz4KD4brzO
         I+ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783920044; x=1784524844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vtAiO3GAOtWbZl83N5tUcn9I/FK/tuLB8pt/tT+Gqe4=;
        b=ad4MJmVY7KSxaabDOvG1+EaICGTh+XBkWDO99iSkN5P0WnYUByzY3nbp0uZxD2nVrz
         KN3BHFY3lTzCD7UZtsgJODQKGrCHuYNF6VyRPeIjacj3BPtar7RP93qHUhUM+xUgghWs
         TTNugWMstxwsgGfu+oDOJNcdjDgi5Hhp1RD39mqkUYaWDFWS7YcJRi6rPWOcm3iap/g0
         JQi2FpyF3LIDtUp3T+TkOGqh5HgYFMdAwuuJt8kml00j5X/qgjRbdq5Z4Q/dx5k4IY8Z
         CLKdMNXsKy4LljYf9aW7v9xDXnx3uuXzN3qHlsn7Sezqhhz+8aLrvsWnkWI3tKY5g/05
         YGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920044; x=1784524844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtAiO3GAOtWbZl83N5tUcn9I/FK/tuLB8pt/tT+Gqe4=;
        b=Yf4FXYsHXXqrhnCfgfpZrrnhQi8Ds3cDZTjtEAI+J+Il1UxvIMRiYqSGUHbKMei2Qj
         2rqKIVgzJQlKPo94jG6u3uBdTNVR77GS1Bz/LDhHV4+feNKkwtdSM+rjt6MeMKhTVrQe
         NwxSMzGo0GXZU+PRW7CZSKF+LmP9qW+CmlPq0Q2tjqM4it00rkqIsbNu834ecBgzU8wp
         0wdRPzg86FKUoxqxY6/jM9Cwb0AvECZKVGf8yMZaT1zAXvTDqBC/duajjNHGizuaNr24
         ZMgqmwWLhyEhW9X0ERzJ3KVUgd8GbTP1UFA9ZP+jv8d32j7tLxPGgPL/xqFiEUWH5N6k
         XtCw==
X-Forwarded-Encrypted: i=1; AHgh+Rof7s2NmFWfgduc4vjWFar+0p5fwS5HQk5tHHqTZmhM4Vt7oHW6wqTO8bQ8ebTAfphl7M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYenM4OHw8omlBLLdL84VXfVmZh0BfG/o5zHVAiKz66MCJ9Mos
	sVRV4g0j0SMMoOsJ/7Z5n0J/hJr/nWubXNKF2k9JwhpzLF0PCFtGllWg5ZhLNoxCEQzH73Ek4PK
	0rHIs4OQEB5+ZNDIYvnR1QXpCsX+MruZJcz3YeJdRWw==
X-Gm-Gg: AfdE7ck2as/BQ5dml7t+z2jcQlVj2j+iOyzXqUIcQtMzvSxdD0UOK+1jLcsniI2485w
	MfVqqq9czOMMkamkDOUSIGtvCkYoPgdsTImz3gEUfwV2DJZPzFauXleln07fulodPFB8fATGj3p
	P3hiYUf31DH8jgpaiGGxgDXBZ9NL+VK49mX52A63gJ0aTN5NP5Z5DR+eqmjdezDOdrTquxLIymM
	01gm3SYnK8qmMz8HiXBhMqhOZV6pz32O4ryFUIS0bJj3aSzz9i3E4+kmPHgfuWhn5CvqGU9Ags3
	f2TRjC+kS9fR5B38pLLnQ8+o+e+Rz3sIHBhZ5EqsjTKa5gJ30F0wwcN/Ov+gCDukQ7Tm2yloH1e
	wjAcoxKR/tgXFPc3J
X-Received: by 2002:a05:6000:40cb:b0:47b:5f25:7c59 with SMTP id
 ffacd0b85a97d-47f2dcf8d32mr8542206f8f.38.1783920044394; Sun, 12 Jul 2026
 22:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610093922.51617-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260610093922.51617-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 10:50:32 +0530
X-Gm-Features: AUfX_mzgLxpjt24Y_crhzgSd_jT-mGHCzGXn6QWlmdDMie4AJ5TBR2ZEqWhokTY
Message-ID: <CAAhSdy220vPtK6a8WpRbmyfN2Aa2wQquJ+p3rLP-P4XOPZOzPQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Avoid redundant page-table allocations in
 ioremap topup
To: fangyu.yu@linux.alibaba.com
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:09=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> kvm_riscv_mmu_ioremap() currently tops up its on-stack page-table
> cache via kvm_mmu_topup_memory_cache(), which allocates up to
> KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE (32) objects per topup.
>
> ioremap only consumes non-leaf page-table pages, at most
> pgd_levels - 1 (1 to 4) per call, and for contiguous mappings
> within the same huge page the non-leaf pages are allocated once
> and reused by subsequent pages. Topping up to 32 objects therefore
> triggers many unnecessary GFP_KERNEL_ACCOUNT allocations on every
> call, all of which are freed when the function returns. In hot
> paths (such as vCPU migration), this creates avoidable allocator
> churn and wastes CPU cycles.
>
> Use __kvm_mmu_topup_memory_cache() with a capacity of pgd_levels so
> the on-stack cache is sized to the maximum demand of a single
> mapping. This removes the redundant allocations and reduces per-call
> overhead without changing behavior.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270..873a5dde4b92 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -39,6 +39,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>         pgprot_t prot;
>         unsigned long pfn;
>         phys_addr_t addr, end;
> +       unsigned long pgd_levels =3D kvm->arch.pgd_levels;
>         struct kvm_mmu_memory_cache pcache =3D {
>                 .gfp_custom =3D (in_atomic) ? GFP_ATOMIC | __GFP_ACCOUNT =
: 0,
>                 .gfp_zero =3D __GFP_ZERO,
> @@ -61,7 +62,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>                 if (!writable)
>                         map.pte =3D pte_wrprotect(map.pte);
>
> -               ret =3D kvm_mmu_topup_memory_cache(&pcache, kvm->arch.pgd=
_levels);
> +               ret =3D __kvm_mmu_topup_memory_cache(&pcache, pgd_levels,=
 pgd_levels);
>                 if (ret)
>                         goto out;
>
> --
> 2.50.1
>
