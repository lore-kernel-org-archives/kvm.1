Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CD3BED4F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033260; cv=pass; b=a+4hf45InCSSBNo0saMR4Ge5+YgAPpnqb5YSUXGTD8VAWfC+fw4I6eVskkZzJ9++E3HCOnwd9G63t5JH6sJXz/HdwQoH3FQ0Mex8uybgJUOyLi1Rf+WV1x2F5KKh04sbDvEEflFQfcVNHRaXkHZg7num1UYAUayLfPb5BlzIcY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033260; c=relaxed/simple;
	bh=RuqLXsxZPv3YMVww/mAtq9WhAoD2f2lB0hq1V0bjgJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWVO0G9/xEHsPrwuG6B2GMHJJ5nuUV0JwWFee5uJqmMAXtQpTLM9PPYLdRaxxp5cWKdWO0NZ2xjUTnGY91pcZ+8x0flWOmepvGQ3Kr9Rv59mGe5ZXvaan1Wb8Z0EWsBUsS2bcYEUNclgaJXL9izm6RhZiNd+zM3dHkdhRF53f2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=IzAx0gVw; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="IzAx0gVw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47df6a5202bso2582681f8f.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784033254; cv=none;
        d=google.com; s=arc-20260327;
        b=LZJwr1u5AcsyQTLRyltcBqQ3UCrsylipvqG8/ZCZjaw6+IyxEMUcv1aZQP6y7ss91m
         pR1RL7Hkl/NJwu0CxOPx59TM5wGkuY/TOb0ke3iL3eUIIZ6+YKwigqE8U6NRFvOIxGat
         Buov1wWqGBZaNSyx9vNDhBdxnenA4FZEsQcireEjkkHPripAIuZ0bzc6TFJxA65bIifh
         DNlVXltLjLhOjE3oYuRALnMcqNSGjGeXPg2HS5bSRoVYR9wNFQrq7U1intzY8Ac8Njnq
         2D5a8sm0jFv5/NXj1Y0LPHWt5WRuV+CJ1B2KE3sTkBxprdYEgqqwrXzW88AuFSPz1LW0
         ugrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        fh=k4TxOMlVoSDD2NjbGeT/sKGqOriEoZ6YRCAmpyVMTyg=;
        b=FXQvDxMsAuhybyBvMCMtRgTN06kaYxi8O+HwJzpjZqf7sMiEhYvVdZrpcArrASVVS4
         t5ripuEzniP4BgOAaanP7kGaDgYwDU18cvMgy/+sxl4+p+s3dxluYshu6cknhlsXn7Ir
         gLiqpUduvbkcbSWM0gaqBqWoNoLabgJhS6ShTOz3g9/qWcPgnSxI3Wzv5MqJvCpq/gT0
         Cf9vXoLhrE+vBwkzh7BQWKQNXVB4i4OMLUwf1RRH54dUObIlannDw/rdSJxQenCrDx2Z
         5uk3BMY+GtD2Y13ni/25/CaL1LTYp9iaIdTG+wVnwItvlFiZoU6pRbyl/IlodHiosyBF
         hn+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784033254; x=1784638054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        b=IzAx0gVwjmRAyNbVa3pxEsfWbEDQH8Avh0cwZ2qX+2BOglAM+cMB206vRlBTOrrH0e
         XhJ6PQDqTbufEtjSPOlctxLZ+smAv9/u0o60k1Q+gJFNUMr9jVypft70IxyKQ3r3FxSA
         cNnx5tCMeT0VMJRu0RAzvvnOzJnLzncxqJxqVtuZ0+qrVSRQPEfUtanZYU+QtWr4ERl/
         siTnurggfVKDHIdNgkd51kXki4n5iHD9nztg/ykjQ/d3mMTa/Dbell+NgEWNUJ89+xcf
         l4glHaVBuipx+AcrM0VzVexir8V7h67oW8gZl3JmGKGF5Ab4JW33wjf6s3u/uIUR4pDb
         FFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033254; x=1784638054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        b=RL+0WXNPjQsV/6s2oPqISmTIN/IJC45c4CX+27fblpfsJOqjtNYZstt9f6V4+qHmt3
         vt1CiiZpZPyQ9twr9X+KvFPupkCkDz+lW1NTiO4Wgduug8osPM1FKGPoa/B3UYbtYbQR
         QITmIze5rgE6pKzM5yUvnKqeHHIuNsOuLgrpFB5VgMmeJqRBjK802NdEk02w82Vrn8Wj
         QLGIrVkue4BQOSzwRyuKWGavFRN6oiBMZBfgtRSL5yXwUuysZYzrteOnG1GMdt5CSMgt
         vA51nQh9xtgc4oHnWyMG4Ad+maWy0cA59UyFeyv/bNe1f8KkvrJxZptXKJ+/pNWPk4kE
         gAPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUFQ6nVeIK6mFF+cW2REA/zmN87750jI3oO2k32cxYrFD1gxCTrUjE7YjMUXEiLeMxAJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gE/f6VN1rSZDxHcpixHcrxGZwdCQlYo0i+LcedhTQ+hg6AcC
	flRmTMlPZuC4wqGoGJLG8yaBzA8xt8/AiwhsNwLx/nMGTAQSxXshS5OVjzmrnMwhaKRPUlVVsXY
	E9lj6owdqykwiU7Zg3iilYuKVM4LnkU3G0KeC6Cldiw==
