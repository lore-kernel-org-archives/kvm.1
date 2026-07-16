Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE42D59E8;
	Thu, 16 Jul 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185080; cv=none; b=WF2RYJC26iCuuJ+hWZXL4uTCnyV6oJzOHpDUqxGZWLXKnB0xMpyDapHqxfGy7lWhxhmZ8yfM1IFcoxKf4hOC52uRZEE0Z7b3LeRw4EFqoxAlN0ljass8Bp6JI7U4IiYh7MoLSDlP8I9NR99cEH/iZZhgMWb4shM+qfBwtK4h2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185080; c=relaxed/simple;
	bh=srJ/3g4KEaTGpwoCotGl56p8vv2YEVYPO6lGXmFWfb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGVY/mGyp4GTmENIwSMejry8KRI/82UyQL3ykj2qdkNhxXO0M2e/9h1Mt5Oi8nW8ncaimbRG60Bj8sj4iS1vGQMeQmoBwhPByJkpmMlVXZd3D3b4hNxw6uLAxu3m6TesIrtMV3rBBsGsH9FoMC96Q+lFr6YhTPs6ZAnUbmTobLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXKAfbsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXKAfbsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9461F000E9;
	Thu, 16 Jul 2026 06:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784185078;
	bh=lXWjQrv0O336LlV97/OEJZN+TLRP32cXFFg4W5AvGqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXKAfbsiJkR2xhHkuWfFBE4JX0egad8Kj7KCzfrA5Vzm5aEk27pGzDJrr/xisUknQ
	 Bw+BkWNKV0HqZpbDix7Rqq1p8b4UT+CE792YDnp/z3wQroI/XjnGoCjcSyRSqUk2YK
	 yj50vv1sb5rJDh8eFhADLk59clVdCxfKD9VAgLGJWgRs6EmnBcdnrA0tYSdWy0nxQi
	 Gr75tTkJvNJDlzbIe5WoZMG3RGUsUQCpaakIaYd5tCKorV7RpvYopm9JTSRWosvwDH
	 hxakgpNLP6yMcAbuA7AoE1xtA3znLEaQEidEltQfQknKTiL4JdMqgCQlqQuK5t8ZcQ
	 MT6TJlYka/aQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical
 section
Reply-To: sashiko-reviews@lists.linux.dev
To: yhchen312@gmail.com
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260716064011.2387501-1-yhchen312@gmail.com>
References: <20260716064011.2387501-1-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 06:57:57 +0000
Message-Id: <20260716065758.4A9461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition during VMID rollover allows a vCPU to transient=
ly execute in guest mode with a stale VMID, compromising cross-VM isolation.
- [High] Integer overflow in the VMID generation counter (vmid_version) on =
32-bit systems causes a cross-VM isolation break.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critic=
al section ---
commit 7d899ea43321661351b3cdd958ba47c38d85eeed
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: Use raw_spinlock for VMID update critical section

This commit converts the vmid_lock to a raw_spinlock_t to prevent
preemption during the VMID update section under PREEMPT_RT. The update
path performs an IPI broadcast which requires preemption to be disabled.

> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index 3b426c800480c..33efde4bb9d75 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -20,7 +20,7 @@
>  static unsigned long vmid_version =3D 1;
>  static unsigned long vmid_next;
>  static unsigned long vmid_bits __ro_after_init;
> -static DEFINE_SPINLOCK(vmid_lock);
> +static DEFINE_RAW_SPINLOCK(vmid_lock);
> =20
>  void __init kvm_riscv_gstage_vmid_detect(void)
>  {

[Severity: High]
This is a pre-existing issue, but does this unsigned long counter present an
overflow risk on 32-bit systems?

If a host user rapidly creates and destroys VMs, the 32-bit vmid_version co=
uld
wrap back to 0. Since a new VM's kvm_vmid struct is zero-initialized,
kvm_riscv_gstage_vmid_ver_changed() would evaluate (0 !=3D 0) as false:

kvm_riscv_gstage_vmid_ver_changed() {
    ...
    return unlikely(READ_ONCE(vmid->vmid_version) !=3D
                    READ_ONCE(vmid_version));
}

Could this cause multiple new VMs to share VMID 0, breaking cross-VM isolat=
ion
by allowing their memory accesses to hit each other's TLB entries?

[ ... ]

> @@ -118,7 +118,7 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vc=
pu)
> =20
>  	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
> =20
> -	spin_unlock(&vmid_lock);
> +	raw_spin_unlock(&vmid_lock);
> =20
>  	/* Request G-stage page table update for all VCPUs */
>  	kvm_for_each_vcpu(i, v, vcpu->kvm)
>  		kvm_make_request(KVM_REQ_UPDATE_HGATP, v);

[Severity: Critical]
This isn't a bug introduced by this patch, but does dropping the lock before
making the requests open a race window?

If the lock is released after updating vmid_version but before setting
KVM_REQ_UPDATE_HGATP, could a concurrent vCPU from the same VM observe the
new vmid_version without the lock?

If it sees no pending requests, it might proceed to enter the guest with a
stale VMID. If a global VMID rollover just occurred, could this stale VMID
have been re-assigned to a different VM, causing an isolation break?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716064011.2387=
501-1-yhchen312@gmail.com?part=3D1
