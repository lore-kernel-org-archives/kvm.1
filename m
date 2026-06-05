Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957B2C028F
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653607; cv=none; b=fc4FguTht4oOdFlDgPGmOuntVgl0OjfNC03vn5UOkzzKd1OJDY08VfkZIjJbo5g4jTUhLOETuYlQccHIeJhz29BwMarpawEqTnQ+UlVMBhBSePIOC0uRM6K+16lRgQFfx5pqGiFZbPysgxDhU5kqQjucZpz7IW2O631tssipYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653607; c=relaxed/simple;
	bh=VrcmJWQh5CRLg8FicAHkvxCM9Jabw923ljvd/PwWK/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nzFlMccyDT6YqAM4pWERFfBndy1L9thoaHlvyCjK97n2rZq73euH60CWoYOW5OizanFoMGdStme3VYiRDsm2S+kZdtYe/xBfW2uSyVJOJD2GiHjFrO80CqhDxPEaX0LvTZ5WSNlueb3jDWyyES/qmyfEZNXaEyCzxrAT5SBS7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui9HFvpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui9HFvpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C171F00893;
	Fri,  5 Jun 2026 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653605;
	bh=lzTMR9P5II63N94s/IAyUvPfw5Z3MZOMEyh4EGglpFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ui9HFvpX+uthO6LHY8D5MiCxqEAt2T10JzYzJFLGf1mTEb9ERNSBp2dG0XH4SnEuL
	 nkueuzzjvGefC9kCH1B19FM0Azs6uEuIk2BhN2FlHQblVfHp4liq/qcLOTZaPasbxF
	 dZEYiRo+3O6/V1kCLO6hppFZgB8XYLLQDbIq3g7nPq/BmQEHvbSvN9PykOXuyjewIX
	 slyM3Veo99MCR5JEc7NdzCAeIUNRPt8efH/IQhxSpAETXJv4eT8nYBa6/omTL2CkQH
	 5ugqLBDLAOLWBnCgKkRaCq+Op/YhRerTfj+2otg+81sRI1SgFWY2+FawTIFb2v1rbl
	 0lXIMW7v1iJlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: add DSM APIC forwarding ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605093857.747735-4-muliang.shou@sjtu.edu.cn>
References: <20260605093857.747735-4-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:00:05 +0000
Message-Id: <20260605100005.A1C171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Incorrect vCPU lookup and missing NULL check for the result of=
 `kvm_get_vcpu()`.
- [High] Dereferencing `vcpu->arch.apic` without verifying if the in-kernel=
 APIC is initialized.
- [High] Modifying vCPU architectural and hardware-switched state from a VM=
 ioctl without `vcpu_load()` or `vcpu->mutex`.
- [High] Implicit structure padding and the use of the `bool` type in UAPI =
structs break 32-bit vs 64-bit ABI compatibility.
- [High] Double IPI delivery in `apic_mmio_write()` due to executing intern=
al KVM logic before queuing the DSM forward request.
- [Medium] Silent error masking on `copy_from_user()` failure.
- [Medium] `dest_id` parameter is completely ignored in `kvm_lapic_reg_writ=
e_remote()`.
- [Medium] Unnecessary and expensive VM exits triggered on standard `APIC_I=
CR2` writes.
- [Low] Unreachable `apic_x2apic_mode` condition in `apic_mmio_write()`.
--

commit 4bde3ce0dad331a911916cb971f72910f8f94774
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: add DSM APIC forwarding ioctls

This commit introduces three new ioctls (KVM_DSM_IPI, KVM_DSM_X2APIC, and
KVM_DSM_APIC_BASE) to apply forwarded APIC, x2APIC ICR, and APIC base updat=
es
on a target vCPU. It also modifies the APIC MMIO write path to exit to
userspace for interrupt forwarding.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2555,6 +2555,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *a=
pic, u32 reg, u32 val)
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +int kvm_lapic_reg_write_remote(struct kvm_lapic *apic, u32 reg, u32 val,=
 u32 dest_id)
> +{
> +	return kvm_lapic_reg_write(apic, reg, val);

[Severity: Medium]
Will this ignore the dest_id parameter? When writing to APIC_ICR, KVM
internally reads the destination ID from the target vCPU's pre-existing
APIC_ICR2 register. Since dest_id is thrown away here, does KVM end up
using whatever stale value resides in APIC_ICR2, sending the IPI to the
wrong destination?

> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_reg_write_remote);
> +#endif

[ ... ]

