Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260453163E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790765; cv=none; b=CMEHyrsXGXTJMzJYLY/k7ZkLkeXuP0mv3TWutxG1x2gM2mbto5+Lt9xxgExtlisfAQ4Ou6MEOPbb6afGsAB+gymGyRpGwHae3xUoB+fB5Irjhw/JnT0/uFUVVTyp3DSIFxXBbY+djFK9Big+mMVSagWUhr9Z4NJIYK6Cl8O5U04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790765; c=relaxed/simple;
	bh=+tkc2jQJBnSXnTg4H7+LVNW4vf52MSbFUIjQcP86qjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rX+mmVTLmaEpXEiINmM0OHOsNVYiAp+4UvkEYO0hzW7WB3/Hn1X+QPGs2dYSIgIrsl5fawCjdVygk0FJy/P8gAPeUvYHI5+2vc/QKtgGjxqIaeNw6gJTgaIBBk2Po6vBcJYnIk9d6kJkENkmk4z2/g/Y7AQB9PDCBwENnAS9x/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdu3fD/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdu3fD/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FF71F00898;
	Wed, 30 Sep 2026 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790763;
	bh=C5X6tpUOufuTw7D4D3Uw3jq0DGNDmDB/tWACOJWbJas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qdu3fD/NN9mKzAyIOfL09fO2wmJzkophaBQvlmxnyb17MyJtEdxTtnixQa8H5oSsK
	 4bhdnKFrwUtRB6BOgctPdngZbn8qxpfHLHa81Ci5JgpuyPrVHpC7FkE/QryEAHZEYx
	 t8QAjruAwKmDuv9MSAwilr7eyTg1ZTrtcqcCTdc1c25aBK4PePDvhm6S8t8HlyY0w0
	 064YEphZJYu4C1PpTQxPB++cwrlfYc1yeqEMHyUOOK1j3DEztkbj1GMMn+Uez9p9Jb
	 AyZjDy5x9CT9zuV6mV6UAbTd/aw2K275WSUxYJ1shg/raeB864tlmaF8UVwbphvsj8
	 kIyPRjG6zMHDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable()
 around virtual-mode HPTE bit-lock users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930173750.56759-3-amachhiw@linux.ibm.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:52:42 +0000
Message-Id: <20260930175243.54FF71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: ppc: deadlock in lock_rmap() due to preemption guard in HPT h=
calls
- [Medium] kvm: ppc: resize_hpt_rehash_hpte() spins with preemption disabled
--

commit 68aaf6c48f58de2d582ba27ebef746d63f655779
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-loc=
k users

This patch adds preemption disable guards around virtual-mode HPTE bit-lock
users in KVM PPC. This prevents situations where a lock-holding thread
gets preempted, starving other threads spinning on the same lock.

> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 2ccb3d138f46c..59da958e09cb4 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c

[ ... ]

> @@ -1219,6 +1229,7 @@ static unsigned long resize_hpt_rehash_hpte(struct =
kvm_resize_hpt *resize,
>  	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
>  		return 0; /* nothing to do */
> =20
> +	preempt_disable();
>  	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>  		cpu_relax();
> =20

[Severity: Medium]
The commit message states: "On failed lock acquisition the guard is released
before the cpu_relax() spin so the lock owner can be scheduled."

Does this unconditional spin with preemption disabled violate that
description?

[ ... ]

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index aa51968e206a7..0b7743bb89d9a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  	case H_CLEAR_REF:
>  	case H_PROTECT:
>  	case H_BULK_REMOVE:
> +		preempt_disable();
>  		idx =3D srcu_read_lock(&kvm->srcu);
>  		ret =3D kvmppc_pseries_do_hpt_hcall(vcpu, req);
>  		srcu_read_unlock(&kvm->srcu, idx);
> +		preempt_enable();
>  		if (ret =3D=3D H_TOO_HARD)
>  			return RESUME_HOST;
>  		break;

[Severity: High]
Does this preemption guard create a permanent deadlock with lock_rmap()?

For example, a host thread executing kvm_test_clear_dirty_npages() or
kvm_unmap_rmapp() acquires lock_rmap() with preemption enabled:

arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_clear_dirty_npages() {
    ...
    retry:
        lock_rmap(rmapp);
    ...
}

If the host thread is preempted while holding the bit-lock, and a VCPU
thread for the same guest is scheduled on the same CPU, it can execute an
H_ENTER hypercall.

When the VCPU thread reaches kvmppc_do_h_enter(), it attempts to acquire
the same rmap lock:

arch/powerpc/kvm/book3s_hv_rm_mmu.c:kvmppc_do_h_enter() {
    ...
    if (realmode)
        rmap =3D real_vmalloc_addr(rmap);
    lock_rmap(rmap);
    ...
}

Since preemption is now disabled across the entire hcall by this patch,
the VCPU thread could spin indefinitely on contention. It would never yield
the CPU, meaning the preempted host thread could never resume to release
the lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930173750.5675=
9-1-amachhiw@linux.ibm.com?part=3D2
