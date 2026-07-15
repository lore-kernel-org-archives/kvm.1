Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932394C0431
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119882; cv=pass; b=eaiD/VSWgAKCXf5TvcNZuGZLG8FsgtcKMjbNGLnC79wrrv2NwwAZ3LeN7D1mY0e4WbxPcIjAsgKvrJ09BqZdu2sFTQj51jV33buAnWxW+xPoVc2HiyrPIZlhn3mYr9csf5fNYGObc3GGBKRn8el8U4JBkDrPeYGRY+HCRCZJPiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119882; c=relaxed/simple;
	bh=2dnmCYtsZG4uVA7LkZsve2zEkBFZi7LRR11RruYnEvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP0tC+JywfzVDtZPjLUQIIxvoOWGlbbMHpEKuDtSu6xWOW2lHfiWVlSHLbrOTEcYegixECtyculbyCqMq8FrF5Qi0ZkPsQzTnMuwJcuUqoG85+2wXOBz6aPT+QYGeCTggaAEFetn6FEINdyEw5neaIgODxdMlY875QfDMf4uvd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=XqHVUthN; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="XqHVUthN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so11539485e9.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 05:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784119868; cv=none;
        d=google.com; s=arc-20260327;
        b=Ht1pWbo/gNhXiPJFiq0FPg6WtIAagUcOlu6rxlBQNBrW0eNnWPu5enX775Zg2y/MjX
         aWnqu+Wgs9movATtmsm6khknlfJqHRAoie+tXIuz5RV9Uf9f3y5YCG5K+rNaSN0iZPHg
         EzmWCSSFEElz/iTSe/WK8lPyIj2T7b/IClYvkxnrcF09QlvwGFcPgXBP8L0+zh3bjIS1
         9AXm38IVTNNlgHjUuZJVt5xhizGOY/S+AsUJPi2KlEeHJsw0QHlKb/ki9txR1+P8cove
         3F3BXabvADhLMOLQd3PEOAYWfp3PgRkCCAElRTcV0SPXfTGl29SeVWuJVKCyV6Cva4Cb
         gwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIFT3gs8xN30+UUY/21zDr3vYrRwm2h3kXT62GHy6VI=;
        fh=6+4ueSZ8A+xtYaBl6QfxH2oqQqKiizZodiG595FbNEA=;
        b=Q5h8p7hYTQZK+tzfEF/aLINlQgwFMJO3kVlDErIArB/saIK9MF81XSDEE7dJtHlp9y
         a52oi5CSTITj+x+Xa5uovIQX+uDk6i82UlB+PUEmhg9B0xSicPXeClXRl9MsqSLHs/K4
         fpqKSiaQsF1b+TW8Y5iN7dQgvGW2aKagdFFV0/Web1u0S18DAEEt90Sxu8l373iYRnVb
         rRI7Dt4nqOBSL59CKqYGDgFQlxgs7YzvH4fGUuhsHvxdMLTo+7psLOJI7sDB8A76pZ9D
         Juq2CNKPhqQXbuad3mboQDr4ct8q1K753HhSxvFYJyPB35SE9vt6lsUBWW8CFU9cctne
         T5WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784119868; x=1784724668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIFT3gs8xN30+UUY/21zDr3vYrRwm2h3kXT62GHy6VI=;
        b=XqHVUthNqUAhOaSXKPifr6tlD4p6aaC8mLVUkVXxPthvbCtBuxg/GzooSxtXiwyAOd
         d9MVZICrul8ecwpGUPS4zP0erEIPNohcTx9oWXe9x22zZDvg9tHSTSL/Kdas3/fEtfPw
         II9RLFflzaR7P2aOcD+guuPBerPHyz57JR6TpqFg3NgLoFt3VM+wT8imLlDDaMCtjARE
         a3jdFCT91cpf/sumNFt135pyYfsT2y1WFwo8A8p+5XXWuZJ6mJP1Ge6fYMw4zVqGOx/0
         yZd3ILcHbtMQuEVIDWkCy47w+HpvJquQ6Vz8STrY4dsP5etp8dTaS4i5zH5mRzy62bqu
         DOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119868; x=1784724668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIFT3gs8xN30+UUY/21zDr3vYrRwm2h3kXT62GHy6VI=;
        b=Cr4gxKIms8aHmOUz+Dw/V29a5/2OMW/tYTxcpWZKenZ+w/3sFXIZlfUFaFp0vXVBkP
         KOqki3yCDKATvk760ZkQSwa5u8OJLy936762FLra+JpTZ8YEpap+jmK3M85atm5xl/Da
         pRL7exu68wdbHmPpgN1qR5/gfmhx1USxao8YUcgaD1DTQH4GDpoxS7PYoE+2uL+AUvy2
         mtLYxfhnN7oTvVxDvt47Pux4e+TFoS7SG4Sh3qNB6JYMjlQ3I8oNKWiyr3Q6fq6QX2LY
         cM92Dj1fbveKOASz4cvsuBXtSZ8caqlYIX5MrGfSyAs3Ok72SjJGkYXrcNSLaghlPPDm
         GkYA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/ZdR6dI3RN6bRuXGisGtIzejw8E1DmWCqGIFfc9kEjBY3jt0sZ4KZwcpCM1RoNssfAFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzziSn6fqYM912GMYiLvb3aVAPJJ8w3LHO3yOrZ6CjUt9zK0cQY
	NycCdtWJ+PlNrySbaAE1a+ukXQcSqDhO4mWNt2cLmDu0NzWrrvVK1giWhU2qBQZjLXan91JISVu
	0Y0FBoPWF+SzCrf8iYaUXhP/SLasgdf/wZZMM4vf80A==