X-Gm-Gg: AfdE7cl7exqN2JkNNuJ3Pi+GjP1pGvSJoCXARr6x5SSmexR+Vw4Nz3v0JDWYNY9ju9e
	bX6yIi8yOTCxFLRSyWUeJtlc3rkP5akgPGZ1RsKLX24Xd4XrCgXdIweh+p6m+YXrxaEitYl3802
	10VWzUtgRLCt8J+gLXwa3fem/3GEpZ0ivW6sNC7amzaao6JiL/0FuwwDlGgTHBVY6EmjWquW8JN
	g52r1pTwaWOuaYI7j0GRQbw1M7j/CdMeAdoWir7EudamX4xs6u4N6VDaia2kW8Ff0lhFZ0/iJ0o
	xemorNPGQ4PnxIHFRwkC7lDhvPCjGyuYHPGpCSM4Df4E0Mb5pe0+NIQYzxerG0NMoRzSTuIM6OJ
	ouxkWUvgrXv+LMz0=
X-Received: by 2002:a05:600c:285:b0:495:8a1:7670 with SMTP id
 5b1f17b1804b1-495093a0d3amr26269855e9.35.1784033254027; Tue, 14 Jul 2026
 05:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com> <20260713073346.1293408-2-xb@ultrarisc.com>
In-Reply-To: <20260713073346.1293408-2-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 14 Jul 2026 18:17:18 +0530
X-Gm-Features: AUfX_mxbLiprqaTisutAbzYiymshMJFela08xtbT5r4jUbiVD4jCK0B3FsskWws
Message-ID: <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending state updates
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:04=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> RISC-V KVM tracks guest interrupt state with two bitmaps:
>
>   - irqs_pending: interrupts that should be visible to the guest
>   - irqs_pending_mask: interrupts whose pending state changed
>
> The current code updates those bitmaps with independent atomic bitops
> and assumes a multiple-producer, single-consumer protocol. That model
> does not actually hold.
>
> kvm_riscv_vcpu_sync_interrupts() is not a pure consumer. When the guest
> changes guest-visible HVIP state, sync_interrupts() writes both
> irqs_pending and irqs_pending_mask to reflect the new guest state back
> into KVM state. As a result, irqs_pending and irqs_pending_mask form a
> single logical state transition, but they are not updated atomically as
> a pair.
>
> This allows a race where a newly injected interrupt is lost. For
> example:
>
>   CPU0                              CPU1
>   ----                              ----
>   kvm_riscv_vcpu_set_interrupt(VS_SOFT)
>     set_bit(VS_SOFT, irqs_pending)
>                                     kvm_riscv_vcpu_sync_interrupts()
>                                       sees guest-cleared HVIP.VSSIP
>                                       sets irqs_pending_mask
>                                       clears irqs_pending

