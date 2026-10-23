Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798321;
	b=eeuKWbcW45WM/yHi0PlKLdg2mGx+dNGTYfkdTBAy/46eZb58oCkzDIZbXN5Is8MH5miX
	 Dn8b3zwCcNQ3Xs0tbdi4zBVOYNWn+lb/j9TvSgMvvlcx3ctapD+gO6UwV+86bbJW4DQxu
	 rDtmIrAMiUkxcWfqXyi9hm//FrJoJAVuhgf8bP+7t9JhUL/vTfIxwg4Y6RIDZgcVdvkw7
	 2eIlisVoZPNTOfesU0f882Kw4DpDTaQLBHX71yGh0+0sx74D/3+Yv6JPKaU65gX3N761q
	 GMM8IhsV8vPSJbbB4zW733vDfxbIq6CAdJ0lX5h5owAFHX+VfXWcgfcRIxLvIy+rHQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UrSgybGj3FSsK0vtkCR7+2GB7JEYjcDNJWMO0vka1Ak=;
	b=xieUzh0WDl9GzfCAz6TIsAie3klFXyIYLBF6FfHi31FkqcV7xhfHcZ00+Tf0fET2QenI
	 xrdcd0HiNGEM0UZ/JppoXzdLWbl8e9BLc+kGGzNX+RzF6sbM6M/BJizj/aw39axdOVl9n
	 DEgeu8hnbvYmyWHCQhQrz4Ac6mODDpXlVs3KV2rHWpHJZwvZ2CDfqM4cSVsKy9GWS20uE
	 9cI7h8sD0rBCkMIUYmWASJY1V7uj+ALDqor3kIjaJUjyLSxXDLPP7YQvkKukclxvQICya
	 Nlo8A3cBwM9Mmh0jbunXuDtsKWS9gsapJ5MxabzFLjeN4S8jrQvT4Mf4AMLGI1zziMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpZ+I12y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD9606A31E
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpZ+I12y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F311F031E0;
	Fri, 23 Oct 2026 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798321;
	bh=UrSgybGj3FSsK0vtkCR7+2GB7JEYjcDNJWMO0vka1Ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HpZ+I12yfMDGSavaOgIObc3Oyem5I9nbjFyrUKgIQp87x7mJyTOKH8EBRslJgUYID
	 eBo5oGuUWnUu4BnfNAkMjOmoAdOSmEYHQE/llGrLu2RP/NCsk1/ru109dOy9GTectu
	 pdiUhssqdGnQA5iWlsek0Jki7fggj+WW1JN0hNivYm291dEhhc+E+ampok8MKEEHl9
	 DSIFwUopAmBWF73DooYNCujOuqZkPOei3pHgP/tToLqYsd72RUbeiJd9b16TsrJ7Wq
	 TvNrBMjR+vmkcYCiymMtFgVeXgRkLMo0vYvB+7y0EcKErdzkKkJwu1H1unCk9f+0CC
	 WY7MEwc9BC+2A==
Message-ID: <sashiko-outbox-183374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/50] KVM: selftests: Test rejection of swap
 tmpfs mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alex Williamson" <alex@shazbot.org>, "Alexander
 Graf" <graf@amazon.de>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexey
 Kardashevskiy" <aik@amd.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Ashish Kalra" <ashish.kalra@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Baolu Lu" <baolu.lu@linux.intel.com>, "Bill
 Wendling" <morbo@google.com>, "Borislav Petkov" <bp@alien8.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Brauner" <brauner@kernel.org>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Fred Griffoul" <griffoul@gmail.com>, "Gregory
 Price" <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, "Hugh Dickins" <hughd@google.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jianxiong Gao" <jxgao@google.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John Starks" <John.Starks@microsoft.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Justin Stitt" <justinstitt@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Sean
 Christopherson" <seanjc@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261022-gmem-alternative-providers-v2-10-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-10-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:31:57 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing CAP_SYS_ADMIN check in create_tmpfs_pool=
_fd()
--

commit 81fb5dc552f2fa0364e094d89b7aaec3df677efb
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of swap tmpfs mounts

This commit adds a helper to mount a tmpfs instance as a resource pool fd a=
nd
tests that creating a guest_memfd backed by a swap-enabled tmpfs mount is
rejected with -EINVAL.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index d62ae23256083..205f822e10c6c 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -478,6 +480,73 @@ static void test_resource_fd_memfd(struct kvm_vm *vm)
>  	close(file_fd);
>  }
> =20
> +static int create_tmpfs_pool_fd(const char *huge, bool noswap, size_t si=
ze)
> +{
> +	char size_str[32];
> +	char template[] =3D "/tmp/gmem_test_dir_XXXXXX";
> +	char *mount_dir;
> +	int fs_fd, mnt_fd, dir_fd;
> +
> +	TEST_ASSERT(size && IS_ALIGNED(size, page_size),
> +		    "Pool size '0x%zx' must be positive and page-aligned", size);
> +
> +	fs_fd =3D syscall(__NR_fsopen, "tmpfs", FSOPEN_CLOEXEC);
> +	TEST_ASSERT(fs_fd >=3D 0, "fsopen failed");
> +
> +	if (noswap)
> +		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_FLAG,
> +				     "noswap", NULL, 0), "fsconfig noswap failed");

[Severity: Medium]
What happens in tools/testing/selftests/kvm/guest_memfd_test.c when
guest_memfd_test is run by an unprivileged user who has access to /dev/kvm
but lacks CAP_SYS_ADMIN?

Through the call chain:

  main()
    test_guest_memfd()
      test_resource_fd_tmpfs_swap()
        create_tmpfs_pool_fd("never", false, page_size)

syscall(__NR_fsopen, "tmpfs", FSOPEN_CLOEXEC) checks may_mount() in the
kernel and fails with -EPERM without CAP_SYS_ADMIN (and when noswap is true,
shmem_parse_one() for "noswap" also requires capable(CAP_SYS_ADMIN) and fai=
ls
with -EINVAL).

Because test_assert() in tools/testing/selftests/kvm/lib/assert.c only skips
on EACCES and exits with code 254 on EPERM, doesn't TEST_ASSERT(fs_fd >=3D =
0,
...) cause the entire test binary to fail and abort in test_guest_memfd()
before running __test_guest_memfd() and the non-tmpfs guest_memfd tests?

Also, a later patch in this series ("KVM: selftests: Test guest execution
with tmpfs-backed guest_memfd") checks:

  if (pool_fd < 0)
          TEST_REQUIRE(false);

after calling create_tmpfs_pool_fd(), which appears to be unreachable as lo=
ng
as create_tmpfs_pool_fd() aborts via TEST_ASSERT() instead of returning an
error or skipping when CAP_SYS_ADMIN is missing. Later in the series ("KVM:
selftests: Test guest_memfd conversions with tmpfs backing"),
guest_memfd_conversions_test will also hit the same failure when run without
CAP_SYS_ADMIN.

Should create_tmpfs_pool_fd() and its callers skip the tmpfs resource pool
tests when the process lacks CAP_SYS_ADMIN, similar to how test_mbind() and
test_numa_allocation() skip on EPERM?

[ ... ]

> @@ -539,6 +608,7 @@ static void test_guest_memfd(unsigned long vm_type)
>  	test_resource_fd_invalid(vm);
>  	test_resource_fd_unsupported_fs(vm);
>  	test_resource_fd_memfd(vm);
> +	test_resource_fd_tmpfs_swap(vm);
> =20
>  	__test_guest_memfd(vm, 0);
> =20

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D10
