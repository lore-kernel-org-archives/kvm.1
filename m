Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C150E54B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199906; cv=none; b=ggRfIHPN1Nm/R+BDiITl9d4yLJ9hI2lrMAlQHCfReDY5Qj64A8QRtiVbL3X5UoMFY1Hx2SzMgJgjUUFbeppcDKbXwRC41pmlysb0epOnqPSnOm79Y4VEkjv7KUk1FgcfFXM9uRSB71MiEoz0iLRYJtKS63zBiQMUBupkV0dwB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199906; c=relaxed/simple;
	bh=oBtw+WSpwtymPSjaZNIAS40Gfj3mkN9PvJqb4RLtByw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KfWIAuH46vyetIG/1Ghx6jajB1aquCCBxqL8Al0f+YtSsSTSqyjdhJJjwl0OE9dMfLWAyoGKRheg64jBKBVJqxgZgCURiqT8zqNB6yx/uqvZPsDgkk9ksBAdcUUwl/BdJHIiKBqwS7VQ+fv2dYhuruBbju5Trzq0/zwYQNOFCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g13JB6MO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g13JB6MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9D1F000E9;
	Tue, 28 Jul 2026 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199903;
	bh=PgARvOT1xYq0cdpv95Czb7+ykAlH33jmcOXpfDfrlT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g13JB6MOedyJbPQ43sdHRXSRhNQtHhlxlmPZhs1VQvvOoxUvd9dr9yS54OzjfNgBU
	 z/4N2BRsJsUwdv/Z080Kcdhkm3+XTFn9tMHPWMsUUiMFq8zIjDMm41n+FoLwEXjTX9
	 XBJhCVMBXHoxv2+YY9j+aY66sTH8uufrk+A74M4WR16zyzLBhME5sPWAujNuLhINYt
	 qG06FL/BxXT5g3E/4DfnPpAZwQRegjfqDSj0+F64ecgs2xaCu0DZ1v2KQez1o25+h/
	 4YEdW8wZTPTGdqBZd66Dl2HZuIl7CMdxNb4bc88KdNjW5GqyCEwK7tebqzyD1Tzm1Y
	 2a+mBrCwJmPkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] KVM: selftests: Refactor invalid nVMX state test
 to prepare for RSM testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728004351.887076-6-seanjc@google.com>
References: <20260728004351.887076-1-seanjc@google.com>
 <20260728004351.887076-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:51:42 +0000
Message-Id: <20260728005142.E8F9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The assertion failure message in `vcpu_run_to_io` hardcodes 'L2' as=
 the expected guest level, ignoring the `want_l2` parameter.
--

--- Patch [5]: [PATCH v4 5/6] KVM: selftests: Refactor invalid nVMX state t=
est to prepare for RSM testcase ---
commit 7bfb34d63ffa2d4c98580f574a703358bca449c2
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Refactor invalid nVMX state test to prepare for RSM testcase

This commit extracts the VM creation and initial vCPU execution logic into
helper functions to allow reuse for a future RSM testcase. It also eliminat=
es
the global vm variable and adds an assertion to ensure L2 is never resumed
after an I/O exit to L1.

> diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_sta=
te.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
> --- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
> +++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c

[ ... ]

> +static void vcpu_run_to_io(struct kvm_vcpu *vcpu, bool want_l2)
>  {
> -	gva_t vmx_pages_gva;
> -	struct kvm_sregs sregs;
> -	struct kvm_vcpu *vcpu;
> -	struct kvm_run *run;
> -	struct ucall uc;
> +	struct kvm_run *run =3D vcpu->run;
> =20
> -	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> +	vcpu_run(vcpu);
> =20
> -	vm =3D vm_create_with_one_vcpu(&vcpu, l1_guest_code);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> =20
> -	/* Allocate VMX pages and shared descriptors (vmx_pages). */
> -	vcpu_alloc_vmx(vm, &vmx_pages_gva);
> -	vcpu_args_set(vcpu, 1, vmx_pages_gva);
> +	TEST_ASSERT(run->io.port =3D=3D ARBITRARY_IO_PORT &&
> +		    (!!(run->flags & KVM_RUN_X86_GUEST_MODE) =3D=3D want_l2  ||
> +		     !kvm_has_cap(KVM_CAP_X86_GUEST_MODE)),
> +		    "Expected IN from port %d from L2, got port %d from L%u",

[Severity: Low]
Is the hardcoded "from L2" in the expected message string intentional?

Since vcpu_run_to_io() is a helper that takes a want_l2 parameter, the error
output could be misleading if a test calls it expecting an exit from L1.
Would it make sense to dynamically print L1 or L2 in the failure message
based on the want_l2 parameter?

> +		    ARBITRARY_IO_PORT, run->io.port,
> +		    1 + !!(run->flags & KVM_RUN_X86_GUEST_MODE));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728004351.8870=
76-1-seanjc@google.com?part=3D5
