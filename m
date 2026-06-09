Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D12AD00;
	Tue,  9 Jun 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990047; cv=none; b=LlTbTJngIRG7QjhgdmC7Wl+y9FSX+kX8br78wy6k4yPR5q0jCfARhzIIsC+jbzWAgkoUU//5KnTfGWlMBNX1cahjloKsRdvMiyj/tT3s+QM6s6BQWqvVjuKY+63O+NgzYE8EgjAwK1hXWlfwHkWXrI26zG5QHkKgGe4ZptGtvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990047; c=relaxed/simple;
	bh=hw8Dwm3pt/+zDzGc7w6MSKicdrHi14/dfJrVgEJJ7ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C3eu8rQUeqjlORPYRTe84tUjPaY1JwWZmXha1OTILSTRlb99YTwU27hHaTek7fBfByNZ62uOHQIDhHANjQWo0TybDydJEKknGaFRmn67zfEK4fupupBX0rgr5rddDBTuFLEYBMgritbpOU6dv6eHfm4s+xJKwoZlbaeIsgaIiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxAutZwCdqQCkSAA--.48682S3;
	Tue, 09 Jun 2026 15:27:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxquBUwCdq7oqgAA--.42025S2;
	Tue, 09 Jun 2026 15:27:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: LoongArch: selftests: Add FPU test case
Date: Tue,  9 Jun 2026 15:27:13 +0800
Message-Id: <20260609072715.1005923-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxquBUwCdq7oqgAA--.42025S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits. It is important for VM migration.
---
v1 ... v2:
  1. Replace hardcode value with CSR_EUEN_XXX when enable FPU access.
  2. Add attribute __aligned(64) with kvm_fpureg variable with better FPU
     save and restore.
  3. Add clobber $f0 register with inline assemble language with
     fld.d/vld/xvld instruction.
  4. Add fallthrough between UCALL_DONE and UCALL_SYNC switch case
     sentences.
  5. Remove sync_global_from_guest() between vcpu_fpu_get() ioctl test
     case, since the buffer is not modified with such instructions
     fld.d/vld/xvld.
  6. Modify FPU register with random value rather than plus 0x10, and
     random() is replaced with value 0x10.
---
Bibo Mao (2):
  KVM: LoongArch: selftests: Enable LASX feature by auto detect method
  KVM: LoongArch: selftests: Add FPU test case

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/include/loongarch/processor.h         |  18 +++
 .../selftests/kvm/lib/loongarch/processor.c   |  12 +-
 .../selftests/kvm/loongarch/fpu_test.c        | 145 ++++++++++++++++++
 4 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c


base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
-- 
2.39.3

