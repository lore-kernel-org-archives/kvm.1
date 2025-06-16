Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936554BC6;
	Mon, 16 Jun 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059351; cv=none; b=T2LOChM/bc/Jh1QjSuIkrAHiJz8+pTzrT6xBZDw8ui8hgEI0zu7gbOHvDlB8Z+fjEwW/nAKxnFuFdv46fLLpX8w9mrJGSwdXcSfk+2EhmjNKSnn4qCjfteIHjFuGxjOvTuJI273iP3SWZZAKtCt2MeXW0jFOIkRucG/ODcKDwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059351; c=relaxed/simple;
	bh=OjTd/WA86Rgtw4b0AdlJ6b2uDCbr07ZTHE+Vy4N6UyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgWUcVsLF1kR7zEgzzMOQIOC9/1NaTQSYjUVHymyhD9ZkN82WV4R0KVnyPrEysoc/ObYyQmO0/wkNDsYj6nr5Zd9bXXPFUnR6sz1YHCh6coZ6E7lxsKKgriLDJW5RLsgvMismTfjf2ZAn3JQkomvuzCt6LpnwdRDzHbK0soKIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxC3JOyU9owY0XAQ--.54577S3;
	Mon, 16 Jun 2025 15:35:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxvhtLyU9okMEcAQ--.34084S2;
	Mon, 16 Jun 2025 15:35:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xianglai Li <lixianglai@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] LoongArch: KVM: INTC: Add IOCSR MISC register emulation
Date: Mon, 16 Jun 2025 15:35:37 +0800
Message-Id: <20250616073539.129365-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvhtLyU9okMEcAQ--.34084S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

IOCSR MISC register 0x420 controlls some features of eiointc, such as
BIT 48 enables eiointc and BIT 49 set interrupt encoding mode. 

When kernel irqchip is set, IOCSR MISC register should be emulated in
kernel also. Here add IOCSR MISC register emulation in eiointc driver.

Bibo Mao (2):
  LoongArch: KVM: INTC: Remove local variable device1
  LoongArch: KVM: INTC: Add IOCSR MISC register emulation

 arch/loongarch/include/asm/kvm_eiointc.h |   4 +
 arch/loongarch/include/asm/loongarch.h   |   1 +
 arch/loongarch/kvm/intc/eiointc.c        | 144 ++++++++++++++++++++++-
 3 files changed, 144 insertions(+), 5 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.39.3

