Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8603D3305
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411825; cv=none; b=dnSuXSRkGOLNIKCVNs+vLQxgQXjA1tDVcCz2tuQ+l4Ws6yz2TRUHGIri7p2vcrEi3zYxn2t2c4QmqsMSJkgoODMH3javghE/vselcyhkAnQl+0x6tN61KqPc9fMZxEmoY222LO8bkxEWU2kFCScmZli/6KE2QeKC04MFWL/P1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411825; c=relaxed/simple;
	bh=OhZyTStBWlFhEEhiOYJYqRf/6aUp3nuKdpjBLKIfNMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cb6XxidAD/2XE+Vqm4tHw0vHOCmBDrvigyOfHPgI6VP8rCD3sO+QyU7ia/RYC+KZQdgTtAnuRBLtkkUaJet70Jm8tA2xrugKgk4oJrobVQGW2AKgrtksvfGgsuMyQ0LxOh8TPPTh64wzWU9oHWIkH9WdzA1jwjOZi4bKHNVV17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHPd4enJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHPd4enJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2E1F000E9;
	Thu, 30 Jul 2026 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785411824;
	bh=QBUgZvjJu2jcNCWXIp1ZUZRZh1tSTDWsxYCD84FWQKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHPd4enJZ18rgLmFo0HLrvrOnnWrtv4N35amD/WG6qF0F/j3GuXKHtfrRh8/IiAYJ
	 E/ZjyciMh81ijhqOl6+/14rU0N7G+hzpfpes8qFXuUXejHiNLPomDFUzzfrD0oJqBi
	 D7Kg5tbUd/lPxA1dRRRQLh2fYfhzv5XLaDeyC6WeXHd/s8YqmdVDKCl2voCx2T2pmH
	 juf8a8c/KVLXk585dNz3vkCZC+6gUhdolHQ/XlYXnAIGr3oxjMoHpbSoBV1gqgCaGA
	 LHg43NgWWpilvWSF4PdW5ASm2kFcIRccoDeFdfDL2Tw/ylDq9o6tXAPgQ+aRq76SR2
	 Grzu47HbvyMQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] KVM: selftests: nx_huge_pages_test: Add TDP
 detection for Zhaoxin CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730110524.2539316-3-ewanhai-oc@zhaoxin.com>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
 <20260730110524.2539316-3-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 11:43:43 +0000
Message-Id: <20260730114343.BED2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete Zhaoxin (ZX) CPU support in KVM selftests due to miss=
ing VMX behavior checks.
--

--- Patch [2]: [PATCH 2/8] KVM: selftests: nx_huge_pages_test: Add TDP dete=
ction for Zhaoxin CPUs ---
commit eac5eaa125fdff453925a87e65268f6af95ed4ee
Author: Frank Zhu <frankzhu@zhaoxin.com>

KVM: selftests: nx_huge_pages_test: Add TDP detection for Zhaoxin CPUs

Update the kvm_is_tdp_enabled() function to include Zhaoxin CPUs when
checking for EPT support, maintaining compatibility while extending
support to ZX CPU systems.

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/test=
ing/selftests/kvm/lib/x86/processor.c
> index a8ea591ebe8e6..4688cb2b00923 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -156,7 +156,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs=
 *sregs, u8 indent)
> =20
>  bool kvm_is_tdp_enabled(void)
>  {
> -	if (host_cpu_is_intel)
> +	if (host_cpu_is_intel || host_cpu_is_zx)

[Severity: Medium]
Since this adds Zhaoxin (ZX) support here, do other tests that use
host_cpu_is_intel as a proxy for VMX behavior also need to be updated?

ZX CPUs implement VMX but host_cpu_is_intel evaluates to false, which might
cause several tests to incorrectly fall back to AMD behavior or assert.

For example, guest_main() in=20
tools/testing/selftests/kvm/x86/fix_hypercall_test.c will hit an assert:

	if (host_cpu_is_intel) {
		native_hypercall_insn =3D vmx_vmcall;
		other_hypercall_insn  =3D svm_vmmcall;
	} else if (host_cpu_is_amd_compatible) {
		native_hypercall_insn =3D svm_vmmcall;
		other_hypercall_insn  =3D vmx_vmcall;
	} else {
		GUEST_ASSERT(0);
		/* unreachable */
		return;
	}

And kvm_is_mediated_pmu_enabled() in=20
tools/testing/selftests/kvm/include/x86/processor.h will incorrectly try to=
=20
read the kvm_amd module parameter:

	if (host_cpu_is_intel)
		return get_kvm_intel_param_bool("enable_mediated_pmu");

	return get_kvm_amd_param_bool("enable_mediated_pmu");

Similar missing checks appear to exist in test_feature_msr() in=20
feature_msrs_test.c for the MSR reset value and in main() in=20
kvm_buslock_test.c for trap-like exits.

Will these tests crash or fail on ZX CPUs without similar updates?

>  		return get_kvm_intel_param_bool("ept");
>  	else
>  		return get_kvm_amd_param_bool("npt");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730110524.2539=
316-1-ewanhai-oc@zhaoxin.com?part=3D2
