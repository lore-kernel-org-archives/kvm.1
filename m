Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362068;
	b=MT2mVtRl8lFUZGWks0q5AcDXtawSbUdc2fg0pEqFpLxUElIucw2tL3nbio0FOJzSG1T+
	 XkibJFphrhGCfd3ikRp5QkyAOXEjph6VP+IiZZkjnRSsQqLGoPfHkxcrV1q0VjbQXtDCj
	 45j8Mjxra0szo1rspGRcH+QyLh7EQiOvb5gnkofkTdut2e5bBs3vRdeePDjRgEbnsl+wo
	 4QLFFfGxHWlp8KF0wOAhq8sgzERAlD0Gw6vqA8zMpGfEZF6PJteFeHwF43kbQiQBWHGUO
	 UXVbKl2VQhUisXh69UkFHn1zIf7YSrqVn5+/6knuDTcdYkQDmUM7Zm3SN2Gl+5T4fBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pyzd/Rxzfr6f6uq9dgXtYp69Oa4J91RQQWIaiAHZWTc=;
	b=JajMTsPyGJYCP+dnhZBc1qb7Ppnq7HOpMkpIk6KnV7Xt3+EXkt4m1ZpPN3Ebq/n58xdv
	 nS3Gmr8edqxeR3YZGVmZTUTBkmk7BsTiuE9U+z/bRorc1keaOVNPekrxJZ+mlWXlgQwlk
	 uN5hJnQTp3G44XEIlWOPhX0a4m9GnEU+ESE8joYiHEMcwwetCEXxixM6jPKF/xl1kSP9k
	 Gzgs5+EBrXvZzbXFNTQYskqqJKTbpIsdsCXKDl739P7ztMvrk8mASYSozjVvi54zCSKS6
	 LG9L4wp82L/R7sqa4/cWg9/rjd5340zmBpkCq2hm4f5RLxxEkh4zTJ0s/AaWIrbtmIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TECUv+Fe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96E606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 01:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B96E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TECUv+Fe
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-854e904005cso1701336a34.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:54:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362066; cv=none;
        d=google.com; s=arc-20260327;
        b=Tu+Bv2zHn1s4feYZ+kjJ/ugzryz1/ahOKKnjl1b9JUvZQS29GvMee69Sx5I39muY6Q
         YJem1OusBmiFRvjYCjjc/y/2/xL2awr3Dhw8wRWLx2HL2QyStVeh0T0qthIblau3NzBU
         gjBZ/tUGQz2kpPxLdQKyC7IdZsaHXzcho4ZOe5SVPGlRCutLsROeF8skU17KHM3qlGZJ
         3vSQjOZs0e7wJfxk4DYJktj7R/9AyJmdEv19voMX6aST3oh/agOHPqRUqluanUy+Olbf
         5BkRQJAfXF/65z7EEpVldw3HGcBo4/erquqa7GZczA2Xqchw+3UWmSJ6F6PuTxJ66rtg
         INkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pyzd/Rxzfr6f6uq9dgXtYp69Oa4J91RQQWIaiAHZWTc=;
        fh=0KjNddDidqk82StotSE0eL9WwvX5F89OFYDe+4OwmHg=;
        b=FvHw1Dgllu41XlzhidZNoslmWULnmqu956IlkiszLnVypXvPCuxtVMl63unSP6SXbk
         /wk0uMYvELxgBT0s3AUnmBWAmXWCTpAPTYNwj+MpVwuW4F/8nTFY+IDMK/fZf6BJ7KP8
         lcu/Si61+IgrOKGs3uVc66EsvU+kboPUla1qH/9GxRcJPnBw084x+lgyyDTLbKCKtXq+
         Y7HV5Dlr1LBEnT3b+7rxirUme7WBq/Rw1qgKOsVBKke00owt2Zu/+oobOzUTdUMnUG/X
         rg9eLxTo8BajDsFSnGaKnDASbvtSLnQlMmdOPFYV1KYA8UnZbyBGBSbBihCtw/0Gwpfa
         A0Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362066; x=1794966866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pyzd/Rxzfr6f6uq9dgXtYp69Oa4J91RQQWIaiAHZWTc=;
        b=TECUv+Few4FU688ar+qqPISrzOI19MuiElp5FzxTU0T/e2FzbFelNNISrbrUhAYW78
         CVpoRMt7pgseXBb7FUggHMVbUSo35ZX1lMDeSHH9fcvrNcvaxVXmONmea3/qyn/hCkEl
         6hulLAs5hwLtNc5JX7XvsSZ0l+MAXlTDi+KSPib9LuHCMKGpM/18DLJOmtZs778O/MoG
         rkMFywFhc6yEAgL/pTplguLyzZIpk1kPzVTKenshMhvEgMflRw1BjqOwbHA5+/F1cqyB
         +KibwYJzA9SU3Pfrq3rE4y7h9X0zAX4z/hFr+mi8T1WnKJ2uLrgIl82SScskCHwVMtfg
         LwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362066; x=1794966866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pyzd/Rxzfr6f6uq9dgXtYp69Oa4J91RQQWIaiAHZWTc=;
        b=puFKR1q9nHXFWiP7i7w2gyQKEnCDQUczVFUbGvLFZVaCdottkUmL09DALRg/7SSSDQ
         ftlJIOI3s6c5xcPe88VuXSll/82422eQK9/fs8hlelhZv+GCnEIpGUEj8zPG2T82UQHq
         l0iN8DhSbDlkKlR1aPW0qlaU+NO5pqxaTO/G22za+IDypvAYpziUVxQVkKvO3AVnH1/h
         M2OKRNwGCBMeuapgDqIufclTFAplvkAv47RMcvwvVuduRXLleD1v8F9/BTkxS9IEDe6B
         0UFEy+FeJskiQiePR63560el42KzvEQY2geqlOLfpcwgCs3c1XRDLKiqNWqgH1Vw1Z5+
         2TYg==
