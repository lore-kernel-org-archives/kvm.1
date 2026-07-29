Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA7433046
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361513; cv=none; b=iEIjfkELO4K1XBsRPQMD6GwkKUicr/geXugRytzkbk3fQgDnadhFaMBhljtakGdn1EG7c7QXQ+QKwS+vaSe0710laUA52rxnw1l5Iqq5YyObLUy5dyub91O58vnLFG2TE4jkZxjpNnd4CE1CrVucOxPtKXenHzTwPB0gS/QgWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361513; c=relaxed/simple;
	bh=RLxHa/dIm70k5s24uMXu9x2e+m/D5ng6/HRbv0GiKrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfJCVJPJych3hTjrFmAmQxr3UN3oa+qiuhRaIILiCnBmeIpgpViJjjR7l7Uj6sSssYQfB2nI61gB/5iqNAkULWsKNZcCQZNRKn7BCH/Dk8WEoGz7Yq81n5TpNNPFh5TvF8dzDfvu5T7wyVLQIpO3JNy+bsIgrm57g6gAVoaoRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADHp8slZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=goBIXQXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADHp8slZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="goBIXQXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785361505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EQeOgVkYHom9zGwvVuCpUzwos37PadsLgERMAVSFHJs=;
	b=ADHp8slZMR1IdWPcuhY4PqwU0sRcSikptXsm43w/DZ8iRhLqL5/lxLNF/CPtRIGJQHzSMs
	vVOPKpAHljQbzZHEjdjaRY0RvgWK0qyQQfDvnhDVhPgxtfcyBxuN49//mzZkObosgn+i6R
	JdpJoSSD05Tm4TCcWcQDCfjQB0LtHfk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-dbUuOU69NMOzplWed3oPaA-1; Wed, 29 Jul 2026 17:45:03 -0400
X-MC-Unique: dbUuOU69NMOzplWed3oPaA-1
X-Mimecast-MFC-AGG-ID: dbUuOU69NMOzplWed3oPaA_1785361503
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83999cceso1127420f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785361502; x=1785966302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQeOgVkYHom9zGwvVuCpUzwos37PadsLgERMAVSFHJs=;
        b=goBIXQXkiymlV80xEhw5MSfQ71f2GUwgN5WYbDaUwAZaM1fccIhYOWxOPWIqM7/qQV
         NiWC3j/KCqeIs4sLcSSciMdouqkbTv1LjiRsGNkiVPG852f7ah24SfWOzFch/DxNB/9v
         cDZcIrGUkBLu/mcmBf9qSujPvd/sLb/iBBnoWgsDxyzkjPSdSF/er3Ve397+9/6BTr3C
         VxnD9AX14SIUjvySL1Nkspe4EzsjyXdgFNq/5kstFN1BWwidG0qlGp21aj82AqQ6Wtho
         ouImwI0U4PT1D8BcfCGVcOi5K0cI3S7OtON4S+4XLKoyTzqMlruHZe9j0PcTq5dafUJP
         AJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361502; x=1785966302;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQeOgVkYHom9zGwvVuCpUzwos37PadsLgERMAVSFHJs=;
        b=VjBu3hshnjKi61sdJkajXSrlF67VuLPkIWFQm7J/Kn2fM2d8lJWWRepEppeFP4zJJ1
         fbq/8b7J+wZDzH3u1O2knJzFyDK6VvCpKyOmxZe3+GMMc1En/5NTnCr4hV+xUg4E2VsK
         eH+l5oVkoCQS2A4aAuPvt8vMP9JslwH5ImP2cUfKw+b8Ay5KXLF3ry/mqRrcboO/DmLi
         TX6diysq4N4HRo5lX7P62uV0XxIRm0J5/j0BR6OHyqHCBbYMzuDZF1eucuyj9K68hU1I
         JentXSJlpwcD+yViJxXqqdVPuKGWOeadvzQeWIz1DF5wxmfwZbwbQOAw1sX2jhps8f6P
         gq9g==
X-Forwarded-Encrypted: i=1; AHgh+RqA6trOflnvFhsd6hiR2fyOqgX1Nk1iai3Q4Togs4Kxv0S0aq9dQ+tuhuEylqvuXG6iBdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsG9nm9K9pZiFWNP9msDpIhHW4MSiYNWHGgUYwa1FbHNDb7KjE
	4EyC72n5i7MsiLq8p4cInmZnl9Yk0OgutdvG4vyViowbPo54mSUQJK+SfDZ7TTARmoxVW6wznyJ
	oBCQ5f7WclGu/TIKqxvzG8M7Vl7+tMuZNsmb7u7cOCyQ2UrwXLXfB4Q==
X-Gm-Gg: AR+sD11P+PKdkvY/3JLh/VXTBz6VCwyp58qS1Ebef9P/vRF+VBEACf/R44uPANIE0AG
	dVwt/WYprF58ZTJOqpdZp1UT5/9Lk8IVkC3wKv7O6blapHu6Hg9aTsgZFG63ghmxa7k96JSY/Qs
	UHIWL/CyNs5xhszymzE/vj9Mrq8v1o9U+0oUyysZONW4dyh8sVYhdP2HRBNZl9kz2LfCkwEWYpX
	BluPMmlsm6R2+mQI0Ehwnpc8G+PFWnWbys9XL8eCXYbAzAqhZ6ZU0P2RjpbYGGBuw853fCF5SQo
	GWuLme3YFY1CdK32eYzMSBi0e+xYqXTqo2RXNk2q7GfhLVlfNhe0YXLGgjsDTPzS5jK2MMie8YU
	NlwF60793NfBKVBpqnWOmwSUlZYzL/iM+L8NbzkpNwWPvvnp0KgUYpeAw2scia2zHWAtkLLZr8y
	D+A40=
