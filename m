Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107750;
	b=JLjHhZ1Pu0xyuMQAcD7h8IGR5q6rBQFSUAaYHs58N9vsEOjUQX9m7Ksla2n9n9S6Qnu+
	 ct2HsXhWh3XROaoLnBKXmI1HMzkKMKGW58nfEyR8P2UgNV0slWVKKZQFx7DYGNGjO1kR5
	 AG2BbQaJzBvv2Qv7E7jb3CzIs8PoS1MiWaW1W7VFcfCPy8ecgiwfhHS+VYj94wKpa570J
	 XzS/t0LFutH4QSnwzFzZg//+w0IDG3fMPk0nGEuKN5lzYUEVX1w8wY3nG/Dfu3ThsRTy9
	 5tGRQItZrWMc44i/2hfxuPGIC6KmzWEtHk5c2tjaRgXFK+TVQGOeD7FI19/JDGX7qVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107750;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=TgkiQXt0qEd5fAMe/LFsA1xI2CJ6D6D3/EwyFO8PrhI=;
	b=gQAn+Lt8uHn/v3nTx3rCQOJGqi3S6jbAK6i7HKbHDp7PPqq5/Cqu38l2mMb/avEWkRo0
	 V2r42KTQ4MbVDuh44VeT9CfBTwQzyQ/2wdIFZofNUCRxnKaVJe8s9fdRuPPuiX+HbHD3U
	 XLcARRi7Gy2uiy97cx6PVMJNIN/W6P8Z7GOOUN/EEzJFmDPHfSYxIcjxru3GjYCQn506C
	 JBDydjNP8D0nyMWlgvpZCMujJ5OTK7bJgDbPMDLVjAkEpHO+lXRZePF7hxnDzAnPtujYf
	 8O93OAWDyvtKC+u+bk1R61jn/c52alU64ZAl8z7UQpr6apBZVd77H+hN8jXrzfJHXKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="H/kXk6lT";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pnFZeihr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08266606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08266606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H/kXk6lT;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pnFZeihr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795107749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkiQXt0qEd5fAMe/LFsA1xI2CJ6D6D3/EwyFO8PrhI=;
	b=H/kXk6lTEjg8VX49dn+wam8sjiezdJLzBe5HrymWCpkEfUwuh1JY2amMYgSIiIKrmQsB4l
	taYIC1YTvrkwDTQqxwe58bhrjdTcs1WgeLiaVFW/Ylt8remZn195IyqTErIqS1e6dzPqpu
	a0ETweBbUGomEF6Z/zslmSkj7jNacXg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-l3IMKBOTPjq7OO_8f105wQ-1; Thu, 19 Nov 2026 12:02:26 -0500
