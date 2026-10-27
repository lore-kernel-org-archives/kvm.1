Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140364;
	b=tP4694DLnAiqQaMlBwcIrFBUYT7fsm0MCpiWttZI8vn/+LpPMddjkCwiFvDD8axoTKUj
	 Oqm5Bx1XzU8KS37FWf4kJd3WZEgrOv8+xKPO+SvvKVL/O5uiudYKnEV4IrupoxlRhQ3rh
	 xENSEv5e3InYXWze3YvLOSMJRlY3dxGm7SRwSTgGf/huT4XL2Y7m6it6JItiPSTyvuOk2
	 ChKfwv1an6lQfCNdGAcXf9NNGXn7lFidGtm4r97nzVBKcggYDPw+rf3XrTvtix41n0mbU
	 cnY7WPZOgeQPO0CeCny1TOmCgqlp2ijw+9nkmuBBFWdbgPlboGgPhha/1MLBN7K72BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140364;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nQ1+cSnv37NmNLs502IFa/RhT6J2RftygRXzRe+pV7U=;
	b=UNuhuTe4UcAiie3NAyiFXlSi1Fy1eJ6UIEG0nDZBKKUlNXWQbP8sYtFmiDkVqCxdNdj5
	 UpjyWZ9w+VJfYzDMdpH+2l7/ZQ38H2kkoVxKYYv6WW9YjLDZazXmQc/rAlZnY8p+nQLe7
	 Nx70MZX7svV1yTERZ8jsmitloUDFH6Fvt8IDck8RmGhTHoe4nowNnYrSj0JpwAn/0FUhw
	 Q9QKV66vIuDECTnog1m+SRi3TxRQzfTuR6Txbj6hYTDTqYwx9406+1IowUr+KuVFBzMmn
	 l5eJ4Wt6f2HQnFHWm8hLrNCfbK2ocEEc0+1HfiieaehNax715aNDO2Nryk6DGd5TRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrhiwCzZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402B606A32A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrhiwCzZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049271F01825;
	Tue, 27 Oct 2026 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140363;
	bh=nQ1+cSnv37NmNLs502IFa/RhT6J2RftygRXzRe+pV7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrhiwCzZNIwcUBE6XTMOHIUiz1uHq+44Z2an/ggsWwEY/9fICQY9s0yGCCdSneqTu
	 ithbAN2t4fBLzwU49kOl+4eoKoTu1bP3J1z7du9fMIFg8I8ryQjcxOxBP/VRsWKuxK
	 QS6gEZgUmsj6U05nh7Z9+nOZvoTPbDR1hTXLU5ypg4RRO9sM/38whEpmmXmd3sRzZn
	 JyvZxQcjfI1CFJWcz5amJZPpofgI7LrVI5b4iZvnM9AKB8UwvX1zRCXsje/SwolRId
	 xuwnV3VL7jALA9ARjkMXpm+UE9NB+/OLFAnCxLcNPLxo2bDOn1KBmAWtozMuXJTfqv
	 yd6R8olJ94QUw==
Message-ID: <sashiko-outbox-187163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/15] KVM: VMX: Explicitly remove dying vCPUs from
 the PI wakeup list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261027221209.1560865-14-seanjc@google.com>
References: <20261027221209.1560865-1-seanjc@google.com>
 <20261027221209.1560865-14-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:32:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: VMX: userspace WARN_ON_ONCE() in vt_vcpu_pi_remove_from_wakeu=
p_list()
--

commit 8f6f619224b282626da2d8fdae4dd65b668b2bef
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Explicitly remove dying vCPUs from the PI wakeup list

This commit adds vt_vcpu_pi_remove_from_wakeup_list() and calls it from
vmx_vcpu_free() so dying vCPUs that were blocking when the VM was released =
are
explicitly removed from the Posted Interrupts wakeup list.

> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_int=
r.c
> index 2644add54b76b..7414fb551d2e9 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c

[ ... ]

> @@ -146,6 +149,19 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  		pi_set_on(pi_desc);
>  }
> =20
> +void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu)
> +{
> +	WARN_ON_ONCE(refcount_read(&vcpu->kvm->users_count));

[Severity: High]
Can this WARN_ON_ONCE() be triggered from host userspace if KVM_CREATE_VCPU
fails after kvm_arch_vcpu_create()?

In virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu(), if kvm_dirty_ring_alloc(=
),
xa_insert(), or create_vcpu_fd() (for example when RLIMIT_NOFILE is reached)
fails, the error path tears down the partially created vCPU while the VM is
still live and vcpu->kvm->users_count is non-zero:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
	r =3D create_vcpu_fd(vcpu);
	if (r < 0)
		goto kvm_put_xa_erase;
    ...
kvm_put_xa_erase:
	mutex_unlock(&vcpu->mutex);
	kvm_put_kvm_no_destroy(kvm);
	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
unlock_vcpu_destroy:
	vcpu->vcpu_idx =3D -1;
	kvm_dirty_ring_free(&vcpu->dirty_ring);
arch_vcpu_destroy:
	kvm_arch_vcpu_destroy(vcpu);
}

kvm_arch_vcpu_destroy() calls into vmx_vcpu_free(), which unconditionally
calls vt_vcpu_pi_remove_from_wakeup_list(vcpu). Since the assertion runs
before checking whether the vCPU is actually on the wakeup list (or checking
vcpu->vcpu_idx >=3D 0), wouldn't a failed KVM_CREATE_VCPU ioctl hit this wa=
rning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027221209.1560=
865-1-seanjc@google.com?part=3D13
