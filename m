Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC53CC7D8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579969; cv=none; b=qfcycCQR/lYqvqJIXEidzSg+BQvu4OmZ3/K8sO3JFrXTBd9UjlOf1ky/hOznU2xi85biaWT17pZLx2QDslhZlvFd6mTS/aii2XLhda70mlPGeMcS5TX21WC3dx5pqMhZNj2LJO+4y0r2qR6BPSrMnOUhF0MI9esHxPPeqwtW12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579969; c=relaxed/simple;
	bh=TBsprsCgg0529z4YYuay7yGSSO0D8eAcuUxXOt/qXZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BRCRzpQzGOvheIva2PzO+ll1W6q4Q99cskFZePljRO6232l9A6rL0GU++dVn1UVRoV4rqCemnLu/w3pZ/5foucpjklBgPhzm5S8pCXjIas9vwU31OgEh/Iq+frN0gfeFgfYc7tB63DGmJic9+HRENnNmIn873jju7hU5CQGIqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2DDepnt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2DDepnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955031F000E9;
	Thu,  9 Jul 2026 06:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579967;
	bh=dxKTsgcHJLQzb8Q9iwBLlCE5urpBv/+K4TK2EBdCeGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2DDepnthft3FIx5+6qZFs5HuUE5jnjCunqrKTo3QFhlTYzhFslwIuRNkDd1r3Gtd
	 C8QZYs2Fau45NHQign81Uv2rQMBmLq+vkaIvHnzNjB+gTFBLV5JEJEofrgXumDj+W3
	 V2V83iQpquMUA88xbn7GZIGfgvltDuLUTMhZunPo/zTZWqa6+S1QpvpqEtdYVgZb50
	 1Vt3i9VP8Q7QYIm5s/krPzSvYS/G5qKnmzHGet2ZPDUx2zNnsm32glNSPGIS9JwbFn
	 2qyzYmS51QL+WSlL4Xoyh89aqHeb8zdFZQqfyUGCOM8Ajiw0x/DEDWWYxZONmPquFK
	 3Xu+bsWJ7tamw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KVM: powerpc: Use generic xfer to guest work
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Chourasia" <vishalc@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709062940.1679427-4-vishalc@linux.ibm.com>
References: <20260709062940.1679427-2-vishalc@linux.ibm.com>
 <20260709062940.1679427-4-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:52:47 +0000
Message-Id: <20260709065247.955031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockdep assertion failure in xfer_to_guest_mode_prepare() due to m=
ismatched IRQ state on BookE architecture after emulated MTMSRWE.
--

--- Patch [1]: [PATCH v3 1/2] KVM: powerpc: Use generic xfer to guest work =
function ---
commit ad7243cc79a6e34d4784ae75e8ea35ce946a8343
Author: Vishal Chourasia <vishalc@linux.ibm.com>

KVM: powerpc: Use generic xfer to guest work function

This commit updates powerpc KVM run loops to use generic infrastructure for
checking and handling pending task_work before guest entry. It replaces
open-coded need_resched() checks and adds xfer_to_guest_mode_prepare() to
disable IRQs and handle TIF_NOTIFY_RESUME properly.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..be5e48ae0c6c2 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -81,23 +81,41 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  	int r;
> =20
>  	WARN_ON(irqs_disabled());
> +	/*
> +	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
> +	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
> +	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
> +	 */
> +	local_irq_disable();
>  	hard_irq_disable();
> =20
>  	while (true) {
> -		if (need_resched()) {
> +		xfer_to_guest_mode_prepare();

[Severity: High]
Can this trigger a lockdep assertion failure on BookE architecture?

When a BookE guest executes mtmsr to set the MSR_WE bit, it enters an idle
state and invokes kvmppc_core_prepare_to_enter(). This function enables
lockdep IRQs but disables hardware IRQs using a macro that bypasses lockdep=
=20
on 32-bit:

arch/powerpc/kvm/booke.c:kvmppc_core_prepare_to_enter() {
    ...
    if (vcpu->arch.shared->msr & MSR_WE) {
        local_irq_enable();
        kvm_vcpu_halt(vcpu);
        hard_irq_disable();
        ...
        r =3D 1;
    }
}

If kvmppc_core_prepare_to_enter() returns 1, the while loop later in=20
kvmppc_prepare_to_enter() continues:

arch/powerpc/kvm/powerpc.c:kvmppc_prepare_to_enter() {
    ...
    if (kvmppc_core_prepare_to_enter(vcpu)) {
        /* interrupts got enabled in between, so we
           are back at square 1 */
        continue;
    }
}

This continues back to the start of the loop and invokes the newly added=20
xfer_to_guest_mode_prepare() check. Since hard_irq_disable() bypassed the=20
lockdep state update, lockdep still believes IRQs are enabled. Will this=20
cause xfer_to_guest_mode_prepare() to fail its lockdep_assert_irqs_disabled=
()=20
check and trigger a splat?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062940.1679=
427-2-vishalc@linux.ibm.com?part=3D1
