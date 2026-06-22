Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C310348C5C
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155608; cv=none; b=QVORNDkBhdt6FfKNePtz/VJ66S52o8Av8zQmy1CQ+6ewBXQeUwtV+EW5/cHsSw4JzRAAtvYKxoMvAgurlLJajp+fpr3M9m9SD6dgabNQw/u+AQwRNYvsZTkVCpw9I0A5zeF3l+H4XHCMDHsMPj81jZsYkxCY4f13+Eg210UDReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155608; c=relaxed/simple;
	bh=m1nKuLiZIGjAiLBMQC9OYQgPC+QpzXNL8zouMgxLVjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SAEgz4sktL+IFQUn5NEcxe5Wo7vpcV9zCmctwhkXOsh74FqMgYvN2dOapy2BDRAm4sGnLOMOvEzswSabSmCZDPZJBoeVzHbjfD5ZI3DdtZGL6pbNg+abKIH1GOPJNX3bJZF2tn93VWpM6rYBjuDdvsDtVzul1+uyc9Cwn5YPhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTKXVWsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTKXVWsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B591F000E9;
	Mon, 22 Jun 2026 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155607;
	bh=pzIM9EtgGJgEzZOSz4KZKY1fknG9SXcu7sOxkG00XVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTKXVWsNNFMLsMRifOnrptfZOmtUetPaOwYqs5mxqw6qpaUQxjii1fCrhmquygY47
	 7TXl2RTRXvZE/sZrcleMhJhcGKVvpGQ2GNvvC9Mg2wIf3mdtZfMveRhrBAd2s/rG+z
	 N3gWRyp0ulNbaER8i6DRddDDkrHnEpIXJV4Apma9grg/z5URCLRamzhW/2yl4iUlA5
	 Up5IiDu1NZCf/bLOV6kluvbVVjcq/nC/YRx/Y+H+KwVke60S6W0/59COeWn2xigmY3
	 uacQZ+jfpoELmeAwiZHafo5G8fT42n19MMC4yoVoFNFZxvXHW/xnnDH3cyFrkUUuvA
	 XHWF5N+5u1ZEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] selftests: kvm: Add
 guest_memfd_preservation_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-10-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-10-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:13:26 +0000
Message-Id: <20260622191327.22B591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Stage 2 test failure due to re-creation of preserved KVM resources=
 (memslots and vCPU)
--

commit 323482e513bb6a4836ceedaaec02c412bc10f974
Author: Tarun Sahu <tarunsahu@google.com>

selftests: kvm: Add guest_memfd_preservation_test

This commit adds a new KVM selftest to verify that guest memory backed
by guest_memfd is preserved properly across kexec via LUO. It introduces
a two-stage test to save state before kexec and verify it afterwards.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_preservation_test.c =
b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
> new file mode 100644
> index 0000000000000..c0a20e788ba79
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c

[ ... ]

> +static void run_stage_2(int luo_fd, int state_session_fd)
> +{
> +	int retrieved_vm_fd, retrieved_gmem_fd, session_fd, stage;
> +	struct vm_shape shape =3D VM_SHAPE_DEFAULT;
> +	const uint64_t gpa =3D SZ_4G;
> +	struct kvm_vcpu *vcpu;
> +	const int slot =3D 1;
> +	struct kvm_vm *vm;

[ ... ]

> +	retrieved_gmem_fd =3D luo_session_retrieve_fd(session_fd, GMEM_TOKEN);
> +	TEST_ASSERT(retrieved_gmem_fd >=3D 0, "Failed to retrieve guest_memfd f=
ile descriptor");
> +
> +	vm =3D vm_create_from_fd(retrieved_vm_fd, shape);
> +
> +	u64 nr_pages =3D 2048; /* 8MB is plenty for slot0 pages */
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0=
);

[Severity: High]
Does this ioctl fail with -EINVAL because slot 0 already exists in the
preserved KVM VM with a different size? The preserved VM from stage 1 retai=
ns
its kernel-side state, which we attempt to blindly re-create here without
respecting the preserved state.

> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	for (int i =3D 0; i < NR_MEM_REGIONS; i++)
> +		vm->memslots[i] =3D 0;
> +
> +	struct userspace_mem_region *slot0 =3D memslot2region(vm, 0);
> +
> +	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_siz=
e);
> +
> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZ=
E, NULL,
> +				   retrieved_gmem_fd, 0);

[Severity: High]
Could this fail with -EINVAL because modifying an existing private
KVM_MEM_GUEST_MEMFD memslot is explicitly forbidden by KVM?

> +
> +	for (size_t i =3D 0; i < GMEM_SIZE; i +=3D page_size)
> +		virt_pg_map(vm, gpa + i, gpa + i);
> +
> +	vcpu =3D vm_vcpu_add(vm, 0, guest_code_phase2);

[Severity: High]
Will this call fail with -EEXIST since vCPU ID 0 was already created
in Stage 1 and remains preserved within the retrieved KVM VM?

> +	kvm_arch_vm_finalize_vcpus(vm);
> +
> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D9
