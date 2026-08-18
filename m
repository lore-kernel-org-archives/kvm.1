Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F2469856
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053339; cv=pass; b=s4txdQjDbW1LhtQNRVfugcG2Q3EY1m5QKWVW//4s/ufLmpbCRzMCtlm6hVTcU81M2G89KqasaArAeopuqnWA+zDRtaS2qcjj7QF0pIn90MyUKsFgJ3J5DzWlYo9O30SbA9976DSX5Y/DPat1bT4cc0Qpa/yDc7xs68nV59V5mPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053339; c=relaxed/simple;
	bh=atsk0A4MpnEfgD/fMEYLJCSDOsfe+GdRkuDv85F/+k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6I3KnJ3Q1HLYHvQvDipUlnTcads2fLWvfw9T3CXR9eguByvknRVVzjjdrtMy9yrLV5Z0yN0YW/w2+LJzeQZURCb1fp2mv6QthSHQKnmYrjciJvZwVO+ZkEo0WLNxxM+39qY9tTnSzRUscpv0weIWhe5LC50Gr+etWxsDX9ldRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUbK1qNo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7Q7BVdV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUbK1qNo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7Q7BVdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787053336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBuPI2v31MBMjaLiX6dqLNyqJZVl6J1gigUP4es5P/M=;
	b=aUbK1qNo6KMjHj2cv+lOOoYEHj9c5bytJv07Zlvx2DGPes1e5vzQAc2OjmP/VtGia3tkgS
	SLJZavBCxM6R+GodxQTotGPV1IwLwY/3TbDrjjj4mHB1HBG5pW7ka6cfDBghQS0AAwcuFt
	+g3GwtgkqlWS/zR7BNNHiSb41jYzsIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-EwiXKxw8Oc-b21C4mRDEdw-1; Tue, 18 Aug 2026 07:42:15 -0400
X-MC-Unique: EwiXKxw8Oc-b21C4mRDEdw-1
X-Mimecast-MFC-AGG-ID: EwiXKxw8Oc-b21C4mRDEdw_1787053334
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so10030005e9.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787053334; cv=none;
        d=google.com; s=arc-20260327;
        b=Exma/HZofEzWUIEZc1xp53UlBqUl/MifPj/MSai9PILxipHacguqbZM73PllNB/58q
         vIX2EYIUIHpRhOJE6vq3cuwNT56WtNDqVmZRygRNHgoNaUfZOohCfU1gk/1OYQSQIu7+
         kz2qqeCDqJ1OepxJXSETbE/mQIwySbbsJSsvS+rzxX87K4xhhyo8c0KAySbycPB8oR/6
         UD1Eu6BH/JrSNPtapw5Re1cMtXJzUx+DfOxH8rnvCw0q/8k9fGMyGahQuuB6sAbCx7ja
         tYmrBO/8ZTL5uDYhfR5/udB5TGz/cdMdeKHx9t7YgLKwHwfJWf29nAlXYqiWbcLZE+qC
         nRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OBuPI2v31MBMjaLiX6dqLNyqJZVl6J1gigUP4es5P/M=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=k/6ESWmbhyLV0ndKzR74ny2Rcn74+fIRVrVdEgXyeJtDbGhLt+WnYHbeAUVthyQTGx
         UQEmUZxL0Sb+ViVcORe4irYgyiENRBXOLOlmAvGSiK7ubXPg4J+TLMvRdyX1VmL+wnW0
         t9R208awp0H4WCq8vIASkW/4v50ba5fZmCi7dSIE/sVBxvLla87nn0sJlqfdAGKOO4lb
         36pU5AWU3gh5zeoKhZvaJ3RaL1OpE/bkNjLosfdzI9SGF15s0PlKTa25lnqNwCJVYXBN
         QnuvpgfhmuLZaWgyhyZjt3+1dj4qjy1UaotEt2fR3VmGM7ralKG0BBCddn0DlyzHTk6A
         6beg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787053334; x=1787658134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OBuPI2v31MBMjaLiX6dqLNyqJZVl6J1gigUP4es5P/M=;
        b=D7Q7BVdVO1gfechceijg0ODmwyx/7M0262D+ZSBJPwaz8GsJpayQxHncUnp8QL4eLI
         qZMXh/wf3SIp0YN3oXZ3/8wFCSkDFdS6ZhgHYLB0TBTR1rZcVntZzpilzF3cNj+zscEH
         WjA5uMfuqKNh0EpgRCj42lSN7Pr8IVTAailra4KNY+CPIKcvk1UcU0/W3wln55YaNh0Z
         sCtByG52UNkTD+oHW9sCPI+oPP2BYHtE7dQ17/D44ER4AE7VAFwZo7SaTWZjI4MEEMuz
         1cTge/QICv10CODzDXmpRYpV/PpCtj+GSm24oyWsao6joC/eyOo9FNMcbTiegXciSDtV
         pSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053334; x=1787658134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBuPI2v31MBMjaLiX6dqLNyqJZVl6J1gigUP4es5P/M=;
        b=O2DsL+Rn9Xd2ObZCxLIiRlq+CH53dx2OIsQA00BDjzWnS3D0HO99VY2bs9Z3dUBd2A
         gx3OUjwEwatJsRcahujVnqlyb+1KcivYvgbOGZYBlKfTSZ7s0nqlMf0Xjq0G4XJgBsL+
         wENM577WdUfkWlpGSHh7ZbPpl2qP58auf0vw9r71xNcGAgaohcE1yucmpvKudoE2v2rS
         0+phpFMtGWQvmd1iPY3QzdcatVZeuNqcf7NqFZelMbVWBn0QSXphYPXEtOkEM1MU3C2S
         ATeNfXvK3qboPYutj0xgtY26edLdAB0l/t8Eg7UDDFcV+GFMrGzeoS104ONQkcZgANLV
         /QEg==
