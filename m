Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A831283E
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171970; cv=none; b=acMjypBhb57sfxxgwvdcxnR1ZJhwgLa7jTYgelKumbiR3tX1F8sfaEJPQC0WR+re+/q6WqVzxuBMw1JOqSSYg5dnDBqjqlZuobscOy1gJ3lCEfWpyotdVy33IFTJ0h/xERtucd1QSYUx/ubyh+SsT7Mr5gKQfMA0qdKviR4SWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171970; c=relaxed/simple;
	bh=QR/HHhLkMKnW42L6rN9A3n1RpneIbsffsRzsS2lB4ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=unlJdbjQ5a7ej6J6k84Xy3asOB6RRybFAqKpDkKUXTakcbqaqqUdaR3BsgkKI5OaA4paomM8TPYSRVBl3sppGd7ItCx93w12stBhc1Jy5hUvcz7txjjklBlsw6qPLoXicq6QhMeDV8afjCoTE2RvBCpv81uyMntiDaNFCs8RF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFZPJOyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFZPJOyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0718D1F000E9;
	Mon, 31 Aug 2026 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171969;
	bh=nuy2WiEJFPix1YZ5YD0HUBvadmJ9t2WiL0mG9Pj2eVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFZPJOyfgVChgh130w5MjxbM1cMbXoycm4EbF1aENRa9KQHw+Yg/Vts/tta0oI9xf
	 j2l84thoMCB7lY2ENjNUsO/p06GrXjXLYxWj8BBIUI79Gp6H72qgrtqf6ZKTcQ59TN
	 cd2ZO2Pcln0UKJKS9A7uESHpEhFj/LdCXn+P5BfnDXTSijDT1efrizQKlLbFA46VzC
	 pokIQYc6DnvGSdiTLtA4qHEWworrtjnKZogzCZ8o0zvRTWNJH9p9yXZp16xGFGePhy
	 rCq4KOZ4gvQJofUzqlLfIWCk3XANXEYJgwUZhdHmSk4BXWote6ftpDvWeU9QsjbNur
	 jPELFk9zB8ykA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] LoongArch: KVM: Implement vmid updating logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831094716.4016652-3-maobibo@loongson.cn>
References: <20260831094716.4016652-1-maobibo@loongson.cn>
 <20260831094716.4016652-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:26:08 +0000
Message-Id: <20260831102609.0718D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Precise single-GPA TLB flushes are replaced with full VMID realloc=
ations on page faults for CPUs with `cpu_has_guestid`.
- [High] Data race on the `tlb_flush_pending` bitmask between non-atomic an=
d atomic operations.
--

commit 79994ac14e7ca6c42512f0cad89100f577b61b57
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Implement vmid updating logic

