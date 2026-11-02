Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644985;
	b=W2SvtigUvDlPYe3coRVj10djqe/wS08bg/WYRzV24+7ASRPHoraww3V+Gj/DAtcq2eIQ
	 oafpx4ZwMf3O3FavChNJhrqGLwXrvW9Qn/emZW4dpl7HNm2086WMOW4Cy3dluhiYo4Ucx
	 W3VACoXjFG+Fu2lkPAFe6AzzAZE5pSuGMta4UPZTFqu2OoxJ96WZhIGKVmDq4CgGP+3hG
	 FdsYjjA3p36U19uvVsYFdoM+pVsP9f/OztI2gtBqV/lAQt9hb57JW1qq13cQ6Lj2/T49m
	 AlUNGpaat0zhu16ZSrLc5k6LbwptWaJUR+/jhPmnoFAaK5v5nIcNybuxUnjQJJ+XASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VZXddJQIe460x5Ylt6WBi165+ry3/8fyLRoaY4bISV4=;
	b=mBGGlcsNMHuTnu591nyR2BdftWnRBGVN2QfnpOmWDlMwnN9sLfWaRg8Z9dFJmlZLNyVj
	 UptvTwWyxFVW62tvB/U+lxkDearZrK9cYdlUCV/jRV2f16HmYSVmqC9JVKDvLrQsoy3uT
	 6DXTxC16jpzEVDKCYFthQo68q+nM6BxFQaSQU+1fZ4iXofzvs7YtcOgVK3FMybOyk3piW
	 3ZWVipVC/UGYCvKzneYsbuXmpFXuG8xXyahjSjAapZO+2z7G+dewTNhGZ0ae3ln0jrzgA
	 PKaUMVQo8kazS3cg0t/C6/ZZh9O2bX9ABVt7khuPwZp70XMjiffWsv3CzThAYUtdF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqOe9ZX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6C606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqOe9ZX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29E61F00A17;
	Mon,  2 Nov 2026 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644984;
	bh=VZXddJQIe460x5Ylt6WBi165+ry3/8fyLRoaY4bISV4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JqOe9ZX4pSVEVj7A+TXSa/T/QrwEx2eQPG9bKYji+0PHR8bvzbA5W92iwi7xqPxo/
	 4gdxegQavuuFrXjZtiiXRq9UXasEQVw8iFOv8/+WFMkPz4aT1FxLxeRaIE2JD6Po3U
	 oE3waLmjn0DpUoqu2ukByeXl9PrRObM4PFtwaggUtPJQlQImfBpq485XFw6ziQldsR
	 q7keA012PHdzjJQ6JLXyEfWyquS69Pv1t9GaTHyGrLDrF9JS6bPTu9/kGDSoFS0ayP
	 0uDNdeNok8vpgpbjzaBeo/Cv/ev5Zr2/00GESbW5bQxvadWYlhxGyYVuhvwPpQx19O
	 3Lm99s9ZLdUSA==
Message-ID: <sashiko-outbox-193959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 42/45] KVM: x86: selftests: Introduce memory protection
 attributes test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-26-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:43:04 +0000
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
- [Low] KVM: selftests: unused MMIO mapping and non-static arrays in memory=
_attributes
--

commit 739900eb4be23c429345b95c9dff33aecc77373c
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: selftests: Introduce memory protection attributes test

This commit introduces a kselftest for KVM memory protection attributes
with architecture-independent test logic and x86-specific helpers for
read, write, and execution access checks.

Link: https://patch.msgid.link/20260918135030.171564-30-pbonzini@redhat.com

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> new file mode 100644
> index 0000000000000..81ec59382f55b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/memory_attributes.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Amazon.com, Inc. or its affiliates. All Rights Re=
served
> + *
> + * Test for KVM_MEMORY_ATTRIBUTES
> + */
> +#include <pthread.h>
> +#include <signal.h>

[ ... ]

> +#define TEST_MEM_SLOT	1
> +#define TEST_MEM_GPA	0x80000000
> +
> +#define MMIO_GPA	0x700000000
> +#define MMIO_GVA	MMIO_GPA
> +
> +enum {
> +	TEST_OP_NOP,
> +	TEST_OP_READ,
> +	TEST_OP_WRITE,
> +	TEST_OP_EXEC,
> +	TEST_OP_EXIT,
> +};
> +
> +const char *test_op_names[] =3D
> +{
> +	[TEST_OP_READ] =3D "Read",
> +	[TEST_OP_WRITE] =3D "Write",
> +	[TEST_OP_EXEC] =3D "Exec",
> +	[TEST_OP_EXIT] =3D "Exit",
> +};

[ ... ]

> +const struct memory_access {
> +	const char *name;
> +	uint64_t attrs;
> +	int ops[5];
> +} access_array[] =3D {

[ ... ]

> +int main(int argc, char *argv[])
> +{
> +	uint32_t guest_page_size =3D vm_guest_mode_params[VM_MODE_DEFAULT].page=
_size;
> +	unsigned int ptes_per_page =3D guest_page_size / 8;
> +	size_t pages =3D ptes_per_page * 2; /* 2 huge-pages */
> +	size_t size =3D guest_page_size * pages;
> +	struct kvm_vcpu *vcpu;
> +	gva_t test_mem;
> +	struct kvm_vm *vm;
> +
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
> +		     KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
> +
> +	vm =3D __vm_create_with_one_vcpu(&vcpu, pages, guest_code);
> +
> +	/* add a few extra pages for use by tests */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    TEST_MEM_GPA, TEST_MEM_SLOT,
> +				    pages + 100, 0);
> +	vm->memslots[MEM_REGION_TEST_DATA] =3D TEST_MEM_SLOT;
> +
> +	test_mem =3D vm_alloc_pages(vm, pages);
> +	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);

[Severity: Low]
This isn't a bug, but even after the subsequent commit "KVM: x86: selftests:
Introduce memory attributes side-channel tests" in this series, MMIO_GPA and
MMIO_GVA are never accessed anywhere in tools/testing/selftests/kvm/memory_=
attributes.c
after main() maps them via virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1).

Similarly, signal.h is never used in this file, and the file-local arrays
test_op_names[] and access_array[] are declared without static.

Could the unused MMIO_GPA/MMIO_GVA definitions, virt_map() call, and signal=
.h
include be dropped, and should test_op_names[] and access_array[] be marked
static?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D42
