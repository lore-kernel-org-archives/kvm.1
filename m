Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30B3451A6
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731690; cv=none; b=r2eHItM7hTvwiN+vk6tN5jB3zjfBkoEHI3bI5b6yOI5bKqiaBlouopPqEiM9r96qx//icHIYjhWef7/0XKfUVmFB4w8+EAfk1iMPJ+cg83nkKUiPiy76iUQyjCjAtg/Q+j6CcSMjJDS5RTUg8iZ7OWXIyW+uwLSzAB43Vcqa4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731690; c=relaxed/simple;
	bh=bME4oA9tpPa/Pd4YtZ/a6Z/yLLlRusAD7dXZ+hjRzhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KPGfrDhEFqL0vrQb2HatJXPe58hZE2j/9w4WeDwz8aycy6o2QkH/krJ3OHdqlApx03sXXxNGroHlxFTmsw40Tlb6bjOvRarWTIyqNsLLkQay7Q1VdYLxTGpTjtiX0mtTy0yX652/fZTdwyaN80VEix5c9PA+U3CSrhfdjRGHtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDpt//6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDpt//6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EB1F000FF;
	Wed, 30 Sep 2026 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731689;
	bh=aH11fgT01vairY4XDikhxcmZ6F5A+jGHRoGKI9RigYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDpt//6ZZmSpzfZOD8AOOG/1GaX/FvK/518ubWW/l+jGKAje1KtmvJ8/dLzrzGxlp
	 GKlGaog8fFLcmvExIr+d8YfIqVmGlDX1CqIJoxB9mL0LuBjz4TD85qsqQCzuFNDrkW
	 rfZJL1+FQn12AVZE32SK+UPWfHo2ioBoAx9c9YX9eIRR94yqY3pGKoIoKOrjGthpeA
	 f3xKKVHhK8OPgnRreMrqFk3hVCbxpZ4ZN7hEiMrPtskkLPICZy4EUdi9ErtCt9t3Dj
	 vlmJ+q2NFyEJkPKQVO3J5guupQ2CjKyMsW9xRboFHB+1CNhWPnxlLtPfrj2A+ktkT4
	 kAvudu+No5vfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] KVM: x86: WARN if fixed-1 DR6 bits aren't
 already set when delivering payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930011313.3197688-6-seanjc@google.com>
References: <20260930011313.3197688-1-seanjc@google.com>
 <20260930011313.3197688-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 01:28:08 +0000
Message-Id: <20260930012809.331EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm/x86: host DoS via WARN_ON_ONCE in kvm_deliver_exception_payload
--

commit 55e3dfb3c54d9318de7a4a9b55c84a0a9acf4aa2
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: WARN if fixed-1 DR6 bits aren't already set when delivering paylo=
ad

This commit adds a WARN_ON_ONCE to kvm_deliver_exception_payload() to assert
that fixed-1 bits in DR6 are already set when delivering a #DB payload. It
also switches to using kvm_get_dr6_fixed_1() for the check.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 99518e3265b45..5b3918a4ed521 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -440,8 +442,10 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *=
vcpu,
>  		 * breakpoint), it is reserved and must be zero in DR6.
>  		 */
>  		vcpu->arch.dr6 &=3D ~BIT(12);
> -		vcpu->arch.dr6 |=3D DR6_FIXED_1;
> +		if (WARN_ON_ONCE((vcpu->arch.dr6 & dr6_fixed_1) !=3D dr6_fixed_1))
> +			vcpu->arch.dr6 |=3D dr6_fixed_1;

[Severity: High]
Can an unprivileged host-userspace process trigger this warning in
kvm_deliver_exception_payload() in arch/x86/kvm/x86.c by injecting a
malformed dr6 state?

If host-userspace invokes the kvm_vcpu_ioctl_x86_set_debugregs() via the
KVM_SET_DEBUGREGS ioctl in arch/x86/kvm/regs.c with dbgregs.dr6 =3D 0, it
clears all fixed-1 bits in vcpu->arch.dr6, since kvm_dr6_valid() only
validates the upper 32 bits.

Then, if it invokes kvm_vcpu_ioctl_x86_set_vcpu_events() in
arch/x86/kvm/x86.c via the KVM_SET_VCPU_EVENTS ioctl to queue a pending
#DB exception with an unchecked payload and runs the VCPU via KVM_RUN,
kvm_deliver_exception_payload() will evaluate this newly added
WARN_ON_ONCE before the fixed-1 bits are restored.

On systems with panic_on_warn=3D1, could this result in a host kernel panic
and a denial of service?

>  		break;
> +	}
>  	case PF_VECTOR:
>  		vcpu->arch.cr2 =3D ex->payload;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930011313.3197=
688-1-seanjc@google.com?part=3D5