X-MC-Unique: l3IMKBOTPjq7OO_8f105wQ-1
X-Mimecast-MFC-AGG-ID: l3IMKBOTPjq7OO_8f105wQ_1795107745
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso16119a91.3
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107745; cv=none;
        d=google.com; s=arc-20260327;
        b=eQz0lhk64l7n2rkWACAo09stdcOkyo1ZKspPjRYOhRYy7Wg/oM7YgP5DciO8rdO9uh
         uKjDoCZdoFCJuNPGZIBjF5otFs2l5VIyc1Vunm616Re6dygNs7GrI+llw0TQziOYrXsR
         ulAkp0/jcYwJe8UfrJxpErPyuxswTA7VQJGRFKq2tFIi2EAeQ/csqDWGL6afq2auvn1n
         ckdl04xYb4cm4BcYIoThD54NiMBdZJDW/KvaQy9hsly3sXA3NfqcJAp43Vk3ZOqtzJWJ
         TNjLzt2fuPTSXg+jEAHDMx58qz5MbwGmCmX5RcgDQ9ideVO7mPMtiHK8Om/dgHMxanmx
         lRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TgkiQXt0qEd5fAMe/LFsA1xI2CJ6D6D3/EwyFO8PrhI=;
        fh=PtL9mTEegM68BZYdErRAVa25+kXiNd3Lq9ba1bVkPRI=;
        b=QgAMSF1MmMIhbziubpsyDWDkaHsPijocAoDjLmtHZBb8kjIFlePo0dyQzs8WqWW+uy
         nMsy+ugfC+AyDIXnfLWQb+JblYuwYg/7uko66wQXMvja4PPCCdTxlGUK9+J0sbD7TP10
         wO4l+ronBpdGOe2CzEnccP2aJdcEUVMc8odLieJkF+0AbElg+rcQpUQ541D41ibGtqoV
         y57LWVIGqxZbbLA149/MMem6WuRRNoPx/hiyvo7j06HUYDbCzUT9JTzYJ3Fat5VyeLYj
         GoJb0Xsb41yIlJsdKMcs/CL1S5OjuO0iPuvW1wZDIqghhUJyvWgCW1pJ7RZXalB1CXc1
         QVVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795107745; x=1795712545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TgkiQXt0qEd5fAMe/LFsA1xI2CJ6D6D3/EwyFO8PrhI=;
        b=pnFZeihrg9iOcG3LM8weQ4sVN9ZAGfGm47cK5hyGPs52VDW2mhosV/l/bQcZi/wO78
         0o0QrOK9YzjL2bUX3/nPg3dcTmS4FSXbwP9KqTdN1O7uBc81rU09Spv2e92y0NTiUVq8
         EulFSd4V/tJnXfbsr9KZXYBUpiHj5sVUrUH8qtiJ62wD/Q0bd1cgCBPq3DPMghfKA+ux
         EA4rfwzdkf0k5p+EHnWnHBXAkIe7Ivud7Brs3M5e+/TYp3ceAS5Nszcqp+DCAwORHDCk
         5mnXDx1mfDdOJulo+ugdtqjEhIln4oCEfcYfaeJxEj6+DXVER2JXcCjYaHBk48i6Uhx1
         f1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107745; x=1795712545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgkiQXt0qEd5fAMe/LFsA1xI2CJ6D6D3/EwyFO8PrhI=;
        b=Hgeh7NdPg6VqhzrbbC3Mb6l8SJhPtGeAHkBIp4qTMODn/00b3ZjSsipf9864DdVBjM
         OKKbzDfeasMnhASItfWF3zhANAWwjscmM58flgDs51UTqHn39gn2k7LgO2Pdv5f1RGjQ
         KuFQpFSEFLbyeX9mh8Q2f4nsIR1UUYyI10ZhMmoTsViEJF0JlkPMWhB83HX8QaqCXXGy
         wGytnVF3G132qeKU4JSkrnUh+WiZW6/VT6O0bO6Pp5G1fOv+zNAzHUEwq4+aex3q3lZI
         fT09inrVGk83xKRjsypf7WT6xI6rO76EIpxh+NbSRGMqKbyVO3mCPj5Prq4i5nYk/C9p
         OrUg==
X-Forwarded-Encrypted: i=1; AL+hErEzIxrEaRTPagkc2xqWgNlcucvgK8ZIbXpm/TlNfOKfJZFX6FXYS28YxrzpnUF/xS+jzqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NPJ0z8GXMz5VhxsjFFiPbabTDjnfrIv/M2ZVjznlWS8qiweKQ
	rHeGGHxl7nAKxUZun/UoQgpoE3NXEJxxZX+QCP2lbE8e53AjMYb1u5geNIIiJXHnSPRRDn1k3zQ
	fAidZXuurvP3k7GGHFAQ3kjKBAAgzOe2wWquzzqtN9WUjEE4sqYhQ1q2JczANOqEhUgyGsZ66T7
	uUEvL7CJ6D1UVtUchRSy1KZvgo05FZ
X-Gm-Gg: AZFdTZeTRPqDAEQj+UOZiWTGBvDV/dOxCz5RnJsIOF3AHIKpLSMt9kefuKGFBsuqT+K
	axY/pjO401U8QTXqdNp/nrm/f2cb/0nBcXEWUhcemc7VoGs628Jb/2YVFlhOenCY4RvggUGYEXz
	8Y/k5xwHTY83VJaCP4f0jspdouSvyqp2e3RMl79eCnqmbLGID8cwcUJFvcNmbw6koqexSuGI+LH
	v/obV6lVcHzuSlAEoMEUEnBwpe6+M082jMQ3WBPqGGS7TAbOAfddEqkEM47
