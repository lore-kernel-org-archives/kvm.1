Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56313315D32
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384470; cv=none; b=PltfcwrIWbJfM9bWfjP6ytsCWF1MtEzUv2fC5V3MeJDFr1kuZMWpyyJhObIHQUBTNsnTL840HeCMNr/L4o2uJNu88/mKxRBmG6Mk8qTOpXrqwDEm5K9A690eUGox6pii4K7tKkg3XhVzQdYQ/etZEFNu3q9WllhrWXEGMhOTsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384470; c=relaxed/simple;
	bh=v/4Te4/vFS79DgIp2TiNjhXo+OuUH0b+y1iyuMA+Pd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EN1dw5YuXbo7qKx4MPn1FpO5cvbMfE0uB37OXhqh2yVP+lfproAQBEMl8xij7uK8KWlOO8xE8KHUFT22pmbkrrOK/N2zCo8eMG0Ee4GUSC4FhM1D28Ak6wg9TH7mabTF/RdduSEzGl0bIvG6318okSmGDuZRxDtSjANDVSXtKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COT3r70M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COT3r70M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B01F000FF;
	Sat, 26 Sep 2026 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384465;
	bh=zdVO4mcm5QKO06l2tRgGWKxNkiOGcWyuLRzY0rce6JU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=COT3r70MtikkylWIG4HK3D+yiolXPTc6GqQR+H78+cI4vY5rc2h6XLA4sSAc47EfD
	 t0V3XZge3zT37jTuWGzWGUuYoxkhKIQdgj/GYrN0E1qYagBkSyIyXCCvnc0OO7G+fb
	 dfATJUAcq8mZnkOzfCBbNWWBNCSV5n05uY+Z5o9Us548+Boi3fygkRmIvQMFCmF27X
	 zhpz7vVxbs8qNAHafZ1E8yBWhydFGqsQc1Tl3gKrDzqA0d0IYEr5AWo7ASmi3GM5Kg
	 jd6K4SXz6rjjmcTSooB+YiZa0/L65QEIuzC/zMscyxrhhn85eolKj2n8cVxisETK7I
	 DgoOxFtvf652w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/17] KVM: selftests: Test guest_memfd with mounted
 tmpfs root directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-12-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-12-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:01:04 +0000
Message-Id: <20260926010105.4A5B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/kvm: guest_memfd_test unconditionally aborts on non-TH=
P kernels
- [Low] selftests/kvm: unhandled TEST_ASSERT failures leak host tmpfs mounts
--

commit 7820bbcbdad0955765992f96c9032de44d05bad4
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest_memfd with mounted tmpfs root directory

This commit adds test coverage to verify that opening the root directory
of an existing mounted tmpfs filesystem and passing its file descriptor
as the resource pool succeeds across guest_memfd subtests.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 73212d5307049..94ef64474f2a0 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -541,66 +543,122 @@ static void test_resource_fd_tmpfs_huge(struct kvm=
_vm *vm)
>  	close(pool_fd);
>  }

[Severity: Medium]
Does test_resource_fd_tmpfs_huge() unconditionally abort on non-THP kernels?

It appears this test calls create_tmpfs_pool_fd("always", ...) which relies=
 on
TEST_ASSERT() to verify the fsconfig system call. If the host kernel is bui=
lt
without Transparent Hugepage support (CONFIG_TRANSPARENT_HUGEPAGE=3Dn), tmp=
fs
will reject the "huge" mount option with EINVAL.

Since the assertion fails, does this fatally terminate the entire test suite
rather than gracefully skipping this specific THP test?

> -#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)		\
> +enum gmem_pool_type {
> +	GMEM_POOL_NONE,
> +	GMEM_POOL_FSMOUNT,
> +	GMEM_POOL_MOUNTED_DIR,
> +};
> +
> +struct gmem_pool {
> +	int fd;
> +	char path[PATH_MAX];
> +	bool is_mounted;
> +};
> +
> +static struct gmem_pool create_gmem_pool(size_t size, enum gmem_pool_typ=
e type)
> +{
[ ... ]
> +	strcpy(pool.path, "/tmp/gmem_test_dir_XXXXXX");
> +	TEST_ASSERT(mkdtemp(pool.path), "mkdtemp failed");
> +
> +	if (syscall(__NR_move_mount, mnt_fd, "", AT_FDCWD, pool.path,
> +		    MOVE_MOUNT_F_EMPTY_PATH)) {
> +		close(mnt_fd);
> +		rmdir(pool.path);
> +		TEST_REQUIRE(false);
> +	}
> +	close(mnt_fd);
> +
> +	pool.fd =3D open(pool.path, O_RDONLY | O_DIRECTORY);
> +	TEST_ASSERT(pool.fd >=3D 0, "open mounted tmpfs root failed");
> +	pool.is_mounted =3D true;
> +
> +	return pool;
> +}
[ ... ]
> +#define ____gmem_test(__test, __vm, __flags, __pool_type, __gmem_size, a=
rgs...)	\
>  do {										\
> -	int pool_fd =3D -1;							\
> +	struct gmem_pool pool =3D { .fd =3D -1 };					\
>  	int fd;									\
>  										\
>  	if ((__flags) & GUEST_MEMFD_FLAG_USE_RESOURCE) {			\
> -		pool_fd =3D create_tmpfs_pool_fd("never", true, __gmem_size);	\
> +		pool =3D create_gmem_pool(__gmem_size, __pool_type);		\
>  		fd =3D vm_create_guest_memfd_resource(__vm, __gmem_size,		\
> -						    __flags, pool_fd);		\
> +						    __flags, pool.fd);		\
>  	} else {								\
>  		fd =3D vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
>  	}									\
>  										\
>  	test_##__test(args);							\
>  	close(fd);								\
> -	if (pool_fd >=3D 0)							\
> -		close(pool_fd);							\
> +	destroy_gmem_pool(&pool);						\
>  } while (0)

[Severity: Low]
Can TEST_ASSERT failures in the test macros leak host tmpfs mounts?

In create_gmem_pool(), the tmpfs mount is attached to a persistent host path
in the host's temporary directory when using GMEM_POOL_MOUNTED_DIR. This is
done without unsharing the mount namespace.

If test_##__test() triggers a TEST_ASSERT failure, process execution will
terminate immediately. This bypasses the call to destroy_gmem_pool(), leavi=
ng
persistent mount points in the host environment. Repeated test failures cou=
ld
pollute the host environment and consume system resources over time.

Is there a way to unshare the mount namespace or register a cleanup handler
so that abrupt test terminations don't leak mounts on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D12
