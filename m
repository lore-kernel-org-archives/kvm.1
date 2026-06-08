Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B033A9E1
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934830; cv=none; b=SIzPbVtO9QZOl1cRN+lIXtao+QGDJC9DU8FOpZnp0FSHQZ78NvXCHxO9uQ6IBkICDITJSsVVtGc1lWEKa0ppdJj0k3dbnOUTJAsD5GKOZZJro/8rYpuiTFQThzAgjiHpam8T5f0fQvAqaoybRdsEGSxF5k0JtiMunBxzRVpG3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934830; c=relaxed/simple;
	bh=2w+YZNdu4gYqxTN6CaH/U5Bf62BsxfRrsv+dKLjN+5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nr3nFE3dLuZ+bfvYUAEaVbJj6uQkXDaY3Wd3vl0TeJ7JXgmIXnCMaE+Fjk6zKnY1KCC4V3TGbHJu3s0LR0TDxbkMcqabvnF60GqJskxTK9b8j7Z6upfMCnlDN7az6prlZgPosbx3h6v3Nn2Ckxf1JW4/lWBmO3tAUCac7dwUgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBft+1Ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBft+1Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E161F00893;
	Mon,  8 Jun 2026 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934829;
	bh=R7CA90X1l4BhXppow45UkA5jJrMxkJNWxIWd57D1kqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBft+1TakJ2FTDLsy7TLDpRVkPnCXplyiPkZuOS/DbPlyvMG+pQ3xa620fA16fsWw
	 PBhypxzooW3RcJ7B3wtrZBvc3FaBN7Em5rVLVMTHtioimu6v7/dP26tr1xUHzDPGH3
	 qyXK5TRH5rgprdOt5vx5eHFWMfoOe+vwt3fpc29QBX5NTrQ8yIqVa8DLW7IY1OJ8Ib
	 Hv/SuZSfEC/sks3HU8ZyS1oJeKjkgLGz10Jw1DnSpiguMRdKsE47wwTSWmbdiXSLnb
	 4DtrJrbjgOyDZAJwpHBL15WmmuTCxMgJnGSDXTfbp9vVBn70MtAsrdz4CPtW8rHgKV
	 5Dt9LP1HkGprQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/60] kvm: Move VCPU scheduling state to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-16-joro@8bytes.org>
References: <20260608144252.351443-16-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:07:08 +0000
Message-Id: <20260608160709.15E161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The active vCPU pointer `common->current_vcpu` is not updated =
during `vcpu_load()`, causing preemption handlers to save and restore the p=
hysical state of the wrong VCPU plane.
- [Low] Mixing `goto`-based error handling and `__free()` cleanup declarati=
ons in the same function.
--

commit aa5b05dc8fcf8ce2c82b92d710cc33efdf5543d2
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move VCPU scheduling state to struct kvm_vcpu_common

The scheduling state of the KVM VCPU is shared between all per-plane
VCPU objects. Move it to struct kvm_vcpu_common.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -166,7 +166,7 @@ void vcpu_load(struct kvm_vcpu *vcpu)
>  	int cpu =3D get_cpu();
> =20
>  	__this_cpu_write(kvm_running_vcpu, vcpu->common);
> -	preempt_notifier_register(&vcpu->preempt_notifier);
> +	preempt_notifier_register(&vcpu->common->preempt_notifier);
>  	kvm_arch_vcpu_load(vcpu, cpu);
>  	put_cpu();
>  }

[Severity: High]
Does this code need to dynamically record the actively loaded vCPU in
common->current_vcpu?

When an ioctl is invoked on a secondary plane's file descriptor, this will
load the physical state of the secondary plane onto the current CPU.=20

If common->current_vcpu is not updated here, could preemption cause the wro=
ng
state to be saved?

[ ... ]

> @@ -468,6 +468,12 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcp=
u, struct kvm *kvm, unsigned
> =20
>  	common->kvm =3D kvm;
>  	common->current_vcpu =3D vcpu;
> +
> +	common->wants_to_run =3D false;
> +	common->preempted =3D false;
> +	common->ready =3D false;
> +	preempt_notifier_init(&common->preempt_notifier, &kvm_preempt_ops);
> +
>  	vcpu->common =3D no_free_ptr(common);
> =20
>  	return 0;

[Severity: Low]
This isn't a bug, but does kvm_vcpu_init_common() mix goto-based error
handling and __free() cleanup declarations in the same function?

The cleanup guidelines suggest that for a given routine, all resources shou=
ld
be converted to scope-based cleanup, or none of them, to avoid confusing
ownership semantics.

[ ... ]

> @@ -6487,36 +6490,36 @@ static void kvm_init_debug(void)
>  }
> =20
>  static inline
> -struct kvm_vcpu *preempt_notifier_to_vcpu(struct preempt_notifier *pn)
> +struct kvm_vcpu_common *preempt_notifier_to_vcpu_common(struct preempt_n=
otifier *pn)
>  {
> -	return container_of(pn, struct kvm_vcpu, preempt_notifier);
> +	return container_of(pn, struct kvm_vcpu_common, preempt_notifier);
>  }

[ ... ]

>  static void kvm_sched_out(struct preempt_notifier *pn,
>  			  struct task_struct *next)
>  {
> -	struct kvm_vcpu *vcpu =3D preempt_notifier_to_vcpu(pn);
> +	struct kvm_vcpu_common *common =3D preempt_notifier_to_vcpu_common(pn);
> =20
> -	WRITE_ONCE(vcpu->scheduled_out, true);
> +	WRITE_ONCE(common->scheduled_out, true);
> =20
> -	if (task_is_runnable(current) && kvm_vcpu_wants_to_run(vcpu)) {
> -		WRITE_ONCE(vcpu->preempted, true);
> -		WRITE_ONCE(vcpu->ready, true);
>  	}
> -	kvm_arch_vcpu_put(vcpu);
> +	kvm_arch_vcpu_put(common->current_vcpu);
>  	__this_cpu_write(kvm_running_vcpu, NULL);
>  }

[Severity: High]
If common->current_vcpu still points to the primary plane because it wasn't
updated in vcpu_load(), will this save the active physical state of the
secondary plane directly into the primary plane's structure?

It looks like upon resuming, kvm_sched_in() would load the primary plane's
corrupted state back into the physical CPU, which might cause deterministic
architectural guest state corruption between planes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D15
