Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545100;
	b=E5PdCNlSHj3Pw2/q+XpijD5v3sOxSPuP2PdPE+ig41omKImf7bsqplxJds23Tf4bJ0sY
	 NNClkBBGdaQbjTihPAFT/kXdDYqaqk3/u/mVq5OTV561S2BWMgM4ztXf0zNz3HKS0bo3Z
	 wG89NnsfnSPmG21e49N1qf9+P4TDkvhDcb1IMu1+C5pjvRtKzOmxBmX6QL3jXySbxAYbm
	 oU37Us60gGNk/OMjZG78uqCvAyaVFg+UlLx0hVB4c+qTw1H3A8FVc9ZZ2WZEedB1hQKty
	 CPq3Fetx05c+VuSCq3mbpT7D7tFxrTFTFk121yM4e7tZiIaO2kcWNaKbCWYwFXl+Dpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s4F0Gc/epIyD0iTLx8KA+5MdWA5rfq4bhGKZDrNipJo=;
	b=LQFUu5oR73T7QBm3fGiOevrSvt+i2wAWqMoT0adRDmm9R+F/JXHC102nATzRMTcntsfS
	 ryX15jhn056bfLs0AGhHnNuAHK0AEU5P3Qijj173okCY7/eP65xBXV3kMDOwzNjnBksx2
	 D2YLstSZczTk2rt5kR+22iCpV/1QIgHhmdZd3HOs96fXBrZrORb6sQ/cbNG+nA7JxcVkk
	 qpEZxMKT+xeauQ+G2YJ+yBmOO+LCag1DqgkquQvKAR96gE4Yz8vDvNxVcQF81gZ3Sgk31
	 RRDr6CMIrTb40v7TsKrzHs10jvdcS2szV+0V1zf+f+FZE3WVFJdIT3qMXHWAwTKQohQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAuvE+O5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E5606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAuvE+O5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C91F000C1;
	Sun,  1 Nov 2026 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793545100;
	bh=s4F0Gc/epIyD0iTLx8KA+5MdWA5rfq4bhGKZDrNipJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAuvE+O5yGAmOJ0eDn10iEWNAVtWRTdff4O7sTNBplxJ7Q7JEnS6LlEob/E8fU6rU
	 L2VrnbfPfntYE/Ko0mdr+R7R2LKbQv7mdI1ous77wtay4lLURCQWq3xeV8CXlPrNde
	 mCfNKNRHM5z+OXNTNi1vy8fq9EXzo7ZFpY7ZMT3ZlAhTg6OV6MXQUkY2Tuj0SFrJj6
	 B4MP7ZH2iNnNdTMaX0Od4JwS05UvnNm3PKpYJc06OUpnwNTjCwJ1AF6pmYAD36xyEd
	 SZMPPz6HyfZwaEByud2h6ZN+OoI5U3E3N8a0MGCg8MxdfSXEVSmbOdj86RbDISJlHO
	 PGR7Xi//ThUMw==
Message-ID: <sashiko-outbox-192462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids
 beyond the PAPR limit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <183d9a0e755f3735ebd531accb9c193cb40317ce.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
 <183d9a0e755f3735ebd531accb9c193cb40317ce.1793543627.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 14:58:19 +0000
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

commit f56e9e3141b7693c524f0cc29414b94ab8a0b784
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit

This commit adds a check in kvm_arch_vcpu_precreate() on Book3S HV nestedv2
to reject vCPU IDs at or above KVM_MAX_VCPU_IDS_NESTEDv2 with -EINVAL before
reaching the H_GUEST_CREATE_VCPU hcall.

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
Is this missing the prerequisite patch referenced in the commit message?

In arch/powerpc/kvm/powerpc.c, kvm_arch_vcpu_precreate() compares id against
KVM_MAX_VCPU_IDS_NESTEDv2, which is not defined anywhere in the tree, causi=
ng
compilation of arch/powerpc/kvm/powerpc.c to fail with an undeclared
identifier error.

In addition, kvm_vm_ioctl_check_extension() in arch/powerpc/kvm/powerpc.c
still returns KVM_MAX_VCPU_IDS unconditionally for KVM_CAP_MAX_VCPU_ID:

	case KVM_CAP_MAX_VCPU_ID:
		r =3D KVM_MAX_VCPU_IDS;
		break;

rather than capping the capability at 2048 on nestedv2 as described in the
changelog.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/183d9a0e755f3735ebd=
531accb9c193cb40317ce.1793543627.git.ritesh.list@gmail.com?part=3D1
