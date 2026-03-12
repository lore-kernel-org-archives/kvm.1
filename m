Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFF1A0BE0;
	Thu, 12 Mar 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278405; cv=none; b=eCKMo2KlKdW/YQMSDfhPuez6lEBG3NkJKJX9JknVhYcZTTczNn1oZ0T9EA7P5Z18ohtgNvfTI7oIX5NqmOxIAAOUoiCF94LW0WNOr5fXq5DsAtMOR24McylMj8pbsyB5zWHpktPFdt5MTOGJyX+JoGXFF3OnuXQ6/DwZiI3rRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278405; c=relaxed/simple;
	bh=5ABnQSYglHEWWDIwmcFBddWpOHBhJW2Jv9JdKCWHais=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJBOyxZCOcBcj3vyFBY2gTuslZoDTxvN8PATo9t2yH+WZ2rdQQ7sVFoaDrDbPrND3RYkGM6TBX4DOCvsHZ2hbXkvO/RIGLWZ3d2Wa1Yi7f5onvJL/I8c8JkVyUcbzQyKEr9lzaPEwX7cgXrofXTxmHy+99K6ylRTHB9m95ITP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAntwqkFLJpB6U4Cg--.65391S2;
	Thu, 12 Mar 2026 09:19:33 +0800 (CST)
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
Subject: [PATCH v4 0/2] RISC-V: KVM: Fix array out-of-bounds in firmware counter reads
Date: Thu, 12 Mar 2026 01:19:29 +0000
Message-Id: <20260312011931.1352239-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntwqkFLJpB6U4Cg--.65391S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fXw45Cry8Ar47tF4DXFb_yoW8Xr1fpF
	W3Ka4YkrykJrs7t343A3yktw15Xrs5Ca98GryxGF18Cr45ZryfXr1qkwnxt3WrCrsYqw1Y
	ya1Igas7CFy5Za7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAaw2AFwI0_JF0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wrylc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNeOpDUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCQ4ECWmx5mWOZAACs5

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

Jiakai Xu (2):
  RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and
    pmu_fw_ctr_read_hi()
  RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test

 arch/riscv/kvm/vcpu_pmu.c                     | 14 +++++++
 .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.34.1

