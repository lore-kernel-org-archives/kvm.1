Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63B2EC0A4
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680171; cv=none; b=DYUznzxzGwGaO1bZQ+gBZXc6riEnvUy10mrilxHRsefebzwr4cGWwa1YzdM0jmUaXbEEQUJ7B1Iy/KXL5Ao9Gx2sH4uuOTNo+5qqXBZYAp21qZYmeQYQNqg4Zji8/8ceamTahgKvAEYooRNkkPY5N0CG0wg/BEoNRrizxHh4Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680171; c=relaxed/simple;
	bh=VTCEU+laGzC0F1d/TXDS6pvZUie8QhHfXsGMvQ7H9g4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFQI9D1shpjdSYNs+KMW2uYKlNvcgW4exD1bcYf737AFExLjWTXhEkuLxiEnhB/YuhPb3OFDW9CT7OaLRTzxPLdP3cyZ0XB7/5wmF+IA7O9rt83ApZq6H/wETSrlw7FTXKmcp1ljtJoxU6Orl2qdpwtSrZcbqh5esEhYekfjWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4tT2m7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4tT2m7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A691F00893;
	Fri,  5 Jun 2026 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680169;
	bh=3pkkME1/BbMX2vbl3hISxwu8NXmMk+mruUU38mZqc9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4tT2m7bfoCm8drhAfm7Ivid+L7oAa7froIxxiqOcYctl6lJYYqgm32IsvfmIMtNB
	 BjJz9SyUR3O0Gg4zEEjt63oMePPDzZ5paDbX7XE3NcihPVQ9GOGPlth1LbVuOusva+
	 HStBCMSmVAm9t0JlCECVme0g135m51ipSqHQk9nusBh8KJLgNNh0sjoMZaxRf/p1D/
	 1uzM3Qwt6CJmsWWli99iXJC1x1IJsfr7NpvVXZSxUlECzlEU9gUN9SAYNc3qJEPp6x
	 9V+ojOiq4srU3s2lfAyUYoyHeUI634akCY0WsyFkiQH52rNIGfhD8Tz1gONjnHZtWQ
	 lQ/Eii5nvZbJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/10] selftests: kvm: Add
 guest_memfd_preservation_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
References: <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:22:49 +0000
Message-Id: <20260605172249.B9A691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Phase 2 blindly recreates a vCPU on the preserved VM, failing wi=
th -EEXIST.
- [Medium] Phase 2 attempts to recreate preserved memslots without explicit=
 deletion, causing KVM_SET_USER_MEMORY_REGION ioctls to fail with -EINVAL.
--

commit fe4115b3a7bf4dcb06bece577462cff5bac12723
Author: Tarun Sahu <tarunsahu@google.com>

selftests: kvm: Add guest_memfd_preservation_test

Add a new KVM selftest guest_memfd_preservation_test to verify that
guest memory backed by guest_memfd is preserved properly. The test leverages
the Live Update Orchestrator (LUO) infrastructure to save and restore memory
folios and configuration layouts during live updates.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_preservation_test.c =
b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
> new file mode 100644
> index 0000000000000..74f90c5c4bf5b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c

[ ... ]

> +static void do_phase1(void)
> +{

[ ... ]

> +	session_fd =3D luo_create_session(dev_luo_fd, SESSION_NAME);
> +	TEST_ASSERT(session_fd >=3D 0, "Failed to create LUO session");
> +
> +	ret =3D luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to preserve VM file descriptor");

[Severity: Medium]
Since this test creates a VM with vCPU 0 and preserves the VM file descript=
or,
but doesn't preserve the vCPU file descriptor, will vCPU 0 still be retained
in KVM's state for phase 2 without a way to access it?

> +
> +	ret =3D luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to preserve guest_memfd file descript=
or");

[ ... ]

> +static void do_phase2(void)
> +{

[ ... ]

> +	vm =3D vm_create_from_fd(retrieved_vm_fd, shape);
> +
> +	u64 nr_pages =3D 2048; /* 8MB is plenty for slot0 pages */
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0=
);

[Severity: Medium]
Does this code attempt to overwrite existing memslot 0 with a new userspace
address without deleting it first?

Since the VM's internal memslots are retained in KVM kernel state when
preserved, redefining slot 0 with a new userspace_addr violates KVM's memsl=
ot
mutability rules and will likely cause KVM_SET_USER_MEMORY_REGION to fail w=
ith
-EINVAL.

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

[Severity: Medium]
Will this also trigger an -EINVAL error from KVM?

Similar to slot 0, redefining the guest_memfd memslot (slot 1) without expl=
icit
deletion first also violates KVM's memslot mutability rules.

> +
> +	for (size_t i =3D 0; i < GMEM_SIZE; i +=3D page_size)
> +		virt_pg_map(vm, gpa + i, gpa + i);
> +
> +	vcpu =3D vm_vcpu_add(vm, 0, guest_code_phase2);

[Severity: Medium]
Will this blindly recreate a vCPU on the preserved VM, resulting in an
immediate -EEXIST failure?

Because the entire VM state was preserved in phase 1, vCPU 0 already exists=
 in
KVM's state. Calling vm_vcpu_add() for vCPU 0 again causes KVM to reject the
duplicate KVM_CREATE_VCPU request.

> +	kvm_arch_vm_finalize_vcpus(vm);
> +
> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D10
