Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB9288CA0;
	Wed,  6 Aug 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470854; cv=none; b=Nr8degnqutQK5vk4og0ARp5D5kO58P0d9fGReBSUosSL3lCaidxL9oQgeKZ1oJetmGvgQJ/ZUxKbvLZIbitzrUbduRAIZoruMQTpFhckesMXoJpKsSoXAa/NdfeJNJ9KjHy9GhVDz3/0dr+NpcyrsVqvW8sXpTXwH9bGlnX0PlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470854; c=relaxed/simple;
	bh=/FgFlt8jBzOj9pL/KMy4IHiZ0hzvDR5d2QsMUFOflyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ao6f/CkzXwWe/9A7crX9PB8cFftAWGQT1vTgDEBvRCoJUb8SB1Cl9C44u5dqBnjIrABo6vl21WRw7hZ5fyTWRGfKqNipGoP1jb1XdIOOryN8/DPLLUIqJAW6FSyVepFKzZWZ0y6BSdN9ZlZ0Ox1Urqo4wBQB9tFsmai8oCJBNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxnOK_GZNogps5AQ--.12574S3;
	Wed, 06 Aug 2025 17:00:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxzsG+GZNoe6k4AA--.54411S2;
	Wed, 06 Aug 2025 17:00:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xianglai Li <lixianglai@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] LoongArch: KVM: Small enhancements about IPI and
Date: Wed,  6 Aug 2025 17:00:43 +0800
Message-Id: <20250806090046.2028785-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsG+GZNoe6k4AA--.54411S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Thre are some small enhancement about IPI emulation and LBT enabling in
LoongArch KVM. With IPI, it supports sending command to vCPU itself. And
with LBT it adds flag checking int function kvm_own_lbt() and make it
robust.

Bibo Mao (3):
  LoongArch: KVM: Access mailbox directly in mail_send()
  LoongArch: KVM: Add implementation with IOCSR_IPI_SET
  LoongArch: KVM: Make function kvm_own_lbt() robust

 arch/loongarch/kvm/intc/ipi.c | 51 ++++++++++++++++++++++-------------
 arch/loongarch/kvm/vcpu.c     |  8 +++---
 2 files changed, 38 insertions(+), 21 deletions(-)


base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
-- 
2.39.3

