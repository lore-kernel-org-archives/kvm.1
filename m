Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CE4BEE22
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164702; cv=none; b=aOkRjiKQLptvrkk/aG7gAix9m4B0rfnUVcV3EBqzQklNXdmGv09GDXpQ+phMzYTIhBalAJxBNb7sNw3r99+Q+oIib55NB1Rq7XKEBp7woir4oyvQ+vdMMNTyjxZ2M6jQLLT8a5hXhj+/1raN015pnA0goSD/EPZfdPcTnZSyWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164702; c=relaxed/simple;
	bh=nvE6ECbtKi3PZ1m1FKRJ6eYqQBFfweqCq8EWHrGj/HI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CIr/BJCM13Yd3SMrbAlEx1xTDavVltNQBVIEyqAhO008r3NK+8LuCiuDzEd6YOrXp2Shly1G+MIkYh5O+H8QidIUdoSQP1OeJEx9Vn1KMwQAUTlj44uG0+4TjHbzheFPz9U+oEldcke8AnTJyH7/WwnQN3ATJr14Iq2eDYMZOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH+ryUbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH+ryUbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8F51F000FF;
	Fri, 11 Sep 2026 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164700;
	bh=8JDwQskZqNP/q3erGedYE9gCvswIImVeOiYD5SlGhy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FH+ryUbZMmVbmNv7a8T82PywIH1XXaWoTY+FYdRMVdYPfqw1dKJisPvYm8lFaPKwr
	 hlKTJiW0O+cfH79FMq7qZezQs+ftQ0tMImHZOWFyejbZaZ1fmsDfSZ1xkwI1nIFe9X
	 lRch1hUCRTMmyw19goNGOOjqku4MYQdjhZhSVNIwhTdr8EoPNmu+amLRKCy8y/rT89
	 TmAEIkhPk3li6gPIJWde30lMxKAwYWPaTrIEXG7qKmXo++kKuf+ZwOnEF4D97blY18
	 AXl/383qRg0IFnBTQV/KleBgSNacscLb/m3cAO0ddklKA8VwRC2e6b3vomAGuNCzG2
	 mhhA6tnOEE2Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/28] KVM: VMX: Dump FRED context in dump_vmcs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-19-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-19-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:11:40 +0000
Message-Id: <20260911221140.7D8F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The FRED context dump in dump_vmcs() omits the FRED Shadow Stack Po=
inter (SSP) VMCS fields for both guest and host states.
--

commit 823b37b6644ed01e20ab9d85f3f985b6c7d1c23f
Author: Xin Li (Intel) <xin@zytor.com>

KVM: VMX: Dump FRED context in dump_vmcs()

This commit adds FRED related VMCS fields to dump_vmcs() to dump FRED
context for both guest and host states.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cd041381b322c..3a3315a7fc112 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
[ ... ]
> @@ -6784,6 +6789,16 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>  	vmx_dump_sel("LDTR:", GUEST_LDTR_SELECTOR);
>  	vmx_dump_dtsel("IDTR:", GUEST_IDTR_LIMIT);
>  	vmx_dump_sel("TR:  ", GUEST_TR_SELECTOR);
> +	if (vmentry_ctl & VM_ENTRY_LOAD_IA32_FRED)
> +		pr_err("FRED guest: config=3D0x%016llx, stack_levels=3D0x%016llx\n"
> +		       "RSP0=3D0x%016llx, RSP1=3D0x%016llx\n"
> +		       "RSP2=3D0x%016llx, RSP3=3D0x%016llx\n",
> +		       vmcs_read64(GUEST_IA32_FRED_CONFIG),
> +		       vmcs_read64(GUEST_IA32_FRED_STKLVLS),
> +		       vmx_read_guest_fred_rsp0(vmx),
> +		       vmcs_read64(GUEST_IA32_FRED_RSP1),
> +		       vmcs_read64(GUEST_IA32_FRED_RSP2),
> +		       vmcs_read64(GUEST_IA32_FRED_RSP3));

[Severity: Low]
Does this guest context dump in dump_vmcs() miss the FRED Shadow Stack
Pointer fields?

It looks like GUEST_IA32_FRED_SSP1, GUEST_IA32_FRED_SSP2, and
GUEST_IA32_FRED_SSP3 are omitted from the diagnostic output. Since this is
dumping the FRED state when kvm_intel.dump_invalid_vmcs=3D1 is set, should
the SSP fields be included to ensure the diagnostic information is complete?

[ ... ]
> @@ -6835,6 +6850,16 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>  	       vmcs_readl(HOST_TR_BASE));
>  	pr_err("GDTBase=3D%016lx IDTBase=3D%016lx\n",
>  	       vmcs_readl(HOST_GDTR_BASE), vmcs_readl(HOST_IDTR_BASE));
> +	if (secondary_vmexit_ctl & SECONDARY_VM_EXIT_LOAD_IA32_FRED)
> +		pr_err("FRED host: config=3D0x%016llx, stack_levels=3D0x%016llx\n"
> +		       "RSP0=3D0x%016lx, RSP1=3D0x%016llx\n"
> +		       "RSP2=3D0x%016llx, RSP3=3D0x%016llx\n",
> +		       vmcs_read64(HOST_IA32_FRED_CONFIG),
> +		       vmcs_read64(HOST_IA32_FRED_STKLVLS),
> +		       (unsigned long)task_stack_page(current) + THREAD_SIZE,
> +		       vmcs_read64(HOST_IA32_FRED_RSP1),
> +		       vmcs_read64(HOST_IA32_FRED_RSP2),
> +		       vmcs_read64(HOST_IA32_FRED_RSP3));

[Severity: Low]
Similarly, does the host context dump also miss the equivalent
HOST_IA32_FRED_SSP1, HOST_IA32_FRED_SSP2, and HOST_IA32_FRED_SSP3 fields?

While this omission doesn't affect runtime correctness, including them
alongside the RSP fields might be helpful for full diagnostic visibility.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D18
