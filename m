Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A633A70E
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227775; cv=none; b=PSTZfrPQ2xTZ17uAIATpQ9JYVuQrRoVg9G80j9h5cpttfYIfIOTQd3Aj3qW4TbQJACvjAqPkCRjdQ8zxeRiFe41BJS/vNVYIdPBuj+/VlFIVQrCSrBC2Z0jleI4x1Pceu06f5GvH1xH3b/o1zz+/Qt8WVg8UuR3FAFppnyhpmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227775; c=relaxed/simple;
	bh=wxEOxYJ5LUfB7Ji8eY6+ociPeFkMweQF4yibLYnO+Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2PifvqAJHKoMgsJvVcoM+3AQCK+Pade85aorjYGo0lb//hN/UXqVT5KOgCmKOHiAQEzau6Y0ZyKw7pgkwc80Fim4t8c9P7GORSvJnjR3cJiid42tPi150Oz5JMp4k76kqVMl3SNKqrAHWk9mrIjEvO2h9qon5zRhSQc16ceFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltVEBJSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltVEBJSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BA01F000E9;
	Thu, 16 Jul 2026 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227773;
	bh=MBs88Htu1yItx3mteg3bH67IjCdtLf2h+bVNOQn+FU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltVEBJShBtzFergRRzWW30DZf/R97W0dg+RIZvAiycT6hk4YKPvQH0u1dYjHPNGqj
	 ob3irNVN9UxZBXhcft19thgh/87iyuOhOySH555s+GEBQBXGB+Ja21unaRL8actQMZ
	 8pe1Jilkf9R0qHHQA9F1+QblMET7yA3DHXepR3EsIfHWUMhVMktciHKQsQF0ioo/jP
	 8gGy7YSHb5VM2+BOY6Oqw5oTlK3DGhboVOg4iYZoh5SsWOylaX2t+JoXHixR8ew4YY
	 /RPK/PHQH4dIVQhhJRchTpRku1kZ70MNV9lWW8nsO9xg5v4VJkBGEPbmXnc/QOL7BT
	 z2hmhvhF71s/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/24] KVM: x86: selftests: Introduce memory attributes
 PTE test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-24-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-24-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:49:32 +0000
Message-Id: <20260716184933.50BA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] `test_memory_access_sync_spte()` incorrectly passes a Guest Virt=
ual Address (`vaddr`) to `arch_write_return_insn()`, which requires a Guest=
 Physical Address (`paddr`), causing test crashes or memory corruption.
- [Medium] `test_page()` silently ignores guest-side assertions (`UCALL_ABO=
RT`), potentially masking test failures and leaving the host/guest state ou=
t of sync.
--

--- Patch [23]: [PATCH 23/24] KVM: x86: selftests: Introduce memory attribu=
tes PTE test ---
commit 129595776ab1f8d4ce03183d898471949d9d7971
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

    KVM: x86: selftests: Introduce memory attributes PTE test

This patch introduces tests to verify the behavior of memory attributes
(non-accessible and read-only) when installed on a page that holds guest
page table entries.

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> index 7066ae791b99a..c66d5d085a9c1 100644
> --- a/tools/testing/selftests/kvm/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/memory_attributes.c

[ ... ]

> @@ -106,6 +121,21 @@ static void vcpu_run_and_inc_stage(struct kvm_vcpu *=
vcpu)
>  	test_data->stage++;
>  }
> =20
> +static int test_page(struct kvm_vcpu *vcpu, int op, gva_t vaddr)
> +{
> +	int rc;
> +
> +	test_data->op =3D op;
> +	test_data->vaddr =3D vaddr;
> +
> +	rc =3D _vcpu_run(vcpu);
> +
> +	if (rc >=3D 0)
> +		test_data->stage++;

[Severity: Medium]
If the guest asserts (e.g., via GUEST_ASSERT), will this silently ignore the
failure?

When a guest assertion fires, KVM exits with KVM_EXIT_IO and the guest spins
in UCALL_ABORT. _vcpu_run() returns 0 in this case. Without decoding the
ucall struct, the test assumes the operation succeeded, increments the stag=
e,
and continues, which could mask test failures.

> +
> +	return rc < 0 ? -errno : rc;
> +}

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/=
testing/selftests/kvm/x86/memory_attributes.c
> index 2e1148f5146dd..3d2bcfe718848 100644
> --- a/tools/testing/selftests/kvm/x86/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/x86/memory_attributes.c

[ ... ]

> +static void test_memory_access_sync_spte(struct kvm_vcpu *vcpu, gva_t va=
ddr)
> +{
> +	struct kvm_vm *vm =3D vcpu->vm;
> +	gpa_t paddr =3D addr_gva2gpa(vm, vaddr);
> +	uint64_t *pte, old_pte, new_pte;

[ ... ]

> +	/* The not executable attrs remain valid */
> +	arch_write_return_insn(vm, vaddr);

[Severity: Medium]
Does this incorrectly pass a Guest Virtual Address (vaddr) to a function th=
at
expects a Guest Physical Address?

arch_write_return_insn() takes a gpa_t and passes it to addr_gpa2hva():

void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr)
{
	memset(addr_gpa2hva(vm, vaddr), 0xc3, 1);
}

If fed a GVA instead of the locally calculated paddr, will this cause the t=
est
to crash due to a failed memory mapping translation, or silently corrupt the
wrong host virtual address?

> +	test_page_restricted(vcpu, TEST_OP_EXEC, vaddr, paddr,
> +			     KVM_MEMORY_EXIT_FLAG_EXEC);
> +
> +	/* Cleanup */
> +	*pte =3D old_pte;
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
> +	test_page_accessible(vcpu, TEST_OP_EXEC, vaddr);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D23