X-Forwarded-Encrypted: i=1; AL+hErFVxORemW86fHf7huzcQ41W8JTBW5RxRZOFTouh4QU9X6mwTbgua3Qx8gI/vLEPp6N5GMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CzSNCER/drIuyMcrJLU+yBJtAjHIBCnZK4uvbkCOWd39id9dQ
	LhTuJwStU0IcBRFBw/Cu9iJjzI9K2a+JQdeEmddkTzTDvRc31wLqX3p1RmpN4UlkUA36F2DSylM
	1RQob2gwwi3Pv41P33OPcm8MHKf/NQ0g=
X-Gm-Gg: AYBFou2ooxmtYxe/XQJZna90U04xQK3ghJSIBC19SK4HuUnhB0Mf3Ob9q8J1ExO7jWr
	rzxglDuER8amAiSAM7oNpMMpeRI+l4pLXOCHlVTjlApzcmHIrLHyEvjctufde+IQQjo4+afszEJ
	b/kY4rs6tEYnsuwiGu6zo53cQ5/1OEPkbr3krqZZIBFzsnAqi8PGiTIyQE/S4G5Lf2tpxJS8eKc
	oXlVULpgaQzMsj0Cx7y/jeiCH5MCymNiTx93ISl1NO5+8i1p7juvXWJ1G5ofKbr2ilSIcYNzO82
	F2LqhjYzulgQapv2QK8d6yz1lrFr/dYL8+tJebw/mLB8+0S3AfLWD+8XDdBL7+Aul8yKrWQeQCK
	4x1TgDhifWEzo1Wg7SMo5xHN8EUx3VaudUs1M9w==
X-Received: by 2002:a05:6820:1342:b0:6fa:3c7:8798 with SMTP id
 006d021491bc7-71915cae43bmr841227eaf.56.1794362065878; Tue, 10 Nov 2026
 17:54:25 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106073417.86867-1-flyingpeng@tencent.com> <au4Cv1pjFp_7rmlT@google.com>
