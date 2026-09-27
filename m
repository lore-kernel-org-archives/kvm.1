Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CB269D18
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495594; cv=none; b=WtPTunN4m3hzy8vFIRXcYrukkyFEBqZdsv9jPhZcLB3bJ2A0OTYlIAEV5NPE5GmnOG8Pn7bvQ/t/iipsiWzaSkr1sSYEh2UAZfF0gi2kebCeGdG4+grmnoGP8f8w5fs7KFK4XgjzxEWJzeDj1RjnXiu4d4XsmqL20Sth6yvr9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495594; c=relaxed/simple;
	bh=EkZp276PkVuQvXsJKjBxb8h55E+NWD2UGE6YJulnUsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucSwEqFtsw6YFK8byutHHD91G9U1ozDl5E9hi2iQewPZUgInZbRqw/60OG5QV/HgutKHcqAXXrXf/Gu8bRKS7QI3gQLkETU40E+3GVu9heiRmIGQJppiA16bPjt/FRHb/j9gJwWB9Bt13OiQP4h9rTxQ1KpYwakxbjzs54N0/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hf2vZ9FA; arc=none smtp.client-ip=91.218.175.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hf2vZ9FA"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EkZp276PkVuQvXsJKjBxb8h55E+NWD2UGE6YJulnUsc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790495587; v=1; x=1791100387;
 b=Hf2vZ9FAQy+y+d/8x4dSNHi7Lc0xmB3m774GtZWKUgkuYJc1a1dewOQW6ah5J3GihK2q2LhE
 3UWWusRdPWTbRw5jkhR1fhjhbVPztudJ7omLPJRrBhU4JOX7Kej+p8ESRxlrEU4aLRshIfWX4pm
 L6LEPuqacyMYGke+9tS4xK9A=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8225a4304a8db2c6;
	Sun, 27 Sep 2026 07:52:57 +0000
X-Mizu-Trace-ID: 8225a4304a8db2c6
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/6] LoongArch: KVM: irqchip and steal time fixes
Date: Sun, 27 Sep 2026 15:52:34 +0800
Message-ID: <20260927075240.3007947-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hi,

Six fixes for the LoongArch KVM irqchip and paravirtual steal time
code:

- Patch 1 fixes a host use-after-free: when KVM_CREATE_DEVICE succeeds
  but the following fd allocation fails (e.g. under RLIMIT_NOFILE),
  ops->destroy() frees the irqchip while kvm->arch.* still points to
  it, so later interrupt injection walks into freed memory.  Verified
  on Loongson-3A6000: with the fd budget exhausted, KVM_IRQ_LINE
  returns success and pch_pic_set_irq() executes on the freed object
  (kprobe); with the fix the same sequence returns -ENXIO.

- Patch 2 makes the irqfd injection entry points tolerate a NULL
  irqchip device: they dispatch through the irq routing table without
  the irqchip_in_kernel() gate that protects KVM_IRQ_LINE, so a
  routing entry that outlives the device dereferences it.

- Patch 3 loads kvm->arch.dmsintc once in the MSI injection path:
  both pch_msi_set_irq() and dmsintc_set_irq() re-read the pointer
  between the non-NULL check and the following dereferences, so a
  concurrent device removal is observed between them.

- Patch 4 fixes steal time accounting: the PVTIME attribute
  initializes its baseline from the control thread's run_delay while
  the accumulation happens in the vcpu thread, so the first delta can
  wrap and the guest reads a steal time near 2^64.  This hits the
  default QEMU topology (control thread sets the attribute, vcpu
  threads run KVM_RUN) once the guest enables steal time.  Verified on
  Loongson-3A6000: a guest steal value of 2^64 - 7.58s before the fix,
  a small value after it.

- Patch 5 aligns kvm_pch_pic_create() with kvm_eiointc_create() by
  propagating the real error code; the kvm_ipi_create() counterpart is
  being fixed separately by "Return the actual error code in
  kvm_ipi_create()" (Chaithanya Lagisetty).

- Patch 6 rejects a repeated PCH-PIC CTRL_INIT: every call registers
  the device on the MMIO bus at the new address while destroy removes
  only one range, so stale ranges silently swallow MMIO accesses
  (measured with kprobes: three accepted inits, one unregister).

All patches carry Fixes tags.

Tao Cui (6):
  LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
  LoongArch: KVM: Guard against NULL irqchip in irq injection
  LoongArch: KVM: Load dmsintc pointer once in pch_msi_set_irq
  LoongArch: KVM: Rebase steal time counter in vcpu context
  LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
  LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT

 arch/loongarch/kvm/intc/dmsintc.c | 12 ++++++++++--
 arch/loongarch/kvm/intc/eiointc.c |  6 +++++-
 arch/loongarch/kvm/intc/ipi.c     |  1 +
 arch/loongarch/kvm/intc/pch_pic.c | 23 +++++++++++++++++------
 arch/loongarch/kvm/vcpu.c         | 25 +++++++++++++++++--------
 5 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.43.0

