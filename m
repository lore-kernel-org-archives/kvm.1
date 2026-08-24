Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B237E5C4
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600914; cv=pass; b=e1xb+4OUJK2md9uH6lcIDdeEcxmH3AK6N9m2pyrBub1Z6zzijW9fLG0E4aDBiKmCRFRkOZREdZICbM+u9c22sFGR8lRrn6Hvd7/yh1C5ch4G/0G1N9NKuaa92eCwN+oH8gzDpwI9Fj99j/z+Zk8O6qz8jArTb8+Tk0EA1Z9alkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600914; c=relaxed/simple;
	bh=ofC7kb0lNN6W4gvYkqZp34eZwnwmen/Oc03rk6eRWko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCIQtI9Jd/Lr6MZc+AGH/SeRZk2Vykeq49SyLya1Y9PB5yRCY7fi/mc1B1WA9qVOLUNA/ByR7KJq1oFAd7bkfwwT+JSEcshalZHm1I7vcv6E2SJ6v+OxL7yIXzW0eAjlDyCZjApSqCAtiSUlZ9aKflI7jVoZhM/GneZlC7zLfvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH9zDlW4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSn6t68V; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH9zDlW4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSn6t68V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787600911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai1QZFLNFxImTcwGdJTINCJXHn62zwOssrDH0GDVjvA=;
	b=ZH9zDlW42nBEtV/zc0Lw4fRRl7eoJ5t5Svh3UG7qfSeEzYwBwn/RwOGS843m703xfMyWfh
	tsn5tRt/rEiBsm5tT+0MGRPiyL9jt/Thc7r8a7tn9IhQ8hyT5H2K6Wwpq4W145WOoGWQF8
	AdbdRlpO5wf46KGvNQgDwGweBgt3YpA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-8xK9kfnWMTapZZr_bkKPrQ-1; Mon, 24 Aug 2026 15:48:30 -0400
X-MC-Unique: 8xK9kfnWMTapZZr_bkKPrQ-1
X-Mimecast-MFC-AGG-ID: 8xK9kfnWMTapZZr_bkKPrQ_1787600909
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so2242855f8f.3
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 12:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787600909; cv=none;
        d=google.com; s=arc-20260327;
        b=NNejEJ+69PCf+c7UCYWY3Ttldb7boGms39wDVxwV9Hz2572lrM+wYUaWzUBTo3bDye
         jpmf9wXTm5ET5AVzjED77rNm6VZcdkL/aXdkJ1ch8G6jglReSGLidCRWlCoda5F+ND79
         4y+juKYWzISV/TXPFG/kCQG+o/QCmiFsG8uWJPLB+09IFO2j1+H6xLrssaYsIwJjDwpB
         lnQR631KUBn0G/LVndEZFE++LmVQ2S/UN9C1f5aLn85anx5jnFUJvx+29ptTQvJXpN17
         fb6zFPjz4uYi3ixLOo8AtHC7VrTFNeZuM4OMcYvNE2lt9p+6r2ECDypniUA37m1tiM0B
         gv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ai1QZFLNFxImTcwGdJTINCJXHn62zwOssrDH0GDVjvA=;
        fh=yorQ4hwOnyVWLIV2+jTFehVtCOrHprYlXgJdCFVFX2s=;
        b=FZI8h6uyvY4T7+2RLvGUQPG7G+z+VZbvSwl1lDFHBIHgHC3W9Pn5+PbzmswBG5nVsS
         vxxQdLGsZIl3WpXLb6/q8R3pBWcV+wWlAaowoPDXzCezHZTsN/hICyGERFT+75Hn04lX
         ZSN95gnEzTYeQ6tPM87NN88LQ0hrv8dvPlxh7t28IFPpXERiIWtwYgHq1g/pB7xq717s
         rfB3BC0Wodi/pRM+6eVosD66NlMnD7BFv2IqVrpn/xcAyZf3ADUeu0r7msFkMd/Ob2yq
         CCS/v24tjcX5isPdXGO28Bnlv874vJhPvjhCWCKcWDOQjohf7lCTv+bxR7Yu3Oj+aKOU
         m7Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787600909; x=1788205709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ai1QZFLNFxImTcwGdJTINCJXHn62zwOssrDH0GDVjvA=;
        b=MSn6t68VGPozXihnpIn0WUvxn1TdlaTqTJp1aZNeD/Ea6sqAqFOYFOeTfVAfebHLyg
         oRhbOTnTP5croln2iHJLlW+M1YIh8Lsmqz7N8SjzXplVqS2JB3GMn1ywb7m/m6q2bSoJ
         l/piLdporP8oT2aRAbloFydLgG9n23be8dlCVoDssX1ND/IKFI1jXLC7Q043bM1MwMb3
         Juu1bSe0ovBrph5oC57npjlzuhn6zJ5xZANskKwLQdZbAkK05cPRmGCjVrhf1jNHsT6f
         QUviM7tlVDMiXgnvKY2tTjDgFL1//JMnQwnEZLiYqJg31d8LqwoS8hAgYBOkpqSpTyuL
         kR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600909; x=1788205709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ai1QZFLNFxImTcwGdJTINCJXHn62zwOssrDH0GDVjvA=;
        b=Ctx+JlmB2Bvb1iDHR0oWrnLugQAh2GjxGseiX7Jp+quYl5nEYPY0q1ujSPNNfk8iCr
         vzhP305/L8zP6+K2cI6ZWgZCYifntdcpQE9wkQQlEHgfRoBSsqG5Vy1WpcephrXDkyNP
         iXhj1N0FQBXnT0kaOKU1WxT5qvoSzDA+EgkVFeE9B4HKWnaJZdvwOmkSfIeLaRYM/7yj
         yyzSUQFej8zephJVH7nmNwdV8LUu05g/i9jiSr4OFGMippIqi8YRRKxZNefIb4xvtGuu
         3LaT4T3JEI+HoFqtboJYCIENaoBOOHnUUEYabEvEtQpxdLkGm+CRFycVWcVavZ8D8KTo
         D0vw==
