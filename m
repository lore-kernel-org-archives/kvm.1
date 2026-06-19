Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F335AC13
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902004; cv=none; b=EegF9Em+39IzZgrKfpUJmCRFwO8a1xeCAnNDrOQI4bNRubc7Jq+fEwqSZLTvPxLm0cfDnLObq0VLEiu1Sh1kWbndTCNUtD8ayhH1JpSrABAuGEZ25pUP9VBfWfDbuA1DcpI14ZoCnDJM857TZu+oz4i/2hLhQAlB3UhriirGhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902004; c=relaxed/simple;
	bh=Bq9oNfogEdZAnq2LId/cfY2I/jQUsrr1JrUsDa/t7AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQ8DCT8aX7Ex0xkSb0giVYJo/fY4ubmsvCAlzHqUyyMQ4OGVf8j686sCcr5pIJZq/hmgO82SVlw0cg8Dwck/yuup4DTAS+neVxDJvHRJuARH+g9lZ6CBk8ZpZirAE50tu0SbGuDgDMesSxcUM+cp52tTzgXa5Weq8EIpXRRREys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqIa1H5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqIa1H5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A691F000E9;
	Fri, 19 Jun 2026 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902003;
	bh=5MIayV3GbvRDajQ1xUQQBBwOcj3bhJqI/1bQLo1yGug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqIa1H5I27+3sKMxkWCzL19pWUWJPBhe6zUMYb+l24BocCr2IAr/uRXAmJoydd2fS
	 8jv+an2tqrRiO/Cq+CJ5xhFG1JCiswk7U4SmFxDbhVGwjvII7/rG5M/Rtq/0TURawc
	 tdMB0vCKFeJMh8dqPYlgc8uT3gPwi66rjtSKlu3WB/dYl+5XjVIEqWUOsh1TEwHGFL
	 mVvBPGTspQ3XGz10Ru9DAEL8Gp8PunPnksIArqHwXeRfOblEpErVEDs+8qPpx0XQQH
	 ErP/ZfPxhEuD47sG+F1M5nPO3/MxQrlH/glSaWNAHidDEBv0tcK1/SbaxKVPfH2pIl
	 2/9CQkyB9CL9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest
 pending from Posted Interrupt vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260619203107.2752678-2-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
 <20260619203107.2752678-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 20:46:42 +0000
Message-Id: <20260619204642.F1A691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The condition `if (max_irr > 0)` incorrectly ignores vector 0, p=
reventing it from being synced to the guest's virtual APIC and leaving the =
PIR state corrupted.
--

commit 5c23c313090006d2eae5e26f892baf83bf9030f1
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector

This commit adds a helper to retrieve the highest pending vector given a
Posted Interrupt descriptor. The helper returns -1 to indicate no interrupt
is pending, improving consistency with IRR and ISR handling.

Link: https://lore.kernel.org/r/20240607172609.3205077-2-seanjc@google.com

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bdc462944cb08..7d8e18dbe8531 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -3818,8 +3819,8 @@ static int vmx_complete_nested_posted_interrupt(str=
uct kvm_vcpu *vcpu)
>  	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
>  		return 0;
> =20
> -	max_irr =3D find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 25=
6);
> -	if (max_irr !=3D 256) {
> +	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
> +	if (max_irr > 0) {

[Severity: Medium]
Does this condition inadvertently skip vector 0?

The commit message states that pi_find_highest_vector() returns -1 to indic=
ate
no interrupt pending, so max_irr can be -1 or 0-255. By checking max_irr > =
0,
the code skips processing if vector 0 is the highest pending interrupt.

While vector 0 is an invalid APIC interrupt that hardware typically ignores,
skipping it here means KVM does not call __kvm_apic_update_irr(). As a resu=
lt,
vector 0 could remain stuck in the PIR array instead of being cleared, which
diverges from the lockless PIR/ON protocol.

Should this condition check for max_irr >=3D 0 or max_irr !=3D -1 instead?

>  		vapic_page =3D vmx->nested.virtual_apic_map.hva;
>  		if (!vapic_page)
>  			goto mmio_needed;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619203107.2752=
678-1-main.kalliope@gmail.com?part=3D1
