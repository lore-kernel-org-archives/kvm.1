Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43E4AA402
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052017; cv=pass; b=Qi37HQ4+vr6/3IIDZ3GKIaq0lsURTvW1Enk8zerKs8jp5TIinL3cKeq/XB/eBHzvHKSB8HLdxb+lFWn0T/epx5+sFRD19BpRHgM4u3Eba+eSCbZiCWSgY51Ap7zNNtTJOzN9ZeAuq8I5bxpZkYgedyLnYaXpzIYgZvwQgEPvNXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052017; c=relaxed/simple;
	bh=BCYd5zKHIb6pmPgog6YamRVpW3AdTCXLTOKv22hGEBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T30TfyKpqQi9UeWtRVtsYZpe5mDDgJ31ivWd8EmCqkLnbaLhyHrfmaTSNK25RbbHam/NRYA+yXwNttXQi2XoEzMXuftTXnbkKFGEUx8htakBiPz/2rraM/oenqrpaiCxLf0vPF9lEXS+FY+UJIUFysVDOGUuwn4naRVwD8HGdng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu4PmEvP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHbiBRZS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu4PmEvP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHbiBRZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792052014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU0xO7xiIuUh7YL7a7ID/AwdZghoxbnnTVjxgl5m5Bs=;
	b=Tu4PmEvPHgdPhgxcSX6FX5sDEQMTy2FVWO/6BAyIgEnOp5aRfGYSZEYgwt3NHvwRGUgXqF
	d5aKIJVPnD/CuBMGgYIHkDcMsz+VFxm40WI+iLUgPeRuK9nEUFj+bfhfQ66Iv8cVVC8L3M
	IRfaj3zmBteXJwdgCH/pC58hkLv/rHM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-XfpLJrfNNVm9yW-EZvLjlQ-1; Thu, 15 Oct 2026 08:13:33 +0000
X-MC-Unique: XfpLJrfNNVm9yW-EZvLjlQ-1
X-Mimecast-MFC-AGG-ID: XfpLJrfNNVm9yW-EZvLjlQ_1792052012
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso5109255e9.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792052012; cv=none;
        d=google.com; s=arc-20260327;
        b=KCXqrl6HhkdA7LWCcm+EOjI8uP3BzaKYzN+rbVANWkINJYmfEUMG+V2ZKhj6V6pZBc
         MNba5Kl5vFyUZxqdFqGnYmA/XGfPe63ga1/vPD/J/y/8MC0a47DGDzLPBFItxdcM3xDU
         MmSD/OohF+IsUZrjlaGhWFTSBs38DQKlfnN7LXi5Rxd3l8gBi8bSugWc9NsIk5Jfjy3F
         rCEL1ITY5H6gwZZam1a1kSpFsfcjloX2MTK7VzNPCym8SQRvu+OG4uhdLJDuqB0Wkd+D
         //bYmNxi9Xh/FVartJZC2Wn36xjHrOSvUDE8DDk/s+8bFw6IlccN0eprdbb6UE6fJuFf
         nx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AU0xO7xiIuUh7YL7a7ID/AwdZghoxbnnTVjxgl5m5Bs=;
        fh=25boHRxvFOj+/zEYPVB3LqdssiTsKuMMbyRZCRrxu50=;
        b=VXLO0tm9RPb97FeTN/drKq2hXH9iEUC/rdjp1vxwjajajs3uAq+CTVtOXOwHB0tHxx
         nNCpBA3gxDKp0iEWJIf2gC3Pqv+BoXPnz6Y+enR4RxA1bySOPGBbRPrfnxkcKsLLpA+K
         4cBPNtEqK6OKGYt2M+fHvJ0IrCDEWAq9CTbUapL5ZuiodU/wlceRACnb0O3ifbTO6Hst
         14PZTLkTVZuJt7fWDEDnMGhSr3aWcDRUiuOgJBp6AY5jszb0Ko8SF+HZU5i55hqmvN3U
         2mJ3RJb+kjKSc1dKEXngXcuWiRkLdj/ssg5nOePqikf79lEbB9hnSu15RSEBAO0LRd9N
         +lDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792052012; x=1792656812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AU0xO7xiIuUh7YL7a7ID/AwdZghoxbnnTVjxgl5m5Bs=;
        b=DHbiBRZSPGqzkOaf/JC+AFSi+DjxBp5k4SjCnioQY42SGhkFBfLsIpb/8ki+gSoJ8A
         EquRJ9l8i9Fsn/3ZLKuFXonbsAnTBorzlgM9UN5zR/+YJ9B00DCuQIHoMhyZXrCD5F2T
         WBQUndSAMzL+itT1eG01Sj5PV1NDsNLg/JdkOb5psGZtMh1RQ/m8jXVSMCHDmVW/UcYe
         oiW49q8lUvWAqBojq/cX+J57PCDYBqY1Dk1ti5sfd9sfWY8pt+QpMB/1Fe4VlsEcyZfr
         J0kzWMwDiY01I0MtHC5T15sPUziqNZnqZFRVW9eblkH6n0Vu7UW2rT3HLaaeXTKLLylH
         6ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052012; x=1792656812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AU0xO7xiIuUh7YL7a7ID/AwdZghoxbnnTVjxgl5m5Bs=;
        b=jb/iwEw4tyzDTNB9oueiWx0swxWlSGzSvkUuMHo98ijsfbrxOd01ZxmbLAoVenTgry
         BHeS07vdmliUjhuOp4SD8WCgzPs2exUaCsUUAZmKmAyXYziXRm+DzPosevtkpScaX+Tq
         e9paLtS08T8MzYsBtFlW9vkpeyVM5kUTad9eG6fzwhFvlc6TIZ3NcyVSgOzDzXCdCNAK
         g93ltcmhuSbJgtNelXzahD0Bnz0h03U91/W4W8Mio3+GBA40aUmk2m9mDkMWVe64mrQE
         wYLrE1AZrfx2PFkKYcuWQZm8MGphz9pIawnU4jzEGI/mXu9/8Gg/bVKDMeskfZ91oSyK
         1lqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzArXny1nK/9fMngyGsEKzilhstDenmVIgMagLFfnFP9lNtv24f9MYad6mJA7yLyULlb+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrj0EpAdAys19y9gMMLzoBiM37+fXOIVLKRVC0VpvhNnWPGtLE
	yHGArWvl00m82eXiVysWTfwQFeH/Oho6mhjoRzpUnqfFzrBzol0YZIDj//7/GI0rGEofOCu0Q7h
	6fn/Uvm6H/kjLXzg4bNSFeHr93d/fc9SalgPRdPryegWHdeH5pdotiG6HJ1mTxqvkBi5q619AoO
	llvLQJ3XBsJcNUI33vvY6YpC5HLO0z
