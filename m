Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6863CB8E6
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740078; cv=none; b=VKFWjaSfrXDeRnRLQ6j0nWwPbDG1/Ysw3mWukxS0x/SI6AFNC/OKQ8miinvWHG5JfdfKgKVRkfqu0P3vWRSoDDv730+ne3bbHDFTcOHFHJqWtGc7+Q29OKWn/OO7gqXNm+HKN079ZuGC1YtVBtQu7sfHOZ2i4JNTpzj//gKBuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740078; c=relaxed/simple;
	bh=USWtx4gfaWksEo7c0lw48vwxUQMIxXkM3dcwBmrt/jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSrNt3G1Cx/VKDs+81FKtDrZtWKMHGXf61YF6T+zFi8nWF5xCS6aR8m2P6l0S5g7A1m25Lbi6o4Kb8ENBPT9Fj+s8zuKXdNSfKTROvHqE9JdcAzDCRzJfA0VajuI+gDFJ+qVRhIyzujFQGxCEkda0p9K+p6JSX6O8htIVGnwC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhC+K1pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhC+K1pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6381F000E9;
	Wed, 26 Aug 2026 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740075;
	bh=MCk9XTilU31enRoeNwAUhujgmSiMraOiGJjcBnTgx24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhC+K1pTobCssQY35SSrEhkEIkJmoCX7TnPRHWWpET3LWgmNAn/lZPgLM/mxnzpsL
	 UCTfXR7LUhYcehrWNG766KHcZnzfBN0hxoCQ81bp8b0y+J+SyDeQx83NWdqPy5bWOG
	 9/C79Ng/KjuKKp1M3V5SvPt05sMF20VMsjX7SU3yNN91SyYnFYnzQHCgRYAtKj5frp
	 TYfQtAfwZ3rKBRt8XoaQ8tbk2eDLgMMKcPTkbGxUm3PV5Netm9hxqZ6AOkD+tCqwR3
	 +p6AcSbhTy4sakxRwF2sqMCNhJES+/MwPabwnx1wlIbvd1S4cXeKenDp0KoKV10T28
	 Il0djZZwQ/Jjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Test the PV_UNHALT feature, not just
 its CPUID bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826101627.2873660-1-hemanth.selam@gmail.com>
References: <20260826101627.2873660-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:27:55 +0000
Message-Id: <20260826102755.7B6381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The arguments to `KVM_HC_KICK_CPU` are swapped in the selftest's=
 `kvm_hypercall()` invocation, causing the test to falsely pass only becaus=
e the target vCPU's APIC ID happens to be 0.
- [Low] Incorrect error reporting for `pthread_create` and `pthread_join`, =
as they do not set `errno`.
--

commit 6ba52c6d2b00ca080ff07b971fc3f8bbdf50de71
Author: Hemanth Selam <hemanth.selam@gmail.com>

KVM: selftests: Test the PV_UNHALT feature, not just its CPUID bit

This commit implements a two-vCPU test for the KVM PV_UNHALT feature to
actually exercise it instead of just checking its CPUID bit. It verifies
that one vCPU can successfully kick and wake up a halted vCPU using
KVM_HC_KICK_CPU.

> diff --git a/tools/testing/selftests/kvm/x86/kvm_pv_test.c b/tools/testin=
g/selftests/kvm/x86/kvm_pv_test.c
> index 8ed5fa6350211..d14d55d3a9ba7 100644
> --- a/tools/testing/selftests/kvm/x86/kvm_pv_test.c
> +++ b/tools/testing/selftests/kvm/x86/kvm_pv_test.c
[ ... ]
> +static void pv_unhalt_kicker_guest_code(u32 halter_apic_id)
> +{
> +	GUEST_ASSERT_EQ(kvm_hypercall(KVM_HC_KICK_CPU, halter_apic_id, 0, 0, 0)=
, 0);

[Severity: Medium]
Are the arguments to kvm_hypercall() in the correct order here?

Passing halter_apic_id as the first argument places it into a0 instead of a=
1.
Since KVM's handler uses a1 for the APIC ID, it will always kick APIC ID 0
instead of the dynamically determined halter_apic_id.

Does this regression falsely allow the test to pass only because the target
vCPU is created first and its APIC ID happens to be 0?

> +	GUEST_DONE();
> +}
[ ... ]
> +	r =3D pthread_create(&thread, NULL, pv_unhalt_halter_thread, halter);
> +	TEST_ASSERT(!r, "pthread_create halter failed, errno=3D%d", errno);

[Severity: Low]
Does pthread_create() set errno?

It returns the error code directly in r. Should this print r instead of
errno to avoid showing a stale or zero value when it fails?

[ ... ]
> +	/* Nothing except the kick can get the halter to GUEST_DONE(). */
> +	r =3D pthread_join(thread, NULL);
> +	TEST_ASSERT(!r, "pthread_join halter failed, errno=3D%d", errno);

[Severity: Low]
Similarly here, pthread_join() returns the error code directly. Should this
log r instead of errno?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826101627.2873=
660-1-hemanth.selam@gmail.com?part=3D1
