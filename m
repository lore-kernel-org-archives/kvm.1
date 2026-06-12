Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A43093CB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306579; cv=none; b=b5xCgbca35cjSlz6E7ro4F1CZjLQB3mX7GjjTPcODp4Dfw5MgpwA5ejLtxpn8AyVbXmHq4t6/q14veJHuw8iqH0F9L3UxI/HotfLL56+PMD/jHorQ+t0cvPsJYjrR53WQumRJ2dgBb9MKk3SsgSp9ZIKGkIqkw2DTk5r43yykb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306579; c=relaxed/simple;
	bh=fd+S7U+wBJGx0cQ5wTiGFK2aKjiWnJFGRuO0JVACZYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KsNbGazXMwbEiiJweyvekxRRVCKLnPNdaiNQAEFdhten97fDu1EGueCNqRsn7t6ZO1khUYVpP/Ux6GyXWXI2uw7CoYZ8wVlgLal1YQLL/s8XrqbcTP8UThsCSrHmTG1QeuTuIn7bDls6h/0gFDUO2L6qT5qOt28b3L6eH+FiPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShYWGDfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShYWGDfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9131F000E9;
	Fri, 12 Jun 2026 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306578;
	bh=o8FgBv8YvZOHVqAqsHnXGESwvTcJxmuPTwfEwZSwbfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ShYWGDfUikL7UDVvsOFtiLdyFU7/tVGenglvKIdnatZv9FCMEe/3Chz352MFTakki
	 hrKaS8FmqruqFMPDYJR+WK2UZ1IzDKmq12D77s+GrnZzFwZ7gRnVzx7jy27+z7hrbX
	 C71207Cq16cFfWDjKKYzjCtgWantJR+7LeRnY43zLwpXOLhNaDjIrogqxCVQY9Jp60
	 JVziqp8zawwlwNovg0Fl1DX4eFWgwi2WJIC4BoRIXDCzkO5r48IpabOqpqFp67xnFs
	 DlhNebzlTVRX0wMoK79Hw1XDN7CT43/8c3Tpw/UUQ6VGOPwvvBwFtB8qv16ZuqV+o/
	 wQxo93iFnV1dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] KVM: x86/hyperv: Ensure vCPU's Hyper-V object is
 initialized on cross-vCPU accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612230622.687665-4-seanjc@google.com>
References: <20260612230622.687665-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 23:22:57 +0000
Message-Id: <20260612232258.0D9131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete conversion to safe Hyper-V object accessor causes a fal=
se positive lockdep splat and unsafe cross-vCPU memory reads.
--

commit c312f67e4d3ecc2c19765c4ac40bd23b51d526ce
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cross-vCPU =
accesses

This commit ensures the vCPU's Hyper-V object is fully initialized before
exposing it to other tasks by using smp_store_release(). It also introduces
and applies a safe to_hv_vcpu_safe() accessor using smp_load_acquire() to
safely retrieve the object in cross-vCPU contexts.

> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index e6c74cfbb1cb6..821b586ed7464 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -61,6 +61,18 @@ static inline struct kvm_hv *to_kvm_hv(struct kvm *kvm)
>  	return &kvm->arch.hyperv;
>  }
> =20
> +static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Ensure the HyperV structure is fully initialized when accessing it
> +	 * without holding vcpu->mutex (or some other guarantee that KVM can't
> +	 * concurrently instantiate the structure).
> +	 *
> +	 * Pairs with the smp_store_release() in kvm_hv_vcpu_init().
> +	 */
> +	return smp_load_acquire(&vcpu->arch.hyperv);
> +}
> +

[Severity: High]
This isn't a bug introduced by this patch, but should=20
kvm_hv_has_stimer_pending() also be updated to use to_hv_vcpu_safe()?

It currently still uses the unsafe to_hv_vcpu() accessor:

static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
{
	struct kvm_vcpu_hv *hv_vcpu =3D to_hv_vcpu(vcpu);
	...

Since kvm_hv_has_stimer_pending() can be reached cross-vCPU without holding
the target vcpu->mutex via the spin-loop yield path:

kvm_vcpu_on_spin() -> vcpu_dy_runnable() -> kvm_arch_dy_runnable() ->
kvm_arch_vcpu_runnable() -> kvm_vcpu_has_events() ->
kvm_hv_has_stimer_pending()

Could this bypass the necessary memory barriers and result in reading an
uninitialized stimer_pending_bitmap?

Also, won't using the unsafe accessor here unconditionally trigger the lock=
dep
assertion introduced later in the series when accessed cross-vCPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612230622.6876=
65-1-seanjc@google.com?part=3D3
