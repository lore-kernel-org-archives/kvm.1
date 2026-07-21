Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B883D34B1
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611274; cv=none; b=EM4X+9519cWH2wTEKkb9VEwFjI/CDOLM7uJPIGzFwzV93I23Qtk2n+/HvGD8ew+k94NmuhEJsDNdayF/f6WKeY6s9iBEuUHXi5gOF4jmJYn+Q63+G8CuauhUsGM8tTEFOdexSvudyzJv+4vKgNv/2v7DKH8BrXy9Sx8RTjbHox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611274; c=relaxed/simple;
	bh=71dkZgO5a+H7WhZiu6wq/CaWUFvg6UYgesVQHg3iQHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HbQZfg+jFSptobdnC61hEv7XLU0+q0Aawzq8VV4j4J5VeJXLGnYiqS8Hi+y9xMzAPkKbxWP3w13Z97GI7U5BpSeJTP5l5lXTROJi3PU9cLTDToB4haM9IO7sQu3WJ/n7tJp9NRme9PrggU+HQ50mn9o/tusHtpdnOIzuvrI+sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnuosbd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnuosbd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B251F000E9;
	Tue, 21 Jul 2026 05:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611273;
	bh=q8tOKd+jwMp0wxraMtp4n9uBaaUkYdDdOL+L39gwh1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnuosbd6C5OA57R38Spui0F3WGDuJMHEmzQX64TtIvplMILRAQnMUaFY9M/L9AJdK
	 /rIWICLBuC0y6WWZopmlzXvC1N6yd5CTdufJOKouOWcHy9CnsfIq+xFx48sC56qcCF
	 4Ini9Td18OhhEET66Q1oh7piy6vR5t74qkHnie/OBj8rnCMyebeY5okPqGZ2sNs/7k
	 eTJJh3HiqXhO/XN7mxf7RlyrZo0rtCQoY+LU5LLjqM3GEQaeOq4Bn6cQOp+DqZPQYd
	 azA/tybIFfg4KD4IS5weDQWD9GFeE0U7WqIqGnNupmuQpepiIe8ZiVdABJNJ/acajg
	 RhB0UMMyLsUHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260721050600.87268-4-shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-4-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:21:12 +0000
Message-Id: <20260721052113.18B251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_deliver_exception_payload() incorrectly clears previously accu=
mulated active-low DR6 events (such as DR6_BUS_LOCK and DR6_RTM) upon subse=
quent #DB exceptions.
--

--- Patch [3]: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_=
fixed() ---
commit eaefa84a8068404a2e75f11446b9fa345fef2bae
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()

When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
(DR6_BUS_LOCK) to 1 unconditionally.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 8d1967f5c099f..9b1afa47c54c9 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -810,7 +810,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_sv=
m *svm)
> =20
>  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>  		vmcb02->save.dr7 =3D svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		svm->vcpu.arch.dr6  =3D svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);

[Severity: High]
This isn't a bug introduced by this patch, but kvm_deliver_exception_payloa=
d()
in arch/x86/kvm/x86.c has the exact same flaw with DR6_ACTIVE_LOW.

Could it be fixed using the newly exported kvm_dr6_fixed() helper?

Currently, kvm_deliver_exception_payload() executes:

    case DB_VECTOR:
        ...
        vcpu->arch.dr6 |=3D DR6_ACTIVE_LOW;
        vcpu->arch.dr6 |=3D ex->payload;
        vcpu->arch.dr6 ^=3D ex->payload & DR6_ACTIVE_LOW;

This unconditionally forces all active-low bits to 1 before applying the
current exception payload, destroying any previously accumulated 0 bits.

If a guest OS relies on the Bus Lock Detect #DB to mitigate DoS attacks,
and another #DB event (like a Single Step) occurs before the guest clears
DR6, kvm_deliver_exception_payload() will force DR6 bit 11 back to 1.

Because the new #DB payload does not have the bus lock bit set, the
subsequent XOR leaves bit 11 as 1.

Does this destroy the accumulated event and allow a malicious task to evade
detection?

Could this be updated to use kvm_dr6_fixed(vcpu) instead of DR6_ACTIVE_LOW
to avoid clearing previously accumulated active-low DR6 events?

>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721050600.8726=
8-1-shivansh.dhiman@amd.com?part=3D3
