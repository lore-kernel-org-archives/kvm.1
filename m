Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE942C3251;
	Wed, 28 Jan 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569424; cv=none; b=QaQWzu9Wd/65anGEbx/jdaD9bY0SONm/292L1iITz6EVscNttPZLzZYvBMCHF5bV9baJrpKXj9c90EPAErn+DJ4odx+BLu/tyKmvNA38ZZ+fWDU26CBP3dFepw/opf3MS88Atpbl9FOLsXkgTxOi7+RA2H23d8sz4p02diNdpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569424; c=relaxed/simple;
	bh=Y5vyU0AN2oyPD/hcEqiFK/XJHujiDRGJ9UC4C3e0AgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n87FtYT2iC/MGomuM1gH5rP0bprcnIBLHoWRT5M7X6JN3wPHdxpm7HVYqnGLXWQXXOVgcoYgYM1SocRUeqYvxiyoOZVsC8Poy5uhK1Geq29NsrSq61SbKPIsx3JNDZo+BDaERqpGL0a8TOu/Td1wteJuHnxG5qU7A7N5rjg+ExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxXcODfHlp92INAA--.43924S3;
	Wed, 28 Jan 2026 11:03:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxaeB_fHlpfUg2AA--.40601S2;
	Wed, 28 Jan 2026 11:03:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/4] LoongArch: KVM: Code cleanup about feature detect
Date: Wed, 28 Jan 2026 11:03:22 +0800
Message-Id: <20260128030326.3377462-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeB_fHlpfUg2AA--.40601S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here is code cleanup about feature detection, there is feature
initialization about host machine, feature checking about VM and host.

Also add register LOONGARCH_CSR_IPR during vCPU context switch, though
it is not used by msgint driver now, it is defined by HW and may be used
in future.

Bibo Mao (4):
  LoongArch: KVM: Move feature detection in function
    kvm_vm_init_features
  LoongArch: KVM: Add msgint registers in function kvm_init_gcsr_flag
  LoongArch: KVM: Check VM msgint feature during interrupt handling
  LoongArch: KVM: Add register LOONGARCH_CSR_IPR during vCPU context
    switch

 arch/loongarch/include/asm/kvm_host.h  |  5 ++++
 arch/loongarch/include/asm/loongarch.h |  2 +-
 arch/loongarch/kvm/interrupt.c         |  4 +--
 arch/loongarch/kvm/main.c              |  8 ++++++
 arch/loongarch/kvm/vcpu.c              |  6 +++--
 arch/loongarch/kvm/vm.c                | 36 +++++++++++---------------
 6 files changed, 35 insertions(+), 26 deletions(-)


base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
-- 
2.39.3

