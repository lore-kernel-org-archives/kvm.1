Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07D2D2397
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110823; cv=none; b=rFZt5mCfCYddsNaUeXvC2ke6iVlMo67q/jp62BM1XX0ufSvimw56MT8ytg31lJXI68bY7x0vo4KHWno0u6vXNv2EXiyaZ1GIOPMj/T2u342Jjbm2OY9gFdTAoAMeVVDPjk8kAOmm+lxKHaw5PI9hwT9PXv0YwuYw9uRLy+DCjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110823; c=relaxed/simple;
	bh=wKQwKDNlqRj/alsPodESHAr0+q9QQKmwv/8qtf5aUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXB2OlvydQLZ7vmE0+9IB3gpJ8fRPIcxd5EC/42p7vi+J+OG9uopOEOKmbI4Ruz6ZUYkRJsgkpQJbcj050uPDNnVi7PKI0bdqImcpPmMEF2S2hY403EKDauu9eqz4hKF02ayNnb+vHX+g/1B883JZ3oGopxvHf4d4O4hHVivco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6pqOgP2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgXx7SYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6pqOgP2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgXx7SYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786110814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=slKcjJ9RbZkXshOTVoAaavZk71fFNadcR8v0HO3PFY0=;
	b=G6pqOgP2/0p8rNDwj1/pRmvPh7AzZjF2YdTrBBDhT1zSFJ3Y26wwwt5CscpAvRddMTTchD
	QdBTbEPF/BKIfzThIiuUHW0zux731OOkJVzunjMW9B4cXN9FuOcWfgJBG8fgv39Ku5h/Jn
	wF6Oa9ieuLVwNARZ7zSAaCUYPqE0ZAA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-0oBbeXmvPEau58JDSmj70A-1; Fri, 07 Aug 2026 09:53:31 -0400
X-MC-Unique: 0oBbeXmvPEau58JDSmj70A-1
X-Mimecast-MFC-AGG-ID: 0oBbeXmvPEau58JDSmj70A_1786110810
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so32269185e9.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786110810; x=1786715610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=slKcjJ9RbZkXshOTVoAaavZk71fFNadcR8v0HO3PFY0=;
        b=AgXx7SYWXszJnSygDLF16/LhI67szXO0aPH7y0B45pW2xfPFWzvQv0GzTyPQfnY8uO
         rn7lold4P+Nf8U58t37Gl0o5pcYQgum9ZAyXQanG2ohd6T1eP0gDOFFC2hhMGg/+0ydq
         S1EzgRdZx9s+2VRjCYEqm607e6tHR0hOyZUOJ2eJrcP/bMVdOw/WjkKySu4/S0CKSGjS
         7zSZpWaN5jqnVa79GuiDjwGpDwGHX+/t6gTHjP3CpGy6PQj87PLZF0Gz1HptfM6lZN4v
         inCXiUmE5/rgT5OKN99NNmXclQDvpM+R4kXgJeqAhaooccL2jCjfWZhi7pVHoK6UrN0Q
         XnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110810; x=1786715610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slKcjJ9RbZkXshOTVoAaavZk71fFNadcR8v0HO3PFY0=;
        b=mWG4CE8+l2/4uQP2VZnTnLESCF9R8rdfkEVzKalr+ZhXSS+WED+pneLbqwJL0Qghcu
         BRS9Qz6IbmXLW013YLajJwZyCTf43J4hJP16Z/tEHJvqXO/oRqaro3J/pEBn+yS3ywVK
         9OmY+Wn/lePqeATt5whov/L6nwxN9VgNEn4trMxizn6W5X4eq4idySjtOjOn3iyNYd2h
         nzAlkqrnp7vUJ+/YltUomisktpCEbZjSxxCQ8+ISXZJYpGjZRDWqYyB7S7d6SW+GEzmr
         AEC/4fguSaT8uzQkbUguByugFykAbSugJMqgOrsRut7Ghz42CCDUATndZkV4FA+YOTUl
         ixtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPUN0IPFI0ZiFGLlwp0uOm4Z4+UpzdnIhN9Ta8T8+LXR8+eC2rvW4uuGGEJcyh2kErz3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpScX11qNuzi91mpp4DUbDm1U+inVcByRO91qgq8vDN0T347IC
	aiBFPFCSJ4PNNuvSRROF8/aDWeaZ8KajpIQak6I2qBS4gxfqDnUC6Jz79GdsxXw6D8X+SCE7G9W
	Az2hRpwU89olqb3XtdNOesAjcjyXxj9E41Ouv/ydfdVWiuRTi+iFi8g==
