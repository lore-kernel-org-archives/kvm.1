Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7538B150
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302535; cv=pass; b=iC3yN1shy2y5uhcT9XEKC7hjlY1Iu50/VNlNaMLSWVfrnaiavsVNFn8MAxQGh+YRaA1T72ZCBYP4q6FNvU6vD2u8UYERj1AYLlkW8h8nS7oFD1QetSfOfWGGXWKhmwJB/OgNLqFWhgYuBgTeUfNIvILS3D1g0rfiWJyjvnik4xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302535; c=relaxed/simple;
	bh=E0ZjGiqEou/mVVQhcRU5NDJl4927/rLFUpJnSc5CMI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCSh3iD5/IfZR4RZJ2QxC5W3jvhGXOtiVDd/Rx+IcqPlaSmxGl8jKkwwb816k6oxendjDfgKiN+BxY0xYMa/hcGRc1Pg6kdHuq5nG9bsR2GuvMw3qVG0MLEW83kQ8lsLF/NWFAd6yHz/tj4uV7h5O4prP4D22dz4+oPA1hQpg8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=IaxhaWRn; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="IaxhaWRn"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d862236ddso4912851eaf.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302531; cv=none;
        d=google.com; s=arc-20240605;
        b=bZoxE62NR9vSPdh655lVG8hVm5hVHkZrqo0Yx5jDEZXA1ItQ53AC6gkwbPAXzEPGkC
         m9mZjZcwZwVfcREz9mAH32ulx3j5V79ZiGh0L6O6V9P7IVicEhNjA5GfaLT/ue92mjX2
         Fi8AACwrO+Gj8Xu1WHOzW1W6ZSysmH7U8uVmUo7qwsEP9YVfvIUawtY4HKTplQlQS/7i
         JG925zO9YME9JnXkG2V8rM1pwUsB1soiHhI4zCGSBQHuhRP8USbCBGwSPB1rZBP9fw0m
         xX1pClQSd8McXIYyd7YYuVTOIgSkX+frIAdUwD2AD3LR/pRZ1CpUXC/6kxS5HtbAiExC
         pLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        fh=p/So+4AwR0XwHezAlczBqElhdiqHu4Xui5ki6p9gOG8=;
        b=H21oYJtcyldfAOumMDI6Z1KcafZZghk3eFfE0SCN9AscNvf9tVX8U6KKexIiJbDWL2
         Ibl8ek0KyYAEzkgN/wy879jaSahlUDfpuK6CcmWcS8df551uyw9oJaz/EwTHBRisSIqE
         xKZNehAsLw6XI4kVgvoCu/z0Uf+tkypdPSmES2Vik/3uqQrSRSRqkgZ8MCfoBJIeJf6S
         lNLP8CfTh6lTXYfEZPbXOtuqkL6YQqYKJmzlMHqdo+vSefnv5K8l2RFGHOX+mFHuafm0
         D7hNX/HZzHRxRRa2VK+a1ZLl2DxfVHL6s5i7K3Fz2JnBSilotXEXeRc80Sj3y8chW+Mx
         f/Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780302531; x=1780907331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        b=IaxhaWRnVjuCasJ0/RGFB2WTozmapeE+8mUurFWRYMQYPn5vkQIUA5wk8GtMw62LIW
         G1ug/daRnR2+H2Rt7ozO9jAMDDtkrQd7XhNHP6nujdL8fVFClFJuGudg9ormh9mQZTO6
         c4sC7I+V1kd9Sgl7BN1lkmLFjCnYWI6ds9aATDGyDBfguEpIU08et1j6f8uX2h0WGzcG
         wfg5ujcRslVtPLu8o19NRV3r5/fwMuuRESQWTEGV8w0FzVzgf1VZsdBrb0nF1B0HotJ6
         IV703nAtZQpVYaOC4xPiGyDl1POR6Gc+6RFiwNPAguJESFV3NzNKLItIE+P8iivD/gO+
         TWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302531; x=1780907331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ESq39BgNzEi4Yu/c7RvuT+HDwB/a0FKWuDwlbw5nEw=;
        b=RcGhMOEHZ/0xdcKkG3hDUqUMzgYbw7L5nf31Y8HkKpJljjw1k5vL5lFDac2c3DrRIk
         UilEOLZZcY67BdMOWS37OHI/QsQnluE7F6en9XZLtiIbEjU3MHFRPzNQ5UdFbpZVRdjf
         0JHRTLyKhVTW+M++h2WIUcd5rC+/IvmkIihP20xYMzme9uRycGWfzbmdtj6i7QhQ3xK3
         1zaPQvy/ekdpPbMtSiMdNKhkFL0ULrgB+LH5tAgyCVNlM0UE1/9iRCX90WRyMTouInUz
         Xxwk4cuqfJsLGdK/mdlWLiZC1F0z8MGItqVOJDYYu7UE+++a/t99k/yTmklepfxmCMKZ
         0l2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8npuJMzbJ6TrHcZfswL6ov5K7im6NI7UOtIA+nksT2Zf9kL9dx1Sm0fMeJjHA8WPQIY7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnDGj9qgIqwilQyPM/+05nQ66rAc5g2fCimsTyq0vwRXWIp0F
	H0jTMLVgNSx2ktekFG51kZhN3heK+lVDdP0WT57AAc4UaQUK2WPU95OZH7/otkm2ZPinOdFRAtB
	3SefnDw5vtBKhPRD4X2C39jMx6j01vb3flGq5tzEvkA==
