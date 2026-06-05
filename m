Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBC33BBA2
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679647; cv=none; b=czSlW8YvpGRQfsouu77j2I55AUJjg6oRGiQCXG5CaQ8Q2xtLaXja/9low7sDIVUaRRfCNS9JmnzauVtPgjqSXKL6Gab1yiqEEPBagWw+dMPMbMvIn7kvwW93+/1g+dmFT6YlADYGLjP4QI/3jzTI7vv+d32Qkr+cEBn9dMXJLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679647; c=relaxed/simple;
	bh=gaTGc7qZpu0SeAc+S4FO8sK36vXv67aWhc31r/9UaMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6+oRdH4ymodAIYPXlhHT+ivABwlcyiA3lUNA/rb5tQ1oJPbgSj6wPbQO2huzgsS7e34f++QjYFE4G8SyBffoh8Jw5UDDdE7RUVo1RtUz2Z4j00/6ZbiWDFpN2y54VEshhiBK81buKO+UlPFfvTOtpeYgqn9WhilYOZ8/+fnt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNufyYFR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rpx6rA1T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNufyYFR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rpx6rA1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780679644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aND6dnM8m5dyNi3AiuogwjT7SV1eV7SsMiTXKhRj8Dw=;
	b=MNufyYFRrQW3X3hrGrhPSHKPBm6J3Ty3aovbX0vCCdCfOYgihSJQ+pLhUyWrjvNRZhzpQ9
	o3G2CwajKFbH6G2Ce3psRpmnghazroARVpGuXbh2khcEoWWGBOp7tzHB0g2BiCrjCQ8y/d
	UEVZYzC9x3323qza4KwAyYlGl4zrbvk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Itr0F2zDMGWvDXwloC3CHw-1; Fri, 05 Jun 2026 13:14:03 -0400
X-MC-Unique: Itr0F2zDMGWvDXwloC3CHw-1
X-Mimecast-MFC-AGG-ID: Itr0F2zDMGWvDXwloC3CHw_1780679642
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46010392f89so1846471f8f.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780679642; x=1781284442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aND6dnM8m5dyNi3AiuogwjT7SV1eV7SsMiTXKhRj8Dw=;
        b=rpx6rA1TGRfD/stUyqZOd9Y3K39KcBp0oVEduJauyj2OW7pDlm5i1glxkRJopf2dxo
         PBVdA+gEC3+8LKIBW9XmOSOPMhh+w9UC9gV4WtIWhi1PGniHwL/iPUf5B5s4RdE3ZqZA
         18NaWHXi8ZDDfb8ke8+kSYnYQtv2a99EORLS9An5L7ISnrxL1dDM1pMKLV8a0iPJdd/h
         ScLYjypu3GYHbLqDN+jxntSbiZOYn0MEGrROlB/n7BxptTGSggoe8D9sMhBqmy3d+tqE
         ZGtGbhAZs5mAoINftFuC4GTCOcxQTivKsFhNUehwmcyc11K+6JChEc5ofkh/TNVslkC1
         hxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679642; x=1781284442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aND6dnM8m5dyNi3AiuogwjT7SV1eV7SsMiTXKhRj8Dw=;
        b=OjY1TNeRPxUZX0ctQnx0D11v+fP/qg1cR7FUQKO8cyc0RUVEUNiOXh4gFVINKgnny8
         EoHaYFvAJ74UGL2rJePl0hkZeGmP/PFdwLTmNWZqRZWx8sa1hQR6bqYbzdxtduNcAyWh
         G9yHjq/FMyMwvV3BiIp63iqWPZV0a2Fq6wTmBXJkxr3iKmoQ+qYpKhrC7iSSpA7cbrfX
         u12uUxPS5opN1GHrnmiqgNT6lc3kv2hDd+KslfKO8pVJxvEEyk4WXLDYlDQ0PvCcTbB9
         skeBSz4FQ9PoiCRiKpo+osqPAJ0v9DTH2iiaF78HY+o81BosZc2x84f7gKXAAoCsEwxB
         RBBg==
X-Forwarded-Encrypted: i=1; AFNElJ+ucbDW75iCr4AxbY68K8zdbs0sokI2kDkGbVz650aW8bHCtbGYM7BzeIrqD2FyDn0bwPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNustB3ylx6KG23o4RM8Uf3JjCqXT2tQs52UojQFX2fDsnozBB
	SxiwrcA/U8bSAEol3at16+G1DlzF45f92RSWDSXabkYIR/wzFo3X+U+tN3DknuRQSlxp60h/MpC
	ZYVdXLnU3iO/OuyQEAVPnTunV2kTVSvrKmwSi+GvA38hIzkzTK//+OeDpci5mIQ==
