Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00C2C027B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215894; cv=none; b=lW4Qwz4CSFF2PN0sv3rn0JX+ODWxZmDqtIyx2O/Pt0BVs27+HdSJdzLpLufYPDTvkNuBUX6N/yQhShzWAxNv6S/eYtXJMAPveBlRqNIOfCzKaoXvCTUDEOFC37PTJ3+LSssjuK991pM6FgOC9JcnZW9/+PMbGCQ4xbx4YVNOugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215894; c=relaxed/simple;
	bh=k4VL1xA4WxhprAfziH9QRzpD1wPR86Ivn8iRFtrgDy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ThEwPBkNQJMNY+2eIezGWWdFi9ofUmKCcC3g0ZeZBCuQyOWWQaT0w5k+V5+/I8SschTyabz8QM+MLV83KGRC/mVEAE1b8dhpFmLdMkytHtTPjOZS66ySWJNykwfpNVQC5Qnws9nD/YOJEF5xr6+fg8ETkgM8NwtaTTWfyWS9l1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6UJSH14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6UJSH14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5FD1F000E9;
	Thu, 16 Jul 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215893;
	bh=r6Hsl4D4RNAH4xvkPkDcmxOHb9UrFcaZqoRQaK+kvlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S6UJSH14uEkugagMcuuPXQHS4HHJTICWze+aRkeEEF9cYNr5nQ5ZhHmlijsGp3EGl
	 d4DhkkeBTUNwa998lva1z5uRaZNns6nUBfsEdNuiNcKCB0KJFy3IPRAemz6IOl6h0s
	 /lEeaFoASvjqI56iTZnLuiQEURf5LMUuFxvmmRq3ioUn9tLDI+4ZLzKT6aNV5ZMXae
	 Ontc1XQixwrJ7z2Ml0NiwUKhbhqXla5CKg7CKCKPrXKh/cZDbfXKxhFCGff4HFnLEl
	 /v3BmhXU4Hf1j8AfJ23NdK0X+l+nA/c05vKAo0XpDmou6+0lvwmusxvIVzimp9lPQ4
	 8y2jnQZ1GvtKQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/11] KVM: selftests: sev_smoke_test: Only run VM
 types the host offers
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <20260716151706.244987-1-dwmw2@infradead.org>
 <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:31:31 +0000
Message-Id: <20260716153132.AC5FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test silently returns 0 (PASS) if no SEV VM types are offere=
d by KVM, masking the lack of test coverage.
--

--- Patch [1]: [RFC PATCH 01/11] KVM: selftests: sev_smoke_test: Only run V=
M types the host offers ---
commit c4fa8ea2868d0892d394adecf158fe07893c3980
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: sev_smoke_test: Only run VM types the host offers

sev_smoke_test is updated to gate the plain SEV subtest on KVM_CAP_VM_TYPES,
preventing the test from aborting when all SEV ASIDs are assigned to SEV-SN=
P.
This ensures the test runs only the VM types the host actually offers.

> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/tes=
ting/selftests/kvm/x86/sev_smoke_test.c
> index 6b2cbe2a90b7c..bf27b6187afac 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -247,7 +247,14 @@ int main(int argc, char *argv[])
>  {
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
> =20
> -	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
> +	/*
> +	 * Only exercise VM types the host actually offers.  CPUID reporting
> +	 * SEV does not guarantee KVM offers the SEV VM type: when all SEV
> +	 * ASIDs are assigned to SEV-SNP, KVM_X86_SEV_VM is unavailable even
> +	 * though X86_FEATURE_SEV is set.  Gate every type on KVM_CAP_VM_TYPES.
> +	 */
> +	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM))
> +		test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);

[Severity: Medium]
Does this code silently return 0 (PASS) if the host offers no SEV VM types?

If none of the KVM_CAP_VM_TYPES conditions evaluate to true, the program wi=
ll
fall through to return 0. This masks a lack of test coverage by falsely
indicating a successful test run, rather than properly skipping the test.

> =20
>  	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM))
>  		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D1
