Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378202;
	b=n1IqG/xZaMrV7QpAtbuhUUdGQs7wqBTJSgJFtjNEfAfB1cwKRhA04eTpjf+BGPB+mje0
	 864j8C3p/qV2Ck+nRynUm9v/wlCyOEJYgBd5YLBrQCshP6E4kGgK2H1A8nTaUemN4zSlm
	 46f0JZ83/VlRaPatv8j9pXUKBaDziNiC+WEVpCQbWajyGfkzSxk5w3jaMX92hdMhgI3tm
	 Xt1OVZUdPByODhVVhtC4MUNO/KSBPWl1xHC+UOZB2HsRXgAA8xIHLSCjAnsytpA0/FyF5
	 5KWS2l9MSW0IxWFLEOGpcnihn3MIZCKVAhHGuVhv1CjPNfqY60YT7x2ZHSU4Ng3a+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nW1dedwvCcdU5KXpQqit/csQCVxAjOSdFbgj/9SMZ18=;
	b=rlpv2+Y0WOY/qS9IoTQEmpXorkHg7eyXFT00mRFKPBLJwmXY3AHoWnHl7SACNrV6yunD
	 gr4JXnVL4PFrvlVHprXyfptcZpU4ZJu+Ws92HyGJ9bIHb8KcMAdZs2LGGMlo+KxNh4/7g
	 NvCljckG6XkjdNd4d54/RRNf9WmypX1IR21YX6f1Dgblm6NsyuVSdMWYurhWFanLtHh3P
	 6Ni+z/9m8w6s1U0LP7OXdHgj7NBImkJ89f3DnfF537SR5sE7NtMjuwm50tOTA7dWBd5Ma
	 6xzPEnNRQwMl7ZVXVqpEH7QWkLGV76OWY7eT6eugKzzcNZsdRYNQM0wT01LXYl/WECw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWGEpwGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE2606A337
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWGEpwGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D286D1F00A09;
	Wed, 11 Nov 2026 06:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378202;
	bh=nW1dedwvCcdU5KXpQqit/csQCVxAjOSdFbgj/9SMZ18=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eWGEpwGjx9GFYnvrSGFspBc9tTe8PDloBtfzeLVDDQW1mLWbtsKL/OQ3rsl9EyDOM
	 sTskRr+B5UIuvEV3fX34bSHPIO31q82LjwDPvOIDi4Ee4vLfHIDzuyd3sI3C7/ac7z
	 eHA56ABuHWdoIMrFQ6WUABboUOSHZnJhtTifSUUSPC4P0lacVcNuqYeSL32tgujL9Y
	 qnMwc73AKeQYm0H5E7ZztrZ4Ka2TpDdTsEYPEo4yb7aol7ChchaPzOEmb+36xWe1Co
	 Vpojt190721Dz+b6yBvMIMk3vRNKSgoH34OXZbiA9UXsaaOyaEA5aTTMPUB3Yk29sf
	 H+1cJxgIdTy9A==
Message-ID: <sashiko-outbox-208435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] KVM: selftests: Test VMware hypercall exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, kvm@vger.kernel.org
In-Reply-To: <e6dfd2e43c8a6ea04fe59b1b5825138ad5523273.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
 <e6dfd2e43c8a6ea04fe59b1b5825138ad5523273.1794374897.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:23:21 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Low] KVM: selftests: native_hypercall_insn() rejects Zhaoxin VMX CPUs
- [Low] KVM: selftests: vmware_hypercall_test open-codes
  vcpu_run_complete_io()
- [Low] KVM: selftests: exit_reasons_known[] omits
  KVM_EXIT_STRING(VMWARE)
- [Low] KVM: selftests: main() in vmware_hypercall_test duplicates
  (false, true) case
--

commit 54cae967f2b7981d769102ff002d20cd884b4d2d
Author: Zack Rusin <zack.rusin@broadcom.com>

KVM: selftests: Test VMware hypercall exits

This commit adds vmware_hypercall_test to cover KVM_VMWARE_ENABLE_HYPERCALL
and KVM_EXIT_VMWARE, and enables VMware hypercall exits in xen_vmcall_test.

