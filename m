Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5144A23
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956631; cv=none; b=Om0t+pABvAhvZrvdixXUoe2rpQC4/Dc5hN+KUQ0bjd2HeEGzsgardnGEDGpSjw8fd/7HzoOe2lIafkp4TwLDvAnf90oQoevN8+pCjka9gi6j3KLdOUnRvkEc0t+YGmGZaHaJLvBQO0eXnGqOXcDpAmpwlkFpR2dPPblAufJiYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956631; c=relaxed/simple;
	bh=ibLZERc3yFCSG3U8rVioI+C3Y7EebOdK5bRKC3ic1nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U1K5THq6F5UqHfXFYDfIiP26z2SF7ccF7XBaAx2wg+qeJbyOupagjnzLoUN8fkaatwvE1lO2e+Ga+zPcewz0NUZEgezGg/pu9w3zWOBHz6us6zVKyy2S3FkYrIV+Fm8cK6jrWxlJ75bpIs4PTelN/dJacxb9yRtA9Y9970zwPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDFZYcyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDFZYcyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8C31F00893;
	Mon,  8 Jun 2026 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956629;
	bh=Skl+22p/a3TXR8aFl0toDMent7Q6M5iHol2ruLoNwVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDFZYcygTH7DUjDIQLmCqCi2UGGMk/u+fm5i1S7sy73qxxtOjv3zcxOFuz5ddLp3G
	 q7n9bC1x6ZLai2iA0MmnsxKlbpcjYqXQzpUG3pNE27n51FE3SEjZlsUgURLjHr5UIO
	 /po2CcazkKQKtXJBO2mHljcdYZq0gWc8konWxjD3c1+5+stc44ylITVO6p0tQjDOSl
	 mNHyIMPAFYQezxq8QlVLnG0Z5pKnGkOnn0eDomS+3mKJSw3amkmH2ibHkHMAKnc3jl
	 gfW0CXK0VGuL8wKBWsCJvG6CHccPN5STNp+YrOOwRd/yiYuaOG/P+cgl8rAhhwiHv5
	 qCnhKGssXsNig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 52/60] kvm: x86: Switch to plane0 if it has events
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-53-joro@8bytes.org>
References: <20260608144252.351443-53-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:10:29 +0000
Message-Id: <20260608221029.BF8C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Cross-vCPU architectural state corruption due to accessing har=
dware-backed state of an unloaded vCPU.
- [High] Event starvation for plane 0 due to checking post-processed pendin=
g flags instead of queued KVM requests.
--

commit 376cda0c730616cf64ef48d0e29e3bef6fee2d77
Author: Joerg Roedel <joerg.roedel@amd.com>

When there are IRQs or events pending for plane0, make sure it can handle i=
t.

This commit introduces a check in the vCPU entry path to determine if plane=
0=20
has pending events like interrupts, NMIs, or SMIs. If plane0 has pending=20
events, it makes requests to reschedule to plane0 so it can process them.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 08fe65b8d57d..60b34bd4da9d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10962,6 +10962,20 @@ static int kvm_check_and_inject_events(struct kv=
m_vcpu *vcpu,
>  	return r;
>  }
> =20
> +static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu *vcpu_plane0;
> +
> +	if (vcpu->plane_level =3D=3D 0)
> +		return false;
> +
> +	vcpu_plane0 =3D vcpu->common->vcpus[0];
> +
> +	return kvm_cpu_has_injectable_intr(vcpu_plane0) ||

[Severity: Critical]
Does calling kvm_cpu_has_injectable_intr() on vcpu_plane0 while the current=
=20
vCPU is loaded risk corrupting architectural state?

If RFLAGS is not cached in software, the architecture-specific callback=20
(such as vmx_interrupt_allowed()) might execute a hardware vmread to fetch=
=20
GUEST_RFLAGS. Because vmread implicitly reads from the currently active=20
VMCS, it would fetch the RFLAGS of the currently running vCPU and cache it=
=20
into the state of vcpu_plane0.

Could this silently overwrite and corrupt the state of plane0 with the stat=
e=20
of the active plane?

> +		vcpu_plane0->arch.nmi_pending ||
> +		vcpu_plane0->arch.smi_pending;
> +}

[Severity: High]
Does this check miss events that are queued but not yet pending?

When an NMI or SMI is injected by the host, KVM sets the KVM_REQ_NMI or=20
KVM_REQ_SMI bit and increments vcpu->arch.nmi_queued. The nmi_pending flag=
=20
is only updated later when process_nmi() executes during the entry loop for=
=20
that vCPU.

Because plane0 is inactive while the secondary plane is running, its entry=
=20
loop never executes to transfer the queued requests to the pending state.

Will kvm_check_plane0_events() evaluate to false despite NMIs or SMIs being=
=20
queued, potentially starving plane0? Should this check kvm_test_request()=20
for KVM_REQ_NMI and KVM_REQ_SMI instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D52
