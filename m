Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25E383C69
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423386; cv=none; b=vFLbZT/6mDawKi3InF//myUvxStdwWGaofRyhIGoqWXOh8beQqVG1ScbR0AJ9n2H0/1Oz0Vq0LrnWpRTSY6KM9kovg4mm0rVYmznDMFn/sPzBIYtbtZHckDWBC5ht27Q51lW6R70Qhly0DRxJsoeQIsg1Ylf9RKzuZuWjHtBIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423386; c=relaxed/simple;
	bh=cDRyFRiwxoK0Vb0dljWhUWkSrtqATFz97Dvamr+hgLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCtzfvKxA02E7eNQ1bDdKr9sMssHqkYvUogqKJ+eSNonJXlBZB+qqF3jHsExtFQjKX1DPiPzFsIZJSjJhoL7m2R/LM4hCteLjwiApqoUEG5nTiITfI3nW/VPnZRruz0XM/gtdGAUh0zO2eTDJ/CJt+81K81HnD02u6ubzLMXt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oUI+I66V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oUI+I66V"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E8B420B7128;
	Fri, 17 Apr 2026 03:56:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E8B420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423384;
	bh=kT+fZO67+FFVyM48Jt/bh2LO+EU7++uA6l5Zv1+8NLc=;
	h=From:To:Cc:Subject:Date:From;
	b=oUI+I66VJt/nBuWkAhLvnvbtE88rVDiUdYrh3K82v7liYYOMt3JxMjKpKGcTNR6iG
	 7T5HP4NcvmBnTPuxJW4rns1hUqTGF0S4teD3mJ6YijwXOQKBLKNVm4/7Mpe+0cYjea
	 tAqu2Wp6s+aJzJGHBMOYf4v823CuRczNw8Lp9AXc=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 00/34] Add migration support to the MSHV accelerator
Date: Fri, 17 Apr 2026 12:55:44 +0200
Message-Id: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey all, This is a patch series for live migration support in the MSHV
accelerator. Since this is somewhat invasive and touches various parts
outside of the accel's folder hierarchies I'm sending an RFC series to
collect early feedback.

This patches are sent in sent in isolation, but for LM to be fully
functional we will require require the recently submitted patch series
"Support QEMU cpu models in MSHV accelerator" (at v6 currently) to be
merged, since on some hosts we will need the CPUID infra to disable
features that we currently are not able to migrate yet (e.g. AMX tiles).

In this series we perform some preperatory refactorings and introduce
new abstractions where required, particulary for irqchips and MSR
logic. We also have to introduce some generic logic for XSAVE
de/compaction to allow migration of XSAVE state.

Note: there is some pending optimization to avoid a buffer copy
and rework existing xsave helper code to be generic over a
compacted or standard layout. We'll address this in a later revision
or in a discrete patch.

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

Changes since RFC:

- Added CET SS/IBT MSR migration
- Assert 64bit padding on CPUX86State->sysenter_cs statically

Magnus Kulke (34):
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
  target/i386/mshv: remove redundant apic helpers
  target/i386/mshv: migrate LAPIC state
  target/i386/mshv: move msr code to arch
  accel/mshv: store partition proc features
  target/i386/mshv: expose msvh_get_generic_regs
  target/i386/mshv: migrate MSRs
  target/i386/mshv: migrate MTRR MSRs
  target/i386/mshv: migrate Synic SINT MSRs
  target/i386/mshv: migrate CET/SS MSRs
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
 accel/mshv/mshv-all.c           | 243 +++++++-
 accel/mshv/msr.c                | 375 -------------
 accel/stubs/kvm-stub.c          |   2 +-
 accel/stubs/mshv-stub.c         |   6 +-
 hw/intc/apic_common.c           |   3 +
 hw/misc/ivshmem-pci.c           |   8 +-
 hw/vfio/pci.c                   |  11 +-
 hw/virtio/virtio-pci.c          |   3 +-
 include/accel/accel-route.h     |  17 +
 include/hw/hyperv/hvgdk_mini.h  |  33 ++
 include/hw/hyperv/hvhdk.h       | 150 +++++
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
 target/i386/mshv/mshv-cpu.c     | 958 +++++++++++++++++++++++---------
 target/i386/mshv/msr.c          | 467 ++++++++++++++++
 target/i386/mshv/synic.c        | 206 +++++++
 target/i386/xsave_helper.c      | 255 +++++++++
 30 files changed, 2684 insertions(+), 956 deletions(-)
 delete mode 100644 accel/mshv/msr.c
 create mode 100644 include/accel/accel-route.h
 create mode 100644 target/i386/mshv/mshv-apic.c
 create mode 100644 target/i386/mshv/msr.c
 create mode 100644 target/i386/mshv/synic.c

-- 
2.34.1

