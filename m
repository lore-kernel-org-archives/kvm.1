Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF33AC0E3
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274305; cv=none; b=axKdGNdUqjbus2fEB8b9k6h3eENS3OXx5F/VUXGHHTvrLZ4bLw2tgs/oEBhdfNk754bwl0upIRr2pQdBqnQT11f0eTmG+8rvF0/srBAU/P2fIbiocqkqS8kzjnnMdFZxERvVAe6Zbsz4fE+RQ62O80FXfRT50wKG2Ul2gCt2vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274305; c=relaxed/simple;
	bh=p3Spg5Kx+BRlRyO9RcbfBp4Qk3BdxZs+rqG/URZD3Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMVp6Pf6pTuc48/QzMlBEKbRZ6s8mr55V84MUXfGrZ7qrjynZkGsXt3OKOGRdaErJuqR5Hasaa1PuOe1B5CYZVnH/e4e5gGUXvEl4JDXNGC/bRyE8D8k/RSe+q0NZ5mM0Ir/RktjBSIP5k/Fg+saOOSJ9JFErLD4bHiv6uM61S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e60CNyS1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e60CNyS1"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6EC2C20B710C;
	Mon, 23 Mar 2026 06:58:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EC2C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274298;
	bh=tJpBQZj75HUYMQsTFFKSpzrxKtG71ffSxKRsEuze/cA=;
	h=From:To:Cc:Subject:Date:From;
	b=e60CNyS1t+kSi37egryYGqrlSAU4SZlOrDSKjWnPYHlGHiXw8CR3GdJrQOxd315T8
	 IT1ij0vS18sYsRkAMip3jK535kAInWobzBxwQUE+1t1r+bZ0c28n9LlpPjZELaq2ib
	 j8whcBvzk2MJdJ0paxjV01cWZ9RBC4s7QEW6YpNw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 00/32] Add migration support to the MSHV accelerator
Date: Mon, 23 Mar 2026 14:57:40 +0100
Message-Id: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey all, This is a draft patch series for live migration support in
the MSHV accelerator. Since this is somewhat invasiva and touches
various parts outside of the accel's folder hierarchies I'm sending
an RFC series to collect early feedback.

Note: this patches are sent in sent in isolation, but for LM to be
functional we will require require the recently submitted patch series
"Support QEMU cpu models in MSHV accelerator" (at v3 currently) to be
merged, since on some hosts we will need the CPUID infra to disable
features that we currently do not yet migrate (e.g. AMX tiles).

In this series we perform some preperatory refactorings and introduce
new abstractions where required, particulary for irqchips and MSR
logic. We also have to introduce some generic logic for XSAVE
de/compaction to allow migration of XSAVE state.

Note 2: I did already receive some feedback offline on the new XSAVE
de/compaction handlers. We want to avoid the buffer copy and rework
existing code to be generic over a compacted or standard layout. The v1
submission will contain this change.

The guest state components that are covered by migration are:

- standard regs
- special regs
- xcr0
- (legacy) FPU regs
- XSAVE
- LAPIC
- MSRs
- SynIC state (SIMP, SIEFP, STIMER)
- pending interrupts/exceptions
- MP state (AP cpu modes)

Finally, routines for dirty-page tracking to reduce migration downtime
have beend added and integrated in the respective hooks.

best,

magnus

Magnus Kulke (32):
  target/i386/mshv: use arch_load/store_reg fns
  target/i386/mshv: use generic FPU/xcr0 state
  target/i386/mshv: impl init/load/store_vcpu_state
  accel/accel-irq: add AccelRouteChange abstraction
  accel/accel-irq: add generic begin_route_changes
  accel/accel-irq: add generic commit_route_changes
  accel/mshv: add irq_routes to state
  accel/mshv: update s->irq_routes in add_msi_route
  accel/mshv: update s->irq_routes in update_msi_route
  accel/mshv: update s->irq_routes in release_virq
  accel/mshv: use s->irq_routes in commit_routes
  accel/mshv: reserve ioapic routes on s->irq_routes
  accel/mshv: remove redundant msi controller
  target/i386/mshv: move apic logic into own file
  target/i386/mshv: migrate LAPIC state
  target/i386/mshv: move msr code to arch
  accel/mshv: store partition proc features
  target/i386/mshv: expose msvh_get_generic_regs
  target/i386/mshv: migrate MSRs
  target/i386/mshv: migrate MTRR MSRs
  target/i386/mshv: migrate Synic SINT MSRs
  target/i386/mshv: migrate SIMP and SIEFP state
  target/i386/mshv: migrate STIMER state
  accel/mshv: introduce SaveVMHandler
  accel/mshv: write synthetic MSRs after migration
  accel/mshv: migrate REFERENCE_TIME
  target/i386/mshv: migrate pending ints/excs
  target/i386: add de/compaction to xsave_helper
  target/i386/mshv: migrate XSAVE state
  target/i386/mshv: reconstruct hflags after load
  target/i386/mshv: migrate MP_STATE
  accel/mshv: enable dirty page tracking

 accel/accel-irq.c               |  41 +-
 accel/kvm/kvm-all.c             |   6 +-
 accel/mshv/irq.c                | 360 ++++++------
 accel/mshv/mem.c                | 211 +++++++
 accel/mshv/meson.build          |   1 -
 accel/mshv/mshv-all.c           | 243 ++++++++-
 accel/mshv/msr.c                | 375 -------------
 accel/stubs/kvm-stub.c          |   2 +-
 accel/stubs/mshv-stub.c         |   6 +-
 hw/intc/apic_common.c           |   3 +
 hw/misc/ivshmem-pci.c           |   8 +-
 hw/vfio/pci.c                   |  11 +-
 hw/virtio/virtio-pci.c          |   3 +-
 include/accel/accel-route.h     |  17 +
 include/hw/hyperv/hvgdk_mini.h  |  22 +
 include/hw/hyperv/hvhdk.h       | 149 +++++
 include/hw/i386/apic_internal.h |   5 +
 include/system/accel-irq.h      |   6 +-
 include/system/kvm.h            |  23 +-
 include/system/mshv.h           |  15 +-
 include/system/mshv_int.h       |  89 +--
 target/i386/cpu.h               |  14 +-
 target/i386/kvm/kvm.c           |   5 +-
 target/i386/machine.c           |  46 ++
 target/i386/mshv/meson.build    |   3 +
 target/i386/mshv/mshv-apic.c    |  78 +++
 target/i386/mshv/mshv-cpu.c     | 940 +++++++++++++++++++++++---------
 target/i386/mshv/msr.c          | 432 +++++++++++++++
 target/i386/mshv/synic.c        | 206 +++++++
 target/i386/xsave_helper.c      | 255 +++++++++
 30 files changed, 2641 insertions(+), 934 deletions(-)
 delete mode 100644 accel/mshv/msr.c
 create mode 100644 include/accel/accel-route.h
 create mode 100644 target/i386/mshv/mshv-apic.c
 create mode 100644 target/i386/mshv/msr.c
 create mode 100644 target/i386/mshv/synic.c

-- 
2.34.1

