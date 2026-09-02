Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0834CCDCA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318492; cv=none; b=TzHh64IOTv6aqE+nP4gDlVuyUpAY+kDSWMEJIMVmqkxhlXrfPbff2lvWRY7ytVA6ljMDdUgyZv+q4je+CKApufVTnht4gefzMlDfvXIHboIZrmgSXZ1+hvXr6xzWpUywDuu3bEcL7NTttPXXod4Ys5uHBrPRxHA28+13UntvLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318492; c=relaxed/simple;
	bh=jptV/z7ywZe1Jggi4juGmkoakyQw5pZNYz+nSlyg9kQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eOuUQ6VsLlPcP4N1I2o+m/zVr2AANeFcq0TmqYLvUgFIRx0PJbgdVFpxhWeQAqv2VD1HJwkM81UyjWu+8/bCfwjHmtKs3YIvZ24oHE1AHeSSsLeBrvb2Lf0kLNW8SgJsXzjkBNqHc32PxwYUMophvORm9f/bzU2xXqEoaTWASXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akQRP09z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akQRP09z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79D31F000E9;
	Wed,  2 Sep 2026 03:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318490;
	bh=Qy4qFHyAudo4l+doivDfjDZxR7pVmBURGI4Kjjw1gKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akQRP09zjQgH5+4QPqmn46rvDQky0vfgNi0aQzx6hsY3HOJpag4ICV7H43TSy5L9P
	 GLRSHn4bRFCh8ASxQJbyoHWwuMpSgLR75WlfTayNHeGefysomgbKZekfPsvN/U/j93
	 e3VvcelMVYxKjesHAPo+d41ThxhHM+UK8X1V9IQ60YCWSDSxsOURDC65k02rhLK4IZ
	 R6MwTc9jminl4McZL6jiP83adn5xqWvmE+xkD7Kcm7WjZEpWg2GwocRq9NL/SSHhHr
	 bwTXuzedOQmyEBTDJCLjqHbC8HdlStOLqJG5vxXT0nog7sRseFf4Pkmh1rGn20WhYJ
	 wc6kWQZ+Ga6Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/20] KVM: x86: Support APX state for XSAVE ABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-4-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-4-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:08:10 +0000
Message-Id: <20260902030810.A79D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] KVM fails to zero out APX registers (R16-R31) when restoring an XS=
AVE buffer where the APX feature bit is cleared, leaking stale state across=
 snapshot restorations.

Pre-existing issues:
- [Critical] Enabling APX support inherently inflates the default FPU uABI =
size beyond 4096 bytes, unconditionally breaking the legacy KVM_GET_XSAVE i=
octl on APX-capable hosts.
--

commit e523aa83189e420a1aea25a00998b66b7d7b10d8
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Support APX state for XSAVE ABI

This commit introduces a facility to copy APX state between the VCPU cache
and the userspace buffer for the XSAVE ABI. It adds two copy functions that
run during state export and import to ensure APX state is correctly handled
since the VCPU cache acts as the single source of truth.

>     Introduce a facility to copy APX state between the VCPU cache and the
>     userspace buffer as the VCPU cache is the single source of truth.

[Severity: Critical]
This is a pre-existing issue, but does enabling APX support inherently
inflate the default FPU uABI size beyond 4096 bytes, unconditionally
breaking the legacy KVM_GET_XSAVE ioctl on APX-capable hosts?

In arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl(), the legacy KVM_GET_XSAVE
ioctl unconditionally rejects the call if the size is too large:

	case KVM_GET_XSAVE: {
		r =3D -EINVAL;
		if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct kvm_xsave))
			break;

Because APX statically inflates the host's default_size beyond 4096 bytes
(the size of struct kvm_xsave), and the core FPU subsystem initializes
vcpu->arch.guest_fpu.uabi_size to this host default size, the legacy ioctl
will instantly fail with -EINVAL. Can this regression prevent VM boot,
migration, or snapshotting for legacy userspace (e.g., older versions of
QEMU)?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..0df74422759f8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -3141,6 +3141,49 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(stru=
ct kvm_vcpu *vcpu,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_KVM_APX
[ ... ]
> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, =
u64 supported_xcr0)
> +{
> +	union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
> +		return 0;

[Severity: High]
When restoring an XSAVE buffer where the XFEATURE_MASK_APX bit is cleared
in the header, does this code fail to zero out the APX registers (R16-R31)
in the software vCPU cache?

Since the vCPU cache is the single source of truth, returning immediately
leaves stale non-zero values from a previous vCPU execution. Will these
stale values be incorrectly loaded into hardware during VM-entry, violating
the x86 architecture requirement that missing XSAVE features are restored to
their INIT (zero) state?

> +
> +	if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +		return -EINVAL;
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D3
