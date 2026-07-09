Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C613FF8B6
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587062; cv=none; b=VfITsSBVg1VzLH10jXhz1ml8aW0ppC3j6XSEIkRo3notblbfzR9MwW/jmz02OEcWTNNIF6lruyVvbTiMko3b0dXiRctgnTOnOqhV+A/9hdiyGSEmaSOMF+5FyuBfffMBBMNvhAE86JobotRYlcA39nWQ8LL92pUFYWbFcbIVAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587062; c=relaxed/simple;
	bh=9mcmoAdxwzfyHrToIJ366XN37NDJA7hRpsdyD99TOnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6Sqhs05PCdbmhS6SXu1RD2pzorbNIgPfrFQO60L4J+VxKfihyRxx84UGaOLGFEGJaq0kdCh135wp0WYZv+2U6pedI3BtcYYGeqF3HOyb55q9PvEW3vyBLaEEgC7LfQ7MDmQWsSnu5wKXxtFXOS+lpaO4WeifBpFflc7IqbRHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVV8pbx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVV8pbx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04BC1F000E9;
	Thu,  9 Jul 2026 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587061;
	bh=BYdXyTjsO+DbPrjyvacuLMY+cWxHTgtO58obMhwJqvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVV8pbx5zUxyzfn890+Yd3JEyqfBtgiEASPzk5Ko/g/7Nlc3XH2FH0NXcqJboGjXQ
	 aDvXvOlo8c/0yCAkvjs8tNlaNWrnEFqJWDTl+vtB3+ik5F43n1WNl2ua0g3wWaU04f
	 vyLN1m1/XuMIkkHbphmqhQEKa43UX5yvioxVddPdqqe8J2AMqo4X93McZo5FemrrCH
	 Ivp4ps+qygRPuuQk0rPPcq6JLbblBHfjeRfxwyKniseaHQ246AiDa/HqqyUpu1rdBG
	 1nkhH41hEpv2qfep2RHDN7uKrwWyfU6LvqlWrMsP5647pb6NGHPTaXftF7xdqoXTeF
	 2TvyUX6eF7Ofg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082953.69434-4-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-4-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:51:00 +0000
Message-Id: <20260709085100.C04BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch identifies that DR6_ACTIVE_LOW unconditionally sets DR6_=
BUS_LOCK (bit 11) to 1, and replaces it with kvm_dr6_fixed() in nested VMCB=
02 preparation. However, the patch fails to replace DR6_ACTIVE_LOW in L1 vC=
PU initialization and #DB payload processing paths, completely breaking Bus=
 Lock Detect for L1 guests.
--

--- Patch [3]: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_=
fixed() ---
commit 0ee3ae36939ed695ccbd636580058ad35113add9
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()

When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
(DR6_BUS_LOCK) to 1 unconditionally.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 84248e6665cfe..0a9e28a02692e 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -811,7 +811,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_sv=
m *svm)
> =20
>  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>  		vmcb02->save.dr7 =3D svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);

[Severity: High]
This is a pre-existing issue, but since this patch correctly identifies that
DR6_ACTIVE_LOW unconditionally forces bit 11 (DR6_BUS_LOCK) to 1, should
DR6_ACTIVE_LOW also be replaced in the L1 vCPU initialization and #DB paylo=
ad
processing paths?

Currently, DR6_ACTIVE_LOW is still used to initialize L1's dr6:

arch/x86/kvm/x86.c:kvm_vcpu_reset() {
    ...
    vcpu->arch.dr6 =3D DR6_ACTIVE_LOW;
    ...
}

It is also used as a flip mask when KVM translates the exception payload to
guest DR6. Because Bus Lock Detect is actually active-high, XORing it with
DR6_ACTIVE_LOW incorrectly inverts the bus lock bit the guest sees:

arch/x86/kvm/x86.c:kvm_deliver_exception_payload() {
    ...
    vcpu->arch.dr6 ^=3D ex->payload & DR6_ACTIVE_LOW;
    ...
}

Similarly, SVM constructs the #DB payload by XORing the hardware exit DR6
with DR6_ACTIVE_LOW:

arch/x86/kvm/svm/svm.c:db_interception() {
    ...
    u32 payload =3D svm->vmcb->save.dr6 ^ DR6_ACTIVE_LOW;
    ...
}

Could this leave Bus Lock Detect functionally broken for L1 guests by causi=
ng
them to observe corrupted hardware state (false positives or false negatives
for bus locks)?

>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082953.6943=
4-1-shivansh.dhiman@amd.com?part=3D3
