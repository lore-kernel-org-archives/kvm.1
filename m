Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547520;
	b=MUQqziPmY4qg0mgfNsvfaWCBHXrt+Ej/dB7aFPBGwfU/gqCvq/vnYTir+Od2iOqeMR5H
	 l0n0U+2/oocTk6etM5VtkaHcaXQXg0P4lYu+HfyUkciARbkhWLIwal+RYExzvKAWKxPj2
	 6ZMG9GiGNrY9VxUaKw8kPS06EaF6K9eMSQ6uXo/qqPx5YeE60NHbe50yo9Qd66ZHGiZN5
	 tCn6G4xMNUu83oYakZn99odj8AwYjnuUAI+44JN1EAXplcur8dtTliyxhojMNJ6YtW46r
	 F7UXmtdcHVhcfQrad2ouZm8Ibdq498okg67anHqXSJqVhZkXiLwRbFS8g/iWaF119Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hs88lmycObCyIS57FEw3DJd/YB2da3akD0Vo8DfWWmg=;
	b=YXVuT8l3pK3GoMrF4n1dw2ThQ4hBU6oGi4mmT6RiA+MygE9lPQ8lPSBWJcQ7iApTCc/h
	 dtV3cHodLJgm/EGp0VLpCU7pxd1gpy9RxuUKtoxJYsG1lV89d9akvPDJRcXipJy5Kptz+
	 l+UZynGUTlWJQDyIZPXAMj/sY/VN0cHYnAaI6Z5FSdKQkY0UaOetaHq/0Z1268vc9BlQJ
	 pxVkFGUZs1c2BCo/pVTDHrKrC+QH8MwTY6WlpiXdkfC5Aghg4bPz7HYpTpLhRJWrHG7KM
	 kBalg2h1vKM09XmbR25OCUzCUeYx2ThH82UKc83xlYaaRRtwCsjKw6gm0MLIihMlLYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kL2hGxwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFB606A327
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kL2hGxwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F81F000C1;
	Sun,  1 Nov 2026 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793547519;
	bh=hs88lmycObCyIS57FEw3DJd/YB2da3akD0Vo8DfWWmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kL2hGxwUQTgirusmfhWs+UzBOahV14Lr31VZeZq5JrrNBEh5n4HLuhqRQH4ltb25S
	 erprpy9eIBrSEYyT1ciW+ocAcKATtwbmFk3annbKSiErZNqkDZ8BaMzW6YbmzXeFJA
	 KuhELEBqhIzH4vyPko60dlRK2VHTF1f3UcL7PKAcN1aj4Q+7w8gPTuYUiexcYRlYJX
	 /tCmee1gs4wir2UzVwZxrohG4i4K7Ildz+S8PFOwBBZ00DmqK0JIBqy/sByoadSDW4
	 1+lZ32h7O0bbpoh9dvFT7goNibgoP4NLWFI2FkNGaKcs0t8/NQufkPL7sqV6q5/lEB
	 +lCEaclFBbMcA==
Message-ID: <sashiko-outbox-192480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids
 beyond the PAPR limit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3b233fa135d54d3ffb569d7febdc1cb8e0ed406a.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
 <3b233fa135d54d3ffb569d7febdc1cb8e0ed406a.1793546707.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 15:38:38 +0000
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
- [Medium] KVM: PPC: undeclared KVM_MAX_VCPU_IDS_NESTEDv2 in kvm_arch_vcpu_=
precreate()
--

commit 6b87f3d0f26a22dc1fab90af1a0540a7a33c6a90
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit

This commit adds a check in kvm_arch_vcpu_precreate() to reject vCPU IDs at
or above KVM_MAX_VCPU_IDS_NESTEDv2 with -EINVAL when running on nestedv2,
avoiding failing later in H_GUEST_CREATE_VCPU.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1ca..f82d3545b39ad 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -772,6 +772,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> =20
>  int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  {
> +	if (kvmhv_is_nestedv2() && id >=3D KVM_MAX_VCPU_IDS_NESTEDv2)
> +		return -EINVAL;

[Severity: Medium]
Is this commit missing the prerequisite patch referenced in the commit
message?

In arch/powerpc/kvm/powerpc.c, kvm_arch_vcpu_precreate() checks id against
KVM_MAX_VCPU_IDS_NESTEDv2, but KVM_MAX_VCPU_IDS_NESTEDv2 is not defined in
arch/powerpc/include/asm/kvm_host.h:

#define KVM_MAX_VCPU_IDS	(MAX_SMT_THREADS * KVM_MAX_VCORES)

or anywhere else in the tree, causing compilation of
arch/powerpc/kvm/powerpc.c to fail when CONFIG_KVM is enabled.

In addition, the commit message notes that the previous patch caps
KVM_CAP_MAX_VCPU_ID at 2048 on nestedv2, yet kvm_vm_ioctl_check_extension()
in arch/powerpc/kvm/powerpc.c still returns KVM_MAX_VCPU_IDS unconditionall=
y:

	case KVM_CAP_MAX_VCPU_ID:
		r =3D KVM_MAX_VCPU_IDS;
		break;

Should the prerequisite patch defining KVM_MAX_VCPU_IDS_NESTEDv2 and capping
KVM_CAP_MAX_VCPU_ID in kvm_vm_ioctl_check_extension() be applied before this
change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3b233fa135d54d3ffb5=
69d7febdc1cb8e0ed406a.1793546707.git.ritesh.list@gmail.com?part=3D1
