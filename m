Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430B305692
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493394; cv=none; b=kyzrd5OP02h4qLGB4LJo8quJpaW3i9ub18f8/hZi5off6K+BYpo2kYDaYHp5oJgroAeGAPi9SMoqrwFAdTtNH6dU9fdU+oH0Pj2BU9HZgnmgtUrJr1ip4DUDK/QCiUjFpqKT3IZivwWQsDua4lVBUJhf9CQFUH4X6UnGJQXRllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493394; c=relaxed/simple;
	bh=t2ieJQrtcht1MBXtKQOyzgCt4PPV96gR3S4VFlTqc5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYIdpFsVPrMyu6nqJQPjJ8GuMc1VP3Fd9/TIIw90B60cgFdORFsUAL8cMcD+5rZOnDSt30+DSCsqUF+uwYh2ddsxlsyN0fQlLuevMoTdSQpI06vw9j77gXgBY5e5sYWuXSDLGyq4Fnvv3EZBw3SGZZGRgmiTWXaFkRzoBtwe8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8Xy7lts; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8Xy7lts"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88b59692e0dso4936098b3a.3
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791493389; x=1792098189; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sgPCKft1vy64ZZFc7AuUdXQNAf9SzWxo8H80XNCAJk=;
        b=L8Xy7ltslXxNgy9cvDTxndnOtkNKh2QcX/0jVXUYztbI4WS6AkCXNE/J8i3qyGNxYw
         bO2fAksVc0fuxONLMyT5shpR4PMK15qTkNy76mQBk+Lt03wMc9CwRiTobBxrtDX/7O5J
         KPAvvuHXorAkfJOK1dDxaBIwaD+j25VFUH19JsrgiiM2kDysRJAi5afDoeL+sR/f9UsU
         GJr/2GOOQAF6+O9sut9cfgTE4+HAkW2jHTKetfWKcnTVmAFjL2GtC7rfSDwyS8pTMgGD
         UStZtqpzrhlYANzTpEpPrYdVxs9ducZeORdxZUN/ZY0nSnctfTxMlHjvjgp31IgIvwmi
         ZZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493389; x=1792098189;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sgPCKft1vy64ZZFc7AuUdXQNAf9SzWxo8H80XNCAJk=;
        b=o0HEVbjwA1hMz1iSF1NsprgZALYNe4a+DvcdENJOjw5oPrGAgRiEENpobGDus+z7Hw
         oMSyD2BBprHLsZOEgJvpThr/Zj0LhgRtXwPIrOWdMFqTbb3VYl4kZF0yVPvS+KE2QkT0
         erUE4mQmQrQMAzgODoI31TdwRQhVSi4m5mtcbo7nMch5HowIDhwHOAuxfY/1ucwxZcpA
         M+5j7T3ZPfQb0f87KSHs2jgJPicVJjQuSh5jn9Q9ltNkEeZqb2xKNsOjNF7EDiL7Qf2p
         83QXn0iYTJuBVaseV3Wd/50p/NM3+u0F9GsxDfATFqGx/n52WnjfSbmgwPD+d1NiNpTN
         KO9w==
X-Forwarded-Encrypted: i=1; AKwUvBxW5/TXbAwWZY4gyemwJJyfSVshAXK+FO/0fKnDN0WbcVoZWUDtNqqqKfF3i+QJ0/jTVf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUlnKFQ060A+9sXUCa87Ti/bymlQ09RxQqudYz6sECKTyhAu3B
	iB+m9SAhUdGzu5cMugya/mRI+mUelTI8MupyWh13gzz7I9t2Jyz2D4hYCW+sfyfWyit2IYXHtfr
	P2w6/Ml4KC7SU7w==
X-Received: from pfz17.prod.google.com ([2002:a05:6a00:bb91:b0:891:7f42:7361])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:815:b0:882:bf63:480 with SMTP id d2e1a72fcca58-891b256514cmr6320256b3a.49.1791493388667;
 Thu, 08 Oct 2026 14:03:08 -0700 (PDT)
Date: Thu,  8 Oct 2026 14:03:02 -0700
In-Reply-To: <20260310060022.15120-10-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-10-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008210306.938803-1-jmattson@google.com>
Subject: Re: [PATCH v3 9/9] KVM: SVM: Add newly added IBS capabilities and MSRs
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:21AM +0000, Manali Shukla wrote:
> IBS on upcoming microarch introduced two new control MSRs and a couple of
> new features. Define macros for them. Add these newly added IBS
> capabilities to KVM-only leaf 0x8000001b, so that when IBS feature bit
> is enabled on the guest, these newly added features can be used by
> guests if the hardware and guest os supports it.
>
>  - X86_FEATURE_IBS_DISABLE: Independent IBS disable capability to
>    avoid RMW race
>  - X86_FEATURE_IBS_FETCHLATFIL: Fetch Latency filtering
>  - X86_FEATURE_IBS_ADDRFILTER: Address Bit 63 based filtering
>  - X86_FEATURE_IBS_STRMST_RMTSOCKET: Streaming store filter and
>    indicator. Remote socket indicator.
>  - X86_FEATURE_IBS_BUFFER1: IBS buffering v1
>  - X86_FEATURE_IBS_MEMPROFILER: IBS memory profiler

