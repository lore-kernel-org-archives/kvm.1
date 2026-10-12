Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497D48EBC5
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825868; cv=none; b=gVviqegWXGt4guqYph6Lx575Fti9xdOIqKjb1Tvj870HBlfdNffbOovCrCOx1TAyIeUTYwiUtezSGqiUwi/eP3PPqV0xOaabA8co+Z6ur2EBWUkpqX2bxw7u1588efHTFm9T8qLrUQ2m8zioIgRv5sQeJBuEAExs3RbUOuFox8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825868; c=relaxed/simple;
	bh=vdBkv0Ar/k2H9o3Cj5VAA2YQ4375ejbf9nUI5vsOQQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIZ80OIx3vLYSKh8uY7gL89IR4an7YxdxGXXU43q5XcddtjLOCULByjtpv2Xx+0orz/NGmXYvQmfU8ErVpoEwoZo0/5Z+dZtfCBC6LupUJ0S3DKHJ+unsx68XI3uD4gGmUIFsTVjad60Ia1Wf45iA+Q19hw/laip94XXKymbw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hm745Xui; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1c+Q6EG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm745Xui";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1c+Q6EG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791825865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5MCinI97TwRTst5/YFDaMtBPJlTzpwg3rQxyfSvYCas=;
	b=Hm745XuiWiKYNsRdY+iFfvwvAsOj+FDv2M84TIjdGXaiqmRA7PTS/4ZYjSzPMWVc1mvQ6b
	Ria76eRmGRFknBEPxaMmvQsICGz25gwHD8lQVwzqnVLnglnBvcBEzaNp0CyG6HAl7vesgj
	v5ZptSNop0M5VAkXrkVIb/g0AP+IFgg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-75a8GCU4ONyIo1X0f2jUIw-1; Mon, 12 Oct 2026 17:24:23 +0000
X-MC-Unique: 75a8GCU4ONyIo1X0f2jUIw-1
X-Mimecast-MFC-AGG-ID: 75a8GCU4ONyIo1X0f2jUIw_1791825863
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so31413025e9.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791825862; x=1792430662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MCinI97TwRTst5/YFDaMtBPJlTzpwg3rQxyfSvYCas=;
        b=c1c+Q6EG27M2iQ9ZUic2TskOh0kl0393uo3KJCHMU7xNi3yS+q9jTrdFYk1gmmgeBq
         nImlDIAzyfYnMCu56bnU1df3BjPZMlQgDeHStOLznra99D4y7LrbVDhrlc3I9pSgtcOx
         rYRgj9OP/KlR8Jhhy04Ic3QgccSJju07bxlWka3c1XF0dP9borQIRhnGGPehIATgHym1
         8jIIOAXbG8NvVxTAj5Xs+nPGK+IbqtI9YvaJbbDRQtYGBqkXeX3M+rkUmAZO2hobVb+/
         xWHxsVfLXB098kna4FPjgWVZKCrd8LbSuuCFC5L0NJ4iOEIlY5hTHThaKPOhV5ynhpYc
         kVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825862; x=1792430662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MCinI97TwRTst5/YFDaMtBPJlTzpwg3rQxyfSvYCas=;
        b=gvfblKt6EM6JSyotWYlzTh8R/AcUfaYJPPVd1lg0zND3DCG8qXjkXqANk1wisno6gX
         gl5D/KKvM1GRaoXCUeBaUE/6Na76hv2I0BEhlVOdGNxeIjWuU2GhIGIUpb9ga747GYHQ
         cblGCZDMMfWd+JT9+X/ZPOGIGVOwqD8xNhTra1Gf2+J4IV7KOrDTDNVIslDqNvUMSvUT
         C78Cbe5nPLgc9O4T2A5U9EXw0BTAsfnUE++a4LsmeYhoSuVqGWsO90WpvInUB9y0KSIe
         fngGutPia0t97b7MxY5kfWkstgkHbaxqxvJsXCWkkFrpZe0NI0+nmK/vm4WP/AGAWAee
         4Ovw==
X-Forwarded-Encrypted: i=1; AKwUvBwn2JxzR9sCN5UGVpDXSdsq7j8HSsaGGptcSs7SeKn2E/gRcxaeq7OTL4RBmpxEHBl6KhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKjSJH9fA2wzugYC1izc7PuiRfHKdu8pmpU62eg1R54Cu6ZwRw
	wL/NpwA6zV2gFdNpbbDkhMCBLKSztWmahNicUUfhqQHS80SeRUtw467zi//7RWVfuRxWC6z4AmC
	WsltUyP9+VYzdONrqwaHqTuFVbryUOEUPzR4TqHS4uN7Cq3OMkpJDxQ==