s/clears irqs_pending/clear_bit(IRQ_VS_SOFT, irqs_pending)

>     set_bit(VS_SOFT, irqs_pending_mask)
>     kvm_vcpu_kick()
>
> After that interleaving, a later flush can update HVIP without VSSIP
> even though a new virtual interrupt was injected. In practice, the
> guest can remain blocked in WFI with work pending.
>
> The same pending/mask protocol is shared by VS soft interrupts, PMU
> overflow delivery, and AIA high interrupt synchronization, so the race
> is not limited to one interrupt source.
>
> Fix this by serializing all updates to irqs_pending and
> irqs_pending_mask with a per-vCPU raw spinlock. This keeps the pending
> bit and the dirty mask as one state transition across:
>
>   - set/unset interrupt
>   - guest HVIP sync
>   - interrupt flush to guest CSR state
>   - vCPU reset
>   - AIA CSR writes that clear dirty state
>
> Use non-atomic bitmap operations while holding the lock. Hold the lock
> across the AIA sync, flush, and pending checks as well, so both bitmap
> words share the same serialization domain.
>
> This intentionally replaces the existing lockless protocol instead of
> trying to repair it with additional barriers. The problem is not memory
> ordering on a single field; it is that two separate bitmaps encode one
> shared state machine while both producers and sync paths can modify
> them. A per-vCPU raw spinlock keeps the fix small, local, and suitable
> for backporting.
>
> Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests=
 handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
> Changes in v4:
> - Split the AIA pending bitmap check from the IMSIC VS-file check.
> - Release irqs_pending_lock before the IMSIC check takes vsfile_lock,
>   avoiding sleep-in-atomic on PREEMPT_RT and an ABBA lock ordering cycle.
>
> Changes in v3:
> - Rebase onto Linux 7.2-rc3.
> - Use non-atomic bitmap operations under irqs_pending_lock.
> - Hold irqs_pending_lock across the AIA sync/flush helpers and add
>   lockdep assertions for their locking contract.
> - Protect kvm_riscv_vcpu_has_interrupts() with irqs_pending_lock.
>
> Changes in v2:
> - Expand the race description and user-visible failure mode.
>
>  arch/riscv/include/asm/kvm_aia.h  |  2 +
>  arch/riscv/include/asm/kvm_host.h | 10 ++---
>  arch/riscv/kvm/aia.c              | 45 +++++++++++++++-----
>  arch/riscv/kvm/vcpu.c             | 69 +++++++++++++++++++++----------
>  arch/riscv/kvm/vcpu_onereg.c      | 13 ++++--
>  5 files changed, 99 insertions(+), 40 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index c67ec5ac0a1..1fe146675e2 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -124,6 +124,8 @@ static inline void kvm_riscv_vcpu_aia_sync_interrupts=
(struct kvm_vcpu *vcpu)
>  {
>  }
>  #endif
> +bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
> +                                              u64 mask);
>  bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);

This split is looking very ugly and unmaintainable.

For now, let's not split kvm_riscv_vcpu_aia_has_interrupts() instead let
kvm_riscv_vcpu_aia_has_interrupts() explicity take irqs_pending_lock.

