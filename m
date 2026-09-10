Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8336EAA4
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058778; cv=none; b=eIk/wth62QPdtpGNmU4UlBCijnQ4ky9Xyt6zV9hm5IBXM3HhUjDX8XNwBUfWob7K/RRq3VKLZvQeQKIPJkQXWWATHTG5bXCfTdj3tCJRUcrIWqtfA9SAH4N6wncShsfmSgKQ6ubTg54GXQ5AlLhAbt/eWWy+msH2s2apSdYAn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058778; c=relaxed/simple;
	bh=qwzvrooIaFmIrsAn3/12pZV97iu+crcrRCs4qw8jnN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HPFPD3PIPI6onKOn8k7jNrnEXppHn+rP5uZCz79JW+zxCYP+pxGsrFO0whh1pqp3q/KPonnmM1OHeyX1s5Zr0dz6Mu7ZuvP37dz+1LHaMPtiTUm3YEGkJoEv7GK2KuQGmXym9AiS8DX3OP74+suN1iO7Q0VqMANeuYZO4mdR9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETYNVEQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETYNVEQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A61E1F000FF;
	Thu, 10 Sep 2026 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058771;
	bh=ObZIpnME0U8IbYU2DzSosQKUJ+lP2Xh9Z9Pfz0/SNs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETYNVEQdhNd05/aenA+town7Yko5aavK5xGXtJ7MPDxgpTb1CQ3yf/KKKRnLclo64
	 b08KYPmQOeG2+i4215CEkXwNK5RKoTjt3BvUgAgTFAooHvUpo7IO+qy0aUp+4v/WFR
	 K13bLnS9eyCXxpgecglRsbXKadpR1f3Drn612lfr+6VjxzXy7V036URn8Nl9BajDTs
	 rRPteSP0xs3Ujbu/Soj/l90ZIQOhotx5znqDpwsqoXCdAud0Wfqyi9o80mL9gS+RJ5
	 22hK6Umd/WGhGH9Rq3VbTx8HUxnedQi7v572xesXVS8abSpt3bw0mTK3yj/z1eOcYj
	 l1JJLniTINxBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/10] KVM: x86: Add guarded_by annotations for
 kvm_arch, kvm_hv, and ioapic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Elver" <elver@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910162343.4092060-10-elver@google.com>
References: <20260910162343.4092060-1-elver@google.com>
 <20260910162343.4092060-10-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:46:11 +0000
Message-Id: <20260910164611.8A61E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Mixing goto-based error handling and scope-based cleanup in the sam=
e function.

Pre-existing issues:
- [High] Lockless traversal of the global vm_list can race with VM creation=
 and destruction.
--

commit b3fea266e46bae40374748855ac1c207f8a8f74f
Author: Marco Elver <elver@google.com>

    KVM: x86: Add guarded_by annotations for kvm_arch, kvm_hv, and ioapic
   =20
    Add __guarded_by annotations to a subset of fields across x86 state
    (struct kvm_hv, struct kvm_arch, and struct kvm_ioapic) where the
    protecting locks reside in the same struct scope. Mark deliberate
    lockless updates with data_race().

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index de7c6eb1a64f5..af03911f0c4fa 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9813,8 +9813,8 @@ int kvm_arch_enable_virtualization_cpu(void)
>  			 * you may have some problem.  Solving this issue is
>  			 * left as an exercise to the reader.
>  			 */
> -			kvm->arch.last_tsc_nsec =3D 0;
> -			kvm->arch.last_tsc_write =3D 0;
> +			data_race(kvm->arch.last_tsc_nsec =3D 0);
> +			data_race(kvm->arch.last_tsc_write =3D 0);

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless traversal=
 of
the global vm_list in kvm_arch_enable_virtualization_cpu() race with VM
creation and destruction?

If a user concurrently creates a VM (kvm_create_vm) or destroys a VM
(kvm_destroy_vm) while CPU hotplug is running via kvm_online_cpu(), the
list_add() or list_del() executed under kvm_lock will race with this traver=
sal.
This can potentially lead to list corruption, use-after-free, or infinite
loops.

While this patch masks static analyzer warnings by adding data_race()
annotations here, shouldn't the broader list traversal safety be addressed?

[ ... ]

> @@ -9927,8 +9927,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
>  	kvm->arch.enable_pmu =3D enable_pmu && !kvm->arch.has_protected_pmu;
> =20
>  #if IS_ENABLED(CONFIG_HYPERV)
> -	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
> -	kvm->arch.hv_root_tdp =3D INVALID_PAGE;
> +	scoped_guard(spinlock_init, &kvm->arch.hv_root_tdp_lock)
> +		kvm->arch.hv_root_tdp =3D INVALID_PAGE;

[Severity: Low]
Does introducing scoped_guard() here mix scope-based cleanup with goto-based
error handling in the same function?

kvm_arch_init_vm() already relies on goto labels (e.g., goto out_uninit_mmu,
goto out_cleanup_page_track) for its error paths. According to the subsystem
coding standards, a function must exclusively use either goto-based cleanup=
 or
scope-based cleanup helpers, but never mix both to prevent confusing owners=
hip
semantics and lifecycle bugs.

Could this be kept as goto-based, or should the entire function be converted
to scope-based cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162343.4092=
060-1-elver@google.com?part=3D9
