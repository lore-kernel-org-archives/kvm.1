Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048D2628D
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384557; cv=none; b=VWfBh379ewoP+CTFLKjwXf6sNcA+Q7wPV7XE81XuKwkxWsLuWa8qVe6hPGYSaIrye9WGjf2xnRHTFD112xMWDpfDab576W8buCOOtTlwYzQrdtJHf6aO/+dfdmxtmYIEksI2OSm7TPb01Clcoi1o1F85+iHRRqHUZY0hjrUcdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384557; c=relaxed/simple;
	bh=3LjH9BfkyM4GBsLU5MUYwaBgda2v7uClmrgz5sLzueU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUuMP60ijhJdLxGXnow5S6rzZMKZ3BiQoXDvjMXhLY2rXBWcTuHwZlKdstQacm+Gd5LE/WAtE3zHV99r0Qn51I3dnM+G92uQ/1MK2lV7LT37y7BP70XY7v0K2avnL8RZ21+yW4Ps/9WgPQ6OVKRnl7ghDF4vm0Tan3+US1Abzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqV1UMg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqV1UMg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054251F0089A;
	Sat, 26 Sep 2026 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384556;
	bh=7rd0gLljfKFxw3elaOaBq61evxCtNser/YB/Y422igA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqV1UMg/8IrqMj5HsEFCP7Fh9ErFZtP/FNfqiw1qkk5Wp58hdHCBYzzOFwlZO1AQp
	 xUrEmACqd1rACJANcZz0CFFDSOTYz4g8OEuII5UvKXRiAJvHoRB4BHEZUxSaykPZVX
	 aB8/6zsEqtG2yDJt+2b6Q32Ei8dD04oxHbYWFskCgAD3pieShapvgQPF41bwOJo/BW
	 Fb2KwKaeJagCrBt+UDYZ9UFXUo47BuqcVebbDuDJDkydQjU8aWv2cu9lQBJm7+5d27
	 pw6LbEjz1eZNZfjGIHyjqh4HGAel+IdGdktUssuOBR2E7w3vhNm0bfcMMOvwBqfPeY
	 GBQ6z7qLjdX5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/17] KVM: selftests: Test guest_memfd with
 anonymous fsmount() tmpfs pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-11-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-11-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:02:35 +0000
Message-Id: <20260926010236.054251F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] kselftests: kvm: incorrect fd validation in create_tmpfs_pool_fd=
()
- [Medium] kselftests: kvm: brittle invalid size test implicitly uses resou=
rce_fd=3D0
- [Medium] kselftests: kvm: test fails on older kernels due to missing flag=
 cap check
--

commit b9ccbfbf6c1bd14da922a66c6dd6f5735cd34ba0
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest_memfd with anonymous fsmount() tmpfs pool

Add test coverage verifying that creating a guest_memfd backed by an
anonymous tmpfs mount descriptor returned by fsmount() succeeds and
reports the requested file size.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index e8199ed17b0f8..73212d5307049 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -541,12 +541,23 @@ static void test_resource_fd_tmpfs_huge(struct kvm_=
vm *vm)
>  	close(pool_fd);
>  }
> =20
> -#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
> -do {									\
> -	int fd =3D vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
> -									\
> -	test_##__test(args);						\
> -	close(fd);							\
> +#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)		\
> +do {										\
> +	int pool_fd =3D -1;							\
> +	int fd;									\
> +										\
> +	if ((__flags) & GUEST_MEMFD_FLAG_USE_RESOURCE) {			\
> +		pool_fd =3D create_tmpfs_pool_fd("never", true, __gmem_size);	\

[Severity: Medium]
Does create_tmpfs_pool_fd() correctly handle when fsmount() returns 0?

Looking at create_tmpfs_pool_fd():

    mnt_fd =3D syscall(__NR_fsmount, fs_fd, FSMOUNT_CLOEXEC, 0);
    TEST_ASSERT(mnt_fd > 0, "fsmount failed");

While typically stdin, file descriptor 0 is valid. If fd 0 is allocated to =
the
new mount, a successful fsmount will trigger a false test failure because t=
he
assertion strictly checks for mnt_fd > 0 instead of mnt_fd >=3D 0.

> +		fd =3D vm_create_guest_memfd_resource(__vm, __gmem_size,		\
> +						    __flags, pool_fd);		\
> +	} else {								\
> +		fd =3D vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
> +	}									\

[ ... ]

> @@ -606,15 +617,23 @@ static void test_guest_memfd(unsigned long vm_type)
>  	test_resource_fd_tmpfs_huge(vm);
> =20
>  	__test_guest_memfd(vm, 0);
> +	__test_guest_memfd(vm, GUEST_MEMFD_FLAG_USE_RESOURCE);

[Severity: Medium]
Does this implicitly pass resource_fd=3D0 when testing the USE_RESOURCE fla=
g?

Looking at test_create_guest_memfd_invalid_sizes(), which is called via
__test_guest_memfd():

    fd =3D __vm_create_guest_memfd(vm, size, guest_memfd_flags);
    TEST_ASSERT(fd < 0 && errno =3D=3D EINVAL, ...);

Because __vm_create_guest_memfd() defaults to 0 for the resource_fd, it rel=
ies
entirely on kernel parameter validation ordering. If the kernel's parameter
validation evaluates resource_fd before size, this will unexpectedly return
EBADF or ENOTDIR (as fd 0 is typically not a valid tmpfs mount), causing fa=
lse
test failures instead of the expected EINVAL for unaligned sizes.

[Severity: Medium]
Does this unconditionally execute the USE_RESOURCE tests without checking i=
f the
flag is supported?

On older kernels, passing an unsupported flag returns -EINVAL. This will ca=
use
test failures since the feature is not exposed via
vm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS) and skipped gracefully. For example,
test_resource_fd_invalid(), which is called just above this line, expects
-EBADF but will receive -EINVAL when the USE_RESOURCE flag is unrecognized:

    fd =3D __vm_create_guest_memfd_resource(vm, page_size,
                                          GUEST_MEMFD_FLAG_USE_RESOURCE, -1=
);
    TEST_ASSERT(fd < 0, "guest_memfd with -1 resource_fd should fail");
    TEST_ASSERT_EQ(errno, EBADF);

> =20
>  	flags =3D vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);
> -	if (flags & GUEST_MEMFD_FLAG_MMAP)
> +	if (flags & GUEST_MEMFD_FLAG_MMAP) {
>  		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP);
> +		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
> +				       GUEST_MEMFD_FLAG_USE_RESOURCE);
> +	}
> =20
>  	/* MMAP should always be supported if INIT_SHARED is supported. */
> -	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED)
> +	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
>  		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
>  				       GUEST_MEMFD_FLAG_INIT_SHARED);
> +		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
> +				       GUEST_MEMFD_FLAG_INIT_SHARED |
> +				       GUEST_MEMFD_FLAG_USE_RESOURCE);
> +	}
> =20
>  	kvm_vm_free(vm);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D11