X-Forwarded-Encrypted: i=1; AHgh+RoAjgJbr3Mkxvsh5gEvUmjFDPf/erXW0HxF32Uyjc2n2pREhjs0QYpXk8YRt7mtArYFA8k=@vger.kernel.org
X-Gm-Message-State: AFuF++lca1insiWLR3H13NeGIa/amjyqi/6zxVGrmkFIRA7QrVOlj4Zt
	Yb5bQYPg6iiICYX4T9a0cIyflNnkI3qEkXq8OvIAdATgM2VHY0dA0zhoIrhX5juN++Z7Zbg33mm
	xZCmL8SuzKt9E3ePZE2HbtyCWFY5M0lzdPOwmSyg6ERBZH7jtVqnAl7yxMFl8WhnAwmRNj+5gFb
	YjR8DMWExfV+IO0fyAYkGfVB8W8gBw
X-Gm-Gg: AR+sD12oYZ5lHGNoVsoBBhVIPMSPXlBeztWDfv4wzGGRUx2dg5CIzKVt5/yYkW/5kPC
	I/l4Pn/4PI80HL9Uiu41+RmANV9yCjSXlkzaNci7mizXoHW6dez5pL5rXFgqQaKKSB4KrEOlpdh
	pW5w7Fkt+SWzU1vmwR6KZOf5ccST/UQTzEqIPmbA7UyxXjvySGko94ls2Lh33nhbinRRG48nc6E
	QSTw6LTqFu52/p5gMy+GQFdJxnCfHFfINfbCoALgb15nO1WVz1fHTf98l4=
X-Received: by 2002:a5d:5f96:0:b0:47f:8ac0:282 with SMTP id ffacd0b85a97d-482c0ba3344mr38751598f8f.17.1787600909060;
        Mon, 24 Aug 2026 12:48:29 -0700 (PDT)
