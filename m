Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818023E320
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700667; cv=none; b=D40Qa2XUTBeBXjp6SaCYsVQD9pa+uq3FXP9ecripGJHCl7iVLKs2RqVsbBOmaf4GZxWTq0+LUZydY/DvpfSS/XYj+iS7cCplOqv3WLwKJSKYYrCytz5gnu884rglpaUz/IfcDFmmKlurkA+OEu50QMC9asBgVcf9MclgoRm8jtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700667; c=relaxed/simple;
	bh=5mEpjbtHK5pt7m8hgy7PKrmwYtrktYkt1+JoeY0RroI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReNDcWaQN13n4TxcdT0l9EGC4bMiNhmvO+BZe6nUJYZC0yGG2dWeTH+UQ5txu8oIgXDEMUrBcI1bsOt7RDAat9H1uVV2PNhMddxZpFFwKQ/L6Et336HJuuxQ5EOQzqAgcd2Df5lI8aLIFPpCBGh4j5asScVxpw+n7meZxR7dRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8/FeVa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8/FeVa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C49D1F00A3A;
	Wed, 17 Jun 2026 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700665;
	bh=ZmN/OWZ0KXA6bellAuuVAIo6/lVS+KqkV7cbW3I6KWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8/FeVa8wNtoN6rhAlLmcZSM38DZLoRSbairpStxVwMoFrzx9PGVMCN3IteyvhndT
	 +mk8mJxZ4KTMCtndk8Ix7y2+BeSJ4uGbqd2UYUkCicQeuQRXs60k5X4ck4XtLHxBaS
	 fzeAvzyOOgdKSOcfxgaqu9DnpxZ2wDvNFR9AxQgSTRQjAVeaCsgZKpQWFlcCDPcCDx
	 GgE59JcKxnD8Zdbe71qKjExD2r+lp098JjBEyF9wItZDP8oN4wLuznhQ94S/kUMxjv
	 zqBxxUyhi03BI/YnRxUvj7rxMc6Fctf0oVxGZrVIef8YW3yZ5dONIj1zKDczL4kIew
	 eok18WwIZUZDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] kvm powerpc/book3s-apiv2: Add suite initialization
 to skip GSB tests without APIv2 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260617123820.467601-1-vaibhav@linux.ibm.com>
References: <20260617123820.467601-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 12:51:04 +0000
Message-Id: <20260617125105.8C49D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test suite is not actually skipped because `init_gs_test_sui=
te` unconditionally returns 0.
- [Low] Calling `kunit_mark_skipped()` on a `kunit_suite` pointer causes a =
compilation error.
--

commit f9ed140af60f93f156fdd320b1d30456dcf507f4
Author: Vaibhav Jain <vaibhav@linux.ibm.com>

kvm powerpc/book3s-apiv2: Add suite initialization to skip GSB tests withou=
t APIv2 support

This commit adds a suite_init callback to check for APIv2 nested
virtualization capabilities before running the guest state buffer tests.
If the host lacks support, it attempts to skip the entire kunit_suite to
prevent test failures on incapable systems.

Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol

> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kv=
m/test-guest-state-buffer.c
> index 5ccca306997a8..232c00493a25d 100644
> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c

[ ... ]

> @@ -521,6 +521,21 @@ static void test_gs_hostwide_counters(struct kunit *=
test)
>  	kvmppc_gsb_free(gsb);
>  }
> =20
> +static int init_gs_test_suite(struct kunit_suite *suite)
> +{
> +	long rc =3D H_NOT_AVAILABLE;
> +	unsigned long host_capabilities =3D 0;
> +
> +	/* Enable test suite only if APIv2 is supported */
> +	if (kvmhv_on_pseries())
> +		rc =3D plpar_guest_get_capabilities(0, &host_capabilities);
> +
> +	if (rc)
> +		kunit_mark_skipped(suite, "Unsupported hypervisor");

[Severity: Low]
Does this regression cause a compilation error?

Looking at include/kunit/test.h, the kunit_mark_skipped() macro expects a
struct kunit pointer as its first argument, but here we are passing a struct
kunit_suite pointer.

Because the macro expands to WRITE_ONCE((test)->status, KUNIT_SKIPPED) and
struct kunit_suite lacks a status field, won't this break the build? I
notice the commit message mentions this relies on a proposed patch, but
could it be adapted to work with the existing API?

> +
> +	return 0;

[Severity: Medium]
Is this a regression where the test suite won't actually be skipped because
the function unconditionally returns 0?

In the KUnit framework, a suite_init callback must return a non-zero error
code to abort initialization and prevent the test cases from executing.

Because init_gs_test_suite() unconditionally returns 0, won't KUnit
consider the initialization successful and proceed to run all test cases
regardless of the APIv2 check?

> +}
> +
>  static struct kunit_case guest_state_buffer_testcases[] =3D {
>  	KUNIT_CASE(test_creating_buffer),
>  	KUNIT_CASE(test_adding_element),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617123820.4676=
01-1-vaibhav@linux.ibm.com?part=3D1
