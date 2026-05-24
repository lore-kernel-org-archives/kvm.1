Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346238F920
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779608632; cv=none; b=pI5PImwfhZGQggq5yEv9xXpD5naBBeOpQnqehLq8/Mb/2UEYMWJarujvqq76iD9DSchWIJhTNxMDITDqz1QTD8hYChhnhShjvbwsWWE9QdS9jr9BjRQBaL9o/Ylycb87bupZV1FBnK7ef36TjyV72NpNBqpjacRKXvLWNDHIvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779608632; c=relaxed/simple;
	bh=sMZJiqFYOoSGn++Vy+ItrgCs8WBaVci+YgY01KnG7fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOB6dpMm2I3PH6t2B+HcYxVnfh4oelwrIGubck+69LRjV04YWZTamMHSRK2uuyFRIjVQcxI5IgDZ0jUC2gfLJsK2bbBRsJBiZuBN7pAjKAJU9oGmc8c20f5O8acgAW8grxMOyHErMR2rY85P43exEN3LNeXlTTRW+9wnwUUC/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O66FA70G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS1GD+uu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O66FA70G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS1GD+uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779608629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=guYtmTJ2slb5RNDW22mMKN47SoDX8VY7dh3FeNFIKbQ=;
	b=O66FA70GyeLp44EN/kZGFHnEof2z3eG/twAPKKZvLVs7zTbznS79u/h7hpXATAyEgeD33a
	PwRILFqcG+F9O665PWMvK0QiOZLDMPOBVogBkEjY0SuCMw/qjaDS9PxUc28VmbaU840trQ
	Se9hsRQ8mq3PTDWIQWzcUJL/agddfY8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-7C5v1CWiMoqI4fdNrrBDbw-1; Sun, 24 May 2026 03:43:45 -0400
X-MC-Unique: 7C5v1CWiMoqI4fdNrrBDbw-1
X-Mimecast-MFC-AGG-ID: 7C5v1CWiMoqI4fdNrrBDbw_1779608624
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45aeac88af4so7129723f8f.3
        for <kvm@vger.kernel.org>; Sun, 24 May 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779608624; x=1780213424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=guYtmTJ2slb5RNDW22mMKN47SoDX8VY7dh3FeNFIKbQ=;
        b=jS1GD+uub0cWYZ1wzXWU/cBl6gcnSVr1JX79j3uoN74ScV1zkq63fIrNPcIYENejJn
         SmHeDvGS6GHuEOaaMs4dLPE6AKH5ZFOMg/fhM0F0GSAcY4zSzWFo/NszSdkA69G1OYv5
         SaesNkGCytpbNaeWkTXn71HoFmrB3aIDFaAhJbggdl4JrqI78yavhyMSXrb54V2+h4nT
         Gm/epLzUVEBUMrZDMQJahD+72cYo6rKQ20IDVkSHO//2jfx4gzC9pWTnNVvsiiVY79F/
         lUeb8hURJlB5ygwA9C7c3U/8iu5WjjA35zTq1/+92cE3rCysE1V0x3uVXFAJsjzd96oP
         kJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779608624; x=1780213424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guYtmTJ2slb5RNDW22mMKN47SoDX8VY7dh3FeNFIKbQ=;
        b=MzVKcgg4bxbZpOs2y8H1liF9QqSmEYDutCeuSt/Bstcorre0wjP+LIaSWO3N/AxQwc
         AnbYKiQdg7yDS50offk6wt2ABGER3ZzwZ6CGFyxHoBBq53ctuaOZTD1TrloaNQwbtqzK
         NUnNEDL1JoK9WN+6Dp/R41qI9mdnGPaAahhHkxMlh7Jc8KrLw1NVdNboCS+sw+b4vFDN
         kU4t6Hf/KaARVNzTsxvdxkPvuzRUTyaaMDyvl0j8IVYFNknyegf5bwKc9Mtpz+0KRLYQ
         ppCbz0DPvUoLCtPSoUm/IBAPVa739ByW5ElcL873sNcTFGESLFEtnVY9/oLRakaKovE6
         WUUw==
X-Forwarded-Encrypted: i=1; AFNElJ+62fdZy4DYeJGsudlzS3SPCNNqG02um+vKuC9ZFjCZR5HZo5OBUbwJ+bYEnUOspLyhVIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TwJyFHbT1QIUWH9KL0Y8LxomQyzuZGcIXDV4FzcnRJcNFyf3
	Yzn1pj8O/Moku6pIMZmazPPQL9bBo9rD6sxqrgCJzE/HLbUZnTtgfpJuQrJkUc3n8AHXoVxqkx9
	xSJ09Xsdx3AG0jCRVWX+c4mb975Rw0pEgEedAdSoSQPb54C8XAQck/Q==
X-Gm-Gg: Acq92OHoRn5vDj/ztwXXmuvnRU9YBE9198EsTeZVUQACdMLDMWidvJ91TEU6jLT/5JA
	bMbqTlaaJ1wWBdzz5YdrTlYQ5nn/UX8f0DjrMQMKNRDaQEn+aT9fHD6xYVwNif49YVKfSfy3mf1
	ZGv3vdOZw1iUOt7zFmFiHAO98QTMBklg5dILepMg1IagPVk+s0+0/33wYmL9fVPYpICGfeV8VjZ
	OYk1+RRXKoiFXHSm4DMWnPhUmB1YkJ+7myr8VB25OV4znfm5xaBl1jNVjg8c0gw9yuEZtL+ZQYH
	Lcu8bMhYRibDYtHEsAetEIcl8IG3T6adG21ZpRPNLn8uiew8gfG1mQAuFJU9aSSBkd6AKWJgfkt
	/RHg6RlDbkchwjElTFSigFaM8589fn7Ix2NGPyhlKduqoWDDD8GI7Vf5iYHaPgEY4nDGUjMWSHj
	PwjLBfBWu752SMcsjpednvGtE=
