Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BD13A3ED;
	Mon, 16 Mar 2026 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625566; cv=none; b=QK3rrnndm+JAIFf3YNaJVja31rCZskbZy8ZWrQcN+FVQ1xkH25ZFBaN8OmLSFiO/Jgyrw+1R8z0ydiyBj4Jbu2dHp0ffGJA480GrA5iHD+dhPdSNdU0NLZFf0U7JMAsDAfLFLuuQOg0RfsDewcCd78pq6NWWS30nNFb/VbD3tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625566; c=relaxed/simple;
	bh=5ABnQSYglHEWWDIwmcFBddWpOHBhJW2Jv9JdKCWHais=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ttyop9omGSvLJM4UwctPHeb0YUBUjMYSbQFZuJJLZZoxyICfb30dzXCaoMpljjk41St9czn8NUp4hPPeRPiiBbrJYZFmmDgLv5QEsVwZCHcdgLtVnumtCieCVgpWX25Vh+7a/VS3+eSu4u6fUB+AZG/rZkoV63+T0mRcGskctnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAC3XWm+YLdpa+wzCg--.590S2;
	Mon, 16 Mar 2026 09:45:34 +0800 (CST)
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
Subject: [PATCH v5 0/2] RISC-V: KVM: Fix array out-of-bounds in firmware counter reads
Date: Mon, 16 Mar 2026 01:45:31 +0000
Message-Id: <20260316014533.2312254-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3XWm+YLdpa+wzCg--.590S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fXw45Cry8Ar47tF4DXFb_yoW8Xr1fpF
	W3Ka4YkrykJrs7t343A3yktw15Xrs5Ca98GryxGF18Cr45ZryfXr1qkwnxt3WrCrsYqw1Y
	ya1Igas7CFy5Za7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr
	0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDb18U
	UUUU=
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwwICWm3WbMoDgAAsY

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