X-Gm-Gg: Acq92OGzRl2ti0rM3Pj1XHBWQMqMwFRk2aQKpR9GGUCNbU+y1sOEd12WXDGxH9beR/j
	tfztrqGnlXIgFmHqtCwOzeumKQJZ2cPMP8N1eRokQmp2XR+Qbg+cl/Kl6HE4Kbh8DNSGZ/74Q7X
	UD6Ozug4RtEqPzOAiYbBqoowJw4mxduY5BtQVshEWLDY9D7CPIRttoLma8RnXyCGGgYviZpbqHn
	0+z/GtnBr8wnvoszygu1FvUQ2XmurYP6hhTZhTZviEHLkTyDGC3mwRjaOsUPsrgiIKDJcVw0xsC
	t9d1P9Xk08DCAWR64ocecgEX4jyIV7KPvPzUzgurzoZlyX9kvW/nCwtRJZ8WgN0pngz2VEutC6e
	PHDmR1y684qjiz7EPmSx5ofnuOQ0ad1RuG6aXMg==
X-Received: by 2002:a05:6820:6ac2:b0:69d:79ff:d3b4 with SMTP id
 006d021491bc7-69e10403a78mr4828258eaf.7.1780302530944; Mon, 01 Jun 2026
 01:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511032144.361520-1-rosenp@gmail.com>
In-Reply-To: <20260511032144.361520-1-rosenp@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 13:58:38 +0530
X-Gm-Features: AVHnY4IF73bShScS20qflmRSB7AeBeAPcEqSmcKeX3spZ09pNG9KxLbJgNe5j3s
Message-ID: <CAAhSdy34CXr4cky4cpg6eVV3FdwHvnR=pJqK=Y+ZsLLx0jL1_g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use flexible array for APLIC IRQ state
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm@vger.kernel.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:52=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Store the per-source APLIC IRQ state in the APLIC allocation instead
> of allocating it separately.
>
> This ties the IRQ state lifetime directly to the APLIC state, removes a
> separate allocation failure path, and lets __counted_by() describe the
> array bounds.
>
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup


> ---
>  arch/riscv/kvm/aia_aplic.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index 3464f3351df7..748107c347d9 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -35,7 +35,7 @@ struct aplic {
>
>         u32 nr_irqs;
>         u32 nr_words;
> -       struct aplic_irq *irqs;
> +       struct aplic_irq irqs[] __counted_by(nr_irqs);
>  };
>
>  static u32 aplic_read_sourcecfg(struct aplic *aplic, u32 irq)
> @@ -581,7 +581,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>                 return 0;
>
>         /* Allocate APLIC global state */
> -       aplic =3D kzalloc_obj(*aplic);
> +       aplic =3D kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1=
);
>         if (!aplic)
>                 return -ENOMEM;
>         kvm->arch.aia.aplic_state =3D aplic;
> @@ -589,11 +589,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>         /* Setup APLIC IRQs */
>         aplic->nr_irqs =3D kvm->arch.aia.nr_sources + 1;
>         aplic->nr_words =3D DIV_ROUND_UP(aplic->nr_irqs, 32);
> -       aplic->irqs =3D kzalloc_objs(*aplic->irqs, aplic->nr_irqs);
> -       if (!aplic->irqs) {
> -               ret =3D -ENOMEM;
> -               goto fail_free_aplic;
> -       }
>         for (i =3D 0; i < aplic->nr_irqs; i++)
>                 raw_spin_lock_init(&aplic->irqs[i].lock);
>
> @@ -606,7 +601,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>                                       &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
>         if (ret)
> -               goto fail_free_aplic_irqs;
> +               goto fail_free_aplic;
>
>         /* Setup default IRQ routing */
>         ret =3D kvm_riscv_setup_default_irq_routing(kvm, aplic->nr_irqs);
> @@ -619,8 +614,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>         mutex_lock(&kvm->slots_lock);
>         kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
> -fail_free_aplic_irqs:
> -       kfree(aplic->irqs);
>  fail_free_aplic:
>         kvm->arch.aia.aplic_state =3D NULL;
>         kfree(aplic);
> @@ -638,8 +631,6 @@ void kvm_riscv_aia_aplic_cleanup(struct kvm *kvm)
>         kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
>         mutex_unlock(&kvm->slots_lock);
>
> -       kfree(aplic->irqs);
> -
>         kvm->arch.aia.aplic_state =3D NULL;
>         kfree(aplic);
>  }
> --
> 2.54.0
>
