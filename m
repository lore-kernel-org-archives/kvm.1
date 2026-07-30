Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B554028C3
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405368; cv=none; b=rN/Ub1dCS0ivdShiEnb4gI1U+t3PuSKdXouHC/4pb4csLtdTJiX9BakUA3OJT7PHcmVPoSyTyPeZqN1JQPJfr/gRuWD186OLBoX2zLQSYE6SVOXkFaeof/5wJ2Vo0hvAKNVqWBnRGLkVC64/zgqBkpe2eJGS+yaaJqKDLdSxzdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405368; c=relaxed/simple;
	bh=hJvgVB0QEX0pZ/fx8+FguuGTuYHtu7vJ04KaCjV6eSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PWOoc6x9qsR1cTKfpAPHC76E7Y2aaImvdGRCZAn+1DBocrucwb3vHsgMoiXC0CgVrI1hgIIlIR8/dr3yAXJxc9hkOuj08O8iqoFhN/n/1gQRkm45d2BKe6wX82kgTVxvT45a0DeygQ4VGtJu4WGZJqcE1g6wLO2XPZGATHrHI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkgJ8Wp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkgJ8Wp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46F81F000E9;
	Thu, 30 Jul 2026 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405366;
	bh=b0kEww0F/1Al+w+2besQvU9A5w0lf2fRGg/dokmLkcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fkgJ8Wp1+4v94/SemCrdiJoFKvfDSNcC1o4w7BL+dlbMoSA4FaDldUX7IobMeevJ+
	 RvKoXJqidq1R6Fc9WL8WKVW3eI8nGUnh5+SxkfRMNbDyu3M/pUxrf6VN59g9ab1i08
	 zLu2+q2SICzO93kyoetPsQNJZbXxi56UwOUp7gehNWMMq6vIcAmLSISlPorPk5/X0u
	 xTz/V7OZuWAK3Gm+ReVl2A5zMzrv5Qsv/gZZEwuEJVvEqMxR40DgWNqdJeyj0UIT5R
	 hnW8S2IVyKVxjkivwhaDHPXlyIqpoYv3EwXffDgytIeNWs/aVJU9j7bJvxEU2akBZt
	 Ekue0GgVdbMFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: KVM: Add hart-to-vCPU mapping for faster MSI
 injection
Reply-To: sashiko-reviews@lists.linux.dev
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com>
References: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:56:06 +0000
Message-Id: <20260730095606.B46F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Heap out-of-bounds write in `aia_init()` due to unvalidated, u=
ser-controlled `hart_index`.
- [High] Heap out-of-bounds read in MSI injection paths due to bounds check=
ing against the dynamically changing `kvm->created_vcpus`.
- [High] Initializing the AIA irqchip when zero vCPUs exist assigns `ZERO_S=
IZE_PTR` to `hart_to_vcpu`, leading to a fatal page fault on MSI injection.
- [High] Missing memory barrier (data race) when publishing the `kvm->arch.=
aia.initialized` flag.
--

--- Patch [1]: [PATCH] riscv: KVM: Add hart-to-vCPU mapping for faster MSI =
injection ---
commit 709e2881a16d8c1738dcbf37e41c35b07a8f7157
Author: BillXiang <xiangwencheng@lanxincomputing.com>

riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection

This patch introduces a direct lookup table to map hart_index to vCPU for
MSI injections, replacing the previous linear scans. The table is allocated
during AIA device initialization based on the number of created vCPUs.

> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index b195a93add1ce..555157d1db5b0 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -249,6 +249,14 @@ static int aia_init(struct kvm *kvm)
>  	if (ret)
>  		return ret;
> =20
> +	aia->hart_to_vcpu =3D kcalloc(kvm->created_vcpus,
> +					sizeof(struct kvm_vcpu*),
> +					GFP_KERNEL);
> +	if (!aia->hart_to_vcpu) {
> +		ret =3D -ENOMEM;
> +		goto fail_cleanup_aplic;
> +	}
> +