X-Received: by 2002:a05:6000:26d1:b0:451:1143:7df5 with SMTP id ffacd0b85a97d-45eb38e041fmr16426306f8f.41.1779608623965;
        Sun, 24 May 2026 00:43:43 -0700 (PDT)
X-Received: by 2002:a05:6000:26d1:b0:451:1143:7df5 with SMTP id ffacd0b85a97d-45eb38e041fmr16426274f8f.41.1779608623537;
        Sun, 24 May 2026 00:43:43 -0700 (PDT)
Received: from [10.41.25.122] ([77.241.232.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f548sm19154877f8f.2.2026.05.24.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 00:43:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 7.1-rc5
Date: Sun, 24 May 2026 09:43:41 +0200
Message-ID: <20260524074341.36685-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6779b50faa562e6cca1aa6a4649a4d764c6c7e28:

  Merge tag 'pci-v7.1-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2026-05-21 15:02:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 9a12fa5213cfc391e0eed63902d3be98f0913765:

  KVM: SVM: Disable AVIC IPI virtualization on Hygon Family 18h (erratum #1235) (2026-05-23 10:09:04 +0200)

----------------------------------------------------------------
Arm:

- Fix ITS EventID sanitisation when restoring an interrupt translation
  table.

- Fix PPI memory leak when failing to initialise a vcpu.

- Correctly return an error when the validation of a hypervisor trace
  descriptor fails, and limit this validation to protected mode only.

RISC-V:

- Fix invalid HVA warning in steal-time recording

- Return SBI_ERR_FAILURE to guest upon OOM in pmu_event_info()
  and pmu_snapshot_set_shmem()

- Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler

- Fix sign extension of value for MMIO loads

s390:

- Fix bugs in vSIE (nested virtualization) and UCONTROL, caused by the page
  table rewrite.

x86:

- Apply erratum #1235 workaround (disable AVIC IPI virtualization) on Hygon
  Family 18h, just like on AMD Family 17h.

- When KVM_CAP_X86_APIC_BUS_CYCLES_NS is queried on a specific VM, return
  the VM's configured APIC bus frequency instead of the default.  This
  is less confusing (read: not wrong) and makes it easier to fill in CPUID
  information that communicates the APIC bus frequency to the guest.

Selftests:

- Do not include glibc-internal <bits/endian.h>; it worked by chance and
  broke building KVM selftests with musl.

----------------------------------------------------------------
Claudio Imbrenda (5):
      KVM: s390: vsie: Fix memory leak when unshadowing
      KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
      KVM: s390: vsie: Fix unshadowing logic
      KVM: s390: vsie: Fix redundant rmap entries
      KVM: s390: Properly reset zero bit in PGSTE

Hisam Mehboob (1):
      KVM: selftests: elf: Include <endian.h> instead of <bits/endian.h>

Jiakai Xu (3):
      RISC-V: KVM: Fix invalid HVA warning in steal-time recording
      RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
      RISC-V: KVM: Fix sign extension for MMIO loads

Michael Bommarito (2):
      KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
      KVM: arm64: vgic: Free private_irqs when init fails after allocation

Osama Abdelkader (2):
      riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem() when OOM
      riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info() when OOM

Paolo Bonzini (3):
      Merge tag 'kvmarm-fixes-7.1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-s390-master-7.1-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvm-riscv-fixes-7.1-1' of https://github.com/kvm-riscv/linux into HEAD

Sean Christopherson (2):
      KVM: x86: Return the VM's configured APIC bus frequency when queried
      KVM: selftests: Verify that KVM returns the configured APIC cycle length

Tina Zhang (1):
      KVM: SVM: Disable AVIC IPI virtualization on Hygon Family 18h (erratum #1235)

Vincent Donnefort (1):
      KVM: arm64: Fix nVHE/pKVM hyp tracing error on invalid desc

 arch/arm64/kvm/arm.c                               |  4 +-
 arch/arm64/kvm/hyp/nvhe/trace.c                    |  9 +++-
 arch/arm64/kvm/vgic/vgic-its.c                     |  4 ++
 arch/riscv/kvm/vcpu_insn.c                         |  9 ++--
 arch/riscv/kvm/vcpu_pmu.c                          | 12 +++--
 arch/riscv/kvm/vcpu_sbi_sta.c                      |  2 +-
 arch/riscv/kvm/vcpu_sbi_v01.c                      |  2 +
 arch/s390/kvm/dat.c                                |  1 +
 arch/s390/kvm/dat.h                                |  3 +-
 arch/s390/kvm/gaccess.c                            |  1 +
 arch/s390/kvm/gmap.c                               | 18 ++++---
 arch/s390/kvm/gmap.h                               | 61 ++++++++++++++++++++--
 arch/x86/kvm/svm/avic.c                            | 12 +++--
 arch/x86/kvm/x86.c                                 |  2 +-
 tools/testing/selftests/kvm/lib/elf.c              |  2 +-
 .../selftests/kvm/x86/apic_bus_clock_test.c        |  4 ++
 16 files changed, 115 insertions(+), 31 deletions(-)

