Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098681;
	b=NkkA6Bh5biz8+kbS5/Stlbm4G1tYn1QDjlv0IPArdS0Jhu3f/cLrRpkGE0MX112+p4Ku
	 El84frZDBFSjtv5mLxvSZ2FFWwND02fnvfcI94r1aEtJbtkpTTY38rZL5PyaUeaCRok8T
	 qpJ+/J07avNxLCJIkY2xfRkpMd1LoUvKzpy+WAghq0ROoHs75Q4A9wyN4kRlyKg/fT06V
	 hvtT5zizQZfQuMokeiT3fX8BPwnf8bfXX27yF7CU2pEVtvv5J5o6YMi6dn8kWEnbgRB38
	 QjAzmlukpBzBmeQ2mtxx4AfNEHshaNkuIdA9GqOoiWVDLs1aSaIwAD+2ZE6z1NAntCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8axrRMWyXoE+R/wxLxsNGire3Rwu8iDfjj2ot/P1Blw=;
	b=gRrVT636pbNZmS/8DYlKmkMomhwVEgqDYnwXgdYl4xjVDjU31fVc8kY93wclBLDhCVZQ
	 KFc9G294JFZhzxmfiV1IoGFA3bf0JO6mw5ZKRmm6PkWJXi71DVa3gF5sykDk8MpGV7bUh
	 +XYrEjp/9VvlhBQbXPHOha5v2Iv4ke+jeCCV0s/jmDe8ttl3vktTZSM4y1jgYM5/d3Aeg
	 uREL/LsX4guWuWYS53tW8TMRAl5n8OqBkuyn34E3C7ax5SHj79rgnLQdmE3kTusw5ESkz
	 C9pEDLvgXzVGEWpX5mdtrS0w0B5Bov3gnP924Mo1tsd4mqtVb52PHAS3HzD/WPSHhcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfAn9IKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117A606D811
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfAn9IKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514041F0089F;
	Sun,  8 Nov 2026 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098681;
	bh=8axrRMWyXoE+R/wxLxsNGire3Rwu8iDfjj2ot/P1Blw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfAn9IKr/dpG2JRZc//F4uTFnvXNh9b3+KCrQHlSIlxOea1iJgw4qrX0uGLnWZShn
	 5jNK7cpb6yYZE2Hy7M4jgpQnPaxBwpn7qYLii6mgF6Pux8DiBlbrw8VGsnS+bF7Bsu
	 5zRGAVDcHzDR4coG+prJirDO581MJnj/2nqUHStSeE35vOMO9X3NISsiwKvAX0AX6+
	 pGVcF/ykdOlpmsBxUSEZeqqdjbuZzcaOmQlYFEGf1gcGggACrzrS6QxrebM3EIW/ym
	 V1jco5E9SozLT1Zr28FkKHzLeuxG8/j52iFdakIpfLTEGPd7rl+RuP1gcjqAScXuYB
	 4zqLDj2jOUyMQ==
Message-ID: <sashiko-outbox-203492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 81/88] KVM: selftests: Verify guest mapping for
 VFIO BAR
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-81-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-81-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:39 +0000
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
- [Low] KVM: selftests: guest_mapping() checks stage-1 PTE via
  vm_get_pte()
--

commit 8a5370d54b044c85eadf5eb14da654ead8af47a1
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Verify guest mapping for VFIO BAR

This commit adds a selftest that configures a VFIO BAR into a KVM memslot
and runs a guest vCPU to verify guest access to the BAR.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/to=
ols/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> index 79a0001ca1733..0339794fb6dd3 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c

[ ... ]

> @@ -594,4 +595,60 @@ TEST_F(guest_memfd_vfio, host_vma_flags)
>  	ASSERT_EQ(0, munmap(bar0_mmap, bar0_info.size));
>  }
> =20
> +static void guest_memslot_cacheability_code(uint64_t bar_gpa)
> +{
> +	uint32_t *reg =3D (uint32_t *)(bar_gpa + E1000_STATUS);
> +	uint32_t val;
> +
> +	val =3D READ_ONCE(*reg);
> +	GUEST_ASSERT(val !=3D 0xFFFFFFFF);
> +
> +	GUEST_DONE();
> +}
> +
> +TEST_F(guest_memfd_vfio, guest_mapping)
> +{
> +	struct vfio_region_info bar0_info =3D {};
> +	uint64_t bar_gpa =3D 0xc0000000;
> +	struct kvm_vcpu *vcpu;
> +	void *bar0_mmap;
> +	uint64_t *pte;
> +	int ret;
> +
> +	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
> +
> +	bar0_info.argsz =3D sizeof(bar0_info);
> +	bar0_info.index =3D VFIO_PCI_BAR0_REGION_INDEX;
> +	ret =3D ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
> +	ASSERT_EQ(0, ret);
> +	ASSERT_TRUE(bar0_info.flags & VFIO_REGION_INFO_FLAG_MMAP);
> +
> +	/* mmap the VFIO BAR directly into host userspace for memslot config */
> +	bar0_mmap =3D mmap(NULL, bar0_info.size, PROT_READ | PROT_WRITE,
> +			 MAP_SHARED, self->bar_fd, bar0_info.offset);
> +	ASSERT_NE(MAP_FAILED, bar0_mmap);
> +
> +	vcpu =3D vm_vcpu_add(self->vm, 0, guest_memslot_cacheability_code);
> +	if (variant->use_gmem)
> +		vm_set_user_memory_region2(self->vm, 1, KVM_MEM_GUEST_MEMFD,
> +					   bar_gpa, bar0_info.size, bar0_mmap,
> +					   self->gmem_fd, bar0_info.offset);
> +	else
> +		vm_set_user_memory_region(self->vm, 1, 0, bar_gpa,
> +					  bar0_info.size, bar0_mmap);
> +
> +	virt_map(self->vm, bar_gpa, bar_gpa, bar0_info.size >> self->vm->page_s=
hift);
> +
> +	/* Run guest to fault in the page via stage 2, then verify S2 PTE */
> +	vcpu_args_set(vcpu, 1, bar_gpa);
> +	vcpu_run(vcpu);
> +	ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, NULL));
> +
> +	pte =3D vm_get_pte(self->vm, bar_gpa);
> +	ASSERT_NE(NULL, pte);
> +	ASSERT_TRUE(is_present_pte(&self->vm->mmu, pte));

[Severity: Low]
Does vm_get_pte() check the guest stage-1 PTE rather than the stage-2 PTE?

vm_get_pte() walks self->vm->mmu (the guest GVA-to-GPA page tables in
guest memory), where virt_map() -> __virt_pg_map() already set
PTE_PRESENT_MASK(&self->vm->mmu) before vcpu_run(), so is_present_pte()
always succeeds without inspecting KVM's stage-2 page tables.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D81
