Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7083C8195;
	Thu, 14 May 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740113; cv=none; b=YJvMyfCuP3csxIZxkNBBaJgsYo5NIJ4lO+I5yNMHLDFpZSFND6ZFkj+3+/4GCp8IcMLytRO76VmuBTw8CgdLtNEw1tD3uNc6GWkgC+ldwBQaaGociCzrMkImHIZdKyFf/B+vKN4tMKpv0Fyce3f/aqrhZoMhr3NVQOEH1rA3o2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740113; c=relaxed/simple;
	bh=NtDOYVGDcFGIKdJA0BPWXhiQeZya8ybIOGQ7MAlFeRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s2xMj/AuytOhq8VxyExbb4Maq53gmwoJxc2YEJQEZlJJeVYhriT718+ZCOSXutvoaQAv0j8fO7ShbdMbTgh9d20PaKgVcNyLp/z9UcNlIKfjvmBd/Eun90WcBYb1SRpE5Z6/iWWIvzFF/N12HJu0rU6huBd2hcEMMdVaIPbf3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxRXiKawVqR7wJAA--.4990S3;
	Thu, 14 May 2026 14:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxfcKJawVqIQqCAA--.48503S2;
	Thu, 14 May 2026 14:28:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] LoongArch: KVM: Small enhancement about interrupt injection
Date: Thu, 14 May 2026 14:28:19 +0800
Message-Id: <20260514062824.1378373-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcKJawVqIQqCAA--.48503S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here make interrupt status acquire interface simpler, add new interface
kvm_vcpu_sync_intr() to sync pending interrupt to software ESTAT
register, and remove expensive vcpu_load() and vcpu_put() function call.

Also interrupt inject is handled with batch method, rather one by one.

---
v1 ... v2:
  1. Add irq validility check in function kvm_vcpu_ioctl_interrupt().
  2. Add valid bit check when set ESTAT CSR register.
  3. Merge two patches about interrupt clear and set with batch method into
     one.
---
Bibo Mao (5):
  LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
  LoongArch: KVM: Use existing macro about interrupt bit mask
  LoongArch: KVM: Inject interrupt with batch method
  LoongArch: KVM: Add valid bit check when set ESTAT CSR register
  LoongArch: KVM: Simple interrupt status acquire interface

 arch/loongarch/include/asm/kvm_vcpu.h |  44 +++++---
 arch/loongarch/kvm/interrupt.c        | 140 +++++++++++++-------------
 arch/loongarch/kvm/vcpu.c             |  57 +++++++----
 3 files changed, 136 insertions(+), 105 deletions(-)


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.39.3

