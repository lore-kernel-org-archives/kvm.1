Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7553F4DFC;
	Thu,  4 Jun 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563483; cv=none; b=pNSxv3z/qLkRNNs3QDcEYXf2mqB3bjiUCgo50MfKQDwU34rkTWNJeRjm8yKSK7Pq14ueDXuqTzQq/7pIYH3z4TA2NspLJY37Wvynr7svsvh6OAecLl9hZIHjESqkMZ5z77eMqcFi0mwnW2n/hGwcOo1qprWR/FWcfPwnrGJCTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563483; c=relaxed/simple;
	bh=GtxeO+71d8adUmukej6kaTbdc/Qd8UZ4p9myc24RyTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ule5F89+psv/KGMHvU9T9howTInMWKgxyGUPvHgoDBi6dJHxqA2eJg+zTY1wZO1Z+0FfFBcSwJjoQdYxO+eqAR7xzylyZ1ii7jWFJ3s8T20zsMe+t3q56epv3uhKxfSYW/vaEtTCxe+SrMpGlohGwzrdCz2vlWm02jzVMsZpaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxVegTPiFq7nkQAA--.39836S3;
	Thu, 04 Jun 2026 16:57:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx28ERPiFqlIObAA--.31690S2;
	Thu, 04 Jun 2026 16:57:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: LoongArch: selftests: Add FPU test case
Date: Thu,  4 Jun 2026 16:57:50 +0800
Message-Id: <20260604085752.2820331-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28ERPiFqlIObAA--.31690S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits. It is important for VM migration.

Bibo Mao (2):
  KVM: LoongArch: selftests: Enable LASX feature by auto detect method
  KVM: LoongArch: selftests: Add FPU test case

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/include/loongarch/processor.h         |  10 ++
 .../selftests/kvm/lib/loongarch/processor.c   |  12 +-
 .../selftests/kvm/loongarch/fpu_test.c        | 144 ++++++++++++++++++
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c


base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
-- 
2.39.3

