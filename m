Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DE3BF660
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579897; cv=none; b=AvSdEaG8/Uk0eGpd7v8EzaTV4s9Uti7krilk33f/NUJo8JEFx1/cOyAMGS7qZFaILYv8ViBSl3RDnVjjiDvgwEU1Gi7aMr9h1d9ucQkr0FgeRpXKJZHo7IEdUmoHCDmCl7VVXRmlYZjq8iFjfmYtMQRBhhfNi5rzUFMpcWPpO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579897; c=relaxed/simple;
	bh=30c3dRa15nHBEqPfGiE9F0+qBMdKUJmV4tgKK2Z1cu0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B55DOl6i3RaHY8xaVZMolcwuSBITtq9LTFxCDmpI9sUgZTSf1wflqbMQJ0k3DwTQPvGz4nOr7L3oiPiuWH3qheJwRLg9wfVfnkaCGT5q1ZodpBAbiQURc6Y6CUPEvD8WArKhPAKa48zRtpoFLZF5vGfHOrWqjM3LENkYOkBxq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAi3Dhma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAi3Dhma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4171F000FF;
	Fri,  9 Oct 2026 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791579896;
	bh=XYYbNr4PpSMmhZrTjv/0sPptCKCM4NgDdDCzMu/wujo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAi3Dhma9nwSRsxAc6cNDeP4G9ZIeagO5ZaLpoB6e5bIoyiDkme3LjB14ODFL1CRk
	 1a7Dff7PkXr8ovOEvbZ8CAZeSysmwMm/XxcFPvh0ppPH9Nq7x0OEnxQUrKdWhl+FNz
	 Cs7wLPxNsskszdU5JdImDfnnf1zEgzXihGSiXFcihUTMBfUImzEk0aTDTnl5PGAy5h
	 0eNhxajEs0aOQHip4PHqloIjT+hSzL3ezrKl64TFvqqRBcOUdz0WAD4SS5ecONfSeb
	 H1+Z94HzCbFB0shWfCUbojGMyYWHnr6bWEXCpX1yCENCFt+x6hbLoAPoRV3xRuM/77
	 V7Kjs4zqBUilg==
Message-ID: <sashiko-outbox-166078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: nVMX: don't check PIR.ON when processing
 nested posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261009205036.672523-2-mlevitsk@redhat.com>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
 <20261009205036.672523-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:55 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: spurious vector 255 injected due to TOCTOU race in PIR update
- [High] KVM: nVMX: missing compiler barrier after pi_clear_on() leads to l=
ost L2 interrupts
--

commit 3c2cccabb927f653f71a7a79b1d1600d4fb5f728
Author: Maxim Levitsky <mlevitsk@redhat.com>

    KVM: nVMX: don't check PIR.ON when processing nested posted interrupts

This commit modifies nested posted interrupt processing to no longer require
the PIR.ON bit to be set. It achieves this by replacing the conditional
pi_test_and_clear_on() check with a direct pi_clear_on() call.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ddf6df7bee93b..11362aad2bc8a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4033,8 +4033,11 @@ static int vmx_complete_nested_posted_interrupt(st=
ruct kvm_vcpu *vcpu)
> =20
>  	vmx->nested.pi_pending =3D false;
> =20
> -	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
> -		return 0;
> +	/*
> +	 * Don't test the value of PID.ON.
> +	 * It is valid to trigger a posted interrupt without setting this bit
> +	 */
> +	pi_clear_on(vmx->nested.pi_desc);

[Severity: High]
Does this change introduce a missing compiler barrier that could result
in lost L2 interrupts?

Replacing pi_test_and_clear_on() (which uses test_and_clear_bit(),
providing a full memory and compiler barrier) with pi_clear_on() (which
uses clear_bit()) removes the implicit compiler barrier. On x86,
clear_bit() uses inline assembly without a memory clobber, providing
no compiler barrier.

Without an explicit smp_mb__after_atomic(), could the compiler reorder the
earlier vmx->nested.pi_pending =3D false store to after the ON bit is
cleared?

If reordered, the CPU could execute the PIR read inside
pi_find_highest_vector() before committing the pi_pending =3D false store.
If a concurrent software IPI triggers
vmx_deliver_nested_posted_interrupt() on another CPU during this window:

- It will set the new PIR bit.
- It will set the ON bit.
- It will assert vmx->nested.pi_pending =3D true.

The delayed pi_pending =3D false store would then silently overwrite the
concurrent true signal. Since the PIR was already read prior to the new
bit being set, KVM would miss and permanently lose the interrupt.

> =20
>  	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
>  	if (max_irr > 0) {

[ ... ]

>  		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
>  			vapic_page, &max_irr);
>  		status =3D vmcs_read16(GUEST_INTR_STATUS);
>  		if ((u8)max_irr > ((u8)status & 0xff)) {
>  			status &=3D ~0xff;
>  			status |=3D (u8)max_irr;
>  			vmcs_write16(GUEST_INTR_STATUS, status);
>  		}

[Severity: High]
Could this execution path erroneously inject a spurious interrupt vector
255 into the L2 guest?

By removing the pi_test_and_clear_on() gate, the code now unconditionally
falls through to __kvm_apic_update_irr() whenever max_irr > 0 and
pi_pending is true.

If an L1 guest concurrently modifies its PIR/IRR memory structures during
L2 posted interrupt processing, clearing the PIR and IRR in guest memory,
__kvm_apic_update_irr() can update max_irr to -1.

When max_irr is -1, the code subsequently casts it to u8:
((u8)(-1) =3D=3D 255)

Since 255 is typically greater than the current RVI, KVM would write 255
to GUEST_INTR_STATUS. Can this cause L2 guest crashes or undefined
behavior by injecting vector 255?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009205036.6725=
23-2-mlevitsk@redhat.com?part=3D1
