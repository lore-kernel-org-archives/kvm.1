Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3E3C5DDE
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571055; cv=none; b=fLS4gihbuQXz+09wd+Z2VxwUQgFHx6xoltRDzVGbphsusODz0pHy6OEoNCuhtmv0rFAbHCsSCp9fZbmkQ8y2/46QHz8Wcq7uKf4KGkaTk5+6x4GqwsilkdcaGmJs+eRlgMHvQA0fHtdtz2T0phx/LEqM1t4vIe+Do/U7b5SgSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571055; c=relaxed/simple;
	bh=LrdQsZ2PZJ8n44pel7gu30SxVBrS0O2YGID+CSbvg8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1MDBKR5bKHaW+gHw0lt5HCtrzV3ZeNY5/ofM5morcdyaSMmNJw8L6/UN0+og4TPv++Sf7zRwSP3yKz7939pJo2jQt5mjqswdIl09ey1Qach72WwYHnh7bFR4f4SZl1k5PCQRqmHw5i/Njpg9Fm3VLW90zcqQvUwk7N1CtspIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/LSa9D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/LSa9D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B653A1F000E9;
	Mon, 20 Jul 2026 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571053;
	bh=QlNuAS0tkk+k+QkApSGYjXisNGbl1k6O8Q8d3vskfPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a/LSa9D9tCSRetymgmWHmgr3P7+q7cxSjaqbB8wLLmjH4lRanQyoiiFr+BfHo8Xf3
	 DdRTr/kKy/3YhFLuBeQodqLYemRJlxG3IRpD/Kpr+WZELLovO6eAMTWiEsOr9O3l9G
	 hKmEEnLf0H7g3ERCp0QiGdrzk1nsclxzwjjbAYy1CHDOxCRFN+s3Jr2VQRJm+UvCJO
	 nmzRJWYf4g8dntovNLFOpLcGmSZIOTzVkAjHR/MjK3oaNZLA9UNVjXSOivXe0kgo2U
	 Rn5z0tyjc/p2G4DE/Eo8rBVx4M+5Rwve+Tywa6yhiILFgqnBVCEMRnd9HQRU+7cOU1
	 N9uiZyqzWKMkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/20] KVM: nVMX: Propagate extended instruction
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-10-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-10-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:10:53 +0000
Message-Id: <20260720181053.B653A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch defines KVM_X86_FEATURE_APX but fails to initialize it=
 in KVM's supported capabilities via kvm_cpu_cap_init(), causing the new ne=
sted VMCS propagation to be dead code.
--

--- Patch [9]: [PATCH v5 09/20] KVM: nVMX: Propagate extended instruction i=
nformation ---
commit 2483dfe37a64f0e1963aeef4b3b32d649b5a5dda
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: nVMX: Propagate extended instruction information

Define the new extended_instruction_info field in struct vmcs12 and
propagate it to nested VMX. Gate the propagation on the guest APX
enumeration, which aligns with bare metal behavior.

Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8e0523e40477d..1684f5d1dbf4d 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -4766,6 +4766,12 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, =
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

[Severity: Medium]
Will this condition ever evaluate to true without first initializing the APX
capability in KVM's supported features?

When userspace sets the guest CPUID via KVM_SET_CPUID2, KVM masks off
capabilities that are not explicitly initialized. It appears F(APX) is miss=
ing
from the CPUID_7_1_EDX capability mask in kvm_set_cpu_caps():

arch/x86/kvm/cpuid.c:kvm_set_cpu_caps() {
	...
	kvm_cpu_cap_init(CPUID_7_1_EDX,
		F(AVX_VNNI_INT8),
		F(AVX_NE_CONVERT),
		F(AMX_COMPLEX),
		F(AVX_VNNI_INT16),
		F(PREFETCHITI),
		F(AVX10),
	);
	...
}

Does this omission cause the newly added nested VMX propagation for APX to =
act
as dead code, since the APX bit in vcpu->arch.cpu_caps would always remain =
0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D9
