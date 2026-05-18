Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83842494D8
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078702; cv=pass; b=mRKGXIgK1OaSbu69BhXb6rDu+dpj1ErNQ0upWvK1NtouTHk10rXH8UUB/LFBkm/4Ol9JoB58GlPCCZC93y7MGMHpTeJ51NHGelDAzAimKgORtcwHNxrjyGAwz8ymM7ITyIYrdcjkeaif2/PJfEagD2cTNg2DyEocSJhQsrDyey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078702; c=relaxed/simple;
	bh=9ciF2pCZn8Iae4mFy+/rt0+ZpiZ3r3c6YvbMMoAFlRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUgf1RxE3vAobXZ2HFUEiYxXVXV/h/olQjJEkMN5IA8FcUkq7m1Sgg+RuklXXioGdqeV5t7Amy1xNW+lNU5hDohzTeIMRYWdl4InRDV6jz51rkWSqJU/ic2Vkmsp3c2cfFH9uRZxYcJMUOY1zUFGQJ3oGU64UfgpDhWgYp58RTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=gwj7JBzB; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="gwj7JBzB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69498319ee7so846766eaf.1
        for <kvm@vger.kernel.org>; Sun, 17 May 2026 21:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779078700; cv=none;
        d=google.com; s=arc-20240605;
        b=VVn1MgLM+wXIqup6B5ZpusIeIlDX1dtIbsvt7ahKiO13Sv15/gHiVnsLPPdG6u6DbO
         Rh6wHaBhXp68hfJ5Ia9EboT/YaIufo2spt1UZeuzSLXAvPek2Lj8PPByl1yupYhZNZZb
         VX/4/cg6R2TOV9oTJfU96Vdwb2ktrHZ8nZEwLp4Xf8TSRwau4KYLhCq5NaIso+10LaiF
         P/dCzLwePNzSDYRqpKLz5YFuq1jIkj64rEv1vH4uFcsUDyf09wx/fFX3dbGMHXuxTlIC
         gz0GhCSKdFrokwBc/7RHqFFXXcR1Jta1wvu1ifV1VLZNMs78DR8shglPXSgp/NoxfLKC
         Fmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GJx3vYf89AmEPHzQLSho6/Q8/zMEPeXT+dUHRoNgkVk=;
        fh=fq0X6NRc83gK6N8Ks3ox46ZxZ7y09GaFplYkICV/DD0=;
        b=kuCoHtrlVkH+u4JpZa44/dMHh04JvFIrj/HoinkSv/tZYiPQIQpbvnneQugg3r1/AF
         CuCfEJpeUH7lCMYxT88iyuu/fvQB2aHYO+UfjPF9SE+zB+04amuA0dLMB6LmKG0gmHXy
         YmH1JodboAsotgELmdEkjYDUTdi9UaW7ZYo6PrQa05aRbpkDHtNk+5qkNEChXvkXb6VF
         wdG2dSUfYdeeI8G5IeYsOagLVTQBr7VW3KAyG2IUc3qzUj62qXxHopxJonNz0r6ndELd
         tErMOwaY2neMtWdIWeLCl5K3UptBMyZgp+Sd35TV2io77iH2g8nNii8PgeISOKaaqbxg
         Cl9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779078700; x=1779683500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJx3vYf89AmEPHzQLSho6/Q8/zMEPeXT+dUHRoNgkVk=;
        b=gwj7JBzBwb2qhErufEk9dgI3YiITNrHEk6LfhDZxEt4pi3QJSaKfHoR4TLfT55wSQa
         VZQ+xECsm7I4seO5Hy1DD9GTRB9XQfPwWctcv1EW3Z87uQTDoO25sBU0qUD6emLFsD5k
         WU0dpdinK0xnz6RB7dfq/471wR1RC+aOd+Z5WlLev8hRa/5LWLhqKVGq3lIlBo3TzV7o
         Aocr/t36lH7MYQ6mchHUwASuPwWUbdVUKzWxYUIerljjdG/ctaI6S5AKP/A+NnBRZ0wx
         2z0mzPBWEklehSoUd4h3MJs+2vUCMet2IyYIorIlI1JzwHft29A+lJQJRF6BKOIF4yf7
         dvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078700; x=1779683500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GJx3vYf89AmEPHzQLSho6/Q8/zMEPeXT+dUHRoNgkVk=;
        b=GUVgyLM++kjt00XV5FMdnSg7rFSAjcke1BIFOIerxyQgN5ofucQRZDjpEglSfUwB+2
         u1fhkzQi+HUyKCtjNou8rkcsT4oMOhQ03/JZCombTttlhno7d2yACZVaGy60XBAfcBJ4
         WdmnVz4wIzWUIknDkio6ytKDY6q7dz8/QtLzAwFYdebuBAiEXpRT5r3VaqHK4ejEKq2N
         ruaqwMhTe9e5xKCW37yuFZvHraAfJ+tJWQRVXfPe8QGLXwwnWzNrfCFLbzF8t9xfLEJ+
         D9WBNEgi+oa8wlPg/r0AW7gaJ/bI4aB27NFwbYSdtyJ/dNI1JG4x4sf+SxPQyjnp+4Bh
         WeWw==