X-Received: by 2002:a5d:5f96:0:b0:47f:8ac0:282 with SMTP id
 ffacd0b85a97d-482c0ba3344mr38751534f8f.17.1787600908421; Mon, 24 Aug 2026
 12:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoaG4cyg3gRQH_8S@kernel.org>
In-Reply-To: <aoaG4cyg3gRQH_8S@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Aug 2026 21:48:13 +0200
X-Gm-Features: AcwNN1UDRkRMy6gfy8grhSa8xS6yDrRe6lIhY3AtoAlV9sJLtCwTwarkFj6pp9s
Message-ID: <CABgObfbaqnaQPzQ+3rs2kc0XkD6Lqft4tOxS-XgcA1VkN583JQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 changes for 7.3
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:47=E2=80=AFAM Oliver Upton <oupton@kernel.org> wr=
ote:
>
> Hi Paolo,
>
> Apologies for the delay on sending you 7.3 content. I've been _mostly_ on
> family leave for the past while but Marc + the entire reviewer crew has
> helped significantly with getting this release into shape. Seriously,
> thanks y'all.
>
> Continuing with the current trend, this release is extremely fix heavy,
> although we were able to get some new features in for PMU, nested, and pK=
VM
> this time around.
>
> There are two minor conflicts, one with the powerpc tree [1] and the othe=
r
> with arm64 [2]. Resolutions for both are straightforward (e.g. add/add co=
llision
> in uapi.h)
>
> Details found in the tag, please pull.

Done, thanks.

Paolo

> Thanks,
> Oliver
>
> [1]: https://lore.kernel.org/linux-next/ans20_e3b_8XJsvA@sirena.org.uk/
> [2]: https://lore.kernel.org/linux-next/anXu1CnuHQo-fKId@sirena.org.uk/
>
> The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733c=
ff:
>
>   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/ tags=
/kvmarm-7.3
>
> for you to fetch changes up to aa8e5dc6a7a2a1141ab40706a51010adcd0e57d2:
>
>   Merge branch 'kvm-arm64/misc-7.3' into next (2026-08-19 14:08:24 -0700)
>
> ----------------------------------------------------------------
> KVM/arm64 changes for 7.3
>
>  - Add support for 'slot' based PMU events, paired with new UAPI that
>    compels the user to select a specific PMU implementation
>
>  - Lazy save/restore of vCPU state for pKVM, along with various fixes
>    and cleanups to the management of vCPU state between the untrusted
>    host and pKVM hypervisor
>
>  - Disable traps of EL1 registers for nested hypervisors when FEAT_NV2p1
>    is present, guaranteeing that EL2-specific register bits are stateful
>    in the EL1 counterpart
>
>  - Leverage FEAT_NV3 to avoid unnecessary ERET/TLBI traps when the scope
>    of those instructions remains 'in host' (i.e. L1 kernel/userspace)
>
>  - Pile of fixes for the management of the VNCR pseudo-TLB, such as
>    under-invalidations and races with concurrent TLBIs on other vCPUs
>
>  - Consolidate the non-protected and pKVM view of ICH_VTR_EL2 to a
>    runtime-patched constant, allowing the same data to be shared with
>    pKVM prior to dropping host privileges
>
>  - Considerable pile of LLM-assisted fixes around the shop but mostly in
>    the VGIC, our in-kernel generator of bugs (and sometimes interrupts)
>
> ----------------------------------------------------------------
> Bradley Morgan (2):
>       KVM: arm64: Skip cache maintenance for non-cacheable pKVM mappings
>       KVM: arm64: Top up stage-2 memcache for dirty logging faults
>
> Congkai Tan (3):
>       KVM: arm64: Expose PMMIR_EL1.SLOTS under strict PMUv3 UAPI
>       KVM: arm64: Advertise STALL_SLOT* in PMCEID1 under strict PMUv3 UAP=
I
>       KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_STRICT vCPU feature
>
> Fuad Tabba (21):
>       KVM: arm64: Drop the unused EL2-side is_created write
>       KVM: arm64: Remove unreachable early checks in pkvm_init_host_vm()
>       KVM: arm64: Drop redundant READ_ONCE() in pkvm_hyp_vm_is_created()
>       KVM: arm64: Sync SCTLR_EL1 when injecting an exception into a pVM
>       KVM: arm64: Flush external_mdscr_el1 to the pKVM hyp vCPU
>       KVM: arm64: selftests: Add a userspace watchpoint test
>       KVM: arm64: Extract MPIDR computation into a shared header
>       KVM: arm64: Make vcpu_{read,write}_sys_reg available to HYP code
>       KVM: arm64: Factor out reusable vCPU reset helpers
>       KVM: arm64: Move PSCI helper functions to a shared header
>       KVM: arm64: Implement lazy vCPU state sync for non-protected guests
>       KVM: arm64: Top up the memcache for pKVM permission faults
>       KVM: arm64: Skip pKVM stage-2 flush when FWB is enabled
>       KVM: arm64: Don't WARN on pKVM stage-2 map failures
>       KVM: arm64: Don't advertise eager page splitting under pKVM
>       KVM: arm64: selftests: Add stage-2 block transition test
>       KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT sa=
ve
>       KVM: arm64: vgic: Don't leak the SPI array when init is retried
>       KVM: arm64: vgic-its: Don't save collections the table cannot hold
>       KVM: arm64: vgic-its: Point saved ITEs at the next valid entry
>       KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
>
> Kajetan Puchalski (1):
>       KVM: arm64: vgic: Fix detection of MI on no pending LR
>
> Karl Mehltretter (2):
>       KVM: arm64: Preserve GPRs for AArch32 CP64 reads generating an UNDE=
F
>       KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID
>
> Marc Zyngier (48):
>       KVM: arm64: vgic-v3: Make vtr_to_* helpers use architectural field =
symbols
>       KVM: arm64: Move GICv3 broken SEIS implementation detection to a CP=
U errrata
>       KVM: arm64: Add a helper providing an inlined literal value for ICH=
_VTR_EL2
>       KVM: arm64: Convert most ICH_VTR_EL2 accesses to inlined literal va=
lue
>       KVM: arm64: vgic-v3: Simplify initial GICv3 configuration sampling
>       KVM: arm64: vgic-v3: Kill kvm_vgic_global_state.ich_vtr_el2
>       KVM: arm64: Add host and hypervisor vCPU lookup primitives
>       KVM: arm64: Minimise EL2's exposure of host VGIC state during world=
 switch
