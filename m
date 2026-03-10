Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C5280CFB;
	Tue, 10 Mar 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122209; cv=none; b=gPsY2ph+rUfeob90jL3eo0uKXWBP/a3sRV4FIDmPj++sY5UecruFXxBYXJcMSvukExoNxs3o6xsF1U6xMPxFeyDg7x8UttnwEJcFnTUFLRogAcIwQAubKKJUtIUp6/NE+R6ykHCNX4Qe/41fyAxXNPCcGwHBX6LGlBa06DYwCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122209; c=relaxed/simple;
	bh=ygrD6QlUMuXbtmBHA2jJax7ZySVX+noemB4jY0XFkKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b0IELzBCHAwq4sMp1r4V8JdlyTsn6oAIZRsX1i3CWSriypMPRecKxpogfFJy/MIXl6s61nI9NqVZGFmZ7N1Gb4Xi9EU2FCYzkX2CZ3noAU3EhorcdFKgFcRq1cFWxbA2PlbWZNGz0vXwgIOAZaApISohch+Iex/4uePwUp0mCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAC30Ndvsq9p08A4Cg--.55585S2;
	Tue, 10 Mar 2026 13:55:59 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>
Subject: [PATCH v3 0/2] RISC-V: KVM: Fix array out-of-bounds in firmware counter reads
Date: Tue, 10 Mar 2026 05:55:55 +0000
Message-Id: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC30Ndvsq9p08A4Cg--.55585S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fXw45Cry8Ar47tF4DXFb_yoW8Xr1xpF
	ZxKa4YkrykJrs7t343A3ykJw15Xrs5Ca98Gry7GF18Cr45ZryfXryqk3sxtF1rCrsYqw1Y
	ka1Igas7CFy5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZ2-5UU
	UUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBgwCCWmvomAt5wAAsP

When a guest reads a firmware PMU counter via
SBI_EXT_PMU_COUNTER_FW_READ or SBI_EXT_PMU_COUNTER_FW_READ_HI without
first configuring it with SBI_EXT_PMU_COUNTER_CFG_MATCH, the counter's
event_idx remains SBI_PMU_EVENT_IDX_INVALID (0xFFFFFFFF).

get_event_code() extracts the lower 16 bits from event_idx, yielding
0xFFFF, which is then used to index into kvpmu->fw_event[]. Since the
fw_event array only contains RISCV_KVM_MAX_FW_CTRS entries, this results
in an out-of-bounds access that can be detected by UBSAN.

Patch 1 fixes the issue by validating the firmware event code before
accessing the fw_event array and returning -EINVAL for invalid values.

After fixing the kernel behavior, the existing KVM selftest
(sbi_pmu_test) fails because it attempts to read firmware counters
without configuring them first. Patch 2 updates the selftest to
configure a firmware event before reading the counter and adds a
negative test to ensure that reading an unconfigured firmware counter
fails gracefully.

6eanut (2):
  RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and
    pmu_fw_ctr_read_hi()
  RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test

 arch/riscv/kvm/vcpu_pmu.c                     | 14 +++++++
 .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.34.1

