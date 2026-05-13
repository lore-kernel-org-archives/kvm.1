Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3544C9576
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689920; cv=none; b=GNP39eJZoreBWpsPfxN4kxjNJ/rWT8S1waTGGQGvHuKMxmqA2oTHulYLx+xf4Q4cVAVv7xjRymmUVdFwyCtHUkGdNlWtRQc7OySLAaukyACAxbhJTwaX8oj1GTCMJ7bRm9EQ+cBAPhEmrT3b9SLeOkvgszbcZk7EWdUI6VKWHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689920; c=relaxed/simple;
	bh=PCkuTE3kzglsbJ0uEeEavFEWuyZvRl6QbZmbHebTB38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjL7ytEL4OfGR0sp24pUMfBa+jmYpql6U9Fv6K71YrEyM/xc+pb4p7I6MEXLWdN1MbEhMCUGvxcyegaJBaOAVI0KwxLdmeo6uaC2Fozk4mO/KRxs/x1l7pkUZ/9nsfep88koJkGWJ8h2Ob73b5F9g398m998tuPIrBiLeFbQhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+YTqMvv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUNYZ2Jd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+YTqMvv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUNYZ2Jd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778689917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUQmNk+fWpt5MA/saxUrRE5RNIqOH/01kEZMZjjxs/w=;
	b=d+YTqMvvsHcrDkGctUvznK6KJFKkVpToX3qoLkOATxlXuJvSmdmw2NeGs4FtFC6lir9Ub0
	1wPdKwmXSl9RYWE/3o5nPW2iU2w8olOWb3i+utPwcWn3FePh8CzgV8AXETJ1am5l9ARhvu
	3ONAssUUJegmM1h9Tup0v1bbcdhMFYc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-UypTkgqmMwuhRg2XQ6wPLg-1; Wed, 13 May 2026 12:31:53 -0400
X-MC-Unique: UypTkgqmMwuhRg2XQ6wPLg-1
X-Mimecast-MFC-AGG-ID: UypTkgqmMwuhRg2XQ6wPLg_1778689912
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e89faa62eso16983725e9.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778689912; x=1779294712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUQmNk+fWpt5MA/saxUrRE5RNIqOH/01kEZMZjjxs/w=;
        b=UUNYZ2JdUivPRbJ9+8uncQwBT4pBIAwEiy6SKg+xvDNmkkRdgHCzby0CSQ458NNiJ/
         DpZFIrydhf6ObHFDriNu7Qe5HPVgvZ0hKC2wUDI/oibWJu8aB8AAxeNb9OaPknor7YVp
         ItQ7zSNjA2NMd+iMpGeHfvS8r8av1qxSVT4TL7kSjURlNbasg6/XagVdiV0DAFg3xnsb
         8Gn0Zn/Be7CcTRNUcwikLaTJy6vywpwI9vyNt9fwA5P7Te6et0MoqPbdTHK4iXwz1fl/
         iMxsVnNeJ1LpvryTpkdKuvb+k/9dOGFw8QvKQGkWrugZdVlbeFjyI0zOid2GOFVnlEL7
         cOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689912; x=1779294712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUQmNk+fWpt5MA/saxUrRE5RNIqOH/01kEZMZjjxs/w=;
        b=P214SuvPII1iDu0V6DorPARvTJqii0F1W8DMNn+VA7xZMF9YkTywU7EPahevpXBQLL
         0hP+P/wi6LqHre5bcAB3OeH34pDCxK+iolrNL2qps+7SOH/vE8N8LOEbzWWKsUbNIejZ
         iVsBLgMT7gQp5F/aSSRVhO/uqA2+RNJLvP965dDbrv46OhUhsLWs4Hw+x267DjzT3SxX
         rrJ0rUmdBN/PpBMQ8YPb2sN+WepyxyGOkDRtlmrIrVfyclKdXwYxWrTVXeyqRZ7GYnJS
         7IAfaZv41FGepHzqkiVx89DHEbcJ8U7BrxNpfhST09dcT3QK5+maXPwG1Hbem9ze6FPF
         Qk7A==
