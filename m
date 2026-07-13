Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC073563E1
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946385; cv=pass; b=XNWEC8c3LL7KNOgRFb3JxW+5n9+TZz7ZRoBHahF6SDTiVhoJ7BuNJ4iVF0r6kPViYouh4YgkAFTcVc5+dJWHB+Y6vZzEDyQ/LwJ7fim9Kn8oUsLqa0z9jKdN2Rk1bBTAh+6GxnoZXJKJQ53fIKqXlz43PaEKwtcFR+UE/+F5AkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946385; c=relaxed/simple;
	bh=kcXzZvQFGE/3wJKH5EFyWlSHh/jE/T/Scah1RD4Y6rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elZy7BpfqWK1nuHzfoYub/cggc6NlVowZOdh/BR8LDme8vfbnoQ6UCSN7MuLnRG/gB24/OqA+OcFqHGgv8vtEUCfqvvOoDhYe3ZHHEglhxSYHoOgjPhe/BZOI82+fzOUmfwRwbrnh6eFF/0bT7Tk1On/Sku0JV8DYXldZg1HRY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=yiR1s5pJ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="yiR1s5pJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so2034921f8f.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946383; cv=none;
        d=google.com; s=arc-20260327;
        b=XioQO9FRI32ew8yeyo0WEyU8ssdqMovx4AJpTkiWqyjxq+xqRg8vLqxvFgfwxnMz9s
         GdkzskGchmcCFtxozbfXezxFzIUYHmKOtNA78YbvLURzwtskSwfE1xGDM+SH6Zx8APfx
         PnHfhfmnT4/pT8GZXulwaaw80u2FDxu+DOOt8PbMNz/jzMTwDpFfzl1zNuA7Mhlb1LuF
         B5nqbOeKnqLoUfCAuW0At5bWAShodryGZRzu/UeU9rT7c+eIHvrNro37SYsGdK4ED2O1
         plnotyhIWZnq0X0IUxP3ba3OYzGf7EnylF2DYhuDF95rKxDwhya4OuADj8hnKxn1B+Cf
         raOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNWZP8g0uAP0JL7jY1bzT8JQmyJ8lb4pF2POpRvfaPE=;
        fh=EdXDe/VgEMvxgJ19leLLXnxiVhDIXl5AQiHuhj/ng1Y=;
        b=IyPUcSM4Ox0rf0PUVqHFJz0qZrUQKCxSq1naDWJdo/DQIuiB7ET4qtOIiJ6rmC3ahe
         FcIEjfLrDachPFIpAGUWWo7+yUuISAK6VWmCpU6vqQw0dTC1N+H+nDa57OMYwLi3Gj5H
         o8YMg9sZfYNbW7zOOZm6NfOk2S+8M/AweT9yXKl9yGFUVWxSAh9g4Wgbhc0K0AsPEZyn
         vXIjG/tvo6gqmD51JH0+wNLMdqA2/ysPbQK3jdU9UfqKCy91eycB3rqZfpGSqHVf1wzo
         SwPR+gQkaq71AbRHxPjHx2+jR+cM/lV+eITuC9KJs7ladY+iLunO1WM50Gjn1tdCbmik
         Urpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783946383; x=1784551183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNWZP8g0uAP0JL7jY1bzT8JQmyJ8lb4pF2POpRvfaPE=;
        b=yiR1s5pJqn9wNfv6EtqlrUnwTbsishv2egMNTOCHQRa+2xSqgFWthLX+sq09dj1hnE
         jduXm2Uo2JSEfvc9yrkluDTUDH8/pt4B0d7cUMLP9jCMku75YySF4bxOeyPnVJGfaSFe
         j4XVfCxz/M0gUlUAb5caTmyIv1bwroKBy2chwEWCyWVbPh0EababOchz/tKpIFIBwYIj
         VfVydzpZurrQN0VzRbWNsM5bncfofsKGG2AP3aAf8Tx1VaSBWKnndEwf6qvSzMtcu5zC
         2XHPiq5EeqPHBieZLiAcdvZhncx2IRMKkWi4mV2pozQ+WlNMt9EKegD/iswy4sMABUIS
         r4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783946383; x=1784551183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNWZP8g0uAP0JL7jY1bzT8JQmyJ8lb4pF2POpRvfaPE=;
        b=HgBCbpJaLlq1lvz3im1u8BbpOqoF83AZeIihHGbTPJ1b3pirq1zcPA3tJRmn8zOP7f
         ZPfrjdWP53vHWm1R1TQbkou8SIRMOe8FFD/iY0URkDXrlIHqeVEQNvEixDI578N69eUz
         amyWNIcpJqiPq8I5n+YnqRexAFs74UospcicBut/Zom/KnDnb6fylL0Up3LJsbfDeW4F
         1pJiXOridlVeWp2xufLCHd+PL6BxN1oFfLgpXc3OJDWlxSGifwAi0RTDPtuZrXo9+u86
         7hG43ilr8LlHm8Ws0nbLrQy35cYE0A+uhiVXXwXU/XCzLCs3aSuzZxM8Woxk8wGT1IUB
         DjAA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8M+DQ9n0sAOEzfQlHWitWPLIyfhOgx819QKlNUggVm9t2IR0r00Sbj/tMOKq9/jZW4IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKw/v+8okFNULuDv6qAIVVVKFl1cSjiv4SBQ0MjXEG/EtpAWN
	67ypjK5x3ua7vER45/4G6KPzv+yhzKYepsXFupq9TxFGXdCVd9C+QTQS1mB27m34WxGweMKUH8x
	9s+0IjKNFBbBOGZ9zePXNWE14Gy7AfzPv8JY+dXxHlw==