In-Reply-To: <au4Cv1pjFp_7rmlT@google.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Wed, 11 Nov 2026 09:54:13 +0800
X-Gm-Features: AclHuK_o3A5R9i6xCnyBT0twKyVocTiAev9X_a68PvnnKiKJS7UCBBrAE9Xh7ug
Message-ID: <CAPm50aK5cpfGqrvXe8qFnp+ED3DjHoNwBfwAm9nR0sCrbMT0ZQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Allocate struct pt_desc only when PT is
 virtualized for guests
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 12:39=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Nov 06, 2026, Peng Hao wrote:
> > struct pt_desc is only used when pt_mode is PT_MODE_HOST_GUEST, so
> > allocate it on demand instead of embedding it in struct vcpu_vmx.
> >
> > This shrinks struct vcpu_vmx from 8384 to 8128 bytes.
>
> Hrm, I don't think I want to do this to save "only" 256 bytes.  I assume =
the goal
> is to get back down to an order-1 allocation, but vcpu_vmx is sooo close =
that
> shaving off 256 bytes is only going to keep it order-1 for a kernel relea=
se or two.
>
> And for "full" configs, e.g. with Xen support, vcpu_vmx is ~9088 bytes.
>
> If we want to get vCPUs back to order-1 allocation with any chance of kee=
ping them
> there, I think we need to aim for ~6-7 KiB, but without adding unnecessar=
y layers
> of indirection.  E.g. kvm_vcpu.stats is a whopping 1104 bytes, but it's a=
ccessed in
> a ton of hot paths, so I wouldn't want to allocate that separately.  Simi=
larly,
> we could dynamically allocate vcpu_vmx.nested, but I don't know that I'd =
want to
> add that extra pointer chase just to get at a variety of flags.
>
> Potential ideas:
>
>   1. vcpu_vmx.rmode (208) - In practice, it's only used by CPUs launched =
before
>      Westmere (2010), and like PT, it's guarded by a module param so it's=
 easy to
>      dynamically allocate.
>
>   2. kvm_vcpu_arch.pmu (912) - Can be allocated if and only if the vCPU h=
as a PMU,
>      e.g. in kvm_pmu_refresh(), or based on the module param.  I'd be som=
ehwat
>      worried about regressing hot paths though.  On the other hand, we co=
uld throw
>      pt_desc and lbr_desc into kvm_pmu to get a total of 1208 bytes in sa=
vings.
>
>   3. kvm_vcpu_arch.xen (680) - Only impacts a limited set of configs, but=
 at a
>      glance, this one would be trivially easy to convert, and if distros =
enable
>      CONFIG_KVM_XEN, would provide meaningful savings for a lot of deploy=
ments.
>
>   4. kvm_vcpu_arch.apf.gfns (512) - Would need to be unconditionally allo=
cated,
>      but its power-of-2 size makes it well suited for a kmem cache, and f=
or many,
>      many VMs, this will almost never be used.
>
> If we did all of the above, that would save 2608 bytes for CONFIG_KVM_XEN=
=3Dy and
> 1928 bytes for CONFIG_KVM_XEN=3Dn.  That would put vcpu_vmx around 6.4KiB=
, which
> would give us some room before we cross the order-1 boundary (again).
>
> The other option for pt_desc in particular would be to simply rip out all=
 of the
> code, as it's been buried behind CONFIG_BROKEN=3Dy for a few years now.
>
> Actually, duh, the less committing thing to do is to compile out the code=
.  I
> think it'd still be worth doing at least some of the above changes, but h=
ard
> disabling PT virtualization seems like a no brainer.  E.g. over a few pat=
ches to
> isolate the code movement.  I'll post a miniseries.
>

