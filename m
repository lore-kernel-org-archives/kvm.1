Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486935B125
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813372; cv=none; b=NpazyEl3exEuMCanrYy9SVA9JzEoo+kwjOzJ0IAVS4gRt1YEocTvV8bahTcXGfZgzw6kyMD3WKYN8ZyL6wJu4regI0L3ZVQCAs66ivEzFaUGZP8nWOp+Vbaqaa4zgMIvp8XCaDgNSH0jb/AdbN8bJpccGZuVLqMVyVU2h1bE8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813372; c=relaxed/simple;
	bh=Rot/SXQ8dEiEbDELhyjWeMwkyYMZDUzgGvvDVxUxoOM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XbpVKYmNJrz+Wp8KxP3i08UdJiC5ffEd12oycpI9dvAHc7xgc4xFJS1MdVqCVTDFh/x7wCN8hQ3t0UakCvKjGKbsY1Ufx9pudviUPsDNSofWmXcmjcbnfN5JZhA+bjjPDeX64mzLFVkAjE97LbtVkXhIl5RHyKSOE+/70tWhgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzzwenao; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzzwenao"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so50254535ad.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813371; x=1777418171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E53Vsp5SigylH1BGAw2CFNHTfpSAIZOTzOsysIgRH5Q=;
        b=tzzwenaoznNAs2DmCvHRldjlXqYA+CIDQHOFlI5WIQibVLChGpxNHqAlw9+4bZczRf
         NWyF50ywQdQesx/1fnzV5y/K+Bg43P+Wb6aa5gnIRmLWHj7vqOO96qX3vcF6Bzmy4lsn
         Wl66lShReb7fr4O6/UHNZtz2tDhc+s4x9NGMJWUKCohVXNEwZ3HldRyX8r569l5NtptK
         TSM/OIzBW7Bu4i6Ej2STMgbrTpvnLdcbzXNFCjS9MINEphO+kmGWaMhevg0Wml6K1pC2
         B00TcWAOH0FOO0Sc5LT40HFZhF2MEG6ilCcynkiZMwf7Emuzx/zuqZY1sc51Jt5QilHA
         fGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813371; x=1777418171;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E53Vsp5SigylH1BGAw2CFNHTfpSAIZOTzOsysIgRH5Q=;
        b=rgGCFeuU8oNBij1u4eKpx0hmYq22Dsn+tDZZ4l9KUDQF19T7jagBbTc28yYeD4kAvy
         NWhKcAkIvl2bhIHoATiJ9Uhmz165HVP57n8YXIiSipP2C1RZ2vqXH8lfVQfNRVVAo9n9
         +NJvga35mkWuuDZ1gKBa+wWfGN8MWHvTwbU7r+CN8AXp9iBZrkdBajUPbfYKJZjVYSl9
         t2sBD3xhAUuoBBubmgLTkV8rJSktDyewK3E8WTHWAw5U5AkwuF8/bkd43MJ48potn7xB
         rq1bo9kXCU6d60OYONKwptUsDTs9B0BRNX8N9l2EvLNpU9KNXa+iOGMQDnCD6baDYTdX
         etwg==
X-Gm-Message-State: AOJu0YyNRsjhbAqX0LuxCdY6zVYfjrWS9sGT0qMxyCt37V3bHMLWiixu
	SSLAD9d2fcQd9O5/yga4H4Dqh90oT1QaPVbDe7I3GrVmJHBU0Tazhu/oRJ3nM5XX+iHUD+H22+K
	DOypKFwTN
X-Received: from plpn23.prod.google.com ([2002:a17:902:9697:b0:2b0:b92b:a3d4])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c403:b0:2b2:5a5a:4f2f
 with SMTP id d9443c01a7336-2b5f9fc4d06mr215637055ad.33.1776813370676; Tue, 21
 Apr 2026 16:16:10 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:41 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-1-jrhilke@google.com>
Subject: [PATCH v3 00/16] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v3 of a series which introduces tools/testing/selftests/kvm/irq_test.c
in KVM selftests. This test exercises the delivery of interrupts (both
emulated via eventfd and real from a VFIO device) to guest vCPUs. Beyond basic
injection, the series adds coverage for several complex scenarios, including:
- Dynamic updates to KVM's GSI routing table while interrupts are active.
- Waking up halted vCPUs via interrupts.
- Stressing interrupt delivery during random host IRQ affinity changes.
- Stressing interrupt delivery during random vCPU thread migration across
  physical CPUs.
- Testing non-postable interrupt remapping (using NMIs to force transitions).
- Supporting both xAPIC and x2APIC modes in the guest.

The series also links the VFIO selftests library into KVM selftests to enable
testing of VFIO-KVM interactions.

The test can optionally use a PCI device bound to vfio-pci to test physical
device interrupts. If using a device, it can be invoked by passing the BDF to
the VFIO selftests setup script, and then running the test with the device BDF
passed via the -d option:
$ ./tools/testing/selftests/vfio/scripts/setup.sh 0000:6a:01.0
$ tools/testing/selftests/kvm/irq_test -d 0000:6a:01.0