X-Gm-Gg: AfdE7cnGXIjM1pVwkBHlOr9gppTOyitu5sRAvSazRFNdsCwUef83LevkxrfCdVRWvGH
	Jt0vjSL+2hFLryRoAXkhBUY/B/iTvJzfHlylAiJMiFavdRvRe8r/HGCF/9awoNlvBFR2Qqe9c0h
	k7L/P6xsp9eWbYni55JT6LE6cs4wblf+t/ipHm2jWxIrALAHh4CiyBAlRFKl/xUOJk2UMpT35XG
	bfwdi+io5sVzlfzGQI/sc55FaHyM2lUMuuvObpRyoTzE3LzCh9oUUuXnpNzEiIdS0JBGiFR0tJY
	VBHFWMjmW2tlg7CwcCJMvi6hzw3xdbPQQgaUrKi9MhB7y3ODdm9zpNKrVF1RuG1VDFvr9vdrNdA
	rqkD6xwPF/8M/ssePEOCiLlS9Jmw=
X-Received: by 2002:a05:600c:34c9:b0:493:f826:89a6 with SMTP id
 5b1f17b1804b1-493f87806ddmr186711985e9.0.1784119867968; Wed, 15 Jul 2026
 05:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715030818.75657-1-min_halo@163.com>
In-Reply-To: <20260715030818.75657-1-min_halo@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 15 Jul 2026 18:20:55 +0530
X-Gm-Features: AUfX_myEAwkg-DK47-Nw8T398vurr_etEiC2Mn8n3DA4o5cqkrypTMsduIATEYE
Message-ID: <CAAhSdy1cSDB-8XbkjMzhZafvOwM=ghjcaoiGd3NXGxLnAUMzkw@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Fix Spectre-v1 in vector register access
To: Zongmin Zhou <min_halo@163.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 8:38=E2=80=AFAM Zongmin Zhou <min_halo@163.com> wro=
te:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> User-controlled register indices from the ONE_REG ioctl are used to
> index into the vector register buffer (v0..v31). Sanitize the calculated
> offset with array_index_nospec() to prevent speculative out-of-bounds
> access.
>
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_vector.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b..3708616e2c32 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> +#include <linux/nospec.h>
>  #include <linux/uaccess.h>
>  #include <asm/cpufeature.h>
>  #include <asm/kvm_isa.h>
> @@ -129,11 +130,20 @@ static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu=
 *vcpu,
>                         return -ENOENT;
>                 }
>         } else if (reg_num <=3D KVM_REG_RISCV_VECTOR_REG(31)) {
> +               unsigned long reg_offset;
> +
>                 if (reg_size !=3D vlenb)
>                         return -EINVAL;
>                 WARN_ON(!cntx->vector.datap);
> -               *reg_addr =3D cntx->vector.datap +
> -                           (reg_num - KVM_REG_RISCV_VECTOR_REG(0)) * vle=
nb;
> +               /*
> +                * The reg_num is derived from the userspace-provided ONE=
_REG
> +                * id. Sanitize it with array_index_nospec() to prevent
> +                * speculative out-of-bounds access to the vector registe=
r
> +                * buffer (32 vector registers: v0..v31).
> +                */
> +               reg_offset =3D array_index_nospec(
> +                               reg_num - KVM_REG_RISCV_VECTOR_REG(0), 32=
);
> +               *reg_addr =3D cntx->vector.datap + reg_offset * vlenb;
>         } else {
>                 return -ENOENT;
>         }
> --
> 2.34.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
