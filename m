Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D423395E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084494; cv=none; b=NlQMzq46EGiKX/GXsy1g2JYn4/TYxAE20M3yomzRazQLvHuxM08B1XJettN51IyB7qXu5h7V/zp8zmCsDVF15/Bxlkka8jGWQnoWsSnnJ12R71PYsnap+4uIqVbtYkTEP7f19ZPDDrHHDXJ5ZxIyC/0nvyM1+yaMAmgY8BgX9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084494; c=relaxed/simple;
	bh=6026oorn6tAejK5YWJkpUlgF4jntWsasGZ5R3R4oB2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjLe1IC8iYBUMTtUZg4kLq5hmtTq3i/B/FGZ2eu96T9i2WlwHH/1HW1n/F+3NwmugNoK/Z0ljHIW6aVyQ2doxpcud6AE6g6qo494z0JTSPAsy7qGmqnAQ/BV0ndWPpPCBLrEJkMZ5Sijh2+s9Bmg/gDO5KjDOAVPxPEvbxGj4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suxvc2n9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suxvc2n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7731F00893;
	Fri, 29 May 2026 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084492;
	bh=R7XT3Dpndag/9BOcr9snFll7PVYTUVrpaQojCEtJQeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Suxvc2n9paFNGGmbPzOe4KAJaOJFn00FEk6dQjEdhF+6ET17y2PEt8lae3804SjkJ
	 SnNmU1kpuhyVUwL6SVQbRdf90hHxFrHSGh4sPbRmza2hTnFeCoa7VHnUOPnX4JupCR
	 G6P73iTJ19ZllihfRU3unrrKM+JKLf3hCDfuJz0AFyLnbHBmBfo5Hd+MOL/RmU+6p6
	 WKxzeDFgcvpZB6hybw/V3l3z7LDZGUM8ZUeOJheFL5J1qolP5bqlHQuX8jpCaafD28
	 fgkUUt+q1Ek6nfXfZJGimqEBStfq9HSHisU01pONAPel52o7U+K9aD+TKXjLUWErK8
	 za2LBXTeIfXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/24] KVM: SEV: Reject MMIO requests larger than 8
 bytes with GHCB v2+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-4-pbonzini@redhat.com>
References: <20260529183549.1104619-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:54:51 +0000
Message-Id: <20260529195452.3F7731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-reachable `pr_err` calls without ratelimiting in `setup_vmge=
xit_scratch` allow a malicious SEV-ES guest to flood the host kernel log.
--

commit e862165e67c650ff667c57363d24f101d03cf5e9
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+

This commit updates KVM to reject MMIO requests larger than 8 bytes when
using GHCB version 2 or later, as required by the GHCB specification.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4502,6 +4502,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		if (!len)
>  			return 1;
> =20
> +		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >=3D 2 && len > 8) {
> +			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
> +			return 1;
> +		}
> +
>  		ret =3D setup_vmgexit_scratch(svm, !is_write, len);

[Severity: High]
This isn't a bug introduced by this patch, but looking at
setup_vmgexit_scratch() called here:

arch/x86/kvm/svm/sev.c:setup_vmgexit_scratch() {
	scratch_gpa_beg =3D svm->sev_es.sw_scratch;
	if (!scratch_gpa_beg) {
		pr_err("vmgexit: scratch gpa not provided\n");
		goto e_scratch;
	}
...

Could a malicious SEV-ES guest flood the host kernel log by repeatedly
triggering this error path?

If the guest continuously passes invalid scratch parameters, the function
immediately returns 1 and resumes the guest without exiting to userspace.
Does this allow an infinite loop of un-ratelimited pr_err() calls that
could stall the host CPU and cause console lockups?

>  		if (ret)
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D3
