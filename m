Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85233D6F9
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226883; cv=none; b=VcGQrB07q0sb3jbgnuEpb7uvXodmlZdJcGMzAKYDjw7nFuczMMRicbzM9Rju/IYKAcyT0jYXdtxZ5MyYWEmLkTog1yILUlVR4rDlBqVBuBvdVK4RJA0ILb9XDHjDDzlKQe/bXiJhva9js62w2rvpbqk36KsgRtKkwSPXIzGDAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226883; c=relaxed/simple;
	bh=q3j6ztlYWWEgBle9a27l4w38IRgfMbFuT2KtLEe4TPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iy75eHN1iQndwLwz7c98tTE9FNn8kSpZokqoEAQ2IRByF8h2ci5ifxIGGIt7EqtKS/M+e2wDYC340dJlVIAWetOFHo90kM1oYjxmhv8hWwY28bwoFGY8ZjVcyZpAj7WtfeG8g8ZSLGAUHvFRazMHg3hq27+tHWn4TS9Mcwae8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3yUPk5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3yUPk5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8F91F00A3D;
	Thu, 16 Jul 2026 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226879;
	bh=ZEplzCreWGQdggGtUC5qCBV4DYgXou/BUVxVELmCmZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3yUPk5zkm+sRiD2knf4B8mP+6ero0xXvXlHWNvmktzoITny9TH6Oe1jwGQH1J/KW
	 F+YjcftFXJJsDVaG4NnHDZmAk29CcAH8CQpUkQ7w28tmyFMfBJfYTp6rkro7OeL+mv
	 RUtK7iCHRyEN6TLkcriBRXzqF0AQZUD6emnqG38BqQLrstEINwi27360oO9nxgd369
	 eYBOOpbm4KyyIvXgX9AdjOM4vSmNwa0Hplhk+RObwJGJeowyVFsgAY2M4rUm6evvUZ
	 W8RnUFRZvrMSh5JRe0eOS3m4U9pm7HrDGaE3oxL6KlZWTl1PH8gD64tomtu2bSGM4L
	 pup/BlqNMW+pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/24] KVM: x86: hyperv: Introduce memory fault on
 hcalls with bad ingpas
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-4-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:34:38 +0000
Message-Id: <20260716183439.3C8F91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unconditionally validates the input parameter GPA (`hc.ingpa`) for=
 all slow hypercalls, causing Guest DoS for hypercalls without input parame=
ters.
- [High] Improperly enforces write access on the input parameter block (`hc=
.ingpa`) and fails to validate the output parameter block (`hc.outgpa`).
- [High] Treats untranslated L2 GPAs as L1 GPAs, allowing an L2 guest to tr=
ivially DoS the L1 VMM.
- [Medium] Reports an inaccurate fault range to userspace by using an unali=
gned GPA and a hardcoded PAGE_SIZE.
- [Medium] Unsynchronized mutability of the `KVM_CAP_HYPERV_HCALL_FAULT_EXI=
T` capability violates KVM guidelines.
--

--- Patch [3]: [PATCH 03/24] KVM: x86: hyperv: Introduce memory fault on hc=
alls with bad ingpas ---
commit 2ee0ff5e023dcf16d5e8bf3cfc26d7ec91c1d297
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86: hyperv: Introduce memory fault on hcalls with bad ingpas

