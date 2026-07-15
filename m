Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3543C065
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110412; cv=pass; b=VDNsVaeww0fUI2F8KTZ6sReTB9iGEvYUDIDqGdt64+MwmEO4CJWeM6R/Umh5DpPvDYF/mSiFgFShi6XVUBrLx3WJ/i2XJEJNa3fcrHC23QMaGXvs2Je5r4z+FE3gni+/gK6ln7pBe6o3rhey4ihuhDvmezIs+tJotwF4W6yTu/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110412; c=relaxed/simple;
	bh=X9RYK8R01XKRF0/cCXIAYcZZgAv5Pzqa1jQEbwt5vfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/WY8Zd51P1iddToZw6VdJvYZ5abTDVlz/BTT3oAKMWlMx2nKcqdeORxdHUZCEKqXH6nB5YJMK/T2Eyh+H4ek4JmXylu3W9ohAyPtKEdGRe8wu+E9EikDdfOjE8iXh85tqZjAohAXG4z0j+/tTFEZM8UYRATg7beE3u+Bjkyvtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2LnATXk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVce3R/O; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2LnATXk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVce3R/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jZxb/DyGzc2Aox27RZLCNs8CB48ahE7uYx1FJS8/x4=;
	b=h2LnATXky627HUxuQiN5ZTvRQd+nCrYXbAI2VyfS2ifrkzb1WKuvpz65Bs6oewXdnXHCdv
	FGzX/gWSStfPH5XIfRtmkrU410tfWo2teFITyh9SWhI5cTrEbO0cefzUTeghj4NbmgB0Gx
	3r+AAgwCVV1Yorxd465alE8d/igUmOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Ndga9J8tM6au63apa9_hBg-1; Wed, 15 Jul 2026 06:13:27 -0400
X-MC-Unique: Ndga9J8tM6au63apa9_hBg-1
X-Mimecast-MFC-AGG-ID: Ndga9J8tM6au63apa9_hBg_1784110406
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c20d0468so21903335e9.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 03:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110406; cv=none;
        d=google.com; s=arc-20260327;
        b=KL3TBnXfc66sD8HRMvBhmoVKAdFPEmyX0DfaZvIph0mpxQMyeFyU98gyuUGfUae43v
         9bPKK5nVQ08w4NtQVX6wGSFK7lojcNcTLJMi//f+b1yy69mAnp2FgdsM/1MMwCR+oruq
         lShwHE3s7DeyhR963Hmn9FlWmk3sgLRdx+3X0SfYdrNKCdrlMpTmvy3pj5g+KSIuFbdp
         RitTZVRx1sD21hv1wOPbgM3U9fUMpM5d9C7v16JBhpwo8fH0O+YVVWsyeZ5iBn2UCiaK
         0reL4hxrNO15UPzFYTvgX7GOOlZrcTcACcoA7QlNOv7LEE1LiuhhpU7rK9hwT04FpmmH
         dy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1jZxb/DyGzc2Aox27RZLCNs8CB48ahE7uYx1FJS8/x4=;
        fh=Uc5dsrfbSyRkUFhFNzgLiT+5J9WM3HcFNjbJfBsGDj0=;
        b=GG0RTJ4KLJKj14MQTJxEPt4+0BlFKWxiBRw6fau8jNlQiAOCT8ecXOTb+kS4Whz0Yv
         uuwWi912ytJicJtHwKdxf2Xz08ySeAUqW2g5yQgvJ5NDwjMxRjAuz/DP5a3PkFdZAkNs
         CA70QrQ/ktEMqjrFCU2ddnGOUZVWVaoHXnwEDJ1l9GTvtH72fq5iDsBxT2a+nIk4w/fT
         d0WPOKsv0hyfZpVEG1fCZgR2kHs420/mfjwZrdlhnD1UW2Lz5OmB7FwjeS66tpSPdPIt
         kIHWLB0Wd1no9M1jG4mswN8UFfXddjkY2EQW0V87wWf99rJAJGtOvcJV0vQoFDSnjuQE
         3seg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784110406; x=1784715206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1jZxb/DyGzc2Aox27RZLCNs8CB48ahE7uYx1FJS8/x4=;
        b=WVce3R/OdtgN3jgTms5s5jJCduWJfHZQnE5pxOzTjse3FVWktcp2e6QqmtoyX+Ie6p
         G95r1ek9IdIzKH8xrKD8qctzbtRIeLAbaCLe3k6fRkF9JIpS6m6zdlp4sQ0izqA/Urri
         jxPqUIOLVf45XM0oRJhPLTkzANJZ8duWe8QMm3QP7Z+useEVKTSDKJujt5dZBdtksk7c
         KDhkLF3X/TfvP2vpqm9To8/OCNv3s5U3HkOl/yopvf7YuYGKJbI00OuREyvSEQQysPFP
         P56VFzHNfUvclKcl0l+5X9jTTg50u7FqCokRDlnP6DAoIISuQtPJv7m3AKV/r8W7By8c
         exMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110406; x=1784715206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jZxb/DyGzc2Aox27RZLCNs8CB48ahE7uYx1FJS8/x4=;
        b=LT2oP3+NLojmRm/qBaUe1Mv+FFaWX34j3fyUDJ03QgLEcNE3K+NI50hOjDd3Gem3KJ
         2PVfHoXd3SnvufrHHu1qcgnRGNocLjy0wjLO0DLp+SczIl4THY/SBdOaBW3CJRmSrSM1
         E5fxSmKIGqeZA9KAiPS4uwIJi5HFcxnt6NJzDvCPdVDwJYODTZ+k3clGIyfcu48IaDtW
         dczICInRiPu8qFIb9y0EG4PzY3+AQ2SP0Z61jALobkIlRxjKgSE8jWLoi89jTphg/YgW
         x+obIGrLV3d35741ynlx85XnUVs+IWsVeUR7MT1iqDT2h+Nx5vdyxg7zuaFMnFpaAq/5
         9wNg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8s16HAT7FDDKq5DasZvXGptDHvUVl9GcQGnFv2vJNkLCMLLmIcrF6fHCUaTgZ8MwZTt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG8Oq1q5GhTiSQ/k3Jf5uBjxd4t5HG5qXCTInnIDFpk7Kl+YU
	MsLD6rwD/lY0Xv5L/P10kVNRWTRzV0ZF6RvY+8pYvPe4U9m84QRf5c4l05vdy4hOqEtlUbwGycc
	XilJllo1fsCfe4WLIBE2VTc8GukQ36spF8+4MPP6I5eYzUiOLklRh3KAh6VKk0Hkb88HeF+4WHa
	nRGS9vQDFagKnZr9A8KWtDvQpDlTaF
