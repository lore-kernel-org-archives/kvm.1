Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4193AA1AE;
	Tue, 10 Mar 2026 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122209; cv=none; b=EaCMCRhqOKqBOXe9hsxDdAToV+tR/t16n/mryXiC1pGSReK7FqRpOs6dCQoEserdkC0QrdOz4/v6EaiRMvT8hSMRl2TgnXZvayCAgBC257oezcwtbGPyqACRqiAeXtD0DUQnICA7mK7GjwFC5242p+NyAnSkMmw3kVQswIy42VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122209; c=relaxed/simple;
	bh=OAjBEVenncfpi3DIxb2NAElidxvomPoHDW/7S6p8hwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqJJSfKgrI312zlcGYQwiRfXaE6zIS9rqky+IrnQSTF+L96pDh7EybaXRJt6cfNtuS+t6X08O2p5rJXSemyo/NdWcPP74w+dDutD6d6umrxbj+sQBQn8HEkoqTTu7V2Zi3vXn3YUVvqmQm1RAbWTxMpwjcnEMucKOp76inmYq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAC30Ndvsq9p08A4Cg--.55585S4;
	Tue, 10 Mar 2026 13:56:00 +0800 (CST)
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
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH v3 2/2] RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test
Date: Tue, 10 Mar 2026 05:55:57 +0000
Message-Id: <20260310055557.835531-3-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
References: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC30Ndvsq9p08A4Cg--.55585S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ftFW7ZFWkXFWDZF1DWrg_yoWrWw1xpF
	W8JFWYkrWrtFnFyFy3A3ZFgr1UXan3Za4xKrW7Wry2yr4UZryfXwsIgF9Fyan8CFZYg343
	Aw1Iga1rCFnxJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjppBDUUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAgCCWmvpGApOQAAsd

The current sbi_pmu_test attempts to read firmware counters without
configuring them first with SBI_EXT_PMU_COUNTER_CFG_MATCH.

Previously this did not fail because KVM incorrectly allowed the read
and accessed fw_event[] with an out-of-bounds index when the counter
was unconfigured. After fixing that bug, the read now correctly returns
SBI_ERR_INVALID_PARAM, causing the selftest to fail.

Update the test to configure a firmware event before reading the
counter. Also add a negative test to ensure that attempting to read an
unconfigured firmware counter fails gracefully.

Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
---
V2 -> V3:
- Removed unnecessary BIT(ret.value) & counter_mask_available check.
- Asserted ret.value == i after successful CFG_MATCH.
- Fixed eidx construction in SBI_EXT_PMU_COUNTER_CFG_MATCH.
---
 .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index 046b432ae896..16f1815ac48f 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -97,6 +97,43 @@ enum sbi_pmu_hw_generic_events_t {
 	SBI_PMU_HW_GENERAL_MAX,
 };
 
+enum sbi_pmu_fw_generic_events_t {
+	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
+	SBI_PMU_FW_MISALIGNED_STORE	= 1,
+	SBI_PMU_FW_ACCESS_LOAD		= 2,
+	SBI_PMU_FW_ACCESS_STORE		= 3,
+	SBI_PMU_FW_ILLEGAL_INSN		= 4,
+	SBI_PMU_FW_SET_TIMER		= 5,
+	SBI_PMU_FW_IPI_SENT		= 6,
+	SBI_PMU_FW_IPI_RCVD		= 7,
+	SBI_PMU_FW_FENCE_I_SENT		= 8,
+	SBI_PMU_FW_FENCE_I_RCVD		= 9,
+	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
+	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
+	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
+	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
+
+	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
+	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
+
+	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
+	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
+	SBI_PMU_FW_MAX,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_event_type {
+	SBI_PMU_EVENT_TYPE_HW = 0x0,
+	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
+	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_RAW_V2 = 0x3,
+	SBI_PMU_EVENT_TYPE_FW = 0xf,
+};
+
 /* SBI PMU counter types */
 enum sbi_pmu_ctr_type {
 	SBI_PMU_CTR_TYPE_HW = 0x0,
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 924a335d2262..9404577e4ad5 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -436,6 +436,7 @@ static void test_pmu_basic_sanity(void)
 	struct sbiret ret;
 	int num_counters = 0, i;
 	union sbi_pmu_ctr_info ctrinfo;
+	unsigned long fw_eidx;
 
 	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
 	GUEST_ASSERT(probe && out_val == 1);
@@ -461,7 +462,24 @@ static void test_pmu_basic_sanity(void)
 			pmu_csr_read_num(ctrinfo.csr);
 			GUEST_ASSERT(illegal_handler_invoked);
 		} else if (ctrinfo.type == SBI_PMU_CTR_TYPE_FW) {
-			read_fw_counter(i, ctrinfo);
+			/* Read without configure should fail */
+			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
+					i, 0, 0, 0, 0, 0);
+			GUEST_ASSERT(ret.error == SBI_ERR_INVALID_PARAM);
+
+			/*
+			 * Try to configure with a common firmware event.
+			 * If configuration succeeds, verify we can read it.
+			 */
+			fw_eidx = ((unsigned long)SBI_PMU_EVENT_TYPE_FW << 16) |
+					  SBI_PMU_FW_ACCESS_LOAD;
+
+			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
+					i, 1, 0, fw_eidx, 0, 0);
+			if (ret.error == 0) {
+				GUEST_ASSERT(ret.value == i);
+				read_fw_counter(i, ctrinfo);
+			}
 		}
 	}
 
-- 
2.34.1

