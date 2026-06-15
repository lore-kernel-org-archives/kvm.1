Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C61383C65
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511746; cv=none; b=IClgpRhc0sOdY/VaLgMvJ+aCb1PlElNZ3zxxrHHMLaHw9p/dtpidIBxMdfVx5ihwUjT0N7vkOfPZVRw3xmltAQ7cwShPv0pLZN780iYUXZKQ9pbprVtIKTTx/uMkzPPodlxOcQrFmSHXgA27gKDzijy4HeScFP3KzAaETanDBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511746; c=relaxed/simple;
	bh=9XdB7Vt7iU48+97QDPKzMJqprmiDjOA8tRhWC+7zIJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIIDUxWIksGVAA7Hm/nKCC0cVk+mUslGliNHjDK5Sw6i61VakGFIliER9fCkPm9gYNQvcDZq9J4oZVzFiCA6MsVPYj0albR+06zW967Tu4Z2D/aJzMaDJd93v8T/eUl97PLe2EXN9OKWfqQxS7Q/6zfgeKhv/3Dh2AcSyKIILgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IuzlOJ3x; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IuzlOJ3x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781511732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdUtS9qqN2S+OtqhVuPxakdjuoUCbzjXmoOqBk4rXk4=;
	b=IuzlOJ3xjFghfr8UUjf/Ze+e2EmdTLq10+qvgVPBFQiBa9356KiLygDaeBRNPOzr1lQ4vU
	mCK6eGQ8+xYmoiuNzQnhY8myQm/yyGCp3z/Qc8Cbd03iBQd8jQihoRlBSTQBGWL+NN6889
	mgG4LOSBzHmVsAbLgK+3iHrhLPOKb6Y=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4 0/3] LoongArch: KVM: Add PV TLB flush support
Date: Mon, 15 Jun 2026 16:21:51 +0800
Message-ID: <20260615082154.42144-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

This series implements paravirtualized TLB flush for LoongArch KVM
guests.

In multi-vCPU KVM guests, remote TLB flushes broadcast IPIs to all
target vCPUs, including those preempted by the host. Sending IPIs to
preempted vCPUs causes unnecessary VM exits and grows with vCPU count,
becoming severe in overcommitted deployments.

Reuse the existing steal-time shared memory page by adding a new
KVM_VCPU_FLUSH_TLB flag to the preempted byte. On the guest side,
skip IPIs to preempted vCPUs and set the flag via cmpxchg instead.
On the host side, when re-entering a vCPU in kvm_update_stolen_time(),
check and clear the flag; if set, drop the VPID to trigger a full TLB
flush on the next VM entry. No new shared memory page, hypercall, or
Kconfig option is needed.

The feature is advertised through the existing KVM PV feature
negotiation: the kernel exposes KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH as
a VM-level capability, and userspace (QEMU) sets
KVM_FEATURE_PV_TLB_FLUSH in the guest's CPUCFG_KVM_FEATURE mask after
probing it. A corresponding QEMU patch ("target/loongarch: Enable PV
TLB flush advertisement to the guest") is posted alongside this
series.

- Host side: only trace a PV TLB flush request when one is observed.
- (Carried over) Host uses amand_db.w to atomically read and clear the
  preempted byte; selftest gained input validation and failure cleanup.

Testing: the PV TLB flush path itself is unchanged from v3, so the
benchmark numbers below still hold.  Note that, unlike v3, the feature
must now be enabled by userspace: run a QEMU built with the companion
patch (or with -cpu kvm-pv-tlb-flush=on) so the guest actually observes
KVM_FEATURE_PV_TLB_FLUSH.  Boot a 32-vCPU guest and run the selftest
inside it with sleep-idle (PV helps) and busy-spin (PV cannot optimize)
modes respectively:

  qemu-system-loongarch64 \
    -m 4G -smp 32 --cpu la464 --machine virt \
    -bios .../QEMU_EFI.fd \
    -kernel .../vmlinuz-...-pvtlb-v4+ \
    -initrd /tmp/ramdisk_test.gz \
    -serial mon:stdio \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0 \
    -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" -nographic

  # PV TLB flush enabled (idle threads sleep, vCPUs get preempted)
  guest# ./pv_tlb_flush_test 1 31 50000 0

  # Baseline (idle threads busy-spin, all vCPUs stay active)
  guest# ./pv_tlb_flush_test 1 31 50000 1

  With PV TLB flush (sleep idle):    ~152,285 ns/flush
  Without PV TLB flush (busy-spin):  ~481,045 ns/flush

  Improvement: ~68% latency reduction (~3.2x throughput increase)

Tao Cui (3):
  LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
  LoongArch: KVM: Implement guest-side PV TLB flush
  KVM: selftests: loongarch: Add PV TLB flush performance test

 arch/loongarch/include/asm/kvm_host.h              |   1 +
 arch/loongarch/include/asm/kvm_para.h              |   9 +
 arch/loongarch/include/asm/paravirt.h              |  21 +++
 arch/loongarch/include/uapi/asm/kvm.h              |   1 +
 arch/loongarch/include/uapi/asm/kvm_para.h         |   1 +
 arch/loongarch/kernel/paravirt.c                   |  60 ++++++
 arch/loongarch/kernel/smp.c                        |  30 +++-
 arch/loongarch/kvm/trace.h                         |  15 ++
 arch/loongarch/kvm/vcpu.c                          |  34 +++-
 arch/loongarch/kvm/vm.c                            |   3 +
 .../selftests/kvm/loongarch/pv_tlb_flush_test.c    | 194 +++++++++++++++++++++
 11 files changed, 362 insertions(+), 7 deletions(-)

---
Changes in v4:
- Drop the "Preserve auto-enabled PV features on userspace override"
  patch: forcing auto-enabled features back on is migration-unsafe, and
  for PV TLB flush (which cannot degrade gracefully) a missed flush
  would corrupt the guest.  Enablement now follows the usual KVM model
  -- the kernel advertises KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH and
  userspace (QEMU) explicitly sets KVM_FEATURE_PV_TLB_FLUSH after
  probing it; a companion QEMU patch is posted alongside, and the
  feature can be kept off for an older destination
  (-cpu kvm-pv-tlb-flush=off).

Changes in v3:
- Host side: replace amswap_db.w with amand_db.w to atomically read
  and clear only the preempted byte, preserving the pad bytes for
  future UAPI use.  Issue a normal load (unsafe_get_user) before the
  atomic amand_db.w to avoid operating on stale cache data.
- Host side: move the pv_auto_features OR operation before the
  compatibility check in kvm_loongarch_cpucfg_set_attr() so that
  userspace does not need updating for pure kernel-internal PV
  feature additions.
- Selftest: add input validation, error checking on pthread_create,
  and cleanup handling on failure.

Changes in v2:
- Host side: replace non-atomic unsafe_get_user + unsafe_put_user with
  atomic amswap_db.w inline assembly. This fixes two issues:
  1) unsafe_put_user failure could skip the TLB flush entirely
  2) non-atomic read+write race with guest-side try_cmpxchg could
     cause FLUSH_TLB requests to be lost
- Guest side: consolidate two separate READ_ONCE calls into a single
  READ_ONCE to eliminate a TOCTOU race where the host could clear
  preempted between the two reads. Also switch from byte-sized
  try_cmpxchg to 32-bit try_cmpxchg on the aligned word containing
  preempted.

-- 
2.43.0

