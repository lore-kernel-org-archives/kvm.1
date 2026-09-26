Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3221A459
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401604; cv=none; b=brvRjjRpQ6bhUvEXY32Tc3Jy7QVRQUmy8a8b3SU6Ntl2OkvS1I464Pt56unREKRPwzV/B58AucU2WqNyRa3lEkSHUNljm2MCugHRQiveAKNxdMwOWqS2v4iDdQcgtorRcEbftTX/8GGbDR8IdOK+Tn2didSu+huHQRVN4+pwjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401604; c=relaxed/simple;
	bh=MV/aF/46k8iJmsU1GyYVh5zRkIZuacp1LIFpDWPf/qo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpi8l8DCYMt/IO46p2Z3Kik08NbfLVsJ+QE40Imo9tGKwIA1gUQoivusREbVcTspwUVTkiGoXH4WN1467t8gfpTdLiGkPi3OznchKO82GA8pTJroitmMISp3VkPLG3TJZuAHtnM3wEMxKBRE7a5T4ZsdIGoCwxtKLDXek4/pGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI2CGF/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI2CGF/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DDD1F000FF;
	Sat, 26 Sep 2026 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790401602;
	bh=oNP4Lvu2E8rkqv1ywyO3n4hXUjyz4Q72wvgV6qRZBmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QI2CGF/n6xuF/Wikl1offRLAIXMZqDi+0IbVBjTaQu5zIPS6UBSfHcQPGuFEqizl3
	 c8BMQMle828bstDICD7SiSoa04f85il+U2GmOeZ1mcKYoXMrgx6+kTq2K4NgUZlJi4
	 p4hhtafrw6UWNE1w2x0L3RGh6KzcBu3n3sWqt58zezfnaCtYu76ygVAfECU8YEZBzm
	 C0vyqB+ZPZuXARJ1nhY98sQA4HrX0ciou5W6cSvZl35KGmTzySzxHBEY4t6x2EPxbP
	 bYPPHcXysBXYw8YB3IZuGX35HGB3143j34JoMbPYbrqvKe3fW2w2iDFt5keblDalTB
	 rgmjVqCKogo2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] KVM: selftests: Extend nested x2APIC test to
 validate disabling x2APIC virt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260926053253.195597-11-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
 <20260926053253.195597-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:46:42 +0000
Message-Id: <20260926054642.B3DDD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] selftests: vmread return value overwrites control variable
- [High] selftests: nested_x2apic_test fails unconditionally on SVM
- [High] selftests: unchecked secondary execution controls in l1_vmx_code_p=
art2
--

commit 654f28b9879b51044371cba2ce7892e66b1a94e7
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt

This commit extends the nested x2APIC test to further validate disabling
x2APIC virtualization. It splits the guest code and intercept checks to
validate interactions with secondary execution controls and TPR shadows.

> diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools=
/testing/selftests/kvm/x86/nested_x2apic_test.c
> index 3b59ba3e33420..e94d4e77256bd 100644
> --- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
[ ... ]
> +static void l1_vmx_code_part2(void)
>  {
> -	x2apic_enable();
> +	u64 control;
> =20
> -	if (this_cpu_has(X86_FEATURE_SVM))
> -		l1_svm_code(test_data);
> -	else
> -		l1_vmx_code(test_data);
> +	control =3D vmreadz(CPU_BASED_VM_EXEC_CONTROL);
> +	control &=3D ~CPU_BASED_TPR_SHADOW;
> +	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
> +
> +	control =3D vmread(SECONDARY_VM_EXEC_CONTROL, &control);

[Severity: High]
Does this assignment overwrite the control variable with the return value of
vmread()? Since vmread() returns 0 on success, control gets assigned 0
instead of retaining the VMCS value populated by reference, which then caus=
es
a regression by corrupting the subsequent vmwrite() when it clears all
secondary execution controls.

> +	control &=3D ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +			SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
> +	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);

[Severity: High]
Are we missing a check for CPU_BASED_ACTIVATE_SECONDARY_CONTROLS before
accessing the secondary execution controls here?

In l1_vmx_code(), we check CPU_BASED_ACTIVATE_SECONDARY_CONTROLS before
modifying them. Since we don't verify it here, won't this cause a test
regression on incompatible CPUs when vmread() and vmwrite() return error
status codes?

> +
> +	GUEST_ASSERT(!vmresume());
> +	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
> +	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
> +			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
> +}
[ ... ]
> +static void l1_guest_code(void *test_data)
> +{
> +	x2apic_enable();
> +
> +	if (this_cpu_has(X86_FEATURE_SVM))
> +		l1_svm_code(test_data);
> +	else
> +		l1_vmx_code(test_data);
> +
> +	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0);

[Severity: High]
Will this assertion unconditionally fail on SVM hardware, causing a test
regression?

Since TPR shadow behavior is only implemented for VMX, L2's write of 0xf0
directly modifies L1's TPR on SVM. When l1_guest_code() expects L1's TPR to
be 0, it appears this will fail. Is this the intended behavior for SVM test=
s?

> +	x2apic_write_reg(APIC_TASKPRI, 0xf0);
> +
> +	l1_test_x2apic_intercepts();
> +
> +	if (this_cpu_has(X86_FEATURE_VMX))
> +		l1_vmx_code_part2();
> +
> +	l1_test_x2apic_intercepts();
> +
>  	GUEST_DONE();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926053253.1955=
97-1-pbonzini@redhat.com?part=3D10
