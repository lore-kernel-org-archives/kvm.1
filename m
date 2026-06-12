Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648C28A72F
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254373; cv=pass; b=TkABLu7HleU+elgbKU1Nhi1mrFVngyb23Xwjy2ZMEhXPPg+IXrU4gKLmdTByt3hWHTwJdzMxty8IE/hZcXFPZoVWoJPBFdc2dCSJZ89BD5z4NeKZsCYtzNGm6xRjgg09mqcGay8iD3HdRgIoaSDwYPfb6J+RCm8JT8j6/nUXccE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254373; c=relaxed/simple;
	bh=svNcQKQ4yr+nyo8MdRRL6FrGNPZqHBNgfoUJccKZlJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9d0PKDi2RGTUFPthNCIlvHyludoLqj9udgFJ5l5K+QckU0cXPtKUW3w8EUAtVPDSde1ZUdHJ6d+GwPkbXKfr4YEkfF45VNjXHIRNKGrbq1Ob1dJZB0NCQLy1BjEnvEOwYpXkJ95pajg6RfbUsFJ44oCwxfBXIN6bhfpyPhChNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHgLi7CH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBSLET7J; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHgLi7CH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBSLET7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781254370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOZXwEI5Y5B3Y02lgtWh42sCFLWWWettLEzpogbwuYA=;
	b=dHgLi7CHcZL3i6ILU4SMa8PV7rxPbHsHLq1bHjVvDdFICbSDOHKxRxrLEXE1yCO3mORLoc
	GXZvlIGdbTNZauXsTAHqbEG9OvnPmfQuwXfCErgvoNIfamQXZc0gr3X0RTooYwp0z78azc
	RiClzw8PPQoMvgvDP1FvHXKV5gkisBU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-MnWRHozvPruFspd-3ErkJQ-1; Fri, 12 Jun 2026 04:52:48 -0400
X-MC-Unique: MnWRHozvPruFspd-3ErkJQ-1
X-Mimecast-MFC-AGG-ID: MnWRHozvPruFspd-3ErkJQ_1781254367
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so5124665e9.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781254367; cv=none;
        d=google.com; s=arc-20240605;
        b=fFnRanZUbFKoPk8Vz/0dh4+llv/T+h1AVv6qjPaRHIBUKp7NFTb7m+Z34ug/W5weK/
         Ze22KB81fRLG5gn2ufDsZnH+MgmRyl6kDKLyfuRweA30LytBAzyJff0le1VpjauI8TVm
         sCgaXEpBD3EgJiCwvKhUjC+0wzW1JrVg29SvLmgxp6LNdcI1Nh050SwPDW+T3/uppAes
         8wFYeujo5iURCuPtuQuwIR+fegOtPJAwDJ9U5hFbEyDORqY1+d+v3KH0yHaJu6voynUe
         UcDlAv9CFO6dkHx3MWOz0JTv+kDtof/K2Bl0FtuX+CaboPVmasn2N13RfUnPl8UPnzQk
         S7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOZXwEI5Y5B3Y02lgtWh42sCFLWWWettLEzpogbwuYA=;
        fh=c3YuEzOxk/0dEvI/A/un+U5sTJr//AWGey04Ru557/Q=;
        b=LilcPGitXs8eTHJ6fypR68cIkb+TuZvjBReF6EtKlg3E7xSWefzpBvLsvGeMParjgf
         fhEkjpgna3F+Ws6/G2FYAncKl6erZNKOUjvKjPzmEtlvFGgHPbxrfXSbt55WGYXLYJRJ
         QspTWjSRPLKot+unqBdEWc72i13922klhmIvk4j8Y8IHGMiYOmlvo/FknwkTVCAJ/Bax
         e9eppZgxm5ryQtmkWWgoq+g6XI/zdnxnMvFtIV/HOkPAadX/CQQzbjJRDmMeZOtH0I9B
         05H0DEK3oxrnzq6BsJbuYWoBagSxBUiErPnuE6CLMaVCmmHni/QML8y8lnpF5pNlW54F
         Jv/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781254367; x=1781859167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOZXwEI5Y5B3Y02lgtWh42sCFLWWWettLEzpogbwuYA=;
        b=HBSLET7JDV8sem+WAi+XUUR+ijzcjJDJt5qHjIEuKV1C2EY6xM5rARW3t4ju0+g0fZ
         N012RopZ0k0YvUBSI5KK61qJkvkORWPESnaC8oES9MGhppPRDTZ2etoxU3IxJD8dSQHE
         JBo4d42pdKQjaqrIPGsEGTsXYu2KD3ZsIMLTBV1EAq6tafyo0tI8dduC1N5aZMW0BEOl
         cdULjExOwL1oB362TpJm7t0TM5bLU/Ah6s8t6R5AoblSXDhV3/o736SpZIlV94S7G7K9
         nPRNuSQfrFeqjLf+BwM5iOsCNcUigMGoOHfMy8Hyuj6k8RCuSQsWQELjDlpMS9+2se9i
         NqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254367; x=1781859167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOZXwEI5Y5B3Y02lgtWh42sCFLWWWettLEzpogbwuYA=;
        b=S8Dt7x9mKF9pI4zGtTmTMRyLy2vXCLj7ukEj7FCiiO9IJJZWVFgr6zRUgdd2sRKKd1
         KPljPiBFVqQwAswipXWPJN6br0AZ7CDkpHFyYycfBDQKz788GVhFLCjsrM59vF148mQl
         +nVkAbh8GiVgzHfNpgFpyMrLXn/4ypdMO5zFzS7yVeU6ZP04y6g3Fz1a0RnRGIltyO6P
         QYLke8mr7RvZkDMoC0dO0TVbqCOIFFcoqpkCno78FOaNEBRUk9XOp1+Sqt9eXzYouHkk
         4bnn/6fsjiV5ea7x7ry5aRYiNwOz0j3nroRj7LOlkvwW06TteziCMQa4N2//pWyU8pZb
         KWSg==
