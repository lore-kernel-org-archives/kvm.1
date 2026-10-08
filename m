Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDAB640
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419737; cv=none; b=HMY3tE4ds42xzyVU4m7D8ciIAezzguNzAL8TXwedxkvwaFCU5f7f5zie7Z31jFVu3PHilwSbdRik5kL/2b8u00wsCrnGUHsBI7oOW2WA0CJSpOOnZqMuPGqnaoUQaPUlT6jHG24kKYeIowjV7u4tOdEEt/n+lChvBVnWj8DYDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419737; c=relaxed/simple;
	bh=IegumqAal+rvV7/Vn78p5m6CGfv4B3HwSf9Vfhlx7n8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rMe9BA9cbZdXgk4gdBN1cqzRtZwr/+xGaBh0eHYCej+L5Is83c+vhep8gpxMcY4DZLyaUxjQC8//1zE/FZJ36oc7Y+S5iDTr5dPW0E9qnSAwl51N5DEhnF+FWWdzaYpL+vaic+4m06VDuy7J5jvhVO8ka/9l67RRo/9wUoowEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCUXGl1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCUXGl1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A091F000FF;
	Thu,  8 Oct 2026 00:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419736;
	bh=tkB0Q8zPbh0rg2iB5SSfGFkRy9RF2znmPSXJHWkxhF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCUXGl1ESBpBYjbDV48cbhjvGYwlYOzsrtlqL3O7RS94YxMvOZNio58GhhUc6cKy8
	 pk5qIzM/jr7ob50nQ3Q0b0gFq5oQKCNh46lXwnoVmgcGQPfvL/FdjVdzLFhYBLT9rw
	 y8oJ+S7UAC/VKw+z7OsywbWowmj1J2YN5AoYcSieiiq2+wta+HkOAb/OCCHTfW8V+I
	 kjynCN6euypWoru5fPLcXy37mhitRpv0sXjAcahM46zSF1D40NVXAqofpCgpim+o11
	 OYsGQzTcLXbVfTrOug8bqonwEvXwb5emviXe+DtOtZJldaZr4tDjEJdIsqwIb8Ae8z
	 QuDjXUyfPXDaw==
Message-ID: <sashiko-outbox-163475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/29] KVM: selftests: Add a test for nested TLB
 flushes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-30-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-30-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:35:35 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: missing memory clobber in invlpga() allows reord=
ering
--

commit c21865242d0952d01a007708f2fbf08ce2550486
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Add a test for nested TLB flushes

Add a test that exercises most common scenarios for TLB flushes. The
test is split into guest-triggered and KVM-triggered TLB flushes.

> diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testin=
g/selftests/kvm/include/x86/svm.h
> index c8539166270ea..7644e37c7042c 100644
> --- a/tools/testing/selftests/kvm/include/x86/svm.h
> +++ b/tools/testing/selftests/kvm/include/x86/svm.h
[ ... ]
> @@ -316,4 +316,9 @@ struct __attribute__ ((__packed__)) vmcb {
> =20
>  #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
> =20
> +static inline void invlpga(unsigned long addr, u32 asid)
> +{
> +	asm volatile("invlpga %0, %1" : : "a"(addr), "c"(asid));
> +}
> +
>  #endif /* SELFTEST_KVM_SVM_H */

[Severity: Medium]
Does this inline assembly need a "memory" clobber?

Unlike the VMX counterparts invvpid and invept introduced in this patch, th=
is
inline assembly lacks a "memory" clobber. This might allow the compiler to
reorder prior memory stores past the TLB flush instruction.

> diff --git a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c b/to=
ols/testing/selftests/kvm/x86/nested_tlb_flush_test.c
> new file mode 100644
> index 0000000000000..fb32b7bf6b19f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
[ ... ]
> +static void l1_guest_code(void *data)
> +{
> +	gpa_t gpa;
> +	int i;
> +
> +	prepare_l2(data, l2_guest_code);
> +
> +	/*
> +	 * Alternately switch the PTE (or TDP PTE) mapping TEST_VADDR between
> +	 * two pages containing VAL1 and VAL2, flush TLBs, and verify that L2
> +	 * reads the expected value.
> +	 */
> +	for (i =3D 0; i < NR_ITERATIONS; i++) {
> +		gpa =3D test_gpa[i % 2];
> +
> +		*pte_gva &=3D ~PHYSICAL_PAGE_MASK;
> +		*pte_gva |=3D gpa & PHYSICAL_PAGE_MASK;
> +
> +		WRITE_ONCE(l2_expected_val, (i % 2 =3D=3D 0) ? VAL1 : VAL2);
> +		run_l2(data, i =3D=3D 0);

[Severity: Medium]
Can the compiler execute the *pte_gva assignments after the TLB flush inside
run_l2()?

Because the invlpga() inline assembly lacks a "memory" clobber, and there i=
s no
other compiler barrier between the assignment and invlpga(), the compiler is
legally permitted to reorder the memory store to execute after the invlpga()
instruction.

If this reordering occurs, the hardware will flush the TLB while the old PT=
E is
still in memory, which could allow a speculative hardware page walk to re-c=
ache
the old PTE before the store completes. When L2 resumes, it may use the sta=
le
TLB entry, causing the test to spuriously fail. The "memory" clobber in the
run_guest() wrapper only ensures both operations complete prior to VM-entry=
; it
does not enforce their relative execution order.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D29
