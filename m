Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB462BCF68;
	Tue, 17 Mar 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739766; cv=none; b=oLMWZRDaCxNOJHf3h4eV7l7Zz6NSplq3q5qQ82S/LhdeIU/cGS6Id6F4LosrFcPC6A38AmHdDhHI/YKAvEPCwI/uKhRzftUb6f5QOeyCZBPkFJfrFmavt2b1Akc4oiCEGQH0VeYOT3FNpUkrFaNuU1bXlYLidIVYD+t/Uy0TvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739766; c=relaxed/simple;
	bh=Jk1R7YSGK0Dvja2SjgnDZzQuJF8Un/G/wEMdgQPaGpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXxbU0bWzFHHzz8eI1N+0e7NWWFUkuiBYnGCZpQJx0/YDhAEqk2jjQsuLCKY8I1EDC35lahsoZvKTWZUCgagX/SoOmuK/lG1xibXIK5bxcdcXByCAocs/UZR7AAbEk/FCFLuW62Qmj5db5fDQ3zYq77aLzO3TcPRD345IB3/hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxH6rrHrlpP+QbAA--.21363S3;
	Tue, 17 Mar 2026 17:29:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxHOHpHrlp3PlWAA--.35253S2;
	Tue, 17 Mar 2026 17:29:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/3] LoongArch: KVM: Some small enhanments
Date: Tue, 17 Mar 2026 17:29:08 +0800
Message-Id: <20260317092911.1400248-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHpHrlp3PlWAA--.35253S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are some small enhancements about LoongArch KVM. There is
improvement about VM entry path in patch 1 and patch, add pending
request checking in advance and it is empty at most time.

Also change vcpu_is_preempted() from function to macro method, by actual
benchmark test such as unixbench. It is affected on physical machine
with function method. With the macro method, only one nop instruction
is added and there is no parameter parsing, there is no obvious
performance influence with physical machine.
---
v1 ... v2:
  1. Add READ_ONCE() with src->preempted to avoid compiler optimization.
---
Bibo Mao (3):
  LoongArch: KVM: Add kvm_request_pending checking in
    kvm_late_check_requests()
  LoongArch: KVM: Move host CSR_EENTRY save in context switch
  LoongArch: KVM: Set vcpu_is_preempted() macro rather than function

 arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
 arch/loongarch/kernel/paravirt.c       | 15 ++------------
 arch/loongarch/kvm/vcpu.c              | 24 +++++++++++------------
 3 files changed, 36 insertions(+), 30 deletions(-)


base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.39.3

