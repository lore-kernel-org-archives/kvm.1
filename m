Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C205442FBE
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406190; cv=none; b=Dami+sZMIkMFWEvH6A+KZKgWroZWBtPu7q1WorDFPNmfcxB1r7UAAhzElXu02NqIZAhdwXkGx9z4UobAaAAXYTFeKHqI3j8eR1tFCalv2R6QwvcLX+pHSqCLb3XXRQM3nUGkKSwtJAiMdLlkPw1kj6gsnPcoyXnULA4BITc77CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406190; c=relaxed/simple;
	bh=5DuEM/ftgGAIcKI4hFwUMAK/cSTQpIDTFGDMnakCpnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7xRet//z2IcDIXfjmwv1/9+nfp7rDJ8x+NuD6iaNNPKZRkqoGgSa9xHRfbFV8F8iK+dcFgDWTEztmyToG+BGfbs4ddHnfcqhvbGdOqjTvExKJk1/3yR4mD+qtDdES0Idfi916zEnDEE6k8VjqysCVP7L8W7kaGDwqM3ALWYiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHoSih1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHoSih1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4631F00893;
	Mon, 14 Sep 2026 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406188;
	bh=cQD0NIeHy9Xyk/VCDwdPUqgvE6vx8qZgGecvkac/LFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHoSih1K9bbi7uRviK+k6tC3Q+j6CK+7igks4iONsTxCGsqDK/CubNhU2y11Nc0Mu
	 /fbKJr4sjql9zYHCVGaZdOLlLL6+EjAEezILIa+HYS18BV42Y+xr4cwLnauh+756lC
	 ROXYsor3iKzCKK81ogGjx52QsfQXX47+ZgM0GEkxUwW+/CNNJCHGfO3T7Xb0Hz3NUg
	 d7F2gx/mNNMoghNIQewgnK/WP/2Lg1EPdBODHf/NWx+Nuoy8gSAp1YExatbEoHKyBb
	 9CIigEqQpKmzyzPVK7I0Yr3iZWv8uYCNyJBlUkYQ9K6H3OtEKY2oZrLC70CBgdxixo
	 Ak2TvuwjeDHeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
References: <cover.1789399214.git.prsampat@amd.com>
 <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:16:28 +0000
Message-Id: <20260914171628.8A4631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] svm_complete_interrupts() incorrectly checks if (control->event_in=
j) instead of the SVM_EVTINJ_VALID bit, which can silently drop valid hardw=
are-reported events (like guest page faults) by clobbering EXITINTINFO.
--

commit 50716e3ba11eb9d000a0186ffad984ac08df1dcb
Author: Pratik R. Sampat <prsampat@amd.com>

KVM: SVM: Re-queue events that were never injected

When injecting an event into the guest via the event_inj field, a non-zero
event_inj value on #VMEXIT means the hardware was unable to inject it.
This commit adds a check to recover potentially lost interrupts by detecting
an undelivered injected event and re-queuing it.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d0971685034b9..e2be2cd86c320 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -4323,6 +4324,27 @@ static void svm_complete_interrupts(struct kvm_vcp=
u *vcpu)
>  	svm->nmi_l1_to_l2 =3D false;
>  	svm->soft_int_injected =3D false;
> =20
> +	/*
> +	 * Hardware clears EVENTINJ field when it injects an event.
> +	 * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
> +	 * mode, and thus that the event was never delivered.  Migrate the event
> +	 * to EXITINTINFO so that it's requeued instead of being dropped.
> +	 *
> +	 * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
> +	 * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
> +	 * without having injected that event into the guest.
> +	 *
> +	 * Clobbering EXITINTINFO is safe precisely because the vCPU never
> +	 * entered guest mode.
> +	 */
> +	if (control->event_inj) {
[Severity: High]
Does this code silently drop valid hardware-reported events?

If an L1 hypervisor sets event_inj to a non-zero value but leaves the
SVM_EVTINJ_VALID bit clear, hardware will ignore the injection and won't
clear EVENTINJ.

If a genuine exception occurs in the L2 guest that populates EXITINTINFO,
this check incorrectly evaluates to true since event_inj is non-zero.

This causes EXITINTINFO to be clobbered with the L1's invalid event_inj
data. Because the clobbered value lacks the VALID bit, KVM will then ignore
it and drop the event.

Should this code check the SVM_EVTINJ_VALID bit instead of checking for a
non-zero event_inj value?

> +		control->exit_int_info =3D control->event_inj;
> +		control->exit_int_info_err =3D control->event_inj_err;
> +		control->event_inj =3D 0;
> +
> +		exitintinfo =3D control->exit_int_info;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789399214.gi=
t.prsampat@amd.com?part=3D1
