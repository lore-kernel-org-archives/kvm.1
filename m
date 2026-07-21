Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5D48034B
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629744; cv=none; b=VVUiAJf57MmwLWQ2zc9oTdYrjg4VcnVK7yHHl9s+0COOCaZ0uE6n9db/CwlyC1WPya3o+cWcIltn/UlpqE22n1YTBrdXlDO6VlrQzyALU8ZI5KbpmZ6Nkk/eXNKcaRSb6bsVi6gsxnMfLnH6gdsCrTuMxW9mSifNQfVUy3jLNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629744; c=relaxed/simple;
	bh=7dAhlKmppNyj7hIAU5ZDkXsen+oZubj8niV0+jlS24Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+JEj5TTO8VQBHb/mH0SIwadU/3ZXoDeG2Snq4B3RzNJ8FtmKDYD7TVLx9722iACUzGvP+PEMNH9FsvMqQUCFvcypfjol7nRqpT8NaZYbO9e/VtvxckZzNXwNcTmdleCZs8JlD8mFMHQkxn8rvSZyWsH7d2xGw+x4TvIlRLEn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP4iwvuN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t8PwoLB9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP4iwvuN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t8PwoLB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784629741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3/VMqesn4DqEZoHxDiB8UOxsgj/POJqv+nAOkfoH9Ws=;
	b=fP4iwvuNmkW5mRqhoTiO7Ma7kmXanYR8iSa+isIdWj0XJeM3/uNn9/5we4KJ9Q7x7qp8Oh
	6ZggfmK2sNajhuhsmhKPnAtSLtWB6M3ElaKlBk7ygmxErhsFM4JQ6K1dfaw0B8hlwiNqqQ
	LHC0wgmbMwL1BOHvVEFAM9Hfy7hGmqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ff3e_FSGPzG4WvU41S_uOg-1; Tue, 21 Jul 2026 06:28:58 -0400
X-MC-Unique: ff3e_FSGPzG4WvU41S_uOg-1
X-Mimecast-MFC-AGG-ID: ff3e_FSGPzG4WvU41S_uOg_1784629738
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f7039fa59so2018745f8f.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784629738; x=1785234538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/VMqesn4DqEZoHxDiB8UOxsgj/POJqv+nAOkfoH9Ws=;
        b=t8PwoLB9kJXC/JNCkuGEuvIaT84W4AH7enlLe8YpR1moaUbzd1nstdIG8aFTK0w9NO
         4evdQKG69JNyA9zhlupbCozRnNAOo3eNqjor+mLzfIbp3RPU4RzfH/4Vzf+e5/YVB5z1
         sqtv1CE49bss3KhztdpM5HISok0gvFmWM45hM513t2cQIpDbXD8tnWxkkhXkQyWZrQpN
         +NO4c7m/0yPpDsNiXDxx4LF0XUtRcL3NcjPObUS0kRUjq6VbBY9i5S1T93OwYYITlb3l
         pGkh4GXjtIWpprZaUpELC/RFCDsnfrvyhQbeMUZ8cFH+poN7729CBkOxT+bQJAyf3IXv
         py1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629738; x=1785234538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/VMqesn4DqEZoHxDiB8UOxsgj/POJqv+nAOkfoH9Ws=;
        b=RpYYNvvtSCEq489n7UYw7OeXFpapqAlzafMzlZl1Etd7VZ7n4qT5hMisChofDi3HPT
         Fyis/bjKOVRMQ5Ccdg+fdyonpUQVzkk/9yLrX4lbCx3FcNbzHRXxgAzuOpS9yCSwdjDo
         qT1FXVfAY98+WMvjwAgHGzkJBueIKdE2ja8fahSUqgN9q7XPmXB5dIjNTYmSjAXdtvn2
         HYBEDvNri+Kywl4xKrInhclrasILV7vmjkzkDn7NKX2IK3fGooDyHdPngEBUTe58RipS
         n07+TXZlRMSY0Xmi8aJ5BDql78h95lfKxNLBD4MNZNQ4x57Efxu7hWBjsk3Z4cv7/2QB
         QejQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrzg4jCRGom5qeYvjZJ5iPoanpND0LUgG8LJqs9yWfkNTA0+GLnQETb5KULBM7Tk7zi/vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNItPdaYwN2RmLWQztQzgXuctKgB3qy/0tOn+K1LiUO0QllUXv
	SP2tqMxmSXYMfJ+nWHbgOgeMez9N4gEp40fQwcnoQnqJXyqzQJ0hgLFwobPwWWCjfAOFi9NHeuW
	T4PgZxmGv86Uio4l5uXDB9I5bTHP9KzWgu3RDhwMQQYi5x3/qY6UoNA==
X-Gm-Gg: AfdE7clSj/naR+KauVtmVblIFF49EwEgncIoXHipaWY2H3XZ5OumqyNBxVIKkr8rmv+
	Q4n2V5ePkAKxOYXkQn2iKfsBqHhk2BGm8uXnTw6ufn3fASMKwzq4fQXdZO42QX251gf/j137I45
	dEzEFcTX4nbITvxsXzI6WAVmWeCj/JQBSsGAT9ymnUwToILoqo3gCSzwrVAo2LQXgzYDRWbsw9v
	4rYHuikifL1EsNu0hpz3LPdIWl4XpkYn1iruLUjLyfMwms/SLne8Df3V92Jt+1YH5i9iAOqOpMZ
	oZ5kirPcG4jq8c6eNpnQVHWW8VDasfHC8+ZwIH1llqInH8aiKiF+I60C4XN0vah/+qAyaDa3DjD
	Ayn20CbilPlXqwY/sNb0ry6h/T9aNi3ksixdALYnEbfu1buA87Myh0tSTR3lho8e7C5OYh6VYzD
	DZe4k1