APM vol. 2 (rev. 3.45), section 13.3.7, says, "Hardware virtualization and
IBS Buffering are not supported for IBS Memory Profiler Version 1."
Moreover, the memory profiler requires additional MSRs
(C001_0380h-C001_0386h), which are not in the list of IBS virtualization
state in section 15.38.

KVM should not advertise X86_FEATURE_IBS_MEMPROFILER.

IBS buffering *is* virtualized (IBS_BUFFER_BASE, IBS_BUFFER_SIZE, and
IBS_BUFFER_TAIL at offsets 7D8h-7E4h in Table B-2). However, this series
does not add these fields to struct vmcb_save_area, and it does not disable
interception of MSRs C001_0390h-C001_0392h. svm_get_msr() and svm_set_msr()
do not emulate these MSRs, so a guest cannot really use IBS buffering.

KVM should not advertise X86_FEATURE_IBS_BUFFER1.

> Extend VMCB save area to include to the newly added MSRs:
> MSR_AMD64_IBSFETCHCTL2 and MSR_AMD64_IBSOPCTL2.

s/include to/include/

As with the other IBS MSRs (see my comment on patch 6/9), svm_get_msr() and
svm_set_msr() do not handle IBS_FETCH_CTL2 and IBS_OP_CTL2, which breaks
KVM_{GET,SET}_MSRS and KVM_FEP. (And to correct what I wrote on patch 6/9:
even if we disable interception of MSR_AMD64_IBSFETCHPHYSAD and
MSR_AMD64_IBSDCPHYSAD so that hardware handles native guest accesses,
svm_get_msr() and svm_set_msr() still must handle those two MSRs as well,
for KVM_FEP if nothing else.)

> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---

[...]

> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 22cfdb331e9e..1af2ba207b8a 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -89,6 +89,12 @@
>  #define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
>  #define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
>  #define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
> +#define X86_FEATURE_IBS_DISABLE			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 13)
> +#define X86_FEATURE_IBS_FETCHLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 14)
> +#define X86_FEATURE_IBS_ADDRFILTER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 15)
> +#define X86_FEATURE_IBS_STRMST_RMTSOCKET	KVM_X86_FEATURE(CPUID_8000_001B_EAX, 16)
> +#define X86_FEATURE_IBS_BUFFER1			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 17)
> +#define X86_FEATURE_IBS_MEMPROFILER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 18)

Three of these names are different from the IBS_CAPS_* names for the same
bits in asm/perf_event.h: IBS_DISABLE (IBS_CAPS_DIS), IBS_FETCHLATFIL
(IBS_CAPS_FETCHLAT), and IBS_ADDRFILTER (IBS_CAPS_BIT63_FILTER). Please
standardize on the existing names.

>  #define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)
>
>  struct cpuid_reg {
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 421a929398da..9bf0d5f66239 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -800,6 +800,13 @@ static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSDCLINAD, MSR_TYPE_RW, intercept);
>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSBRTARGET, MSR_TYPE_RW, intercept);
>  	svm_set_intercept_for_msr(vcpu, MSR_AMD64_ICIBSEXTDCTL, MSR_TYPE_RW, intercept);
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS_DISABLE)) {
> +		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL2, MSR_TYPE_RW,
> +				intercept);
> +		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPCTL2, MSR_TYPE_RW,
> +				intercept);
> +	}

First, this function never re-enables the intercepts for
MSR_AMD64_IBSFETCHCTL2 and MSR_AMD64_IBSOPCTL2. If KVM_RUN recalculates the
intercepts but returns to userspace before VMRUN (e.g. due to a pending
signal), userspace can still clear X86_FEATURE_IBS_DISABLE with
KVM_SET_CPUID2, and the intercepts stay disabled. Call
svm_set_intercept_for_msr() unconditionally with the computed intercept
state, as svm_recalc_pmu_msr_intercepts() does.

Second, IbsDis (bit 13) is not the only CPUID bit that enumerates fields in
these MSRs. Per APM vol. 2 (rev. 3.45), section 13.3:

- IbsFetchCtl2[IbsFetchLatFilter] depends on IbsFetchLatencyFiltering
  (bit 14).

- IbsFetchCtl2[IbsFetchExclAddr63Eq{0,1}] and IbsOpCtl2[IbsOpExclRip63Eq{0,1}]
  depend on IbsAddrBit63Filtering (bit 15).

- IbsOpCtl2[IbsOpStrmStFilter] depends on IbsStrmStAndRmtSocket (bit 16).

The Linux IBS driver already uses these MSRs for IBS_CAPS_BIT63_FILTER
without IBS_CAPS_DIS (see perf_ibs_init()). If userspace gives the guest
any of bits 14-16 without bit 13, these MSRs stay intercepted,
svm_set_msr() rejects the guest's writes, and KVM synthesizes a #GP.
