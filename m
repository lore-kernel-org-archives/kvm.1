Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82772358384
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366716; cv=none; b=jc7kgqyee9kNr3w5b2FyJflotGxOE3u7JTkuXUiyeQFr2edNfbcMX4YJgMuncJfGdNBjTKbyQTamC6arHtwR9Nj9HWjM/wbA2XGEmvk1fedTFPttlBj5bEnrsPH6LYKX4ZMUt461mvPT5M1NZYfOQAhR+2Joe1Z5Z8lS3t9R5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366716; c=relaxed/simple;
	bh=cHTXIvn9hGTXOzczouS657qykU6XYi2xouSLtg2OCmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNZqOZ+fYnig6eoXdzMzeuwzZOuc5tcKflbV68AMlvoAQklbETJBA1PkOZx2BE7JhvtitSHtrAHoncS9PGJ3VdJR+tYRT/qr+VkktAecPTlPPAlJ1f/PL1gw2GdauvtgxgswNBopj0/OUEC6vA85YHO1PByu6exyPIDp6NDDGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O4SGZXaT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O4SGZXaT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780366712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+C6CjJNiB4kYrTw4fbNAQHwHUkBCJ+hPXtiuZShvG/o=;
	b=O4SGZXaTDtndmOIZICfbjUprclxUItVr/WCxTeMvg+d1/wUz69v59ahRokHqz7iqhYZxTp
	4Vx1cYI6x6H5jNVGSGi2enrEHHG4RKk0XR5qDeWWuMwHjdEm2x+wuEHKRsjzKSLW4ylFt0
	iAVJaKRFiPc7BinLgwjQD8UHE1mTvLw=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 0/4] LoongArch: KVM: Add PV TLB flush support
Date: Tue,  2 Jun 2026 10:18:15 +0800
Message-ID: <20260602021819.2373404-1-cui.tao@linux.dev>
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

Testing: boot a 32-vCPU guest with the following QEMU command, then
run the selftest benchmark inside the guest with sleep idle (PV helps)
and busy-spin (PV cannot optimize) modes respectively:

  /root/qemu_branch_origin/build/qemu-system-loongarch64 \
    -m 4G -smp 32 --cpu la464 --machine virt \
    -bios /root/bios_loongarch64/QEMU_EFI.fd \
    -kernel /boot/vmlinuz-7.1.0-rc5-next-20260529-pvtlb-v3-fix+ \
    -initrd /tmp/ramdisk_test.gz \
    -serial mon:stdio \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0 \
    -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" -nographic

  # PV TLB flush enabled (idle threads sleep, vCPUs get preempted)
  guest# ./tlb_bench 1 31 50000 0

  # Baseline (idle threads busy-spin, all vCPUs stay active)
  guest# ./tlb_bench 1 31 50000 1

  With PV TLB flush (sleep idle):    ~152,285 ns/flush
  Without PV TLB flush (busy-spin):  ~481,045 ns/flush

  Improvement: 68.3% latency reduction (~3.2x throughput increase)

Tao Cui (4):
  LoongArch: KVM: Preserve auto-enabled PV features on userspace
    override
  LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
  LoongArch: KVM: Implement guest-side PV TLB flush
  KVM: selftests: loongarch: Add PV TLB flush performance test

 arch/loongarch/include/asm/kvm_host.h         |   3 +
 arch/loongarch/include/asm/kvm_para.h         |   9 +
 arch/loongarch/include/asm/paravirt.h         |  21 ++
 arch/loongarch/include/uapi/asm/kvm.h         |   1 +
 arch/loongarch/include/uapi/asm/kvm_para.h    |   1 +
 arch/loongarch/kernel/paravirt.c              |  54 +++++
 arch/loongarch/kernel/smp.c                   |  30 ++-
 arch/loongarch/kvm/trace.h                    |  15 ++
 arch/loongarch/kvm/vcpu.c                     |  50 ++++-
 arch/loongarch/kvm/vm.c                       |   4 +
 .../kvm/loongarch/pv_tlb_flush_test.c         | 194 ++++++++++++++++++
 11 files changed, 375 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c

---
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

