Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C340C5AE;
	Tue, 19 May 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183795; cv=none; b=LUPcQXLCI2vq4pjn+/jTsHmVE5Diipi8M4HkcBBiTP9b+OlUtMqLWgnIOc/S4gv99KxBh9qv8+TEzXn5L3I8aeXkrWBVw8DOGQ4dRyIEG3BQ5tEOHIQQOMoO75+bc20rfdFUxZUBHHPUHLrgeiCxkQsJHrxlyLKbrxcNX6ywuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183795; c=relaxed/simple;
	bh=nbgBgna4U3ZhBvOGNNur/jiCzWXVWT9U0UbZeEqHbxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKmsAAvrsC4OGtOaywHNVj0HfOcP5/aXieuo1QySR1S6m8tGYIn/iQkOyFs3DLIQThoSNYQd8G0N+uQIARAlS3unX3jzlziL8QTZ0SOXOVxmdgJIIDpvhZ4QprRLpJ93I9VVwZqCkuzAB1v8LDbL0I1R40KyeuZgnX86ngjTEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxZniuMAxqWC0LAA--.8253S3;
	Tue, 19 May 2026 17:43:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKtMAxqjD6IAA--.61010S2;
	Tue, 19 May 2026 17:43:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] LoongArch: KVM: Small enhancement about interrupt injection
Date: Tue, 19 May 2026 17:43:02 +0800
Message-Id: <20260519094308.3983046-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKtMAxqjD6IAA--.61010S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here make interrupt status acquire interface simpler, add new interface
kvm_vcpu_sync_intr() to sync pending interrupt to software ESTAT
register, and remove expensive vcpu_load() and vcpu_put() function call.

Also interrupt inject is handled with batch method, rather one by one.

---
v2 ... v3:
  1. Split patch 1 into two smaller patches, one is smaller bugfix patch
     with irq validility check in kvm_vcpu_ioctl_interrupt(), so that it
     is easy to porting to old kernel.

v1 ... v2:
  1. Add irq validility check in function kvm_vcpu_ioctl_interrupt().
  2. Add valid bit check when set ESTAT CSR register.
  3. Merge two patches about interrupt clear and set with batch method into
     one.
---
Bibo Mao (6):
  LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
  LoongArch: KVM: Check msgint feature in interrupt post
  LoongArch: KVM: Use existing macro about interrupt bit mask
  LoongArch: KVM: Inject interrupt with batch method
  LoongArch: KVM: Add valid bit check when set ESTAT CSR register
  LoongArch: KVM: Simple interrupt status acquire interface

 arch/loongarch/include/asm/kvm_vcpu.h |  44 +++++---
 arch/loongarch/kvm/interrupt.c        | 140 +++++++++++++-------------
 arch/loongarch/kvm/vcpu.c             |  54 ++++++----
 3 files changed, 134 insertions(+), 104 deletions(-)


base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
-- 
2.39.3