X-Forwarded-Encrypted: i=1; AFNElJ9r6eXHjpEBQeaxRn5sjJzqw2pSWPIrq+xhasL+zMgLgp/xCjOk0jZjbd4BgfAcUPUyaUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXFl7Xf0NXmb2Ul7hx+h7NnI+DhJKH5L4NVnV8go9wqXEWtum
	Mw2+FC/pYNLSB3D4An/TnkCIakf9q8HUg78495i3G1yqAzyZmzwjMpXXI3LFD5inYu/RnnlqO0k
	jN1Xw/T+YiDrb6ulMdH1uw5x4TLVrCZmZjsv2G5mn90HHVs0p2+FSs7bOKx0BkECoQjrfIx67C7
	vB4/4QfOMYHI3nEDxvxUQroXknEeX6
X-Gm-Gg: Acq92OFj7YaRe8ZmwNY5RB71jWm20uXWxN55UHlG9JTC44dRtVTqCsu9n7VfxmiQE+f
	7PF61XJNlyWQyZnh5Hn6kmBaVumEoDlQ8KagguyZ3pppJnU/jNRciqytgHye3MbskHvg9Dk+jWz
	0QKIjtAZCBa4O0FokRqkSDA+6nkFSzocAa3v91j3kNtbdVdhYRu5Vn+wXMT6xftZoLFDH9IT+ge
	LHsCsb5dVxXwbCrKLGt/HpmIXCXiIalgVDMxiCIh4IgHTzmuZYgFwiRB2Hg/UqKR8RzcrfVL+FQ
	35BTmQ==
X-Received: by 2002:a05:600d:15a:20b0:490:bbc4:76a6 with SMTP id 5b1f17b1804b1-490ec4fb51fmr15350165e9.21.1781254367119;
        Fri, 12 Jun 2026 01:52:47 -0700 (PDT)
