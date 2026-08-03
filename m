Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA627A92D
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796663; cv=none; b=uy6e6rU0lbn0wYkZs5+265aRVML7ye8EXYJJgfNGhsCTz9sY4a5yCAlp/Bwef3aE3vL3ZfD/OvX3Ock63iPxWzcHJDP8zScG4p2NTu7lTKFK2YK6c+SwEkPfT9Vab3IsWMh7n54s1wZ8QhJ+JvrDHiXTXQx7pyGsP61DgKSo/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796663; c=relaxed/simple;
	bh=6k5d/yGVFzN5oLPDHAYgfPWngvlHeA/j76H+mwv3EJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEOvPq2paEdxWbpmEZYE5DtSFnfVzNiGmKWOmE6dHzbsX88oIc9yEGwBNxoDoKCP7yb2Y2XQBZo3CBJ15gRVBqdDlrm/vko75HHeaInkkpMQsb8WKc4Fjm3n4nLEzVFHAMMsilo17gKGIAPpnlvRy/+jcgjDpGi+msRo502gRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV2XuSU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV2XuSU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C19C1F00A3A;
	Mon,  3 Aug 2026 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796662;
	bh=rsJo1UVgls1GOnJ0Rget9IC/DdzO7BV9Mk8ioiFF++E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dV2XuSU/69ffloKeolYHRmlVXGjV6iPDWRtlsunXkBSm2KD89geQPogMAKEwUTw9z
	 cFh3n+Dodtz0bJ1IqtK/Sx621wmrXtcgosnpR6XwHjsxQNRp9C4+ZFFFm8vj0o2NO3
	 RLpi+LIgi0qu6Yj9aUwe0rzEqbb/ugvn90PvL9kkuQxe0pWfFj6XpLPCUOJOCGPnyA
	 bHHlQ4Ms9eA1MfSodkdNlWiS5E1iDElYXt4XbTDgn/ACsSFe7n1Dc6YomEKrAfsnyC
	 kMURB4LaQCZdWdksl9xU3XSLN8NHpwbkJABE2Cc3eu7nISeFnJnO54snqHtK+AOg7a
	 I92gDZ/Eurc0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] RISC-V: KVM: fix vcpu vector context handling
 for kernel-mode vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803215250.824417-4-tchiu@tenstorrent.com>
References: <20260803215250.824417-1-tchiu@tenstorrent.com>
 <20260803215250.824417-4-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:37:41 +0000
Message-Id: <20260803223742.0C19C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preemptible kernel-mode vector (KMV) state is corrupted by KVM pre=
empt notifiers when a VCPU thread is preempted.
--

--- Patch [3]: [PATCH v5 3/3] RISC-V: KVM: fix vcpu vector context handling=
 for kernel-mode vector ---
commit 077b610f9ed223f15b05bd83c13e358e4b341dc9
Author: Andy Chiu <tchiu@tenstorrent.com>

RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
   =20
This commit registers an RCU-protected callback to flush the vCPU vector
context when kernel-mode vector (KMV) is serving a guest. This prevents
KMV from misattributing the guest's vCPU context as the user's context.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
[ ... ]
> @@ -654,9 +656,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
> =20
>  	kvm_riscv_vcpu_timer_save(vcpu);
> +	get_cpu_vector_context();
>  	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
>  					 vcpu->arch.isa);
>  	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);

[Severity: High]
This is a pre-existing issue, but does unconditionally restoring the host=20
vector context here corrupt the kernel-mode vector state if the vCPU thread
is preempted?

If a vCPU thread enters a kernel-mode vector section (like
enter_vector_usercopy() during guest I/O) and is preempted by a page fault,
kvm_sched_out() calls kvm_arch_vcpu_put(). This unconditionally restores the
host (QEMU) vector registers via kvm_riscv_vcpu_host_vector_restore().

When switch_to() subsequently calls __switch_to_vector(), wouldn't it save
this newly clobbered hardware state into the kernel's vector context buffer
(kernel_vstate) instead of the actual kernel vector state?

Could a malicious guest trigger this by supplying an unmapped virtual addre=
ss
for an I/O operation, forcing a page fault and voluntary preemption during
the vector-optimized copy_to_user()?

> +	put_cpu_vector_context();
> =20
>  	if (kvm_riscv_nacl_available()) {
>  		nsh =3D nacl_shmem();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803215250.8244=
17-1-tchiu@tenstorrent.com?part=3D3
