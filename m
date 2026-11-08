Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098654;
	b=pTmIcgzubDIxQU/0ay+6lavKdR1O0A6BK939mvMh9GJfNuVn3xJVhY+3+GF06iG1W5IZ
	 Dbz0BM/dXbjDOvSofI3+XOps8XR1nHfD6Y+rH09j+78NeEvltjXrs3DvEfV0d0m8Y98KL
	 5mupZFIFNI2Un0bx2Be6sbZEuQTQALH7DXFPQS92uEvdA2x12aeaoO2mK8Rn1srDyDZ9N
	 raGuLAeJvM6JNO482AYNmVQ0dUwNuJjWxikZYuzIaVXCEuKBn4WreFH96cIefd9KzyRYp
	 eKG6fMh5Y0SHN+C/MGsHxFwfbph+R5nKi1ufqcJ0011wKy1i/+ZDtLgcOAapA1+x35A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098654;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3JfgPEX+gibV6cuYOvTDNUqQKlrInM+Bzq+kAGu3/K4=;
	b=zr5mycHgJ3o5xmBpPLavbON7LUfQ4dM9THClHS/zoIUTBoFYXj9XeHjbS5REswYLfCUm
	 ht9HEvSGZ7N71oMU1pVR4gkYL2OX43vCDBFdQ9mesJ+zj3+rDNVrlD5Y2MmhcEsveStir
	 rxdvNKgMY2AerZZB3tPCs4guvBqZLe91kjEyQicGTc4PfsEjxQyTeqO7F4LwxVTWPuqzG
	 0xSDOJ7LmLrfb7SQS/kDop1cKfIAgrDSQymt837KZFp22ZUuQMbJnU7kmnzYg38DYb1ip
	 IN/bwHx4wFz24CcBeKnublebf8PDhicAMtdPG3Z7OWBO9LEbLbcZ0Yht/m4LR5yVkCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFI+icke;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DB606A33C
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFI+icke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EC71F008A2;
	Sun,  8 Nov 2026 00:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098654;
	bh=3JfgPEX+gibV6cuYOvTDNUqQKlrInM+Bzq+kAGu3/K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFI+ickeMfbpjvlltARUblyw8Qp0gDO89iEfsq5irogDTnVOGRREK3b6wXSkXyP9X
	 rjs0ODzh52mBmxd+ZBJHWL8G7fDHAfPyco5+ul19xzAGYDSHwbMCn88aw91RHdornG
	 x3p6J5fzJtFkRTTgq63cNZxpvr7odKMWWlprjaTg0x5QlBd3MqHn95QM8SUbXZhdRT
	 mQFSq5Yob7Ti74KbhiyougEGKDLcfAmqnK/aKc91z/8t07/Yp2pEoR7OBiF382TWlN
	 LBlHhToR0XQUqVlGF6dWtoXdzk2W2MvybGBe7o0tv/LPKdONdy5M4xxOfJZ/EsYmEp
	 nWyWhimrsNyIA==
Message-ID: <sashiko-outbox-203461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 50/88] KVM: selftests: Test guest_memfd
 conversions with sample memory provider backing
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-50-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-50-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:13 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] KVM: selftests: file descriptor leak of gup_test_fd in
  __pin_pages()
- [Low] KVM: selftests: gmem_fd leak in gmem_conversions_do_setup()
- [Low] KVM: selftests: wrong relative include path to memory_provider.h
--

commit 60d8850de9774956f2ff25264d606f044e04bb8c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest_memfd conversions with sample memory provider ba=
cking

This commit adds a fixture variant to guest_memfd_conversions_test to test
guest_memfd conversions backed by the sample memory provider, and adds a
__pin_pages() helper so the elevated_refcount test can check that pinning
PFN-backed memory fails.

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index d42e201eba763..9793818f54d23 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -674,7 +674,7 @@ int __pin_task_to_cpu(pthread_t task, int cpu)
> =20
>  static int gup_test_fd =3D -1;
> =20
> -void pin_pages(void *vaddr, uint64_t size)
> +int __pin_pages(void *vaddr, uint64_t size)
>  {
>  	const struct pin_longterm_test args =3D {
>  		.addr =3D (uint64_t)vaddr,
> @@ -685,7 +685,12 @@ void pin_pages(void *vaddr, uint64_t size)
>  	gup_test_fd =3D __open_path_or_exit("/sys/kernel/debug/gup_test", O_RDW=
R,
>  					  "Is CONFIG_GUP_TEST enabled?");
> =20
> -	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
> +	return ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args);
> +}

[Severity: Low]
Does __pin_pages() leak gup_test_fd when the PIN_LONGTERM_TEST_START ioctl
fails?  In the elevated_refcount multipage test for the mp variant,
__pin_pages() is expected to fail and the caller returns early without
calling unpin_pages(), so each loop iteration overwrites gup_test_fd
without closing the previous descriptor.  Closing and resetting
gup_test_fd via kvm_free_fd(gup_test_fd) when the ioctl returns an error
would avoid the leak.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 023df9cb9d4a6..d0cbb1353d7ee 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -16,11 +16,13 @@
>  #include "kselftest_harness.h"
>  #include "test_util.h"
>  #include "ucall_common.h"
> +#include "../../../../samples/kvm/memory_provider.h"

[Severity: Low]
Should this relative path have five "../" components instead of four?
Files under tools/testing/selftests/kvm/x86/ sit five levels below the
repository root (like tools/testing/selftests/kvm/lib/kvm_util.c, which
includes "../../../../../mm/gup_test.h").  With four "../" components, the
preprocessor searches two levels above the kernel tree via
-I$(LINUX_TOOL_INCLUDE) before resolving the header through
-I$(LINUX_TOOL_ARCH_INCLUDE), which breaks file-relative lookup for tools
and risks picking up a file outside the checkout.

[ ... ]

> @@ -75,10 +109,12 @@ static void gmem_conversions_do_setup(test_data_t *t,
> =20
>  	vm =3D __vm_create_shape_with_one_vcpu(shape, &t->vcpu, nr_pages, guest=
_do_rmw);
> =20
> +	t->expect_pin_failure =3D variant->expect_pin_failure;
>  	t->resource_fd =3D -1;
> =20
>  	if (variant->create_resource) {
> -		uint64_t flags =3D gmem_flags | GUEST_MEMFD_FLAG_USE_RESOURCE;
> +		uint64_t flags =3D gmem_flags | GUEST_MEMFD_FLAG_USE_RESOURCE |
> +				 variant->extra_flags;
> =20
>  		t->resource_fd =3D variant->create_resource(size);
>  		TEST_ASSERT(t->resource_fd >=3D 0, "Failed to create backing resource"=
);

[Severity: Low]
Does gmem_conversions_do_setup() leak the local gmem_fd created by
__vm_create_guest_memfd_resource() for resource-backed variants?
vm_mem_add() duplicates a caller-supplied gmem_fd via kvm_dup(gmem_fd)
rather than taking ownership of it:

tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c:gmem_convers=
ions_do_setup() {
	if (variant->create_resource) {
		...
		gmem_fd =3D __vm_create_guest_memfd_resource(vm, size, flags,
							   t->resource_fd);
		TEST_ASSERT(gmem_fd >=3D 0, "Failed to create guest_memfd with resource");
	}

	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, nr_pages,
		   KVM_MEM_GUEST_MEMFD, gmem_fd, 0, gmem_flags);
}

Because gmem_fd is never closed after vm_mem_add(), the guest_memfd file
and its attached backing resource (including the CMA pages allocated by
the memory_provider module in the mp variant) stay pinned across teardown
in multipage test loops until the process exits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D50