>       KVM: arm64: Add primitives to flush/sync the VGIC state at EL2
>       arm64: sysreg: Emit RESx/UNKN values for Mapping/Fields definitions
>       arm64: Update ID_AA64MMFR4_EL1 description to 2026-03 JSON release
>       KVM: arm64: Merge guest's HCRX_EL2 using NV_HCRX_GUEST_EXCLUDE
>       KVM: arm64: Drop __HCRX_EL2_* masks
>       KVM: arm64: Plumb HCRX_EL2.SRMASKEn in HCRX_EL2 sanitisation
>       KVM: arm64: Classify CPTR_EL2 as a SR_LOC_SPECIAL register
>       KVM: arm64: Don't evaluate HCR_EL2.NV nor HFGITR_EL2.ERET on ERET f=
ast path
>       arm64: Add ARM64_HAS_NV2P1 capability
>       KVM: arm64: Relax CPTR_EL2 handling when FEAT_NV2p1 is present
>       KVM: arm64: Relax CNTHCTL_EL2 handling when FEAT_NV2p1 is present
>       KVM: arm64: Expose FEAT_NV2p1 to NV guests
>       arm64: Add FEAT_NV2p1 detection
>       arm64: sysreg: Add NVHCR_EL2 description as a mirror of HCR_EL2
>       arm64: sysreg: Add HCRX_EL2 bits related to FEAT_NV3
>       arm64: Add ARM64_HAS_NV3 capability
>       KVM: arm64: Split NV-specific exit fixups from the non-NV handling
>       KVM: arm64: Add NV3 control bits to HCRX_EL2 sanitisation
>       KVM: arm64: Add kvm_has_nv{2,3}() predicates
>       KVM: arm64: Make HCR_EL2 a non-VNCR register
>       KVM: arm64: Add sanitisation for NVHCR_EL2
>       KVM: arm64: Add NVHCR_EL2 handling to the sysreg array
>       KVM: arm64: Add routing for NVHCR_EL2 trap
>       KVM: arm64: Add NVHCR_EL2 context switching
>       KVM: arm64: Engage NV3 ERET trap elision
>       KVM: arm64: Engage NV3 TLBI trap elision
>       KVM: arm64: Add FEAT_NV3 detection
>       KVM: arm64: Expose FEAT_NV3 to guests
>       KVM: arm64: selftest: Add NVHCR_EL2 to get-reg-list
>       arm64: Add override for ID_AA64MMFR4_EL1.NV_frac
>       KVM: arm64: Remove VM-wide VNCR mapping counter
>       KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluat=
ion
>       KVM: arm64: Consider SCTLR_EL2.M when mapping the L1 VNCR page
>       KVM: arm64: Correctly handle end of VA space TLBI invalidation
>       KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR =
unmapping
>       KVM: arm64: Sign-extend VA for range-based TLBI invalidation
>       KVM: arm64: Make VNCR invalidation participate in MMU invalidation =
retry
>       KVM: arm64: Add VNCR TLB tracking again
>       KVM: arm64: Make timer_get_offset() work in all contexts
>       KVM: arm64: Correctly cap TLBI Range to the architural limit
>
> Mostafa Saleh (4):
>       KVM: arm64: Avoid naming collision in tracing
>       KVM: arm64: Optimize protected mode with FWB and DIC
>       KVM: arm64: Fix timer offsets for non-protected VMs
>       KVM: arm64: Fix hvhe and broken CNTVOFF_EL2
>
> Oliver Upton (7):
>       KVM: arm64: Ignore writes to PMCR_EL0.N when using strict UAPI
>       Merge branch 'kvm-arm64/pmu-7.3' into next
>       Merge branch 'kvm-arm64/pkvm-7.3' into next
>       Merge branch 'kvm-arm64/feat-nv3' into next
>       Merge branch 'kvm-arm64/vncr-fixes' into next
>       Merge branch 'kvm-arm64/vtr-patch' into next
>       Merge branch 'kvm-arm64/misc-7.3' into next
>
> Qihang (1):
>       KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_=
tables
>
> Sascha Bischoff (4):
>       KVM: arm64: vgic: Free gic_kvm_info on initialization failure
>       KVM: arm64: vgic: Prevent speculative SPI array underflow
>       KVM: arm64: vgic: Reject out-of-range GICv5 PPI IDs
>       KVM: arm64: Validate GICv5 timer PPIs before claiming ownership
>
> Vincent Donnefort (1):
>       KVM: arm64: Drop %pB on nVHE panic when stage-2 is active
>
> Will Deacon (1):
>       KVM: arm64: Avoid mismatched accesses to 'struct kvm_nvhe_init_para=
ms'
>
>  Documentation/virt/kvm/api.rst                     |  11 +
>  Documentation/virt/kvm/devices/vcpu.rst            |  11 +-
>  arch/arm64/include/asm/cpufeature.h                |   1 +
>  arch/arm64/include/asm/kvm_arm.h                   |  27 +-
>  arch/arm64/include/asm/kvm_asm.h                   |   4 +-
>  arch/arm64/include/asm/kvm_emulate.h               | 107 +++++++-
>  arch/arm64/include/asm/kvm_host.h                  |  14 +-
>  arch/arm64/include/asm/kvm_nested.h                |  20 ++
>  arch/arm64/include/asm/kvm_pkvm.h                  |   8 +-
>  arch/arm64/include/asm/vncr_mapping.h              |   2 +-
>  arch/arm64/include/uapi/asm/kvm.h                  |   1 +
>  arch/arm64/kernel/asm-offsets.c                    |   1 -
>  arch/arm64/kernel/cpu_errata.c                     |  17 +-
>  arch/arm64/kernel/cpufeature.c                     |  18 +-
>  arch/arm64/kernel/image-vars.h                     |   2 +
>  arch/arm64/kernel/pi/idreg-override.c              |  10 +
>  arch/arm64/kvm/arch_timer.c                        |  15 +-
>  arch/arm64/kvm/arm.c                               |  26 +-
>  arch/arm64/kvm/at.c                                |   2 -
>  arch/arm64/kvm/config.c                            |  27 +-
>  arch/arm64/kvm/emulate-nested.c                    |  18 +-
>  arch/arm64/kvm/handle_exit.c                       |  40 ++-
>  arch/arm64/kvm/hyp/exception.c                     |  34 +--
>  arch/arm64/kvm/hyp/include/hyp/switch.h            |  42 ++--
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  11 +
>  arch/arm64/kvm/hyp/include/nvhe/clock.h            |   8 +-
>  arch/arm64/kvm/hyp/nvhe/clock.c                    |   4 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |  11 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c                 | 271 +++++++++++++++=
+++---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c              |   7 +
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  15 +-
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   5 +-
>  arch/arm64/kvm/hyp/nvhe/timer-sr.c                 |  10 +-
>  arch/arm64/kvm/hyp/nvhe/trace.c                    |   4 +-
>  arch/arm64/kvm/hyp/vgic-v3-sr.c                    |  43 +---
>  arch/arm64/kvm/hyp/vhe/switch.c                    |  62 +++--
>  arch/arm64/kvm/hyp/vhe/sysreg-sr.c                 |  21 +-
>  arch/arm64/kvm/mmu.c                               |   9 +-
>  arch/arm64/kvm/nested.c                            | 190 ++++++++++-----
>  arch/arm64/kvm/pkvm.c                              |  34 +--
>  arch/arm64/kvm/pmu-emul.c                          |  54 +++-
>  arch/arm64/kvm/psci.c                              |  30 +--
>  arch/arm64/kvm/reset.c                             |  60 +----
>  arch/arm64/kvm/sys_regs.c                          | 152 ++++++++++--
>  arch/arm64/kvm/sys_regs.h                          |  19 ++
>  arch/arm64/kvm/vgic-sys-reg-v3.c                   |   8 +-
>  arch/arm64/kvm/vgic/vgic-init.c                    |   8 +-
>  arch/arm64/kvm/vgic/vgic-its.c                     |  26 +-
>  arch/arm64/kvm/vgic/vgic-v2.c                      |   3 +-
>  arch/arm64/kvm/vgic/vgic-v3-nested.c               |   2 +-
>  arch/arm64/kvm/vgic/vgic-v3.c                      | 107 +++++---
>  arch/arm64/kvm/vgic/vgic-v5.c                      |   5 +-
>  arch/arm64/kvm/vgic/vgic.c                         |   7 +-
>  arch/arm64/kvm/vgic/vgic.h                         |  19 +-
>  arch/arm64/tools/cpucaps                           |   3 +
>  arch/arm64/tools/gen-sysreg.awk                    |   8 +-
>  arch/arm64/tools/sysreg                            |  42 +++-
>  include/kvm/arm_arch_timer.h                       |  34 ++-
>  include/kvm/arm_pmu.h                              |   4 +
>  include/kvm/arm_psci.h                             |  27 ++
>  include/kvm/arm_vgic.h                             |   4 +-
>  include/uapi/linux/kvm.h                           |   1 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  .../testing/selftests/kvm/arm64/debug-exceptions.c |  41 ++++
>  tools/testing/selftests/kvm/arm64/get-reg-list.c   |   3 +
>  .../selftests/kvm/arm64/stage2_block_transitions.c | 226 +++++++++++++++=
++
>  66 files changed, 1580 insertions(+), 477 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/arm64/stage2_block_transi=
tions.c
>

