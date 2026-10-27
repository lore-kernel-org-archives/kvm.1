Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141577;
	b=kiJRRLcfA7JodaO9yZ1vIG8kQCCFgLau8e/PMO19IPXr9BUuvbxVms/jCntDuD9XRQSp
	 o/NBvvy9yQ8p3rVln/NJKbw3Qx6NFRTjqwD4DplfuFpeO95llTSQ+sJtnAR1CbXn9zvd+
	 Z1BHgYy/IWBWJlcSiPBfbiysIAEgVJEJc0NEha98Q7grM+COXMmnNrwOadb0IKEkk32wq
	 8Gd3T/ZVmfKzPSTbij6NKBj8W8Djf/A3kVCuVbaanzrqhGm3fafmWHG2Rb8LIHzawNfH4
	 MxzQtPBH1A14fKGvISw8gUHWFgeUXyK4A5zFrCV5+zyroR/lJzY2iiXSRpyuPw7xhKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LLHeszN3NBnCSekfmuYWBeUA8vPHYFxSGgvz8Lu2E70=;
	b=KFmf0MJjMTwtMqU1wyqVNou6KyvG5cMiEzq6MSyFbjkmO4de8BaiAxDRVS9ElOoIuXLD
	 JKmEIMbqH/x3l+5XEJqcHSkpfpw8UIkAr3jYZqVmZzBH+KLpVUwRoWc5/vFnobHMXT/Xq
	 qktLw88UjZvAzh/DLeyxG+0b+DCzo9VnD6D8XzEnY0H0hvFcwfN/Ebnw/SUCMopsRcCrs
	 S/FxzOBJbBU2khnZwbUP25bw0L7bYClbULYRigHLi7kUoeLarDihXgMkk2lYwDc8gkYqX
	 vNlOc/oI04Q4VVx5F8uW0p3b7ewpIn/VpJMmOWJp3QSlsyHlJqmVv7XiweJypm4r3iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XckmGcSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D6606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XckmGcSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FA21F01825;
	Tue, 27 Oct 2026 22:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141576;
	bh=LLHeszN3NBnCSekfmuYWBeUA8vPHYFxSGgvz8Lu2E70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XckmGcSO7wlIx+r/CaC0SVZlIvtyhHsYmAhe5ET0NVsuPbnNdrI+I16qE4+oMt64x
	 h+E8Dnw4np2YMChXTI12IkHB4pt9jJjzqx6/F2uuVnBxdfcZ3NiS4Io4NALtp+uazs
	 mQhMDT4PgSSt9KKxnFl9+L/pnRfY6nMc0H10ta8lyu76Z8rK8QdGc4AzwAa/kAhX20
	 lBArsX01EhZY2u7YWi8eF4csojH2iwE4Byem2IV9aUNNpjtEToMIMBK1FWXqlXMzxx
	 uG255G1R1Nc8N6UZteo6Yl4GTSwldSdxUmYGTHMACK439eT3HER9FU+004rP6HG5/L
	 5AYBbuQMqNpew==
Message-ID: <sashiko-outbox-187178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] KVM: selftests: Expect failure when trying to
 set EFER that violates vCPU model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261027224914.1574319-7-seanjc@google.com>
References: <20261027224914.1574319-1-seanjc@google.com>
 <20261027224914.1574319-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:52:55 +0000
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
- [Medium] KVM: selftests: uninitialized sregs in test_sregs_lmsle()
--

commit 6277431d999ca1b09f23758ba28993921a931827
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Expect failure when trying to set EFER that violates vCPU m=
odel

This commit updates test_host_initiated_lmsle() in svm_nested_efer_test.c to
expect KVM_SET_MSRS to reject EFER.LMSLE=3D1 when EFER_LMSLE_MBZ is enabled=
 in
guest CPUID, and cleans up related comments in the test.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/too=
ls/testing/selftests/kvm/x86/svm_nested_efer_test.c
> index fa9cfe8b12427..bdec7cdb37146 100644
> --- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c

[ ... ]

> @@ -222,11 +219,6 @@ static void test_sregs_lmsle(void)
>  	vm =3D vm_create_with_one_vcpu(&vcpu, NULL);
>  	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
> =20
> -	/*
> -	 * Unlike KVM_SET_MSRS, KVM_SET_SREGS runs the full set of guest CPUID
> -	 * checks, i.e. rejects EFER.LMSLE even though it's host-initiated.
> -	 */
> -	vcpu_sregs_get(vcpu, &sregs);
>  	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");

[Severity: Medium]
Was removing vcpu_sregs_get(vcpu, &sregs) in test_sregs_lmsle() unintention=
al?

Without that call, the stack variable sregs is left uninitialized when
TEST_ASSERT() reads sregs.efer and when sregs.efer |=3D EFER_LMSLE is passe=
d to
_vcpu_sregs_set(vcpu, &sregs):

tools/testing/selftests/kvm/x86/svm_nested_efer_test.c:test_sregs_lmsle() {
	struct kvm_vcpu *vcpu;
	struct kvm_sregs sregs;
	struct kvm_vm *vm;
	int rc;

	vm =3D vm_create_with_one_vcpu(&vcpu, NULL);
	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);

	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");

	sregs.efer |=3D EFER_LMSLE;
	rc =3D _vcpu_sregs_set(vcpu, &sregs);
	...
}

In addition to reading uninitialized stack memory on the assertion, passing
an uninitialized struct kvm_sregs to KVM_SET_SREGS means KVM may reject the
ioctl due to garbage in other fields rather than specifically testing
rejection of EFER.LMSLE=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027224914.1574=
319-1-seanjc@google.com?part=3D6
