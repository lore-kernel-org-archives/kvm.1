Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426240;
	b=RWXq+CokNZQ5vhYDeXDmcrF0fhSJN94q6bjJPITUhFd+LNNDgv7yiRG5aXOlcPG4jvww
	 SdW0GRfdGUNEK3hWigKkquCxKHO3gEqXeqvLvaDpfN369e3Fn0S0x5Gc51T44nBohf9HP
	 kfo2i/KmxCXVprH5cSbcwt6QepUrV7yYJn4f/Q5w+xlLCfxUZ2GhHIL1q3qDVC+H9Wwva
	 SoQUsGdNSj+cBB0kE6N0EhwBDg3w2Q+bpHd2Gacf0QiNfxavLu+ntxyx927plX/15fTPl
	 yP1VWwkYJJsqw/ai4U8FkXnCRGl8x+3JB/R628FefOT45Hm11yo5RvOqac3XqExFqwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=budKP17OwFpdBQY/FY4KHSRQH4SY6H0NSDw4Kjt/VrQ=;
	b=SBjJ/U3+hyNmeo1uYutHTEmzXskVf4SB66XfKFBLLtyJ7a0Nd1iGzLR10jz+tp+4s5lW
	 XjijKIjvVdloDOi2UCpieaZ2L/BRB15Sh8SUd9zlDmClYQw1Ig4j4zfTrJuxVq2h6qfZI
	 Qc5eJM7QjWGoG+qD3omobYe3QjR5cVz4FF8+sl5hiEd+iYd4bVEDBSy20awiNSJuq8L90
	 biP5WSgHcRjQ7AYpQbmavoOcVSLJTVUid3oYpbCZ7APTYYpEwmYX+zUfbDx9q++wOed9s
	 d0b346f2hWPg7zUYOLRU/Y+z2FNc0QOgmUmS+09jARVQl8ZuCH9YuJJVcyPc/Amdiug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+UdCnmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08178606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+UdCnmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F81F00A05;
	Wed, 11 Nov 2026 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426239;
	bh=budKP17OwFpdBQY/FY4KHSRQH4SY6H0NSDw4Kjt/VrQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=k+UdCnmOUFkuzw+tr6OgrKX6lOmpX/gParYbJE1lZ/pk0k78EuvB1GoXTxyF81WoP
	 mZLnLkHkQOvVr8QJoylcHyqKeroi2pGoS9bAwoF2IU4dzhjFzWmC92vsS2VUzQhL6H
	 L0FXmlH3U+lhdbXauosN+wTajZ/vKTtcne0LKk1ptsaNDEToXZoF41j3aAVPgC+hqM
	 yhxSMlggPbSnMs5fBp2ztCKxepeiYeVhV2JZiANuH/l1RzdWCWkZsELxJeN7QYyGAs
	 nIfVUArRMIO2WO2Q2//cRxYXj7LdQFd1X856+yPYmjiBrva52vO3GvrXLjivh+fvX9
	 24doOMwnmMwMw==
Message-ID: <sashiko-outbox-209589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/26] KVM: x86: Replace nr_vcpus_matched_tsc count
 with all_vcpus_matched_tsc bool
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261111180922.4177927-4-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
 <20261111180922.4177927-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:43:59 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: x86: race clearing matched TSC state in
  kvm_arch_vcpu_postcreate()
--

commit 0772c4b5400b34e15b8efeba1e351501ea33af4a
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool

