Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DF18B0F
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075964; cv=none; b=DJ4hP1raZ0BEy8f7BkUf27STu8rAP17pRh9axrNO+NccmsIUYuF9ARWhoVUbzh3CjCMtRHurJmbu1eb2lzLXIDtvFc98wwlXAboND47VVre6+U3T6bYW9bEpdKqbmlMN03cAJcHsdEQTME9rraiDnW+pGof3olmHXJTbooLXNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075964; c=relaxed/simple;
	bh=np0/f1Ci0qhqlx0DauxdgSfXX1AsUX0ru7g8zvo3tgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRopPChCZX6PDB7F2Y9ZJsH+mYehQeImhXQAwLkdvvGoZQEKjFFkvt9xAdOOPdErC+itheIHvMMRoGiPWaRT1Vz1WZXpJvavA/d7gfNrfz+r7OcG2CzQ1zPM+6LnRciI3yo0uMpWmoBMgS7UJ3e5UcG+FimX6UfrBwIGL3PR6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXWqDFtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXWqDFtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93011F000E9;
	Fri,  7 Aug 2026 04:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786075962;
	bh=UBKV2U0ol4jhU4rup+SIK9KAKmYQaLF/azZoqFjKcVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXWqDFtt0rSrpskNNKyC2diocly7BMA1RQ78oa/LzvAooS3xWjHaYdpPqxPQluApM
	 dyLzi8ZROnICSz09tfRl5aDt31fmilkqSjcgmvKxWWrfmO8dnPg6jNYl3ses93D8oL
	 9CsRgDxKAg+MemFXwnKOPkFHM2nkLOrhZmHOt7wpyDaGkRlCm2H7d1rEq+exZjL7by
	 AXYXk0ASedMHAMmDUdrhu+RP/Kc9gIX2DMEqcFVZpWadJcBbV7BDtmbv6XbH8pHnzy
	 n8pxL1bBkeUu9uMyaZ7hqTmSPk8LqvxyWCEyqrkdr7/u+FS9YAoithTHEeGQDKMYo1
	 sNNvGAnnPlePg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Add PMU event filter support
Reply-To: sashiko-reviews@lists.linux.dev
To: Yuhang.chen <yhchen312@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807035039.294998-2-yhchen312@gmail.com>
References: <20260807035039.294998-1-yhchen312@gmail.com>
 <20260807035039.294998-2-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 04:12:42 +0000
Message-Id: <20260807041242.A93011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Guest can trivially bypass PMU event DENY filters by setting unmas=
ked high bits in the event index (eidx).
- [Medium] RISC-V defines a structurally incompatible `struct kvm_pmu_event=
_filter` compared to x86, which causes the KVM_SET_PMU_EVENT_FILTER ioctl n=
umber to diverge and breaks cross-architecture userspace code.
- [Medium] Missing validation for the UAPI padding field prevents safe futu=
re extensions.
--

--- Patch [1]: [PATCH 1/2] RISC-V: KVM: Add PMU event filter support ---
commit 4331081d868d3aa2c618439fb21772bb580c0495
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: Add PMU event filter support
   =20
Allow userspace to restrict which SBI PMU events a guest is permitted
to program via the new VM ioctl KVM_SET_PMU_EVENT_FILTER.  It takes a
struct kvm_pmu_event_filter whose events[] array holds SBI PMU event
indices encoded as (type << 16) | code.

> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 504e73305343a..da4f639fa89f8 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
[ ... ]
> @@ -396,6 +397,25 @@ struct kvm_riscv_sbi_fwft {
>  /* One single KVM irqchip, ie. the AIA */
>  #define KVM_NR_IRQCHIPS			1
> =20
> +/* for KVM_CAP_PMU_EVENT_FILTER */
> +#define KVM_PMU_EVENT_ALLOW	0
> +#define KVM_PMU_EVENT_DENY	1
> +
> +/*
> + * For KVM_SET_PMU_EVENT_FILTER: restrict which SBI PMU events a guest m=
ay
> + * configure.  Each @events entry is a SBI PMU event index (type in bits
> + * 19:16, code in bits 15:0).  %KVM_PMU_EVENT_ALLOW permits only listed
> + * events; %KVM_PMU_EVENT_DENY rejects them.  Enforced at counter
> + * configuration (SBI PMU COUNTER_CFG_MATCH), not retroactively.
> + */
> +struct kvm_pmu_event_filter {
> +	__u32 action;
> +	__u32 nevents;
> +	__u32 flags;
> +	__u32 pad;
> +	__DECLARE_FLEX_ARRAY(__u64, events);
> +};

[Severity: Medium]
Since KVM_SET_PMU_EVENT_FILTER is a generic KVM ioctl, does defining
struct kvm_pmu_event_filter with a different size and layout than the exist=
ing
x86 definition break cross-architecture userspace code?=20

The size difference (due to missing fields like fixed_counter_bitmap and
different padding) causes the ioctl number to evaluate to a different numer=
ic
value on RISC-V. Could this be unified with the existing generic definition=
 to
maintain KVM UAPI consistency?

>  #endif
> =20
>  #endif /* __LINUX_KVM_RISCV_H */
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2025b664961c8..189650b04c37d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
[ ... ]
> @@ -733,6 +733,29 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>  	return 0;
>  }
> =20
> +static bool kvm_riscv_pmu_event_allowed(struct kvm *kvm, unsigned long e=
idx)
> +{
> +	struct kvm_pmu_event_filter *filter;
> +	bool in_list =3D false;
> +	unsigned int i;
> +
> +	filter =3D srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
> +	if (!filter)
> +		return true;
> +
> +	for (i =3D 0; i < filter->nevents; i++) {
> +		if ((unsigned long)filter->events[i] =3D=3D eidx) {
> +			in_list =3D true;
> +			break;
> +		}
> +	}

[Severity: High]
Can a malicious guest bypass the DENY filter by setting high unmasked bits
in the event index?

In kvm_riscv_pmu_event_allowed(), the guest-controlled eidx is exact-matched
against the filter entries. If the guest provides an eidx with bits above
bit 19 set (e.g., bit 63), the equality check fails and a DENY filter will
incorrectly allow it.

Because the subsequent configuration logic masks out the high bits using
get_event_type() and get_event_code(), the blocked event is still
successfully configured. Should eidx be properly masked before it is compar=
ed
against the filter events?

> +
> +	/* ALLOW: permit only listed events; DENY: reject them. */
> +	if (filter->action =3D=3D KVM_PMU_EVENT_ALLOW)
> +		return in_list;
> +	return !in_list;
> +}
> +
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb767..6f822c43f1569 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
[ ... ]
> @@ -265,7 +268,68 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
>  	}
>  }
> =20
> +#define KVM_PMU_EVENT_FILTER_MAX_EVENTS	256
> +
> +static int kvm_riscv_vm_ioctl_set_pmu_event_filter(struct kvm *kvm,
> +						   void __user *argp)
> +{
> +	struct kvm_pmu_event_filter __user *user_filter =3D argp;
> +	struct kvm_pmu_event_filter *filter, tmp;
> +	size_t size;
> +	int r =3D 0;
> +
> +	if (copy_from_user(&tmp, user_filter, sizeof(tmp)))
> +		return -EFAULT;
> +
> +	if (tmp.action !=3D KVM_PMU_EVENT_ALLOW &&
> +	    tmp.action !=3D KVM_PMU_EVENT_DENY)
> +		return -EINVAL;
> +
> +	if (tmp.flags)
> +		return -EINVAL;
> +
> +	if (tmp.nevents > KVM_PMU_EVENT_FILTER_MAX_EVENTS)
> +		return -E2BIG;

[Severity: Medium]
Does this code leave the tmp.pad field unvalidated?

If userspace passes uninitialized data or garbage in the padding field,
the kernel will silently accept it because there is no check ensuring
tmp.pad is zero. Will this prevent safely repurposing the padding field
for new features or flags in the future without breaking ABI compatibility
for existing applications?

> +
> +	size =3D struct_size(filter, events, tmp.nevents);
> +	filter =3D kzalloc(size, GFP_KERNEL_ACCOUNT);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807035039.2949=
98-1-yhchen312@gmail.com?part=3D1