>
>  void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu);
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d..e2d5808169e 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -209,13 +209,13 @@ struct kvm_vcpu_arch {
>         /*
>          * VCPU interrupts
>          *
> -        * We have a lockless approach for tracking pending VCPU interrup=
ts
> -        * implemented using atomic bitops. The irqs_pending bitmap repre=
sent
> -        * pending interrupts whereas irqs_pending_mask represent bits ch=
anged
> -        * in irqs_pending. Our approach is modeled around multiple produ=
cer
> -        * and single consumer problem where the consumer is the VCPU its=
elf.
> +        * The irqs_pending bitmap represents pending interrupts whereas
> +        * irqs_pending_mask represents bits changed in irqs_pending. Upd=
ates
> +        * to these bitmaps are serialized so vcpu interrupt sync/flush c=
annot
> +        * drop a newly injected interrupt while syncing guest-visible HV=
IP.
>          */
>  #define KVM_RISCV_VCPU_NR_IRQS 64
> +       raw_spinlock_t irqs_pending_lock;
>         DECLARE_BITMAP(irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         DECLARE_BITMAP(irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce..001e83032f6 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -53,12 +53,15 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_v=
cpu *vcpu)
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long mask, val;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (!kvm_riscv_aia_available())
>                 return;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
> +       mask =3D vcpu->arch.irqs_pending_mask[1];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[1] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[1] & mask;
>
>                 csr->hviph &=3D ~mask;
>                 csr->hviph |=3D val;
> @@ -69,23 +72,35 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vc=
pu *vcpu)
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (kvm_riscv_aia_available())
>                 csr->vsieh =3D ncsr_read(CSR_VSIEH);
>  }
>  #endif
>
> -bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
> +bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
> +                                              u64 mask)
>  {
> -       unsigned long seip;
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
>
>         if (!kvm_riscv_aia_available())
>                 return false;
>
>  #ifdef CONFIG_32BIT
> -       if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
> +       if (vcpu->arch.irqs_pending[1] &
>             (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask)=
))
>                 return true;
>  #endif
> +       return false;
> +}
> +
> +bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
> +{
> +       unsigned long seip;
> +
> +       if (!kvm_riscv_aia_available())
> +               return false;
>
>         seip =3D vcpu->arch.guest_csr.vsie;
>         seip &=3D (unsigned long)mask;
> @@ -207,6 +222,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_aia_csr) / siz=
eof(unsigned long);
> +#ifdef CONFIG_32BIT
> +       unsigned long flags;
> +#endif
>
>         if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
>                 return -ENOENT;
> @@ -216,11 +234,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcp=
u,
>         reg_num =3D array_index_nospec(reg_num, regs_max);
>
>         if (kvm_riscv_aia_available()) {
> -               ((unsigned long *)csr)[reg_num] =3D val;
> -
>  #ifdef CONFIG_32BIT
> -               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -                       WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +                       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lo=
ck, flags);
> +                       ((unsigned long *)csr)[reg_num] =3D val;

The hvip in guest context is not under critical section so don't bring hvip=
h
under critical section.

> +                       vcpu->arch.irqs_pending_mask[1] =3D 0;
> +                       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pendi=
ng_lock,
> +                                                  flags);
> +               } else {
> +                       ((unsigned long *)csr)[reg_num] =3D val;
> +               }
> +#else
> +               ((unsigned long *)csr)[reg_num] =3D val;
>  #endif
>         }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e..99c929ec0ac 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -80,6 +80,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcp=
u *vcpu,
>
>  static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_res=
et)
>  {
> +       unsigned long flags;
>         bool loaded;
>
>         /**
> @@ -104,8 +105,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vc=
pu, bool kvm_sbi_reset)
>
>         kvm_riscv_vcpu_aia_reset(vcpu);
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS)=
;
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_riscv_vcpu_pmu_reset(vcpu);
>
> @@ -151,6 +154,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>
>         /* Setup VCPU hfence queue */
>         spin_lock_init(&vcpu->arch.hfence_lock);
> +       raw_spin_lock_init(&vcpu->arch.irqs_pending_lock);
>
>         spin_lock_init(&vcpu->arch.reset_state.lock);
>
> @@ -352,10 +356,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long mask, val;
> +       unsigned long flags;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       mask =3D vcpu->arch.irqs_pending_mask[0];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[0] & mask;
>
>                 csr->hvip &=3D ~mask;
>                 csr->hvip |=3D val;
> @@ -363,11 +370,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>
>         /* Flush AIA high interrupts */
>         kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>  }
>
>  void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>  {
>         unsigned long hvip;
> +       unsigned long flags;
>         struct kvm_vcpu_arch *v =3D &vcpu->arch;
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>
> @@ -376,27 +385,29 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu=
 *vcpu)
