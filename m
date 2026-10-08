Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3543485925
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450956; cv=none; b=rFhpMR+Byi4Zw+xF2c18I6EJrMAX37PPoSSHpjppNpEAs351arChlTU1Xtf4eLI1uJaoKdo6H4sehRkbzt9uV0HtyLF0RtZdaADk9f9eKojwBCmPSzidOEcpVa7b//bjTPLCsBBMTlAZl7BQcYXL7FPjP8iPZR0Lyvz35ZV9UEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450956; c=relaxed/simple;
	bh=MlLCPrd4NEnT2SJxbUQirubHp0v6gtxgd/wMafuCeUU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nYE1W2THjWVvBmNMW7r5KAw4IBuJjJ9N1TYLRTt2AoluzEseJ/uHjlHsGPISEUK2k1MUmeCO6ATtaGiOI9IsxrsyiHzXDQWIMcONUHX2XC6QoTeomgnftiQ8FgenykdFusFxgm3rtsrWv5KhjWsltSDwTTkCZ1ZJ1QcplVGGu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxtNKA+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxtNKA+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C85A1F000FF;
	Thu,  8 Oct 2026 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791450945;
	bh=PDlhtniwqdMX3pA9pkJPxeP3mg4DptcoSFocNMpjS+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxtNKA+WJBbjlz8ZwEAIYVdHvS4z+cH8uL8n9Ku4Dku74f3rM7TijcobFZ9D6CKyZ
	 PrgOlGaB5L+Zu4V9KblHelvhw8+qnSggtscHfPP34EOMOEKMtjEV8bqr5OtuqtqlpZ
	 rRCYe4PcWxqOmI96DtIm0fOdZK9qpbKsY9+1jmP1s2rwQipkoNkItGEbQt8uWqS/Lw
	 odgai4aDbrFZB8EezTJkr3k5gcNd4RcffHgH9DYJ/6PAI+9DnKKXWhVzrRURWcQELy
	 5uQS6Y3OS6MwXZom+z+UiQ9pqWiVddH5gPacyJodwy16ToPGSkDjCiU9T56XnD56dO
	 FWmlJ6WMBC7Nw==
Message-ID: <sashiko-outbox-163910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Guard against division by zero in
 adjust_lapic_timer_advance()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008090037.86931-1-flyingpeng@tencent.com>
References: <20261008090037.86931-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 09:15:44 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86: divide by zero in __wait_lapic_expire() with nested TSC =
scaling
--

commit 615a870f84e9397c4bfba8db0f187034794e3d9e
Author: Peng Hao <flyingpenghao@gmail.com>

KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()

When TSC calibration fails, vcpu->arch.virtual_tsc_khz is zero. This patch
adds a check to avoid division by zero in adjust_lapic_timer_advance().

>     When TSC calibration fails and userspace never programs a tsc khz,
>     vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
>     software-mode expiry path still calls adjust_lapic_timer_advance()
>     unconditionally on every timer expiration (unlike
>     __wait_lapic_expire(), this path is not gated on tsc_scaling_ratio).

[ ... ]

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 48b019114c196..dc4a669d1d460 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1978,6 +1978,9 @@ static inline void adjust_lapic_timer_advance(struc=
t kvm_vcpu *vcpu,
>  	    abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MIN)
>  		return;
> =20
> +	if (unlikely(!vcpu->arch.virtual_tsc_khz))
> +		return;
> +

[Severity: High]
Does __wait_lapic_expire() need this same check?

The commit message mentions __wait_lapic_expire() is safely gated by
tsc_scaling_ratio, but is that description accurate when nested
virtualization is enabled?

An L1 guest can enable nested virtualization and set a custom tsc_multiplier
in VMCS12 for its L2 guest. KVM computes vcpu->arch.tsc_scaling_ratio to th=
is
non-default value:

arch/x86/kvm/vmx/nested.c:prepare_vmcs02_early() {
    ...
	vcpu->arch.tsc_scaling_ratio =3D kvm_calc_nested_tsc_multiplier(
			vcpu->arch.l1_tsc_scaling_ratio,
			vmx_get_l2_tsc_multiplier(vcpu));
    ...
}

If host TSC calibration failed and virtual_tsc_khz is 0, when the LAPIC tim=
er
expires during L2 execution, __wait_lapic_expire() takes the else branch
because tsc_scaling_ratio !=3D default_tsc_scaling_ratio:

arch/x86/kvm/lapic.c:__wait_lapic_expire() {
    ...
	if (vcpu->arch.tsc_scaling_ratio =3D=3D kvm_caps.default_tsc_scaling_ratio=
) {
		__delay(min(guest_cycles,
			nsec_to_cycles(vcpu, timer_advance_ns)));
	} else {
		u64 delay_ns =3D guest_cycles * 1000000ULL;
		do_div(delay_ns, vcpu->arch.virtual_tsc_khz);
		ndelay(min_t(u32, delay_ns, timer_advance_ns));
	}
    ...
}

Can an untrusted L1 guest use this path to reliably crash the host with a
divide-by-zero panic?

>  	/* too early */
>  	if (advance_expire_delta < 0) {
>  		ns =3D -advance_expire_delta * 1000000ULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008090037.8693=
1-1-flyingpeng@tencent.com?part=3D1
