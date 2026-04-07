Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60213A0B13;
	Tue,  7 Apr 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553314; cv=none; b=gGU/xjgZspJxBbmMIX8DxyVgbKWDMC87Qqlwk82kfndfodrwPvjP88LZFHXyptgLjpHZvhI6xjJ4h2m6opQ31OjVnDfG1mlcVNPiq7kM4eDpdudEPEEnzwHZF1EvOc57UMbh0KN4K65Xu/y9uiAMQZJ4lHoEEcWqOHI6sRo1zxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553314; c=relaxed/simple;
	bh=Cxqvhvo5oKEKZ1cdBCU2bgE9T3FwDSksh9rd9Vt7PQA=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=oaroQZhDoQHONdEQg/3FumDpIfNYC9qD1t4HKqbTz2gvJMcn/qVGHfApqDt7HOUqfFMFkoitX5iJ1t6NNehaBfx+2lemKpIKd6PEwkUqHAtuvEfVQWOu0w54llf4oM9JppuxN/cDRg4T1/gMW+WP8XCeiPNfSX5t+jQ6aJShQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fqgWz00Dnz7QYRQ;
	Tue, 07 Apr 2026 17:15:10 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 6379Ere8070472;
	Tue, 7 Apr 2026 17:14:53 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 7 Apr 2026 17:14:55 +0800 (CST)
X-Zmail-TransId: 2b0369d4cb0fb57-00521
X-Mailer: Zmail v1.0
Message-ID: <20260407171455735miXfwO3C51btdouaaGUEc@zte.com.cn>
In-Reply-To: <20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn>
References: 20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn
Date: Tue, 7 Apr 2026 17:14:55 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvM10gUklTQy1WOiBLVk06IGFkZCB0cmFjZXBvaW50cyBmb3IgZ3Vlc3QgcGFnZSBmYXVsdHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6379Ere8070472
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Apr 2026 17:15:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69D4CB1E.001/4fqgWz00Dnz7QYRQ

From: Wang Yechao <wang.yechao255@zte.com.cn>

Add the kvm_page_fault event tracepoints to count the number of KVM
guest page faults.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/trace.h     | 25 +++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_exit.c |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
index 3d54175d805c..9056cc9883cf 100644
--- a/arch/riscv/kvm/trace.h
+++ b/arch/riscv/kvm/trace.h
@@ -56,6 +56,31 @@ TRACE_EVENT(kvm_exit,
 		__entry->htinst)
 );

+/*
+ * Tracepoint for page fault.
+ */
+TRACE_EVENT(kvm_page_fault,
+	TP_PROTO(struct kvm_vcpu *vcpu, u64 fault_address, u64 error_code),
+	TP_ARGS(vcpu, fault_address, error_code),
+
+	TP_STRUCT__entry(
+		__field(unsigned int,   vcpu_id)
+		__field(u64,            fault_address)
+		__field(u64,            error_code)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id        = vcpu->vcpu_id;
+		__entry->fault_address  = fault_address;
+		__entry->error_code     = error_code;
+	),
+
+	TP_printk("vcpu %u address 0x%016llx error_code 0x%llx",
+		__entry->vcpu_id,
+		__entry->fault_address,
+		__entry->error_code)
+);
+
 #endif /* _TRACE_RSICV_KVM_H */

 #undef TRACE_INCLUDE_PATH
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..0cfb0149da9f 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -11,6 +11,7 @@
 #include <asm/insn-def.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
+#include "trace.h"

 static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			     struct kvm_cpu_trap *trap)
@@ -43,6 +44,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		};
 	}

+	trace_kvm_page_fault(vcpu, fault_addr, trap->scause);
+
 	ret = kvm_riscv_mmu_map(vcpu, memslot, fault_addr, hva,
 				(trap->scause == EXC_STORE_GUEST_PAGE_FAULT) ? true : false,
 				&host_map);
-- 
2.47.3
