Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519103ED100
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617392; cv=pass; b=K4Gv9jYH+Iet7YcMrPNycG4byh9eXEjfTQ36uOtvzaF7u1jglIi+kjbkMmzEaWpbiAiFiE77cHadxhh/0LMzw+Q1DxJSwKuJ24Io+oxZlAar+tfVbCgKRgNaxIVSamwkOHYj3wDEXWqzPjqkb4twNHhG6oM1h9FoU8YnuZKt2Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617392; c=relaxed/simple;
	bh=0npK+LpLA6BChEex8bv3MvWeonr79UU+n6b4CahqHrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKg+VsEh2Oe9gvLt/yoImSOmhAirsNopqcLmw/Z5jaLtICTRykNyhMZQAPrMs+VEj3sJhXNPoEa04ptXznik5IwCNFVQEq38k3jYc5HOpRqmon1EPIqJqaYIskUkm3JQ6lDOOE7U34qp0nM2DpROR6cmB8ou74JwSSYS2yAD0Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2KSR4irP; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2KSR4irP"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4671cbce32bso560954b6e.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 06:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774617389; cv=none;
        d=google.com; s=arc-20240605;
        b=ep2AOjBZ0VowghtBfmJMPOWLN70c6Fmkxkhs/e5u7diWgBEqkrHNCtXeiQ7q+B/cvX
         /pvWAL4Nm8G2xJ5SsrunGAUDj4lfD2JV9k3zJxlULYr95Qnb0ciVS+osm2dtP6F0RIZD
         xBu39GCXDpJ2oZMWxYyGkdw3Jp5ZHVEyvzeItNvcCoscFkE+ggd7YeAiwAIpN/WulY4p
         6uM2DVsFNUDyf6SlwtVUv4Z6tDI2Dgv+zMby3A509a7Szfdm/B9PgzHGuuwQXDpO8Zha
         BEWcF3sPmd18nmcvHu/Djd2YbL/bjgrR2LK4A0w8ZVbibxoWlY1rOkLu494+3Joy6q6V
         kCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        fh=EjCWf22/Esh7NV0R0woU35VIolG2++bDQO2QJjtgzVg=;
        b=GazT0aBKfBLQDaCPWoDoVpBVue/pCmPfMDzNYYHjSDXwH1k/esifJ+FhV+sW2uGxKS
         E8oL6dcan+9Y3mBQYiHIh9hP/BpYSIccAIS0upwi06/QI3yiRRuvQUa2/JwFxePJBqtX
         MNL+czfm7ECfvulIUwyP6NKZBMBAHuyDQbOUuYqkqdS/LPSxvPgulAu0tD1c6B/D0NN4
         Jp9Di7nhJPTj1gs4Ga44NgEpWqjv9IVj+3dOh8Try4emOxDUvY5ebqceQ+v5Di9UPzyO
         cLwnID8qljldVm66oZF6ke9BTVXAgerP4fjs7ix86C0K0TZEoz7gSoINZk0t00xXYrC6
         EdAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774617389; x=1775222189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        b=2KSR4irPaxiQvIUfp42MQ5CEh/D/U6dAF5yrTV0Ix1lnCREHf138HtRDRT6v/PZ9bl
         AL0MWeyvWSajt7TxPxEO5YIiOC/m1KVatbYeDnQ9CHwwUkYzg+ykAu6v8B0qoKJAswq6
         JYuDNPssNZaq1ikzArHjwIcguSplps9nMNvXxajg3MPb6T5k1nESlQXrx8Y5LeVUeUJF
         WUw33E6tBiWMHcUCzhacVLGSAU4HSZ68VmUsc8DPVV2d+jYClrOx03yS4C16yTzosAEX
         wq6F9qt3XlVnwS4g6musHjvNX1o6rKFClzkFX7VW0s+9IruBSWJk7u25O7su1s9ruqjX
         QUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617389; x=1775222189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        b=oGmFUlmRN+w6NC9tQORY5UNVX/3dXzaOfEy+/LZoA8Ya4HoELSBS4SsVNiOX/H/Zef
         VjHQXUr0Xaj3g17JOfWdyadYkP2MFSVLClG7HFCiTaghjQx/BkGsxWxuHyFPDjapCnVm
         7TZl3E347RxyoxOdCnkvVdSOwYvbhVJlYho0ZwwYt0NY4cQWjGqX1ap4YuAiVRjr6Fal
         OptQEn6A6ZzbPPhuL0MvRhM5u0PdSV3SL/OJ9TAEEDwKmYCF8NOg2ncH11Rk/SJ1vzSc
         djWPrrdpWpmjexKLf2VtSMCbGIZMMUSwVXuobYTvDSk7rzr1mRwPXlwMqtjR8HkKRMNx
         g8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9iAFMix2pb0X7UUnqcMY52vMK9h+B3QrD4Q45zW4e8sWsjdb7H0VvC4bEurxkUSdz8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjD5CEFmme12CjqMPUlffXzWhuzcL7w/IT3ud8aOvsza09ljQ
	JAhxIXescu8RU2ae8gK08PQFjtQrc+pokE4hzhSJLZ13gDJbTMq2eIiuHJuW6BS6+mF4gRD6JD2
	zS8mnd6o+0tPActPgdjSeRhD9oMvP8BwzNkA6TVqFAg==