X-Received: by 2002:a05:600d:15a:20b0:490:bbc4:76a6 with SMTP id
 5b1f17b1804b1-490ec4fb51fmr15349825e9.21.1781254366732; Fri, 12 Jun 2026
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612084835.2992552-1-maz@kernel.org>
In-Reply-To: <20260612084835.2992552-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:52:35 +0200
X-Gm-Features: AVVi8CdX7owDuivueK1-dJeSaKhgMulywKYC_yrCRr9BJkyYkQ7RP3nuvUevgwM
Message-ID: <CABgObfZToG=W=g3ex21LSHUgXF7tNDRTH9CX_g9AcDJpkv+1FQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 updates for 7.2
To: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Eric Auger <eric.auger@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Hyunwoo Kim <imv4bel@gmail.com>, Jackie Liu <liuyun01@kylinos.cn>, Joey Gouly <joey.gouly@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, 
	Zenghui Yu <zenghui.yu@linux.dev>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 10:48=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Paolo,
>
> This is a bit of an odd merge window on the KVM/arm64 front. There is
> absolutely no new feature in the pull request. It is purely fixes,
> because it is simply becoming too hard to review new stuff when so
> many AI-fuelled fixes hit the list. And even then, I've arbitrarily
> tagged the branch today, knowing that there is quite a backlog of
> fixes that I will send very shortly, probably before -rc1.

No problem. Since I usually wait for the arch code to be merged before
sending my PRs, you have almost a week to send them and have them
included in the very first PRs.

Pulled these for now, thanks.

Paolo