This commit replaces read-time comparisons of nr_vcpus_matched_tsc against
online_vcpus with a boolean all_vcpus_matched_tsc maintained under
tsc_write_lock, initializing it to true at VM creation and clearing it in
kvm_arch_vcpu_postcreate() before synchronizing the new vCPU.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 12f465040efc2..1bb0136042a65 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -9584,8 +9589,38 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  {
> -	if (mutex_lock_killable(&vcpu->mutex))
> +	struct kvm_arch *ka =3D &vcpu->kvm->arch;
> +	unsigned long flags;
> +
> +	/*
> +	 * The new vCPU is already counted in online_vcpus but has not
> +	 * been synchronized. Clear the cached matched state before
> +	 * trying the mutex: the old read-time comparison failed
> +	 * conservatively false throughout this window, and userspace
> +	 * can hold it open across a whole first KVM_RUN by taking
> +	 * vcpu->mutex before we do. The synchronization below (or any
> +	 * racing host-initiated TSC write on the already-live fd)
> +	 * re-latches the flags. A protected guest TSC never
> +	 * participates in offset matching, so for it there is nothing
> +	 * to clear =E2=80=94 and no later sync to re-latch.
> +	 */
> +	if (!vcpu->arch.guest_tsc_protected) {
> +		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
> +		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
> +		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
> +	}
> +
> +	if (mutex_lock_killable(&vcpu->mutex)) {
> +		/*
> +		 * Aborted by a fatal signal: the synchronization never
> +		 * ran. Propagate whatever the matched state now is (a
> +		 * racing TSC write may have re-latched it), so the
> +		 * master clock does not stay in its previous mode with
> +		 * running siblings keeping PVCLOCK_TSC_STABLE_BIT.
> +		 */
> +		kvm_update_masterclock(vcpu->kvm);
> +		return;
> +	}

[Severity: Medium]
Can clearing ka->all_vcpus_matched_tsc here race with vCPU ioctls on the
newly created fd, or leave ka->use_master_clock stale while waiting for
vcpu->mutex?

In kvm_vm_ioctl_create_vcpu(), create_vcpu_fd(), atomic_inc(&kvm->online_vc=
pus),
and mutex_unlock(&vcpu->mutex) all run before kvm_arch_vcpu_postcreate():

CPU0                                    CPU1
kvm_vm_ioctl_create_vcpu()
  create_vcpu_fd(vcpu)
  atomic_inc(&kvm->online_vcpus)
  mutex_unlock(&vcpu->mutex)
                                        kvm_vcpu_ioctl(KVM_SET_MSRS)
                                          mutex_lock(&vcpu->mutex)
                                          ...
                                          __kvm_synchronize_tsc()
                                            ka->nr_vcpus_matched_tsc++
                                            vcpu->arch.this_tsc_generation =
=3D
                                              ka->cur_tsc_generation
                                            ka->all_vcpus_matched_tsc =3D t=
rue
  kvm_arch_vcpu_postcreate()
    raw_spin_lock_irqsave(&ka->tsc_write_lock)
    WRITE_ONCE(ka->all_vcpus_matched_tsc, false) <-- clobbers matched state
    raw_spin_unlock_irqrestore(&ka->tsc_write_lock)
    mutex_lock_killable(&vcpu->mutex)   <-- aborted by fatal signal
    kvm_update_masterclock()            <-- disables masterclock permanently

Because vcpu->arch.this_tsc_generation already matches
ka->cur_tsc_generation after CPU1's write, even if mutex_lock_killable()
succeeds, a subsequent matching sync in postcreate will not increment
nr_vcpus_matched_tsc again (and in the later commit "KVM: x86: Allow KVM
master clock mode when TSCs are offset from each other", a non-matching
offset write on CPU1 followed by the clear on CPU0 leaves
ka->all_vcpus_matched_freq false).

Additionally, when another thread takes vcpu->mutex for KVM_RUN before
postcreate does, clearing ka->all_vcpus_matched_tsc without calling
kvm_update_masterclock() leaves ka->use_master_clock true across that
entire first KVM_RUN (and even if CPU1 runs kvm_guest_time_update() before
CPU0 acquires tsc_write_lock, both ka->all_vcpus_matched_tsc and
ka->use_master_clock are still true).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111180922.4177=
927-1-dwmw2@infradead.org?part=3D3