X-Received: by 2002:a05:600c:6812:b0:495:5eca:f9b3 with SMTP id 5b1f17b1804b1-4955ecafb22mr81536275e9.26.1784629737700;
        Tue, 21 Jul 2026 03:28:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6812:b0:495:5eca:f9b3 with SMTP id 5b1f17b1804b1-4955ecafb22mr81536055e9.26.1784629737329;
        Tue, 21 Jul 2026 03:28:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e0fcdbsm302629135e9.2.2026.07.21.03.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:28:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.2-rc5
Date: Tue, 21 Jul 2026 12:28:55 +0200
Message-ID: <20260721102855.313301-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit fce2dfa773ced15f27dd27cd0b482a7473cdcf2a:

  Merge tag 'v7.2-rc3-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2026-07-16 16:46:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to e61e6fd4f139f2342a6bc86da602df7456ef87f6:

  Merge tag 'kvm-riscv-fixes-7.2-1' of https://github.com/kvm-riscv/linux into HEAD (2026-07-21 12:25:45 +0200)

----------------------------------------------------------------
RISC-V:

- Avoid redundant allocations when allocating IMSIC page tables

- Apply SBI FWFT LOCK flag only on successful set

- Bound SBI PMU counter mask scan to BITS_PER_LONG, since on RV32
  the PMU SBI start/stop helper can only access 32 PMU counters.

- Skip TLB flush when G-stage PTE becomes valid if the Svvptc
  extension is available.

- Always show Zicbo[m|z|p] block sizes in ONE_REG

- Inject instruction access fault on unmapped guest fetch

- Use raw spinlock for irqs_pending and irqs_pending_mask

- Fix Spectre-v1 in vector register access via ONE_REG

x86:

- Fixes to SEV selftests.

- Once free_nested() did a VMCLEAR of shadow VMCS, there's no need to VMCLEAR it
  again if the kernel is preempted and thread migration happens

- Preserve nested TDP shadow page tables if they are used as roots, instead of
  clearing them unnecessarily

- Fix use of stale data if out-of-memory happens after vendor module reload

- Check for invalid/obsolete root *after* making MMU pages available, because
  the latter can make a page invalid

- Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG

David Woodhouse (2):
      KVM: selftests: sev_smoke_test: Only run VM types the host offers
      KVM: selftests: sev_init2_tests: Derive SEV availability from KVM

Dylan.Wu (1):
      riscv: kvm: Skip TLB flush when G-stage PTE becomes valid with Svvptc

Fangyu Yu (1):
      RISC-V: KVM: Avoid redundant page-table allocations in ioremap topup

Hyunwoo Kim (2):
      KVM: nVMX: Hide shadow VMCS right after VMCLEAR
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots

Paolo Bonzini (1):
      Merge tag 'kvm-riscv-fixes-7.2-1' of https://github.com/kvm-riscv/linux into HEAD

Phil Rosenthal (1):
      KVM: x86/mmu: Fix use-after-free on vendor module reload

Qingwei Hu (1):
      RISC-V: KVM: Inject instruction access fault on unmapped guest fetch

Sean Christopherson (1):
      KVM: x86: Check for invalid/obsolete root *after* making MMU pages available

SeungJu Cheon (1):
      KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set

Shengwen Cheng (1):
      KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG

Venkatesh Srinivas (1):
      KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

Xie Bo (1):
      RISC-V: KVM: Serialize virtual interrupt pending state updates

Zongmin Zhou (1):
      KVM: riscv: Fix Spectre-v1 in vector register access

 arch/riscv/include/asm/kvm_host.h                 | 10 ++--
 arch/riscv/kvm/aia.c                              | 35 +++++++++---
 arch/riscv/kvm/gstage.c                           |  6 +-
 arch/riscv/kvm/mmu.c                              |  3 +-
 arch/riscv/kvm/vcpu.c                             | 68 ++++++++++++++++-------
 arch/riscv/kvm/vcpu_exit.c                        | 19 +++++++
 arch/riscv/kvm/vcpu_onereg.c                      | 46 ++++-----------
 arch/riscv/kvm/vcpu_pmu.c                         |  4 +-
 arch/riscv/kvm/vcpu_sbi_fwft.c                    |  6 +-
 arch/riscv/kvm/vcpu_vector.c                      | 14 ++++-
 arch/x86/kvm/lapic.c                              |  2 +-
 arch/x86/kvm/mmu/mmu.c                            | 12 ++--
 arch/x86/kvm/mmu/paging_tmpl.h                    | 10 ++--
 arch/x86/kvm/vmx/nested.c                         | 11 +++-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 16 ++++--
 tools/testing/selftests/kvm/x86/sev_smoke_test.c  |  9 ++-
 16 files changed, 180 insertions(+), 91 deletions(-)

