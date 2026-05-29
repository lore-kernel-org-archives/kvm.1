Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB53F1AC4
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072797; cv=none; b=rVSJpdEkyLkaC4brW0urOf9ZLZ46HvEOd8HNOx+FPS6IX9BA/s2V+6hMkS2j6IR+Kwy9gDNwgiBtswEC2ZyMKcjqUs30sBeiP7B5Rifxohr88Z8KqJtEdkmKU53eo7G9hqhc7VLnKwkzdtvJZT8rRdb6HagrWNlybb1QW/5UOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072797; c=relaxed/simple;
	bh=B2ecA4b+NBlplh9y9301cgIo98R5BviQrXNCMmQ2OEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YLbWTb0C6vgoywVz80Rgigvgu7yOfva4hRom+iQZes3Iy8GOIfD+nIiX0nidRrivP5IBWM1g9TlngfZll2EBXMhsW6MwT7fQpM/S//BUOY7CIwIenoQpcJG6mGj+0tX6lB+i2q1b2uI7lRgtprbhJ2oad4TW0eqGbJxJi6Y5+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLz5p/Hk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLz5p/Hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19911F00898;
	Fri, 29 May 2026 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072793;
	bh=XyOX7Y7xMT1la3zJnU7UicOeM/0uwf/Gyc+neIwPMBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OLz5p/HktEXoMQp7NmdFziKtCqzZBqjqizsY2L0VplZTdLTG5NazzUMMzxr9revXP
	 OAfkcWAhOJCYqQY1wodBmen/KpKXk+jyOkFYWJsiAfs1glt9Ws4b9w969KLHPpJIGv
	 XQ+xzC9XqGei6QPccdYV+6eHa1jICE+zoQm6cPYpbMQpMSQT9crLvI09MsRg77vSD4
	 3tXeKkxeDUwGlVtKhpSVxzSVyeXKGBJqyJ+8LRA0Z2fPKH4KQE+5X+bPSyNzjpij/L
	 jbrfwBkLnkGRvFtcOUxdkSKqvyg6JB5yGfbmS1C8JNuMcXA1C8sLqIzM98TIf8bnSi
	 f1ZB4ABrzgyQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/27] KVM, vfio: remove symbol_get(kvm_get_kvm_safe)
 from vfio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-3-seiden@linux.ibm.com>
References: <20260529155050.2902245-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:39:53 +0000
Message-Id: <20260529163953.A19911F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure in arch/x86/kvm/svm/sev.c due to missing `users_count=
` struct field update.
--

commit d29c547487163d60419f67e02b219cd59361c39b
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio

This removes the deprecated symbol_get usage for kvm_get_kvm_safe in VFIO
by making the function inline. As part of this, the function is moved to
kvm_types.h and the users_count field in struct kvm is moved into a new
kvm_refcount struct.

[ ... ]

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4c14aee1fb063..8a068cbf12ff2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -768,6 +768,9 @@ struct kvm_memslots {
>  };
> =20
>  struct kvm {
> +	/* Must be the first field, see function definitions in kvm_types.h.  */
> +	struct kvm_refcount rc;
> +
>  #ifdef KVM_HAVE_MMU_RWLOCK
>  	rwlock_t mmu_lock;
>  #else
> @@ -831,7 +834,6 @@ struct kvm {
>  	struct list_head ioeventfds;
>  	struct kvm_vm_stat stat;
>  	struct kvm_arch arch;
> -	refcount_t users_count;

[Severity: Low]
Does removing users_count from struct kvm break the build for x86 with AMD
SEV?

Looking at kvm_lockdep_assert_sev_lock_held() in arch/x86/kvm/svm/sev.c, it
still references this directly:

arch/x86/kvm/svm/sev.c:kvm_lockdep_assert_sev_lock_held() {
    ...
	/*
	 * Querying SEV+ support is safe if there are no other references, i.e.
	 * if concurrent initialization of SEV+ is impossible.
	 */
	if (!refcount_read(&kvm->users_count))
		return;
    ...
}

Should this reference be updated to use kvm->rc.users_count like the other
files modified in this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D2
