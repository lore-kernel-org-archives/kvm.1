Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD071CDFCA
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487196; cv=none; b=lr+Er6eklrqvJs2rL3nocr/bW3IxfDclYg8cVdmeyb8d7lVCK3noMqrGJ0jpLFAXGLa2gQyQ7rSXkHPW4VHkZwmKvzFI8LQQZlBgLLLMziLnJDzB3xEuy5qNIR99b8YCK0meYyrBVl49B6eWV9hMb/P5FY/J0ODVXKA19S5SIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487196; c=relaxed/simple;
	bh=umaJHrZtq+wJcQ0KI+QpDg+Y6QU0FpjPZqRdsh49IhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=csqof28+ULmBlfr9EUrM5t2T+Be9DqxrnWnTXsfNBSApVT5mZhQ3j/rcQ5vtQ05iunM5yAj3lMr4M5amx83co+MQVSJZuapjWagz3R9JbG2Y4JVkX92kNcx8y60oBpeVsV43eIElPEgE+YuTCzi8sxFrx12FGQLcwhmS1JUjWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIV12DNn; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIV12DNn"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88629a452e0so4485272b3a.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791487194; x=1792091994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/xRvvpsSt2FNzWJp1C+ROE9vNYxXKO75+47iMojJNco=;
        b=nIV12DNnTCuCtwGstnNuWBT9AicO/VPjFJOXurDkh0qjsZW+vK89r6Nkn3XCT7wUyT
         BvBi1U5ETky3vAqTktM8NxmJA6V6zASh709MtDbbIsy1XPBxb6+/0OQx1+90qmvmNr7p
         jozLr6j6xdnZO18bDVnfRIaTU7/OuoPvqyNgt8yQqP6rxf7EdmXFci9Vwqvscpa/xxXw
         T8HXouawTITaSRBqi2R2p6DVB4M+VJWhebbc82HIA/2r7SAPgltO83pNX0HnanDjErQ7
         ZRndr0IOc6xkZfWkaLS5bHdlhrnZu8/OjsLWYRKmNq79cgsLejNUmAbxaZLTKlsmgfEr
         ahEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487194; x=1792091994;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xRvvpsSt2FNzWJp1C+ROE9vNYxXKO75+47iMojJNco=;
        b=2YKoHXf5g6evoAQ3DlTrzEWTJXm0X3GnHxy6Yc2NiCNeH+EvD5gs5D4i6qhrrNrxcg
         FyPSk3V4mceNqVlP33tQwP5PYdLid9B1h4pFWy7c71TCknysiX3pIejxBLo4LTK8KcPY
         aAKC0RNlRoq4nYj4ddy/DXL2s2lyHVkA9pbAAtEYIEkyjV/Ab8RdFc7Ee3J6SRBNx0ja
         AAHhBeacjXY1EzIw+0fIe+7eeJyX7pQFtbZzo6h1uYqFWDOeBrHFwo6ZwiynE8ihITB7
         DMPK+ZaRF0i+0NqfsjN+E+umzsNW6prVkh56zDvXLi18mWj80daPfWY5uijTTA3eJsi6
         sR8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxk2+oc/VQNfw8mRs2Y+jIDNFwp/r6rff1cCfUnh7MmIPVW7phIbKXaMGlr77xB4U5uD/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7tppUl2TUTaE7Z4In4gPfWnv+koAhpsrJMLB4RWBoobZR0d5z
	lW3z493gzLpSwzbYUTBddm/gSRPXsHmXHUfp/xUe9XL73Os3od/SoxQ6yBbJgrsfXhn+048EBFC
	EfXvCT81c8ZhBtg==
X-Received: from pfbdh20.prod.google.com ([2002:a05:6a00:4794:b0:887:5ba8:7334])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:331b:b0:881:cbb0:6a9c with SMTP id d2e1a72fcca58-891b167b93cmr6124484b3a.32.1791487194112;
 Thu, 08 Oct 2026 12:19:54 -0700 (PDT)
