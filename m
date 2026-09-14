Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F9381EAE
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411040; cv=none; b=tljfSmBpBAwnb44+qsqhZWOOLArfak4xP9bJoJgK7CQv23t7H4WGFID+TKpR8yekfUZ8Pd2etMSPM/a2A7d91cn0oVWOjwZOOSp7yJ7bFf+YVnDKgRoKJIRBl544Ga6yHXjDOC/npXFDyre7wjzjoJRJSUqYnSOlDTicIfCGEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411040; c=relaxed/simple;
	bh=pqtNEXTLbjbBkYrS32Rft5VrXCFZaluaEYVxnyRjzrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pq3nInMGkdIYf7+AoqblQg0kPAfAMiQrNdqNvViqgaERpp0zukhNxK8cc8aLGiKcw83/UEqdden2ZFbKOrydvfQveanTvfJUSMPYJG3WuNJLKgcbRHTAL1CFrWP/Lg3+aXSnpkIUtznGCg1QupyW9DfGmCdFjpKYBFnZKSB3wsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvCtn0PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvCtn0PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141931F000FF;
	Mon, 14 Sep 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411039;
	bh=beCjqR5xfYpU1aZecyycvtZPb2dYg6JSJkiRJbPw0EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvCtn0PQ8vVkzBeimE7vNny0KL6v9NLiHFUB9fY8J4taXL17Ii36IdRacfYJsUFgz
	 dS+Wai7+in7sGk98vW76f2Rnqv0+SX/xQrGAnjFcTDvQDIYYMhJ8sIWcB+LYWLQBK+
	 p7ZNjiCwf7agl/VRDaz8D/hHF02L1zTmo6EAsfOIdo3AkK4FleI8bjS0lLd86KUkq9
	 RHeDSgkTSdVt7tx7NwK1b4mlKn70kUPy+3sYkWkoaxv5WbwufgTpXzkB9LmAvZaAnf
	 mMVV1A8RWYqYLBS2oHbQv68KEzF21hGLDrOWVf58y8cvxSlDxqsZSMmj3g6/QXMWxE
	 pvuQcsecu2m6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] KVM: Protect all of kvm_vm_ioctl_create_vcpu() with
 kvm->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260914181223.289061-3-seanjc@google.com>
References: <20260914181223.289061-1-seanjc@google.com>
 <20260914181223.289061-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:37:18 +0000
Message-Id: <20260914183719.141931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Self-deadlock in KVM vCPU creation due to recursive `kvm->lock=
` acquisition on PowerPC and s390.
- [Low] Mixing goto-based error handling and guard() cleanup in the same fu=
nction.
--

commit de58d2836963a7ea1b99cd6c2ad5be4f18984b33
Author: Sean Christopherson <seanjc@google.com>
KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock

This commit serializes vCPU creation by holding kvm->lock throughout
the entirety of kvm_vm_ioctl_create_vcpu(). It prevents concurrent
vCPU creations to simplify the code and prevent race conditions.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 78cc090435be5..c17cc8dd371b6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4165,6 +4165,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  	struct kvm_vcpu *vcpu;
>  	struct page *page;
> =20
> +	guard(mutex)(&kvm->lock);
> +

[Severity: Critical]
Could this cause a self-deadlock on PowerPC and s390? The guard acquires
kvm->lock for the entire scope of kvm_vm_ioctl_create_vcpu(), but this
function subsequently calls architecture-specific hooks like
kvm_arch_vcpu_create() and kvm_arch_vcpu_postcreate().

On PowerPC, kvm_arch_vcpu_create() eventually calls
kvmppc_core_vcpu_create_hv() in arch/powerpc/kvm/book3s_hv.c, which
explicitly attempts to acquire kvm->lock via mutex_lock(&kvm->lock).

Similarly, on s390, both kvm_s390_vcpu_setup() and
kvm_arch_vcpu_postcreate() in arch/s390/kvm/s390/s390.c call
mutex_lock(&vcpu->kvm->lock).

Since standard Linux mutexes are not recursive, it appears any userspace
process invoking the KVM_CREATE_VCPU ioctl on these architectures will
indefinitely hang the creating thread.

[ ... ]

> @@ -4267,7 +4259,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  	atomic_inc(&kvm->online_vcpus);
>  	mutex_unlock(&vcpu->mutex);
> =20
> -	mutex_unlock(&kvm->lock);
>  	kvm_arch_vcpu_postcreate(vcpu);
>  	kvm_create_vcpu_debugfs(vcpu);
>  	return r;
> @@ -4278,7 +4269,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
>  unlock_vcpu_destroy:
>  	vcpu->vcpu_idx =3D -1;
> -	mutex_unlock(&kvm->lock);
>  	kvm_dirty_ring_free(&vcpu->dirty_ring);
>  arch_vcpu_destroy:

[Severity: Low]
Does this mix goto-based error handling and scope-based cleanup within
the same function? The cleanup subsystem guidelines specify that a function
should either use goto for cleanup or scope-based cleanup helpers, but
never both.

While the lock is safely released on return here, introducing
guard(mutex)(&kvm->lock) at the top of kvm_vm_ioctl_create_vcpu()
while retaining manual goto cleanup labels like unlock_vcpu_destroy
creates confusing ownership semantics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914181223.2890=
61-1-seanjc@google.com?part=3D2
