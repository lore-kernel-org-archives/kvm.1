Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560922A1D4
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831264; cv=none; b=n/ToEqMRcGCn1AJ4yF6U51ufppVdYmietUnN4BdnB7b7AwTMKsjuekqoV7c4dCrRo7pSjVLnj/YbftTAH7JaR33T5hDO8etUoaRer3QlBh1vHbzsYhsHMQ8GSdjgm/gQPjhTngt8+RzCU1TunosBCE991AcIUioAw4ZpSuCPK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831264; c=relaxed/simple;
	bh=/IHQbl8eQJj5hWcxwa+TO96YLMK9VCJKW55grJVyJR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8cSNEMdKalyAFDy/kA7HmziouKcocBmze7IQeMI8eLUQbQSrE8kz6gmfByKIg5a3CMcfqr2CigMvZ37B/Jz1Wb9a60pxKONS8kLTPJoV3qc6cn+0ydlR7oHXXrPDpQjVEyPfvQjsdvCFDrd6A6V2U938NQNZLr4s4PMmahx/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F63oT6AD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F63oT6AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB091F000E9;
	Fri, 19 Jun 2026 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831263;
	bh=lH+eZW1tIdGVopgwugFx4yAOiK5HqKqKfP57XZnRpGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F63oT6ADm4+GHGLbf+hdnIaksRL0Ijc5KcjmYupNod0i03xqVYIGd1wGydALluC8d
	 qY+tS64ZTh+6UO5uKWd8lCOTzUlH4FSLxZQ0oHpue/eRN0cgsga/tOesqXPFV/L8pQ
	 jUw9gvWTS6ilnEVksBIGYAwyABtyqqVAZtzx2jGmtcM3zSs0lMZb1ph2kUa7aOLIQ0
	 zv6VMEBWeZK8mdk0DNoK8wSVyEp37OkQIi4EnKHWnVBgyY7JyQLpVtJatE4d1Dp7pQ
	 Q+408BUuB/b3laFhDAlOEXLECsHk4a3yI3DZCdqywaiQvSfzd/idRpztyj/AbTuGaE
	 2TQsAjfmqLkBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 39/46] KVM: selftests: Test conversion with elevated
 page refcount
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-39-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-39-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 01:07:42 +0000
Message-Id: <20260619010742.ABB091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test assertion evasion due to `error_offset` zero-initialization=
 masking kernel bugs.
--

commit b2da0256dee5eac26d6a8400d7fa310b8e255837
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test conversion with elevated page refcount

This commit adds a selftest to ensure that converting a shared
guest_memfd page to private fails if the page has an elevated reference
count.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 99b0023609670..4ebbd29029526 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
[ ... ]
> @@ -441,6 +441,62 @@ GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
>  #undef TEST_STATE_AWAIT
>  }
> =20
> +static void test_convert_to_private_fails(test_data_t *t, u64 pgoff,
> +					  size_t nr_pages,
> +					  u64 expected_error_offset)
> +{
> +	/* +1 to make it anything but expected_error_offset. */
> +	u64 error_offset =3D expected_error_offset + 1;
> +	u64 offset =3D pgoff * page_size;
> +	int ret;
> +
> +	do {
> +		ret =3D __gmem_set_private(t->gmem_fd, offset,
> +					 nr_pages * page_size, &error_offset);
> +	} while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +	TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EAGAIN,
> +		    "Wanted EAGAIN on page %lu, got %d (ret =3D %d)", pgoff,
> +		    errno, ret);
> +	TEST_ASSERT_EQ(error_offset, expected_error_offset);

[Severity: Medium]
Will this poison mechanism work as intended when expected_error_offset is 0?

Looking at the underlying call chain, __gmem_set_private() calls
__gmem_set_memory_attributes(), which unconditionally zero-initializes the
error_offset field before issuing the ioctl:

	struct kvm_memory_attributes2 attr =3D {
		.attributes =3D attributes,
		.offset =3D offset,
		.size =3D size,
		.flags =3D 0,
		.error_offset =3D 0,
	};
	int r;

	r =3D __gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);

	/* Copy error_offset regardless of r so caller can check. */
	if (error_offset)
		*error_offset =3D attr.error_offset;

Since the wrapper ignores the poison value we pass in and overwrites it wit=
h 0,
if expected_error_offset happens to be 0 (e.g. for test_page =3D=3D 0) and =
a kernel
bug causes KVM to fail to populate error_offset, TEST_ASSERT_EQ(0, 0) will
still pass, incorrectly hiding the bug.

Should the test's poison value be passed down to the ioctl structure, or
should we use a non-zero expected_error_offset to reliably detect if KVM
updated it?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D39
