Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318691;
	b=nAQOTSatFuIE1GZNa3TrG45MDSOOmQ5DtMTT0BXSbLFdnKik2of6yr1GJw0PWGFRuteK
	 OQS3h8v4VRWWRCAr+6wIc6mpPN2OqUoUl5XFCS6o/Kx0DE0uLyBSF9npTaVM1eeeC1r0l
	 1uKJcva8ceRjzrHL7XxLOWQgPWGwiqx58Gu0cgYZa+uQsDdgEpSrgKXyFGHgtWwUAxAQj
	 u5l00LGSdnUBWX55OeCMt+8JkfXwZWPy4FRiMI66ND3c8L1a006yYM/CgnpHSq/HMLV9r
	 bF/hFgrwtVZRTsO/UnVO0cfyShYYxxZQL4f0zfIJMwJ7TkKa/67J6svx+oRYDTH19uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QT0b4cj8MXIGv8LIRca513xpWCi25cLtYz1pl1JYINc=;
	b=ujHyP2yI++cppIAal78CBHHVQUxIvOIUDUWgMdf25CDzQhSLOq6N/MwFjR2qrsyNJYcJ
	 gR0aJaUuIatW0VfqVABg2AzMeaJla3sqoxM1dl3wdBYIEIemJVlWqBg4FhSaUziHmqRFP
	 75/ZXztL5D4UdrhMbSUx1zl9SwLeVyQABVwliv3lqnyVuyknKNlkLC3vnC4cpNs3Jyrb/
	 J21RAKfbLlSHvGvkc6Zq3NWa7x+R7PX3Q5bUq+wrXrcd5XvLnrfu6uzg4mJjoUUzkx14t
	 vD5KrdpOcmV35i/aG40rXO4lof7B0wy5C0HmCfJ/2wFzrwBMazW021RY0g0nIwkhSLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNdchIJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341E606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNdchIJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0461F000C1;
	Fri, 30 Oct 2026 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318691;
	bh=QT0b4cj8MXIGv8LIRca513xpWCi25cLtYz1pl1JYINc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TNdchIJfPa5hc78llUzvYEcuBCS0sXQYAVlpEYheaFea52G7DSS6kEttrBJQu/miQ
	 WHDt5wUC00roJav7GnWcelVepjzgHw+5o4jVfVs9T7PSVi2lsPxAqYz/G8PG7LtJOd
	 0MhPuH3S23N/947Q21O0rwdl54xLT13WNwNDwOp8aNNsw9QUF0+CeX2LP2vyuB8Sm/
	 Tr369E6M4gcz+bUhudsCQE5qm2kGnR0jrHP25PpFasmnA+A3DC7SS64BcYfV/TcS5Z
	 mcTTyKmhKZVFUIOXwwySVtmMtCT64WtZdrbUSxwZe2+Rvd+HVhVjybyLxvk8u5P9Ni
	 FeeerT91XVKfw==
Message-ID: <sashiko-outbox-190122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Verify that L2's LMSW leaves
 L1-owned CR0 bits alone
Reply-To: sashiko-reviews@lists.linux.dev
To: ma.mandourr@gmail.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20261029235040.12013-3-ma.mandourr@gmail.com>
References: <20261029235040.12013-1-ma.mandourr@gmail.com>
 <20261029235040.12013-3-ma.mandourr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 00:04:50 +0000
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
- [Medium] KVM: selftests: unordered l2_cr0 store and zero check in l2_lmsw=
_test()
--

commit 81df08b65f8d95b00451c4c4a33f93d0001cf528
Author: Mahmoud Abumandour <ma.mandourr@gmail.com>

KVM: selftests: Verify that L2's LMSW leaves L1-owned CR0 bits alone

This commit adds a nested VMX test case to nested_exceptions_test to verify
that an LMSW in L2 that exits to L0 preserves L1-owned CR0.TS and reads an
L1-owned CR0.NE from the CR0 read shadow.

> diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/t=
ools/testing/selftests/kvm/x86/nested_exceptions_test.c
> index f47432526ea16..7113018ee62a9 100644
> --- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> @@ -109,6 +109,40 @@ static void l1_svm_code(struct svm_test_data *svm)
>  	GUEST_DONE();
>  }
> =20
> +static u64 l2_cr0;
> +
> +static void l2_lmsw_test(void)
> +{
> +	/* Toggle CR0.MP, which KVM intercepts and L1 doesn't. */
> +	asm volatile("lmsw %w0" : : "r" (get_cr0() ^ X86_CR0_MP));
> +	l2_cr0 =3D get_cr0();
> +	asm volatile("fnop");
> +	GUEST_FAIL("L2's FNOP didn't take #NM");
> +}
> +
> +/*
> + * L1 owns CR0.TS (set) and CR0.NE, both with a read shadow of 0.  L2's =
LMSW
> + * must leave both alone: FNOP takes #NM and L2 reads NE as 0.
> + */
> +static void vmx_run_l2_lmsw(void)
> +{
> +	u64 cr0 =3D vmread(GUEST_CR0);
> +
> +	vmwrite(CR0_GUEST_HOST_MASK, X86_CR0_TS | X86_CR0_NE);
> +	vmwrite(CR0_READ_SHADOW, cr0 & ~(X86_CR0_TS | X86_CR0_NE));
> +	vmwrite(GUEST_CR0, cr0 | X86_CR0_TS);
> +	vmwrite(EXCEPTION_BITMAP, BIT(NM_VECTOR));
> +	vmwrite(GUEST_RIP, (u64)l2_lmsw_test);
> +	vmresume();
> +
> +	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
> +	GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_INFO) & 0xff, NM_VECTOR);
> +	GUEST_ASSERT(!(l2_cr0 & X86_CR0_NE));

[Severity: Medium]
Can the store to l2_cr0 in l2_lmsw_test() be reordered past the fnop
instruction, causing the assertion in vmx_run_l2_lmsw() to pass vacuously?

In tools/testing/selftests/kvm/include/x86/processor.h:get_cr0(), the inline
assembly reads CR0 into a register, and l2_lmsw_test() then stores that
register to static u64 l2_cr0, which is zero-initialized in .bss and not
marked volatile (nor written via WRITE_ONCE()).

Because asm volatile("fnop") does not have a memory clobber, the compiler is
only required to order the volatile asm inside get_cr0() before fnop, while
the plain C store to l2_cr0 can be scheduled after fnop (before the function
call in GUEST_FAIL()). When fnop triggers #NM and exits to L1, any store
scheduled after fnop never executes, leaving l2_cr0 at 0.

In vmx_run_l2_lmsw(), GUEST_ASSERT(!(l2_cr0 & X86_CR0_NE)) only tests that
X86_CR0_NE is clear, which succeeds when l2_cr0 is still 0.

Should l2_cr0 be written with WRITE_ONCE() (or given a memory clobber on fn=
op)
and checked against the full expected CR0 value
(cr0 & ~(X86_CR0_TS | X86_CR0_NE)) ^ X86_CR0_MP via GUEST_ASSERT_EQ()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029235040.1201=
3-1-ma.mandourr@gmail.com?part=3D2