For context on why I went with dynamic allocation: since commit aa0d42cacf0=
9
("KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind
CONFIG_BROKEN"), pt_mode can only be changed with CONFIG_BROKEN=3Dy, but th=
e PT
code and pt_desc are still built unconditionally.  I took that as the inten=
ded
state and only tried to avoid paying for pt_desc when it can't be used, so =
I
 didn't consider adding a dedicated Kconfig.  Splitting it back out into
 CONFIG_KVM_INTEL_PT as you did solves the problem more simply.

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1719059570fb..243307328adf 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -151,6 +151,9 @@ config KVM_INTEL_TDX
>
>           If unsure, say N.
>
> +config KVM_INTEL_PT
> +       def_bool y if BROKEN
> +
>  config KVM_AMD
>         tristate "KVM for AMD processors support"
>         depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index e91650af44c2..a69020c01afd 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -2596,6 +2596,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>                 if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
>                         return;
>                 break;
> +#ifdef CONFIG_KVM_INTEL_PT
>         case MSR_IA32_RTIT_CTL:
>         case MSR_IA32_RTIT_STATUS:
>                 if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
> @@ -2619,6 +2620,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>                      intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) =
* 2))
>                         return;
>                 break;
> +#endif
>         case MSR_ARCH_PERFMON_PERFCTR0 ...
>              MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>                 if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=3D
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilit=
ies.h
> index 810119167f79..604cc376ca5a 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -17,11 +17,16 @@ extern bool __read_mostly enable_ept_ad_bits;
>  extern bool __read_mostly enable_cet;
>  extern bool __read_mostly enable_pml;
>  extern bool __read_mostly enable_mbec;
> -extern int __read_mostly pt_mode;
>
>  #define PT_MODE_SYSTEM         0
>  #define PT_MODE_HOST_GUEST     1
>
> +#ifdef CONFIG_KVM_INTEL_PT
> +extern int __read_mostly pt_mode;
> +#else
> +#define pt_mode                        PT_MODE_SYSTEM
> +#endif
> +
>  struct nested_vmx_msrs {
>         /*
>          * We only store the "true" versions of the VMX capability MSRs. =
We
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index f0d75f5a968c..4bc0c1b743d8 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5455,10 +5455,12 @@ static int enter_vmx_operation(struct kvm_vcpu *v=
cpu)
>         vmx->nested.vmcs02_initialized =3D false;
>         vmx->nested.vmxon =3D true;
>
> +#ifdef CONFIG_KVM_INTEL_PT
>         if (vmx_pt_mode_is_host_guest()) {
>                 vmx->pt_desc.guest.ctl =3D 0;
>                 pt_update_intercept_for_msr(vcpu);
>         }
> +#endif
>
>         return 0;
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e6a61514e797..bd1ea5f16c78 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -210,8 +210,8 @@ static unsigned int ple_window_max        =3D KVM_VMX=
_DEFAULT_PLE_WINDOW_MAX;
>  module_param(ple_window_max, uint, 0444);
>
>  /* Default is SYSTEM mode, 1 for host-guest mode (which is BROKEN) */
> +#ifdef CONFIG_KVM_INTEL_PT
>  int __read_mostly pt_mode =3D PT_MODE_SYSTEM;
> -#ifdef CONFIG_BROKEN
>  module_param(pt_mode, int, S_IRUGO);
>  #endif
>
> @@ -1231,6 +1231,165 @@ static unsigned long segment_base(u16 selector)
>  }
>  #endif
>
> +#ifdef CONFIG_KVM_INTEL_PT
> +static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
> +{
> +       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +       unsigned long value;
> +
> +       /*
> +        * Any MSR write that attempts to change bits marked reserved wil=
l
> +        * case a #GP fault.
> +        */
> +       if (data & vmx->pt_desc.ctl_bitmask)
> +               return 1;
> +
> +       /*
> +        * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
> +        * result in a #GP unless the same write also clears TraceEn.
> +        */
> +       if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> +           (data & RTIT_CTL_TRACEEN) &&
> +           data !=3D vmx->pt_desc.guest.ctl)
> +               return 1;
> +
> +       /*
> +        * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
> +        * and FabricEn would cause #GP, if
> +        * CPUID.(EAX=3D14H, ECX=3D0):ECX.SNGLRGNOUT[bit 2] =3D 0
> +        */
> +       if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
> +               !(data & RTIT_CTL_FABRIC_EN) &&
> +               !intel_pt_validate_cap(vmx->pt_desc.caps,
> +                                       PT_CAP_single_range_output))
> +               return 1;
> +
> +       /*
> +        * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write =
that
> +        * utilize encodings marked reserved will cause a #GP fault.
> +        */
> +       value =3D intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_per=
iods);
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
> +                       !test_bit((data & RTIT_CTL_MTC_RANGE) >>
> +                       RTIT_CTL_MTC_RANGE_OFFSET, &value))
> +               return 1;
> +       value =3D intel_pt_validate_cap(vmx->pt_desc.caps,
> +                                               PT_CAP_cycle_thresholds);
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
> +                       !test_bit((data & RTIT_CTL_CYC_THRESH) >>
> +                       RTIT_CTL_CYC_THRESH_OFFSET, &value))
> +               return 1;
> +       value =3D intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_per=
iods);
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
> +                       !test_bit((data & RTIT_CTL_PSB_FREQ) >>
> +                       RTIT_CTL_PSB_FREQ_OFFSET, &value))
> +               return 1;
> +
> +       /*
> +        * If ADDRx_CFG is reserved or the encodings is >2 will
> +        * cause a #GP fault.
> +        */
> +       value =3D (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
> +       if ((value && (vmx->pt_desc.num_address_ranges < 1)) || (value > =
2))
> +               return 1;
> +       value =3D (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
> +       if ((value && (vmx->pt_desc.num_address_ranges < 2)) || (value > =
2))
> +               return 1;
> +       value =3D (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
> +       if ((value && (vmx->pt_desc.num_address_ranges < 3)) || (value > =
2))
> +               return 1;
> +       value =3D (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
> +       if ((value && (vmx->pt_desc.num_address_ranges < 4)) || (value > =
2))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +       struct kvm_cpuid_entry2 *best =3D NULL;
> +       int i;
> +
> +       for (i =3D 0; i < PT_CPUID_LEAVES; i++) {
> +               best =3D kvm_find_cpuid_entry_index(vcpu, 0x14, i);
> +               if (!best)
> +                       return;
> +               vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] =3D be=
st->eax;
> +               vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] =3D be=
st->ebx;
> +               vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] =3D be=
st->ecx;
> +               vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] =3D be=
st->edx;
> +       }
> +
> +       /* Get the number of configurable Address Ranges for filtering */
> +       vmx->pt_desc.num_address_ranges =3D intel_pt_validate_cap(vmx->pt=
_desc.caps,
> +                                               PT_CAP_num_address_ranges=
);
> +
> +       /* Initialize and clear the no dependency bits */
> +       vmx->pt_desc.ctl_bitmask =3D ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
> +                       RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC=
 |