> So here it is: only fixes and very minor improvements, all over the
> place. Details in the tag below.
>
> Please pull,
>
>         M.
>
> The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23=
c8:
>
>   Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-7.2
>
> for you to fetch changes up to 1ee27dacbe5dc4def481794d899d67b0d4570094:
>
>   Merge branch kvm-arm64/nv-mmu-7.2 into kvmarm-master/next (2026-06-12 0=
9:29:34 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 updates for 7.2
>
> * New features:
>
>   - None. Zilch. Nada. Que dalle.
>
> * Fixes and other improvements:
>
>   - Significant cleanup of the vgic-v5 PPI support which was merged in
>     7.1. This makes the code more maintainable, and squashes a couple
>     of bugs in the meantime.
>
>   - Set of fixes for the handling of the MMU in an NV context,
>     particularly VNCR-triggered faults. S1POE support is fixed
>     as well.
>
>   - Large set of pKVM fixes, mostly addressing recurring issues
>     around hypervisor tracking of donated pages in obscure cases
>     where the donation could fail and leave things in a bizarre
>     state.
>
>   - Fixes for the so-called "lazy vgic init", which resulted in
>     sleeping operations in non-preemptible sections. This turned
>     out to be far more invasive than initially expected...
>
>   - Reduce the overhead of L1/L2 context switch by not touching
>     the FP registers.
>
>   - Fix the way non-implemented page sizes are dealt with when
>     a guest insist on using them for S2 translation.
>
>   - The usual set of low-impact fixes and cleanups all over the map.
>
> ----------------------------------------------------------------
> Fuad Tabba (5):
>       KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
>       KVM: arm64: Fix __deactivate_fgt macro parameter typo
>       KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
>       KVM: arm64: Pre-check vcpu memcache for host->guest share
>       KVM: arm64: Pre-check vcpu memcache for host->guest donate
>
> Hyunwoo Kim (2):
>       KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCP=
U
>       KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
>
> Jackie Liu (1):
>       KVM: arm64: vgic-its: Make ABI commit helpers return void
>
> Marc Zyngier (29):
>       KVM: arm64: nv: Track L2 to L1 exception emulation
>       KVM: arm64: nv: Don't save/restore FP register during a nested ERET=
 or exception
>       KVM: arm64: timer: Repaint kvm_timer_{should,irq_can}_fire() to kvm=
_timer_{pending,enabled}()
>       KVM: arm64: Simplify userspace notification of interrupt state
>       KVM: arm64: timer: Kill the per-timer irq level cache
>       KVM: arm64: pmu: Kill the PMU interrupt level cache
>       KVM: arm64: vgic-v2: Force vgic init on injection outside the run l=
oop
>       KVM: arm64: vgic-v2: Don't init the vgic on in-kernel interrupt inj=
ection
>       KVM: arm64: vgic-v5: Add for_each_visible_v5_ppi() iterator
>       KVM: arm64: vgic-v5: Move PPI caps into kvm_vgic_global_state
>       KVM: arm64: vgic-v5: Remove use of __assign_bit() with a constant
>       KVM: arm64: vgic-v5: Drop pointless ARM64_HAS_GICV5_CPUIF check
>       KVM: arm64: vgic: Constify struct irq_ops usage
>       KVM: arm64: vgic: Consolidate vgic_allocate_private_irqs_locked()
>       KVM: arm64: vgic-v5: Drop defensive checks from vgic_v5_ppi_queue_i=
rq_unlock()
>       KVM: arm64: vgic: Rationalise per-CPU irq accessor
>       KVM: arm64: vgic-v5: Limit support to 64 PPIs
>       KVM: arm64: Key CPTR_EL2.E0POE propagation on FEAT_S1POE
>       KVM: arm64: Wire AT S1E1A in the system instruction handling table
>       arm64: cpufeature: Expose ID_AA64ISAR2_EL1.ATS1A to KVM
>       KVM: arm64: nv: Avoid dereferencing NULL VNCR pseudo-TLB
>       KVM: arm64: nv: Hold kvm->mmu_lock while initialising vcpu->arch.vn=
cr_tlb
>       Merge branch kvm-arm64/no-lazy-vgic-init into kvmarm-master/next
>       Merge branch kvm-arm64/nv-fp-elision into kvmarm-master/next
>       Merge branch kvm-arm64/nv-granule-sizes into kvmarm-master/next
>       Merge branch kvm-arm64/pkvm-fixes-7.2 into kvmarm-master/next
>       Merge branch kvm-arm64/vgic-v5-PPI-fixes into kvmarm-master/next
>       Merge branch kvm-arm64/misc-7.2 into kvmarm-master/next
>       Merge branch kvm-arm64/nv-mmu-7.2 into kvmarm-master/next
>
> Oliver Upton (5):
>       KVM: arm64: Don't leak PFN when kvm_translate_vncr() races MMU noti=
fier
>       KVM: arm64: nv: Fully update VNCR fixmap state in kvm_translate_vnc=
r()
>       KVM: arm64: nv: Inject SEA TTW when desc update can't write to GPA
>       KVM: arm64: Restart instruction upon race in __kvm_at_s12()
>       KVM: arm64: nv: Restart stage-1 walk if stage-2 desc update fails
>
> Sascha Bischoff (9):
>       KVM: arm64: vgic-v5: Add missing trap handing for NV triage
>       KVM: arm64: vgic-v5: Atomically assign bits to PPI DVI bitmap
>       KVM: arm64: selftests: Add missing GIC CDEN to no-vgic-v5 selftest
>       KVM: arm64: selftests: Cleanup unused vars in GICv5 PPI selftest
>       KVM: arm64: selftests: Improve error handling for GICv5 PPI selftes=
t
>       Documentation: KVM: Fix typos in VGICv5 documentation
>       Documentation: KVM: Clarify that PMU_V3_IRQ IntID requirements for =
GICv5
>       irqchip/gic-v5: Immediately exec priority drop following activate
>       KVM: arm64: Fix arch timer interrupts for GICv3-on-GICv5 guests
>
> Vincent Donnefort (4):
>       KVM: arm64: Reset page order in pKVM hyp_pool
>       KVM: arm64: Fix __pkvm_init_vm error path
>       KVM: arm64: Add fail-safe for refcounted pages in __pkvm_hyp_donate=
_host
>       KVM: arm64: Set a Linux errno on SMCCC error in kvm_call_hyp_nvhe()
>
> Wei-Lin Chang (5):
>       KVM: arm64: nv: Rename vtcr_to_walk_info() to setup_s2_walk()
>       KVM: arm64: Factor out TG0/1 decoding of VTCR and TCR
>       KVM: arm64: nv: Use literal granule size in TLBI range calculation
>       KVM: arm64: Fallback to a supported value for unsupported guest TGx
>       KVM: arm64: Fix block mapping validity check in stage-1 walker
>
> Will Deacon (1):
>       KVM: arm64: Don't populate TPIDR_EL2 in finalise_el2()
>
> Zenghui Yu (Huawei) (1):
>       KVM: arm64: Remove @arch from __load_stage2()
>
> tabba@google.com (4):
>       KVM: arm64: Flush HCR_EL2.VSE to deliver SErrors to pKVM guests
>       KVM: arm64: Free hyp-share tracking node when share hypercall fails
>       KVM: arm64: Avoid host/hyp share desync on unshare hypercall failur=
e
>       KVM: arm64: Roll back partial shares on kvm_share_hyp() failure
>
>  Documentation/virt/kvm/devices/arm-vgic-v5.rst |   6 +-
>  Documentation/virt/kvm/devices/vcpu.rst        |   7 +-
>  arch/arm64/include/asm/kvm_host.h              |   8 +-
>  arch/arm64/include/asm/kvm_hyp.h               |   1 +
>  arch/arm64/include/asm/kvm_mmu.h               |   3 +-
>  arch/arm64/kernel/cpufeature.c                 |   1 +
>  arch/arm64/kernel/hyp-stub.S                   |   4 +-
>  arch/arm64/kvm/arch_timer.c                    | 137 +++++++--------
>  arch/arm64/kvm/arm.c                           |  41 +++--
>  arch/arm64/kvm/at.c                            | 146 +++++++++++----
>  arch/arm64/kvm/emulate-nested.c                |  12 ++
>  arch/arm64/kvm/fpsimd.c                        |  26 +++
>  arch/arm64/kvm/hyp/include/hyp/switch.h        |   2 +-
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h  |   3 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c             |  21 ++-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c          |  37 ++--
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c           |  21 ++-
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                 |   4 +-
>  arch/arm64/kvm/hyp/nvhe/switch.c               |   2 +-
>  arch/arm64/kvm/hyp/nvhe/tlb.c                  |   4 +-
>  arch/arm64/kvm/hyp/vgic-v5-sr.c                |  82 ++-------
>  arch/arm64/kvm/hyp/vhe/switch.c                |   2 +-
>  arch/arm64/kvm/hyp/vhe/tlb.c                   |   4 +-
>  arch/arm64/kvm/mmu.c                           |  39 ++++-
>  arch/arm64/kvm/nested.c                        | 234 ++++++++++++++++---=
------
>  arch/arm64/kvm/pmu-emul.c                      |  31 +---
>  arch/arm64/kvm/sys_regs.c                      |  20 +--
>  arch/arm64/kvm/vgic/vgic-init.c                |  45 ++---
>  arch/arm64/kvm/vgic/vgic-irqfd.c               |   6 +
>  arch/arm64/kvm/vgic/vgic-its.c                 |  21 +--
>  arch/arm64/kvm/vgic/vgic-kvm-device.c          |   9 +-
>  arch/arm64/kvm/vgic/vgic-v5.c                  |  51 ++----
>  arch/arm64/kvm/vgic/vgic.c                     |  33 ++--
>  arch/arm64/kvm/vgic/vgic.h                     |   3 +
>  drivers/irqchip/irq-gic-v5.c                   |  13 +-
>  include/kvm/arm_arch_timer.h                   |   7 +-
>  include/kvm/arm_pmu.h                          |   5 +-
>  include/kvm/arm_vgic.h                         |  19 +-
>  tools/testing/selftests/kvm/arm64/no-vgic.c    |   1 +
>  tools/testing/selftests/kvm/arm64/vgic_v5.c    |  10 +-
>  40 files changed, 651 insertions(+), 470 deletions(-)
>

