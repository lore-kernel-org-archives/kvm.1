Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69A3446C0
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916087; cv=none; b=YzgD8407S2pexFgQ69OB3ibL19z9VaaflkNJ3Ts6n+gKWmRC5iLesrFIj0DG10jyvIEweyeTU2kD8cMKgEQdCNtgEVBKp5qTZ8FxeMXoQk2Y8ntoV7xDimkjg/5tXH/GM465wTM9wqGpVtJ9I3CXYAW+FgrjlTlxb3GJIbD6Fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916087; c=relaxed/simple;
	bh=5ew/42B4Jt8XUgSR0qzNVkoNj1X9e/Rmpc6KW/G7P8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmrwng9M81IVts8c1QMQQEmJr2RY+VszRbirEIdoX84giHaqIEtd5QWdrchSF/iyR8xIqiD3HYsEBL/EvRKWvZ/HC2UxdubuphtoDY/fQplEucPTtS8yN6YColMwAKstalPy38GhHjU1FyKg7jjwbIBRpV1fbfSr1sudn047H0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=frdtDOjK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="frdtDOjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xO
	TFH5k6Ji9MYeLzPy0mbMBJQbUtBCk8vx/09Io1rFs=; b=frdtDOjK47uv7+Ltf1
	Lg0ueCfpZzwoRXHLsnvnc1x9nWu9Kvmx/61Bp2s/8sbDqpDEdtrLbMUZUcXhR34z
	I0LPI23IhMlo1/53toeEKnAaWUnfeg+3vH38uxjQbdbi7eErGDEPsRW3Oo+/1j4K
	KQcsTzTIwPbYM5fM/7oszvySA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD35mzeI0VqYpWYGg--.10116S2;
	Wed, 01 Jul 2026 22:27:43 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: kvm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [RFC PATCH 0/2] PCI bus/CPU address translation for MMIO
Date: Wed,  1 Jul 2026 22:26:52 +0800
Message-ID: <20260701142654.483659-1-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD35mzeI0VqYpWYGg--.10116S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr45Jry3uFWrKrWUtF13urg_yoWDCrX_uw
	1xCrZ5JrWUXFZrCFWYywnxtryUC3y0yF4DJ3Z5Xr1fGFyqyrnxGw1UtFsrW3WrWrs0yryD
	Wr93Gr1xZ343GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRENBMPUUUUU==
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8R-rZGpFI981ggAA3F

PCI BARs contain PCI bus addresses, while KVM MMIO exits and ioctls use
CPU physical addresses.

kvmtool currently assumes that these two address spaces are identical.
That is true for the existing default layouts, but it breaks once an
architecture exposes a non-identity PCI MMIO window to the guest.

This series adds PCI bus/CPU address translation hooks with an identity
default, then wires up RISC-V to exercise a non-identity PCI MMIO window
through a new --pci-mmio-cpu-base option.

Jinyu Tang (2):
  pci: translate BAR addresses for MMIO users
  riscv: allow a non-identity PCI MMIO CPU base

 include/kvm/pci.h                   | 17 ++++++++++
 riscv/fdt.c                         |  2 +-
 riscv/include/kvm/kvm-arch.h        |  5 ++-
 riscv/include/kvm/kvm-config-arch.h |  4 +++
 riscv/pci.c                         | 49 ++++++++++++++++++++++++++---
 vfio/core.c                         | 25 ++++++++++-----
 vfio/pci.c                          | 31 ++++++++++++------
 virtio/pci-legacy.c                 |  6 ++--
 virtio/pci-modern.c                 |  2 ++
 virtio/pci.c                        | 25 ++++++++++-----
 10 files changed, 133 insertions(+), 33 deletions(-)

-- 
2.43.0

