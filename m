Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C043E9D5;
	Tue, 10 Mar 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136346; cv=none; b=mQwINXaJbdzYGtsMWaqsa2K/oLx3RBTDKONZC5A5HvyhGTToNc2zemU14x79yIs5aBhDq2yQm5NKYnFMBuD+Yy5dMKz6d0OyN1zrBaqNHZgiRzXlahZeMeHlvPdSsWMRfvpkMvLjXyF5FS0DUIdpmFtjm6fwDFT5n1sSTQitrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136346; c=relaxed/simple;
	bh=xRINCu4c/8xrLiHdIv7M+/ekDTj8VPeli4UIZhShB0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5LlJUUllJco6/f51wBKvUaUYvlyk3ma+NXzzEL+ShrotrhenYBYhKbYOxtxS496kEPhIgWXxklnRGOzS1AsUykp2kp4XYw1fr9A4T1V2uX0cc+ipGbjOG+HRGEUMpDxrwNVCT33kwg5qqZgd5HGlr4GHWPsFhnIbWD+sOdg2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Bx08DP6a9pCncZAA--.15899S3;
	Tue, 10 Mar 2026 17:52:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJDxzsLP6a9p7gVSAA--.24922S2;
	Tue, 10 Mar 2026 17:52:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn
Cc: loongarch@lists.linux.dev,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: LoongArch: selftests: Add PMU test cases
Date: Tue, 10 Mar 2026 17:26:54 +0800
Message-Id: <20260310092657.1023650-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsLP6a9p7gVSAA--.24922S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This series adds KVM selftests for the LoongArch Performance Monitoring Unit (PMU),
covering basic event counting and overflow interrupt functionality.

Thanks.
Song Gao

Song Gao (3):
  KVM: LoongArch: selftests: Add cpucfg read/write helpers
  KVM: LoongArch: selftests: Add basic PMU event counting test
  KVM: LoongArch: selftests: Add PMU overflow interrupt test

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/loongarch/pmu.h     |  66 ++++++
 .../kvm/include/loongarch/processor.h         |  15 ++
 .../selftests/kvm/lib/loongarch/processor.c   |  14 +-
 .../selftests/kvm/loongarch/guest_pmu_test.c  | 205 ++++++++++++++++++
 5 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/guest_pmu_test.c

-- 
2.47.3

