Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2A47A0C2;
	Wed,  9 Sep 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943231; cv=none; b=KrZxpB9DZaZ4any5eLON5nkluDOM+rMyVmpRy4TQC8BfLG5v1FVsMJWY8yLcwW5nbZOnfp+wp4RfQGTQGlKbmgRneNrLsnwU0fxKbE7UCWRIbr8SetgCmI7O12mzCPel3yJfei/qhhdOZinwNJPZWEPSNLHHm4+VRLySTSxSuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943231; c=relaxed/simple;
	bh=2EEqqBaySonKRbNZhYOSFRx7U6u4g8OCjSV+MEHvFsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhEW3ixS1JFb5PxxRtcjHLUFz10fCp99Kvgj6eYWOdRxp9umPBthjW03n7kriNZ4/L7dSZYCfQrA5Db85n9clTBwfC9+FjYv2AMn5XzDJmiy9x5N6XYpLc2/mru2WOutb4DEts5dxfSvjs+zjnYgbxHpRJ3hYtufWSJLm5VYamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axj9F0G6FqSBwKAA--.29361S3;
	Wed, 09 Sep 2026 16:40:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHs90G6FqXdIdAA--.30773S2;
	Wed, 09 Sep 2026 16:40:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] LoongArch: KVM: Code cleanup with MSI intterupt injection
Date: Wed,  9 Sep 2026 16:32:57 +0800
Message-Id: <20260909083259.1910290-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHs90G6FqXdIdAA--.30773S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here is to remove some unnecessary parameter checking when injecting
MSI interrupt, include MSI level parameter and vcpu::arch::dmsintc_state
NULL pointer etc.

Bibo Mao (2):
  LoongArch: KVM: Remove parameter line when inject MSI
  LoongArch: KVM: Remove duplicated checking with DMSI irq injection

 arch/loongarch/include/asm/kvm_dmsintc.h |  3 +--
 arch/loongarch/include/asm/kvm_pch_pic.h |  2 +-
 arch/loongarch/kvm/intc/dmsintc.c        | 19 +++----------------
 arch/loongarch/kvm/intc/pch_pic.c        |  6 +++---
 arch/loongarch/kvm/irqfd.c               |  6 +++---
 5 files changed, 11 insertions(+), 25 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.39.3