>
>         /* Sync-up HVIP.VSSIP bit changes does by Guest */
>         hvip =3D ncsr_read(CSR_HVIP);
> +       raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);

Add newline before and after raw_spin_lock_irqsave() to make it readable.

>         if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
>                 if (hvip & (1UL << IRQ_VS_SOFT)) {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               set_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __set_bit(IRQ_VS_SOFT, v->irqs_pending);
>                 } else {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               clear_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __clear_bit(IRQ_VS_SOFT, v->irqs_pending)=
;
>                 }
>         }
>
>         /* Sync up the HVIP.LCOFIP bit changes (only clear) by the guest =
*/
>         if ((csr->hvip ^ hvip) & (1UL << IRQ_PMU_OVF)) {
>                 if (!(hvip & (1UL << IRQ_PMU_OVF)) &&
> -                   !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
> -                       clear_bit(IRQ_PMU_OVF, v->irqs_pending);
> +                   !__test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask=
))
> +                       __clear_bit(IRQ_PMU_OVF, v->irqs_pending);
>         }
>
>         /* Sync-up AIA high interrupts */
>         kvm_riscv_vcpu_aia_sync_interrupts(vcpu);

Add newline here before raw_spin_unlock_irqrestore().

> +       raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
>
>         /* Sync-up timer CSRs */
>         kvm_riscv_vcpu_timer_sync(vcpu);
> @@ -404,6 +415,8 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *=
vcpu)
>
>  int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq=
)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, and external
>          * interrupts when irq is one of the local interrupts
> @@ -416,9 +429,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vc=
pu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       set_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __set_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_vcpu_kick(vcpu);
>
> @@ -427,6 +441,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcp=
u, unsigned int irq)
>
>  int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int i=
rq)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, counter overflow and ex=
ternal
>          * interrupts when irq is one of the local interrupts
> @@ -439,26 +455,37 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
*vcpu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       clear_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __clear_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         return 0;
>  }
>
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
> +       unsigned long flags;
>         unsigned long ie;
> +       bool ret;
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         ie =3D ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
>                 << VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
>         ie |=3D vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>                 (unsigned long)mask;
> -       if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
> -               return true;
> +       ret =3D vcpu->arch.irqs_pending[0] & ie;
> +
> +       /* Check AIA high pending bitmap while holding irqs_pending_lock =
*/
> +       if (!ret)
> +               ret =3D kvm_riscv_vcpu_aia_has_pending_interrupts(vcpu, m=
ask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
> -       /* Check AIA high interrupts */
> -       return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +       /* IMSIC interrupt check takes vsfile_lock, which can sleep on RT=
. */
> +       if (!ret)
> +               ret =3D kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +
> +       return ret;
>  }
>
>  void __kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c..cba3682944b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -298,6 +298,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_=
vcpu *vcpu,
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_csr) / sizeof(=
unsigned long);
> +       unsigned long flags;
>
>         if (reg_num >=3D regs_max)
>                 return -ENOENT;
> @@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kv=
m_vcpu *vcpu,
>                 reg_val <<=3D VSIP_TO_HVIP_SHIFT;
>         }
>
> -       ((unsigned long *)csr)[reg_num] =3D reg_val;
> -
> -       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -               WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +               raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flag=
s);
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;

Same comment as above.

> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,=
 flags);
> +       } else {
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;
> +       }
>
>         return 0;
>  }
> --
> 2.54.0
>

Regards,
Anup