X-Gm-Gg: AR+sD137GnFXphcRn6Z4POXMzANDh9NnRT1z2uMvduRq/k7Kh0fHX/uoKm4QcOu9rcU
	FOkV3HQcHpEUU/QexPulOvT6s6ioUdZNRTuHlgQbrDED8JvYAsOTRhGmmxCXe5fFR7gCUpgpMqM
	b6VUY2MRFF8hjWInqRfxT5CzX0q4yW6+HGGkQ4cZSjZ2QRdFu31/3m49ORCkQJQPRWMWYYM0tCk
	BzgpgkIW/EWyY538XvFan7foNabdXjk5pz/pw3BgELrn/FBL8N8MDzuKA1u1Ion4JOuga2jysEQ
	Y6UZnc+eIJ/W2yDcPyYIBNGto3eJW6uIaEzZg3vHxFoZFjTJUN6Q4Kzuu4JcnTyJWjP14bysVXS
	+A7NA6raDB0kXUS6Ny6ztHjpE3w8ieGKDMZJo9qfa5uMn6tCMpZfyIZL8HfeSOofz4kzXp2Djp+
	+T8zg=
X-Received: by 2002:a05:600c:474f:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4995210c57fmr198173675e9.1.1786110810277;
        Fri, 07 Aug 2026 06:53:30 -0700 (PDT)
X-Received: by 2002:a05:600c:474f:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4995210c57fmr198173215e9.1.1786110809862;
        Fri, 07 Aug 2026 06:53:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2dc4esm46871165e9.13.2026.08.07.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:53:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
Date: Fri,  7 Aug 2026 15:53:27 +0200
Message-ID: <20260807135327.2629594-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2026-08-03 12:26:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 5ec42d57655c690234c14aece6dd3f209778c1d8:

  KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page (2026-08-07 09:26:45 +0200)

----------------------------------------------------------------
s390:
- fix a lot of small bugs and races

x86:
- fix missing locking related to KVM_CAP_MOVE_ENC_CONTEXT_FROM

- warn on creating a new page table that is the child of an invalid one,
  and limit damage before it's too late

- disable use of INVLPGA when NPT is enabled, because it doesn't seem
  to flush TLBs correctly

----------------------------------------------------------------
Claudio Imbrenda (13):
      KVM: s390: Fix unlikely NULL gmap dereference
      KVM: s390: Do not free SCA if it was not allocated
      KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
      KVM: s390: Fix overclearing ESCA in case of error
      KVM: s390: ucontrol: Fix sca_clear_ext_call()
      KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
      KVM: s390: Fix race in __do_essa()
      KVM: s390: cmma: Fix dirty tracking when removing memslot
      KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
      KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
      KVM: s390: Return -EINTR if a signal is pending while faulting-in
      KVM: s390: Fix ordering when adding to SCA
      KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()

Eric Farman (10):
      s390/vfio_ccw: Free all memory if cp_init() fails
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Fix out of bounds check on CCW array
      s390/vfio_ccw: Ensure first IDAW remains constant
      s390/vfio_ccw: Calculate idal length based on idaw type
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Implement a crw lock

Paolo Bonzini (3):
      KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
      Merge tag 'kvm-s390-master-7.2-3' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      KVM: SVM: Serialize accesses to the owner and mirror list with separate lock

Sean Christopherson (1):
      KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page

 arch/s390/include/asm/kvm_host.h    |   1 +
 arch/s390/kvm/dat.c                 |  23 +++++--
 arch/s390/kvm/dat.h                 |   2 +-
 arch/s390/kvm/faultin.c             |   6 +-
 arch/s390/kvm/interrupt.c           |  19 ++++--
 arch/s390/kvm/kvm-s390.c            | 125 +++++++++++++++++++++++-------------
 arch/s390/kvm/priv.c                |  10 +--
 arch/s390/kvm/pv.c                  |  43 +++++++------
 arch/x86/include/asm/kvm_host.h     |   2 +-
 arch/x86/kvm/hyperv.c               |   7 +-
 arch/x86/kvm/mmu/mmu.c              |   5 +-
 arch/x86/kvm/svm/sev.c              |  34 +++++++---
 arch/x86/kvm/svm/svm.c              |  27 ++++++--
 arch/x86/kvm/svm/svm.h              |   1 +
 arch/x86/kvm/vmx/main.c             |   4 +-
 arch/x86/kvm/vmx/vmx.c              |   2 +-
 arch/x86/kvm/vmx/x86_ops.h          |   2 +-
 drivers/s390/cio/vfio_ccw_async.c   |  16 +++++
 drivers/s390/cio/vfio_ccw_chp.c     |  31 +++++++--
 drivers/s390/cio/vfio_ccw_cp.c      |  74 +++++++++++++++------
 drivers/s390/cio/vfio_ccw_cp.h      |  10 +++
 drivers/s390/cio/vfio_ccw_drv.c     |  21 +++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |   8 ++-
 drivers/s390/cio/vfio_ccw_ops.c     |  39 +++++++++--
 drivers/s390/cio/vfio_ccw_private.h |  10 ++-
 25 files changed, 379 insertions(+), 143 deletions(-)

