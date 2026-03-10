Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D0324705;
	Tue, 10 Mar 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122209; cv=none; b=fCsW96sEpqjiToC7OfKF+DATI3RcN2N09f1IKWj3nNJWjDT6PI1KLPoXQPW6fyL2C3AWXXtsV8PaAIlqzYF8wqLJICRoAmLZ5c3S555tQVueeaym4+5YVRfIAmpo7ntYJCe3BphtRJjTFewobhhiHJgcrzB8RrK2p8Lvp84hHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122209; c=relaxed/simple;
	bh=8zuN/PEkDKF2GRxVw5Memi/ODdqD8Ac62nwPc88i0vY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt7gOG/2iYYUuc/SsPrg2v08B+L0gCmfSgXXwoKDVn4nwta5amZ/FRW3yb92Kr7JQxY5wptmKdA4gLkPTCSvvOVdw8ndRMyQG0KEy+BxZB3Hyq07hXPO6fvvatDgoNL3nVZxH5IHR3y7R/jikWXjbWxWPDPDmfwBegarfpQoBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAC30Ndvsq9p08A4Cg--.55585S3;
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
Subject: [PATCH v3 1/2] RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and pmu_fw_ctr_read_hi()
Date: Tue, 10 Mar 2026 05:55:56 +0000
Message-Id: <20260310055557.835531-2-xujiakai2025@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC30Ndvsq9p08A4Cg--.55585S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1fCFW8Xw1rtF4kZw13Arb_yoW5Xw1fpr
	47Kwn0q395trZ2vw1Yyw1Duw4Uta1kK398WrW7WF18Aw13Wry3JFyDW3sIqF43AF4Fqa4x
	tw1Ig3WxCFy5Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUj0edDUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwkCCWmvo+0qZgAAsB

When a guest invokes SBI_EXT_PMU_COUNTER_FW_READ or
SBI_EXT_PMU_COUNTER_FW_READ_HI on a firmware counter that has not been
configured via SBI_EXT_PMU_COUNTER_CFG_MATCH, the pmc->event_idx remains
SBI_PMU_EVENT_IDX_INVALID (0xFFFFFFFF). get_event_code() extracts the
lower 16 bits, yielding 0xFFFF (65535), which is then used to index into
kvpmu->fw_event[]. Since fw_event is only RISCV_KVM_MAX_FW_CTRS (32)
entries, this triggers an array-index-out-of-bounds:

  UBSAN: array-index-out-of-bounds in arch/riscv/kvm/vcpu_pmu.c:255:37
  index 65535 is out of range for type 'kvm_fw_event [32]'

Add a check for the known unconfigured case (SBI_PMU_EVENT_IDX_INVALID)
and a WARN_ONCE guard for any unexpected out-of-bounds event codes,
returning -EINVAL in both cases.

Fixes: badc386869e2c ("RISC-V: KVM: Support firmware events")
Fixes: 08fb07d6dcf71 ("RISC-V: KVM: Support 64 bit firmware counters on RV32")
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
---
V2 -> V3:
- Added check for SBI_PMU_EVENT_IDX_INVALID.
- Added WARN_ONCE for unexpected out-of-bounds event codes.
V1 -> V2:
- Merged the fixes for pmu_ctr_read() and pmu_fw_ctr_read_hi() into a single
commit.
- Removed the pr_warn, simply returning -EINVAL instead.
---
 arch/riscv/kvm/vcpu_pmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e873430e596b..c87a7b0037cf 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -226,7 +226,14 @@ static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
 		return -EINVAL;
 
+	if (pmc->event_idx == SBI_PMU_EVENT_IDX_INVALID)
+		return -EINVAL;
+
 	fevent_code = get_event_code(pmc->event_idx);
+	if (WARN_ONCE(fevent_code >= SBI_PMU_FW_MAX,
+				  "Invalid firmware event code: %d\n", fevent_code))
+		return -EINVAL;
+
 	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
 
 	*out_val = pmc->counter_val >> 32;
@@ -251,7 +258,14 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 	pmc = &kvpmu->pmc[cidx];
 
 	if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
+		if (pmc->event_idx == SBI_PMU_EVENT_IDX_INVALID)
+			return -EINVAL;
+
 		fevent_code = get_event_code(pmc->event_idx);
+		if (WARN_ONCE(fevent_code >= SBI_PMU_FW_MAX,
+					  "Invalid firmware event code: %d\n", fevent_code))
+			return -EINVAL;
+
 		pmc->counter_val = kvpmu->fw_event[fevent_code].value;
 	} else if (pmc->perf_event) {
 		pmc->counter_val += perf_event_read_value(pmc->perf_event, &enabled, &running);
-- 
2.34.1