> +                       RTIT_CTL_BRANCH_EN);
> +
> +       /*
> +        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[0]=3D1 CR3Filter can be set o=
therwise
> +        * will inject an #GP
> +        */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_cr3_filtering=
))
> +               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_CR3EN;
> +
> +       /*
> +        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[1]=3D1 CYCEn, CycThresh and
> +        * PSBFreq can be set
> +        */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc))
> +               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_CYCLEACC |
> +                               RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
> +
> +       /*
> +        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[3]=3D1 MTCEn and MTCFreq can =
be set
> +        */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc))
> +               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_MTC_EN |
> +                                             RTIT_CTL_MTC_RANGE);
> +
> +       /* If CPUID.(EAX=3D14H,ECX=3D0):EBX[4]=3D1 FUPonPTW and PTWEn can=
 be set */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_ptwrite))
> +               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_FUP_ON_PTW |
> +                                                       RTIT_CTL_PTW_EN);
> +
> +       /* If CPUID.(EAX=3D14H,ECX=3D0):EBX[5]=3D1 PwrEvEn can be set */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_power_event_t=
race))
> +               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_PWR_EVT_EN;
> +
> +       /* If CPUID.(EAX=3D14H,ECX=3D0):ECX[0]=3D1 ToPA can be set */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
> +               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_TOPA;
> +
> +       /* If CPUID.(EAX=3D14H,ECX=3D0):ECX[3]=3D1 FabricEn can be set */
> +       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys=
))
> +               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_FABRIC_EN;
> +
> +       /* unmask address range configure area */
> +       for (i =3D 0; i < vmx->pt_desc.num_address_ranges; i++)
> +               vmx->pt_desc.ctl_bitmask &=3D ~(0xfULL << (32 + i * 4));
> +}
> +
> +void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +       bool flag =3D !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
> +       u32 i;
> +
> +       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_STATUS, MSR_TYPE_RW=
, flag);
> +       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_BASE, MSR_TY=
PE_RW, flag);
> +       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_MASK, MSR_TY=
PE_RW, flag);
> +       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_CR3_MATCH, MSR_TYPE=
_RW, flag);
> +       for (i =3D 0; i < vmx->pt_desc.num_address_ranges; i++) {
> +               vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_A + i=
 * 2, MSR_TYPE_RW, flag);
> +               vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_B + i=
 * 2, MSR_TYPE_RW, flag);
