Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56937204A
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082134; cv=none; b=t6hECILGVqqr0lhP7jh0DTUEiFwHu2OOxrWtHn16HWSqjEdwQH0PXNQ5auutvTApuap4XJtQT8ZFi+5JQS3IvdNa0LoEKTdk2UjVHiIG9XvgHpOCVL+SJmxiUGd35EMB3KXxYDM4l3bhTTglzYoVM7PlF32K8amaOi/bkIu1Bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082134; c=relaxed/simple;
	bh=ky9O7id4vkt4RKgyDA7djSIT0kiOAMksEdqUBrSc0XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tp8LkbJcCuDbA1j9DrWCNxeXsRMT6W+djxhjkGzmX4dpbswK/PfOY1/KOQWYqy/XrQJ2gq9lwjV56E41eUbFKaVQEJLaLSKAsFXrKHhadmE9RANPNHMMoPvQqKD1GfGT2a4oDHG6/05jYgZP5LrYWZVVfV4O7wLjkxOsat8S/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3dxxsur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3dxxsur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586251F000E9;
	Fri,  7 Aug 2026 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786082132;
	bh=Kno4+NhO96L4kLBZMpVlaa8Bc0DGFUe/NSpvAhAT0Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3dxxsur/nSTQktLTXArhPv2XDVFEnG9tYxiKAN7IoLfk8kEldZwU9c1Mj4m0FYBj
	 DD1YWsZgBMJb6looIGtTFDMTW9tO+lMWysmUaYfgtOyjQszsIFRpFNPv0/VqczJsPK
	 EpguhsXoGpaAvmlbzXKpe5QoFf2WiJ3uNUrYid/5d4XntebRBNzm0Cit4cJigieHua
	 Az0wloorALSipMyF53XO35G3sL/RSRuaobHtDBDKwQi0ubhp+XwUf9ur1NJlAIPyPJ
	 trJEIuE2uyUECBiJdkvucDgObB2uodCAHaz5GNiSfrKxok3zUaG+565Sym77eHvaFQ
	 4aplcCCWOBPjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Add PMU event filter support
Reply-To: sashiko-reviews@lists.linux.dev
To: Yuhang.chen <yhchen312@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807053227.341700-2-yhchen312@gmail.com>
References: <20260807053227.341700-1-yhchen312@gmail.com>
 <20260807053227.341700-2-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 05:55:31 +0000
Message-Id: <20260807055532.586251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The implementation fails to clear the active filter when `nevent=
s =3D=3D 0` as documented in the commit message.
--

--- Patch [1]: [PATCH v2 1/2] RISC-V: KVM: Add PMU event filter support ---
commit f5fab5adc86a94658a09438bfb27fb33aa49c8df
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: Add PMU event filter support
   =20
Allow userspace to restrict which SBI PMU events a guest is permitted
to program via the new VM ioctl KVM_SET_PMU_EVENT_FILTER.

> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb767..a5a3a2182d1e4 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c

[ ... ]

> @@ -265,7 +268,71 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)

[ ... ]

> +	if (tmp.nevents > KVM_PMU_EVENT_FILTER_MAX_EVENTS)
> +		return -E2BIG;
> +
> +	size =3D struct_size(filter, events, tmp.nevents);
> +	filter =3D kzalloc(size, GFP_KERNEL_ACCOUNT);
> +	if (!filter)
> +		return -ENOMEM;

[Severity: Medium]
The commit message states that "nevents =3D=3D 0 clears any active filter".=
=20
However, this code unconditionally allocates and installs a new filter even
when nevents =3D=3D 0, instead of skipping the allocation and setting the p=
ointer
to NULL.

If userspace passes a zeroed structure to clear the filter (meaning nevents
is 0 and action defaults to 0, which is KVM_PMU_EVENT_ALLOW), won't this
install a 0-event ALLOW filter?

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2025b664961c8..cf360f8496e5e 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c

[ ... ]

> @@ -733,6 +733,32 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,

[ ... ]

> +	for (i =3D 0; i < filter->nevents; i++) {
> +		if ((unsigned long)filter->events[i] =3D=3D eidx) {
> +			in_list =3D true;
> +			break;
> +		}
> +	}
> +
> +	/* ALLOW: permit only listed events; DENY: reject them. */
> +	if (filter->action =3D=3D KVM_PMU_EVENT_ALLOW)
> +		return in_list;
> +	return !in_list;
> +}

[Severity: Medium]
If a 0-event ALLOW filter was installed because nevents was 0, in_list will
be false here.=20

Does this result in kvm_riscv_pmu_event_allowed() returning false and
rejecting all guest PMU events, breaking PMU functionality rather than
restoring the default allow-all behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807053227.3417=
00-1-yhchen312@gmail.com?part=3D1
