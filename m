Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102245FFA0
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710964; cv=none; b=SKA+Mbd+lBhFZOB9oORCccGNNOdtbOnl4J9Q3hJP0nXlXHs0DxWAVenodSDx+9ct29g5RytPmepA1LgJ/Gb6ADdY8Zo4e0mhD00KfiDyaHng7BDGLNZFkQ1gJng17q/14gbkxxMX/XA6qwTiXsHpKMkrFOqx8iEqoU7U8tbG7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710964; c=relaxed/simple;
	bh=TkDW6b1+JKxpBtH+Vbo/8j3ET4tgnpLuLKovOFW3zZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjR4uhn8zf5c9fVMTHKjf2YwYqeaY/HQsnr1YRdQDpH/Qsmn86xc/URQsUDaaHkXwJUHJpeA2APL+nN4DQCSELzwJ4gOjHwDYbwrFJBlsf7kbzp1/CIaIYqr61nr32A3L8V6WeTH/8l6m7KjXf3QT/dmaZd3J6hQVEocfEePt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xgf3xPwG; arc=none smtp.client-ip=95.215.58.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xgf3xPwG"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TkDW6b1+JKxpBtH+Vbo/8j3ET4tgnpLuLKovOFW3zZ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786710960; v=1; x=1787315760;
 b=Xgf3xPwGoJUhfVKJ1HubtXLNhQ/VQmb9u1CN0m3V9R2HmtQblCZh3sx2l9akP0BTYlaZZW1V
 5E3zFObEJRL6KShO+nC48ivs2DEOAS9Pj6/FLHbyB7XifjTiBwNjS5/LdzhOwX3GUdKqZpjCXtL
 Bw1WV5FYAdbSuM86iohHZnJ4=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id c1eb88277eb99e05;
	Fri, 14 Aug 2026 12:36:00 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH] KVM: riscv: Avoid redundant interrupt check for pending timers
Date: Fri, 14 Aug 2026 08:35:41 -0400
Message-ID: <20260814123541.593613-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_vcpu_check_block() calls kvm_arch_vcpu_runnable() before
checking whether a timer is pending. On RISC-V, kvm_arch_vcpu_runnable()
already checks all pending guest interrupts through
kvm_riscv_vcpu_has_interrupts(vcpu, -1UL), including IRQ_VS_TIMER.

Drop the repeated IRQ_VS_TIMER pending-interrupt check from
kvm_riscv_vcpu_timer_pending() and keep the helper focused on the timer
deadline state. If the timer becomes pending after the runnable check,
the timer path still injects IRQ_VS_TIMER and kicks the vCPU through the
normal wakeup path.

Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 arch/riscv/kvm/vcpu_timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index ae53133c7ab0..0e01bd793772 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -132,11 +132,7 @@ bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
 	struct kvm_guest_timer *gt = &vcpu->kvm->arch.timer;
 
-	if (!kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t) ||
-	    kvm_riscv_vcpu_has_interrupts(vcpu, 1UL << IRQ_VS_TIMER))
-		return true;
-	else
-		return false;
+	return !kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t);
 }
 
 static void kvm_riscv_vcpu_timer_blocking(struct kvm_vcpu *vcpu)
-- 
2.43.0