> +       }
> +}
> +
>  static inline bool pt_can_write_msr(struct vcpu_vmx *vmx)
>  {
>         return vmx_pt_mode_is_host_guest() &&
> @@ -1306,6 +1465,25 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
>                 wrmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
>  }
>
> +static unsigned int vmx_handle_intel_pt_intr(void)
> +{
> +       struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
> +
> +       /* '0' on failure so that the !PT case can use a RET0 static call=
. */
> +       if (!vcpu || !kvm_handling_nmi_from_guest(vcpu))
> +               return 0;
> +
> +       kvm_make_request(KVM_REQ_PMI, vcpu);
> +       __set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
> +                 (unsigned long *)&vcpu->arch.pmu.global_status);
> +       return 1;
> +}
> +#else
> +static void pt_guest_enter(struct vcpu_vmx *vmx) { }
> +static void pt_guest_exit(struct vcpu_vmx *vmx) { }
> +static void update_intel_pt_cfg(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1)=
; }
> +#endif /* CONFIG_KVM_INTEL_PT */
> +
>  void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs=
_sel,
>                         unsigned long fs_base, unsigned long gs_base)
>  {
> @@ -1708,79 +1886,6 @@ void vmx_set_interrupt_shadow(struct kvm_vcpu *vcp=
u, int mask)
>                 vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibilit=
y);
>  }
>
> -static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
> -{
> -       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> -       unsigned long value;
> -
> -       /*
> -        * Any MSR write that attempts to change bits marked reserved wil=
l
> -        * case a #GP fault.
> -        */
> -       if (data & vmx->pt_desc.ctl_bitmask)
> -               return 1;
> -
> -       /*
> -        * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
> -        * result in a #GP unless the same write also clears TraceEn.
> -        */
> -       if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> -           (data & RTIT_CTL_TRACEEN) &&
> -           data !=3D vmx->pt_desc.guest.ctl)
> -               return 1;
> -
> -       /*
> -        * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
> -        * and FabricEn would cause #GP, if
> -        * CPUID.(EAX=3D14H, ECX=3D0):ECX.SNGLRGNOUT[bit 2] =3D 0
> -        */
> -       if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
> -               !(data & RTIT_CTL_FABRIC_EN) &&
> -               !intel_pt_validate_cap(vmx->pt_desc.caps,
> -                                       PT_CAP_single_range_output))
> -               return 1;
> -
> -       /*
> -        * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write =
that
> -        * utilize encodings marked reserved will cause a #GP fault.
> -        */
> -       value =3D intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_per=
iods);
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
> -                       !test_bit((data & RTIT_CTL_MTC_RANGE) >>
> -                       RTIT_CTL_MTC_RANGE_OFFSET, &value))
> -               return 1;
> -       value =3D intel_pt_validate_cap(vmx->pt_desc.caps,
> -                                               PT_CAP_cycle_thresholds);
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
> -                       !test_bit((data & RTIT_CTL_CYC_THRESH) >>
> -                       RTIT_CTL_CYC_THRESH_OFFSET, &value))
> -               return 1;
> -       value =3D intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_per=
iods);
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
> -                       !test_bit((data & RTIT_CTL_PSB_FREQ) >>
> -                       RTIT_CTL_PSB_FREQ_OFFSET, &value))
> -               return 1;
> -
> -       /*
> -        * If ADDRx_CFG is reserved or the encodings is >2 will
> -        * cause a #GP fault.
> -        */
> -       value =3D (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
> -       if ((value && (vmx->pt_desc.num_address_ranges < 1)) || (value > =
2))
> -               return 1;
> -       value =3D (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
> -       if ((value && (vmx->pt_desc.num_address_ranges < 2)) || (value > =
2))
> -               return 1;
> -       value =3D (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
> -       if ((value && (vmx->pt_desc.num_address_ranges < 3)) || (value > =
2))
> -               return 1;
> -       value =3D (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
> -       if ((value && (vmx->pt_desc.num_address_ranges < 4)) || (value > =
2))
> -               return 1;
> -
> -       return 0;
> -}
> -
>  int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
>                                   void *insn, int insn_len)
>  {
> @@ -2130,7 +2235,6 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>  {
>         struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>         struct vmx_uret_msr *msr;
> -       u32 index;
>
>         switch (msr_info->index) {
>  #ifdef CONFIG_X86_64
> @@ -2216,6 +2320,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                                                         &msr_info->data);
>  #endif
>                 break;
> +#ifdef CONFIG_KVM_INTEL_PT
>         case MSR_IA32_RTIT_CTL:
>                 if (!vmx_pt_mode_is_host_guest())
>                         return 1;
> @@ -2251,8 +2356,9 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                         return 1;
>                 msr_info->data =3D vmx->pt_desc.guest.output_mask;
>                 break;
> -       case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
> -               index =3D msr_info->index - MSR_IA32_RTIT_ADDR0_A;
> +       case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
> +               u32 index =3D msr_info->index - MSR_IA32_RTIT_ADDR0_A;
> +
>                 if (!vmx_pt_mode_is_host_guest() ||
>                     (index >=3D 2 * vmx->pt_desc.num_address_ranges))
>                         return 1;
> @@ -2261,6 +2367,8 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                 else
>                         msr_info->data =3D vmx->pt_desc.guest.addr_a[inde=
x / 2];
>                 break;
> +       }
> +#endif
>         case MSR_IA32_S_CET:
>                 msr_info->data =3D vmcs_readl(GUEST_S_CET);
>                 break;
> @@ -2339,7 +2447,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>         int ret =3D 0;
>         u32 msr_index =3D msr_info->index;
>         u64 data =3D msr_info->data;
> -       u32 index;
>
>         switch (msr_index) {
>         case MSR_EFER:
> @@ -2529,6 +2636,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                 if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
>                         return 1;
>                 return vmx_set_vmx_msr(vcpu, msr_index, data);
> +#ifdef CONFIG_KVM_INTEL_PT
>         case MSR_IA32_RTIT_CTL:
>                 if (!vmx_pt_mode_is_host_guest() ||
>                         vmx_rtit_ctl_check(vcpu, data) ||
> @@ -2575,7 +2683,9 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                         return 1;
>                 vmx->pt_desc.guest.output_mask =3D data;
>                 break;
> -       case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
> +       case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
> +               u32 index;
> +
>                 if (!pt_can_write_msr(vmx))
>                         return 1;
>                 index =3D msr_info->index - MSR_IA32_RTIT_ADDR0_A;
> @@ -2588,6 +2698,8 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>                 else
>                         vmx->pt_desc.guest.addr_a[index / 2] =3D data;
>                 break;
> +       }
> +#endif
>         case MSR_IA32_S_CET:
>                 vmcs_writel(GUEST_S_CET, data);
>                 break;
> @@ -4222,22 +4334,6 @@ static void vmx_update_msr_bitmap_x2apic(struct kv=
m_vcpu *vcpu)
>         }
>  }
>
> -void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
> -{
> -       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> -       bool flag =3D !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
> -       u32 i;
> -
> -       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_STATUS, MSR_TYPE_RW=
, flag);
> -       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_BASE, MSR_TY=
PE_RW, flag);
> -       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_MASK, MSR_TY=
PE_RW, flag);
> -       vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_CR3_MATCH, MSR_TYPE=
_RW, flag);
> -       for (i =3D 0; i < vmx->pt_desc.num_address_ranges; i++) {
> -               vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_A + i=
 * 2, MSR_TYPE_RW, flag);