X-Forwarded-Encrypted: i=1; AFNElJ/Xs3MQ6lYCICnLONcTW3+EqBGJJZzDTcyw/1fVumNwSCKZNHzRjrZC8cmmt6N2+UETMmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8u1CtmgtMgXXeNHlPdQzq8cGws9wOEcld2EsasV7q5pOMSyd
	wECD71WbFLCk8nqfk3lcqT+lY+mUMEvZ2cmldaK2s8sKyLCmm8g5jK0Y/Tfn8kXnn2IYISePJ3L
	ppq9vyvAn0k5RS8kSHjUJ2dYwran3x4DCxiFg+LAhpkJpz45+UoWvGA==
X-Gm-Gg: Acq92OEBwJFh1h+RaCZC+HMZC1UmkWFz4AHaM/vq68q+1JPd2NbCGQzY0+6zwgiFItT
	GjOIphGeDq+WZusNqIul6SQVKslgNR53R2seDD0uURdZlRH+EdYbz4g8RaUboKhzUnzG3qXmayl
	jnyhuOGWpYTWrZoL/XAw72cc6V+UW0rMZ4SAWv1nCuT152JDPjxfMRMdwKg0xtfcta2EezgHXgI
	DWjjjQvu0SeACEzntDiCkUr0Fw7qewulcIi3v0TESwYILxgsorVZ7hHQk8x6DaZyVeYXinLKcD2
	m7kPSHuh7bn10RbU9pNsDv4EuHkq2dRLmT06FIlGQKGqMjEW/8EKr9t6oyN7WgXikO9qFDV7XkN
	+y1vuxp9ue+8WgB1SlyEYnitW0cV1vhrm1edLMwasCZUy2Jshs6dKjJGEJ87+AgMp0SYZ1neaov
	01ytRn9CI1oZ6zT2ppZZJE+1fxHeyc
X-Received: by 2002:a05:600c:5010:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fc9a02512mr56268665e9.6.1778689912128;
        Wed, 13 May 2026 09:31:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5010:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fc9a02512mr56268125e9.6.1778689911488;
        Wed, 13 May 2026 09:31:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64a017esm2124065e9.9.2026.05.13.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:31:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.1-rc4
Date: Wed, 13 May 2026 18:31:50 +0200
Message-ID: <20260513163150.3440901-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6d35786de28116ecf78797a62b84e6bf3c45aa5a:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2026-05-03 15:25:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 2d5d3fc593c9b7e41bee86175d7b9e11f470072e:

  KVM: VMX: introduce module parameter to disable CET (2026-05-13 15:38:22 +0200)

----------------------------------------------------------------
Arm:

* Add the pKVM side of the workaround for ARM's erratum 4193714, provided
  that the EL3 firmware does its part of the job. KVM will refuse to
  initialise otherwise.

- Correctly handle 52bit VAs for guest EL2 stage-1 translations when
  running under NV with E2H==0.

* Correctly deal with permission faults in guest_memfd memslots.

* Fix the steal-time selftest after the infrastructure was reworked.

* Make sure the host cannot pass a non-sensical clock update to the
  EL2 tracing infrastructure.

* Appoint Steffen Eiden as a reviewer in anticipation of the KVM/s390
  ability to run arm64 guests, which will inevitably lead to arm64
  code being directly used on s390.

* Make sure that EL2 is configured with both exception entry and exit
  being Context Synchronization Events.

* Handle the current vcpu being NULL on EL2 panic.

* Fix the selftest_vcpu memcache being empty at the point of donation or
  sharing.

* Check that the memcache has enough capacity before engaging on the
  share/donate path.

* Fix __deactivate_fgt() to use its parameter rather than a variable
  in the macro context.

s390:

* Fix array overrun with large amounts of PCI devices.

x86:

* Never use L0's PAUSE loop exiting while L2 is running, since it's
  unlikely that a nested guest will help solving the hypervisor's
  spinlock contention

