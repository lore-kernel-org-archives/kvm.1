Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52E2DF3F2
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384162; cv=none; b=P8pH23JDnD92VJqOwdoS0B2hcSsAnZcnXbXATqwStGRb1lILL0ZVmgxXiQY2vkKZfXRJIDCF8SD6PYew3BC2otRwuQke3sAPDGDjap5OUYeNdHEVVow8Q4s8tu1k8wuI7nF4qVFjxKJBPnXqYzNL4IdWFupCko1x9yX1R2P31Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384162; c=relaxed/simple;
	bh=egMb6CzK84Lvga6QGTOqa9a4moRv52bs6/H7i3g4SsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2iIHnLVGGxgckCht11bsUTfj03E+/7plKWhsMQce8agL29vCbqSQoGVULRogfStVmFOAgYACL1JfHlsfcbC9IVzfo47qgqVRJmtP3UPEf6goTvY634+U243Sr/nV3qiqkzLz9RiJNt68LFmV+pxL1sdWEJGGdjU8GU29cxCqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgsrWj6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgsrWj6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C181F000FF;
	Sat, 26 Sep 2026 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384161;
	bh=WuZIaPwLDottPjB4qgTAzO76Xq4Sw33Dz3bLk7UEIOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgsrWj6jChajP77SiHd01Yec3kdnqSY8XhywCxxJIPeqTV+NWVnidYSI+hC20q1mJ
	 t4sVXCwXzUuvXkahT8SmzTfym26vJy+NAVGP86qc8LR2ekzNeNTe1k2WfBeovmFnCO
	 q8h4V+vtuPJtSDcmuZJTV0wcZkTqpdvVGC+XRvVKIYm5zZ8uL4YwnCmSWy17W/wy8E
	 5WQfYGlv+FGSTfQtrN1HKI8YBO+v4P8YYLc22DvUqyJm4JSSBrBnID/jClymKCtQnR
	 13ikrmS3JmGDmJcZQO5o0rCoSm+br6xelUPCmSFPxAINalBVzGatZ+h+SPVRcS712z
	 Ifq+xlqhso2Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/17] KVM: selftests: Test rejection of unsupported
 filesystem for resource_fd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-7-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-7-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:56:00 +0000
Message-Id: <20260926005600.D3C181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: missing capability check for GUEST_MEMFD_FLAG_US=
E_RESOURCE
--

commit 12edbf910d6d9507b605565dea5dca809a2eece9
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of unsupported filesystem for resource_fd

This commit adds test coverage to verify that passing a directory file
descriptor from an unsupported filesystem fails with EOPNOTSUPP.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 84b958b9ef715..31bc74c4c26bd 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
> @@ -495,6 +516,7 @@ static void test_guest_memfd(unsigned long vm_type)
>  	test_guest_memfd_flags(vm);
> =20
>  	test_resource_fd_invalid(vm);
> +	test_resource_fd_unsupported_fs(vm);

[Severity: Medium]
Does this new test invocation need to verify if the underlying KVM module
supports the GUEST_MEMFD_FLAG_USE_RESOURCE capability before running?

The test_guest_memfd() function unconditionally calls
test_resource_fd_unsupported_fs(), which passes the
GUEST_MEMFD_FLAG_USE_RESOURCE flag to KVM. On older kernels lacking this
feature, the ioctl will reject the unknown flag with -EINVAL.

Since the test explicitly expects -EOPNOTSUPP, this mismatch will cause the
assertion to fail and abort the test run, unexpectedly breaking backward
compatibility for the test suite.

> =20
>  	__test_guest_memfd(vm, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D7