X-Received: by 2002:a05:6000:22ca:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-47fc81dffe8mr56778f8f.1.1785361502609;
        Wed, 29 Jul 2026 14:45:02 -0700 (PDT)
X-Received: by 2002:a05:6000:22ca:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-47fc81dffe8mr56754f8f.1.1785361502208;
        Wed, 29 Jul 2026 14:45:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef48sm10348036f8f.21.2026.07.29.14.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:45:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.2-rc6
Date: Wed, 29 Jul 2026 23:44:59 +0200
Message-ID: <20260729214500.651377-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 7d3aae206663c4e006b25a1c7a20a4029e67da76:

  KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active (2026-07-29 23:39:36 +0200)

----------------------------------------------------------------
Arm:

- Fix a tiny buglet when propagating the deactivation of an interrupt
  from a nested guest, which happened to trigger a gold plated CPU bug
  on a particular implementation

- Fix a race between LPI unmapping and mapping, resulting in leaked
  LPIs

- Make LPI mapping more robust on memory allocation failure

- Fix the handling of the EL2 tracing clock being disabled

- A couple of Sashiko-driven fixes for corner cases in the EL2 tracing
  code

- Add missing sysreg tracepoint for the EL2 code

- Tidy-up the mutual exclusion of guest-memfd and MTE

- Update Fuad's email address to point to @linux.dev

s390:

- several fixes for PCI passthru in s390 kvm

- fix a 7.2-rc regression in the adapter interrupt mapping code

x86:

- Add memory clobber to asm for VMX instructions; without one, the compiler
  could reorder them in troublesome ways because "asm volatile" and "asm goto"
  only protect against removal of the asm.

- Cancel delayed I/O APIC EOI handling before destroying vCPUs

- Check all address spaces (normal and SMM) for write tracking and large
  pages, not just the current one.

- Always update x2APIC MSR intercepts for L1 when AVIC is deactivated,
  even if not running L1.  If the deactivation is VM-wide rather than being
  caused by something in L2's vCPU state, after a nested vmexit L1 will
  be able to access the host's APIC state.

----------------------------------------------------------------
Alexandru Elisei (1):
      KVM: arm64: Reject guest_memfd memslots when the VM has MTE

Carlos López (2):
      KVM: arm64: vgic: Fix race between LPI release and re-registration
      KVM: arm64: vgic: Mitigate potential LPI registration failure

D Scott Phillips (1):
      KVM: arm64: vgic: Avoid double-deactivate of IRQs in the nested context

Farhan Ali (6):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
      KVM: s390: pci: Fix missing error codes and memory unaccounting
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Fix resource leak on IRQ registration failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Fuad Tabba (1):
      KVM: arm64: Update Fuad Tabba's email address

Jaehoon Kim (1):
      KVM: s390: Fall back to short-term pinning in MAP ioctl

Jinu Kim (2):
      KVM: x86/mmu: Check write tracking in all address spaces
      KVM: x86/mmu: Check all address spaces before skipping unsync

Paolo Bonzini (3):
      Merge tag 'kvm-s390-master-7.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-fixes-7.2-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      KVM: VMX: add memory clobber to asm for VMX instructions

Sean Christopherson (1):
      KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active

Vincent Donnefort (4):
      KVM: arm64: Fix hyp_trace clock disabling
      KVM: arm64: Fix potential leak in hyp_trace_buffer_alloc_bpages_backing
      KVM: arm64: Fix hyp_trace_desc allocation size in hyp_trace_load()
      KVM: arm64: Add missing hyp_enter when trapping sysreg

Weiming Shi (1):
      KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs

 .mailmap                                     |   1 +
 Documentation/arch/arm64/silicon-errata.rst  |   4 +
 Documentation/virt/kvm/api.rst               |   6 ++
 Documentation/virt/kvm/devices/s390_flic.rst |  15 +++-
 MAINTAINERS                                  |   2 +-
 arch/arm64/include/asm/kvm_hypevents.h       |   1 +
 arch/arm64/kvm/arm.c                         |  25 +++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c           |   1 +
 arch/arm64/kvm/hyp_trace.c                   |  36 ++++++---
 arch/arm64/kvm/mmu.c                         |   4 +
 arch/arm64/kvm/vgic/vgic-its.c               |  25 +++++--
 arch/arm64/kvm/vgic/vgic-v3.c                |   8 +-
 arch/arm64/kvm/vgic/vgic.c                   |  18 ++---
 arch/s390/include/asm/kvm_host.h             |   5 ++
 arch/s390/kvm/interrupt.c                    |  56 ++++++++++----
 arch/s390/kvm/pci.c                          | 107 +++++++++++++++++++++------
 arch/s390/kvm/pci.h                          |   2 +
 arch/x86/kvm/mmu/mmu.c                       |  22 +++++-
 arch/x86/kvm/mmu/page_track.c                |  32 ++++++--
 arch/x86/kvm/svm/avic.c                      |   8 --
 arch/x86/kvm/vmx/vmx_ops.h                   |   8 +-
 arch/x86/kvm/x86.c                           |   6 ++
 include/kvm/arm_vgic.h                       |   3 -
 23 files changed, 298 insertions(+), 97 deletions(-)

