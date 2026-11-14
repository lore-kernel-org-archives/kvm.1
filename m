Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665334;
	b=k9lAKyFT1VQVYQBcKYemiTJPSAspy27fTKrxXSDkJ8DGsV84mTL9lxLEUBzRFkOhatBR
	 axR2x1FdJnNeyQmBFZ5hHk4oecJYH+ulorOK7L24PwslZwrSVIWiF82t2rU6eISz4cBkW
	 EjFBpr5a37Bh5xciJOOsIj6AMFdZmlQ87yjjctMF/aWMu0MSWnGoGRQDF+n/JxqJQJuv7
	 oSdrLXMjaRk/Mt/NTke/MpkQzdf3RZqbolzxDaCf3qsoOYHO2VXSazNhRwwAhqSmRU97y
	 2yaHPCYIWQejk+rf88eGYWggp3ahojfpKNYiKbLz6o49v81gV7TtuQIqbqhx0yZ5HvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fw4W/Vm3KORZ910M8MQlZ2qOgcGxqyG9xoAizUZfybs=;
	b=mMUrAEXG48Q8BcpdrTmpl4OJ/4ivvHwJt2iJ4wwggv65w4PIj97X083ItyXG43ZJ4Z5f
	 PFfzMF6koBJdyJ5r1dpbScoqWi7O2D8A0cEUmSNyQLjddTAyY9R68iGAQxi1R6dGp9h0s
	 f9RlUoTm3osW3kjtap79zqiVcL3qujokhGYSHksr049YK6ntyd9z0YjPeuUb1CFvjASzJ
	 ok1fvPq1nv5HzExcu1L/vLRZNCgHz6DI2I4ZZa9GCoieCbIFIk2KDfKp74bwvfReVA2E8
	 bdPaq6xZzOP1QokQaN69IvABo20MvZyzNp/jKzU3+tttLwGEBrRf8GyCXbOaq54lw7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLaVXgrw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F5606A330
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLaVXgrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742F51F000C4;
	Sat, 14 Nov 2026 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665333;
	bh=Fw4W/Vm3KORZ910M8MQlZ2qOgcGxqyG9xoAizUZfybs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLaVXgrw1R6saYh7h4wqqAreT+VowsYNFsWptIUj0qHrzXFHnrG35QFTFhjsN9JUZ
	 UGRRZX/CqjKht968j0UJnh/SYmZyXlZqLjMLzc6JMd/qaRaZfwjwdEKU8/1J4wEx8r
	 oEIfhDQ8kmfVcz1cxYENApWl8tOgd2GIAhROSuKqda0XCriT3U0MXBZGR7U9pAnQvP
	 NRjd3X0S8QwFi/NuOxRZ7HHuzGNjp6KE5Tjhr0kOdgQEtkDXqrajUiOA25fCHhtAhm
	 9zuC9OfNekwSjuBdIo+86AnKydcHBnByT6473RBefYZ3INNDzaB1xIva4uMufXVZcv
	 XIATOvL1dRXiw==
Message-ID: <sashiko-outbox-214611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw
 spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261114135056.202556-1-anup.patel@oss.qualcomm.com>
References: <20261114135056.202556-1-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:08:52 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: riscv: unordered MMIO write in
  kvm_riscv_vcpu_aia_imsic_inject()
- [High] KVM: riscv: race on IRQ_VS_EXT in
  kvm_riscv_vcpu_aia_imsic_inject()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] RISC-V: KVM: double-free in
  kvm_riscv_vcpu_aia_imsic_update() [1]
--

commit 7416cdfbe4d0521c182f4faca63b3ac6e4ae60b3
Author: Anup Patel <anup.patel@oss.qualcomm.com>

RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock

This commit converts imsic->vsfile_lock from rwlock_t to raw_spinlock_t,
removes vsfile_hgei_lock, moves imsic_swfile_extirq_update() outside
vsfile_lock, and switches kvm_riscv_vcpu_aia_imsic_inject() to
writel_relaxed().

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 302938972aa0e..0b9d15721d52f 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c

[ ... ]

> @@ -726,10 +715,10 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu=
 *vcpu)
>  		return 1;
> =20
>  	/* Read old IMSIC VS-file details */
> -	read_lock_irqsave(&imsic->vsfile_lock, flags);
> +	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
>  	old_vsfile_hgei =3D imsic->vsfile_hgei;
>  	old_vsfile_cpu =3D imsic->vsfile_cpu;
> -	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);

[Severity: Critical]
This problem wasn't introduced by this patch, but can [1] cause a
double free of old_vsfile_hgei when kvm_riscv_vcpu_aia_imsic_update()
races with kvm_riscv_vcpu_aia_imsic_release()?

kvm_riscv_vcpu_aia_imsic_update() caches old_vsfile_hgei and
old_vsfile_cpu under imsic->vsfile_lock and drops the lock before later
freeing the old HGEI slot:

CPU0                                  CPU1
kvm_riscv_vcpu_aia_imsic_update()     kvm_riscv_vcpu_aia_imsic_release()
  raw_spin_lock_irqsave(...)
  old_vsfile_hgei =3D imsic->vsfile_hgei;
  old_vsfile_cpu =3D imsic->vsfile_cpu;
  raw_spin_unlock_irqrestore(...)
                                        raw_spin_lock_irqsave(...)
                                        old_vsfile_hgei =3D imsic->vsfile_h=