X-Gm-Gg: AfdE7cnC6FD0rIVoGbaGTQfIY9ofyjfoGQ2v4jNeZ1RoAWiBR90ugDMbxkIlVLhG1a1
	K2Im69IeMYTlvFPO0dAz47zSFEcfy4GYiObLI5oDGzXG8N9xMUOvrFDRWUvgRUEwjQAhXdinXka
	j58wJfRPn3/Z9y3pA48O1o1RIJ/nv7zykke/zWa5QO/j2fPyh2REA9Gcch3GfqS3mILs7+b8deI
	L+PiK3cZ+2Dldg/nVAcSzp9mzvOfRKnnUQsJH7vR6Lr46EYXkkH/+CQJpuVMQs3yzCoAg==
X-Received: by 2002:a05:600c:4e50:b0:495:3f48:5df2 with SMTP id 5b1f17b1804b1-4953f48693emr7640235e9.29.1784110406244;
        Wed, 15 Jul 2026 03:13:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4e50:b0:495:3f48:5df2 with SMTP id
 5b1f17b1804b1-4953f48693emr7639785e9.29.1784110405766; Wed, 15 Jul 2026
 03:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626133526.817232-1-maz@kernel.org>
In-Reply-To: <20260626133526.817232-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Jul 2026 12:13:10 +0200
X-Gm-Features: AUfX_mxVOlhzpUoKqPqzo5NYFwSGnaFmiBzLMOnOOVrVLohEJlEsW4snDDbir2w
Message-ID: <CABgObfY=eyZ6=hLsJ2mH8=ojthafiOzo5OCrae6W48JD4SxSjQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.2, take #1
To: Marc Zyngier <maz@kernel.org>
Cc: Bradley Morgan <include@grrlz.net>, Fuad Tabba <tabba@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Oliver Upton <oupton@kernel.org>, Weiming Shi <bestswngs@gmail.com>, Will Deacon <will@kernel.org>, 
	Xuanqing Shi <shixuanqing.11@bytedance.com>, Zhong Wang <wangzhong.c0ss4ck@bytedance.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 3:35=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> As predicted, here's another largeish set of fixes for KVM/arm64. A
