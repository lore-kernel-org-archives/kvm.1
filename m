Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507F348C67
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108011; cv=none; b=QAOGxxgWwGZHFRF6Ug6yEiW3zIiM+8th92XozAucD7AVYP5u9ue83RctSbdimNLlHMxUQ5/TvvZpUk42xARk9+CiYiSSWGkwVbo99X1UVWdya+q9BN9a8MhLg8x3yK5wYpW9rIgqhAFXnEJ0IN5WenVTnj9qymp6msx3O9zI2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108011; c=relaxed/simple;
	bh=zWUKHHgdE4FtiQpO2+FWlgc3I65IEDGH6HfPURJKSvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iz8Bc2I866nGR+4RhFgwrza+IQXIXYMOawcOEmRsqV7jur3lvfh2qUam3CrBcwAoY2QVB+LZ9DvufVPJCugAKw88oPDbGzBudLfwwogh/YCrVMYwBj8+V+Epzqa9sSeh1UYwX5wlXzYxB7BLhfIPIqkkJsIlTZySHJ4jd9rPmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyYNPXHP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyYNPXHP"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zWUKHHgdE4FtiQpO2+FWlgc3I65IEDGH6HfPURJKSvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108007; v=1; x=1792712807;
 b=VyYNPXHPNnNNBWBfuRLW0MJgeY/9gdl6m4YScaUWCm5jumdyyjn0IiHYwA7leVY7tq/uN3vZ
 9bwJRDjAkTomatP/C7FPcBhX4FeDlwQI9ebBPMPzH1ziJwuIqNR15QQvhPxglaCod/ir34XKPmG
 J2dlOVgKyWfyGnHn2gyTTKac=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea0d57db6aa5ee63;
	Thu, 15 Oct 2026 23:46:47 +0000
X-Mizu-Trace-ID: ea0d57db6aa5ee63
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4 0/3] LoongArch: KVM: irqchip fixes
Date: Fri, 16 Oct 2026 07:46:35 +0800
Message-ID: <20261015234638.1077815-1-cui.tao@linux.dev>
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
  slots_lock.

All patches carry Fixes tags.

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
 arch/loongarch/kvm/intc/pch_pic.c | 14 ++++++++++----
 4 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0

