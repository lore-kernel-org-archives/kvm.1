Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5546EF69
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122642; cv=none; b=Fp+99/9JL+FK/WfZzKYVT7maiz3+KG6mH+qx/Y95D9+Meb6a6RDfjIcNRVR5HrX1xA+GKjMiEnhhCBuMUfXgR+snOHqag+bAl84AxY2Pr9ZQfLm7//J3WPFu2o7VW26Lqoz5l76IrgbH9IgQOgf5qzYGpIcGZNtp0PLSv6bKDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122642; c=relaxed/simple;
	bh=NULQ2t396jd7YXJ+C75rzZdIMCK/Y+hRXmYmMzlbXOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QS+PkobueWIAV4AbWu0rPXSboXs6UXVcmkL6Y8lnSfzoIAW0T0NQjTyOnjhJGtX/4MLXwbD5kKOn8ot3ccbSmwnazLTUgSBJaPHpnwSFj2tnuK7hBwNk91EjjDtjio/Pi6adYczAU8Snwzxs8yrCw+5Kpk5uoNZWk+gzCmm/Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJWF9m9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJWF9m9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7A71F00899;
	Fri, 11 Sep 2026 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122641;
	bh=7StcpINhgkUNZJ8KQgFMXXNZ/Q/7mHJECdjBcxoubEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJWF9m9zjvYtMpuGb7LMNbW8EBNSDZ2UcZ+8ZSYnE0S7heuuORPzWodxI9kbFT4Gr
	 25a6qnsybTkt2tTrzb0n2uKLtmKKAGWLtu+Cc9yZFuAvlCILFjxPECJvAPzOKzinix
	 h2jZroIHVQpQKlFOOGg2sfgMvvdkTX/xEh5sBHvs3xWISvf99A15cBSo2sXS8v+pcH
	 N+Sp7fA3kT9MG2RVtlSxcnCH+VSksQ5E4VFyao/4SBCbewxeUV0qOuGw4miANfm+Pr
	 oaHw7wE9tg+BQNqp1zlhTK9kn4AayTsuUTpXexvu0NDum8fL99J+45TDe7kxNHwtV1
	 lZClzNgMA6/1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Add a test for nested virtual NMI
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911102105.1927773-1-hemanth.selam@gmail.com>
References: <20260911102105.1927773-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 10:30:40 +0000
Message-Id: <20260911103041.4E7A71F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing memory barrier before VM-exit allows compiler to reorder=
 global variable store, causing test flakiness.
--

commit 369b941892ff4fd633ee8a8bca1eef89e730d9a0
Author: Hemanth Selam <hemanth.selam@gmail.com>

KVM: selftests: Add a test for nested virtual NMI support

KVM's virtual NMI support for nested guests has no test coverage.
This commit adds a test covering the vNMI controls L1 provides in vmcb12,
including delivery of virtual NMIs to L2 and verifying the state of
V_NMI_PENDING and V_NMI_BLOCKING flags.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c b/too=
ls/testing/selftests/kvm/x86/svm_nested_vnmi_test.c
> new file mode 100644
> index 0000000000000..4e9916a837ddd
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_vnmi_test.c

[ ... ]

> +static unsigned int nmi_fired;
> +
> +static void guest_nmi_handler(struct ex_regs *regs)
> +{
> +	nmi_fired++;
> +
> +	/*
> +	 * Exit to L1 from NMI context, i.e. before this handler's IRET, so
> +	 * that L1 can observe V_NMI_BLOCKING while the NMI is in service.
> +	 */
> +	vmmcall();
> +}

[Severity: Medium]
Could an optimizing compiler reorder the store to nmi_fired after the
vmmcall()?

Since nmi_fired is a plain global variable and vmmcall() is implemented as
an inline assembly block without a "memory" clobber, the C standard allows
the compiler to reorder the memory store across the vmmcall() instruction.

If instruction scheduling places the memory store after the vmmcall(), L2
will execute the VM-exit before the store is committed, causing the host (L=
1)
to read a stale value and making the GUEST_ASSERT_EQ(nmi_fired, i) assertion
fail sporadically.

Would adding a compiler barrier or using WRITE_ONCE() before the vmmcall()
help ensure the store is committed before exiting to the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911102105.1927=
773-1-hemanth.selam@gmail.com?part=3D1
