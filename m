Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44596318EE7
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401372; cv=none; b=lJxH3v/arGGEkGo9hJnhqyDgyp62uvdYqaiba8GbeFHEP9/k9UuVGclokw9L950dbKJYRqJ1xQ2NWkeyBrQHpvLXz2ovBRdYcw8p3VM9U/ooYn4OeV2BVFSyc7G0F5kxds0Lb1CAhrVjW9JsI5OzqLxAhyXT6EVPiSfD6MC6ovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401372; c=relaxed/simple;
	bh=S5E9ra2p5k4TH5AHfHkwb+y5z2YS6RJFJc/l2F9NAgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kioOhuYViz7ZYnL3DmwZqRWbfW2o+OfhvGHtdKIgp2LjhjC6o625dJRbS28K4z0MSoFnyyvNpFD1RxPfyvYYFiiMdJC6DklcRb8/P9HydgAkdfoNSc21h/Utdro/StueCyuHXuDHVewF5tDD3JOlnxf4i0CmsGMXgIe38kgiKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXZopJ0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXZopJ0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AA31F000FF;
	Sat, 26 Sep 2026 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790401370;
	bh=eyGqdIKKks8OizoaJySzCpX7OsDfX1E8U0PcPUOAyCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXZopJ0dfXtRFk3gvyaYGAOSi2XVec5vOPH7piQzmJ8WNLYsXN+ilfPqYDNBRtU/b
	 lsiyfDT18kzstsGO401HmD3vhkzVjJMtkD3LpUEZURaNYAOof/t7jd9yKzKUdtXViW
	 wqKFVdbXrxn2/xzO7St967BOZWlkyYX68PzNDUEOLegf41uEnez7eg5IiAthv7zv7u
	 0NK1pIGrXpridmFLyZpSp+MXM2cD+Yc4du+SzobM0O0+7CT3QVJVUZP5eHlER3TeCh
	 Mlf9dwiGjl0xvbfiF+ixNmQInPEUWtMMeH2saCSY3xLAU4Oy2z6bA0SiE+USISxrwP
	 17cMq23EypWIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] KVM: selftests: Verify that L0's TPR doesn't get
 clobbered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260926053253.195597-10-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
 <20260926053253.195597-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:42:50 +0000
Message-Id: <20260926054250.B0AA31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: host lockup in nested_x2apic_test on buggy kerne=
ls
--

commit 4b6251f570c0e52b8b50c2db54a19f22c22f7cf3
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Verify that L0's TPR doesn't get clobbered

This commit updates the nested_x2apic_test to verify that KVM properly
intercepts L2's writes to the APIC_TASKPRI register. It adds checks in
both L2 and L1 guest code to assert that the TPR value written in L2 is
correctly handled and observable.

> diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools=
/testing/selftests/kvm/x86/nested_x2apic_test.c
> index a1072bf499ee2..3b59ba3e33420 100644
> --- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
> @@ -28,6 +28,10 @@ static void l2_guest_code(void)
>  {
>  	if (inhibit_apicv)
>  		wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0)=
);
> +
> +	x2apic_write_reg(APIC_TASKPRI, 0xf0);

[Severity: Medium]
Does writing 0xf0 here risk permanently freezing the host CPU when testing =
on
buggy kernels?

When running this test on an unpatched kernel where KVM fails to intercept
this x2APIC MSR (the AVIC bug this test targets), this writes directly to t=
he
host CPU's physical TPR. A TPR value of 0xf0 sets the task priority class to
15, which blocks all maskable interrupts (including local timers and device
interrupts).

Could a harmless value like 0x10 be used instead, which would still fail the
L1 assertion without masking critical host interrupts?

> +	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);
> +
>  	asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
>  }
> =20
> @@ -73,10 +77,22 @@ static void l1_guest_code(void *test_data)
> =20
>  	sti_nop();
> =20
> +	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);

[Severity: Medium]
If the test runs on a kernel with the AVIC bug, won't this assertion fail a=
nd
abort the test immediately?

If the test aborts here due to the assertion failure, the host's physical T=
PR
is never restored. Because L2 previously wrote 0xf0 to the host TPR, this
leaves the host CPU completely unresponsive to maskable interrupts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926053253.1955=
97-1-pbonzini@redhat.com?part=3D9