> diff --git a/tools/testing/selftests/kvm/x86/vmware_hypercall_test.c b/to=
ols/testing/selftests/kvm/x86/vmware_hypercall_test.c
> new file mode 100644
> index 0000000000000..d882d3661022b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
> @@ -0,0 +1,388 @@
[ ... ]
> +static const u8 *native_hypercall_insn(void)
> +{
> +	if (host_cpu_is_intel)
> +		return vmx_vmcall;
> +	if (host_cpu_is_amd_compatible)
> +		return svm_vmmcall;
> +
> +	TEST_FAIL("VMware hypercall test requires an Intel or AMD-compatible CP=
U");
> +}

[Severity: Low]
Should native_hypercall_insn() check host_cpu_is_intel_compatible instead
of host_cpu_is_intel?  Zhaoxin CPUs implement VMX and use VMCALL (as
handled in fix_hypercall_test.c and X86_HYPERCALL()), so checking only
host_cpu_is_intel causes the test to hit TEST_FAIL() on Zhaoxin hosts.

[ ... ]

> +static void run_to_vmware_exit(struct vmware_test *test, bool cpl3,
> +			       bool compat)
> +{
> +	test->vcpu->run->kvm_valid_regs =3D KVM_SYNC_X86_REGS;
> +	vcpu_run(test->vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(test->vcpu, KVM_EXIT_VMWARE);
> +	TEST_ASSERT(test->vcpu->run->kvm_valid_regs & KVM_SYNC_X86_REGS,
> +		    "KVM did not return synchronized GPRs");
> +	assert_hypercall_state(test, cpl3, compat);
> +}

[Severity: Low]
Does exit_reasons_known[] in tools/testing/selftests/kvm/lib/kvm_util.c
need a KVM_EXIT_STRING(VMWARE) entry?  Without it, exit_reason_str()
returns "Unknown" if TEST_ASSERT_KVM_EXIT_REASON() fails on an expected or
unexpected KVM_EXIT_VMWARE exit.

[ ... ]

> +static void test_synchronized_output(bool compat)
> +{
[ ... ]
> +	run->s.regs.regs =3D expected;
> +	run->kvm_dirty_regs =3D KVM_SYNC_X86_REGS;
> +	run->immediate_exit =3D 1;
> +
> +	errno =3D 0;
> +	ret =3D __vcpu_run(test.vcpu);
> +	run->immediate_exit =3D 0;
> +	TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINTR,
> +		    "Completion with immediate_exit failed: ret=3D%d errno=3D%d",
> +		    ret, errno);
[ ... ]
> +}
> +
> +static void test_valid_exception(u32 vector, u32 error_code, u64 address,
> +				 bool dirty_regs)
> +{
[ ... ]
> +	run->immediate_exit =3D 1;
> +
> +	errno =3D 0;
> +	ret =3D __vcpu_run(test.vcpu);
> +	run->immediate_exit =3D 0;
> +	TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINTR,
> +		    "Exception completion failed: ret=3D%d errno=3D%d", ret, errno);

[Severity: Low]
Can test_synchronized_output() and test_valid_exception() use
vcpu_run_complete_io(test.vcpu) instead of open-coding the immediate_exit
sequence?

[ ... ]

> +int main(int argc, char *argv[])
> +{
[ ... ]
> +	test_synchronized_output(false);
> +	test_synchronized_output(true);
> +
> +	test =3D create_test(true, false, ARG_RAX);
> +	run_to_vmware_exit(&test, true, false);
> +	destroy_test(&test);
> +
> +	test =3D create_test(false, true, ARG_RAX);
> +	run_to_vmware_exit(&test, false, true);
> +	destroy_test(&test);

[Severity: Low]
Was the second create_test() / run_to_vmware_exit() block meant to pass
(true, true) instead of (false, true)?  test_synchronized_output(true)
already exercises (cpl3=3Dfalse, compat=3Dtrue), whereas (cpl3=3Dtrue,
compat=3Dtrue) is not tested.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794374897.gi=
t.zack.rusin@broadcom.com?part=3D10
