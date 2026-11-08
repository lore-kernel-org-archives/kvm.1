Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098641;
	b=JzzADBn9XSRUnUCWHOGiah4ypqmEERarLwiF1rScmsRFkeGwy7uvmPT5GbTA99q6fFkU
	 yHt2IlsBn0Bhn4ttwDlGb6FLhRYOppvJvFR5l2XuXsU7jeZWPEbjkkBNy4eH9OdaJq84i
	 oZhgu5fXOMEAhxZJEmjS89LU2gKvHcOsJ/LdAuB0NwiB9tlk8gJPTkuPUKZUagYQlCOdC
	 tRzzBXN37O7b6lejc7tqk5glXh/XVZtnGXOsExkWNsCs1zGP/z+U1jYgRG8w44njsUuRD
	 1OtAC3gWUh0fZM7n6L9w3cXqWh1SeozfLWTlNEoL8ha7HgbnXmfI4xHRbysXs7ja63g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a6BGbZLN6euKJPfD3bQQFNk/1c8I/Z2rG+D3HSQmTxU=;
	b=xhwpAFcmJW07pp/fK8HIZg+WX/j6rY6LgVNPkZo1c9IytjMRr9kJkENb4Cnck9rfXA9N
	 UcObeBQUb0vOwZpU1NMO81KZC/UQuHxHN/fLX33da5XoWJYW41gk8YC6Moc8EkTrx+t3X
	 VkUpwkFLgAd/23a7UsfSGdmzf5UgdjXLVZ+09E9cXtqQHWe4eW7PlFyb5h4HbmuQVFXFn
	 HDyPNoDc0Qqsg/oEM9at3aqqpPc9+hxYnlTr40Lks+SNsnwj87m5EpchVsJ0AF4Y86odR
	 ImZYYUKz0mtKno1xKXHy36C8GjURj1AYuQoz1R5SUXySByXFwlNPQL3cOEwjXDsavfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMAvyE5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7C606A339
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMAvyE5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C081F008A1;
	Sun,  8 Nov 2026 00:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098640;
	bh=a6BGbZLN6euKJPfD3bQQFNk/1c8I/Z2rG+D3HSQmTxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMAvyE5i3dBfW55Iv+1bJCA/0jvRbUtPWSB6MAmCNyhZPFX+Hc7ax1Sr/Oj9Jh3ES
	 zFBEPt68J5vWk1i6qFflL5Ya8T4K+rhB6dKJvRnaoVBaFugtXBv5V200y3MnuKv2A6
	 DGCKdwOFtb/td41GXaglaEAuxdW6x1HUwr+/8wpEPnOwbN0wXSw2zvrR68QkuYgnNK
	 npMFMvycYnNQdIyy7P61pN7QyQae6cdPupLVoqCLn2awbSQG57LBy732RmT3FkmsaG
	 9EtoTB+qwzf0zOCtzoUTxy4ntsTrJT6Ih6sZs5k0JEU9hCGWZ2J5APcbAftXr3GliJ
	 JXOX1NqVnWbNQ==
Message-ID: <sashiko-outbox-203428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 17/88] KVM: selftests: Test guest execution with
 tmpfs-backed guest_memfd
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-17-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-17-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:59 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: selftests: undersized tmpfs pool in
  test_guest_memfd_guest_resource()
- [Low] KVM: selftests: dead check and duplication in
  test_guest_memfd_guest_resource()
--

commit 5b99efdf7e83feb9f2f28a33ce29eb94813f4546
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest execution with tmpfs-backed guest_memfd

This commit adds a selftest verifying that a guest vCPU can execute and
access memory mapped through a guest_memfd backed by a tmpfs resource pool.

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

[Severity: Low]
This isn't a bug, but test_guest_memfd_guest_resource() duplicates almost t=
he
entire body of test_guest_memfd_guest() rather than parameterizing the
existing helper.  In addition, create_tmpfs_pool_fd() asserts via
TEST_ASSERT() on every error path and never returns a negative value, making
the pool_fd < 0 check unreachable, and the __vm_create_guest_memfd_resource=
()
plus TEST_ASSERT(fd >=3D 0, ...) call open-codes the existing
vm_create_guest_memfd_resource() wrapper.

> +
> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NU=
LL, fd, 0);
> +
> +	mem =3D kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +	memset(mem, 0xaa, size);

[Severity: Medium]
Will this memset() crash with SIGBUS when vm->page_size is larger than the
host page_size (for example, on LoongArch where VM_MODE_DEFAULT uses 16K
guest pages on a 4K-page host)?

create_tmpfs_pool_fd() limits the backing tmpfs mount to page_size bytes
before the VM is created, whereas the guest_memfd is sized and faulted in
across size =3D max_t(size_t, vm->page_size, page_size) bytes.  When
vm->page_size > page_size, faulting past the first host page hits -ENOSPC in
shmem_gmem_alloc_folio(), which kvm_gmem_fault_user_mapping() turns into
VM_FAULT_SIGBUS.  Creating pool_fd after computing size (and passing size as
the capacity) avoids exhausting the pool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D17