X-Gm-Message-State: AOJu0YyrQl6oeEhVmhI6kqmi66h5TW7+P0n3JwzrxaLnX1s6KtkanV7+
	sZ+xqrjlzfRDbplOTm/dM43U/v0dOP4gkYcwqmGHSYaEqnRIsbnpE5Iu9ZZkSz2rk294Mf36b4N
	vLbHx9UaMMEHw7xR/3DUJ4dcj7cZ/p2NRJPbT+aJlJWbGkHEaCBxcUFNUSB+w4gGWGW34fgNt01
	3wwvkemPYeb7yIzVdaXvyxigrOSk/G8Q9y8SXv
X-Gm-Gg: AR+sD10sJsD+nd1F1w0uj/rm69zaOS8YrxUgrLV+uiBD4KMDt4lnk0JD4AAEETBqiu1
	qAxmIEhlgt+tAi79UiFX7oJSRfTPAEcD882HdmrqwhG3Srbkch/jzh8wLqzm6LDS2Anp0M7LdRz
	WvTtxae0gafELT2q2IGRMEY6KRspn7DOyMNj++Kdrr5KyyDS442WRNQRdiVLzxRivghVEknM///
	HjQrnEpHENKXQOBRrGaMWxyejqAFb5sI57qwUuq1lTFZVuwza2FI7u4fRo=
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499a206a553mr79267675e9.6.1787053334048;
        Tue, 18 Aug 2026 04:42:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-499a206a553mr79265105e9.6.1787053333675; Tue, 18 Aug 2026
 04:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-6-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:42:01 +0200
X-Gm-Features: AcwNN1VxNZ0hPudHIvtqyhMhgCIaBvsDoUcL8IT9iW86F4llGF9EGu7lzFwlUOU
Message-ID: <CABgObfa-4Dbi0FjKCy6UvjvmcniCwuhrvZfA9uuBH2QE2HdU1g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> The main set of x86 changes for 7.3.  Yosry's INVVPID and EFER validation=
 changes
> are probably the most interesting.  Almost everything from me falls into =
the
> category of "fixes for things that are technically bugs, but that no one =
cares
> about in practice".

Pulled, thanks.

Paolo

