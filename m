Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C5262FFC
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427407; cv=none; b=OdSKxftHCOPSRORO48svJCT5CB501mI3KWr5WG+mdRufwsVeQkaZrmL4Xl5CgS5jc5nlvhJ4dREg4EYfnf96TBdBKWs93UI2OrPmEFf7/VWASSwp0krbKUOE7nnEAVrLdd3GPbsKDL42/E2hp6sbes9ReeujQpmz2wFZOLcs7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427407; c=relaxed/simple;
	bh=msjZAvkFrb/BCc240g3p/iWFEMRv63J7auO/NtKs9zY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bs61uiGdwdAUT0NYUWVC+Q1ZsgGspoyjRdM773vesyxsa6v8w+PYNiSMNHWl4kNFFTv77t4SPt0NBv1TWo6J8ai+SQsjg/M4U21YkDHJ5fHm9+0MoHBCDagjAgx+t055kGLzXWHqZg6adzY+QlWWNQFsHiju5up+eowE33mKoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzxqW5Sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzxqW5Sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8ED1F000E9;
	Thu, 25 Jun 2026 22:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427405;
	bh=Mu2wVQnY3x33b64A934OjwYJHU99PAwqUc1qE853Jyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzxqW5SdYb7+M7XkJ5zW1DyshhiKIhDdsuboCN9bKu3nrDFvn9pIaRycuIYxbgYrb
	 iCWW3ZXlkAUVbZtZ5Fsyt1G0PwuUjDlUDnudMC/BGSs7MzklkavDTQckdheFLRvuNU
	 +H3rbeOyY0tZ7uKoG1OwJ2/MfTpjrVWy8Ym49N+uyLJ92rrHICorjgMfk0cFi6PBjh
	 O57x0rjN5H2e1PuhVc0MXxQr0JbjOu0JfBAC3/suzxV5ywB06+qfIEOYaSbBaGu+Dd
	 4TT7hQ0FV7SokiXEazdoeQHYVfuyg4/IB6PewgCvOfhQs6CazwxyfsYuVXlhXRXIzk
	 q0lyAYDeXPoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] KVM: x86/xen: Consolidate checks on Xen vCPU
 ID for singleshot timer hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625223623.3376478-6-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
 <20260625223623.3376478-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:43:25 +0000
Message-Id: <20260625224325.BE8ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hoisting the vCPU ID check in `kvm_xen_hcall_vcpu_op()` incorrectl=
y rejects all cross-vCPU `__HYPERVISOR_vcpu_op` hypercalls, breaking SMP in=
itialization for Xen guests.
--

commit ab4f31575265dd36c2d3998b19a199dfac35a37c
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer hyperc=
alls

This commit hoists the Xen vCPU ID checks for set_singleshot_timer and
stop_singleshot_timer out of their switch cases in kvm_xen_hcall_vcpu_op()
into the common path.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1614,13 +1614,13 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu=
 *vcpu, bool longmode, int cmd,
>  	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
>  		return false;
> =20
> +	if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
> +		*r =3D -EINVAL;
> +		return true;
> +	}
> +

[Severity: High]
Does hoisting this check unintentionally reject cross-vCPU commands that sh=
ould
be delegated to userspace?

If a guest issues a cross-vCPU hypercall like VCPUOP_up or VCPUOP_initialis=
e,
this check will now evaluate to true and return -EINVAL directly from the
kernel.

Previously, these non-timer hypercalls would bypass the switch statement and
fall through to return false, properly delegating the operation to userspac=
e.

Could this cause regressions in SMP initialization for Xen guests by
intercepting and rejecting commands intended for secondary vCPUs?

>  	switch (cmd) {
>  	case VCPUOP_set_singleshot_timer:
> -		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
> -			*r =3D -EINVAL;
> -			return true;
> -		}
> -

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.3376=
478-1-seanjc@google.com?part=3D5