[Severity: High]
If the host userspace initializes the AIA irqchip before creating any vCPUs,
will kcalloc() with a zero count return ZERO_SIZE_PTR?

Because ZERO_SIZE_PTR is not NULL, the allocation check will pass.

Later on, if a vCPU is created and an MSI is injected, could this lead to a
page fault when ZERO_SIZE_PTR is used as a base pointer for the array
in kvm_riscv_aia_inject_msi()?

>  	/* Iterate over each VCPU */
>  	kvm_for_each_vcpu(idx, vcpu, kvm) {
>  		vaia =3D &vcpu->arch.aia_context;
[ ... ]
> @@ -271,6 +279,12 @@ static int aia_init(struct kvm *kvm)
>  		vaia->hart_index =3D aia_imsic_hart_index(aia,
>  							vaia->imsic_addr);
> =20
> +		if (aia->hart_to_vcpu[vaia->hart_index]) {

[Severity: Critical]
Is vaia->hart_index guaranteed to be within the bounds of the hart_to_vcpu
array?

The hart_index is derived from the user-controlled imsic_addr, nr_hart_bits,
and nr_group_bits via aia_imsic_hart_index().

Since aia->hart_to_vcpu is sized exactly to kvm->created_vcpus, could a
maliciously configured address cause an out-of-bounds read and subsequent
out-of-bounds write when we assign the vcpu pointer to this array?

> +			ret =3D -EINVAL;
> +			goto fail_cleanup_imsics;
> +		}
> +		aia->hart_to_vcpu[vaia->hart_index] =3D vcpu;
> +
>  		/* Initialize IMSIC for this VCPU */
>  		ret =3D kvm_riscv_vcpu_aia_imsic_init(vcpu);

[Severity: High]
Does publishing the aia->hart_to_vcpu array and setting the initialized flag
at the end of aia_init() require a memory barrier?

aia_init() publishes the array and then sets:
    kvm->arch.aia.initialized =3D true;

Since KVM_SIGNAL_MSI ioctls do not hold kvm->lock, they can run concurrentl=
y.

Because RISC-V uses a weakly ordered memory model, could the CPU or compiler
reorder the write to the initialized flag before the array is fully populat=
ed?

If a concurrent MSI injection sees initialized =3D=3D true but reads an
uninitialized aia->hart_to_vcpu array, could this result in a wild pointer
dereference?

[ ... ]
> @@ -541,30 +558,28 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcp=
u)
>  int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
>  				   u32 guest_index, u32 iid)
>  {
[ ... ]
> +	if (!aia->hart_to_vcpu || hart_index >=3D kvm->created_vcpus)
> +		return 0;
> =20
> -	return 0;
> +	vcpu =3D aia->hart_to_vcpu[hart_index];

[Severity: High]
Could this bounds check fail to protect the array access if vCPUs are creat=
ed
after the AIA device is initialized?

The hart_to_vcpu array is allocated with a capacity equal to
kvm->created_vcpus at the time aia_init() is called.

If additional vCPUs are created via KVM_CREATE_VCPU post-initialization,
kvm->created_vcpus will increase dynamically.

Would injecting an MSI with a hart_index corresponding to a newly added vCPU
bypass this check (since it tests against the newly incremented vCPU count
rather than the array's actual allocation size) and result in an
out-of-bounds read?

> +	if (!vcpu)
> +		return 0;
> +
> +	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_index, 0, iid);
>  }
> =20
>  int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  {
[ ... ]
> +	hart_index =3D aia_imsic_hart_index(aia, target);
> +	if(hart_index >=3D kvm->created_vcpus)
> +		return 0;
> +
> +	vcpu =3D aia->hart_to_vcpu[hart_index];

[Severity: High]
Does the same dynamic kvm->created_vcpus bounds checking regression apply
here in kvm_riscv_aia_inject_msi() as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730093614.9835=
08-1-xiangwencheng@lanxincomputing.com?part=3D1
