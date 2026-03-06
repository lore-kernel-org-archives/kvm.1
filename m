Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C0376492;
	Fri,  6 Mar 2026 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782691; cv=none; b=TmqwBxEM9Yxk0bd/CyxhbW+mjVw1Pa2lTL+d+2TNmgOU+7axS4QwfNp/3+Kt0jCPf2vH/cM2g3eYflg4Ldz5Z8Ufk2tmKH0WuwaxzepSg/tk89p80eQp8v/zsV4f14Pn7ikPMO3cjSHUzbdY99bcgJvELYLo9uYaKxxQ//kgqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782691; c=relaxed/simple;
	bh=9W6lWpIPyCepfjaR47bzG+FodGlZWvhNDBSDg/QcjD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjFyRLHb9dIvxGrJul05B8bf6BLjvRAXi/rhwbNwdeiVctnVxStiOZIX9VvWEG+ukbeo3LkoiiGGhzLNVG0qnTDBQ2AVv9nkEGZO7/Ov97206gPpSrHrmbEQOqMxEk7QCNxNsJIihBb2SAyfNIEkH/zLN1P7l8cRLt9WCcYPiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAXpglFhKppgcC9CQ--.1822S4;
	Fri, 06 Mar 2026 15:37:44 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH 2/2] RISC-V: KVM: Fix array out-of-bounds in pmu_fw_ctr_read_hi()
Date: Fri,  6 Mar 2026 07:37:39 +0000
Message-Id: <20260306073739.3441292-3-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306073739.3441292-1-xujiakai2025@iscas.ac.cn>
References: <20260306073739.3441292-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXpglFhKppgcC9CQ--.1822S4
X-Coremail-Antispam: 1UD129KBjvJXoW7GF4DXr1fAr1Uur45Xw13urg_yoW8JrWrpr
	sFkFyag3s5trn2va4Yyw1DurWjyw4kKFZ0gr1j9F15Jr12vry3tFyDu3sxJr13AFW0qryI
	kw42kas7CFW5Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSQ6JUUUUU=
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwoSCWmqYzp40wAAsn

pmu_fw_ctr_read_hi() has the same issue as pmu_ctr_read(): when a guest
reads a firmware counter that has not been configured, pmc->event_idx is
SBI_PMU_EVENT_IDX_INVALID and get_event_code() returns 0xFFFF, causing
an out-of-bounds access on kvpmu->fw_event[].

Add the same bounds check on fevent_code before accessing the fw_event
array.

Fixes: 08fb07d6dcf71 ("RISC-V: KVM: Support 64 bit firmware counters on RV32")
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index c6d42459c2a1..b7ceda1643ec 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -227,6 +227,10 @@ static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 		return -EINVAL;
 
 	fevent_code = get_event_code(pmc->event_idx);
+	if (fevent_code >= SBI_PMU_FW_MAX) {
+		pr_warn("Invalid firmware event code [%d] for counter [%ld]\n", fevent_code, cidx);
+		return -EINVAL;
+	}
 	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
 
 	*out_val = pmc->counter_val >> 32;
-- 
2.34.1