> The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f3=
70:
>
>   Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.3
>
> for you to fetch changes up to 66ee8f1556575c8f9ae76932dd3aca65b4b60e59:
>
>   KVM: x86/pmu: Clean up vPMU comments and stray blank lines (2026-08-05 =
16:42:23 -0700)
>
> ----------------------------------------------------------------
> KVM x86 misc changes for 7.3
>
>  - Fix VPID virtualization bugs where KVM would fail to flush hardware TL=
Bs.
>
>  - Harden the SNP and TDX "populate" ioctls against bad input, and to pre=
pare
>    for supporting in-place private<=3D>shared conversion.
>
>  - Fix a variety of #DB priority bugs.
>
>  - Fix a class of races related to enabling Hyper-V emulation on a vCPU a=
fter
>    the vCPU is visible to the rest of KVM.
>
>  - Use static calls for nested virtualization ops.
>
>  - Move more KVM-internal code out of x86's kvm_host.h.
>
>  - Enumerate support for a variety of Zhaoxin instructions that don't req=
uire
>    explicit virtualization.
>
>  - Fix missing EFER validation bugs, including in the KVM_SET_SREGS* path=
.
>
>  - Harden kvm_vcpu_map() against double-mapping and thus leaking referenc=
es.
>
>  - Misc fixes and cleanups, e.g. for largely benign syzkaller splats.
>
> ----------------------------------------------------------------
> Binbin Wu (1):
>       KVM: x86: Fix emulated CPUID features being applied to wrong sub-le=
af
>
> Carlos L=C3=B3pez (3):
>       KVM: x86: Treat any non-zero return from set_dr() as a faulting con=
dition
>       KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86=
_set_mce()
>       KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock
>
> Ewan Hai-oc (5):
>       KVM: x86: Expose Zhaoxin SM2 CPUID feature
>       KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
>       KVM: x86: Expose Zhaoxin RNG2 CPUID feature
>       KVM: x86: Expose Zhaoxin PHE2 CPUID feature
>       KVM: x86: Expose Zhaoxin RSA CPUID feature
>
> Hao Zhang (1):
>       KVM: selftests: Extend the invalid nVMX guest state test to cover R=
SM
>
> Joerg Roedel (1):
>       KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDA=
TE
>
> Kai Huang (1):
>       KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook
>
> Like Xu (1):
>       KVM: x86/pmu: Clean up vPMU comments and stray blank lines
>
> Sean Christopherson (45):
>       KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
>       KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION s=
ource
>       KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
>       KVM: x86: Manually check DR4/5 write values to fix SVM intercept pr=
iority
>       KVM: x86: Prioritize #UD on MOV DR over #GP due to non-zero CPL
>       KVM: VMX: Prioritize DR7.GD=3D1 #DB over CPL>0 #GP on Intel
>       KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values=
 in emulator
>       KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
>       KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or D=
R5
>       KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not cal=
ler
>       KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_t=
lb_flush_fifo()
>       KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cro=
ss-vCPU accesses
>       KVM: x86/xen: Always route non-singleshot-timer vCPU hypercalls to =
userspace
>       KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot time=
r hypercalls
>       KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU=
 ID isn't set
>       KVM: Initialize a vCPU's index to '-1' while it's being created
>       KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
>       KVM: x86: Treat a vCPU as unreachable if its index is invalid
>       KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
>       KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active=
 accesses
>       KVM: x86: Move the "APIC attention" macros from kvm_host.h =3D> lap=
ic.c
>       KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
>       KVM: x86: Pluralize the macro guard name for msrs.h
>       KVM: x86: Move CR and DR macro definitions from kvm_host.h =3D> reg=
s.h
>       KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h =3D> x86.c
>       KVM: x86: Add static asserts to document connection b/w TSS structs=
 and macros
>       KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
>       KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h =3D=
> lapic.h
>       KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.=
h =3D> hyperv.h
>       KVM: x86: Reject nested CAP enablement if nested virtualization is =
disabled
>       KVM: x86: Add static calls for nested virtualization ops
>       KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_=
ops
>       KVM: x86: Don't WARN if IRQ disappears because it was cleared from =
the PIC
>       KVM: x86: Don't WARN if IRQ disappears when Xen emulation is enable=
d.
>       KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-E=
xit
>       KVM: nSVM: Add CLASS()es for automagically handling local kvm_vcpu_=
map() usage
>       KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
>       KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap me=
rging
>       KVM: PPC: Use CLASS(kvm_vcpu_map_local) to patch dcbz
>       KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking =
references
>       KVM: x86: Extract VMX's unhandleable emulation check to common x86
>       KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
>       KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initia=
lization()
>       KVM: selftests: Use port 0x80 in invalid nVMX guest state test
>       KVM: selftests: Refactor invalid nVMX state test to prepare for RSM=
 testcase
