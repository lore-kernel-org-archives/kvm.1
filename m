Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0723438AE
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938968; cv=none; b=ZR9nrRasFM+fHF0NBGMnelmTKNLyqtVEmihSMEiDfd52vqyyWDHe1vgC6yJuWq1t/3we41QQliVUsjxCxrDZZDQAYovMd+zXzTYvYz5htKwoO5dSBqbRYSucxcWQga68KDVXBdcTWUa9TVESSiVn13EdkbEwIzgmuCfF7P4EPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938968; c=relaxed/simple;
	bh=rxkC6ueoGU/OfgWFCfj2IeSIfFl6CRJkpLd38kl09ts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m7NsQJ0qYcPMdHM+VVkOLoIRls40MSIC3Uj/O1bYVCgWQwzAp9W8k36FTBNQiRI6DzB5uP7rxJ3ndS/rWAN9vEcNOrStuBZSkJvzdt0oEUQyx3k5SLmFvr56+Zk/0+N3MlbZqSnp11aMhQmDgCTiuPGdSvAp+Mbkx3A3/LzcoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4BIYQ88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4BIYQ88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCCB1F000E9;
	Thu, 28 May 2026 03:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779938965;
	bh=2zhS6zMeJmagDRtvgTIrxM/q6eI/esvuSVxQXHMItME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4BIYQ884ZaWwd14U0Zn/OnAk/Y7lV+wEit4RIVROR4lKJmJ5LK/TuSpV404dLcl/
	 hHFZwYqVtSz73bzh1lj4mSwQWoeNpsE87BbjvLnYPW3EcKJUYHELA1T5Z71fKnmUil
	 sWKjyHWnS0zB7+Zm1fX2v8sAijZm9TbInQdniMhXu6R8NqeQztM966mpccd9vnVGn4
	 zBmxvE80/rpgjK+lI/W5Hu481EyNaqOu8poZnHm9oha9pQECatL6AHR4BB973a4V8g
	 UWrfhwSA1VdXybpCuaKqRfAZfipIPRdwu2NU4ve3ZI+T/d6quywUfnjgwwdBiMdvnH
	 TR445TQX5R5Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: selftests: Add guest_memfd regression test
 signed offset+size bug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528021117.107984-4-seanjc@google.com>
References: <20260528021117.107984-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 03:29:25 +0000
Message-Id: <20260528032925.BBCCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The hardcoded guest_memfd offset literal is 68 bits long and onl=
y 4KB-aligned, causing the test to pass for the wrong reasons and failing t=
o verify the actual signed offset+size bug.
--

commit 418cb333b0d34d015bff4f1526de77942a583c81
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add guest_memfd regression test signed offset+size bug

This commit adds a regression testcase to ensure KVM rejects an offset and
size that would result in a negative value when computed as a signed 64-bit
value.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 246bb408ecc0c..95a6ddfd80237 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -345,6 +345,16 @@ static void test_invalid_punch_hole(int fd, size_t t=
otal_size)
>  	}
>  }
> =20
> +static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
> +{
> +	int r;
> +
> +	r =3D __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, size,=
 0,
> +					 fd, 0x7ffffffffffff000ull);

[Severity: Medium]
Is this hardcoded offset value correct?

The literal 0x7ffffffffffff000ull contains 17 hex digits (68 bits), which
will be truncated to 64 bits (0xfffffffffffff000ull) by the compiler. Becau=
se
this truncated value is very close to the maximum 64-bit unsigned integer,
adding the size to it will wrap around zero.

Will this trigger KVM's existing unsigned overflow check instead of the sig=
ned
offset plus size bug this test is meant to verify, causing the test to pass
for the wrong reason?

Also, since the trailing 000 makes the offset strictly 4KB-aligned, will
this fail immediately during the page alignment check on architectures with
larger page sizes (like 64KB on ARM64)?

Should the offset be dynamically calculated at runtime based on the page si=
ze
to ensure proper alignment and accurately test the signed boundary?

> +	TEST_ASSERT(r && errno =3D=3D EINVAL,
> +		    "Memslot with out-of-range offset+size should fail");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528021117.1079=
84-1-seanjc@google.com?part=3D3
