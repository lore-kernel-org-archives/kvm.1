Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAD33F8D6
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936675; cv=none; b=eINyoZqCMyPzQKwiJQC9aB93PDAzj1Bj+dnVUNnkDrplZ4j1kl0jAdL+9L4jW5pmbZCD1fM6ID3CDM5AqIw6/nEs9Al2Azps+3Zg5oXXOzJN/YGdkKoD51J3EhE2tC3pK7DbMkOp80X3n1f9ezRNC7zUHd132w5wR7IYuoJEYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936675; c=relaxed/simple;
	bh=XNFOeKXks6an52eTmeRmZ6VvMe5nElYpNCKDNdPtQpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2naQOVkficHkAneKsC1yRbh8aL+B1spZJvbNVBipQ30NJFaQQkQzfzyJQQGPz88PyoddWFy9ZSHfcG76hx6/V0fwHfXdCyYSKgJshBgezeke/6ZULHuUCLRam7q8c+ckLvnIhoZb0C92lN/Q3NgYB6VVOs5FTWDtGjScV0J3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX1+WOFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX1+WOFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CB51F00893;
	Mon,  8 Jun 2026 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936669;
	bh=X9oaJnHDSK5zqTwCBUFn73LR5p6Ik4xGoVOXGK4JDhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LX1+WOFpehCIih+7LJoRyCHRum2qTe7PdK0r/gmevYeTd2lIerWiAc/rDd8A62Wxw
	 4Rinv1bLsOrVsXlqyrWgJBwshZhY45sWeL0ItIUQMg7HicYC6cNulOvWAz5suOoCH9
	 lkoTXvac0Mb6vpGBf2OGWtHQz7rUq3aIfSGQwLb1IWeyRE6NIal824KBgvzw8plaRa
	 mkLY51JAxXq4GmdOUk9sxpbOP4vRjnrrRMC0LX7w4gAE9xQ2Zc3qNrQyX+Ild/+fTJ
	 PaR8oARuvLiG9xvV+LRhUsDRkxrFLr5NINn4rgKk+IrZxRZpI4r6Jf6PKFRGn8IY7H
	 I0bHD3sLPBN8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/60] kvm: Move kvm_vcpu mode and requests field to
 struct kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-21-joro@8bytes.org>
References: <20260608144252.351443-21-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:37:49 +0000
Message-Id: <20260608163749.83CB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kicking an inactive plane consumes the shared `IN_GUEST_MODE` tran=
sition but sends the IPI to the wrong host CPU, leading to lost wakeups.
--

commit 88d15ceb3d5f247a97568016e3edb271e847d58a
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move kvm_vcpu mode and requests field to struct kvm_vcpu_common

This commit moves the mode and requests fields from the per-plane
struct kvm_vcpu into the shared struct kvm_vcpu_common. This ensures
these states are shared across all planes of a given VCPU.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 45286b3b35c9f..7704820986da5 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> @@ -630,7 +631,7 @@ static inline int kvm_vcpu_exiting_guest_mode(struct =
kvm_vcpu *vcpu)
>  	 * memory barrier following the write of vcpu->mode in VCPU RUN.
>  	 */
>  	smp_mb__before_atomic();
> -	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
> +	return cmpxchg(&vcpu->common->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);

[Severity: High]
Could sharing the mode field across planes lead to permanently lost wakeups
when an inactive plane is kicked?

If an inactive plane is kicked (for example, if kvm_get_vcpu_by_id() returns
plane 0 while plane 1 is active), this cmpxchg will successfully transition
the shared mode to EXITING_GUEST_MODE.

However, when __kvm_vcpu_kick() subsequently runs, it reads the per-plane
vcpu->cpu field:

virt/kvm/kvm_main.c:__kvm_vcpu_kick() {
    ...
    cpu =3D READ_ONCE(vcpu->cpu);
    if (cpu !=3D me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
        ...
        smp_send_reschedule(cpu);
    }
}

Because the kicked plane is inactive, its cpu field may be stale or -1. Will
this cause the IPI to be sent to the wrong host CPU, leaving the active pla=
ne
running in the guest?

Furthermore, since the shared mode was consumed and is now EXITING_GUEST_MO=
DE,
would all subsequent kicks to any plane fail the cmpxchg and be ignored unt=
il
the guest naturally exits?

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D20
