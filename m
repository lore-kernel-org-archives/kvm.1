Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620599;
	b=eQe2GTtdzCRwN+ptY57f4zljAjSUyeTgw3GFk6kbUkbi1rE8O/Uw4kVTEnx6Y128jE72
	 NpFkHrBTZUT5GRdmaiigNoraT6gJ0rTQekoowB77IU7QixKCYraFMmg70CEcLL/XOtfzE
	 YtnpUSa0WLznO4YwwTwvk56pMnt4wZu13S4v32by/hxCx2xA6g3cqJTDT7NwR8MhNGgNz
	 cRxpE1+EgWluJXyOajiRHMerZA4NCBw87f/N5lrPKVgPRoR9ajuK6ct8kldbr965oW8pN
	 FIPUyAzKsbm2HEb0/JX+QIR6m5dPb8XK0cyNUdqyKnLAkk5pe0TdIbgA3EZgSIS2dYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZVJKPFwLaA1CZFoKSN0YrqmIw+m1OcrYW1hfAAMTdGE=;
	b=u4p7eAt+h058asolNYh+VBEvo81nfff6+j2ZtdLlpmIOoV9YKrXhwSmVsSTrdrHBc0Zf
	 pvbfGRRdenW9E4dQBwGiB/YUn1ah75Ssna9TCdfr0TZ8lHlnr8Fo4L6EyT4cB9WGYmMk8
	 c6HGdNJgdc7Xy9ZE79uEW08sGzZsthHU0CJ+O3CTlp+mYA17oa72flJZbMuOAw7olcBAT
	 +jVkwAQ5RZR/iWyd/FnONX/CanR//9SB5pH1p3ITUOHw8VLstO8LxAFxohXe4Rvpurw7Z
	 +Sw3qh3FIiCmK2qqRT7jt03nRncqCG/AvjsdOmz/VmDYb+RMaYiHtizmOIACOaLLMeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUzGRI3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A1606A332
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUzGRI3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5130F1F00A16;
	Mon,  2 Nov 2026 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620598;
	bh=ZVJKPFwLaA1CZFoKSN0YrqmIw+m1OcrYW1hfAAMTdGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUzGRI3RFFFTSC4id6wB7OLIwaTIZmcb9O4fJackCv18Z/+Z0rM9L9GnMPMpXdX4D
	 xxIcAt3DLrZ0mt0N7ZB/339XQ8QW/LdOzzTkukbW3Z4k9itYT/V2k2OFJcNzml32ZK
	 Z9LbZqBeK3HUko+xmsYEmOsB4ysdRoY38cXVrQWEDTS+4uyiogtpKXAsTY5Hz2pUt0
	 9kcM7SE/mOpG2SwNyI6SqcQ1XM2lQ7DNJtUBzwjjj6WkLkHOHdH/j0Xbq4DFaYm92J
	 6jUU2Nwd/LFSNKOVrA5TikEqk790dZfjC6HA9sUIwIGlYtQHcArVE1EDMcguho5HsJ
	 i1uRnJZGCvGcA==
Message-ID: <sashiko-outbox-193358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] KVM: selftests: Test the SNP APIC-ID-list GHCB
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102114137.1198982-8-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-8-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:56:37 +0000
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
- [Medium] KVM: selftests: 32-bit nr_vcpus passed to 64-bit va_arg in run_a=
pic_id_test()
--

commit 3cc5f05e1197383f380887a6674ec843f8015520
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: selftests: Test the SNP APIC-ID-list GHCB request

This commit adds a KVM selftest exercising the GET_AP_APIC_IDS NAE event fr=
om
an SNP guest, testing valid requests, missing RAX validity, zero-sized
requests, invalid GPAs, and the 1024-vCPU descriptor boundary.

> diff --git a/tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c b/too=
ls/testing/selftests/kvm/x86/sev_snp_apic_id_test.c
> new file mode 100644
> index 0000000000000..8ad9c15091c2d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c

[ ... ]

> +static void guest_code(void *ghcb, gpa_t ghcb_gpa, void *list,
> +		       gpa_t list_gpa, struct apic_id_results *results,
> +		       u64 expected_vcpus)
> +{

[ ... ]

> +	do_get_apic_ids(ghcb, list_gpa, 2, true);
> +	results->valid_info1 =3D ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_1_=
OFFSET);
> +	results->valid_info2 =3D ghcb_get_field(ghcb, GHCB_SAVE_SW_EXIT_INFO_2_=
OFFSET);
> +	results->nr_entries =3D desc->nr_entries;
> +	results->first_apic_id =3D desc->apic_ids[0];
> +	results->last_apic_id =3D desc->apic_ids[expected_vcpus - 1];
> +
> +terminate:
> +	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
> +	vmgexit();
> +}
> +
> +static void run_apic_id_test(unsigned int nr_vcpus)
> +{
> +	struct apic_id_results *results;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	gva_t ghcb_gva, list_gva, results_gva;
> +	gpa_t ghcb_gpa, list_gpa;
> +	unsigned int i;
> +
> +	kvm_set_files_rlimit(nr_vcpus);
> +	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpu);
> +	for (i =3D 1; i < nr_vcpus; i++)
> +		__vm_vcpu_add(vm, i);
> +
> +	ghcb_gva =3D vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
> +				   MEM_REGION_TEST_DATA);
> +	list_gva =3D vm_alloc_shared(vm, 2 * PAGE_SIZE, KVM_UTIL_MIN_VADDR,
> +				   MEM_REGION_TEST_DATA);
> +	results_gva =3D vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
> +				      MEM_REGION_TEST_DATA);
> +	ghcb_gpa =3D addr_gva2gpa(vm, ghcb_gva);
> +	list_gpa =3D addr_gva2gpa(vm, list_gva);
> +	results =3D addr_gva2hva(vm, results_gva);
> +
> +	vcpu_args_set(vcpu, 6, ghcb_gva, ghcb_gpa, list_gva, list_gpa,
> +		      results_gva, nr_vcpus);

[Severity: Medium]
In run_apic_id_test(), nr_vcpus is declared as unsigned int (32-bit) and
passed without a cast as the 6th variadic argument to vcpu_args_set().

In C, default argument promotions do not widen unsigned int to 64 bits, whi=
le
tools/testing/selftests/kvm/lib/x86/processor.c:vcpu_args_set() extracts all
variadic arguments as 64-bit u64 values:

    if (num >=3D 6)
        regs.r9 =3D va_arg(ap, u64);

Because the first six arguments to vcpu_args_set() consume all six integer
argument registers on x86-64, nr_vcpus is passed on the stack. A 32-bit sto=
re
to that stack slot leaves the upper 32 bits uninitialized, and va_arg(ap, u=
64)
loads all 64 bits into regs.r9, which guest_code() receives as u64
expected_vcpus and uses to index desc->apic_ids[expected_vcpus - 1].

Can this result in reading uninitialized upper bits in expected_vcpus and
indexing out of bounds in desc->apic_ids[]? Should nr_vcpus be cast to u64 =
(or
declared as u64) when passed to vcpu_args_set()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102114137.1198=
982-1-joro@8bytes.org?part=3D7