X-Gm-Gg: AYBFou3T+q7hATZrWOFXqj9gAwiQIHvXrGUpfntLOgd/XyKKv3jGFXpyYrngwoXsTxJ
	40tm/ew1EjFRkCFSeGHUp3AerDQbluChGasaHSlgaApmzo8nhSdWkiD1deYZfkF6GDeFCkNpjDG
	M4hAVYDcvqV1e9OJGgcIpQ3mnbdOEP2JZpaRO2g6GfArcjnwe0tpEOMbs6W8npX0qtykAM++AFE
	o3QQrg5pnGtx0P4YjN+Foowq2sqzTRBedw43UG2HU0WfOroPZYJtwWSY6jO2NDMObCiAq3n5Jxx
	nwLNGMZ+7FNgVH/FvgWQZhwYt7JSlylW15tRUdnuoltbowLhodccDw5WAWyZ8DxBFAEJiiAQAAR
	w4XiaSBeuVHfOM/TcKehSHCEr0pAu+6YuEgogrMgG421AR37PzLd3afLhA3Qcwb0VFssx7l8CgG
	IuN5cP
X-Received: by 2002:a05:600c:3e07:b0:4a1:8627:aec7 with SMTP id 5b1f17b1804b1-4a18e4987abmr166291535e9.5.1791825862151;
        Mon, 12 Oct 2026 10:24:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:4a1:8627:aec7 with SMTP id 5b1f17b1804b1-4a18e4987abmr166291025e9.5.1791825861524;
        Mon, 12 Oct 2026 10:24:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm480677705e9.8.2026.10.12.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:24:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.3-rc8 or final
Date: Mon, 12 Oct 2026 19:24:19 +0200
Message-ID: <20261012172419.138525-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to e90ab3669181c6469e3647ef2b30ae408275f496:

  KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes (2026-10-12 18:58:45 +0200)

----------------------------------------------------------------
More x86 fixes:

- Fix a WARN if the SS bit is set in #NPF exit codes; the AMD manual
  is unclear about whether it can be set when the guest uses CET but the
  SupervisorShadowStackEn feature (which KVM does not use) is disabled.
  However, Hyper-V has started using CET now that KVM supports GMET
  (it wants the two feature in pairs), and that dissolves all the doubts:
  the SS bit *is* reported and not clearing it causes a WARN and/or a
  UBSAN splat.

- If creating a vCPU ultimately fails, clear its entry in the AVIC Physical ID
  table used by hardware to perform IPI Virtualization and delivered posted
  IRQs.  I.e. plug the same use-after-free hole related to IPI virtualization
  and posted IRQs that was fixed for APICv by commit b41f2ca6c0601 ("KVM: VMX:
  Fix stale PID-pointer table entry left after vCPU free").

- Use set_page_dirty_lock() instead of set_page_dirty() when marking a page
  dirty after writing back SNP firmware's desired CPUID state to userspace.
  Using set_page_dirty() is unsafe if the page/folio isn't locked (as pointed
  out by its function comment's big DANGER warning, which no one reads given
  the number of bugs of this exact nature).

- When checking for an MMIO generation match, use the memslots for the current
  vCPU context (non-SMM vs. SMM), as a misbehaving guest can coerce KVM into
  incorrectly identifying a write as MMIO in order to bypass KVM's
  write-tracking.

----------------------------------------------------------------
Jann Horn (1):
      KVM: SEV: Fix page dirtying in sev_gmem_post_populate()

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Naveen N Rao (AMD) (1):
      KVM: SVM: Clear AVIC Physical ID table entry if vCPU creation fails

Paolo Bonzini (2):
      Merge tag 'kvm-x86-fixes-7.3-rc6' of https://github.com/kvm-x86/linux into HEAD
      KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes

Sean Christopherson (2):
      KVM: SVM: Add paranoid helper for checking if vCPU is AVIC-addressable
      KVM: SVM: Use "is AVIC-addressable" helper to sanity check load()/put()

 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  3 +--
 arch/x86/kvm/svm/avic.c        | 22 ++++++++++++++++------
 arch/x86/kvm/svm/sev.c         |  2 +-
 arch/x86/kvm/svm/svm.c         |  6 +++++-
 arch/x86/kvm/svm/svm.h         |  1 +
 arch/x86/kvm/x86.h             |  4 ++--
 7 files changed, 38 insertions(+), 16 deletions(-)

