Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927203D9DB9
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307018; cv=none; b=cBr5BO9NOsIsfyEMEszwwj8t8FZfBIFLUcSFZOI3S15n6WXG03P1BYoetKHKLFhHOBEx0Wb2P04GEn+dbLEScfXzEpHr57j+GE0D2dQvZLUbURMykQNeWqzDKi/hI+DHd1kJrDpi78ySPxL2xWe22FOoAmwyRj8vY+FWLFOuT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307018; c=relaxed/simple;
	bh=KSTg5pX6YOU21OLdNhI4fKvICvd+yKIcrs/R7i95uO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBHSR4BeFQrWbp0We76MSGumB7sWB8ojBRhxoESSs6HbhWW+ZwnFk0EMz42+t+xDIxBrN9/DMMdjC9SaLQKjMarhujiMrK2WxRRoePprudFfs6FmA9Fymtvl/LjY78Ye8B+wYN0rT6CqpmLudFTG+Opx6Zp8ISqx00XwEXN5wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ0Urocr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ0Urocr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9771F000E9;
	Fri, 12 Jun 2026 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307017;
	bh=LXS3SPjXIRXGiUfe8mJ8gVrYYRx47Uvwl2GzvVI/TRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZ0UrocrnqrKuv65cHobNxidpJKSIVZCfBJsHkdOIzdt3FNDMihD+jjohyK7h/9k4
	 pG3KH66UBlcaS6hMLZJ3G8d5wnWIzzyAm4q5Lav+ig7JgT4k814xiG6Ke7C7/4GduE
	 3aZchU0EYH/azRoCJINI0yfbM0kArBO4kDF3e9rr2OkQBmvwZ8OmYHdzAe2pE8bFEd
	 3X0OXIzJT++CMRylN5x3mj8KxPRcjYp3YqUbseMRwHKUDqz7FMewjLpa58xrPBn56N
	 0nWJTOlzkW7mxhh5DYGaZym6CnR7Z2+8EPmwYgMJOpIDWtMbkHIZIGxZAoWwdAFPAq
	 js2A4NG+Va5GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: Initialize a vCPU's index to '-1' while
 it's being created
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612230622.687665-5-seanjc@google.com>
References: <20260612230622.687665-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 23:30:16 +0000
Message-Id: <20260612233017.1F9771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `vcpu_idx` to `-1` changes the default initialization of X=
en `vcpu_id` from `0` to `-1`, potentially breaking VMMs that rely on the i=
mplicit default for vCPU 0.
--

commit bcf5ca6a21c901bf1c4eeb8dcb3b2d169932ed92
Author: Sean Christopherson <seanjc@google.com>

KVM: Initialize a vCPU's index to '-1' while it's being created

This commit invalidates a vCPU's index immediately after allocating storage
for the vCPU. This prevents KVM from incorrectly treating an incomplete vCPU
as vCPU0 and allows detecting unreachable vCPUs.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e44c20c049610..b3d2a678210c3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4188,6 +4188,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  		goto vcpu_decrement;
>  	}
> =20
> +	vcpu->vcpu_idx =3D -1;
> +

[Severity: High]
Does setting vcpu->vcpu_idx to -1 here inadvertently change the default
initialization of Xen's vcpu_id?

Because this is set before kvm_arch_vcpu_create(), the architecture-specific
creation code will see the -1 value. On x86, kvm_arch_vcpu_create()
eventually calls kvm_xen_init_vcpu():

arch/x86/kvm/xen.c:kvm_xen_init_vcpu() {
    ...
    vcpu->arch.xen.vcpu_id =3D vcpu->vcpu_idx;
    ...
}

Since the actual vcpu_idx isn't assigned until later in
kvm_vm_ioctl_create_vcpu(), this leaves vcpu->arch.xen.vcpu_id as -1 instead
of its previous default of 0.

Could this cause guest hypercalls, such as VCPUOP_set_singleshot_timer,
to fail with -EINVAL if a VMM relies on the previous default of 0 for vCPU 0
and doesn't explicitly invoke KVM_XEN_VCPU_SET_ATTR?

>  	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
>  	page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  	if (!page) {

[ ... ]

>  	vcpu->run =3D page_address(page);
> =20
>  	kvm_vcpu_init(vcpu, kvm, id);
> =20
>  	r =3D kvm_arch_vcpu_create(vcpu);
>  	if (r)
>  		goto vcpu_free_run_page;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612230622.6876=
65-1-seanjc@google.com?part=3D4
