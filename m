Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE003414A1E
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620424; cv=none; b=vEOK5Ez4G2AoioFdHJ6qJTr/7/5iINcikakMK9U84URy6Apv4ls89d6jwcIf/BHSAu4O0e6lJJBr3UZeZACw5otnEmgNbyFRvxNWQflr/shZNEs9P7L2JGUvV4t/s93gBZUiH4lg/bhNgq4bmTpF11LLFUUyTWn/3bJdviFASjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620424; c=relaxed/simple;
	bh=3RwulrDbloP3GjEXKjhnZRdb/j3U0lMT2nyytojDJkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GdcIWJrnNb4ppnPFXa1FMhfjYZhPBp/jE/h25IoBRZCzTGV28gYb3tNlUPx+VuD20s0uQTANMBJtAICtZexOGRT8ZJ1zuG5uXfffYEaeenS3EOb/rsihl5Ao5VAdEh6LBjPpvQlX8A6TcLqmn6NsYhbZGsVCxOK5HGUv6CTSwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpSNJ8fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpSNJ8fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279D01F00A3A;
	Tue, 21 Jul 2026 07:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620422;
	bh=rA1MGmHq2Ddpo+SDCMd4Xy7DfNYV/CK1Eb67xPMCT2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpSNJ8fbYPixX6wnV9T31OPtCrJFkXRW5lAMxBDQJDfFt6+XVHo8hrfAOYExgcKxg
	 hNJ/GlAV90E+gokPMlI9ASADQWYflky/eA1uk45/jf/W4i+9Mesf6I2BlYIH3spH78
	 IcYs0cy6uVr4scPE5S7odo2Ky0kAqsMJcDLlcjGulzM7eyWEnMuYFZEFN1JQ336udO
	 0prF7xBzfr6D9j9IB/g1vaJTQ0tFXcGjvzWAA81/PFhccX9kQgtld0x6x7q3R+Rb30
	 ZQMa6IQGU53+C3wq00x1pnQYHyqxM5D5bg5cobujrutv2p4+RMBnExM0HjgHr3/ds2
	 bxa0WSncvYgDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260721073612.137259-1-xb@ultrarisc.com>
References: <20260721073612.137259-1-xb@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:53:41 +0000
Message-Id: <20260721075342.279D01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Uninterruptible `mutex_lock` in device ioctl causes unkillable tas=
k hang.

Pre-existing issues:
- [High] Hardware state corruption due to missing CPU check in `kvm_riscv_v=
cpu_aia_imsic_put()`.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU mi=
gration ---
commit 477c5bd7ef196223bb86313755b20f69e286864b
Author: Xie Bo <xb@ultrarisc.com>
RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

KVM device ioctls are not serialized against KVM_RUN. This patch serializes
the entire IMSIC attribute operation with the target vCPU mutex to prevent
the VS-file from being migrated and recycled until the attribute access
completes.

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de0834c5..2a4f88efee17f 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -969,9 +969,13 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>  	if (!vcpu)
>  		return -ENODEV;
> =20
> +	mutex_lock(&vcpu->mutex);

[Severity: High]
Does this uninterruptible mutex_lock() cause an unkillable task hang if the
target vCPU is currently executing a guest via KVM_RUN and holding its
vcpu->mutex?

Since it is reachable by userspace via KVM_SET_DEVICE_ATTR or
KVM_GET_DEVICE_ATTR, could a user program racing with KVM_RUN block
indefinitely in D-state?

Should this use mutex_lock_killable() instead to prevent a local denial
of service that triggers the hung task watchdog?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at
kvm_riscv_vcpu_aia_imsic_put(), does it blindly set CSR_HGEIE on the local
CPU without verifying that imsic->vsfile_cpu matches the current
smp_processor_id()?

arch/riscv/kvm/aia_imsic.c:kvm_riscv_vcpu_aia_imsic_put() {
    ...
    if (imsic->vsfile_cpu > -1)
        csr_set(CSR_HGEIE, BIT(imsic->vsfile_hgei));
    ...
}

If a vCPU blocks in kvm_vcpu_block(), it can be migrated to a different CPU
upon wakeup. If it loops and sleeps again without returning to KVM_RUN
(where imsic->vsfile_cpu is updated), kvm_sched_out() will be invoked on the
new CPU.

Could this call kvm_riscv_vcpu_aia_imsic_put() and write to CSR_HGEIE on the
new CPU using imsic->vsfile_hgei allocated for the old CPU, resulting in
cross-CPU hardware state corruption affecting interrupts of other KVM guest=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721073612.1372=
59-1-xb@ultrarisc.com?part=3D1
