Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C515347FC4
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090371; cv=none; b=EB4flsS4h7BT7yLl/JgcWvlHkmGdofuyvjpXxjNaTbyNEEecISPLVIuMjTaiKaPBBlyVdmgxyynuiQNf29ueX6hoxv1KidbQj6Fa0KddXs3uWpI2Rz9k0yrAQw84VhzQjHB3hNJQpSvn+dGf6Ro6jjWJ1ESviU0736VoTN5YMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090371; c=relaxed/simple;
	bh=AFC8T19hFiKJfx6iS8WDPzc+QjrCYCJ/5+4fMDRwf90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qfxo79UaCkTCr1sffzdqd+ZPEo/wrh+k95GlT8YpsxhUgx2IRlBbAZwhSzseVZ7fj5XAapdqdSH+jrkDCtZ68kuQGlUBRsXCfC6kLOYvEPFcH+x+7jD+h3FaiwftxjklCHwZGCSRDRN8KUps7p3ZK87pVlXNhUKSCLAuUAHTtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B04BXE6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B04BXE6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ED61F00893;
	Fri, 29 May 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780090369;
	bh=LW3AFhRDnuQy9+mRlB5phH4llUYTgcPuDq5FH5sFUdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B04BXE6b+1pElTsZQKSwfH0rqXb3lTxrrQwJ2jyTgXn+93c9Wxxcu/6nPq49O7Zcd
	 CDvRFgWTVO207SnIL/siD9ZFTlj1RC4SbMtQnebGuzVt9XCnjUj1Zgbu5D5nq/uSJ8
	 aFHO1j72Jfgf+42gn9rEb3nN3uyRrpGfdPCIbZI7BRoKsEfyN1HCxluh0xxgnhtfOc
	 ihOp8OhQPN5cU9LbFbS/PzpZe/ugHlWu+JOD3oObwJsSTxTLVrq3DLrHHj3T8quqEu
	 E3KYntDH7pNccn+fjJKuIlRyxaxn8m8zq2vyIZYE+TYGRpK8WBvc2PYn2ZO2rSl9ni
	 4WJ3zGXljqsjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/24] KVM: SEV: WARN if KVM attempts to setup scratch
 area with min_len==0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-8-pbonzini@redhat.com>
References: <20260529183549.1104619-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 21:32:48 +0000
Message-Id: <20260529213249.43ED61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-triggerable non-ratelimited `pr_err` messages can be spammed=
 to flood the host logs, leading to a host-side DoS.
--

commit f2dbe3638336199969535efb957ca83d946dd1f5
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: WARN if KVM attempts to setup scratch area with min_len=3D=3D0
   =20
This commit adds a warning when KVM attempts to configure the scratch area=
=20
with a minimum length of zero. This guards against future bugs, as all
paths are now expected to provide a valid, non-zero length.

Link: https://lkml.kernel.org/r/20260501202250.2115252-8-seanjc@google.com

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3669,6 +3669,9 @@ static int setup_vmgexit_scratch(struct vcpu_svm *s=
vm, bool sync, u64 min_len)
>  	u64 scratch_gpa_beg, scratch_gpa_end;
>  	void *scratch_va;
> =20
> +	if (WARN_ON_ONCE(!min_len))
> +		goto e_scratch;
> +
>  	scratch_gpa_beg =3D svm->sev_es.sw_scratch;
>  	if (!scratch_gpa_beg) {
>  		pr_err("vmgexit: scratch gpa not provided\n");

[Severity: High]
This is a pre-existing issue, but could a malicious SEV-ES guest intentiona=
lly
provide a malformed scratch GPA and repeatedly issue VMGEXIT requests in a
tight loop?

Since this pr_err in setup_vmgexit_scratch is not rate-limited, the continu=
ous
VM exits might flood the host kernel log. Would it be safer to convert
guest-triggerable log messages like this one to use vcpu_unimpl or
pr_err_ratelimited to prevent host-side log spam?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D7
