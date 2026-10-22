Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708724;
	b=wORhfPrAH2FRW/Vkec83d/2xQloA5oM2cG8rGccGdktUtahnJE4lTzuNzdAyguWcAbH7
	 eKWT2dHFQBc3dr2XXgNE4oY97EYr/ciYyVZUdHfdyeM+ispg8dgkFA14tURY3MVnCk9mz
	 4InU3sDXE7F5GSGD1l/LQ4LJ8SQTFxYwOjZihCtvvxja4EoKH6YvYkka9BDPvBs9FBhgH
	 nClAZbDfPt4DROuNtInrc6R4ovkZtqy3mSh7MstG6SiTj7X8B0YxptcB5pz4ASgCJ6wQF
	 4oHoxwLckkCFgEQoVb++2W0F0Tvzf5KJcBLBbxe5BEDD76aY/TgxiSALf6ai+gxd2zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=grkQROvlVwy9sQSzhGpSmDLgHZfoBy2B+4Le3+SCc10=;
	b=gdxDAq2T/vHRRnhsTXeJpCxc92o1gjl3e/VUxgk8l1iFaDaMsTYX+rKVydYMrMOqooq3
	 sau2mLyYMwpsmrnTzdEfm65hnGx7iAzt7XT/sSennRG7KKoXamhLFXEYycNI+FbXUIsXb
	 E5S+YmI8DfwIsJL+eWPOgbMm+m4UMU1dros3MLPxMhmHPeUphI74WA79wQmX/Ol3wcTp2
	 nyZi6BNa+pHv5bMtkcpC7Vf5TGeSCTMyyBCIz0nDyq7xX/DCwf87skR6jRfk4KTOCatX4
	 YNYCT3aE9VOOXVAF8ipKbMD8YYONoQRT1vcTGP6zT8iOJ4O4qrg+pbwSWDRTmH2U+XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gA1VP2lV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BF606A321
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gA1VP2lV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B51F01828;
	Thu, 22 Oct 2026 22:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708723;
	bh=grkQROvlVwy9sQSzhGpSmDLgHZfoBy2B+4Le3+SCc10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gA1VP2lVrOiN5n4OyvJQU4bw/nVmJw06Kh52E05bbo3OKcYRxBbFycMNf/mn9QhTp
	 sJVXNk7OklNNBvJAs/kN7vK+DCy4sKdhqj7OjyIQAZHHlkvxyK8PHa3+MUD74evIWk
	 UDuS72kHPbx66jNkygrsLqIeNKklIUueIE2MUMI/D2ClNC5hc+smddTJfinO/Lxx5w
	 LjH2rrK2pLpLt+mD++Za/chyG465c6CDNO/2QCmYWbIN7YcHf8GyudMyvMUihJj+8u
	 RUVcxBgoxKqXwB1yV7d4vd54X84JAwhlcS3rcTD0uc6LloxoGIQWNm7tw9KS+RKfxv
	 VpZskqk3DEneg==
Message-ID: <sashiko-outbox-182126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] Revert "KVM: x86: Skip EFER vs. guest CPUID checks
 for host-initiated writes"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022223052.646891-2-seanjc@google.com>
References: <20261022223052.646891-1-seanjc@google.com>
 <20261022223052.646891-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:38:43 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: x86: set_efer() revert breaks test_host_initiated_lmsle() a=
nd api.rst
--

commit f8fc3a0796b0b21e716b9ed0c1fcf3c9297d569f
Author: Sean Christopherson <seanjc@google.com>

Revert "KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated write=
s"

This commit reverts commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPU=
ID
checks for host-initiated writes") so that set_efer() unconditionally valid=
ates
EFER against guest CPUID capabilities and CR0.PG even for host-initiated
MSR_EFER writes.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index e91650af44c20..2df42276fd826 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -580,8 +580,11 @@ static int do_get_feature_msr(struct kvm_vcpu *vcpu,=
 unsigned index, u64 *data)
>  				 kvm_get_feature_msr);
>  }
> =20
> -static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> +bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
> +	if (efer & ~kvm_caps.supported_efer_bits)
> +		return false;
> +
>  	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIB=
RS))
>  		return false;
> =20
> @@ -610,33 +613,18 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu,=
 u64 efer)
