Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356A334C3B;
	Wed, 23 Sep 2026 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126729; cv=none; b=jtAM7yeUFOU8jkwTSAQ8T6/hoS51XNGZA1F2USWyzO9BECYh5lSjvm1l9sy2GMECJL3dK96ffGtebiqJwX7wrcUBfBlE07kRnhJAYx8VECWRyNknmEL9cAgkYV/4g6ByTEO1eXrIn5bJr50z3yj9xo58BzapbvaHwYh40GXxTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126729; c=relaxed/simple;
	bh=yC39ZVBmE6KWA4Bz6dca0X886Ye+9W/oGTKx3N9Tk0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pEyEIoDGKsAYTbTXrs006c0Y+YGJpqtfnPbIVrVgzedGM5Aw3MRtPe3PqCcwGsBcB9iYXkXFhdiwc1foOU6QDYhgcHVttmrW3cTpXP+i4GaQMCg4ABOG47ryol+EHf/NDiES984xeqGcVxEFV5jVVTxDADyyYLWgSsgE3luZCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxPtOEKrNqS9wOAA--.43380S3;
	Wed, 23 Sep 2026 09:25:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c2EKrNqyQIkAA--.45699S2;
	Wed, 23 Sep 2026 09:25:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/2] LoongArch: KVM: Code cleanup with MSI intterupt injection
Date: Wed, 23 Sep 2026 09:18:01 +0800
Message-Id: <20260923011803.1057945-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c2EKrNqyQIkAA--.45699S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here is to remove some unnecessary parameter checking when injecting
MSI interrupt, include MSI level parameter and vcpu::arch::dmsintc_state
NULL pointer etc.
---
v1 ... v2:
  1. Remove function dmsintc_deliver_msi_to_vcpu() and inline it in
     dmsintc_set_irq().

  2. Keep return value with -1 rather than -EINVAL when level == 0
     in kvm_set_msi(). Return value with 0 is one option also, now keep
     similar with other architectures, will modify this in future when the
     final solution is made.
---
Bibo Mao (2):
  LoongArch: KVM: Remove parameter line when inject MSI
  LoongArch: KVM: Remove duplicated checking with DMSI irq injection

 arch/loongarch/include/asm/kvm_dmsintc.h |  3 +-
 arch/loongarch/include/asm/kvm_pch_pic.h |  2 +-
 arch/loongarch/kvm/intc/dmsintc.c        | 37 +++++-------------------
 arch/loongarch/kvm/intc/pch_pic.c        |  6 ++--
 arch/loongarch/kvm/irqfd.c               |  4 +--
 5 files changed, 15 insertions(+), 37 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.39.3