X-Received: by 2002:a17:90b:4a48:b0:3b3:af45:6a6b with SMTP id 98e67ed59e1d1-3b41c7b5e76mr10145a91.3.1795107744843;
        Thu, 19 Nov 2026 09:02:24 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3b3:af45:6a6b with SMTP id
 98e67ed59e1d1-3b41c7b5e76mr9946a91.3.1795107742662; Thu, 19 Nov 2026 09:02:22
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106172107.3263617-1-maz@kernel.org>
In-Reply-To: <20261106172107.3263617-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Nov 2026 18:02:11 +0100
X-Gm-Features: AclHuK-Qf3LMzbseiJS1i8JmdlMZFytktE3YbrYDCN516IglzImVS7C0HGuzIqI
Message-ID: <CABgObfbFo3+qfpNe4tZX4jnD=GtoN43b1xMHwtbeV39Vr+LeUA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.4, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Colton Lewis <coltonlewis@google.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Gavin Shan <gshan@redhat.com>, Hyunwoo Kim <imv4bel@gmail.com>, Joey Gouly <joey.gouly@arm.com>, 
	Leonardo Bras <leo.bras@arm.com>, Lorenzo Stoakes <ljs@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Matthias Goergens <matthias.goergens@gmail.com>, Oculytic <oculytic@gmail.com>, 
	Oliver Upton <oupton@kernel.org>, Sascha Bischoff <sascha.bischoff@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Will Deacon <will@kernel.org>, Xuheng Li <xuheng@cs.columbia.edu>, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:21=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Paolo,
>
> Here's the second set of KVM/arm64 fixes for 7.4, which is a pretty
> large set as Fuad has made his mission to address each and every
> Sashiko utterance. This is great work, in all the meanings of the word
> Great.
>
> We also have a couple of more "amusing" fixes, such as the livelock
> issue that Ard managed to debug and elegantly address.
>
> As usual, details in the tag below. I'll be at KVM Forum next week, so
> I'll probably come back with another PR in time for -rc4 (I've already
> earmarked a number of patches...).
>
> Please pull,

Pulled, thanks.

Paolo