> -               vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_B + i=
 * 2, MSR_TYPE_RW, flag);
> -       }
> -}
> -
>  static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  {
>         u64 vm_exit_controls_bits =3D VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL =
|
> @@ -4997,12 +5093,14 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
>
>         vmx_write_encls_bitmap(vcpu, NULL);
>
> +#ifdef CONFIG_KVM_INTEL_PT
>         if (vmx_pt_mode_is_host_guest()) {
>                 memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
>                 /* Bit[6~0] are forced to 1, writes are ignored. */
>                 vmx->pt_desc.guest.output_mask =3D 0x7F;
>                 vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
>         }
> +#endif
>
>         vmcs_write32(GUEST_SYSENTER_CS, 0);
>         vmcs_writel(GUEST_SYSENTER_ESP, 0);
> @@ -7758,75 +7856,6 @@ static void nested_vmx_cr_fixed1_bits_update(struc=
t kvm_vcpu *vcpu)
>  #undef cr4_fixed1_update
>  }
>
> -static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> -{
> -       struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> -       struct kvm_cpuid_entry2 *best =3D NULL;
> -       int i;
> -
> -       for (i =3D 0; i < PT_CPUID_LEAVES; i++) {
> -               best =3D kvm_find_cpuid_entry_index(vcpu, 0x14, i);
> -               if (!best)
> -                       return;
> -               vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] =3D be=
st->eax;
> -               vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] =3D be=
st->ebx;
> -               vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] =3D be=
st->ecx;
> -               vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] =3D be=
st->edx;
> -       }
> -
> -       /* Get the number of configurable Address Ranges for filtering */
> -       vmx->pt_desc.num_address_ranges =3D intel_pt_validate_cap(vmx->pt=
_desc.caps,
> -                                               PT_CAP_num_address_ranges=
);
> -
> -       /* Initialize and clear the no dependency bits */
> -       vmx->pt_desc.ctl_bitmask =3D ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
> -                       RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC=
 |