X-Gm-Gg: Acq92OGospvLWgsLE4HHLDXs62gyD2Mi+NdZNc70BJ0P3U8rYQRPfA1a1vbmQgZ6CQL
	FQPnf6epB6GMjG6L8ahhzcHB2YmTndOrmebTb52KQpnXwJNCbTYk8AxtkxLTmQCeo1ZE7tYT6/9
	0WvZxx2XPPJ2h7llvT2eK1TLRft/uVyc4J5PX2UCUpoEXoLlLErPzm3zLYQNTA0Jwd0lyqtGJPz
	BNNbUPNCnpPrjJQN2XkLnRnqFbzemyuswN1fSW+RoLh6jpOiEIX538yPyy1SmC7pRE+SmwoOMOK
	Q6dpqVmvEICCKYH0PEIx9AWer5mdekrOepOHm0kIjDNHl2Q+oG/ylPHJGAiY/5LJXNPui28jw/f
	3YOAo0dYzdkIzbG6zPp7yV5zSErKRcwySSyWeE+G3soXCWWcft+/MXS682URycDQEbwfOr1+sFv
	1X3bAMudzjIwF6xTLxdVd9i33xY4l9omGiQr5fcQ==
X-Received: by 2002:a05:6000:29d6:b0:460:3233:beeb with SMTP id ffacd0b85a97d-4603233c00bmr4351382f8f.43.1780679641878;
        Fri, 05 Jun 2026 10:14:01 -0700 (PDT)
X-Received: by 2002:a05:6000:29d6:b0:460:3233:beeb with SMTP id ffacd0b85a97d-4603233c00bmr4351359f8f.43.1780679641490;
        Fri, 05 Jun 2026 10:14:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.250.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm29916060f8f.1.2026.06.05.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:14:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.1-rc7
Date: Fri,  5 Jun 2026 19:13:59 +0200
Message-ID: <20260605171359.183205-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 7ec0360122d8f5033177ed0210d5ad71ec5b50c7:

  Merge tag 'kvmarm-fixes-7.1-5' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-06-05 18:54:37 +0200)

It may not seem like that, but this should be the last bang.

Thanks,

Paolo


----------------------------------------------------------------
Arm:

- Correctly drop the ITS translation cache reference when it actually
  gets invalidated

- Take the SRCU lock for SW page table walks

- Restore POR_EL0 access to host EL0, avoiding POR_EL0 becoming
  inaccessible from EL0 after running a guest

- Reassign nested_mmus array behind mmu_lock, ensuring that vcpu init
  and MMU notifiers are mutually exclusive

- Correctly handle FEAT_XNX at stage-2

s390:

- More fixes for the new page table management and nested virtualization

x86:

- More fixes for GHCB issues

  - Read start/end indices of page size change requests exactly one per vmexit

  - Unmap and unpin the GHCB as needed on vCPU free

----------------------------------------------------------------
Claudio Imbrenda (10):
      KVM: s390: Fix _gmap_unmap_crste()
      KVM: s390: Fix _gmap_crstep_xchg_atomic()
      KVM: s390: Avoid potentially sleeping while atomic when zapping pages
      KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
      KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
      KVM: s390: Fix fault-in code
      KVM: s390: Lock pte when making page secure
      KVM: s390: Prevent memslots outside the ASCE range
      KVM: s390: Fix possible reference leak in fault-in code
      KVM: s390: Remove ptep_zap_softleaf_entry()

Hyunwoo Kim (3):
      KVM: arm64: vgic-its: Drop the translation cache reference only for the erased entry
      KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation
      KVM: arm64: Reassign nested_mmus array behind mmu_lock

Joey Gouly (1):
      KVM: arm64: Restore POR_EL0 access to host EL0

Oliver Upton (2):
      KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
      KVM: arm64: Correctly identify executable PTEs at stage-2

Paolo Bonzini (2):
      Merge tag 'kvm-s390-master-7.1-3' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-fixes-7.1-5' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Sean Christopherson (7):
      KVM: SEV: Make it more obvious when KVM is writing back the current PSC index
      KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
      KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT
      KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
      KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
      KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
      KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

 arch/arm64/include/asm/kvm_nested.h     |   4 +-
 arch/arm64/kvm/at.c                     |   6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |   2 +
 arch/arm64/kvm/hyp/pgtable.c            |   4 +-
 arch/arm64/kvm/nested.c                 |  33 +++--
 arch/arm64/kvm/vgic/vgic-its.c          |   6 +-
 arch/s390/include/asm/gmap_helpers.h    |   1 +
 arch/s390/kvm/faultin.c                 |  30 ++--
 arch/s390/kvm/gaccess.c                 |  11 +-
 arch/s390/kvm/gmap.c                    |  19 ++-
 arch/s390/kvm/gmap.h                    |   3 +
 arch/s390/kvm/kvm-s390.c                |  33 ++++-
 arch/s390/kvm/priv.c                    |   8 +-
 arch/s390/kvm/pv.c                      |  21 ++-
 arch/s390/mm/gmap_helpers.c             | 128 +++++++++--------
 arch/x86/kvm/svm/sev.c                  | 238 +++++++++++++++++---------------
 arch/x86/kvm/svm/svm.h                  |   9 +-
 virt/kvm/kvm_main.c                     |   3 +-
 18 files changed, 337 insertions(+), 222 deletions(-)