X-Gm-Gg: AfdE7claXYYH/+C3CPtsSyS4fPO8xxaSFOqjaqRLrCJkNVEDXx+VW5ukHumtuy4bRNw
	dKOi23kKuPKBgNgGpgEnCxCatcjsvkl/5662CXwgrE6523omJfWv1ZZQrNE33Hmxb3ItdAocXtT
	cx/w7L5Qlkd33kc5PsD0UuD3LXm573WRRxtwEGb9TAeKS7IQpSXV31G1w8mm8jm+vdHMeIlrHfh
	i2nhqyCULyiXpczWy1H02Hd9YytNcTZJKz2DacYcQ7ejBUfsP//vEMv6/vtPapp7wS4FROgihLY
	mAc7oZAW2jjhUWRL/urxIPqrV2dGUOHvg5JjG+5auTgeBrdN/W6tsZY9P8kxPgoIqPK3pTS26Lq
	ghcvFW17SzDzE85SS6z33tz42og==
X-Received: by 2002:adf:e185:0:b0:477:71ef:5d81 with SMTP id
 ffacd0b85a97d-47f2dc8cd0bmr11146687f8f.6.1783946382636; Mon, 13 Jul 2026
 05:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701075239.95542-1-fredwudi0305@gmail.com>
In-Reply-To: <20260701075239.95542-1-fredwudi0305@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 18:09:30 +0530
X-Gm-Features: AUfX_mwXj_7QcwyUg7nnOIiO2RcCPbUhH-15KvTXyB0HOEvvnkqibyEafWCL2JM
Message-ID: <CAAhSdy1YZYA6etr+Z552QNSGKM-iMpU7uGwDcYGydpb0b4qULg@mail.gmail.com>
Subject: Re: [PATCH] riscv: kvm: Skip preventive hfence.gvma for new G-stage
 mappings with Svvptc
To: "Dylan.Wu" <fredwudi0305@gmail.com>
Cc: palmer@dabbelt.com, atish.patra@linux.dev, pjw@kernel.org, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, zhouquan@iscas.ac.cn, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:23=E2=80=AFPM Dylan.Wu <fredwudi0305@gmail.com> wr=
ote:
>
> For Invalid->Valid G-stage leaf PTE updates, the flush in
> kvm_riscv_gstage_set_pte() is preventive. When Svvptc is available, new
> valid PTEs become visible to the page-table walker within a bounded
> time, so an immediate hfence.gvma is unnecessary.
>
> Skip gstage_tlb_flush() for that case. Permission-restricting updates
> continue to use the existing flush path.
>
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>

The patch subject is unnecessarily long and needs some simplification.
Also, there is minor warning reported by checkpatch.pl related to
include of asm/cpufeature.h. I will take care of both of these at the
time of merging this patch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/gstage.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b7956..7b805112d 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -10,6 +10,8 @@
>  #include <linux/module.h>
>  #include <linux/pgtable.h>
>  #include <asm/kvm_gstage.h>
> +#include <asm/cpufeature.h>
> +#include <asm/hwcap.h>
>
>  #ifdef CONFIG_64BIT
>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 3;
> @@ -171,8 +173,11 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gsta=
ge,
>         }
>
>         if (pte_val(*ptep) !=3D pte_val(map->pte)) {
> +               bool was_invalid =3D !pte_val(*ptep);
>                 set_pte(ptep, map->pte);
> -               if (gstage_pte_leaf(ptep))
> +               if (gstage_pte_leaf(ptep) &&
> +                   !(was_invalid &&
> +                     riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC))=
)
>                         gstage_tlb_flush(gstage, current_level, map->addr=
);
>         }
>
> --
> 2.34.1
>