> bunch of them are fairly benign (the PSTATE.IL stuff), but some are
> pretty annoying (vgic, MOPS) and are stable material.
>
> On the bright side, Fuad has volunteered to be an official reviewer.
> We really need people to engage with the reviewing process instead of
> simply dumping patches on us, as me and Oliver really can't be
> stretched much further. So many thanks Fuad for offering to help.

Indeed, thanks very much!

> I expect to be back next week with a similar delivery, as my Inbox
> keeps filling with this stuff...

Pulled, thanks. Sorry for the delay (though it was known in advance).

Paolo

> Please pull,
>
>         M.
>
> The following changes since commit 1ee27dacbe5dc4def481794d899d67b0d45700=
94:
>
>   Merge branch kvm-arm64/nv-mmu-7.2 into kvmarm-master/next (2026-06-12 0=
9:29:34 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.2-1
>
> for you to fetch changes up to d098bb75d14fde2f12155f1a95ec0168160867ce:
>
>   KVM: arm64: account pKVM reclaim against the VM mm (2026-06-22 10:48:08=
 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.2, take #1
>
> - Fix an accounting buglet when reclaiming pages from a protected
>   guest
>
> - Fix a bunch of architectural compliance issues when injecting a
>   synthesised exception, most of which were missing the PSTATE.IL bit
>   indicating a 32bit-wide instruction
>
> - Another set of fixes addressing issues with translation of VNCR_EL2,
>   including corner cases where the guest point that register at a RO
>   page...
>
> - Don't warn when trapping accesses to ZCR_EL2 from an L2 guest, as
>   that's not unexpected at all
>
> - Address a bunch of races with LPI migration vs LPIs being disabled
>
> - Fix a total howler of a bug combining FEAT_MOPS and NV, resulting in
>   exception returning in the wrong place...
>
> - Coerce Fuad Tabba into a reviewer role, and may his Inbox catch
>   fire!
>
> ----------------------------------------------------------------
> Bradley Morgan (1):
>       KVM: arm64: account pKVM reclaim against the VM mm
>
> Fuad Tabba (11):
>       KVM: arm64: nv: Write ESR_EL2 for injected nested SError exceptions
>       KVM: arm64: Sync SPSR_EL1 when injecting an exception into a pVM
>       KVM: arm64: nv: Fix PSTATE construction on illegal exception return
>       KVM: arm64: Add Fuad Tabba as a reviewer
>       KVM: arm64: Set ESR_ELx.IL for injected undefined exceptions at EL2
>       KVM: arm64: Unconditionally set IL for injected undefined exception=
s
>       KVM: arm64: Unconditionally set IL for injected abort exceptions
>       KVM: arm64: Set IL for injected FPAC exceptions during ERET emulati=
on
>       KVM: arm64: Set IL for emulated SError injection
>       KVM: arm64: Set IL for nested SError injection
>       KVM: arm64: Set IL in fake ESR for pKVM memory sharing exit
>
> Hyunwoo Kim (1):
>       KVM: arm64: vgic: Check the interrupt is still ours before migratin=
g it
>
> Marc Zyngier (1):
>       KVM: arm64: vgic: Handle race between interrupt affinity change and=
 LPI disabling
>
> Oliver Upton (6):
>       KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
>       KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
>       KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PF=
N
>       KVM: arm64: nv: Re-translate VNCR before injecting abort
>       KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
>       KVM: arm64: nv: Mark VM as bugged for unexpected VNCR abort
>
> Weiming Shi (1):
>       KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
>
>  MAINTAINERS                             |   1 +
>  arch/arm64/include/asm/kvm_nested.h     |   8 ++
>  arch/arm64/kvm/at.c                     |   8 --
>  arch/arm64/kvm/emulate-nested.c         |  37 +++++--
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  11 ++-
>  arch/arm64/kvm/hyp/nvhe/pkvm.c          |   3 +-
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c      |   3 +-
>  arch/arm64/kvm/inject_fault.c           |  18 +---
>  arch/arm64/kvm/nested.c                 | 164 ++++++++++++++++----------=
------
>  arch/arm64/kvm/pkvm.c                   |   2 +-
>  arch/arm64/kvm/vgic/vgic.c              |  20 ++--
>  11 files changed, 149 insertions(+), 126 deletions(-)
>

