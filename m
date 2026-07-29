Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA563CBE8F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355204; cv=none; b=Yc/cXzH2Sthsu7vGxS14YmWlLWH4tqVg93sDBKgi/zbP7X9LXAe8BAPGbmr98lSPfQ3GqBcCVsmk9wHLdPmye++ldyAZ65WObd1NMQWQUblz0WAvcCHuyWCFk6bdVLxCl+9P7Wx9MAO9kYJhJgOsNlfNCw8F67nixsnBNmwjZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355204; c=relaxed/simple;
	bh=xFMbWYilyzlKEwUDT7ZI6SqyBafG+PdZXNuahZUCGoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8YVuRP6kK65dvrRadDqnMWgh1ALLHa8JoU75jD5fpbIrjoS7zmDuA+3X9Yei7lzKxgqTwCqI0P5o4PxH1b1eGY6Ug8ZaeUDDK64DkuPLCznrkUgNNCtEcsGRrdATk6QF2GCa5N3bi/nHSOHlVi8ITCtsEJXtq/arV5NdO+isaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwS9rWq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwS9rWq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73611F000E9;
	Wed, 29 Jul 2026 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355203;
	bh=Bd12dR59D3+8IYOMCOyEW4apacoQgDsgAV/XGzYNEN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwS9rWq2+80ShNW9oyYl4ZwSZ9x0aMF372187+z9SnKXRl8Ez3rjo6PZy3h/Mh7S8
	 WL4jVLKXW/AQDBTQwcYrA7X2UMhyt3pqLm661tXAXMgyQHxsz0+UdA0Dj0ws83hkwO
	 d4NPhIlKFqPZ1YkB643UfVSvq9WvEcxprdT2JynmtcQU3zflbDfD3/bxePmyaFcqp7
	 2eNWPAXHpuxGoTgA0iwFDKjjS8KpAKBICPaH67JtYDN8giugtlULyGWpoiEmWnM7xe
	 F2RX0ZBcCVDQ6kTzmI/647BZcCdiV0vqlTyxAqntgMsOBLpETnudsQxSJzTC51j0g9
	 +5AF7l8PVkqxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/20] KVM: VMX: Support instruction information
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-9-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-9-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:00:02 +0000
Message-Id: <20260729200002.D73611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new EXTENDED_INSTRUCTION_INFO (0x2406) field is read unconditi=
onally based on host CPU capability but is not added to nested VMX (vmcs12)=
 or Enlightened VMCS (eVMCS) tracking structures, breaking instruction pars=
ing for L1 hypervisors.
- [High] Guest-triggerable WARN_ON_ONCE Denial of Service via APX extended =
register parsing when KVM is compiled without CONFIG_KVM_APX.
--

--- Patch [8]: [PATCH v6 08/20] KVM: VMX: Support instruction information e=
xtension ---
commit 79c771b60a674c5dc19ac6cc97b8e80b339be936
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Support instruction information extension
   =20
Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.

Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com

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
> +
>  static inline int vmx_get_exit_qual_reg(unsigned long exit_qualification)
>  {
> -	return (exit_qualification >> 8) & 0xf;
> +	return (exit_qualification >> 8) & (vmx_instr_info_extended() ? 0x1f : =
0xf);
>  }

[Severity: High]
Does this expose the host to a guest-triggerable warning if KVM is
compiled without APX support?

If the host hardware supports APX but the KVM software configuration does
not, NR_VCPU_GENERAL_PURPOSE_REGS remains 16. A malicious guest could
execute a trapping APX instruction using an extended register, such as
r16.

This would cause vmx_get_exit_qual_reg to extract a 5-bit register index
greater than or equal to 16. When passed to kvm_register_read, it would
trigger the bounds check:

arch/x86/kvm/regs.h:kvm_register_read_raw() {
    if (WARN_ON_ONCE((unsigned int)reg >=3D NR_VCPU_GENERAL_PURPOSE_REGS))
        return 0;
    ...
}

This allows an unprivileged guest to spam the host kernel log or cause a
host panic if panic_on_warn is set. Should this check also verify KVM's
software capability for APX?

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
Does reading EXTENDED_INSTRUCTION_INFO unconditionally on APX-capable hosts
break nested virtualization and enlightened VMCS?

When KVM runs a nested L1 hypervisor on an APX host, L0's prepare_vmcs12
only copies the legacy VMX_INSTRUCTION_INFO. The new
EXTENDED_INSTRUCTION_INFO is missing from vmcs12.

Additionally, if L1 attempts to read EXTENDED_INSTRUCTION_INFO via VMREAD,
L0 will fail the lookup in handle_vmread and inject a VM-fail because the
field is entirely missing from KVM's supported vmcs12 fields:

arch/x86/kvm/vmx/nested.c:handle_vmread() {
    offset =3D get_vmcs12_field_offset(field);
    if (offset < 0)
        return nested_vmx_fail(vcpu, VMXERR_UNSUPPORTED_VMCS_COMPONENT);
    ...
}

Similarly, if KVM itself runs as L1 on Hyper-V, reading this field
fails to find the eVMCS offset mapping in get_evmcs_offset, triggering a
WARN_ONCE and returning 0.

Do we need to add EXTENDED_INSTRUCTION_INFO to the nested VMX and eVMCS
tracking structures?

> =20
>  static inline int vmx_get_instr_info_reg(u64 instr_info)
>  {
> -	return (instr_info >> 3) & 0xf;
> +	return vmx_instr_info_extended() ? (instr_info >> 16) & 0x1f :
> +					   (instr_info >> 3) & 0xf;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D8
