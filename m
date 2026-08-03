Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204521DFFB
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766497; cv=none; b=cffPCGFWPAW5pwSdV28GrJsVyexwudNXDBQKYebHO2cYmMHdSOMSgBCuIS1oewnNKBwXVVkxD2XNru+/GcptMIdH0lMlatObwuNNYDNzDwoXa1EdO5DvfDkttncIZuuAb5x/MwDc+Zo9mA2wTGcx7X6BLHJQWMO6EU621x0FDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766497; c=relaxed/simple;
	bh=aJeVpm/Iog+ttCrwtI2lyoNLFBoJTVBZji3LN2VUlvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q97RviyhyuCpRzYZ/il6m4TtMEWs1xHwr299jK4sB1cNpnoyEFZ7bLRkhf6cGNW31AZOxW+O2kz1/i8fWtQPCuZdYPWAP6Cph22xwgL+NjGyn8pUJPdy6d7bcztaAYhCKcxx74XPGuLjcsbsetskcpe7hyNV1+Xwu5dr9ixJ/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDdb25Of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDdb25Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AEB1F000E9;
	Mon,  3 Aug 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766495;
	bh=OVtt8IliwN1VS45O1RWE9NlKn+SeRdNzh7YOy3WlDN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDdb25Of5VFj+AwoOxhlUHNn6tJwE+MNOIlZfl//DoT0wrsJhCkn7LeuGf4BVGCbF
	 e2a/JxCZL7/5M/9tzDeDyv6cqm5CfGLIJGQVy04naXdwA+t5J32JgDMP1+MN6WJbrG
	 4NdOlm0xfTOpbRjLIZsKBkZTo0JQSXQl15vxWpEI5A0eYEBOvVf24fGFUEF7DIyT0R
	 waACHtIBXij+pxH/uaeboAXJ+VM1GMxM2FPrgoTJIAAoyvMZaKJJZhJXhO/Wx7bq4z
	 oHVL8rGDxoH00Ofzsc4A+qveyoaVcQt1QnyBHhiC2XdYrzQYxfgCGn3eKcAuQauztU
	 RJG6o6odD3MhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: KVM: Flush VS-stage stale entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guo Ren" <guoren@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803135454.2726112-1-guoren@kernel.org>
References: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
 <20260803135454.2726112-1-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:14:53 +0000
Message-Id: <20260803141455.01AEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Direct execution of the raw HFENCE.VVMA instruction in kvm_riscv_m=
mu_update_hgatp() bypasses the Nested Acceleration (NACL) shared memory mec=
hanism, breaking nested virtualization.

Pre-existing issues:
- [Critical] The VS-stage TLB flush condition `last_exit_cpu !=3D cpu` is i=
ncomplete, skipping necessary flushes during VMID rollover, `vmid_bits =3D=
=3D 0` configurations, and same-VM vCPU interleaving on the same physical C=
PU.
--

--- Patch [1]: [PATCH] riscv: KVM: Flush VS-stage stale entries ---
commit f1e080e98f0df465d2cf4d51c2026f9bf9cd7c71
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

riscv: KVM: Flush VS-stage stale entries

When a vCPU migrates to a different host CPU, the new CPU may retain
stale VS-stage TLB entries (GVA -> GPA) left by a previous run of the
same guest. This patch issues an HFENCE.VVMA inside
kvm_riscv_mmu_update_hgatp() whenever the vCPU is loaded on a CPU
different from the one it last exited on.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..8eae1805442ba 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -719,4 +719,7 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> =20
>  	if (!kvm_riscv_gstage_vmid_bits())
>  		kvm_riscv_local_hfence_gvma_all();
> +
> +	if (vcpu->arch.last_exit_cpu !=3D cpu)

[Severity: Critical]
This is a pre-existing issue, but does this condition properly flush VS-sta=
ge
TLB entries during VMID rollover, configurations where vmid_bits is 0, or w=
hen
interleaving different VMs on the same physical CPU?

If a vCPU switches VMs on the same physical CPU, last_exit_cpu will still
equal cpu and skip the flush. Since HFENCE.GVMA issued during rollover or VM
switch does not guarantee flushing of VS-stage entries, could the incoming
vCPU inherit the previous VM's stale VS-stage mappings?

> +		asm volatile(HFENCE_VVMA(zero, zero) : : : "memory");

[Severity: High]
Does executing the raw HFENCE.VVMA instruction bypass the Nested Accelerati=
on
(NACL) shared memory mechanism?

When executing as an L1 guest with NACL enabled, ncsr_write(CSR_HGATP, hgat=
p)
only updates KVM's shared memory page with L0, not the physical CSR. Since =
the
direct HFENCE.VVMA instruction is executed immediately after on the physical
core, does it flush the TLB using the old (stale) VMID still present in the
physical CSR?

Additionally, if no flush request is enqueued into the NACL shared memory v=
ia
nacl_hfence_vvma_all(), will the L0 hypervisor fail to perform the flush for
the new VMID before switching to the L2 guest?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803135454.2726=
112-1-guoren@kernel.org?part=3D1
