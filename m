Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B4246BCD
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678310; cv=none; b=rJmGg/aMHW0HZ/fxqD2ZjpZkMNuQHTCnmsm4DsKLOGUkFQ4nLZyvqdL+A5opPVjl/xy6QNQEfcxv60QMyTJY0A+e6h/JC8GeMctaPM7nS89RLYogof6AOLu0QiGR8Hwl6MG00Grmh8BSukC0iCFqwTuBJTcmKrSNfdRhdihfB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678310; c=relaxed/simple;
	bh=DBMaZSyqIFm/snrlt75jUplSPJN9y1okhhiTmaXI5YQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FOyg3KgX0NZY06zQN6w0czvVrj0JM36l8gQ+eCbVcG0wzkcXkaExWcRJJn/t3x/glaDil1GgO+QYis7CDggkCVBX4xjUiUvWfCJm9sd6ruqLAih7KM77rJ5x6a6jWo/75NAvXR6rqCgRE4WwnaQ8iVyacB80XvdU5s9qQ7mCWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed+XR8AY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed+XR8AY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9461F000FF;
	Sun, 11 Oct 2026 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791678309;
	bh=6+P0c7V0NNBt228U1TJYNo20dEfG0Br9pl4jAA1zRtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ed+XR8AYoOodzUFIYL0J5aaReZuT3uNkGhhHE87KVWclQjHvyhEF4sj7N2/JMLUON
	 TJ+w9Sc3uWqSaWVKCWIZgodsd+zXkDlN43wehhjaeKX2EAn5hhGRi1ez+xhe4n09wn
	 v1ukanioyb7qEgrHHdjNBW4w7SZQFbZj8R9Wle8RRgvrp4WH15rRxF9ajTzM4tqfpn
	 p8nahr9FYvsPoSK9XSkK0wL69prx0VCXVKeTxNcgixuIN4czjgDUeX9xadKOMc/Mla
	 9lZLq99p2ElQgaoJcAIUXgL//KD4fhyk6DlNYEWFIiOGcitK12Q5O+AGR5mCL8nxh1
	 4QsOCUyYC5FyA==
Message-ID: <sashiko-outbox-166942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: nVMX: don't check PIR.ON when processing
 nested posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261011001303.723721-2-mlevitsk@redhat.com>
References: <20261011001303.723721-1-mlevitsk@redhat.com>
 <20261011001303.723721-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 00:25:08 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/kvm: direct usage of __smp_mb__after_atomic() bypasses KCSAN
--

commit b3864bd32325846a2ccca43a4ce66f3b92dcb341
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: nVMX: don't check PIR.ON when processing nested posted interrupts
   =20
Despite the suggestion to test and set the PIR.ON and avoid sending
a posted interrupt if it is already set, there is no requirement
for this bit to be set for posted interrupt processing to happen
when the target CPU receives the posted notification vector.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ddf6df7bee93b..50548e3483181 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4033,8 +4033,16 @@ static int vmx_complete_nested_posted_interrupt(st=
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
> +
> +	/* Ensure that guests sees the change to PIR.ON before KVM harvest
> +	 * the PIR
> +	 */
> +	__smp_mb__after_atomic();

[Severity: Low]
Does this code intentionally bypass KCSAN instrumentation?

By calling the architecture-internal macro __smp_mb__after_atomic() directly
instead of the generic smp_mb__after_atomic() API, KCSAN instrumentation
(provided by kcsan_mb()) is skipped.

While this does not cause a functional memory ordering bug on x86, it viola=
tes
kernel API conventions and could lead to false positives when running KCSAN.

> =20
>  	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
>  	if (max_irr > 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011001303.7237=
21-1-mlevitsk@redhat.com?part=3D1