X-Forwarded-Encrypted: i=1; AFNElJ+AurV9YjsdhzmyoJLZiOnoRvmkg7LFQyuK+ZNLe8bke3ON30yMF9nTlCDso9na0A0YlQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdXP/DMBIqK98pgKYfqXtuhW7ElEcSJuQTH/nvFrk0DJQGrzL
	jLq1/Dq2o2yuevrQ0mNTuQbeaTeUx/CzK6CDQN5q3ZJ3vkoKkLPZq5eLt5n3bG+UtPlldCd+p16
	tHiDQOkJvfUSSLxXgCVaWmnpLZZPkMoW+QcMqmi679w==
X-Gm-Gg: Acq92OEZcgVFl7IgjxEh8Tgo21aXu2SJocvznLqpecQ8UqoS0WKnPl49m8csyfLZruf
	7lx3ISoWDVU+/7x3LnbQaJxyVKoZFx0taUvBGtpxNKGb9VkbLgrSKMX/3KJLHMuX20VmsgwLRlr
	xf6KJTFWpjVUQ7dFUEowSweG1/yXlk+pkporbjbEVv6RI6y/acI/ckGYd75C2NGq80BP10SPIn/
	UmiC6DqhMqnxS9y9BoWFeLBygiB03QsE97iTda9CVIvfDQW1MsnYfHLYY0xRGXuZSEE1fANiP9c
	OVZgsje8Ye4TNJ/oXqzFc6zAnDg21NkLKCNzemGix8lZq/HiuWg+kGdfUpUkc9Cdmwx1pH+fBLw
	DUcvCtzP0uwtocQCrHBMxWNz5Vw==
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69b884ac83amr8443261eaf.33.1779078699723; Sun, 17 May 2026
 21:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514081752.472987-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260514081752.472987-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 18 May 2026 10:01:28 +0530
X-Gm-Features: AVHnY4KrYwepB5OiXTY2dv7ZHi-ani2vKZrt4RfWbnSXlOx_ga651Ne910vtQ3U
Message-ID: <CAAhSdy2z_2OUyzA_MK+V6z_5ucwKN6A6f4j6hNaVH7c904SBQw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix sign extension for MMIO loads
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:47=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> The kvm_riscv_vcpu_mmio_return() function handles MMIO read results
> by writing the data back to the guest register. For signed load
> instructions (LB, LH, LW on RV64), the value needs sign-extension
> from a smaller integer to unsigned long.
>
> The current code uses:
>     (ulong)data << shift >> shift
> but (ulong) makes the right shift a logical shift (zero-extend)
> rather than an arithmetic shift (sign-extend), causing incorrect
> results when the MMIO device returns a negative value. For example,
> LB reading 0x80 would return 128 instead of -128.
>
> Fix this by casting to (long) after the left shift so that the
> subsequent right shift is arithmetic and correctly propagates
> the sign bit:
>     (long)((ulong)data << shift) >> shift
>
> Additionally, remove the unnecessary shift assignment for LBU
> (unsigned byte load) since it does not need sign extension.
> This makes LBU consistent with LHU and LWU which already keep
> shift =3D 0.
>
> Fixes: b91f0e4cb8a3 ("RISC-V: KVM: Factor-out instruction emulation into =
separate sources")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: OpenClaw:DeepSeek-V3.2

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.1-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_insn.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 4d89b94128aea..f09f9251d1f0a 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -415,7 +415,6 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>                 shift =3D 8 * (sizeof(ulong) - len);
>         } else if ((insn & INSN_MASK_LBU) =3D=3D INSN_MATCH_LBU) {
>                 len =3D 1;
> -               shift =3D 8 * (sizeof(ulong) - len);
>  #ifdef CONFIG_64BIT
>         } else if ((insn & INSN_MASK_LD) =3D=3D INSN_MATCH_LD) {
>                 len =3D 8;
> @@ -649,22 +648,22 @@ int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcp=
u, struct kvm_run *run)
>         case 1:
>                 data8 =3D *((u8 *)run->mmio.data);
>                 SET_RD(insn, &vcpu->arch.guest_context,
> -                       (ulong)data8 << shift >> shift);
> +                       (long)((ulong)data8 << shift) >> shift);
>                 break;
>         case 2:
>                 data16 =3D *((u16 *)run->mmio.data);
>                 SET_RD(insn, &vcpu->arch.guest_context,
> -                       (ulong)data16 << shift >> shift);
> +                       (long)((ulong)data16 << shift) >> shift);
>                 break;
>         case 4:
>                 data32 =3D *((u32 *)run->mmio.data);
>                 SET_RD(insn, &vcpu->arch.guest_context,
> -                       (ulong)data32 << shift >> shift);
> +                       (long)((ulong)data32 << shift) >> shift);
>                 break;
>         case 8:
>                 data64 =3D *((u64 *)run->mmio.data);
>                 SET_RD(insn, &vcpu->arch.guest_context,
> -                       (ulong)data64 << shift >> shift);
> +                       (long)((ulong)data64 << shift) >> shift);
>                 break;
>         default:
>                 return -EOPNOTSUPP;
> --
> 2.34.1
>
