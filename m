Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7A3F44D9
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654385; cv=none; b=cCqU0cdFX7kdAtfFzyONYiF4F0aa/jqScKX76vezO8F+PpYkhpO3tNWY6alvyC/ooReTuzOTGUBWlqhzkb8ThRAqgEJdBm0fDKDozWj3O6WhG1bOs4cM+deCL+y738D39ZfrNYRq+CLaeSolQvuYq63qsQw949uaqEVNIixMQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654385; c=relaxed/simple;
	bh=1+dX0cUpyOc6qOAwRS16/j8rukMGs0f17utseRGMKcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCeABXB+qEptO/UvQJLvahFVYmG0VK0uike+Ewp8SaLCdu2Y0oEGsyGgdrIerdYhA1Eyf0IkeOFRVRJhoX8cr7CdHYG4S9H4Zwcyo2G/pFz3APNjApzsd6o/YOvkFOwc1vtXvMAbht2lni7WYdOLLznUL+G/Sy0kiZuzMZQDwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STJ3uIcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STJ3uIcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9551F00893;
	Fri,  5 Jun 2026 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654383;
	bh=6bYoHFwhUe+YQlDzu55ayCC9JgrgNY5MRJ+BR7jEd1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STJ3uIcUkRZPeCSUqRUIoi7y9e3VT3BfAIC0KJMxVkwKf81RkcQOVh9DMRxmmx4n7
	 Il8gbOPI9q2pvMVa7hr9BYYUBFOzfFRiJOBhWwuoCvC/W1lMApsLwcT9P8OlSoTg+d
	 lkAChXU/TeDG7kd58rqIPfCkH8PT3fZwT0WuJ6WPkt/qv25JRioWGXBx/kyGIUBud3
	 STcssAQxJwUM4n6AfBLekP+FtSDO3iTcasFdOCo55wLh3xtZy9qNHUThkGHw2SC8U3
	 5qWB+86IUKrYZXt7Gn53HwLkZpUQ52zeowMKztGu3vlbgUMjto8VUPsiCZwPhr8uHG
	 0JtUaKn7IWXZw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] KVM: x86: add DSM APIC forwarding ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605100031.834938-4-muliang.shou@sjtu.edu.cn>
References: <20260605100031.834938-4-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:13:03 +0000
Message-Id: <20260605101303.8D9551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] The new VM ioctls unconditionally dereference the vcpu pointer=
 returned by kvm_get_vcpu(), which can be NULL if the user-provided vcpu_id=
 is out of bounds.
- [Critical] The ioctl handlers unconditionally dereference vcpu->arch.apic=
 without verifying that the VM has an in-kernel APIC instantiated.
- [High] The VM ioctls modify target vCPU architectural and hardware-switch=
ed state without holding vcpu->mutex or utilizing vcpu_load() and vcpu_put(=
).
- [High] Incorrect vCPU lookup function is used to resolve userspace vCPU I=
Ds, potentially accessing the wrong vCPU.
- [High] The UAPI structs contain implicit compiler padding and use the `bo=
ol` type, breaking 32-bit/64-bit ABI compatibility.
- [Medium] Failures in copy_from_user falsely return success (0) instead of=
 -EFAULT.
- [Medium] The newly added VM ioctls are not enumerable by userspace becaus=
e they are not backed by a KVM capability.
- [Low] The `dest_id` field in `struct kvm_dipi_params` is passed to `kvm_l=
apic_reg_write_remote` but completely ignored by the kernel.
--

commit e8a8009fce815ec914cc7e9a3c8df8f13d03680a
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: add DSM APIC forwarding ioctls

Add userspace ioctls that apply forwarded APIC, x2APIC ICR, and APIC
base updates on a target vCPU.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
[ ... ]
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +int kvm_lapic_reg_write_remote(struct kvm_lapic *apic, u32 reg, u32 val,=
 u32 dest_id)
> +{
> +	return kvm_lapic_reg_write(apic, reg, val);
> +}

[Severity: Low]
Is the dest_id parameter intended to be used here? It looks like it is
passed in from KVM_DSM_IPI but completely ignored by kvm_lapic_reg_write().

> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_reg_write_remote);
> +#endif
> +
[ ... ]
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -7634,6 +7634,46 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		r =3D kvm_vm_ioctl_set_msr_filter(kvm, &filter);
>  		break;
>  	}
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD

[Severity: Medium]
Should these newly added KVM_DSM_* ioctls be discoverable by userspace via
the KVM_CHECK_EXTENSION capability interface?

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
Does this mask the -EFAULT error if copy_from_user() fails? It appears r is
set to 0 right before the check, so the out label will return success inste=
ad
of propagating the error to userspace.

> +		vcpu =3D kvm_get_vcpu(kvm, params.vcpu_id);

[Severity: High]
Could this access the wrong vCPU or fail to find one entirely?
kvm_get_vcpu() expects an internal 0-based array index, but userspace is
passing an arbitrary vCPU ID. Should this use kvm_get_vcpu_by_id() instead?

[Severity: Critical]
Can kvm_get_vcpu() return NULL here if the provided vcpu_id is invalid or o=
ut
of bounds? If so, dereferencing vcpu->arch.apic immediately below would cau=
se
a kernel panic.

> +		reg =3D params.val;
> +		val =3D params.val2;
> +		kvm_lapic_reg_write_remote(vcpu->arch.apic, reg, val, params.dest_id);

[Severity: Critical]
Is it guaranteed that the VM has an in-kernel APIC instantiated here? If
the VM was created without calling KVM_CREATE_IRQCHIP, vcpu->arch.apic could
be NULL, leading to a panic when passed into kvm_lapic_reg_write_remote().

[Severity: High]
Does modifying the target vCPU's architectural and hardware-switched state
from a VM ioctl require holding vcpu->mutex and utilizing vcpu_load() and
vcpu_put()? Updating APIC state asynchronously without these protections mi=
ght
lead to leaked preempt notifiers or hardware state corruption if the target
vCPU is running concurrently.

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
> +		break;
> +	}
> +#endif
[ ... ]
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
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
Will this structure layout cause 32-bit/64-bit ABI compatibility issues? The
__u64 data field requires 8-byte alignment, which introduces implicit
compiler padding after vcpu_id on 64-bit systems but not on 32-bit ones. Th=
is
changes the structure size and the resulting ioctl number generated by the
_IOW macro.

> +
> +#define KVM_DSM_X2APIC _IOW(KVMIO, 0xf4, struct kvm_x2apic_params)
> +
> +struct kvm_apic_base_params {
> +	int vcpu_id;
> +	bool host;

[Severity: High]
Is it safe to use the standard C bool type in a UAPI struct? Its size is
implementation-defined, which can break ABI compat. Also, mixing bool,
__u32, and __u64 introduces implicit compiler padding here as well.

> +	__u32 index;
> +	__u64 data;
> +};
> +
> +#define KVM_DSM_APIC_BASE         _IOW(KVMIO, 0xf5, struct kvm_apic_base=
_params)
> +
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605100031.8349=
38-1-muliang.shou@sjtu.edu.cn?part=3D3
