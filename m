Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000537;
	b=4Bmu6lJzvDQUgA0FQ8orRG9vbuwnXtGuETPMeVmg1/dcYXK00NJ25lBAhCmAaKM3pC2t
	 2c3PulWzPSUaQxxAeoqk1hMMPi+gqw3ScQVjNu1PwFdSXavFF1cHeUbvR2KHxEUF+HbiR
	 h6vqZyQs3sHyw6Q78KqsjAXAHD6ZKE/Xko2aVxErE9NgsMDIgeEcHrvcBXW5qEjuXstHb
	 4728G12LUZCdXM6C5XBDLPgGHS+yNU7PbJlwupv8t2GNCqr1dUTG7IwO8Qf2pXR+rXrMW
	 HX8nAi9IptQdKShRAdTXhGiJaEPPVug1Dq/52Tc/s9fdTeBRHTTdOYb64wHfWVlmyKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QK09cvCCv1U2VbXXs4aXYBwdDy0Jn6Y8NtPS8Cb2LSk=;
	b=AovLTzQf9ZlKzDhEjJizb+f1mojlBXq0TP+B+ekk8aOc6Xe4Bl6fLFaTf95PB5FmPzCg
	 auALs0mfaqYlkbP91bi+GnKLdXjVmNIRTn9RBLxHkne5fWBFb2LUzQYYhnaZptlehmxn2
	 4QoGPZVQ9oV3c4C1Vshejj8rvr6NPJI0/na/vO1NS6LOXekE06hUfO7Gfhb4+8gmSnqHr
	 DAtStmN0vf0yzY2tfHW2aBkQ2H5bbbhw804CvnsPotogNUKKItmEJ8/8YSo5F3s4TfSlW
	 82XkHRDv71F00KnyETw1I6Xfux9kyLqLO5ZPwHBzZRdnsvuFGi5iNk861rMJRpAbSvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zz1SyuAS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E103606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zz1SyuAS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420F1F01825;
	Mon, 26 Oct 2026 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000537;
	bh=QK09cvCCv1U2VbXXs4aXYBwdDy0Jn6Y8NtPS8Cb2LSk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Zz1SyuASBC+eJsHXA5Wv5i8DneYUcveOWukvOTNfkeEwlSUTilmpcFF3r3LDzaOPt
	 81pt2O99nRR7S6JTKWaegQ3MDZ8lavjuYsFhUaPmrdvarAnxHKfVmXmB+qdBh0ZbGm
	 1XRtqzZ4Juqw+1U2e+YX4AGjwgAjxS531nQbk58y/mN6onG/pEXrCYi+YVrKQbcJeB
	 3cnBDSyxZ/cRqrWj1fGAEAZUqquXcI+xcuhD7i1yICCPUcYkZC/NPTUXpiBkVw09ED
	 Y/rZYFZPDHApe/UwD6LJjjRwZSuLESMCnjGN5GqBACkycvaptg9n/KLZ8pT62Ez8HX
	 RtjtVBmmlwrnw==
Message-ID: <sashiko-outbox-184664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/5] KVM: selftests: Add tests for
 KVM_LINK_GUEST_MEMFD ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Gong" <gongtao@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261026064424.3003536-5-gongtao@google.com>
References: <20261026064424.3003536-1-gongtao@google.com>
 <20261026064424.3003536-5-gongtao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:42:16 +0000
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
- [Medium] KVM: selftests: test_link() hits vm->type assert in ____vm_creat=
e() on arm64
--

commit c8e0fca46d65aef6ffa609495f3f615b1c614301
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add tests for KVM_LINK_GUEST_MEMFD ioctl

This commit adds kselftest helpers and test cases in guest_memfd_test.c for
the KVM_LINK_GUEST_MEMFD ioctl, covering invalid inputs and valid linking
between VMs.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 2233d871a38f4..ccde4d735c77c 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -418,6 +418,68 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
>  	}
>  }
> =20
> +static void test_link(struct kvm_vm *vm, int src_fd, size_t total_size)
> +{
> +	struct kvm_link_guest_memfd params =3D {};
> +	struct stat src_stat, dst_stat;
> +	struct kvm_vm *dst_vm;
> +	int dst_fd, bad_fd;
> +	int ret;
> +
> +	/* guest_memfd can only be linked between VMs of the same type. */
> +	dst_vm =3D vm_create_barebones_type(vm->type);

[Severity: Medium]
Will passing vm->type to vm_create_barebones_type() here trigger an
assertion failure in ____vm_create() on arm64 when vm->pa_bits !=3D 40?

On arm64, main() invokes test_guest_memfd(VM_TYPE_DEFAULT) with vm_type =3D=
 0,
and the initial vm_create_barebones_type(vm_type) call in test_guest_memfd()
reaches tools/testing/selftests/kvm/lib/kvm_util.c:____vm_create():

#ifdef __aarch64__
	TEST_ASSERT(!vm->type, "ARM doesn't support test-provided types");
	if (vm->pa_bits !=3D 40)
		vm->type =3D KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
#endif

When the selected default guest mode has a physical address width other than
40 bits (for example on hosts where guest_modes_append_default() selects a
48-bit or 52-bit IPA mode), ____vm_create() overwrites vm->type in place
with a non-zero KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits) value.

When __test_guest_memfd() then calls test_link(), passing that mutated
vm->type into vm_create_barebones_type(vm->type) forwards a non-zero
shape.type into ____vm_create(), tripping TEST_ASSERT(!vm->type, ...).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026064424.3003=
536-1-gongtao@google.com?part=3D4
