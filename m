Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F248472
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571178; cv=none; b=Sc0U6NAiHdip+K6ejYpvee7bTEa8bv35SlUhsjssnQEtviuqolUOSVdzARfj01oE0x8OpLBeX54bXn/SzypVviMHhgAsAD95vBYAiGr1ajDDUBrTF2mHxPCf2IxPysHCClFP4GYKTF/UMLYxriHGiku9/Ym2sR0u1AedpO0PW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571178; c=relaxed/simple;
	bh=9q8ixYWFkoRREC4o6a1Wy/pFV9jNZDuoL/kbLhlpOL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJ2BpTgk6TcDb+Z7ShgcltEoHsul3hrk+cBeKXercMYA5Nsy2gRk+hwPQir8ByVOHOB0buKBorde7MpXIAuiPccDLmvX9vhfaVMPvmTNTM74kyeGtWwnCZUPtOvkDznzAvp1eQojUYOH90creHmQswB/ZuxUyklXyK1hVAk7hbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKC2jvWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKC2jvWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5711F000E9;
	Mon, 20 Jul 2026 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571177;
	bh=sQ76jDTr0UN/ikPN1QZaYyN7SemUSPr9vS+2fZlTf5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKC2jvWLmepMhgltX2CmcdQAcwd+dwPDCKOCJuuWum9lXgBC0YPlpcjErnCUJI01z
	 ig646sCSy4NL3J0bZ+wzOoZ0PelwgoW++PsgHScV9VMR6VumcW0PivnYnfkYJF9bhm
	 XYmlcEfrG1ikrOc4sAvTbAtGuZ2m9zgkqOj6pS8M17aH5eicrS0h1m2yQXr4OBzhtX
	 toxQzqDeg3bYzcWHCs+v8FQpv63BJGccOWKfdtoTSCTGrqtJLIZyQzfZPL09IovTXj
	 mrL7j/iBtY+cJnKQuD49KI6WLopnDZ+mLne+EwLJ1j2nur0+vwnBCmdJHcvsG/mbld
	 VIsZ/EdHUKxzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/20] KVM: VMX: Support instruction information
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-9-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-9-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:12:56 +0000
Message-Id: <20260720181256.DA5711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The new EXTENDED_INSTRUCTION_INFO VMCS field is omitted from neste=
d VMX reflection (vmcs12), breaking APX instruction emulation for L1.
- [High] Reading EXTENDED_INSTRUCTION_INFO unconditionally when Enlightened=
 VMCS (eVMCS) is enabled triggers a warning and returns 0, corrupting KVM's=
 instruction emulation on Hyper-V.
- [High] Malicious guests can trigger a host WARN_ON_ONCE by executing APX =
instructions when KVM is compiled without CONFIG_KVM_APX.
--

--- Patch [8]: [PATCH v5 08/20] KVM: VMX: Support instruction information e=
xtension ---
commit 96831841dd3c831246d26ed4875bb970e11f9dce
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Support instruction information extension

This commit defines VMCS field offsets for extended instruction
information and supports retrieving 5-bit register indices for the APX
extension. It relies on the host CPUID APX enumeration for enabling this
behavior.

Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com

> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 5645a84f4fbc9..2334f52071f9f 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -276,6 +276,8 @@ enum vmcs_field {
>  	PID_POINTER_TABLE_HIGH		=3D 0x00002043,
>  	GUEST_PHYSICAL_ADDRESS          =3D 0x00002400,
>  	GUEST_PHYSICAL_ADDRESS_HIGH     =3D 0x00002401,
> +	EXTENDED_INSTRUCTION_INFO       =3D 0x00002406,
> +	EXTENDED_INSTRUCTION_INFO_HIGH  =3D 0x00002407,

[Severity: High]
Does this break nested VMX instruction parsing?

It appears EXTENDED_INSTRUCTION_INFO is not mapped in
kvm_supported_vmcs12_field_offsets in arch/x86/kvm/vmx/vmcs12.c, nor is
it copied in prepare_vmcs12() in arch/x86/kvm/vmx/nested.c.

If L2 executes an APX-extended instruction that exits to L1, and L1 attempts
a VMREAD of EXTENDED_INSTRUCTION_INFO to parse the exit, will this fail with
VMXERR_UNSUPPORTED_VMCS_COMPONENT and cause L1 emulation failures?

>  	VMCS_LINK_POINTER               =3D 0x00002800,
>  	VMCS_LINK_POINTER_HIGH          =3D 0x00002801,
>  	GUEST_IA32_DEBUGCTL             =3D 0x00002802,

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index f3b0ec7ccb03a..2f53338f84f0b 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -323,9 +323,18 @@ static __always_inline unsigned long vmx_get_exit_qu=
al(struct kvm_vcpu *vcpu)
>  	return vt->exit_qualification;
>  }
> =20
> +/*
> + * The APX enumeration guarantees the presence of the extended fields.
> + * The host CPUID bit alone is sufficient to rely on it.
> + */
> +static inline bool vmx_instr_info_extended(void)
> +{
> +	return static_cpu_has(X86_FEATURE_APX);
> +}

[Severity: High]
Can a guest trigger a host-side WARN_ON_ONCE by executing an APX instruction
when KVM is compiled without CONFIG_KVM_APX?

If KVM is built with NR_VCPU_GENERAL_PURPOSE_REGS =3D 16, but the host CPU
supports APX, this check returns true. A guest could cause a VM-exit with
a 5-bit register index 16 or greater.

When KVM extracts this index from the instruction and passes it along, will=
 it
hit this check in arch/x86/kvm/regs.h:kvm_register_read_raw():

    if (WARN_ON_ONCE((unsigned int)reg >=3D NR_VCPU_GENERAL_PURPOSE_REGS))
        return 0;

This could panic the host if panic_on_warn is enabled.

> =20
>  static inline int vmx_get_exit_qual_reg(unsigned long exit_qualification)
>  {
> -	return (exit_qualification >> 8) & 0xf;
> +	return (exit_qualification >> 8) & (vmx_instr_info_extended() ? 0x1f : =
0xf);
>  }

[ ... ]

> @@ -707,20 +716,22 @@ static inline bool vmx_guest_state_valid(struct kvm=
_vcpu *vcpu)
> =20
>  void dump_vmcs(struct kvm_vcpu *vcpu);
> =20
> -/* A placeholder to smoothen 64-bit extension */
>  static inline u64 vmx_get_instr_info(void)
>  {
> -	return vmcs_read32(VMX_INSTRUCTION_INFO);
> +	return vmx_instr_info_extended() ? vmcs_read64(EXTENDED_INSTRUCTION_INF=
O) :
> +					   vmcs_read32(VMX_INSTRUCTION_INFO);
>  }

[Severity: High]
Will this corrupt KVM's instruction emulation when Enlightened VMCS (eVMCS)
is enabled on Hyper-V?

When vmx_instr_info_extended() is true, this calls:

vmcs_read64(EXTENDED_INSTRUCTION_INFO)
  evmcs_read64()
    get_evmcs_offset()

Since EXTENDED_INSTRUCTION_INFO doesn't seem to be added to the EVMCS1_FIELD
mappings in arch/x86/kvm/vmx/hyperv_evmcs.c, get_evmcs_offset() will return
a negative offset.

Will this trigger a warning and cause the read to unconditionally return 0,
leading to incorrect instruction decoding and silent data corruption in the
guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D8
