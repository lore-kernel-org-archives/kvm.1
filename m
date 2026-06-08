Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C2233927
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946136; cv=none; b=Q3K30IsXDXrc/Wb0dgXTGzeuaoqjt9M5PvYZDnVkg0qsS3iDwI/RI8deEj7ClnOY3dF2/JBDFrepLwxz6//G5c6RoGdhRziQWipnxx7a8dG+thAn9IT8mVpNL8JqXU0OAIH9da3ihyiPE9U/N9oOCggCBUCL+Xd+1ksGMGjd1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946136; c=relaxed/simple;
	bh=m+csobFfQ1EA/yruk7y2I0Cfbr/cl8wa87sH42zQyFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jHQ2+NzQjtA3DjlVZY4rnQl2ZLzlPoXtAOX4Mk7i6svv0c/bb1P/3LkeaJGGCX2MsYvOJZvAl+sapG2AHkLMu4yk8VfPCN4PMX7m+g1PiL2ZZI1HfhUUyAw5hGSt2GNT/LGc8+upzGlnPFdCycUODLCzAiLsBOeGusEj52X6FUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdpn7TEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdpn7TEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DF81F00893;
	Mon,  8 Jun 2026 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780946135;
	bh=pCc/ZiFXy6gxmWkfG0m3nyQfVRN9xEK5HI1Kej+DFSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vdpn7TEiU2l1KRB035rMbOabVdJYcYo/5FqwkenDfujfcQanz610PX9y/3K+d5vTq
	 cpgos6fARNe53UJwEhFQHqkIgCbc6zxSRjFKEGQXUQPeJGebg7r/by13El+wyGgniT
	 yRx3m60V19ojyybngRjjvfshi3L9Ph4qKNK1HhObbWExicGB/wPcKfr3+hpHt3ImX0
	 6tznsFKP/43E5vy4P3MzLN9lBZJD7sW4mgzl/WkktnE3i2oLrdfFqxYHMMGmMZ3xTo
	 LeTqm+g19MtJ9F1BwCN2vIu/Ee6o4yCUqI8gT+wfSdBSUrsPRZi3O6Ujjn0/yamTON
	 OMtQmiYsqcb/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/34] KVM: x86: Allow KVM master clock mode when
 TSCs are offset from each other
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-22-dwmw2@infradead.org>
References: <20260608145455.89187-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:15:34 +0000
Message-Id: <20260608191534.F3DF81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Guest pvclocks are not updated when all vCPUs re-synchronize the=
ir TSC offsets, permanently depriving the guest of the PVCLOCK_TSC_STABLE_B=
IT optimization.
--

commit b05710eb6e19ddef655898395dce759387bbe84e
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Track frequency matching separately from offset matching

Previously, a guest writing different TSC values on different vCPUs could
force KVM out of master clock mode. This patch separates frequency tracking
from offset tracking, allowing master clock to persist despite offset
mismatches, while maintaining PVCLOCK_TSC_STABLE_BIT semantics.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ac66f8e7116f..86c30be4c5d2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2647,14 +2647,37 @@ static void kvm_track_tsc_matching(struct kvm_vcp=
u *vcpu, bool new_generation)

[ ... ]

> +	/*
> +	 * To use the masterclock, the host clocksource must be based on TSC
> +	 * and all vCPUs must have matching TSC *frequency*. Different offsets
> +	 * are fine =E2=80=94 each vCPU's pvclock has its own tsc_timestamp that
> +	 * accounts for its offset.
> +	 */
> +	bool use_master_clock =3D ka->all_vcpus_matched_freq &&
>  				gtod_is_based_on_tsc(gtod->clock.vclock_mode);

[Severity: Medium]
Will guest pvclocks be correctly updated when the final vCPU synchronizes i=
ts
TSC offset to match the others?

Because all_vcpus_matched_tsc is now decoupled from use_master_clock, the
broadcast that restores PVCLOCK_TSC_STABLE_BIT across all vCPUs appears to =
be
broken, causing a performance regression for guest vDSO time reads.

When the final vCPU synchronizes its offset, new_generation evaluates to fa=
lse
and use_master_clock remains true.

Therefore, the existing condition further down in kvm_track_tsc_matching():

if ((ka->use_master_clock && new_generation) ||
    (ka->use_master_clock !=3D use_master_clock))
        kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

will fail to trigger the KVM_REQ_MASTERCLOCK_UPDATE request.

Other vCPUs will not get the broadcast to run kvm_guest_time_update() and w=
ill
be permanently deprived of the PVCLOCK_TSC_STABLE_BIT optimization until an
unrelated event forces a global clock update.

[ ... ]

> @@ -3527,7 +3566,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
> =20
>  	/* If the host uses TSC clocksource, then it is stable */
>  	hv_clock.flags =3D 0;
> -	if (use_master_clock)
> +	if (use_master_clock && ka->all_vcpus_matched_tsc)
>  		hv_clock.flags |=3D PVCLOCK_TSC_STABLE_BIT;

[Severity: Medium]
Without the KVM_REQ_MASTERCLOCK_UPDATE broadcast mentioned above, will other
vCPUs ever reach this code to restore their PVCLOCK_TSC_STABLE_BIT flag once
ka->all_vcpus_matched_tsc becomes true again?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D21
