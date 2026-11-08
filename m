Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098644;
	b=e/j4S+5foenjIYFSKN7gmcwhIDDkcfV65egHM0ejCj+N75lFaWxP/cr5f44YmTkYLgt0
	 /1la2Mma6mQI8xxbIOklQ1FHNLE+IjqPISwRFT72MXJueA0s4PAkORSzjjFNzCTraqLAr
	 qKDWrFaqNhSpOtOe1z/DMp6x/77spM5jrXRBAbza8iBojUFicAPn8WA/9n9bIoZAkKmsO
	 +lyqP8X1Xa1CkWnIML/oRQd1FFPuA0SAPucc5UVEChJaQngzz57z8f2tK8dMKlDpu8+y2
	 3NcgzE07B0+gOHnrfBiOqlz0SNe8v80GYw9x/TFgWPVR4zq002qSp+aYyhzZn4t/h3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eIchnQRlgp7AVtT1biMkeiqkz7sV5hY4Y3uzSD6iLfQ=;
	b=e/EAZuns0AcvVeFfA4+M06WY/0rtCTwI2k4zKXDM+WHg//9ZDknlyD6Uokl7x/egLgB5
	 3rnvYgDhPXuLXosU4gCKJvITNJ6TsLoVRSJ52ckjCSIhkB2tk75cn+XxWvdKRIK8fdrDr
	 3FVxNJDQ2GI0w1eUY6d23ee4h/AiqzZel7qcyKo1ygQoHoP+sYB6oR3pwGKqx/nYh+PmE
	 YHYxVjMw9cQtgy6L/BNlyThhXFJDXlnsNJV5NNQOFfaWini5D8kvu4wr3N9xay6tgYFB8
	 AN7HH4NXXW9GUJsLRuv72f/9k8+zUiQ8oi0wLgSGIhhPjTMB9QOUdlWEU4zUtfF3bvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqpjIbit;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F8606A33A
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqpjIbit
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5547D1F0089F;
	Sun,  8 Nov 2026 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098643;
	bh=eIchnQRlgp7AVtT1biMkeiqkz7sV5hY4Y3uzSD6iLfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqpjIbite5no/XC7mXhZNwr8TNiS5Qgk4Sti4UMTpMJfYfS2uMPbPGCDUjU0uWUUm
	 4Rw1R06Zkdm1OEDq7I4+c5uG/lpYSxzSs2hFrEAJwWNA1EdUGjxzog5aiJHF0zgqS/
	 kk8wUOSzzsklutJNYT72jks+X6+aS3Asgh4wdqYfYPuMeOl6xzeljQP8wmKzkGwTg8
	 ZYF6ixaBQV72jd70e2XnmqDvsoN2cru+/lDlOYrjtpTfGn649jknUyuk4Mhxn18Wko
	 339VmpznhgveJ/jM9tpJ6u300OfTsaHOIQEDXT8eAa4IgFaF7jKTCgscLfbqxWOSpY
	 t7wDP+SjEqoFg==
Message-ID: <sashiko-outbox-203436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 25/88] KVM: selftests: Add basic test for sample
 memory provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-25-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-25-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:01 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: selftests: open_provider_dev() reimplements
  __open_path_or_exit()
--

commit 0532d9b657d56f90c6d83715d992908b2bbe987a
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add basic test for sample memory provider

This commit adds a selftest for the sample memory provider to test file
creation across multiple sizes and verify initial statistics.

> diff --git a/tools/testing/selftests/kvm/mem_provider_sample_test.c b/too=
ls/testing/selftests/kvm/mem_provider_sample_test.c
> new file mode 100644
> index 0000000000000..b39161f4933d3
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
> @@ -0,0 +1,85 @@
[ ... ]
> +#define DEV_PATH "/dev/memory_provider"
> +
> +static int open_provider_dev(void)
> +{
> +	int fd =3D open(DEV_PATH, O_RDWR);
> +
> +	if (fd < 0) {
> +		TEST_REQUIRE(errno !=3D ENOENT && errno !=3D ENODEV);
> +		TEST_FAIL("Failed to open %s: %d (%s)", DEV_PATH, errno,
> +			  strerror(errno));
> +	}
> +	return fd;
> +}

[Severity: Medium]
Could open_provider_dev() use __open_path_or_exit() from kvm_util.h
instead of hand-rolling the open() error handling?

/dev/memory_provider is registered with default 0600 permissions, so
running the test as an unprivileged user fails with EACCES and hits
TEST_FAIL().  Inside test_assert(), test_dump_stack() prints an assertion
failure stack trace and calls system(), clobbering errno before the
EACCES check and exiting with status 254 instead of KSFT_SKIP:

tools/testing/selftests/kvm/lib/assert.c:test_assert() {
	if (!(exp)) {
		...
		test_dump_stack();
		...
		if (errno =3D=3D EACCES) {
			print_skip("Access denied - Exiting");
			exit(KSFT_SKIP);
		}
		exit(254);
	}
}

Using __open_path_or_exit() skips cleanly via ksft_exit_skip() on both
EACCES and ENOENT, and prints the device path and prerequisite help text
instead of the literal TEST_REQUIRE() condition when the module is not
loaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D25
