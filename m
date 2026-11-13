Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566079;
	b=mn1zYC1aO12U4GHzm4biy9YY9P05k713/O/KLTb79MWcdInc9kntsHccNHq+ehKN62/I
	 OOv577gBSY9UNA2YMltF8m9wrHVzSfKKJ39Vgtir4GAx7dvkm1Eo9HC3J2prnIy8qLd70
	 sdefBUeCmb3hlIXzpN7eW2935MIBIG3QSCpMzvftRKcFw9cNw7k+uoJPHonJLHihVrhmi
	 pHcKt1NMyJbUcpgajffZigygxi8YUmP6E1CJIlaDk+gQJY2uqKdZkgc48OUms1LPkrIEq
	 Bur8IcM3l2Q8M3ajai8i5WYMYl0YExrKlwnqn8h5C22ArkPtgmcbDvMZCwc9IoFlsCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oZbILVbIb3V8jih6VUtTSUOM/NNXMtINb6II4bj3FUI=;
	b=AMOuYwcafkbwefNujE3aohxWUszE6y+6zMNQ36sqXPtrkt8tg0MSjRsto7lhWTOS/OnX
	 yHMolySzYRDxzQ/aKCWOtuQERrSSJZVD430FpV4t1jhwr6ZC4K6Pis6uYnxyZDrwXLd/6
	 8F/Ct2HxLhVeQc/2wi3BEe6uQnTi/5fEaWB5Bz762TkiqwGyxv1ehFlyp15wk4zrybs7Z
	 5iScQqugzdtz+A8UbRghBUdi7Kege6bujROOwpWbujY5SpR3Ctdz5d2tXGIXiHMoaVG/t
	 QBR5UrL74i0oUkcmDexFNvPDQ5QHvWoyUcNClHs7Tg59Z8ECzeKb/Mim/l8EyYpF1RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFodNFEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D820606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFodNFEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31A1F000C6;
	Fri, 13 Nov 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566078;
	bh=oZbILVbIb3V8jih6VUtTSUOM/NNXMtINb6II4bj3FUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFodNFEsT5if1shClQyoNFBQN5Qq8UiB/vqXqQhjLJltoBhB1nsssQysGjz1Rjc06
	 snDAY4HZmdAEDpkMZySbENvGkaJ6FPRv3RpdHaTAqBJ+dGD3rrhsNz9aSHQv26/Ii8
	 FVNgJ3IshtbxpVJhjOS+oXEU9SawiO98rrCfcrIZ9J1B/FlqwFEqC0pxeF6PDmLp6m
	 2zg+xur2p5RPUsb4YTuuNBAw4HaQP6BgAApcej2q0BF/AmBNTer23B+d9Avscebobe
	 yOj0F13n+uLnUsqsAB1a2g4esxb9k2VgfDcOxR6298DZqDkD+zmLIDJ5zlTpoZLg73
	 XIkZ3DVRj6w5w==
Message-ID: <sashiko-outbox-212624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI
 read-and-clear operation
Reply-To: sashiko-reviews@lists.linux.dev
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113101358.3007601-1-xiangwencheng@lanxincomputing.com>
References: <20261113101358.3007601-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:34:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] RISC-V: KVM: stale topei passed to
  __imsic_swfile_extirq_update()
- [High] RISC-V: KVM: imsic->swfile dereferenced before !imsic check in
  inject
- [Low] RISC-V: KVM: missing Fixes trailer on IMSIC TOPEI serialization
  fix
--

commit 322bd38f6016b31c1cdf5b875effdce4436f4b2f
Author: BillXiang <xiangwencheng@lanxincomputing.com>

> RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear opera=
tion
>
> The TOPEI read-and-clear must be atomic with respect to
> interrupt injection (set_bit in EIP). Otherwise an
> interrupt injected between the topei read and the
> clear_bit could be silently dropped.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>

[Severity: Low]
Since this fixes a race in the IMSIC software file TOPEI handling, should
it include:

  Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 302938972aa0e..f4cc1691e0478 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -526,26 +526,25 @@ static void imsic_vsfile_cleanup(struct imsic *imsi=
c)
>  		kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
>  }
> =20
> -static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
> +static void __imsic_swfile_extirq_update(struct kvm_vcpu *vcpu, u32 tope=
i)
>  {
>  	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>  	struct imsic_mrif *mrif =3D imsic->swfile;
> -	unsigned long flags;
> -
> -	/*
> -	 * The critical section is necessary during external interrupt
> -	 * updates to avoid the risk of losing interrupts due to potential
> -	 * interruptions between reading topei and updating pending status.
> -	 */
> -
> -	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> =20
> -	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
> -	    imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
> +	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) && topei)
>  		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
>  	else
>  		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
> +}
> +
> +static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
> +{
> +	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> +	struct imsic_mrif *mrif =3D imsic->swfile;
> +	unsigned long flags;
> =20
> +	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> +	__imsic_swfile_extirq_update(vcpu, imsic_mrif_topei(mrif, imsic->nr_eix=
, imsic->nr_msis));
>  	raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
>  }
> =20
> @@ -830,12 +829,15 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
cpu, unsigned long isel,
>  	struct imsic_mrif_eix *eix;
>  	int r, rc =3D KVM_INSN_CONTINUE_NEXT_SEPC;
>  	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> +	unsigned long flags;
> =20
>  	/* If IMSIC vCPU state not initialized then forward to user space */
>  	if (!imsic)
>  		return KVM_INSN_EXIT_TO_USER_SPACE;
> =20
>  	if (isel =3D=3D KVM_RISCV_AIA_IMSIC_TOPEI) {
> +		raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> +
>  		/* Read pending and enabled interrupt with highest priority */
>  		topei =3D imsic_mrif_topei(imsic->swfile, imsic->nr_eix,
>  					 imsic->nr_msis);
> @@ -852,16 +854,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
cpu, unsigned long isel,
>  					  eix->eip);
>  			}
>  		}
> +		if (wr_mask)
> +			__imsic_swfile_extirq_update(vcpu, topei);

[Severity: High]
Does this pass the pre-clear interrupt ID in topei to
__imsic_swfile_extirq_update() instead of re-reading imsic_mrif_topei()
after clear_bit()?

When a guest claims the last pending interrupt in imsic->swfile via a
TOPEI write, topei still holds the non-zero ID that was just cleared from
eix->eip.  __imsic_swfile_extirq_update() then calls
kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT) instead of unsetting
IRQ_VS_EXT, leaving IRQ_VS_EXT asserted and causing spurious guest
external interrupt traps.

[ ... ]

> @@ -959,6 +965,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *=
vcpu,
>  	unsigned long flags;
>  	struct imsic_mrif_eix *eix;
>  	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> +	struct imsic_mrif *mrif =3D imsic->swfile;
> =20
>  	/* We only emulate one IMSIC MMIO page for each Guest VCPU */
>  	if (!imsic || !iid || guest_index ||

[Severity: High]
Does imsic->swfile dereference a NULL imsic pointer before the !imsic
check below?  If a vCPU is created after aia_init(), its imsic_state is
NULL and injecting an MSI to that vCPU will crash the host kernel instead
of returning -ENODEV.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113101358.3007=
601-1-xiangwencheng@lanxincomputing.com?part=3D1