gei;
                                        old_vsfile_cpu =3D imsic->vsfile_cp=
u;
                                        imsic->vsfile_cpu =3D -1;
                                        imsic->vsfile_hgei =3D -1;
                                        raw_spin_unlock_irqrestore(...)
                                        ...
                                        kvm_riscv_aia_free_hgei(...)
  ...
  if (old_vsfile_cpu >=3D 0) {
    ...
    kvm_riscv_aia_free_hgei(...)  <-- double free

If a concurrent CPU hotplug or vCPU reset runs
kvm_riscv_vcpu_aia_imsic_release() in that window, both paths free the
same HGEI slot.  If that slot was reallocated to another VM in between,
the second free corrupts cross-VM interrupt state.

[ ... ]

> @@ -970,17 +965,26 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu=
 *vcpu,
>  	if (imsic->nr_msis <=3D iid)
>  		return -EINVAL;
> =20
> -	read_lock_irqsave(&imsic->vsfile_lock, flags);
> +	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
> =20
>  	if (imsic->vsfile_cpu >=3D 0) {
> -		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> +		/*
> +		 * We can use writel_relaxed() over here because the
> +		 * raw_spin_unlock() below will do mmiowb_spin_unlock()
> +		 * which in-turn drains the write-buffer ensuring the
> +		 * write is visible to the CPU owning the IMSIC VS-file.
> +		 */
> +		writel_relaxed(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);

[Severity: High]
Does replacing writel() with writel_relaxed() leave the MMIO write to
imsic->vsfile_va unordered with raw_spin_unlock_irqrestore()?

mmiowb_spin_unlock() only emits mmiowb() when ms->mmiowb_pending is set:

include/asm-generic/mmiowb.h:mmiowb_spin_unlock() {
	struct mmiowb_state *ms =3D __mmiowb_state();

	if (unlikely(ms->mmiowb_pending)) {
		ms->mmiowb_pending =3D 0;
		mmiowb();
	}
}

On RISC-V, writel() calls __io_bw() and __io_aw() (which calls
mmiowb_set_pending()), whereas writel_relaxed() uses __io_rbw() and
__io_raw(), which are both no-ops.  Because writel_relaxed() never sets
ms->mmiowb_pending, raw_spin_unlock_irqrestore() does not emit mmiowb()
(RISCV_FENCE(o, w)).  If the vCPU concurrently migrates or releases its
VS-file in kvm_riscv_vcpu_aia_imsic_update() or
kvm_riscv_vcpu_aia_imsic_release(), the store to IMSIC_MMIO_SETIPNUM_LE
can arrive after imsic_vsfile_read() has cleared the old VS-file and
kvm_riscv_aia_free_hgei() has freed the slot, losing the guest interrupt
or delivering a spurious MSI to another vCPU.

>  	} else {
>  		eix =3D &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>  		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
> -		imsic_swfile_extirq_update(vcpu);
> +		swfile_update =3D true;
>  	}
> =20
> -	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +
> +	if (swfile_update)
> +		imsic_swfile_extirq_update(vcpu);

[Severity: High]
Can moving imsic_swfile_extirq_update() outside imsic->vsfile_lock race
with kvm_riscv_vcpu_aia_imsic_update() and leave IRQ_VS_EXT stuck pending?

imsic_swfile_read() clears imsic->swfile and unsets IRQ_VS_EXT without
taking swfile_extirq_lock, relying on vsfile_lock to serialize against
SW-file producers:

CPU0                                  CPU1
kvm_riscv_vcpu_aia_imsic_inject()     kvm_riscv_vcpu_aia_imsic_update()
  raw_spin_lock_irqsave(&vsfile_lock)
  /* vsfile_cpu < 0 */
  set_bit(..., eix->eip)
  swfile_update =3D true
  raw_spin_unlock_irqrestore(...)
  imsic_swfile_extirq_update()
    raw_spin_lock_irqsave(&extirq_lock)
    /* reads eidelivery && topei !=3D 0 */
                                        raw_spin_lock_irqsave(&vsfile_lock)
                                        imsic->vsfile_cpu =3D vcpu->cpu
                                        raw_spin_unlock_irqrestore(...)
                                        imsic_swfile_read(..., true, ...)
                                          memset(imsic->swfile, 0, ...)
                                          kvm_riscv_vcpu_unset_interrupt(
                                              vcpu, IRQ_VS_EXT)
    kvm_riscv_vcpu_set_interrupt(
        vcpu, IRQ_VS_EXT)  <-- re-asserts IRQ_VS_EXT

Once the vCPU is using a hardware VS-file (HSTATUS.VGEIN > 0), guest
accesses to CSR_VSTOPEI are handled by hardware without trapping, so
nothing clears IRQ_VS_EXT in CSR_HVIP and the guest vCPU is wedged in a
spurious external interrupt storm.

[1] https://sashiko.dev/#/bug/linux-0a58883c-0da3-49e7-847e-a71b508f0638

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114135056.2025=
56-1-anup.patel@oss.qualcomm.com?part=3D1