Date: Thu,  8 Oct 2026 12:19:45 -0700
In-Reply-To: <20260310060022.15120-7-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-7-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008191950.816113-1-jmattson@google.com>
Subject: Re: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 06:00:18AM +0000, Manali Shukla wrote:
> From: Santosh Shukla <santosh.shukla@amd.com>
>
> IBS virtualization (VIBS) allows a guest to collect Instruction-Based
> Sampling (IBS) data using hardware-assisted virtualization. With VIBS
> enabled, the hardware automatically saves and restores guest IBS state
> during VM-Entry and VM-Exit via the VMCB State Save Area.
>
> IBS-generated interrupts are delivered directly to the guest without
> causing a VMEXIT.
>
> VIBS depends on mediated PMU mode and requires either AVIC or NMI
> virtualization for interrupt delivery. However, since AVIC can be
> dynamically inhibited, VIBS requires VNMI to be enabled to ensure
> reliable interrupt delivery. If AVIC is inhibited and VNMI is
> disabled, the guest can encounter a VMEXIT_INVALID when IBS
> virtualization is enabled for the guest.

APM vol. 2, section 15.38, disagrees. Without virtualized interrupt
delivery, "an IBS interrupt occurring in the guest will not be delivered to
either the guest or the hypervisor."  The only VMEXIT_INVALID that section
15.38 describes is for VMRUN of an SEV-ES or SEV-SNP guest with IbsFetchEn
or IbsOpEn set.

> Because IBS state is classified as swap type C, the hypervisor must
> save its own IBS state before VMRUN and restore it after VMEXIT. It
> must also disable IBS before VMRUN and re-enable it afterward. This
> will be handled using mediated PMU support in subsequent patches by
> enabling mediated PMU capability for IBS PMUs.

On hardware with IBS_CAPS_DIS, perf_ibs_stop() does not clear IbsFetchEn or
IbsOpEn. perf_ibs_disable_event() only sets CTL2[Dis], and
IBS_{FETCH|OP}_CTL[En] stays 1. Section 15.38 says that these bits must be
0 at VMRUN of an SEV-ES or SEV-SNP guest with IBS virtualization enabled
(otherwise VMRUN fails with VMEXIT_INVALID), and that they should be 0 for
other guests, "to prevent host IBS interrupts from leaking across a world
switch."  Section 15.38 does not say that CTL2[Dis]=3D1 is sufficient. Is i=
t?
If not, the host must also clear En before VMRUN on hardware with
IBS_CAPS_DIS.

> More details about IBS virtualization can be found at [1].
>
> [1]: https://bugzilla.kernel.org/attachment.cgi?id=3D306250
>      AMD64 Architecture Programmer=E2=80=99s Manual, Vol 2, Section 15.38
>      Instruction-Based Sampling Virtualization.
>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/svm.c     | 73 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 4296efc1dafe..17aa6bf76bce 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -226,6 +226,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area=
 {
>
>  #define SVM_INT_VECTOR_MASK GENMASK(7, 0)
>
> +#define SVM_MISC_ENABLE_V_IBS BIT_ULL(2)
> +

This bit is in misc_ctl2, not misc_ctl. Please name it SVM_MISC2_ENABLE_V_I=
BS
and place it after SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE.

[...]

> @@ -779,6 +782,26 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm=
_vcpu *vcpu)
>  				  MSR_TYPE_RW, intercept);
>  }
>
> +static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
> +{
> +	bool intercept =3D !(guest_cpu_cap_has(vcpu, X86_FEATURE_IBS) &&
> +			   kvm_vcpu_has_mediated_pmu(vcpu));
> +
> +	if (!enable_mediated_pmu || !vibs)
> +		return;
> +
> +	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL, MSR_TYPE_RW, int=
ercept);

For SEV-ES and SEV-SNP guests, section 15.38 says that IBS virtualization
is enabled by bit 12 of SEV_FEATURES in the VMSA, not by bit 2 at offset
B8h in the VMCB. This patch sets only the VMCB bit, but it disables these
intercepts for every vCPU that has X86_FEATURE_IBS and a mediated PMU,
*including* SEV-ES guests.  IBS virtualization is not enabled for SEV-ES
guests, so they will be able to read and write the host's IBS MSRs!

