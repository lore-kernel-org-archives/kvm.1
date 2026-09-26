Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51D1D5174
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384844; cv=none; b=DfbXhL1+cnHTBLRbEklOi99XCacfOv5VpQJZ3pCmskcSSMNOHgSbofZ3eu6oT46FE6VavmX4ltNiftIudS7E+yWXsAlLq8Qqy+fDsrYRc47NimHjHWcLesggLKH6p4nXQnzJS9BQ9dzqlpCiTYK9GJQ+SH/HNTDthI5UTiCJZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384844; c=relaxed/simple;
	bh=ejy5b4PMhv7t/pOeBdDb9W31d4G/UuLF4FuE4a5kjL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iDCPBEEudUOHjGAsMVWQ3vwxt+j3fCNNpe/M7DbeMdcDQLyoT4Tuj3oYeAu9O6inISYy361NuCurJypOHnh6gA1kWqsygRlChoPeohGk7PZR7aWo1bsQpIHOgvBEp21eGWr54dCM7lf16imasxjwTZeyyYTHiMX0Qawm5DDjeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ZVIoBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1ZVIoBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6871F000FF;
	Sat, 26 Sep 2026 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384842;
	bh=391jlS4/jQnlrYqy7tCyo+yqWkv8Xp4D49bpjryNOjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1ZVIoBWSvOVt6klmDppWa96L/ogVQQdHDLvyYovcG3S0G5GQZ2t7Iwjtr5MvsXHD
	 S8ztevpsrNdZM8SmONdHQEZz6DucbTLE58iRID9utYJ2emk7K1ErYcVp5MQJ4TIkGR
	 4zaOor5/xobrlcFi0rxn+4h/00/rJqAvkYmThpIWbkMe+mwt1snY+hF4HggEKAo0L9
	 j6SdYLz0q5bi/Tqs1zaoZO8jRsSSYFJSwhzQcbyZAj3oDOcc3EAizWCF0KSG61gPXX
	 QkXA9BoISayaV33Bzkqs6CwZPvdR60t4fFr2GoNVBpcs+Sc4FUmzWUz/fvIP9fy9ft
	 ptJq5A4fuSySQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/17] KVM: selftests: Test guest execution with
 tmpfs-backed guest_memfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-16-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-16-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:07:21 +0000
Message-Id: <20260926010722.2D6871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: guest_memfd: tmpfs pool capacity mismatch causes ENOS=
PC
- [Medium] selftests: guest_memfd: missing backward compatibility check for=
 USE_RESOURCE flag
--

commit 1a86f5779ff5f4e3456d291df1f061ef3218958b
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest execution with tmpfs-backed guest_memfd
   =20
Test that a guest vCPU can execute instructions and read/write memory
mapped into a guest_memfd instance that is backed by a tmpfs resource
pool descriptor.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 345b41c912a18..bf369874f2647 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -829,6 +829,62 @@ static void test_guest_memfd_guest(void)
>  	kvm_vm_free(vm);
>  }
> =20
> +static void test_guest_memfd_guest_resource(void)
> +{
> +	const gpa_t gpa =3D SZ_4G;
> +	const int slot =3D 1;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int pool_fd, fd, i;
> +	size_t size;
> +	u8 *mem;
> +
> +	if (!kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
> +		return;
> +
> +	pool_fd =3D create_tmpfs_pool_fd("never", true, page_size);
> +	if (pool_fd < 0)
> +		TEST_REQUIRE(false);
> +
> +	vm =3D __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, gues=
t_code);
> +
> +	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_F=
LAG_MMAP,
> +		    "Default VM type should support MMAP, supported flags =3D 0x%x",
> +		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
> +	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_F=
LAG_INIT_SHARED,
> +		    "Default VM type should support INIT_SHARED, supported flags =3D 0=
x%x",
> +		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
> +
> +	size =3D max_t(size_t, vm->page_size, page_size);

[Severity: Medium]
Will this capacity mismatch cause the test to fail unconditionally with
ENOSPC when the guest page size exceeds the host page size?

The tmpfs pool is sized statically to the host page_size earlier in the
function, before the required guest memory size is dynamically calculated
here. This could structurally prevent the test from passing on architectures
with larger guest page sizes (e.g. ARM64).

> +	fd =3D __vm_create_guest_memfd_resource(vm, size,
> +					      GUEST_MEMFD_FLAG_MMAP |
> +					      GUEST_MEMFD_FLAG_INIT_SHARED |
> +					      GUEST_MEMFD_FLAG_USE_RESOURCE,
> +					      pool_fd);
> +	TEST_ASSERT(fd >=3D 0, "guest_memfd with tmpfs pool should succeed");

[Severity: Medium]
Could this crash with an assertion failure instead of gracefully skipping
when run against older kernels?

The GUEST_MEMFD_FLAG_USE_RESOURCE flag is passed here without validating
whether it is present in the KVM_CAP_GUEST_MEMFD_FLAGS bitmask, which is
required for backward compatibility with kernels lacking support for this f=
lag.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D16
