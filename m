Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798328;
	b=3IFgSUp7Iy3rOC8ew5q/EkvrsQ0u37Bt47hhUxOdnQ7l+fGoqSWCAlqsyp3e0V0gijMT
	 dnm3cvDbaP58lcxU97TZzH+GF5jHx0m9a9f0BvpqjFoJnb+XQh3s9iF3aTJXluL3bHWrr
	 XI54CGx/fEdWe9+UlAVCdeQd/ltrubuRJK6EpMS7Y3tNQqdTvVkcFasKNlu2D6ejotp7i
	 ZnLkOdWNcr1a8COzzznvtAEnrn7bbYXPduUyzXvLXlgCIUxx2P3j0fP8USCP1iFHmYmNA
	 EdefmiZX/Z/5cYTmRDmv9Klk5nNCCHGzB9nrjRvbPplFvBL+85hSsrDZowq6kbhEZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798328;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ruHanbLvoE1VJkWUikficvKLFnq3SIPwAWmLJ71jezY=;
	b=avpRN8A4VO/XH0hvUdi1i20nrjxCF3IVvemWT2ZuezWIexXssMqvW4nCYQEbUR9Z83bf
	 JmshuvMwsumh9no0xrjPHpFgEUil27wAYrbBLsY6OHitfu/KqRnq9u4z+FXaUiZBCh7jY
	 T/8DrTg3iAMEMy2I83q1+Mown0eFn6aYGPF4hXAUEjfZOEUz8zgFjEMIMRYbSyPI/SFJZ
	 hXZuRutsHUdb4CPFfCY9PJdFFF5MUdXxAnj3lvfWtFpT46HsyvuvBE/I32DgHbwvHdY99
	 xxAuq2Stp7bRKIaHf4zvsldga49mXTwTLE2Gac0js9wTWLh5HgCIa9y1t1fuCCFuoPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFcJmQnD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F619606A31B
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFcJmQnD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF7A1F01825;
	Fri, 23 Oct 2026 23:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798328;
	bh=ruHanbLvoE1VJkWUikficvKLFnq3SIPwAWmLJ71jezY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFcJmQnDL3astvp/bhPoGy4f9Ecsu73Rkzy5dDEawW6HcUyX5noK0Kyq0OKv0DYno
	 zFIAHqgogExV+AzopY+PkBwONlYBt7YRWSr6Gg2+cSFFN7oEvhcUGg8GAoL2wgQKu/
	 IzbGaxqKjqAPzkeoseGw0IvFZvIUI1bqbjt8YWMDwbfm/TyJg3f4jHqyckGvhOLOir
	 Neu+CGOBFUttA3LzRl3pIJT7plAEj3H/vaEV1zNbFCK+xEWx7IrrHYkJQ1bx1GW6WT
	 h+EFHWOIprhK28mGZo+lprE0EQzvpcil451fMsluTBeK14uvXwFl5uMjYSocArpLco
	 fDXolBT2NQLyA==
Message-ID: <sashiko-outbox-183381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 17/50] KVM: selftests: Test guest execution with
 tmpfs-backed guest_memfd
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
In-Reply-To: <20261022-gmem-alternative-providers-v2-17-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-17-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:32:05 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: selftests: undersized tmpfs pool in test_guest_memfd_guest_=
resource()
- [Low] KVM: selftests: dead pool_fd check and duplication in test_guest_me=
mfd_guest_resource()
--

commit a03f3023933c2e4a7447fa35e4f2470380c225bd
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest execution with tmpfs-backed guest_memfd

This patch adds a selftest in guest_memfd_test.c to verify that a guest
vCPU can execute instructions and read/write memory backed by a
tmpfs-backed guest_memfd resource pool.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 20de24ad535f1..8e9261db23354 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -799,6 +799,61 @@ static void test_guest_memfd_guest(void)
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

[Severity: Low]
In test_guest_memfd_guest_resource() in
tools/testing/selftests/kvm/guest_memfd_test.c, can pool_fd < 0 ever be
true here?

Looking at create_tmpfs_pool_fd(), every failure path already asserts via
TEST_ASSERT() before returning dir_fd:

	dir_fd =3D open(mount_dir, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
	TEST_ASSERT(dir_fd >=3D 0, "open tmpfs mount directory failed");
	...
	return dir_fd;

Also, since test_guest_memfd_guest_resource() duplicates the VM setup,
memslot configuration, guest execution, and memory verification of
test_guest_memfd_guest(), could test_guest_memfd_guest() be parameterized
(and use vm_create_guest_memfd_resource()) instead of duplicating the test
function?

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
> +	fd =3D __vm_create_guest_memfd_resource(vm, size,
> +					      GUEST_MEMFD_FLAG_MMAP |
> +					      GUEST_MEMFD_FLAG_INIT_SHARED |
> +					      GUEST_MEMFD_FLAG_USE_RESOURCE,
> +					      pool_fd);
> +	TEST_ASSERT(fd >=3D 0, "guest_memfd with tmpfs pool should succeed");
> +
> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NU=
LL, fd, 0);
> +
> +	mem =3D kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +	memset(mem, 0xaa, size);

[Severity: Medium]
In test_guest_memfd_guest_resource() in
tools/testing/selftests/kvm/guest_memfd_test.c, what happens when
vm->page_size is larger than the host page_size?

pool_fd is created earlier via create_tmpfs_pool_fd("never", true,
page_size), which limits the backing tmpfs mount capacity to a single host
page. When vm->page_size > page_size, size is computed as
max_t(size_t, vm->page_size, page_size) and exceeds the pool capacity.

When memset(mem, 0xaa, size) faults in pages beyond the first host page,
shmem_gmem_alloc_folio() will fail with -ENOSPC and
kvm_gmem_fault_user_mapping() will raise SIGBUS.

Should pool_fd be created after size is computed, passing size instead of
page_size to create_tmpfs_pool_fd()?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D17