> @@ -2583,6 +2591,24 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, =
struct kvm_io_device *this,
>  	val =3D *(u32*)data;
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +	reg =3D offset & 0xff0;
> +	if (reg =3D=3D APIC_ICR || reg =3D=3D APIC_ICR2) {

[Severity: Medium]
In xAPIC mode, a guest routinely writes to APIC_ICR2 merely to set up the
destination ID, and then writes to APIC_ICR to trigger the interrupt.
Since userspace cannot forward an incomplete IPI, does triggering a
userspace exit on APIC_ICR2 subject the guest to a pointless, expensive
roundtrip?

> +		kvm_lapic_reg_write(apic, reg, val);

[Severity: High]
Does this execute the actual internal KVM IPI delivery mechanism before
triggering the DSM forwarding request? Writing to APIC_ICR here invokes
kvm_apic_send_ipi(). Does this mean the interrupt is sent internally by
KVM first, and then the vCPU exits to userspace requesting it to forward
the same IRQ, leading to duplicate interrupt delivery?

> +		if (reg =3D=3D APIC_ICR) {
> +			if (apic_x2apic_mode(apic)) {

[Severity: Low]
Is this apic_x2apic_mode() check reachable? Earlier in apic_mmio_write(),
KVM checks if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) and
returns immediately. Therefore, MMIO writes to the APIC are unconditionally
rejected when in x2APIC mode, making this new x2APIC check dead code.

> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +			} else {
> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +				dest_id =3D GET_XAPIC_DEST_FIELD(dest_id);
> +			}

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7634,6 +7634,46 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		r =3D kvm_vm_ioctl_set_msr_filter(kvm, &filter);
>  		break;
>  	}
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +	case KVM_DSM_IPI: {
> +		struct kvm_dipi_params params;
> +		struct kvm_vcpu *vcpu =3D NULL;
> +		u32 reg;
> +		u32 val;
> +
> +		r =3D 0;
> +		if (copy_from_user(&params, argp, sizeof(params)))
> +			goto out;

[Severity: Medium]
If copy_from_user() fails, the code executes goto out with r =3D 0. Does th=
is
falsely inform userspace that the operation succeeded when the parameters
were invalid and no action was actually performed? Should this return
-EFAULT instead?

> +		vcpu =3D kvm_get_vcpu(kvm, params.vcpu_id);
> +		reg =3D params.val;
> +		val =3D params.val2;
> +		kvm_lapic_reg_write_remote(vcpu->arch.apic, reg, val, params.dest_id);

[Severity: Critical]
Does kvm_get_vcpu() expect an internal array index rather than the uAPI
vcpu_id? If the provided ID/index is out of bounds, kvm_get_vcpu() returns
NULL. Since the pointer is immediately dereferenced, could an unprivileged
userspace process trigger a deterministic host kernel panic?

[Severity: High]
If userspace created the VM without an in-kernel local APIC, vcpu->arch.apic
can be NULL. Will unconditionally dereferencing the APIC pointer lead to a
host kernel panic?

> +		break;
> +	}
> +	case KVM_DSM_X2APIC: {
> +		struct kvm_x2apic_params params;
> +		struct kvm_vcpu *vcpu =3D NULL;
> +
> +		r =3D 0;
> +		if (copy_from_user(&params, argp, sizeof(params)))
> +			goto out;
> +
> +		vcpu =3D kvm_get_vcpu(kvm, params.vcpu_id);
> +		kvm_x2apic_icr_write_fast(vcpu->arch.apic, params.data);
> +		break;
> +	}
> +	case KVM_DSM_APIC_BASE: {
> +		struct kvm_apic_base_params params;
> +		struct kvm_vcpu *vcpu =3D NULL;
> +
> +		r =3D 0;
> +		if (copy_from_user(&params, argp, sizeof(params)))
> +			goto out;
> +		vcpu =3D kvm_get_vcpu(kvm, params.vcpu_id);
> +		kvm_apic_set_base(vcpu, params.data, params.host);

[Severity: High]
These DSM ioctls are implemented as VM-level ioctls, which do not implicitly
acquire vcpu->mutex or call vcpu_load(). Does modifying vCPU hardware state,
such as APIC registers and apic_base, asynchronously without vcpu->mutex
introduce severe data races? Also, failing to pair vcpu_load() and vcpu_put=
()
violates KVM subsystem guidelines and can lead to hardware state corruption.

> +		break;
> +	}
> +#endif

[ ... ]

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -231,6 +231,33 @@ struct kvm_exit_snp_req_certs {
>  #define HINT_UNSAFE_IN_KVM(_symbol) _symbol
>  #endif
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +struct kvm_dipi_params {
> +	int vcpu_id;
> +	__u32 val;
> +	__u32 val2;
> +	__u32 dest_id;
> +};
> +
> +#define KVM_DSM_IPI _IOW(KVMIO,  0xf3, struct kvm_dipi_params)
> +
> +struct kvm_x2apic_params {
> +	int vcpu_id;
> +	__u64 data;
> +};

[Severity: High]
Does this mix of 32-bit and 64-bit fields without explicit padding break
32-bit vs 64-bit ABI compatibility? On 64-bit architectures, the compiler
inserts 4 bytes of padding before __u64 data to maintain 8-byte alignment,
while 32-bit x86 only requires 4-byte alignment, inserting no padding. This
difference in size causes the _IOW macro to generate different ioctl
command numbers for 32-bit and 64-bit userspace.

> +
> +#define KVM_DSM_X2APIC _IOW(KVMIO, 0xf4, struct kvm_x2apic_params)
> +
> +struct kvm_apic_base_params {
> +	int vcpu_id;
> +	bool host;
> +	__u32 index;
> +	__u64 data;
> +};

[Severity: High]
Similarly, does this struct suffer from the same 32-bit vs 64-bit implicit
padding differences? Also, since the C++ bool type's size is
compiler-defined, is it safe to use it in a UAPI struct, or will it further
break ABI guarantees?

> +
> +#define KVM_DSM_APIC_BASE         _IOW(KVMIO, 0xf5, struct kvm_apic_base=
_params)
> +
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605093857.7477=
35-1-muliang.shou@sjtu.edu.cn?part=3D3
