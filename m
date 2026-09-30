Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92848502D4A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805176; cv=none; b=RgpYdnkerajhZg6L9rDQWGUrP4N9wJRfinh/+czFFptP8vETBR2Fmy5EFjnclGnmwKBiw35FtKHfibtbnpuJEWa9vojQ0YWsdZRLQ2Hv/tuJFxIOhGDjC7hy4BYdGYgQ2V6CKSJ+u/76eniaNjEG86w7bhOTAJVkL0KwH56pHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805176; c=relaxed/simple;
	bh=1PSGlQdySXRQfnvTSNtGcnDv9ZH+lWZ4fAl/oSwYBg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WHHoXJzIPm3Re4byX5Fw5SfbJNpU3vVI7u+ZWyalQdJntFxzcsUoDDxzpKOqdZx8xDi5J1rTVl1Egetuy8+5nt4ht6C8G9TiI2OOuCTPkOmz1lOiJZOlPzrC1pJMbIIp7uXqOc9H3crgAdtzHkumKgmGPIqq2i8u1y47IW6smq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja/peKED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja/peKED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6D61F000FF;
	Wed, 30 Sep 2026 21:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805175;
	bh=vIFCUty7cKnBTEh1Z0Fb17xt1eSVGsZW2QErbX+WErk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ja/peKEDnMfwOnUs5JPxKO1uc8wi+d/vRYH1Pmh23AUCLGsJ7ubWF6XYAJAuIg7pi
	 VAzmODJJLK5XduZtLBJ6V4ypHc/ZSNPbygt2ukpm8ZhSSTvBwhVeyUSB/OnJrMnuB9
	 Jxuzi9cKxZhaEQjNj99HbGC8U0DO/pwjuqVSkvTfuT2AbQ7b/CkuWPsBZfO71XcwpO
	 jXtQckcvliaOKjpxs04G7IdC4tltWuVSxpgHJLg6c0GnNAB+7QwQhFCVRyn92seOjd
	 OCb87nsBRJVKeKKdSpMF2f1vM+s4hopv2H7Y/8uuScsrgGHDU1XTTy7nBsdnc+37/1
	 On3cIOWuy9B8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/20] KVM: nVMX: Propagate extended instruction
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-10-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-10-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:52:54 +0000
Message-Id: <20260930215254.DC6D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: nvmx: missing eVMCS mapping for EXTENDED_INSTRUCTION_INFO cau=
ses host DoS
--

commit 50ba47ea51df9d3191678e833e5b9efb01e769c0
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: nVMX: Propagate extended instruction information

This commit defines the new extended_instruction_info field in struct vmcs12
and propagates it to nested VMX. The propagation is gated on the guest APX
enumeration.

Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com

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
Does this unconditional read cause an issue when KVM is running as an L1
hypervisor on top of Hyper-V?

When eVMCS is in use, vmcs_read64() transparently redirects to the eVMCS re=
ad
handler. If EXTENDED_INSTRUCTION_INFO is not mapped in vmcs_field_to_evmcs_1
for eVMCS v1, evmcs_field_offset() will return -ENOENT.

This missing mapping leads to a host-side warning in get_evmcs_offset()
firing on nested exits:

    WARN_ONCE(offset < 0, "accessing unsupported EVMCS field %lx\n", field);

Because an unprivileged L2 guest could easily trigger these exits, could th=
is
be used as a host-side denial of service in environments where panic_on_war=
n=3D1
is enabled?

> =20
>  		/*
>  		 * According to spec, there's no need to store the guest's

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D9