X-Gm-Gg: ATEYQzxGJ2x3YgQRVh2ya+7CCSpuC0qVKSqxG05i4Xt360liXG7soR7uwR+93T9gqzm
	TJ4kmFuhKkhG2tefe8ZyG1h5qJHa4GnpEvyCbDsnPzKWdq6j1SzWxLlf3sMWgW51S3Do0fRVktk
	a8zOPuXHGqSKT04HLnImbgc+CuwveHdi9NLzrIbG7P18bQf0x5lRp0J6BSK9pUIHUzgJ00GrFzd
	ZYtEo/ySg3z1mSInzxvWsB/Dv/QcaAuQUQyicFZuqgzrO0e5u3JNXpqJwPFdzRkxZvDo7BV3ZK0
	TkSnucbfarm0P2ZoVMuxA/8gaWJhpS/0LqyPvyLITofWlutvhliBdqofRojQTDQEgczMAwL4oCw
	XfqPtKt9gdsl5rry8tZgbRPceRA==
X-Received: by 2002:a05:6808:4f29:b0:467:32c1:acf1 with SMTP id
 5614622812f47-46a8a574768mr975177b6e.39.1774617389039; Fri, 27 Mar 2026
 06:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316151612.13305-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260316151612.13305-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 18:46:17 +0530
X-Gm-Features: AQROBzAiBWQwzRrAsNPun8GkheFgn7uHFWTVjZzHMuhgO-eFGjXm39iFGnN1dNM
Message-ID: <CAAhSdy1c=Bvso+ZCy_6a_1Bh8sznGDs9wErPQdqGWepgq8nQsg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: fix vector context allocation leak
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vincent Chen <vincent.chen@sifive.com>, Andy Chiu <andybnac@gmail.com>, 
	Greentime Hu <greentime.hu@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 8:46=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> When the second kzalloc (host_context.vector.datap) fails in
> kvm_riscv_vcpu_alloc_vector_context, the first allocation
> (guest_context.vector.datap) is leaked. Free it before returning.
>
> Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Queued this patch for Linux-7.1

Thanks,
Anup

> ---
> v2:
> - Add Fixes: tag
> - Add Cc: stable@vger.kernel.org
> ---
>  arch/riscv/kvm/vcpu_vector.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 05f3cc2d8e31..5b6ad82d47be 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcp=
u *vcpu)
>                 return -ENOMEM;
>
>         vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
> +               vcpu->arch.guest_context.vector.datap =3D NULL;
>                 return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>