This commit introduces a new capability, KVM_CAP_HYPERV_HCALL_FAULT_EXIT,
which allows KVM to exit to userspace with a memory fault when a guest
provides an invalid input GPA during a hypercall.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
[ ... ]
> @@ -2531,11 +2531,30 @@ static bool hv_check_hypercall_access(struct kvm_=
vcpu_hv *hv_vcpu, u16 code)
>  	return true;
>  }
> =20
> +static unsigned int kvm_hv_hypercall_mem_access(u16 code)
> +{
> +	switch (code) {
> +	case HVCALL_SIGNAL_EVENT:
> +	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
> +	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
> +	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
> +	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
> +	case HVCALL_SEND_IPI:
> +	case HVCALL_SEND_IPI_EX:
> +		return KVM_MEMORY_EXIT_FLAG_READ;
> +	}
> +
> +	return KVM_MEMORY_EXIT_FLAG_WRITE;

[Severity: High]
Does this default to requiring write access for all unlisted hypercalls?

If a guest issues an unlisted hypercall (e.g., HVCALL_POST_MESSAGE) with its
input parameter block in read-only memory, this would return
KVM_MEMORY_EXIT_FLAG_WRITE, causing KVM to incorrectly demand write access
and reject a valid read-only buffer with a memory fault.

> +}
> +
>  int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv *hv_vcpu =3D to_hv_vcpu(vcpu);
> +	struct kvm *kvm =3D vcpu->kvm;
>  	struct kvm_hv_hcall hc;
>  	u64 ret =3D HV_STATUS_SUCCESS;
> +	unsigned int access;
> +	unsigned long addr;
> =20
>  	/*
>  	 * hypercall generates UD from non zero cpl and real mode
> @@ -2590,6 +2609,19 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		kvm_hv_hypercall_read_xmm(&hc);
>  	}
> =20
> +	if (!hc.fast && kvm->arch.hyperv.hcall_fault_exit) {
> +		bool writable =3D true;
> +		access =3D kvm_hv_hypercall_mem_access(hc.code);
> +		addr =3D kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(hc.ingpa), &writabl=
e);

[Severity: High]
Does this code unconditionally validate hc.ingpa for all slow hypercalls?

If a guest invokes a hypercall that does not take an input parameter
(like HVCALL_NOTIFY_LONG_SPIN_WAIT), its parameter registers may be
uninitialized. If the uninitialized register contains an unmapped GPA,
wouldn't KVM inject a KVM_EXIT_MEMORY_FAULT and return -EFAULT, causing
userspace to terminate the VM?

[Severity: High]
Are untranslated L2 GPAs treated as L1 GPAs here?

When an L2 guest executes a hypercall, KVM reads hc.ingpa and blindly passes
it to kvm_vcpu_gfn_to_hva_prot() without translating it or checking
is_guest_mode().

If an L2 guest passes an invalid L1 GPA, this could return -EFAULT and
trigger a KVM_EXIT_MEMORY_FAULT to L0 userspace, terminating the entire
L1 VM. Could this allow an L2 guest to trivially crash L1?

> +		if (addr =3D=3D KVM_HVA_ERR_BAD ||
> +		    (access =3D=3D KVM_MEMORY_EXIT_FLAG_WRITE && !writable)) {

[Severity: High]
Is the output parameter block (hc.outgpa) validated anywhere in this new
mechanism?

It looks like we enforce the write access requirement on the input
parameter GPA, but completely omit validation for hc.outgpa. Hypercalls
writing to unmapped memory might bypass the memory fault mechanism entirely.

> +			kvm_prepare_memory_fault_exit(vcpu, hc.ingpa, PAGE_SIZE,
> +						      access =3D=3D KVM_MEMORY_EXIT_FLAG_WRITE,
> +						      false, false);

[Severity: Medium]
Could this report an inaccurate fault range to userspace?

We are preparing a memory fault exit using the exact unaligned address
provided by the guest (hc.ingpa) but with a hardcoded size of PAGE_SIZE. If
hc.ingpa is near a page boundary, the reported fault range would span two
pages, even though we only validated a single GFN for hc.ingpa.

> +			return -EFAULT;
> +		}
> +	}
> +
>  	switch (hc.code) {
>  	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
[ ... ]
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -4190,6 +4191,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		mutex_unlock(&kvm->lock);
>  		break;
>  	}
> +#ifdef CONFIG_KVM_HYPERV
> +	case KVM_CAP_HYPERV_HCALL_FAULT_EXIT:
> +		kvm->arch.hyperv.hcall_fault_exit =3D cap->args[0];

[Severity: Medium]
Should this capability state be protected by kvm->lock and restricted to
before vCPUs are created?

Userspace can toggle the capability dynamically, and modifying this flag
without checks creates state-machine transitions that could race with activ=
ely
executing hypercalls. New flags that change VM or vCPU behavior typically
default to immutable once vCPUs are running.

> +		r =3D 0;
> +		break;
> +#endif
>  	default:
>  		r =3D -EINVAL;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D3
