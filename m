Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E16309EE7
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946554; cv=none; b=f3ROsfp0dMJm2s5V+OjQ4AVj793OGvnrISF6BW1CMiPaUggqzHw+3Dy38IgE6+Fx9BQ7lEvu6XgEWjPSkTOUSoTmivd/SWIP9mmq9+l+CNFasCRCkUSJNYQsiNotGLJ8Q8ZFVV0M3FEOOdiGfpF5ewU+B3HHQBEbxF80eYJCeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946554; c=relaxed/simple;
	bh=BBHtzaGbyXfKsMhlYv1Q0I+jW2JlH+JpfzaSKpRl0X8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2f2a7jWlfwBNy9907DsI8uhuqDASpPbHTMnCvLpphvU9kZ29sTUbQPTMGKWrxkFgqtof1uYz4ioWCNxumI/7od9JbPOUy6BjuNeXs6K2l9PRKeK7nHv4PE8zXdWd5yxLIRTy98JM7F94y6Pw+GofQIqd+NAYDPzsmPFJ1BaP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnYxbh6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnYxbh6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DCC1F000E9;
	Fri, 28 Aug 2026 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787946553;
	bh=MXfroyXUupnT7voNMe0WpwqtJVb2uy5t+DQ9GfyU0eM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnYxbh6PQ617HjqZvq6tdOhedI/oUGW3oYMGWnlqjo1x3AwY9ProhXUOd1Gje12Lw
	 f1F4IdxLREGtIl9YuLqCJ8CIDYWOvwxKDpZazufK93efNXHEizFApTS6YPAYZ721mw
	 f6XfXsxl9hsvIYLLCApDBWIMCkmvlEq697vbj4ijXAj8eNT/Zydh5hXDjlgNrP4bdg
	 Ip9JVAuV/2XlYhxNL7udUqn7foA0usIjjWjL7eg1RDPiDsu0vLwt6AYeVAq0abcasf
	 TETngvW2zBgv9rGg+3YDNqvE6YwMFhXQc6HpU5Cf65Ygzxq2sAJ6oV54cWLYMvH7fg
	 x4wH2fJ15Qcbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Restrict saved GPA writes to hardware write
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260828193055.59623-1-kylebot@openai.com>
References: <20260828193055.59623-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 19:49:12 +0000
Message-Id: <20260828194912.E4DCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks legacy SEV guests on older AMD CPUs (e.g., Zen 1 =
and Zen 2) by relying on `PFERR_GUEST_FINAL_MASK`, which is not populated b=
y older hardware.
--

commit f344c94c8318fa7052f7268b565d10c7815dcc45
Author: Kyle Zeng <kylebot@openai.com>
KVM: x86: Restrict saved GPA writes to hardware write faults

This commit restricts reusing a hardware-supplied GPA for emulated writes=20
by requiring a final hardware write fault. It retains the GPA and write=20
authorization information across emulator contexts.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b9267..223698cbb9be6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -6632,6 +6632,16 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *v=
cpu, gpa_t cr2_or_gpa, u64 err
>  		return r;
> =20
>  emulate:
> +	/*
> +	 * A write during a guest page walk does not authorize the instruction
> +	 * itself to write to the faulting GPA.  Require a final write access
> +	 * before allowing the emulator to reuse the GPA for writes.
> +	 */
> +	if (direct && (error_code & PFERR_WRITE_MASK) &&
> +	    (error_code & PFERR_GUEST_FINAL_MASK) &&
> +	    !(error_code & PFERR_GUEST_PAGE_MASK))
> +		emulation_type |=3D EMULTYPE_PF_WRITE;
> +

[Severity: High]
Does this logic break legacy SEV guests on older AMD hardware (e.g., Zen 1
and Zen 2) by requiring PFERR_GUEST_FINAL_MASK?

When an MMIO write in a legacy SEV guest triggers a nested page fault on
these older processors, the hardware does not set PFERR_GUEST_FINAL_MASK
(as this bit requires GMET or SEV-ES). Because this flag is missing,
kvm_mmu_page_fault() will not append EMULTYPE_PF_WRITE to the emulation
type.

Without EMULTYPE_PF_WRITE, ctxt->gpa_write evaluates to false, causing the
emulator to fall back to a software page table walk via
vcpu_mmio_gva_to_gpa(). Since SEV guest page tables are encrypted, the
software walk will fail, resulting in fatal emulation failures and guest
crashes.

>  	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
>  				       insn_len);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828193055.5962=
3-1-kylebot@openai.com?part=3D1