This test only supports x86. Testing physical device interrupts (-d argument)
requires a device with a supported VFIO selftest driver. Currently supported
devices include:
- Intel DSA (Data Streaming Accelerator), 8086:0b25
- Intel IOAT (I/O Acceleration Technology), 8086:2021

The test can be run with following command-line arguments allow for broad
coverage of the interrupt delivery path:
-a: Random IRQ Affinity. Randomly affinitizes the device IRQ to different host
    CPUs to verify stable delivery during interrupt steering changes.
-b: Block vCPUs. Causes vCPUs to HLT instead of spinning, verifying that
    Posted-interrupt wakeup (PIW) correctly kicks blocked vCPUs.
-c: Clear GSI Routes. Periodically destroys/recreates KVM's GSI routing table to
    verify handling of dynamic IRQ updates.
-d: Device MSI Triggers. Uses the physical device to trigger MSIs instead of
    eventfd emulation (requires a supported device driver).
-i: IRQ Count. Sets the number of interrupts to generate (default 1000).
-m: vCPU Migration. Migrates vCPUs to random physical CPUs to verify that
    posted interrupts follow the vCPU across host cores.
-n: NMI Delivery. Routes interrupts as NMIs into the guest to verify the
    VFIO-NMI delivery path.
-v: vCPU Count. Distributes interrupts across multiple vCPUs via round-robin
    routing.
-x: xAPIC Mode. Forces legacy xAPIC mode to verify compatibility.

The series also links the VFIO selftests library into KVM selftests to enable
testing of VFIO-KVM interactions.

Changelog
---------
v3:
- Split monolithic test patch into smaller, logical patches (Sean).
- Moved guest read/write macros to separate patch and renamed them (Sean).
- Extracted /proc/interrupts parsing logic into separate helpers (Sean).
- Renamed guest_rng to kvm_rng for consistency (Sean).
- Added helper to generate random u64 in range [min,max] (Sean).
- Added support for printing vCPU affinity on timeout.
- Removed configurable timeout argument.

v2:
- Split the monolithic test into a series of logical patches (Sean)
- Move READ_FROM_GUEST and WRITE_TO_GUEST macros to kvm_util.h (Sean)
- Add gettid, sched_setaffinity, and sched_getaffinity to kvm_syscalls.h (Sean)
- Extract /proc/interrupts parsing logic into lib/irq_util.c (Sean)
- Add -t command-line option for configurable interrupt timeout (Sean)
- Improve assertion messages with specific vCPU failure context (Sean)
- Update guest loop to use cpu_relax() when not blocking (Sean)
- Add KVM_RANDOM_SEED support to kvm_selftest_init for reproducibility (Sean)
- Randomize the default IRQ vector and GSI (Sean)
- Use kvm_mmap() instead of mmap() (Sean)

[v2] https://lore.kernel.org/kvm/20260331194033.3890309-1-jrhilke@google.com/

David Matlack (13):
  KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
  KVM: selftests: Add /proc/interrupts parsing helpers
  KVM: selftests: Add guest read/write macros
  KVM: selftests: Add IRQ injection test
  KVM: selftests: Verify device IRQs are routed to vCPUs
  KVM: selftests: Verify IRQ affinity changes
  KVM: selftests: Verify IRQs wake up halted vCPUs
  KVM: selftests: Verify dynamic IRQ routing updates
  KVM: selftests: Configure number of IRQs
  KVM: selftests: Verify non-postable IRQ remapping
  KVM: selftests: Verify vCPU migration during IRQ delivery
  KVM: selftests: Configure number of vCPUs
  KVM: selftests: Add xAPIC support

Josh Hilke (3):
  KVM: selftests: Rename guest_rng to kvm_rng
  KVM: selftests: Add helper to generate random u64 in range [min,max]
  KVM: selftests: Print vCPU affinity on timeout

 tools/testing/selftests/kvm/Makefile.kvm      |   7 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   4 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |   8 +-
 .../selftests/kvm/include/kvm_syscalls.h      |   6 +
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../testing/selftests/kvm/include/proc_util.h |  28 ++
 .../testing/selftests/kvm/include/test_util.h |  26 +-
 .../selftests/kvm/include/x86/kvm_util_arch.h |   4 +-
 tools/testing/selftests/kvm/irq_test.c        | 367 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  88 ++++-
 tools/testing/selftests/kvm/lib/memstress.c   |   8 +-
 tools/testing/selftests/kvm/lib/proc_util.c   |  62 +++
 tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
 tools/testing/selftests/kvm/mmu_stress_test.c |   9 +-
 tools/testing/selftests/kvm/steal_time.c      |  21 +-
 15 files changed, 615 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/irq_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

-- 
2.54.0.rc2.533.g4f5dca5207-goog

