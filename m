Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1036494B
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482059; cv=none; b=g3CROJZw5bixj1AkL5pIpqQoYvdrNNF5AK1f2OLK0gEofHJA2tS0SE5+oqxIbYDZuaO9pwTtCJXVWYP29Ts0Xeb53UmxkyGDtwu5n4cPik1iVN9chj4EPICXsK7G8Y3jZLYBXDecviZTn1wsNZfp4VSN6eSPTcqHFbmpE2kbiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482059; c=relaxed/simple;
	bh=MwggFFBVDOxQtoK4ZBJgCL+2W2iJJDwtunpFOasqig0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPWSgJvr4OMkcPW3AWHA7aJu0/SGJZsGLf67T48j1dafzwvCUMjerj85VFwtHFC9UUclhA2LPAI5cdthFJVQx/mur52xU6WfHGPZDJO12DFLWmcDA1Oov0WmbeEMuu0xGSW80IIr41lfAnjcAMKB/MVi/562HGM4UnuBkQBvCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o15ZCR2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o15ZCR2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFE61F00893;
	Wed,  3 Jun 2026 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482057;
	bh=fND6tOiAt5cQMV1Dq4qLEQtouvffQrg0Owhr4ApWs50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o15ZCR2as0rCxT0/DBQ5OtUL6tuAnovLVpZYtoDdy3D9Llao+LXNjEdR1wwgDmNc8
	 DlvIRwqbcXWriz1j+IFngHIU2z1Vvz5FNMbT4XgAwOXw6eB/Xil3ugWD3G72vpMw9l
	 AS9B1KEQjZ3UiAaynx/1/BNj5dpSDmLveR5hsq6oIE/RhAh3grIhlBLp8vXX1HNS0u
	 E33uvpYaR7nZXBtbA7IrZV2s22MggMtmC0v0Sg49A1BJh40muq8DV0kqrEz2GsGPBC
	 ZiSrQ4lJx4BGOo5mv+Wve/Oi4Rnt8/Ddr5Gq66KZBJtx/UMg+3+9uOZ5gtw84gHiem
	 +qawNY5YrtTRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] RISC-V: KVM: Add the split page cache for ioctl
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603175439237VrPTLz6fG79fXRYAu-JFW@zte.com.cn>
References: <20260603175439237VrPTLz6fG79fXRYAu-JFW@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:20:57 +0000
Message-Id: <20260603102057.AEFE61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Destruction of stage-2 PGD during `mmu_notifier_release` allow=
s vCPUs to execute with BARE mode stage-2 translation, granting guests full=
 access to host physical memory
- [High] NULL pointer dereference when enabling dirty logging after MMU des=
truction
--

commit 5935831ace6c3305e677dc574f5aeeda39b0da2a
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Add the split page cache for ioctl context

Add the split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl.

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270c..0676937bd9a1c 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -572,6 +573,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
> =20
>  	if (pgd)
>  		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
> +
> +	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }

[Severity: High]
This is a pre-existing issue, but can
kvm_arch_mmu_enable_log_dirty_pt_masked() trigger a NULL pointer dereference
after the PGD is freed here?

When a process exits, mmu_notifier_release() invokes kvm_riscv_mmu_free_pgd=
(),
which frees the stage-2 PGD and sets kvm->arch.pgd =3D NULL and
kvm->arch.pgd_levels =3D 0.

However, if the KVM VM file descriptor is still held open by another process
or thread, a subsequent KVM_CLEAR_DIRTY_LOG ioctl would call
kvm_arch_mmu_enable_log_dirty_pt_masked() in arch/riscv/kvm/mmu.c.

This unconditionally initializes the gstage and accesses the PGD via
kvm_riscv_gstage_get_leaf(). Since gstage->pgd_levels is 0, current_level
wraps around to UINT_MAX, and it dereferences gstage->pgd (which is NULL)
plus an out-of-bounds index.

> =20
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)

[Severity: Critical]
This is a pre-existing issue, but does freeing the stage-2 PGD during
mmu_notifier_release allow vCPUs to execute with BARE mode stage-2
translation?

If the VM file descriptor is kept open after kvm_riscv_mmu_free_pgd() sets
kvm->arch.pgd_phys =3D 0 and kvm->arch.pgd_levels =3D 0, another process ca=
n still
invoke KVM_RUN.

When the vCPU resumes, kvm_riscv_mmu_update_hgatp() in arch/riscv/kvm/mmu.c
programs the hgatp CSR using kvm_riscv_gstage_mode(0), which evaluates to
BARE mode:

arch/riscv/kvm/mmu.c:kvm_riscv_mmu_update_hgatp() {
	...
	unsigned long hgatp =3D kvm_riscv_gstage_mode(ka->pgd_levels)
			      << HGATP_MODE_SHIFT;

	hgatp |=3D (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
	hgatp |=3D (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;

	ncsr_write(CSR_HGATP, hgatp);
	...
}

With BARE mode stage-2 translation, the hardware treats guest physical
addresses as host physical addresses. Could this grant guests full access to
host physical memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603175256408L0=
jnqGs1cJGc0ijCdujci@zte.com.cn?part=3D1
