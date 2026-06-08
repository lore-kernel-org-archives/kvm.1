Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA123ED5B
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940170; cv=none; b=E926VIXgiI5LLnwDiHhBhTc7pWiu+4H4KjLpDFGX/iIpOsLQ1q5fddGtmhQSc1PZPgtwgv86kfwpa/cbPofxX9ge3gAXfOGkRbSzqn78ashFIcOEdVTA9DMPvKjhqHbuYgNJ1L74tqhdPGvGv7wGjNCpwSuV3VNQvAADIcm+spQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940170; c=relaxed/simple;
	bh=c+/q6sAt+xZD5ZZmuTtypj/dmVP/krt6z9WhAn/Ltns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/MvZA44OOAj+Hce0v91BGcgQwDcSaIlwU6VJWN3df2g544Y+GQ6iNcC0JxlptgxxmOVXxTRyh6Khqfu8wW94aw6uhLrwJHTZO7t2kA3qDMR5yHd7qfMOwo0vTHSCJ3B4aXlQRm0bu/qBF0Zm1htlk2SePL6NrJC4l/xzquh3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyxRlpO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyxRlpO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D33F1F00893;
	Mon,  8 Jun 2026 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940169;
	bh=3mpfjGlZ64E63F9UBmkjw3aK5yA6lgm2yfjTxgnx+WA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RyxRlpO0pF26MMzErxBsc9n+hzwlYDfTSSgcNrRdVemMhxlESOfihZf0rx2FhFBJD
	 3pthwYbJol1r+CRpCMcgUkU7zIs4kxmkr/iR7BESLED4RbIGUcIU8VJYMNtuvCnk1V
	 LMruU52B8USde5fSq20oxIiO7N/UDyIzH3Oz5+lxAYSlYRXHokMU9pdpnBpDUe5Xem
	 212mpZKNzdSW4vOEJvAw7bcIK0NoRmxotvLmvjg1rvfaOMT4nnZJP3JClUObeQ3kXW
	 Q0ByRkEVpz2GvNqJkLcPiquwpbe32B/3McPIcBO0PqdqIxVNuSIFIQiIHkVL9QENzE
	 k16DO0nukT3RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 30/60] kvm: Add KVM_EXIT_PLANE_EVENT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-31-joro@8bytes.org>
References: <20260608144252.351443-31-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:36:09 +0000
Message-Id: <20260608173609.6D33F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing capability negotiation for the new exit reason KVM_EXIT_PL=
ANE_EVENT.
- [Low] Architecture-specific parameter (`apic_id`) used in generic KVM cod=
e.
--

commit 7ac5546369ac2dcb5fc9dd9195a781cf261e7620
Author: Paolo Bonzini <pbonzini@redhat.com>

Add a new exit-type to KVM for telling user-space that a plane-vcpu is miss=
ing.

This commit adds KVM_EXIT_PLANE_EVENT and a helper kvm_request_create_plane=
()
to populate the kvm_run exit structure.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3ecd472c7cfa..90b97137840e 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1649,6 +1649,8 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
>  bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
> =20
> +int kvm_request_create_plane(struct kvm_vcpu *vcpu, unsigned plane, u64 =
apic_id);

[Severity: Low]
Does this introduce an architecture-specific parameter into generic KVM cod=
e?

The apic_id parameter is an x86-specific concept, but this declaration is
exposed in the generic kvm_host.h API. Would it be better to use an
architecture-neutral term like vcpu_id or hw_id?

[ ... ]

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 24e34b8e4819..a88d987c7882 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -193,6 +200,7 @@ struct kvm_exit_snp_req_certs {
>  #define KVM_EXIT_ARM_SEA          41
>  #define KVM_EXIT_ARM_LDST64B      42
>  #define KVM_EXIT_SNP_REQ_CERTS    43
> +#define KVM_EXIT_PLANE_EVENT      44

[Severity: High]
Should there be a capability negotiation flag added for this new exit reaso=
n?

If a host kernel begins emitting KVM_EXIT_PLANE_EVENT without prior
capability negotiation (e.g., via a KVM_CAP_PLANE_EVENT definition), it
could cause older, unaware userspace processes to crash when they
encounter the unknown exit reason.

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 03a44ff62f0f..f0f78bb74e51 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -3973,6 +3973,18 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
> =20
> +int kvm_request_create_plane(struct kvm_vcpu *vcpu, unsigned plane, u64 =
apic_id)
> +{
> +	vcpu->run->exit_reason =3D KVM_EXIT_PLANE_EVENT;

[Severity: Low]
Can this function signature be updated to use architecture-neutral terminol=
ogy?

This generic helper implementation uses apic_id, matching the header=20
declaration. Using a neutral parameter name here might better maintain=20
subsystem layering.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D30
