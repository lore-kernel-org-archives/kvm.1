Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD44CCDCA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318435; cv=none; b=Bw5LmMJr5hkLmnbQp1m5H+t5LholNLxocW5h66pwMDP6Tp6/qQDuRUWsbGQ09SsfbkgZqN1sKRBMRiMbzrXW2zVhTVZ5L5a1kffPy+PbtErowcAfzTy+i0GYQE5g6w7wYZ3Ia9ehKoaiG1X+PrMNC6qh8m+l0PViyzjB0lE3f5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318435; c=relaxed/simple;
	bh=U7UIzVpA7E7ok4juOmWPedDGwJqZUbumyq/Uk/BTY1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lslTQudRpni9Uzkjx2XtdhgHzO5CglrDd3c7NR/2hQfY1ODbpC7Mpgba78H6GwGkZsPBK5d+Nz2c5laBVBglgOmZpbkU4kIOFbNvW4BPMweu+cT14hvl8QtLJobelRHBwOhH9BN4rFjruhmfRBvhV+P+104V1gQSrPkBwXo4Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHXZDp/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHXZDp/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472A21F000E9;
	Wed,  2 Sep 2026 03:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318434;
	bh=ITaZCI6AiSACu8bCuyXXM7up13Op+s8UiXhXt8pO07U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHXZDp/5zYP5QtEZJ3qnIxeL5IXNKY2xiohy3xHL6Dg3zrMU7hRcPp/mQamfKmvbp
	 F69ahbZTOPRKTzZ1GtWYtCT6Oc4Gwa9Fmp+xy8HPzcVcTuZsnB6zUK3D3hucjrm2IU
	 3bsmX0kUm6ZKMs9rNNVXAUms840c2WTa6JaFa9EbH1cgXsfL7UVw5K2ongU1WA+ZJJ
	 nznZNgp4J2p94vy7WK+2c1f/2Zkc3n2go1VhSFXexBJYb99vVCPMBqohM1LJTfWEqV
	 r3Ax6GlQIt9JUUf7P9lbJrCcDiCk4k5mxCYpEPAe26jRkPbmxwTRtk/TDgrn6eYW/+
	 A08WA4s1LR9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/20] KVM: nVMX: Propagate extended instruction
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-10-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-10-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:07:13 +0000
Message-Id: <20260902030714.472A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing Support for EVMCS Field / Reachable WARN_ON
--

commit 24f2192a997da0f16691df1c9b88d4d8d59b8258
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: nVMX: Propagate extended instruction information

Define the new extended_instruction_info field in struct vmcs12 and
propagate it to nested VMX. Gate the propagation on the guest APX
enumeration, which aligns with bare metal behavior.

Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com

[ ... ]

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7229934c38bb1..69302b806a98e 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4773,6 +4773,12 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, =
struct vmcs12 *vmcs12,
>  		vmcs12->vm_exit_intr_info =3D exit_intr_info;
>  		vmcs12->vm_exit_instruction_len =3D exit_insn_len;
>  		vmcs12->vmx_instruction_info =3D vmcs_read32(VMX_INSTRUCTION_INFO);
> +		/*
> +		 * The APX enumeration guarantees the presence of the extended
> +		 * fields. This CPUID bit alone is sufficient to rely on it.
> +		 */
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_APX))
> +			vmcs12->extended_instruction_info =3D vmcs_read64(EXTENDED_INSTRUCTIO=
N_INFO);

[Severity: High]
Could this lead to a host-side Denial of Service when KVM is running as a
nested hypervisor on top of Hyper-V?

When EVMCS is active (kvm_is_using_evmcs() returns true) and the L2 guest
has the APX feature, prepare_vmcs12() will unconditionally execute
vmcs_read64(EXTENDED_INSTRUCTION_INFO).

Since EXTENDED_INSTRUCTION_INFO does not appear to be present in the EVMCS
mapping array (vmcs_field_to_evmcs_1), won't the subsequent call to
get_evmcs_offset() return -ENOENT and trigger a WARN_ONCE?

If panic_on_warn is enabled, an unprivileged L2 guest could potentially
trigger a host panic just by issuing a nested VM-exit.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D9