> =20
>  	return true;
>  }
> -
> -bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> -{
> -	if (efer & ~kvm_caps.supported_efer_bits)
> -		return false;
> -
> -	return __kvm_valid_efer(vcpu, efer);
> -}
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
> =20
> -static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> +static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
>  	u64 old_efer =3D vcpu->arch.efer;
> -	u64 efer =3D msr_info->data;
>  	int r;
> =20
> -	if (efer & ~kvm_caps.supported_efer_bits)
> +	if (!kvm_valid_efer(vcpu, efer))
>  		return 1;
> =20
> -	if (!msr_info->host_initiated) {
> -		if (!__kvm_valid_efer(vcpu, efer))
> -			return 1;
> -
> -		if (is_paging(vcpu) &&
> -		    (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_LME))
> -			return 1;
> -	}
> +	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_L=
ME))
> +		return 1;

[Severity: Medium]
Does reverting this check break test_host_initiated_lmsle() in
tools/testing/selftests/kvm/x86/svm_nested_efer_test.c and leave
Documentation/virt/kvm/api.rst out of date?

Commit 7358d13e1f19 ("KVM: x86: Honor the guest's EFER_LMSLE_MBZ") and comm=
it
34f749161dab ("KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeatur=
e")
were added after commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID
checks for host-initiated writes"), when set_efer() skipped __kvm_valid_efe=
r()
for host-initiated writes.

With this revert, host-initiated MSR_EFER writes via KVM_SET_MSRS take the =
path
kvm_arch_vcpu_ioctl() -> msr_io() -> kvm_set_msr() -> kvm_set_msr_common() =
->
set_efer() -> kvm_valid_efer(), which rejects EFER_LMSLE when
X86_FEATURE_EFER_LMSLE_MBZ is set in guest CPUID:

arch/x86/kvm/msrs.c:kvm_valid_efer() {
	...
	if (efer & EFER_LMSLE &&
	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
		return false;
}

On AMD SVM hosts that support EFER.LMSLE, test_host_initiated_lmsle() in
tools/testing/selftests/kvm/x86/svm_nested_efer_test.c sets
X86_FEATURE_EFER_LMSLE_MBZ and then asserts that a host-initiated write of
EFER_LMSLE succeeds:

tools/testing/selftests/kvm/x86/svm_nested_efer_test.c:test_host_initiated_=
lmsle() {
	...
	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
	...
	vcpu_set_msr(vcpu, MSR_EFER, efer | EFER_LMSLE);
	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_EFER), efer | EFER_LMSLE);
}

Because set_efer() now returns 1 on that write, vcpu_set_msr() fails and ab=
orts
the selftest (and neither this patch nor follow-up patch 4/4 in the series
updates test_host_initiated_lmsle() or the related comment in
test_sregs_lmsle()).

In addition, Documentation/virt/kvm/api.rst under "Long mode segment limits"
still states:

  Note, ``KVM_SET_MSRS`` is exempt from the check, as host-initiated MSR wr=
ites
  skip guest CPUID checks so that userspace can set MSRs before it sets gue=
st
  CPUID.  ``KVM_SET_SREGS`` and nested VMRUN are not exempt.

And efer_trap() in arch/x86/kvm/svm/svm.c still references the removed
__kvm_valid_efer() helper in its comment:

  * Clear the EFER_SVME bit from EFER. The SVM code always sets this
  * bit in svm_set_efer(), but __kvm_valid_efer() checks it against
  * whether the guest has X86_FEATURE_SVM - this avoids a failure if
  * the guest doesn't have X86_FEATURE_SVM.

Should test_host_initiated_lmsle(), Documentation/virt/kvm/api.rst, and the
comment in efer_trap() be updated to match the restored set_efer() behavior?

[ ... ]

>
>  	efer &=3D ~EFER_LMA;
>  	efer |=3D vcpu->arch.efer & EFER_LMA;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022223052.6468=
91-1-seanjc@google.com?part=3D1
