Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478803043A7;
	Tue, 19 Aug 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605854; cv=none; b=OvMivJx+UJa1hy8lhuD5GDzP24T7PDTNq+oDnBYQprlwoYcLQfyOlzqsa4TdzBpnC3bq0eP73wwWh7YLbt28rYBg6EeHQ2882F4WncsKh/6Pwro8lh9wp3hoKlJl18MPpSrqP7czACGcC/4ziQs221IbRGsl9vjovSxS3SgrMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605854; c=relaxed/simple;
	bh=13cJ3LLl+BEyaEg2m8lLOvDNUxze5XMFg47O9XVdI/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6+YrcqNXdCPDCQ9c4VjPq7YI+pP0TqT0UtIIyCxciF1DHKFkQZDOgHhx4tJn0NAcYVi9mrxmE666g0f0mxCZT/A0QnbafxrHdcutv+FapW7+L5qL1SsJGKMyoxmMK7FxWp73HDSbEUCzNlzQlnhNUFxty74g3pBFtoMUmxoj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx_79Wa6Rop2IAAA--.373S3;
	Tue, 19 Aug 2025 20:17:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxfcFWa6Ro2DtYAA--.19719S2;
	Tue, 19 Aug 2025 20:17:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Xianglai Li <lixianglai@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add sign extension with kernel MMIO read emulation
Date: Tue, 19 Aug 2025 20:17:23 +0800
Message-Id: <20250819121725.2423941-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcFWa6Ro2DtYAA--.19719S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patch is to add sign extension with kernel MMIO/IOCSR read
emulation, it is similar with user space MMIO/IOCSR read completion
handling.

Bibo Mao (2):
  LoongArch: KVM: Add sign extension with kernel MMIO read emulation
  LoongArch: KVM: Add sign extension with kernel IOCSR read emulation

 arch/loongarch/kvm/exit.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)


base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.39.3

