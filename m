Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D81E4AF
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197255; cv=none; b=uK6+aOH+vjj3W0WW/x/uQdD7IZjaG9+tM8LtW7komg8yZ2GSg2laln1GJ0GIM15Y1hkQ/qnpmMPS6qdYjVpym7U125S/KpAqRUgWXOMWedDJP5RZwGCnIkUuU6BIn4fXWKUdePdLkeskyNJCUN9AGAt6RESKcB4gvx0PJ4J2xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197255; c=relaxed/simple;
	bh=AevJvxFdEP6YrQySo5odIkwbOpJEZFP0hSV4QFHiszQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ty0xO8ihBsqxGyYbciXVFrhprJYnIcvLrOCQLtsaU+wEe1xiraM/jIbF6bTEwtv383J5fdAhicCoOCU0O9iaLZfz3GUVCIcFaG11wk+lEUW61cKW6OrWtPH/R/VC1WaVAspEzi5R6GZDDWVjlIa6T2mWeHQvO6NZo0TxYeOTxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQyqcXj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQyqcXj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987911F000E9;
	Tue, 28 Jul 2026 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197253;
	bh=wzJSQOc9lc4mjDNiT49TV+u+9VP/9jZPpOv9qaYnRN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQyqcXj5HdIk+pf+dae3GYP+5qKDleNPNS2kwpygRypnH8M0s21VURC0Hcl1pqiaR
	 a7ajSUvv2LVKcOo7c/y8mNN6ZpAxbDjmlxxk8P7pg5fgzRKN3bzZBP9Om8DLTlUdLO
	 00GZNLaP+Jho9l9aBHFvZ07aajtpSXxXVWpS3KFpMYqnlRU8PiC8FnXbpjrweA86ee
	 kj23gew9xm3rBNh9JJc1fcOIVTVIMIVXFjWjoA+BBv4nR3QRPLgfE1HaZ32t4EMfaf
	 5FelaI7tk7Dk5ISB5vP2umEZ/F3odIWf3/8rQULtyHV2Vt1izK26Mm7AWOQJL4M7KX
	 fbjAtkLPJPKMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] KVM: selftests: Fix RAX and RFLAGS VMCB
 offsets when running L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727235228.1007324-3-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
 <20260727235228.1007324-3-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:07:33 +0000
Message-Id: <20260728000733.987911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The hardcoded offsets in `LOAD_GPR_C` and `SAVE_GPR_C` are misalig=
ned with `struct gpr64_regs` by 8 bytes, causing out-of-bounds memory corru=
ption and shifting L1/L2 registers to incorrect offsets.
--

--- Patch [2]: [PATCH v4 02/12] KVM: selftests: Fix RAX and RFLAGS VMCB off=
sets when running L2 ---
commit 828b231275dca6c618d4ec1f5e43abd20a4b5e54
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2

This commit fixes incorrect vmcb_save_area offsets by using vmcb->save.rax
and vmcb->save.rflags as parameters to the assembly block. This avoids
hardcoding offsets completely and also directly uses guest_regs.rax instead
of assuming it is at offset 0.

Link: https://lore.kernel.org/all/20260521092311.86030-1-pbonzini@redhat.co=
m/
Closes: https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40ker=
nel.org?part=3D1

> diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/se=
lftests/kvm/lib/x86/svm.c
> index 1445b890986fd..766d15f1d534a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/svm.c
> +++ b/tools/testing/selftests/kvm/lib/x86/svm.c
> @@ -164,19 +164,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
>  {
>  	asm volatile (
>  		"vmload %[vmcb_gpa]\n\t"
> -		"mov rflags, %%r15\n\t"	// rflags
> -		"mov %%r15, 0x170(%[vmcb])\n\t"
> -		"mov guest_regs, %%r15\n\t"	// rax
> -		"mov %%r15, 0x1f8(%[vmcb])\n\t"
> +		"mov rflags, %%r15\n\t"
> +		"mov %%r15, %[vmcb_rflags]\n\t"
> +		"mov %[guest_regs_rax], %%r15\n\t"
> +		"mov %%r15, %[vmcb_rax]\n\t"
>  		LOAD_GPR_C
>  		"vmrun %[vmcb_gpa]\n\t"
>  		SAVE_GPR_C

[Severity: High]
This isn't a bug introduced by this patch, but do the hardcoded memory
offsets in LOAD_GPR_C and SAVE_GPR_C cause an out-of-bounds memory access?

These macros use offsets that appear to be misaligned with the layout
of struct gpr64_regs by 8 bytes. For instance, SAVE_GPR_C exchanges
%r15 with guest_regs+0x80.

Since guest_regs has a total size of exactly 0x80 bytes, doesn't this
result in an 8-byte out-of-bounds memory write past the end of the
structure that could corrupt adjacent globals?

> -		"mov 0x170(%[vmcb]), %%r15\n\t"	// rflags
>  		"mov %%r15, rflags\n\t"
> -		"mov 0x1f8(%[vmcb]), %%r15\n\t"	// rax
> -		"mov %%r15, guest_regs\n\t"
> +		"mov %[vmcb_rax], %%r15\n\t"	// rax
> +		"mov %%r15, %[guest_regs_rax]\n\t"
>  		"vmsave %[vmcb_gpa]\n\t"
> -		: : [vmcb] "r" (vmcb), [vmcb_gpa] "a" (vmcb_gpa)
> +		: [vmcb_rflags] "+m" (vmcb->save.rflags),
> +		  [vmcb_rax] "+m" (vmcb->save.rax),
> +		  [guest_regs_rax] "+rm" (guest_regs.rax)
> +		: [vmcb_gpa] "a" (vmcb_gpa)
>  		: "r15", "memory");
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727235228.1007=
324-1-yosry@kernel.org?part=3D2
