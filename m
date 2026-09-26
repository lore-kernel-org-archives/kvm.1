Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2330FF2A
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384469; cv=none; b=aOhlIqpwW1+ETEOIzADs1qcyjGGNEHllW2kZXp2qJoSVjgVPq6HNh7UT1VYqHLYlVqbm1tl2Oe0T26QdQAZuZ2sgefg3iTLF5qdBniDaLDjRZgh2wUcW9GBTQky4s96OzRu41JvqOoBqLjwOlY0Ek6nZGPikH8f0zhkoK3qLlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384469; c=relaxed/simple;
	bh=cK2kawnTS7vlF98mXmqGd1gBqfByH33rZPKu35A19m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6lxSVNLuZ3dVkGcvpF94rHu9iKeUVelH2uVBjq15I+NmacoxYi7zTw6R6HoTdouqOiMq4D86v16tWoiciwXv3dY+KZ2l+sqC45kJ/0qAYRZ0V86askJiwQidy4ZXsKf/MYOp7ChgQ9734+C+7V9AoHmTujGT4nHuz2sxK8kTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1+KK2t5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1+KK2t5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EFC1F00893;
	Sat, 26 Sep 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384464;
	bh=HVZRN63cGoMPv18uJesNgmB+G4qQuEMbbElJHpEg7yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y1+KK2t5NgfcYYRsHrozJU4CArepEy4rOT8/2d4jajlMWnRvO/nIZofJ7GeQovGq3
	 WHYlM6Y6v3rLsqWn3GOPjIeHLTvBhc11k3/ATyVZQuEvpdEfCDq6Fyydf9aMi0SZZX
	 MKBYe2zSXibZByRC7TjC2gGSx2C+CnUXKa/YR89MtBAQWlL7M940OaDrVSMML6dJGA
	 jfol8RFh02MDlkGd4uOM1VZ5mGyoTvLzriiU/TG/owLetUmPFXMEsm3juepUbz/xec
	 fgq0hjMVGFw6zQJGD0TvYngRTD2JOH361NCLo6NzWwP0eV/WkOyRFJEQgP9fjiId1H
	 2D2hDjtyOd+CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/17] KVM: selftests: Test negative validation of
 resource_fd argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-6-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-6-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:01:04 +0000
Message-Id: <20260926010104.90EFC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: backwards compatibility broken by unconditional =
resource_fd test
--

commit 2b17d287ef002db57e09b112a2ab9e4264aeefd9
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test negative validation of resource_fd argument

This commit adds negative test coverage to ensure that creating a guest_mem=
fd
instance with a non-zero resource_fd without the GUEST_MEMFD_FLAG_USE_RESOU=
RCE
flag fails with -EINVAL. It also verifies that using an invalid resource_fd
with the flag fails with -EBADF.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 2233d871a38f4..84b958b9ef715 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -418,6 +420,22 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
>  	}
>  }
> =20
> +static void test_resource_fd_invalid(struct kvm_vm *vm)
> +{
> +	int fd;
> +
> +	/* Non-zero resource_fd without GUEST_MEMFD_FLAG_USE_RESOURCE fails */
> +	fd =3D __vm_create_guest_memfd_resource(vm, page_size, 0, 1);
> +	TEST_ASSERT(fd < 0, "guest_memfd with resource_fd but without flag shou=
ld fail");
> +	TEST_ASSERT_EQ(errno, EINVAL);

[Severity: Medium]
Will this ioctl unexpectedly succeed on older kernels that don't support
GUEST_MEMFD_FLAG_USE_RESOURCE?

Older kernels did not validate that the reserved array in
struct kvm_create_guest_memfd was strictly zeroed. Because resource_fd
replaces reserved[0], passing resource_fd =3D 1 with flags =3D 0 on an olde=
r kernel
will successfully create a guest_memfd rather than failing with -EINVAL,
causing spurious selftest failures.

> +
> +	/* Bad file descriptor with GUEST_MEMFD_FLAG_USE_RESOURCE fails */
> +	fd =3D __vm_create_guest_memfd_resource(vm, page_size,
> +					      GUEST_MEMFD_FLAG_USE_RESOURCE, -1);
> +	TEST_ASSERT(fd < 0, "guest_memfd with -1 resource_fd should fail");
> +	TEST_ASSERT_EQ(errno, EBADF);

[Severity: Medium]
Does this return -EINVAL instead of -EBADF on kernels lacking
GUEST_MEMFD_FLAG_USE_RESOURCE support?

Passing the unsupported GUEST_MEMFD_FLAG_USE_RESOURCE flag to an older kern=
el
returns -EINVAL instead of the -EBADF expected by this test, leading to test
failures.

> +}
> +
>  #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
>  do {									\
>  	int fd =3D vm_create_guest_memfd(__vm, __gmem_size, __flags);	\

[ ... ]

> @@ -476,6 +494,8 @@ static void test_guest_memfd(unsigned long vm_type)
> =20
>  	test_guest_memfd_flags(vm);
> =20
> +	test_resource_fd_invalid(vm);

[Severity: Medium]
Is it intentional to call test_resource_fd_invalid() unconditionally here?

This bypasses the capability checks that properly gate other flag-dependent
tests. Calling it unconditionally breaks backwards compatibility for kselft=
ests
when running against older kernels.

> +
>  	__test_guest_memfd(vm, 0);
> =20
>  	flags =3D vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D6