This commit implements VMID updating logic for LoongArch, calculating VMIDs
on a per-CPU basis similar to ASIDs. It adds checks during vCPU scheduling =
to
ensure the VMID is valid against the globally cached VMID.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index a98f0284134a0..0099d0f0b8030 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
[ ... ]
> @@ -278,15 +281,54 @@ static void __kvm_check_vpid(struct kvm_vcpu *vcpu)
[ ... ]
> +static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
> +{
> +	int cpu;
> +	unsigned long ver, old, vmid;
> +
> +	/* On some machines like 3A5000, vmid needs the same with vpid */
> +	if (!cpu_has_guestid) {
> +		vmid =3D vcpu->arch.vpid & vpid_mask;
> +		if (vcpu->arch.tgid !=3D vmid) {
> +			vcpu->arch.tgid =3D vcpu->arch.vpid & vpid_mask;
> +			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		}
> +		return;
>  	}
> +
> +	cpu =3D smp_processor_id();
> +	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
> +		vcpu->kvm->arch.vmid[cpu] =3D 0;

[Severity: High]
Is there a risk of a data race on the tlb_flush_pending bitmask here?=20
In this function, we perform an atomic read-modify-write operation using=20
cpumask_test_and_clear_cpu(). However, kvm_arch_flush_remote_tlbs()=20
concurrently performs a non-atomic memory write using cpumask_setall()=20
on the same mask.

Mixing non-atomic stores with atomic operations on the same memory location=
=20
can lead to lost bit updates. If a remote TLB flush request is lost due to=
=20
this race, could a CPU continue executing with stale TLB entries?

> +
> +	/* Check if the vmid is out of an older version */
> +	ver =3D vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
> +	old =3D this_cpu_ptr(vcpu->kvm->arch.vmcs)->vmid_cache & ~vpid_mask;
> +	if (ver !=3D old)
> +		kvm_update_vmid(vcpu, cpu);
> +
> +	vcpu->arch.tgid =3D vcpu->kvm->arch.vmid[cpu] & vpid_mask;
>  }
> =20
>  void kvm_check_vpid(struct kvm_vcpu *vcpu)
[ ... ]
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa5328..e07ba28cc5655 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -893,7 +893,12 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsig=
ned long gpa, bool write)
>  		 * there is invalid tlb with small page
>  		 * need flush these invalid tlbs for current vcpu
>  		 */
> -		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +		if (!cpu_has_ptw) {
> +			if (!cpu_has_guestid)
> +				kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +			else
> +				cpumask_set_cpu(vcpu->cpu, &vcpu->kvm->arch.tlb_flush_pending);

[Severity: High]
Could this lead to a severe performance regression due to excessive TLB=20
flushes? By setting the tlb_flush_pending bit instead of issuing a precise=
=20
local single-page flush, this forces __kvm_check_vmid() to allocate a=20
completely new VMID for the vCPU.=20

This new VMID allocation causes the hardware to abandon all cached Stage 2=
=20
TLB entries associated with the old VMID. Doing this on every TLB Modified=
=20
exception (such as the first write to a tracked huge page) appears to=20
guarantee a 100% TLB miss rate for existing mappings.

> +		}
>  		++kvm->stat.hugepages;
>  	}  else if (kvm_pte_huge(*ptep) && write)
>  		ptep =3D kvm_split_huge(vcpu, ptep, gfn);
> @@ -929,8 +934,11 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsig=
ned long gpa, bool write, in
>  		 *
>  		 * With SW PTW, invalid TLB is added in TLB refill exception.
>  		 */
> -		vcpu->arch.flush_gpa =3D gpa;
> -		kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		if (!cpu_has_guestid) {
> +			vcpu->arch.flush_gpa =3D gpa;
> +			kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +		} else
> +			cpumask_set_cpu(vcpu->cpu, &vcpu->kvm->arch.tlb_flush_pending);

[Severity: High]
Similar to the huge page mapping case above, does replacing the precise=20
KVM_REQ_TLB_FLUSH_GPA request with the tlb_flush_pending bit cause a full=20
VMID cycle when mapping normal pages? If so, this would flush the entire=20
TLB for the VM on this CPU during routine page faults.

>  	}
> =20
>  	return 0;
> @@ -940,6 +948,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct=
 kvm_memory_slot *memslot)
>  {
>  }
> =20
> +int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
> +{
> +	/*
> +	 * Queue a TLB invalidation for each CPU to perform on next
> +	 * vcpu loading
> +	 */
> +	if (cpu_has_guestid) {
> +		cpumask_setall(&kvm->arch.tlb_flush_pending);

[Severity: High]
Is this non-atomic memory write to tlb_flush_pending safe against concurren=
t=20
atomic operations? As noted earlier, __kvm_check_vmid() uses the atomic=20
cpumask_test_and_clear_cpu() on this same mask. Mixing non-atomic stores=20
with atomic operations on the same memory location can cause data corruptio=
n=20
and lost updates.

> +		/* Be sure that other CPUS can watch the changes */
> +		smp_wmb();
> +	}
> +
> +	/* Return 1 continue to send ipi to running vCPUs */
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831094716.4016=
652-1-maobibo@loongson.cn?part=3D2
