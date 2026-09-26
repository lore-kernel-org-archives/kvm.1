Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D12EEE62
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384309; cv=none; b=XjEbFU4NRjWmnOWeIGfMCwMhLCQBR1OZzti/+At/V4AbyfOXkqDJY92tXmrgKxyHPOzuSA9cq6SRMer83010oVOKcin10wCoI7min8uwYbSbU/UGzh/Oqe5Z9fmJa2md3EGR2dgd9fKWz7T8oVS2h3c9Orvw5A59TqD2Kyv5WIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384309; c=relaxed/simple;
	bh=HSaZn4pGeKCnEvcmRi+P4ykdaajcV9qbNw9JeMhcufs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUXlhr7ps/NhSCivQKvLMGV4GGJ8qOegDV7WjXAMsrfygjRECKx1Uc0Fy8QFbUtTLxwHMErzsQ+o8Lf/5NxkhUe3jJFQHvcdTWGOWXqxlasPlN0Yx5Ql7ZvAXAmkN1Bv5ij1VvVpeXdIk6ICpsTjIEI12I96jE0zopmdSTwSFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMq35k65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMq35k65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799B51F000FF;
	Sat, 26 Sep 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384307;
	bh=1U3HSJnlrzs/wfXzjK/Bs6VUlwUTr+2vXdtKA3E7m44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMq35k655N5UAJG/uUYcJ4wBqCBUFiLvS1jhWTN1w7vFCpqDdZYfgfeJti4C9lkv5
	 iy0bc1goRlTn0eHYYxgUSey4BopkjqeBQ9UocSfsBvfG02YxSXEUJhlZ8b9RUMD32N
	 i7YWuOA/h2FiNhU1G8TP93rLQbr91z201POWxmb+MBYQsXQV4FFoOD/tsg7cIz6oql
	 2s85nfW+rdUFcMibTJ68v+qlpWfMYLM8cip7lFzeJIkckDNgCTY96peftTiTLhE/KF
	 QNzQ+QWyR9SPZNPPPdtiUhqUnx60yZaVWPjLYHUoPr4lUAFyIW7V9SVDc49kPJ0DTf
	 krpD0yY3W3cgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/17] KVM: selftests: Test rejection of hugepage
 tmpfs mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-10-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-10-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:58:27 +0000
Message-Id: <20260926005827.799B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: test_resource_fd_tmpfs_huge aborts on systems wi=
thout THP
--

commit 3b3c9f0d1e79074e146192602be76f64b250554b
Author: Ackerley Tng <ackerleytng@google.com>

    KVM: selftests: Test rejection of hugepage tmpfs mounts

This commit adds a test to verify that guest_memfd creation fails when back=
ed
by a tmpfs mount with huge pages enabled.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 5d017164d7b45..e8199ed17b0f8 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -526,6 +526,21 @@ static void test_resource_fd_tmpfs_swap(struct kvm_v=
m *vm)
>  	close(pool_fd);
>  }
> =20
> +static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
> +{
> +	int pool_fd, fd;
> +
> +	pool_fd =3D create_tmpfs_pool_fd("always", true, page_size);

[Severity: Medium]
Will this unconditionally abort the test suite on systems that lack
Transparent Huge Pages (THP) support?

When create_tmpfs_pool_fd() is called, it issues an fsconfig syscall wrapped
in a hard assertion:

tools/testing/selftests/kvm/guest_memfd_test.c:create_tmpfs_pool_fd() {
	...
	if (huge)
		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_STRING,
				     "huge", huge, 0), "fsconfig huge failed");
	...
}

If the host kernel was built without CONFIG_TRANSPARENT_HUGEPAGE or otherwi=
se
lacks hardware THP support, wouldn't the fsconfig syscall fail with -EINVAL
and trigger the hard assert, aborting the rest of the guest_memfd_test suit=
e?

> +
> +	fd =3D __vm_create_guest_memfd_resource(vm, page_size,
> +					      GUEST_MEMFD_FLAG_USE_RESOURCE,
> +					      pool_fd);
> +	TEST_ASSERT(fd < 0, "guest_memfd with huge-enabled tmpfs should fail");
> +	TEST_ASSERT_EQ(errno, EINVAL);
> +
> +	close(pool_fd);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D10