Since nested_vmcb02_prepare_control() does not set SVM_MISC_ENABLE_V_IBS in
vmcb02->control.misc_ctl2, nested SVM has a similar problem. If L1 does not
set INTERCEPT_MSR_PROT in vmcb12, vmcb02 uses vmcb01's msrpm, which
disables these MSR intercepts. Because VIBS is disabled in vmcb02, L2 can
read and write the host's physical IBS MSRs.

OTOH, if L1 sets INTERCEPT_MSR_PROT in vmcb12 and clears the IBS MSR
intercept bits in msrpm12, nested_svm_init_msrpm_merge_offsets() does not
include the IBS MSRs in merge_msrs[], so msrpm02 still intercepts them, and
L0 injects #GP into L2 on accesses to IBS_FETCH_CTL, IBS_OP_CTL, etc.

Furthermore, the guest's IBS state is in the VMCB save area, but userspace
has no way to save or restore it. The IBS MSRs are not in msrs_to_save[],
and svm_get_msr() and svm_set_msr() reject them, so KVM_{GET,SET}_MSRS will
fail. Hence, the IBS state is lost on suspend/resume.

[...]

> @@ -2880,6 +2904,27 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr_info)
>  	case MSR_AMD64_DE_CFG:
>  		msr_info->data =3D svm->msr_decfg;
>  		break;
> +
> +	case MSR_AMD64_IBSCTL:
> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
> +			msr_info->data =3D IBSCTL_LVT_OFFSET_VALID;
> +		else
> +			msr_info->data =3D 0;
> +		break;

Before this patch, KVM synthesized a #GP when a guest without
X86_FEATURE_IBS read MSR_AMD64_IBSCTL. Now it returns 0.

The condition should also test for kvm_vcpu_has_mediated_pmu(vcpu).

> +
> +

Nit: there is an extra blank line above.

> +	/*
> +	 * When IBS virtualization is enabled, guest reads from
> +	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must return 0.
> +	 * This is done for security reasons, as guests should not be allowed t=
o
> +	 * access or infer any information about the system's physical
> +	 * addresses.
> +	 */
> +	case MSR_AMD64_IBSDCPHYSAD:
> +	case MSR_AMD64_IBSFETCHPHYSAD:
> +		msr_info->data =3D 0;
> +		break;
> +

These new cases should be conditional. Before this patch, KVM synthesized
a #GP for a guest without X86_FEATURE_IBS. Now it returns 0.

But, is this even necessary? APM vol. 2, section 15.38, says that when IBS
virtualization is enabled in the VMCB, the processor returns 0 on guest
reads from IbsFetchPhysAd and IbsDcPhysAd and ignores guest writes to
them. Can't we just disable interception of these MSRs when VIBS is enabled
for the vCPU, and let the hardware handle them?

>  	default:
>  		return kvm_get_msr_common(vcpu, msr_info);
>  	}
> @@ -3171,6 +3216,16 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr)
>  		svm->msr_decfg =3D data;
>  		break;
>  	}
> +	/*
> +	 * When IBS virtualization is enabled, guest writes to
> +	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must be ignored.
> +	 * This is done for security reasons, as guests should not be allowed t=
o
> +	 * access or infer any information about the system's physical
> +	 * addresses.
> +	 */
> +	case MSR_AMD64_IBSDCPHYSAD:
> +	case MSR_AMD64_IBSFETCHPHYSAD:
> +		return 1;

Returning 1 does not "ignore" the write; it induces a #GP. But, see the
point I made above.

[...]

> @@ -4678,6 +4733,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vc=
pu *vcpu)
>  	if (guest_cpuid_is_intel_compatible(vcpu))
>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
> +		svm->vmcb->control.misc_ctl2 |=3D SVM_MISC_ENABLE_V_IBS;
> +	else
> +		svm->vmcb->control.misc_ctl2 &=3D ~SVM_MISC_ENABLE_V_IBS;
> +

The condition should also check kvm_vcpu_has_mediated_pmu(vcpu), as in
svm_recalc_ibs_msr_intercepts().
