Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13538F939
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566147; cv=none; b=RVvVv4UhKFBOkys6aCBJVEqdNNdTOvM+f56ZhhovqnYwPvWuiH3p15rqVfAXv5MmDbdzJa4o7YTsxD+KxcZMz510VlpJ6/w93gyu/3pmtiYMhCYgZtdVsJNRPln8d6duLZ9YsoX9qLqummnpkYCXaqHg256iBk8XTPcjG76sUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566147; c=relaxed/simple;
	bh=yh/3DfNhzvQDZNpY3sDjDm0Xmh9qRX6yecLs2KZ5r2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u13T5XBflf902Goaj4xTY4Drk7ksDbyQyAc0yxr/4RpuWAv3SuxkJ9jxSfkqDVryNx7CSGUtusznV0msOKov8jp3DJ1Pwti9KVaKhjWe21mMDupX8M9q7LG1HN3SCuIhiT8TAY15t2vhRG+vmYZdHrrlTOonZdUNDlJJlvpbKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWU34HRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWU34HRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE201F00893;
	Thu,  4 Jun 2026 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566146;
	bh=kjjqElfgCERY0RcqecH/D2b9wdh4IVtbUXWU5a0qmPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWU34HRLGExg7s+m1y8VM+fzOFaTv5j1DBysUaOytJUvW3mqqnP4z8qcbkpmEsJxS
	 CIhfp8znYZqXIsAnMGXH6xJIXFW7cce7LM+79T3aZvBqSLKHQuHthFk1nFZaGuBB6S
	 +A7ncIuAhnYVLObjjDRXu+IEm2Z5bJmWQlSfKr/0h0bt+iLcXe4k1prNQSpolGzmJ1
	 D9udTV23zMMrC5GTdvZppMQeYKiE99z/6ZqVIxTxQqXrYnX/wdmtGVrAAKOD4obIoU
	 rlXMTg4d+ujeP12X7NsGUWIC2C1rBIRcO5fS8hnqCD8YXrOgU7VX2u9TAxCkBuPa6c
	 E+V2RtDiB/cKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kvm powerpc/book3s-apiv2: Add suite initialization to
 skip GSB tests without APIv2 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604092931.344101-1-vaibhav@linux.ibm.com>
References: <20260604092931.344101-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:42:25 +0000
Message-Id: <20260604094226.3BE201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional hypercall execution in the test suite initialization=
 will cause a kernel panic on bare-metal (PowerNV) systems.
- [Medium] The capability check yields a false positive when compiled witho=
ut `CONFIG_PPC_PSERIES`.
- [Medium] Skipping the entire test suite when APIv2 is unavailable disable=
s purely memory-manipulation tests that do not depend on the hypervisor.
- [Low] Directly modifying the private `status` field of `struct kunit_case=
` violates the KUnit API.
--

commit 91f29321c74a3de9acc6e6b6af3b00cdee30f4f2
Author: Vaibhav Jain <vaibhav@linux.ibm.com>

kvm powerpc/book3s-apiv2: Add suite initialization to skip GSB tests withou=
t APIv2 support

This commit adds a suite initialization callback to check for PAPR APIv2
nested virtualization support. If APIv2 is not supported, it marks all test
cases in the suite as KUNIT_SKIPPED to prevent test failures.

Link: https://lore.kernel.org/all/20260603064225.GC18149@sol

> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kv=
m/test-guest-state-buffer.c
> index 5ccca306997a8..f84b40fa55db6 100644
> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c

[ ... ]

> @@ -521,6 +521,24 @@ static void test_gs_hostwide_counters(struct kunit *=
test)
>  	kvmppc_gsb_free(gsb);
>  }
> =20
> +static int init_gs_test_suite(struct kunit_suite *suite)
> +{
> +	long rc;
> +	unsigned long host_capabilities;
> +	struct kunit_case *test_case;
> +
> +	/* Enable test suite only if APIv2 is supported */
> +	rc =3D plpar_guest_get_capabilities(0, &host_capabilities);

[Severity: High]
Could this unconditional hypercall execution cause a kernel oops on bare-me=
tal
(PowerNV) environments?

plpar_guest_get_capabilities() internally invokes plpar_hcall(), which
issues an "sc 1" instruction. On bare-metal systems without an underlying
hypervisor, executing this will trigger an Emulation Assistance exception.

Should this code verify that it is running as a guest by checking
kvmhv_on_pseries() before issuing the hypercall, similar to how
test_gs_hostwide_counters() is protected?

[Severity: Medium]
When the kernel is compiled without CONFIG_PPC_PSERIES, will this check
yield a false positive?

In arch/powerpc/include/asm/plpar_wrappers.h, plpar_guest_get_capabilities()
is defined as a stub that returns 0 (H_SUCCESS):

static inline long plpar_guest_get_capabilities(unsigned long flags,
						unsigned long *capabilities)
{
	return 0;
}

Because it returns success, init_gs_test_suite() could incorrectly assume
that PAPR APIv2 is supported and fail to skip the test suite on these build=
s.

> +
> +	if (rc !=3D H_SUCCESS) {
> +		/* Skip all testcases if no APIv2 support */
> +		kunit_suite_for_each_test_case(suite, test_case)

[Severity: Medium]
Does skipping the entire test suite unnecessarily bypass memory-based tests
that do not depend on the hypervisor?

Out of the 7 tests in the suite, only test_gs_hostwide_counters() executes
hypercalls. Tests such as test_creating_buffer(), test_adding_element(), and
test_gs_parsing() are strictly memory-based unit tests.

Could this lead to a loss of test coverage for valid test cases in non-APIv2
environments?

> +			WRITE_ONCE(test_case->status, KUNIT_SKIPPED);

[Severity: Low]
Is it appropriate to directly modify the private status field of the
struct kunit_case here?

In include/kunit/test.h, the status field is explicitly marked for
internal use only:

struct kunit_case {
[ ... ]
	/* private: internal use only. */
	enum kunit_status status;
[ ... ]
};

Direct manipulation of framework internals from within an architecture's
test module appears to violate the KUnit API.

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604092931.3441=
01-1-vaibhav@linux.ibm.com?part=3D1