X-Gm-Gg: AYBFou31P1ZGSVIzzg6g5XPpUMraoFgeCyEOscVm8ZnNdcAmVDbyn1CFYr9NULCpM50
	UbjHg19RAJdheojU8aH8huFLEoTq8fe9FzjeIX55AAkPCxti+s57Lqoyw3h4opS/CTEUtSUhDLl
	GPlAxar3wKvDdbTom8jOtv3BfLwfmmJgw94w4KXW+1f+mm9iEltVczU6UvPpN+lIHp13nyLv966
	aaoq64Po+qYjZG7w3vr29rNWFRJLOZS6U0Q7n29WOev9+3UdhOB0Da3ffnlUw==
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18e4c05e5mr370153095e9.19.1792052012064;
        Thu, 15 Oct 2026 01:13:32 -0700 (PDT)
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-4a18e4c05e5mr370152605e9.19.1792052011600; Thu, 15 Oct 2026
 01:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015064656.1525830-1-chenhuacai@loongson.cn>
In-Reply-To: <20261015064656.1525830-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2026 10:13:17 +0200
X-Gm-Features: AclHuK-N6y3qu8Vg7-uaSs-vNc8ppvQ0yoTimFzinJPuSt1vYpru_CK0wq-a7q4
Message-ID: <CABgObfb1GuJioOC5WEEY+ZJ6zCDH-gXr2Sg+20eF4AAVyE2_NA@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v7.4
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:47=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c9=
07:
>
>   Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-7.4
>
> for you to fetch changes up to 34f4ce22cf25802d8026c60c13c2db81f8c8e3a0:
>
>   KVM: LoongArch: selftests: Enable HW PTW by auto detection method (2026=
-10-13 16:49:05 +0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v7.4
>
> 1. Add separate vmid support.
> 2. Simplify MSI intterupt injection.
> 3. Add hypercall crash support.
> 4. Allow to set pv_feature until vCPU run.
> 5. Enable HW PTW automatically in selftests.
>
> ----------------------------------------------------------------
> Bibo Mao (8):
>       LoongArch: KVM: Add vmid support for stage2 MMU
>       LoongArch: KVM: Implement vmid updating logic
>       LoongArch: KVM: Probe & enable separate vmid feature
>       LoongArch: KVM: Remove parameter "level" when injecting MSI
>       LoongArch: KVM: Remove duplicated checking with DMSI irq injection
>       LoongArch: KVM: Add hypercall crash support
>       LoongArch: KVM: Allow to set pv_feature until vCPU run
>       KVM: LoongArch: selftests: Enable HW PTW by auto detection method
>
> Chaithanya Lagisetty (1):
>       LoongArch: KVM: Return the actual error code in kvm_ipi_create()
>
>  arch/loongarch/include/asm/kvm_dmsintc.h           |  3 +-
>  arch/loongarch/include/asm/kvm_host.h              | 15 ++++-
>  arch/loongarch/include/asm/kvm_para.h              |  3 +
>  arch/loongarch/include/asm/kvm_pch_pic.h           |  2 +-
>  arch/loongarch/include/asm/loongarch.h             |  5 ++
>  arch/loongarch/include/uapi/asm/kvm.h              |  1 +
>  arch/loongarch/include/uapi/asm/kvm_para.h         |  1 +
>  arch/loongarch/kernel/asm-offsets.c                |  1 +
>  arch/loongarch/kernel/cpu-probe.c                  |  4 ++
>  arch/loongarch/kvm/exit.c                          | 11 ++++
>  arch/loongarch/kvm/intc/dmsintc.c                  | 36 +++--------
>  arch/loongarch/kvm/intc/ipi.c                      |  7 +--
>  arch/loongarch/kvm/intc/pch_pic.c                  |  6 +-
>  arch/loongarch/kvm/irqfd.c                         |  4 +-
>  arch/loongarch/kvm/main.c                          | 71 ++++++++++++++++=
++++--
>  arch/loongarch/kvm/mmu.c                           | 25 +++++++-
>  arch/loongarch/kvm/switch.S                        |  5 +-
>  arch/loongarch/kvm/tlb.c                           | 19 +++++-
>  arch/loongarch/kvm/vcpu.c                          | 15 ++++-
>  arch/loongarch/kvm/vm.c                            |  2 +
>  .../selftests/kvm/include/loongarch/processor.h    |  3 +
>  .../selftests/kvm/lib/loongarch/processor.c        | 16 ++++-
>  22 files changed, 194 insertions(+), 61 deletions(-)
>