* Fix emulation of MOVNTDQA.

* Fix typo in Xen hypercall tracepoint

* Add back an optimization that was left behind when recently
  fixing a bug.

* Add module parameter to disable CET, whose implementation seems
  to have issues.  For now it remains enabled by default.

Generic:

* Reject offset causing an unsigned overflow in kvm_reset_dirty_gfn()

Documentation:

* Update stale links

Selftests:

* Fix guest_memfd_test with host page size > guest page size.

----------------------------------------------------------------
Aaron Sacks (1):
      KVM: Reject wrapped offset in kvm_reset_dirty_gfn()

Alexandru Elisei (1):
      KVM: arm64: Handle permission faults with guest_memfd

Fuad Tabba (6):
      KVM: arm64: Make EL2 exception entry and exit context-synchronization events
      KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
      KVM: arm64: Fix __deactivate_fgt macro parameter typo
      KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
      KVM: arm64: Pre-check vcpu memcache for host->guest share
      KVM: arm64: Pre-check vcpu memcache for host->guest donate

James Morse (1):
      KVM: arm64: Work around C1-Pro erratum 4193714 for protected guests

Junrui Luo (1):
      KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic

Matthew Rosato (1):
      KVM: s390: pci: Fix aisb calculation

Mostafa Saleh (1):
      KVM: arm64: Remove potential UB on nvhe tracing clock update

Ninad Naik (1):
      Documentation: kvm: update links in the references section of AMD Memory Encryption

Paolo Bonzini (4):
      Merge tag 'kvmarm-fixes-7.1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      KVM: x86: use again the flush argument of __link_shadow_page()
      Merge tag 'kvm-s390-master-7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      KVM: VMX: introduce module parameter to disable CET

Qiang Ma (1):
      KVM: x86: Fix Xen hypercall tracepoint argument assignment

Sean Christopherson (3):
      KVM: nSVM: Never use L0's PAUSE loop exiting while L2 is running
      KVM: selftests: Ensure gmem file sizes are multiple of host page size
      KVM: x86: Swap the dst and src operand for MOVNTDQA

Sebastian Ott (1):
      KVM: selftests: arm64: Fix steal_time test after UAPI refactoring

Steffen Eiden (1):
      MAINTAINERS: Add Steffen as reviewer for KVM/arm64

Wei-Lin Chang (1):
      KVM: arm64: nv: Consider the DS bit when translating TCR_EL2

 .../virt/kvm/x86/amd-memory-encryption.rst         |  8 ++--
 MAINTAINERS                                        |  1 +
 arch/arm64/include/asm/kvm_nested.h                |  1 +
 arch/arm64/include/asm/sysreg.h                    |  2 +-
 arch/arm64/kvm/arm.c                               | 21 ++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  2 +-
 arch/arm64/kvm/hyp/nvhe/clock.c                    |  3 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              | 47 +++++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     | 16 +++++++-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  3 +-
 arch/arm64/kvm/mmu.c                               | 29 +++++++++----
 arch/s390/kvm/interrupt.c                          |  3 +-
 arch/s390/kvm/pci.c                                | 10 ++---
 arch/x86/kvm/emulate.c                             |  2 +-
 arch/x86/kvm/mmu/mmu.c                             | 23 ++++++++++-
 arch/x86/kvm/svm/nested.c                          | 43 +++++++-------------
 arch/x86/kvm/svm/svm.c                             | 15 ++++++-
 arch/x86/kvm/trace.h                               |  2 +-
 arch/x86/kvm/vmx/capabilities.h                    |  1 +
 arch/x86/kvm/vmx/vmx.c                             | 17 +++++++-
 include/linux/arm-smccc.h                          |  6 +++
 tools/testing/selftests/kvm/guest_memfd_test.c     |  9 ++++-
 tools/testing/selftests/kvm/steal_time.c           |  2 +
 virt/kvm/dirty_ring.c                              |  3 +-
 24 files changed, 204 insertions(+), 65 deletions(-)

