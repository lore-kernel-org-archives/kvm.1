Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81097327204;
	Wed, 15 Apr 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776239561; cv=none; b=H+lfoLKdb3xpITyvmHuFhS+Xzh7T26XMrMXvLX7vRVZ3WfTH+XWnP68F9mWCEz5qfQOYuzsO8yXTZw4CNNH2tlXnfCCMMXe0mYrSZxkavLPMf8BOz9BmnppFW0VGPtj2CqdTwqJ+f8ZPKOi6sj5W4rRNsCtdTy7AGfxCeIXZ8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776239561; c=relaxed/simple;
	bh=gFoOTBhVj8qR/+DdeqVXZpUeBTgfnien4z8tg8KjX1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUVeFWnhKaIydZ042ZdiIMMt5IGV70te3+IPoaXy5pDhj6FUz3IOKTbIQ6CTh7pFo+Er9MbH5LIvl1sdzoxeKGuYVmPrWLO7PO2RDTQsYMZg5TLeCN6+vhI9Ykzy/3VZWd0Q2NEoMO0LvwqXnmAh4mGc2Ebh2qUfEJujGmBmt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABH1QiyQ99pSIKTDQ--.36677S2;
	Wed, 15 Apr 2026 15:52:18 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix invalid HVA warning in steal-time recording
Date: Wed, 15 Apr 2026 07:52:16 +0000
Message-Id: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABH1QiyQ99pSIKTDQ--.36677S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15Kr48ur1UKw13Jr4fXwb_yoW8AF15pF
	ZrCr98Ww1rtry2gasrAr4kWa1jg3yvgF1qgr9I9F90yrs0kFyYyrsYk34IvFyUJry0qF1r
	ZF1YqF1Duan8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBg0SCWnfJvJ8DgAAsA

kvm_riscv_vcpu_record_steal_time() assumes that the steal-time shared
memory GPA (vcpu->arch.sta.shmem) is always backed by a valid guest
memory slot. However, this assumption is not guaranteed by the KVM
userspace ABI.

A malicious or buggy userspace can set the STA shared memory GPA via
KVM_SET_ONE_REG without establishing a corresponding memory region via
KVM_SET_USER_MEMORY_REGION. In such cases, the GPA cannot be translated
to a valid HVA and kvm_vcpu_gfn_to_hva() returns an error address.

The current implementation incorrectly treats this as a kernel warning
using WARN_ON(), which may escalate to a kernel panic when panic_on_warn
is enabled.

This is not a kernel bug condition but a normal invalid configuration
from userspace, and should be handled gracefully.

Fix it by removing WARN_ON() and treating invalid HVA as a normal
failure case, resetting the STA shared memory state.

Fixes: e9f12b5fff8ad0 ("RISC-V: KVM: Implement SBI STA extension")
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Assisted-by: OpenClaw:DeepSeek-V3.2
---
 arch/riscv/kvm/vcpu_sbi_sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 3b834709b429f..60e50296a0085 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -46,7 +46,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 	gfn = shmem >> PAGE_SHIFT;
 	hva = kvm_vcpu_gfn_to_hva(vcpu, gfn);
 
-	if (WARN_ON(kvm_is_error_hva(hva))) {
+	if (kvm_is_error_hva(hva)) {
 		vcpu->arch.sta.shmem = INVALID_GPA;
 		return;
 	}
-- 
2.34.1