>
> Tim Wiederhake (1):
>       KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE
>
> Yosry Ahmed (9):
>       KVM: nVMX: Always flush vpid02 on first use
>       KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
>       KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER se=
tup
>       KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not suppor=
ted
>       KVM: x86: Always initialize EFER reserved bits on vendor initializa=
tion
>       KVM: x86: Reverse the polarity of efer_reserved_bits
>       KVM: x86: Move supported EFER bits to kvm_caps
>       KVM: x86: Check EFER validity on KVM_SET_SREGS*
>       KVM: selftests: Extend set_sregs test to cover EFER
>
> leixiang (1):
>       KVM: Remove kvm_debugfs_dir on kvm_init() error paths
>
>  arch/powerpc/kvm/book3s_pr.c                       |  11 +-
>  arch/x86/include/asm/cpufeatures.h                 |  10 +
>  arch/x86/include/asm/kvm-x86-nested-ops.h          |  36 ++++
>  arch/x86/include/asm/kvm-x86-ops.h                 |   5 +-
>  arch/x86/include/asm/kvm_host.h                    | 212 ++-------------=
------
>  arch/x86/kvm/cpuid.c                               |  22 ++-
>  arch/x86/kvm/emulate.c                             |  49 +++--
>  arch/x86/kvm/hyperv.c                              |  95 +++++----
>  arch/x86/kvm/hyperv.h                              | 117 +++++++++++-
>  arch/x86/kvm/irq.h                                 |  20 ++
>  arch/x86/kvm/lapic.c                               |  13 +-
>  arch/x86/kvm/lapic.h                               |  33 ++++
>  arch/x86/kvm/mmu.h                                 |  11 +-
>  arch/x86/kvm/mmu/mmu.c                             |   2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h                     |   2 +-
>  arch/x86/kvm/msrs.c                                |  21 +-
>  arch/x86/kvm/msrs.h                                |   5 +-
>  arch/x86/kvm/pmu.c                                 |  12 +-
>  arch/x86/kvm/pmu.h                                 |   4 +-
>  arch/x86/kvm/regs.c                                |   3 +-
>  arch/x86/kvm/regs.h                                |  38 ++++
>  arch/x86/kvm/smm.c                                 |   4 +
>  arch/x86/kvm/svm/nested.c                          |  20 +-
>  arch/x86/kvm/svm/sev.c                             |  16 +-
>  arch/x86/kvm/svm/svm.c                             |  66 ++-----
>  arch/x86/kvm/svm/svm.h                             |   1 +
>  arch/x86/kvm/tss.h                                 |   7 +
>  arch/x86/kvm/vmx/main.c                            |  24 ++-
>  arch/x86/kvm/vmx/nested.c                          |  81 ++++----
>  arch/x86/kvm/vmx/nested.h                          |   6 +-
>  arch/x86/kvm/vmx/pmu_intel.c                       |   1 -
>  arch/x86/kvm/vmx/tdx.c                             |  16 +-
>  arch/x86/kvm/vmx/vmx.c                             |  19 +-
>  arch/x86/kvm/vmx/x86_ops.h                         |   4 +-
>  arch/x86/kvm/x86.c                                 | 110 ++++++++---
>  arch/x86/kvm/x86.h                                 |   8 +-
>  arch/x86/kvm/xen.c                                 |  43 +++--
>  include/linux/kvm_host.h                           |  26 +++
>  .../testing/selftests/kvm/include/x86/processor.h  |   2 +
>  .../testing/selftests/kvm/x86/pmu_counters_test.c  |   6 +-
>  .../selftests/kvm/x86/pmu_event_filter_test.c      |   4 +-
>  tools/testing/selftests/kvm/x86/set_sregs_test.c   |  81 ++++++--
>  .../kvm/x86/vmx_invalid_nested_guest_state.c       | 118 ++++++++++--
>  virt/kvm/kvm_main.c                                |  12 ++
>  44 files changed, 857 insertions(+), 539 deletions(-)
>  create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h
>