>
>         M.
>
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7=
e4:
>
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.4-2
>
> for you to fetch changes up to 181a701fc14d3d468c603b5ecfb9f12115c5fb72:
>
>   Merge branch kvm-arm64/misc-7.4-1 into kvmarm-master/fixes (2026-11-03 =
18:14:37 +0000)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.4, take #2
>
> * MMU fixes:
>
>   - Correctly sanitise the TCR_EL2 register
>
>   - Stop advertising LPA2 to NV guest when it isn't supported
>
>   - Correctly convert EH2=3D=3D0's view of TCR_EL2 into the E2H=3D=3D1 fo=
rmat
>
>   - Make sure an EL2 mapping is immediately visible to the hypervisor
>     code, as we don't necessarily require ETS
>
>   - Address a horrible situation where a guest can livelock when
>     trying to solve a permission fault whilst the underlying S2 PTs
>     have AF=3D0
>
>   - Correctly wipe MTE tags for large mappings instead of just the
>     head page, providing a convenient helper for this
>
>   - Fix dirty logging detection in ring-only mode
>
>   - Use ATS1A whenever FEAT_S1PIE is present
>
> * VGIC fixes:
>
>   - Fix a bunch of low-impact issues with GICv4, avoiding leaks on
>     unlikely failure paths
>
>   - Use a separate lockdep class for vPE doorbells, and guarantee that
>     they are never threaded
>
>   - Avoid spurious allocation of VPEs when userspace decided not to
>     expose nASSGIcap
>
>   - Fix spurious preservation of the pending state after DISCARD
>     and CLEAR ITS commands
>
>   - Make sure GITS_CTLR.Enabled is updated under the its_lock
>
>   - Serialise vgic CTRL_INIT against vCPU creation
>
>   - Make the forwarding of LPIs tobust against LPIs being disabled
>     on the target redistributor
>
> * pKVM fixes:
>
>    - Fix the reset of GICv3 LRs for pKVM, de-uglifying the PM paths
>      whilst at it
>
>    - Fix PMU handling for both protected and non-protected guests,
>      fixing the synchronisation of kvm_host_data in the process
>
>    - Correctly invalidate TLBs and I-cache when multiplexing multiple
>      vcpus of the same VM on a single physical CPU
>
> * Feature visibility fixes:
>
>   - Correctly handle ACCDATA_EL1 being exposed to guests, plugging a
>     potential communication channel between guests.
>
> * Misc fixes:
>
>   - Correctly clear the vcpu feature set on init failure
>
>   - Clear PSTATE.TCO on exit from the guest when MTE is enabled
>     for the kernel
>
>   - Let the L0 hypervisor always deal with FEAT_MOPS A/B nonsense when
>     taking such exception, instead of potentially forwarding it
>
>   - Add a "maintainer profile" for KVM/arm64
>
>   - Add testing for the MOVI and MOVALL commands
>
> ----------------------------------------------------------------
> Ard Biesheuvel (1):
>       KVM: arm64: Don't livelock when AT can't resolve a fault IPA
>
> Colton Lewis (1):
>       irqchip/gic-v4: Use a separate lockdep class for vPE doorbell IRQs
>
> Fuad Tabba (25):
>       irqchip/gic-v4: Clear the domain and fwnode pointers after freeing =
them
>       irqchip/gic-v4: Unwind what its_alloc_vcpu_irqs() allocated on fail=
ure
>       KVM: arm64: vgic: Tear down what vgic_init() created when it fails
>       KVM: arm64: vgic-v4: Restore nr_vpes before freeing the vPE resourc=
es
>       KVM: arm64: vgic-its: Clear an unqueued LPI before dropping its loc=
k
>       KVM: arm64: vgic-its: Remove the pending state of a cleared LPI
>       KVM: arm64: vgic-its: Update GITS_CTLR.Enabled under its_lock
>       KVM: arm64: vgic-v4: Don't allocate vPEs for a GICv2 VM
>       KVM: arm64: vgic-v4: Don't allocate vPEs when userspace clears nASS=
GIcap
>       KVM: arm64: vgic: Don't forward LPIs to a redistributor with LPIs d=
isabled
>       KVM: arm64: vgic-v3: Don't drop a pending LPI mapped with LPIs disa=
bled
>       KVM: arm64: selftests: Add MOVI and MOVALL commands to the ITS libr=
ary
>       KVM: arm64: selftests: Build a VM per test in vgic_lpi_stress
>       KVM: arm64: selftests: Test MOVI and MOVALL on a pending LPI
>       KVM: arm64: Disable host PMU counters for protected guests
>       KVM: arm64: Ensure TLBs and I-cache are private to each vCPU in pKV=
M
>       arm64: Add override for ID_AA64ISAR1_EL1.LS64
>       KVM: arm64: Enable ST64BV0 for guests with FEAT_LS64_ACCDATA
>       KVM: arm64: selftests: Add ACCDATA_EL1 to get-reg-list
>       KVM: arm64: Clear the VM's feature bitmap when kvm_setup_vcpu() fai=
ls
>       KVM: arm64: Clear the default PMU when kvm_setup_vcpu() fails
>       KVM: arm64: Clear the whole hugetlb folio when sanitising MTE tags
>       KVM: arm64: Clear the whole hugetlb folio when storing MTE tags
>       KVM: arm64: Sanitise MTE tags when a permission fault installs a ma=
pping
>       arm64: mte: Add mte_clear_folio_tags()
>
> Marc Zyngier (11):
>       Merge branch kvm-arm64/vgic-fixes-7.4-1 into kvmarm-master/fixes
>       KVM: arm64: Reset TCR_EL2 according to guest's E2H mode
>       KVM: arm64: Add ACCDATA_EL1 to the sysreg array
>       KVM: arm64: Add context-switch of ACCDATA_EL1
>       arm64: Add return value to mte_disable_tco_entry()
>       KVM: arm64: Reenable MTE tag checking on exit from guest when runni=
ng VHE
>       KVM: arm64: Don't let a guest overwrite HCRX_EL2.MCE2
>       Merge branch kvm-arm64/mmu-fixes-7.4-1 into kvmarm-master/fixes
>       Merge branch kvm-arm64/pkvm-fixes-7.4-1 into kvmarm-master/fixes
>       Merge branch kvm-arm64/ls64-accdata into kvmarm-master/fixes
>       Merge branch kvm-arm64/misc-7.4-1 into kvmarm-master/fixes
>
> Matthias Goergens (1):
>       Documentation/process: Add a maintainer entry profile for KVM/arm64
>
> Oliver Upton (2):
>       KVM: arm64: nv: Correctly compute the effective TCR_EL1 for nVHE TC=
R_EL2
>       KVM: arm64: Pass the PMU events to the hyp vCPU of non-protected gu=
ests
>
> Sascha Bischoff (1):
>       KVM: arm64: vgic: Serialise CTRL_INIT against vCPU creation
>
> Vincent Donnefort (4):
>       KVM: arm64: Make __vgic_v3_init_lrs HVC always available
>       KVM: arm64: pkvm: Fix missing reset of GICv3 LRs
>       KVM: arm64: pkvm: Reset GICv3 LRs in the hypervisor
>       KVM: arm64: Synchronise kvm_host_data before host deprivileging
>
> Wei-Lin Chang (5):
>       KVM: arm64: nv: Don't advertise FEAT_LPA2 for guest stage-1
>       arm64: sysreg: Add TCR_EL2 to sysreg infrastructure
>       KVM: arm64: Convert TCR_EL2 to config-driven sanitisation
>       KVM: arm64: Fix dirty logging detection in ring-only mode
>       KVM: arm64: Remove stale remark on canonical IPA alignment
>
> Will Deacon (1):
>       KVM: arm64: Use S1E1A when Stage-1 PIE is supported
>
> Xuheng Li (1):
>       KVM: arm64: Add an ISB after mapping a hyp fixmap slot
>
>  Documentation/admin-guide/kernel-parameters.txt    |   3 +
>  Documentation/process/maintainer-kvm-arm64.rst     | 181 +++++++++++++++
>  MAINTAINERS                                        |   2 +
>  arch/arm64/include/asm/cpufeature.h                |   5 +
>  arch/arm64/include/asm/kvm_arm.h                   |  13 --
>  arch/arm64/include/asm/kvm_asm.h                   |   2 +-
>  arch/arm64/include/asm/kvm_emulate.h               |   3 +
>  arch/arm64/include/asm/kvm_host.h                  |   5 +-
>  arch/arm64/include/asm/kvm_nested.h                |  38 ++-
>  arch/arm64/include/asm/mte.h                       |  14 +-
>  arch/arm64/include/asm/sysreg.h                    |   1 -
>  arch/arm64/include/asm/virt.h                      |   2 +-
>  arch/arm64/kernel/cpufeature.c                     |   7 +
>  arch/arm64/kernel/mte.c                            |  15 +-
>  arch/arm64/kernel/pi/idreg-override.c              |   2 +
>  arch/arm64/kvm/arm.c                               |  60 +++--
>  arch/arm64/kvm/config.c                            | 112 +++++++++
>  arch/arm64/kvm/guest.c                             |  11 +-
>  arch/arm64/kvm/hyp/include/hyp/fault.h             |   5 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h            |  24 +-
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  23 ++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  16 +-
>  arch/arm64/kvm/hyp/nvhe/mm.c                       |   1 +
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  22 +-
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c               |   4 +
>  arch/arm64/kvm/hyp/nvhe/switch.c                   |  24 ++
>  arch/arm64/kvm/hyp/vhe/switch.c                    |   7 +
>  arch/arm64/kvm/mmu.c                               |  21 +-
>  arch/arm64/kvm/nested.c                            |  15 ++
>  arch/arm64/kvm/pkvm.c                              |   6 +
>  arch/arm64/kvm/sys_regs.c                          |  22 +-
>  arch/arm64/kvm/vgic/vgic-init.c                    |  21 +-
>  arch/arm64/kvm/vgic/vgic-its.c                     |  68 +++---
>  arch/arm64/kvm/vgic/vgic-kvm-device.c              |   2 +
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  40 ++--
>  arch/arm64/kvm/vgic/vgic-v3.c                      |   3 +-
>  arch/arm64/kvm/vgic/vgic-v4.c                      |   5 +-
>  arch/arm64/kvm/vgic/vgic.c                         |  12 +-
>  arch/arm64/kvm/vgic/vgic.h                         |   1 +
>  arch/arm64/tools/cpucaps                           |   1 +
>  arch/arm64/tools/sysreg                            | 125 ++++++++++
>  drivers/irqchip/irq-gic-v4.c                       |  39 +++-
>  tools/testing/selftests/kvm/arm64/get-reg-list.c   |   2 +
>  .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  | 258 +++++++++++++++=
++++--
>  .../selftests/kvm/include/arm64/gic_v3_its.h       |   2 +
>  tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  28 +++
>  46 files changed, 1099 insertions(+), 174 deletions(-)
>  create mode 100644 Documentation/process/maintainer-kvm-arm64.rst
>

