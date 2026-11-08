Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098642;
	b=1S1xfwkrcDY6hA6sgoty+LSjDN7wsgwZ81AntEORV/7CvpX4bp4JICVu6WiX/pxXwhHa
	 fwMXq351nLsJ12+iKQcQdHDn0cuBY3gc61E9ErHa6xxDrtXjB1veyZzG5po1H8X+FSWhx
	 D8jALo2wvt7IzJhO2ysbPYiYWXwoTfB+y8/5J8ur21iO/rZUKiuI3k69hqHNyh0o4DUQw
	 EH1UhetjgZ0DdZb42tMSwO6TXsU5YDa8GApYFys/EZMenBi3eqGu+o3YXK1B60JXVFWSX
	 iRkJgqgnFd9g9bckp1vwdWjvixwzlk2ETZu8PgIuccFo8LE3gH0jCbocOlopAzDdaCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhhWGTSByI4qIQcbqu228xwAcrd5jwpz2egUaYGLH4A=;
	b=VVhnPTpFRp1GjL/j8nVH4LoH2mQsrs5RZKAbYWiq8qArc3ClT3S/6K4jLGMNrWDv5mGZ
	 2nKa6miuFXEXb6rjFZhMKsR6YDmbc7QhnC4M5WmMwzuA/S4lfSBk7+LqQsx0iaucnx9tx
	 1wFIWtc845K0CM6VzjNEfn6CUIG81fPXLbukHs4WIu5xXZgI1uOOffXUQuUZBbmufHtBK
	 Zk+diD1Ot5KfhxVlx3IbS3sZnCHMdja6ZITpeEemiPiTzJqhDijZBKpsfCoDr4bs9urRt
	 BJpuaJhBTJoYnbYMTgix+udlpZ3wpob1qOhycYHmtivvge6+1C3ggSPylbaTI5Zn6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ+Rfqnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D8606A338
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ+Rfqnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28831F008A3;
	Sun,  8 Nov 2026 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098641;
	bh=jhhWGTSByI4qIQcbqu228xwAcrd5jwpz2egUaYGLH4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJ+RfqncbREiSilmnF4x43JuulPX1sub/CJ14BUTCZU0eWiYufbfG1I3+g8oPRvoF
	 hgfYQev+RnnJFLa3EUbANJtkvSU0yrNc5oZatFRmTPStF5Gals3ssYcBj0zbjmWAg0
	 41JrYbe1o0nWATj/q2w/V8D0j7yKACcygSLje8r2rsmrV2++CL/7nOL25WToQRrMyj
	 NeIPXME4vcI91cPjTvl1iD5ijRurQFbQW8FxBXLRwQzjiitjjnRQBeEVsvM22BSRRT
	 zZxw6yQSloJ2pNOPNCStzYJilECTG2SW/hw83iKw+av63PLfED2Tb3go+kVzcKBlmT
	 Gs8WWZkNb2Cgg==
Message-ID: <sashiko-outbox-203430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 19/88] KVM: selftests: Test guest_memfd
 conversions with tmpfs backing
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-19-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-19-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: selftests: gmem_fd leak in gmem_conversions_do_setup()
--

commit 4496ec39f3ba447f6a2dfb084849079edae5c81f
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest_memfd conversions with tmpfs backing

This commit moves create_tmpfs_pool_fd() into test_util.c and extends
guest_memfd_conversions_test with fixture variants to test both native
and tmpfs-backed guest_memfd instances.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index e1c84df0f0596..023df9cb9d4a6 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
[ ... ]
> @@ -50,12 +69,27 @@ static void gmem_conversions_do_setup(test_data_t *t,=
 int nr_pages,
>  	 */
>  	const gpa_t gpa =3D SZ_4G;
>  	const u32 slot =3D 1;
> +	size_t size =3D nr_pages * page_size;
>  	struct kvm_vm *vm;
> +	int gmem_fd =3D -1;
> =20
>  	vm =3D __vm_create_shape_with_one_vcpu(shape, &t->vcpu, nr_pages, guest=
_do_rmw);
> =20
> +	t->resource_fd =3D -1;
> +
> +	if (variant->create_resource) {
> +		uint64_t flags =3D gmem_flags | GUEST_MEMFD_FLAG_USE_RESOURCE;
> +
> +		t->resource_fd =3D variant->create_resource(size);
> +		TEST_ASSERT(t->resource_fd >=3D 0, "Failed to create backing resource"=
);
> +
> +		gmem_fd =3D __vm_create_guest_memfd_resource(vm, size, flags,
> +							   t->resource_fd);
> +		TEST_ASSERT(gmem_fd >=3D 0, "Failed to create guest_memfd with resourc=
e");
> +	}
> +
>  	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, nr_pages,
> -		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +		   KVM_MEM_GUEST_MEMFD, gmem_fd, 0, gmem_flags);
> =20
>  	t->gmem_fd =3D kvm_slot_to_fd(vm, slot);
>  	t->mem =3D addr_gpa2hva(vm, gpa);

[Severity: Low]
Does gmem_conversions_do_setup() leak the local gmem_fd when
variant->create_resource is set?

When a caller passes a non-negative gmem_fd to vm_mem_add(), vm_mem_add()
duplicates it via kvm_dup() for the memslot region and leaves ownership
of the passed-in descriptor with the caller.  Because gmem_fd is never
closed here, the guest_memfd file, its tmpfs mount and folios, and the VM
instance remain pinned across kvm_vm_free() in
gmem_conversions_do_teardown(), including across each loop iteration in
GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D19
