Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789D38425A
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355313; cv=none; b=fUJM+ihKCFXMnJLgpFr/wMfzTfeG1t8wVj8c0+9Zjaroo1a1rO1JC7Rde26mjcXviIw59wOcwciBnBTksrY0DYYCkrAweCaerq4ba/W/VfdBKKfgK1IlkRUmypGi20D681m0+c9j55WXzrdU2bN+HnZcVFv5N8VAs3xr9ikbASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355313; c=relaxed/simple;
	bh=8KUO0LXiy4qEZAJ2yDH4hETgrEtU7HORCggXdYppMWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tG1SV/AApo8iHlFGTSk53V8bDqpB42YXkW6NYzyYo3DZNU/otwJplJLqT+K9/cQnkTfShewO33a1H8oQFkBmsF6vfwtxloiFtp6TbPDeAP+1Cn7/YFH3BKxC6lXyb08IfM6qUnAd6SvApnftuoAmBa4Mtx5+eYJo+mFRBsPmdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri7nbxIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri7nbxIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A940C1F000E9;
	Wed, 29 Jul 2026 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355311;
	bh=/0TYLiXr2lM+7p+3Ne2O/h07JQalThWoOYbR0zQRTuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ri7nbxIPtgX5GsD/gO54SgjuLSLLwVkb4WPxSRAf2I8MY25jmhPtdhDu1TFFxCNYn
	 ZszlmwVITQr/eUnws7j8Cfu31em5hFCGYVmrPduPGUHaIbTBiXYEMs3BVH/zpMSkEx
	 ThElfB5G63bPtOfmxRSG6Jq2R1SDZvYC8c3kEFBoe9PLFSJMUHiPfV8QDFC0dFONTw
	 6aqU1x1Wn/5owDAusXRsMSz8V87wwybp4woMQfb8QrLO8sHsApb3onMPs5UOcY9Uq9
	 9jtQ6Kr5SB36at8FTopa3RaeO2Z1/dSoyKJEULoc3lUaGpcKCDrmyYNh1/e2svZOV1
	 Ltg87u/eUaDSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/20] KVM: nVMX: Propagate extended instruction
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-10-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-10-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:01:51 +0000
Message-Id: <20260729200151.A940C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch series reads EXTENDED_INSTRUCTION_INFO using vmcs_read64=
() if APX is supported, but fails to map this field for enlightened VMCS (e=
VMCS), triggering a host kernel WARNING and corrupting instruction emulatio=
n when KVM runs on Hyper-V.
- [Medium] The logic to propagate EXTENDED_INSTRUCTION_INFO is dead code be=
cause KVM's CPUID capability tracking never initializes or exposes X86_FEAT=
URE_APX.
--

--- Patch [9]: [PATCH v6 09/20] KVM: nVMX: Propagate extended instruction i=
nformation ---
commit 649ca5041fdd2df30db144e44ba02783451c334f
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: nVMX: Propagate extended instruction information

Define the new extended_instruction_info field in struct vmcs12 and
propagate it to nested VMX. Gate the propagation on the guest APX
enumeration, which aligns with bare metal behavior.

Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com

> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 657f5f743ed97..de90697c4e5a0 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h

[ ... ]

> @@ -35,6 +35,7 @@
>  #define X86_FEATURE_AVX_VNNI_INT16      KVM_X86_FEATURE(CPUID_7_1_EDX, 1=
0)
>  #define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 1=
4)
>  #define X86_FEATURE_AVX10               KVM_X86_FEATURE(CPUID_7_1_EDX, 1=
9)
> +#define KVM_X86_FEATURE_APX             KVM_X86_FEATURE(CPUID_7_1_EDX, 2=
1)
> =20
>  /* Intel-defined sub-features, CPUID level 0x00000007:2 (EDX) */
>  #define X86_FEATURE_INTEL_PSFD		KVM_X86_FEATURE(CPUID_7_2_EDX, 0)

[ ... ]

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

[Severity: Medium]
Will this condition ever evaluate to true?

It appears X86_FEATURE_APX is defined in arch/x86/kvm/reverse_cpuid.h but is
never enabled in the capabilities mask in cpuid.c (e.g., kvm_cpu_caps).

Without initializing it there, it seems this feature will be stripped from
vcpu->arch.cpu_caps, making this block dead code.

> +			vmcs12->extended_instruction_info =3D vmcs_read64(EXTENDED_INSTRUCTIO=
N_INFO);

[Severity: High]
Does vmcs_read64() handle EXTENDED_INSTRUCTION_INFO correctly when KVM is
running on Hyper-V with enlightened VMCS (eVMCS) enabled?

Since EXTENDED_INSTRUCTION_INFO isn't mapped for eVMCS, attempting to read
it here (once the dead code issue is fixed) will trigger a host kernel
WARNING and return 0.

This could corrupt the instruction emulation state and cause a
guest-triggerable host log denial of service when an L2 guest executes an
instruction that induces a VM-exit reading instruction info.

> =20
>  		/*
>  		 * According to spec, there's no need to store the guest's

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D9
