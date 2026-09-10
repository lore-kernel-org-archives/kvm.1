Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAB34F255
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053961; cv=none; b=f8CztaKyUKG0N2M+7oiQFZodMSpvmyWW7Fq8JTgkVk8ObdfHKYcNZdGieWW7B+tkozuu0Wc3s7Pshl6PMbHzGpkhrnK3HmTzThoxWyo1+brhviudXZ5Hfz6WYrwbmWpmYwoyB+8q7Dk3qCRUp4XUEHImuXbAtUSXpuqA7HofjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053961; c=relaxed/simple;
	bh=iVHagnSj52SSDGfWURYA7aZ0jsmXs7SEp2cys4WB3Nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBHq91lnjYyNjjiuIDA2lVEiNTDF+hWeiF0q59zRnvfoEqGFVjuSIKq1R6AVTAHAwnHKd0sWLJxF4UNsfZ36GuGR43k53pmQdtbzqSC3l2irklsiVjgPPijv5BfatKhOCWqbrh30ppDDCzvQi7LGZdPrJbtJzOg5ouufhQClo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUxVEcu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUxVEcu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8504E1F000FF;
	Thu, 10 Sep 2026 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053959;
	bh=a1P5yuhAThkPH9p7+kQC4YGisEhAZ4B6kbnlFW12LJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KUxVEcu2dlfEugLZ1mwsIkBCVBVB7XcHRfnSprCSPZUbkAzBo3zCkaFy+1dSfGIMA
	 DVIEdkkEZ60+vkYWil/ujGS5ItvuxwUeebdQZcji9k2WnJWpHgdy+mk/meCeY7RwTU
	 83EabbcAVpMD5eRUIJDAK/T83eoWuPyZCmGnMDujAM1usXeEZN10CAkG86lWiwIBa/
	 qcCskBaIaTWoG0iZImkg+6MrWNA8nwohLQaEPXHpPiQfjiGH4OUFVvLIFAfFYvtMY3
	 tEeWzWTKLlklQPNGcomk3giztRI3ZRjKHIR9BNEM2qo9UlSMzODeQvDPSimDT4KKbf
	 DjjwwqCOWjDlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Avoid synchronous IPIs on VMID rollover
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenlong Li" <wenlongli486@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910151227.986678-1-wenlongli486@gmail.com>
References: <20260910151227.986678-1-wenlongli486@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 15:25:59 +0000
Message-Id: <20260910152559.8504E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Race condition during VMID rollover allows vCPU to enter guest=
 with stale hardware VMID, breaking memory isolation.
--

commit f9683a31ea50a94b9a73a513d36b5718f5b167c1
Author: Wenlong Li <wenlongli486@gmail.com>
RISC-V: KVM: Avoid synchronous IPIs on VMID rollover

This commit makes VMID rollover lazy to avoid synchronous cross-CPU IPIs on
all online CPUs. It tracks active and reserved software VMIDs, performing
pending local HFENCE.GVMAs on the next VMID activation before guest entry.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e062ca19f9d8f..85542c1a5ec3f 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -943,14 +943,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  			continue;
>  		ret =3D 1;
> =20
> -		kvm_riscv_gstage_vmid_update(vcpu);
> -
>  		ret =3D kvm_riscv_check_vcpu_requests(vcpu);
>  		if (ret <=3D 0)
>  			continue;
> =20
>  		preempt_disable();
> =20
> +		kvm_riscv_gstage_vmid_update(vcpu);
> +

[Severity: Critical]
Does moving kvm_riscv_gstage_vmid_update() after kvm_riscv_check_vcpu_reque=
sts()
create a window where a vCPU misses a pending request?

Later in kvm_arch_vcpu_ioctl_run(), the vCPU checks for pending requests:

    if (kvm_riscv_gstage_vmid_ver_changed(&vcpu->kvm->arch.vmid) ||
        kvm_request_pending(vcpu) ||
        xfer_to_guest_mode_work_pending()) {
        vcpu->mode =3D OUTSIDE_GUEST_MODE;

If another vCPU updates the shared VMID generation locklessly,
kvm_request_pending() can evaluate to false here if the KVM_REQ_UPDATE_HGATP
request from the other vCPU has not yet been written. This would allow the
vCPU to enter the guest with a stale hardware VMID.

>  		/* Update AIA HW state before entering guest */
>  		ret =3D kvm_riscv_vcpu_aia_update(vcpu);

[ ... ]

> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index c15bdb1dd8bef..7b86a6fbe4a69 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -201,31 +201,31 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *=
vcpu)

[ ... ]

> +	/*
> +	 * Publish the CPU-local active identity only after the required
> +	 * local invalidation is complete.
> +	 */
> +	atomic64_set(active, vmid);
> +
> +	raw_spin_unlock_irqrestore(&vmid_lock, flags);

[Severity: Critical]
Is it safe to update the admission state and drop the lock here before=20
issuing the HGATP update request?

If the current vCPU drops the lock, another vCPU can observe the new=20
generation, update its own admission state, and bypass the=20
KVM_REQ_UPDATE_HGATP check since the request has not yet been made. The=20
second vCPU would then proceed to enter the guest.

> +
> +	/*
> +	 * A new software VMID may contain a different hardware VMID, so
> +	 * request an HGATP update for every vCPU in the VM.
> +	 */
> +	if (vmid_changed) {
> +		kvm_for_each_vcpu(i, v, vcpu->kvm)
> +			kvm_make_request(KVM_REQ_UPDATE_HGATP, v);
>  	}

[Severity: Critical]
Since this cross-vCPU request is issued locklessly, can this cause a=20
regression where two VMs might share the same hardware VMID?

Because the second vCPU mentioned above advertises the new VMID in its=20
admission state but still runs with the old hardware VMID in the guest, the=
=20
old hardware VMID is no longer protected. It could be immediately=20
reallocated to another VM, breaking spatial isolation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910151227.9866=
78-1-wenlongli486@gmail.com?part=3D1
