Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB14156F45
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983426; cv=none; b=fQsbxThO3fKLshbWAnD0YSnwz7k1RYFEFqKpPhR72RLb805sdbpI6yz7U2P9GpvpzfHJKQ50edYZoDuZwCMF6hKLHji5wu/zQ8xIqqG8c9NZxzbP7ezLW4ChS4RfEErARrBEE6SFd8rhKq9ijQFv3n6xj/6l180kGIjST/v53wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983426; c=relaxed/simple;
	bh=zqD/z9iVjls17mwDkY6SAPrCWX3+f7BQp+HfSlu1jPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzzkL9OONsLG85lqpuebbvaXQCZYRLYVHt3Tm4zA/tkzueMMTHblOJ9ZSkF6Z/ZJPmTDlBiJW+Y80BPUNX/9jyYDuG7r3rvMRg+lSPBDVGP5exYc9R6PuP3KJRDsPar3FEyMcfyeIsIF5N6iSTYZFzR+XIUQiQc0THmrOgec6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq0rh3tJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq0rh3tJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACCE1F000E9;
	Thu,  6 Aug 2026 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983424;
	bh=ahU4rT8f/kfZ94ds9W58XuYRmaRnXgBWnogsXlekMzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lq0rh3tJftkcKfkoyX4/mPWi9SraimoCCHMfhq1qaJn/g0XeAw5y1roH3Hb6AY+ts
	 +wLm/gWS/mD2/P+iuq4pUVMJHKtWbLqmVWzVfn5bPkuxAdg4nIDB1WlSXvmfkElP8u
	 pnJiAyCE12PSsW1qAcwcrMlkfRWhcplYG7WRLIEYzHKDtkTo89mU0SUgfajQRsYEqk
	 0sG2+bbV1xLKQ4UH0shx1pD7aRIpSdsfeDfou3ZexpA14vS9AM/xsUXVbSGhZlpWha
	 jb+YzNdOicblea6pp479ZS18AoBT9ArQoDQEvxPWGXnSA4KgjONznbE9ZbH+RFZQp3
	 N3XyYGVII/6Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] LoongArch: KVM: Implement vmid updating logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806020739.2149268-5-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:30:23 +0000
Message-Id: <20260806023024.7ACCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing early return in `__kvm_check_vmid` for machines without gu=
est ID support breaks VMID/VPID synchronization.
- [Medium] Data race between non-atomic `cpumask_setall()` and atomic bitwi=
se operations on `tlb_flush_pending`.
- [Low] Dead code: `kvm_arch_flush_remote_tlbs_memslot` is a fictitious arc=
h hook not called by KVM core.
--

--- Patch [4]: [PATCH v2 4/5] LoongArch: KVM: Implement vmid updating logic=
 ---
commit 1626f2256d93ca3c5c607a6a950ca7531c03169a
Author: Bibo Mao <maobibo@loongson.cn>
Date:   Thu Aug 6 02:07:38 2026 +0000

    LoongArch: KVM: Implement vmid updating logic
   =20
    VMID calculation method is the same with ASID on LoongArch, it is
    percpu vmid calculation method. For every physical CPU, VMID of
    different VM is different, and it is the same for different vCPUs
    of the same VM.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index c36e62ab0d917..72c1d23156e50 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
[ ... ]
> @@ -291,6 +316,20 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
>  			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>  		}
>  	}
> +
> +	cpu =3D smp_processor_id();
> +	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
> +		vcpu->kvm->arch.vmid[cpu] =3D 0;
> +
> +	/*
> +	 * Check if our vmid is of an older version
> +	 */
> +	ver =3D vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
> +	old =3D this_cpu_ptr(vcpu->kvm->arch.vmcs)->vmid_cache & ~vpid_mask;
> +	if (ver !=3D old)
> +		kvm_update_vmid(vcpu, cpu);
> +
> +	vcpu->arch.hw_vmid =3D vcpu->kvm->arch.vmid[cpu] & vpid_mask;

[Severity: High]
Does this unconditionally overwrite vcpu->arch.hw_vmid for machines without
guest ID support? On machines like 3A5000, hw_vmid is set to match vpid
above, but without an early return or else block, it falls through and gets
overwritten here with a dynamically allocated vmid.

>  }
> =20
>  void kvm_check_vpid(struct kvm_vcpu *vcpu)
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index 714640a2e6142..80e7a8bdc344a 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
[ ... ]
> @@ -942,6 +943,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct=
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

[Severity: Medium]
Could calling cpumask_setall() cause a data race with concurrent atomic
bit operations?=20

cpumask_setall() uses a non-atomic memset() internally, while
__kvm_check_vmid() and kvm_handle_mm_fault() use atomic read-modify-write
operations like cpumask_test_and_clear_cpu() and cpumask_set_cpu() on the
same cpumask.

> +		/* Be sure that other CPUS can watch the changes */
> +		smp_wmb();
> +	}
> +
> +	/* Return 1 continue to send ipi to running vCPUs */
> +	return 1;
> +}
> +
> +void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
> +					const struct kvm_memory_slot *memslot)
> +{
> +	kvm_flush_remote_tlbs(kvm);
> +}

[Severity: Low]
Is kvm_arch_flush_remote_tlbs_memslot() dead code? There does not appear to=
 be
a KVM core hook by this name, so this architecture-specific function won't =
be
called by the KVM core during memslot updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806020739.2149=
268-1-maobibo@loongson.cn?part=3D4
