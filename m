Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF93BFE5B;
	Tue, 16 Jun 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576788; cv=none; b=HsxjqY6K9a6VEYuynYKlU6JFiBB29xEkf1v9BQz9qNmr1/vnH6av+WQeewMU6slRmy/3ORhzasDHmEjyT0zDR4OnJ26qNXGGG5IjPVhBJyczNLhHda+ldyZif0bPuAJU4KDVfvaLSROoYey64pDJDVKCKYHXBq8iujGeyLvr/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576788; c=relaxed/simple;
	bh=V77/xJFXF1BGBgjwljiqLmVdvU3je0PQI8qT/DGU2Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMFefbZ8znul50pLv/ZfTv/Enfqj1LwL77Z3hdS67VAabFm5jSWTQFSGU1TSz67UiUdYv+UAfvIA5HGfyvB5ztPIXdukTtiZt0CVRlYH4Tly3E8ltgFyu2EIxq2wBf2Htjh0SLDiMZ19HPEN0MwYr+CdEEXCOYa683NO+cMWQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxhnhNtDBqcpsUAA--.29290S3;
	Tue, 16 Jun 2026 10:26:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxXcJItDBqz7WnAA--.54020S2;
	Tue, 16 Jun 2026 10:26:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/2] KVM: LoongArch: selftests: Add FPU test case
Date: Tue, 16 Jun 2026 10:26:13 +0800
Message-Id: <20260616022615.2141072-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxXcJItDBqz7WnAA--.54020S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Here add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits. It is important for VM migration.
---
v2 ... v3:
  1. Remove __vm_has_feature() and use __kvm_has_device_attr() directly
     when checking LSX/LASX feature in patch 2.

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
 .../selftests/kvm/loongarch/fpu_test.c        | 138 ++++++++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.39.3

