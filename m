Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886630AD05
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252692; cv=none; b=HtScaeSNAP+wutGmFff/T7pLIClQC1/e37hmnD+aFjqfiYVMmGWK9A7GYl/dWHkiH5YV+Fs9dUyhHiAzZMtyyKcVhaIMgX+zA70AIQnW7r1QNIIFmv1zkGUkCI9v/6CDck2t4MjvtNmQ4kyabCKqylRTWiQa2H/e6mRoyetU2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252692; c=relaxed/simple;
	bh=8NCClHrm2or4BNnnlAVP3I9JkEAjx9iVvTQl6qzFeak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cpz7T1CMc3MFXZ/A1L4Y/NF3ZkON9EIB9cDuNUcYiDOtmdgwnyUQPnx6RMECJbdd7pRytw6QkW3dp5UzdoeFYy7GrC/Ky+gRPzLssQXdoNjh1XsCHWO28fO/sDcKUj463zw/itjhl49WCdlTj/OI5m4Z3aVnMNlbcZ3vmLWzCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8A9UFN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8A9UFN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E665B1F00A3D;
	Tue, 28 Jul 2026 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252691;
	bh=0vJ2qchA/3YJo8FrHzTOIrxIMOki1qZiXjYEE4aHUcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8A9UFN2dyllLHddl7tM1f8FB71rOHR7NocU9K6G2cKaj03FrLk5SwB0Q1IjbxuVP
	 VUhp1dsiSICzRzYp6lmxohaODv+MYE8SiVsjieh49jUw68ccyYmFiHm1NWzJiX4vC7
	 hYVvgH7ohqRZ1cEsWj9vn0kx75gU9CRlP8kWXEANdugw/9St7gD7tiHTES+WWF9mUJ
	 18JvsGE4XrKfaYKApDOkJ+FLSiZ+nXjwTugs/zt8BPF7x3pUcrYg9uOcOdgAVXjrwp
	 bTF2eFXcumx7l6wKIYjNCgyl8J/yfh2RmOyhwtoBIbdwGn+oNcmW+xx1J+W8U04+KR
	 myKhEbsz6866w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/36] KVM: x86: Activate master clock from
 kvm_arch_init_vm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-29-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-29-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:31:30 +0000
Message-Id: <20260728153130.E665B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect masterclock scaling ratio and stale state initialization=
 in `kvm_arch_init_vm()`.
- [High] Unconditional setting of `user_set_tsc =3D true` at vCPU creation =
breaks 1-second TSC slop protection.
--

--- Patch [28]: [PATCH v7 28/36] KVM: x86: Activate master clock from kvm_a=
rch_init_vm() ---
commit c68bcfc5acfe3bb9dda51b0de8e297101615b7d5
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock from kvm_arch_init_vm()

Initialize the TSC generation and master clock state at VM creation
time, rather than relying on kvm_update_masterclock() from
kvm_arch_vcpu_postcreate().

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9407,8 +9407,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  		return;
>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL);

[Severity: High]
A previous patch in this series modified kvm_set_tsc_khz() to unconditional=
ly
call kvm_synchronize_tsc(vcpu, &tsc) with a non-NULL pointer during vCPU
initialization.

Does this cause __kvm_synchronize_tsc() to unconditionally set
kvm->arch.user_set_tsc =3D true globally for the VM when the very first vCPU
is created?

If user_set_tsc is set immediately at boot, does this break the 1-second TSC
slop protection for newly restored VMs, potentially leading to timekeeping
corruption and TSC jumps during live migration of young VMs?

> -	if (!vcpu->kvm->arch.use_master_clock)
> -		kvm_update_masterclock(vcpu->kvm, NULL);

[Severity: High]
By removing this synchronous update, are we deferring the
master_tsc_scaling_ratio updates to KVM_RUN?=20

If so, does this leave early KVM_GET_CLOCK requests with a stale ratio?

>  	vcpu_put(vcpu);

[ ... ]

> @@ -9849,18 +9849,47 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
[ ... ]
>  	kvm->arch.default_tsc_khz =3D max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns =3D APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info =3D true;
>  	kvm->arch.enable_pmu =3D enable_pmu && !kvm->arch.has_protected_pmu;
> =20
> +	kvm->arch.all_vcpus_matched_freq =3D true;
> +	kvm->arch.all_vcpus_matched_tsc =3D true;
> +	kvm->arch.cur_tsc_scaling_ratio =3D kvm_caps.default_tsc_scaling_ratio;
> +	kvm->arch.cur_tsc_khz =3D kvm->arch.default_tsc_khz;

[Severity: High]
Here we initialize cur_tsc_khz to default_tsc_khz, which might be scaled
if max_tsc_khz is configured on the host.

> +
> +	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
[ ... ]
> +	kvm->arch.cur_tsc_write =3D 0;
> +	kvm->arch.cur_tsc_offset =3D -(s64)kvmclock_host_tsc;

[Severity: High]
However, cur_tsc_offset is set to the unscaled -(s64)kvmclock_host_tsc here.

When the first vCPU is created, kvm_synchronize_tsc() sees
virtual_tsc_khz =3D=3D cur_tsc_khz. Will it then erroneously apply this uns=
caled
offset to a vCPU using a scaled multiplier, since we bypass the scaling that
kvm_compute_l1_tsc_offset() would have provided?

Could this lead to a large guest TSC jump at boot and cause timekeeping
corruption?

> +	kvm->arch.cur_tsc_nsec =3D kvmclock_ns;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D28
