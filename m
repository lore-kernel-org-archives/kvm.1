Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41531E85B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779877; cv=none; b=PsHcxaci3HCZkq2QjjOe+YjyWON9I+Vb/086+wzrzcIWEBkOVT/CtDsWaszx8+Ro/Gohjj7qnO9fZr9T8l3TI9f/G9ITgTwVyh7B6W3Eh51tBIV27rc1DPQft9TQEPZ15CjfUmnStA9ET0ZGkkUExz4qramYaUq7/WinpSQUIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779877; c=relaxed/simple;
	bh=jsV9GXOK72loCPs7hNMYPKs+jYsan6HiVYX+XcY5L9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lB1Z0FgBLFZR6ULUgh8WxbnACyN4BwdjQLKGiAgGhafca4XHUKYKuBy4bmJ1UA+m3hMMrKHcezgYT1lZytvoAIx5bFJjt9A6LXE2Zr63NpcYAa6SqH0ilS0puspf7IDK3DRk0qKGqtnGaGG8k4FalkG3ZE+zrT/9Hyec848iAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4Up/CVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Up/CVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25441F00A3A;
	Wed, 26 Aug 2026 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787779876;
	bh=OrMsW8eueiCbjss+pG/bZa/tlsUCWmmsTGTCkkxbqIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4Up/CVl8xyFYs9YBeRM+OW5miLSrx871fX0rbyXXFEP73yucTIjCiGuSY9WsGrEz
	 veJoHNIugHm0p7gvoQFabuD7aw/MhZxiejVo07qBs57idx224jfl2ec0KwOFYaM98s
	 g5oaFAsOGn9NV/WBMBUfvq//IrjhO0t/PAmcOxDifdwOi7aAUxWPvp38ZSI+Pdpf2+
	 luxsSTShQo7uDDoUez0t6va8ZuZedHkHqtUjp/J/g6HKs+xAQJq4x8q82UqWDZYk96
	 +LWYz/BujDhuf/Q5N1r0ROt8NTMRUlJFLgCp3rNygNuiXPMiR5sp3qTJWvHK+Tx9VA
	 NkM56NaCtJcvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role
 with EFER.LMA=1 && CR4.PAE=0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826211844.884951-4-seanjc@google.com>
References: <20260826211844.884951-1-seanjc@google.com>
 <20260826211844.884951-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:31:15 +0000
Message-Id: <20260826213115.C25441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying a const-qualified structure field via a pointer cast inv=
okes Undefined Behavior, allowing the compiler to optimize out the mitigati=
on and leaving KVM vulnerable to processing corrupted MMU states.
--

commit 398614ee03891692ae2eecdde307edc043d7403e
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=3D1 && CR4.P=
AE=3D0

This commit attempts to mitigate invalid MMU roles by bugging the VM and
clearing EFER.LMA if long mode is active without PAE paging enabled.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b9267..81c30e2c74f3c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
>  		return role;
>  	}
> =20
> +	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kv=
m))
> +		*(u64 *)&regs->efer &=3D ~EFER_LMA;

[Severity: High]
Does casting away the const qualifier and modifying regs->efer here invoke
undefined behavior?

The regs pointer points to a struct kvm_mmu_role_regs, which defines the
efer field as const:

struct kvm_mmu_role_regs {
	const unsigned long cr0;
	const unsigned long cr4;
	const u64 efer;
};

Modifying a const-qualified object invokes undefined behavior per C11 6.7.3=
p6.
Because the regs structure is typically allocated locally on the stack, for
example via vcpu_to_role_regs, and passed to kvm_calc_cpu_role, modern
compilers have full visibility into the object's definition and can cache t=
he
initial const value of regs.efer in a register.

If the compiler evaluates subsequent checks like ____is_efer_lma(regs) using
this cached value, could this completely bypass the sanitization?=20

If an untrusted guest attempts to set its vCPU state with EFER.LMA=3D1 but
CR4.PAE=3D0, this bypass could cause KVM to compute a corrupted MMU role, s=
uch
as configuring 64-bit levels but 32-bit PTE sizes, which then escapes into
the MMU configuration.

While KVM_BUG_ON flags the VM as bugged, the function continues executing
with the corrupted role, potentially leading to out-of-bounds accesses befo=
re
the VM is fully halted.

This issue defeats the purpose of the security mitigation and is not fixed =
by
the subsequent commit "KVM: x86/mmu: Convert MMU walker's bounds check from
BUG_ON() to KVM_BUG_ON()".

> +
>  	role.base.efer_nx =3D ____is_efer_nx(regs);
>  	role.base.cr0_wp =3D ____is_cr0_wp(regs);
>  	role.base.cr4_smep =3D ____is_cr4_smep(regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826211844.8849=
51-1-seanjc@google.com?part=3D3
