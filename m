Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF63BAD9B;
	Sun, 17 May 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032275; cv=none; b=Oqvjil7SZl0ORyC/9vHwW/RbXW+LYoj8xaaUGPsjQxaQn3KOu2lu4zDO0yCL7G90l+6Olne05MppmLcT3fMx0itBbS9SHQgga8amGxfkkTIKdj+tfQdkynDAZ80bFZ+Sr7j2qxguMH6O/N9cikbP9t30uXLPO7RBIpA5bMt9mZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032275; c=relaxed/simple;
	bh=kNIFaOnoms8vpXrC93aiuCYGyPn+69apiDxwOfb+ZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R08MVKDpsUsPQG0Gp5NPbfacKFMlThGf8jwuHDI7tkZFqicO9z+9bxnjiXDMB1VFcE8ys3U9bvQNIGFqXn0WSlhMRh6jSwX3dr3Kia3pctibwdu6U1WShiPKo9MvtpttOcm5WnoKPtX1i/lpEkC+3WHXHvgUAZvACC0JOIQk/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J1W7Oelf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J1W7Oelf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R2
	vdFoj/uYRCZ7Xe7zmYDyiQkstZgeSKUDsvCleEwA8=; b=J1W7Oelfr8fXM1QOFV
	OLSE7F3bmId4/hJ3lCuusehbacu3aI22bzz6GSsbxXLsIs7XKmS4WG5w1nzLhrBM
	+ACz8G2gMKxYu+bGePoOvmLSTY8m/SR7nVIUlTOBPoyiPxxiraNgfArSG8eTgiCD
	f9aDA5ubkeAsVEBQWMOamO/EI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S2;
	Sun, 17 May 2026 23:34:39 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH 0/5] KVM: riscv: Speed up dirty logging write faults
Date: Sun, 17 May 2026 23:34:22 +0800
Message-ID: <20260517153427.94889-1-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF48Cr1DKryUuFy3Ww45Wrg_yoW8Kr1UpF
	WkWr4Fkws2gryxZ3s3C3WDCr909as3GrW7GF47X34DZFs0kry5Aayvg348XFZrJFyxXw12
	vFW0y34fu34UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziVbyZUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC0A8YkGoJ4A+wjQAA3m

This series speeds up the common dirty logging write fault path for
RISC-V KVM.

When dirty logging is enabled, guest writes to write-protected G-stage
4K leaves currently go through the full fault path and take mmu_lock for
write.  That is expensive once the leaf already exists and
only needs its permission and dirty state updated.

The series first makes the existing MMU notifier locking contract
explicit, switches RISC-V KVM to KVM's rwlock form of mmu_lock, adds an
atomic G-stage PTE update helper, uses it for existing permission
updates, and finally handles dirty logging write faults under the read
side of mmu_lock when a 4K G-stage leaf is already present.

The locking and concurrency model follows existing KVM patterns from x86
and arm64: use an rwlock mmu_lock, keep structural page-table changes on
the write side, and use atomic PTE updates for permission-only changes
that may race with another vCPU.

The fast path marks the memslot page dirty before making the PTE writable
again.  It also sets the PTE dirty bit, so systems that trap when D is
clear do not fall back to the slow path for a writable-but-clean PTE.

Performance was measured with KVM selftests inside a QEMU RISC-V host.

  dirty_log_perf_test -m 19 -v 4 -b 1G -i 3
    base dirty memory avg, iterations 2-3: 53.262493s
    patch 1-4 dirty memory avg, iterations 2-3: 52.735675s
    patch 1-5 dirty memory avg, iterations 2-3: 26.422964s
    patch 1-5 improvement over base: 50.4%

  dirty_log_perf_test -m 19 -v 4 -b 64M -i 3
    base dirty memory avg, iterations 2-3: 3.203170s
    patch 1-5 dirty memory avg, iterations 2-3: 1.762452s
    improvement: 45.0%

Patch 1-4 are prerequisites for the read-side fast path. The
main speedup comes from patch 5 avoiding the full fault path 
for dirty logging write faults.

Jinyu Tang (5):
  KVM: riscv: Rely on common MMU notifier locking
  KVM: riscv: Use an rwlock for mmu_lock
  KVM: riscv: Add a G-stage PTE cmpxchg helper
  KVM: riscv: Update G-stage PTE permissions atomically
  KVM: riscv: Fast-path dirty logging write faults

 arch/riscv/include/asm/kvm_gstage.h |   4 ++
 arch/riscv/include/asm/kvm_host.h   |   2 +
 arch/riscv/kvm/gstage.c             |  35 +++++++---
 arch/riscv/kvm/mmu.c                | 105 +++++++++++++++++++++++-----
 4 files changed, 122 insertions(+), 24 deletions(-)

-- 
2.43.0

