Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A03441618
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154287; cv=none; b=dZXNKRIcOxTOJn6PMFOcrypUqM7rk4DWhxU4V0/mvCRr1Mt0uQ1ABBmqaXaw2xsqF9VNfESAygInDBmZXjoTDHCt1h/XlVt4qy5KDh0AlIgwgAserq/Oe5YwkVQapSCkdGXNQZyPKJuVlENukWsQbLe4Rby3yPvsq9fwNEPJL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154287; c=relaxed/simple;
	bh=F76rJF6rJyKJ9l8ks9XlH+gyCTXUKy31iCnWUKjvOe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7sa6z7jbqdJ3ZA+Z+Blhj4MV1QEnabQ/dtFCUk2C+ypAL6XxAunCGrCF1UZH78OEPvJId4lAzSwDKFwdJ5ShYQjZfkKE/4dXRLU7u73kVxxqe1Nu9GhO9SRglkCKW3vxajc+/9l9rtfogR8UsOXq2y8Wjqxa8uWWUe599HF4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWCfLDns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWCfLDns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6791F00893;
	Wed, 23 Sep 2026 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154285;
	bh=fp0Px9NCaBEq8uaaDYKK+Ud2ioVOuzzI3JCjUnpy6FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWCfLDns0A0BIMpWokhTeBJB2xlc4Neng1Izi3430H5/eW2BH+9qLPUqZ/dFYE/VJ
	 D8n0K+BdaQBq58cVu5JzcEGmHu4JyM7MTYFqSZ0ivggDvSyDHYxvIBr/nqW+IuEYWy
	 AzzLuq0CDl1mubocIAVubq2Zcmhg5l/c9uqvLb+Qh5SwbTGpivz3Flty0ZrejJfKO+
	 S5vh8IYR6XJMC7W8Z2e6rVasha8ikVvo9/iuBvpBjmLFKzK1oU0kKfKe7y9COGf+cR
	 sHdj9pIYvwelroiwJMh4FYZuBu0lZJ9F83q7xBd6AK32+It9YhsZnjTIcuwfvC323N
	 gv+pUtq5kOhcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI
 read-and-clear operation
Reply-To: sashiko-reviews@lists.linux.dev
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260923085631.1384021-1-xiangwencheng@lanxincomputing.com>
References: <20260923085631.1384021-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 09:04:45 +0000
Message-Id: <20260923090445.7A6791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] riscv: kvm: build error due to undeclared 'eflags'
--

commit 216b97a6c827bbe2a6897aa0efd6984c531cf514
Author: BillXiang <xiangwencheng@lanxincomputing.com>

RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operati=
on
   =20
This commit adds synchronization to the IMSIC TOPEI read-and-clear path to
ensure it remains atomic with respect to interrupt injections.

Link: https://lore.kernel.org/kvm-riscv/20260923070332.1376132-1-xiangwench=
eng@lanxincomputing.com/

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index c1af23e79ae06..490c55419eb22 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c

[ ... ]

> @@ -912,12 +911,15 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
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

[ ... ]

> @@ -934,16 +936,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
cpu, unsigned long isel,
>  					  eix->eip);
>  			}
>  		}
> +		if (wr_mask)
> +			__imsic_swfile_extirq_update(vcpu);
> +
> +		raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, eflags);

[Severity: Low]
Does this cause a build failure? The local variable is declared as flags at
the top of kvm_riscv_vcpu_aia_imsic_rmw(), but this unlock path attempts to
use eflags instead, which appears to be undeclared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923085631.1384=
021-1-xiangwencheng@lanxincomputing.com?part=3D1
