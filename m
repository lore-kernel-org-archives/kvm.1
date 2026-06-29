Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FB3F58DF
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721920; cv=none; b=nDoiKhNKZtV69qAXttJy9Vg38TVKSHuDWzmiLbHrXonDizClc9QH0kSHdzyF5jaQ2OPAhotxGLuc6rnJUHqyrjNsh50GW+UhOLyPB3/U9uwi2x2MOomvsyCnBLVViL+L2ABrXyYQ0rSlE/KVkSUKov7ItGMbSvpuoK2+qlD26ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721920; c=relaxed/simple;
	bh=v0Vz5LRyfEj2M3C3U/KZzB8124hX+LVohUrXyefRk6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E3lqHDKJHYWXqcLM7KUu827kaw7Ju5cXqkVr1G1XskZA7SNSeSNFg/P0wVVC+vo175KyvWmWBHaZCxFLXE8FNWGKKa8xsLtcjkXdmKxHAVDo6D7Cp6Cdg5UljRsFq4E1y+V69meOc/84bURZBewQ3JctS8rOqMRvds+CnEdmXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb8X67rZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb8X67rZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175D1F000E9;
	Mon, 29 Jun 2026 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721919;
	bh=YN5Yf6C2fnzWVyotnVeZN8xTo9IDyNRMMIOJgShpHBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kb8X67rZn3Olu2MNJ3h2RI1sBOArkhtmfQrHvpvCwzc7VxTTa9vkT5HVJ4SPO32wN
	 0Q2OBCPZF5SLKbvT1Ck+h7Xu6poxV17t9xYBTHYsx5oATnMjihEoRtm2m4eBjap2zM
	 ATRUpaJxUf7E531tXrmBltc+pvVF8MReM0vKAFGvV/uBjsdeTrmIcDhFI0ZvyD7429
	 x4fZ6mrcnRV9LxjyBvwdHMPlUCyBpNAfpi4N4f4BYirvpAfKZZFFO+6Q1ZTQduYhdh
	 M0RrExvhpaB7bBc49lsjDS8TnoCqhYBI8OELs0O9RWMWutJhGnm88Ti4TTvFF76sEx
	 FOnmviMlcg3lQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2] KVM: SVM: Add Bus Lock Detect support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629081018.60618-1-shivansh.dhiman@amd.com>
References: <20260629081018.60618-1-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:31:58 +0000
Message-Id: <20260629083158.C175D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Nested DR6 fixed bits are manually calculated incorrectly, break=
ing architectural invariants for Bus Lock Detect.
- [Medium] L1 guests can bypass CPUID limits and enable Bus Lock Detect for=
 L2 nested guests via the nested VMCB, even if X86_FEATURE_BUS_LOCK_DETECT =
is disabled for L1.
--

commit 859bd7557c537342acbc2ffe091acc01a0a180b9
Author: Ravi Bangoria <ravi.bangoria@amd.com>

KVM: SVM: Add Bus Lock Detect support

Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
Virtualization is enabled. Add this dependency in the SVM.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index c1485c3e691c4..4fdc58d38afe0 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -808,7 +808,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_sv=
m *svm)
> =20
>  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>  		vmcb02->save.dr7 =3D svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		/* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
> +		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;

[Severity: Medium]
Will this assignment cause an L2 guest to incorrectly observe DR6 bit 11 as=
 0
if the guest lacks the BUS_LOCK_DETECT feature?

By bypassing kvm_dr6_fixed(vcpu) and hardcoding DR6_FIXED_1 | DR6_RTM, it
appears KVM fails to force bit 11 (DR6_BUS_LOCK) to 1. If an untrusted
L1 guest without X86_FEATURE_BUS_LOCK_DETECT runs an L2 guest and writes 0
to bit 11 of vmcb12->save.dr6, won't the L2 guest read DR6 and incorrectly
see bit 11 as 0 instead of 1?

>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 716be21fba335..c65dc3acb5d1d 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -783,7 +783,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> =20
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK=
_DETECT))

[Severity: Medium]
Could this redefinition allow an L1 guest to bypass CPUID limits and enable
Bus Lock Detect for L2 nested guests, even if X86_FEATURE_BUS_LOCK_DETECT
is disabled for L1?

Looking at nested_vmcb02_prepare_save() in arch/x86/kvm/svm/nested.c, it
copies the nested guest's dbgctl MSR value directly into the hardware VMCB
using this mask:

	svm_copy_lbrs(&vmcb02->save, save);
	vmcb02->save.dbgctl &=3D ~DEBUGCTL_RESERVED_BITS;

Since this mask now allows the bus lock bit unconditionally without validat=
ing
against the L1 guest's CPUID limits, could an untrusted L1 guest with
X86_FEATURE_LBRV write DEBUGCTLMSR_BUS_LOCK_DETECT to vmcb12->save.dbgctl
and successfully enable the feature in L2?

> =20
>  /* svm.c */
>  extern bool dump_invalid_vmcb;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629081018.6061=
8-1-shivansh.dhiman@amd.com?part=3D1
