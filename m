Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1043EDE7A
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144323; cv=none; b=WYWHdFvGv3a6ri4oWIttSGKBk2felrOiezHsvPBH77OHmIAyciiJak+BAcENgIdr29xy55tUmVUQDRhsQ5K7jAMRpvE1FUICAw44Czft1Ov4z5VlJjru4HfZ7UO9jUfSzwsbFNYVTLlftT7yrgc9gTiO+We8Hed7tdXI7JiC/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144323; c=relaxed/simple;
	bh=JeXCHDGG4tolFhsL1j4EBYIwuOPeprGDnIDl4AqEcjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rciogsCaOjfC1JIPb+47FrlIowodhqo+BKtTlis1apzkALy0vSMpFMbYZ82i+V94OEccggJVNQogvNFooJJbMq5qLtvJRT/cNu0QrVOdoK/3lr4tBAFesm/R5clq057U+RFMDkId3NwJlrb1lzZ070Xjvr4w8yp/IwP1eDnei/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kmVixSRM; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kmVixSRM"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JeXCHDGG4tolFhsL1j4EBYIwuOPeprGDnIDl4AqEcjo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144320; v=1; x=1792749120;
 b=kmVixSRMQLN1fUvJPnVDRCJpCjl2hLEjyYxW1GtwRqSGTAA4Kouwej1oMqBNGGFsGtUwacue
 ZlbconyVvdhI27+HS4vl6331vRT2Z4wpYtIubToXg+biV64ld0ZI7NLZctk0jGDw1kf7wZP/kYe
 3sP6iizoTIF0dZLjE70tbvZY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5457d83e8fddaa8;
	Fri, 16 Oct 2026 09:52:00 +0000
X-Mizu-Trace-ID: c5457d83e8fddaa8
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v5 0/3] LoongArch: KVM: irqchip fixes
Date: Fri, 16 Oct 2026 17:51:48 +0800
Message-ID: <20261016095151.1155049-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hi,

Three fixes for the LoongArch KVM irqchip code:

- Patch 1 clears the device pointer in the destroy callbacks: when
  KVM_CREATE_DEVICE succeeds but the following fd allocation fails
  (e.g. under RLIMIT_NOFILE), ops->destroy() frees the irqchip while
  kvm->arch.* still points to it.

- Patch 2 aligns kvm_pch_pic_create() with kvm_eiointc_create() by
  propagating the real error code; the kvm_ipi_create() counterpart is
  being fixed separately (Chaithanya Lagisetty).

- Patch 3 rejects repeated PCH-PIC CTRL_INIT with -EEXIST, using the
  initialized state of the kvm_io_device as the indicator.  The check,
  the MMIO base update and the bus registration are serialized by
  slots_lock; on a registration failure the state is rolled back so
  that a retry can start over.

All patches carry Fixes tags.

Changes in v5:

- Patch 3: roll back the base and the device state on registration
  failure, as suggested by Bibo.

Changes in v4:

- Patch 3: update pch_pic_base unconditionally, as suggested by
  Huacai.

Changes in v3:

- Drop "Load dmsintc pointer once in pch_msi_set_irq" (v2 patch 2),
  suggested by Bibo and Huacai.

- Patch 3 (v2 patch 4): reject repeated CTRL_INIT by checking the
  kvm_io_device state instead of a separate has_init flag, also
  suggested by Huacai; the check stays under slots_lock.

Changes in v2:

- Drop "Guard against NULL irqchip in irq injection" (v1 patch 2) and
  "Rebase steal time counter in vcpu context" (v1 patch 4) after
  review discussion: their trigger scenarios are not reachable
  through real VMM behaviour.

- Use the one-line destroy style in dmsintc suggested by Bibo.

- Track repeated PCH-PIC CTRL_INIT with a has_init flag and return
  -EEXIST instead of -EBUSY, also suggested by Bibo; move the check
  and base update under slots_lock so they are atomic.

- Add READ_ONCE() to the dmsintc pointer loads so the compiler
  keeps each of them a single load.

Tao Cui (3):
  LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
  LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
  LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT

 arch/loongarch/kvm/intc/dmsintc.c |  1 +
 arch/loongarch/kvm/intc/eiointc.c |  1 +
 arch/loongarch/kvm/intc/ipi.c     |  1 +
 arch/loongarch/kvm/intc/pch_pic.c | 19 +++++++++++++++----
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.43.0