> -                       RTIT_CTL_BRANCH_EN);
> -
> -       /*
> -        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[0]=3D1 CR3Filter can be set o=
therwise
> -        * will inject an #GP
> -        */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_cr3_filtering=
))
> -               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_CR3EN;
> -
> -       /*
> -        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[1]=3D1 CYCEn, CycThresh and
> -        * PSBFreq can be set
> -        */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc))
> -               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_CYCLEACC |
> -                               RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
> -
> -       /*
> -        * If CPUID.(EAX=3D14H,ECX=3D0):EBX[3]=3D1 MTCEn and MTCFreq can =
be set
> -        */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc))
> -               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_MTC_EN |
> -                                             RTIT_CTL_MTC_RANGE);
> -
> -       /* If CPUID.(EAX=3D14H,ECX=3D0):EBX[4]=3D1 FUPonPTW and PTWEn can=
 be set */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_ptwrite))
> -               vmx->pt_desc.ctl_bitmask &=3D ~(RTIT_CTL_FUP_ON_PTW |
> -                                                       RTIT_CTL_PTW_EN);
> -
> -       /* If CPUID.(EAX=3D14H,ECX=3D0):EBX[5]=3D1 PwrEvEn can be set */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_power_event_t=
race))
> -               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_PWR_EVT_EN;
> -
> -       /* If CPUID.(EAX=3D14H,ECX=3D0):ECX[0]=3D1 ToPA can be set */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
> -               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_TOPA;
> -
> -       /* If CPUID.(EAX=3D14H,ECX=3D0):ECX[3]=3D1 FabricEn can be set */
> -       if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys=
))
> -               vmx->pt_desc.ctl_bitmask &=3D ~RTIT_CTL_FABRIC_EN;
> -
> -       /* unmask address range configure area */
> -       for (i =3D 0; i < vmx->pt_desc.num_address_ranges; i++)
> -               vmx->pt_desc.ctl_bitmask &=3D ~(0xfULL << (32 + i * 4));
> -}
> -
>  void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> @@ -8471,20 +8500,6 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu,=
 gva_t gva, unsigned int flags
>         return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_=
ULL(63));
>  }
>
> -static unsigned int vmx_handle_intel_pt_intr(void)
> -{
> -       struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
> -
> -       /* '0' on failure so that the !PT case can use a RET0 static call=
. */
> -       if (!vcpu || !kvm_handling_nmi_from_guest(vcpu))
> -               return 0;
> -
> -       kvm_make_request(KVM_REQ_PMI, vcpu);
> -       __set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
> -                 (unsigned long *)&vcpu->arch.pmu.global_status);
> -       return 1;
> -}
> -
>  static __init void vmx_setup_user_return_msrs(void)
>  {
>
> @@ -8671,6 +8686,7 @@ __init int vmx_hardware_setup(void)
>         kvm_caps.supported_mce_cap |=3D MCG_LMCE_P;
>         kvm_caps.supported_mce_cap |=3D MCG_CMCI_P;
>
> +#ifdef CONFIG_KVM_INTEL_PT
>         if (pt_mode !=3D PT_MODE_SYSTEM && pt_mode !=3D PT_MODE_HOST_GUES=
T)
>                 return -EINVAL;
>         if (!enable_ept || !enable_pmu || !cpu_has_vmx_intel_pt())
> @@ -8679,6 +8695,7 @@ __init int vmx_hardware_setup(void)
>                 vt_init_ops.handle_intel_pt_intr =3D vmx_handle_intel_pt_=
intr;
>         else
>                 vt_init_ops.handle_intel_pt_intr =3D NULL;
> +#endif
>
>         setup_default_sgx_lepubkeyhash();
>
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 6c9dd5b2365d..a449a36fcd1c 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -46,6 +46,7 @@ enum segment_cache_field {
>         SEG_FIELD_NR =3D 4
>  };
>
> +#ifdef CONFIG_KVM_INTEL_PT
>  #define RTIT_ADDR_RANGE                4
>
>  struct pt_ctx {
> @@ -65,6 +66,7 @@ struct pt_desc {
>         struct pt_ctx host;
>         struct pt_ctx guest;
>  };
> +#endif
>
>  /*
>   * The nested_vmx structure is part of vcpu_vmx, and holds information w=
e need
> @@ -280,7 +282,9 @@ struct vcpu_vmx {
>         u64 msr_ia32_mcu_opt_ctrl;
>         bool disable_fb_clear;
>
> +#ifdef CONFIG_KVM_INTEL_PT
>         struct pt_desc pt_desc;
> +#endif
>         struct lbr_desc lbr_desc;
>
>         /* ve_info must be page aligned. */
>
