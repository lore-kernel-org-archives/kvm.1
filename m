Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC903CF04C
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955797; cv=none; b=UJvzyrBOpDR+AKTT5WS81yaS8xIAv6ZmaeD7mDS1NNdwt7QNohSwjPXzuEg2hNckPyYATz2G3K4silO0TkcsQeHP1MSdqOxfw+A5pYgXbScl5FeAXLFKNHoP3dJb5BjNHcpzHyVlR7688uV0zwj1c8vGaYcGz/F+18/u5Q6UtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955797; c=relaxed/simple;
	bh=I6GevRfZSa/tBRJ0bxh7IY4+EECM+sywyrGAPuUESfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvujhMYIlBCWldMI1HsHOlYPWp9uDH1401kCdQezOAo9XpWzk41KV362CmKRnwxbSEmvhHoYwa14U+m7UBLHXyXTDDMKtQ7/h3gEqqQyf03XxfPD0jzQIWuHKrNFfip1lWbWDREa1WoPw4ohcvMucC+YPWACp72PnfRVuCIBQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcJeK+eb; arc=none smtp.client-ip=95.215.58.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcJeK+eb"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=I6GevRfZSa/tBRJ0bxh7IY4+EECM+sywyrGAPuUESfY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791955793; v=1; x=1792560593;
 b=tcJeK+ebEMTCEJDctYjIM+U6uZB2mwBGvZlGB5jr2ad2nMm2oySMaGSkEoeHLHnjXs8WSS2R
 ZCS+10xeyecBvzAXAmGKBHYLgW3ACkvJqxTZU0vUJpVRU4jhMpU1H8SJyn0WxG+POzJxpDXOvbZ
 UJjR38w16/fd3JPdKgTvlL78=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69abde7a0bbf387e;
	Wed, 14 Oct 2026 05:29:52 +0000
X-Mizu-Trace-ID: 69abde7a0bbf387e
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
	lihongfu <lihongfu@kylinos.cn>
Subject: [PATCH v3 0/3] LoongArch: KVM: irqchip fixes
Date: Wed, 14 Oct 2026 13:29:30 +0800
Message-ID: <20261014052933.723303-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lihongfu <lihongfu@kylinos.cn>

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
  initialized state of the kvm_io_device as the indicator; the MMIO
  base is only committed after a successful bus registration.

All patches carry Fixes tags.

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

Tao Cui (3):
  LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
  LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
  LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT

 arch/loongarch/kvm/intc/dmsintc.c |  1 +
 arch/loongarch/kvm/intc/eiointc.c |  1 +
 arch/loongarch/kvm/intc/ipi.c     |  1 +
 arch/loongarch/kvm/intc/pch_pic.c | 15 +++++++++++----
 4 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0

