Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397C484899;
	Mon, 21 Sep 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993660; cv=none; b=tUQluB1ZCUIbDXqUian16Nkh7/1JSZQzAPoz0RWx5opnxZOiCnpexmvZvNx9ZC2xTURawfxIaG5958cFyMy/ygitLvqX4LBBhlIYqz0lfXXbb9tqaLL+g+0GowPD/rhacDB0+90lc4s2JjTolw65YAM4TeMbly80DxYGB/MNVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993660; c=relaxed/simple;
	bh=8slFpj6V+wxA425Ck48abJXZQvB/iF8gGN86pruXVRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik2ziWlLJa6hW0UzJ0IbxD8ubCC+ID6FE71szl4IVksaoOm09Ba5xOLAKbu+8yp4KsLkYtLK/6KaUdsrlLJyKpTkCqVpsxEJhEwFC8AtngRF/fQJxcuFwA3Ott9YAG+DO/14D7uaDPcbcqgbCeahz5qLtht6iSudnXgb4rd0/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1Cb4P8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1Cb4P8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB6B1F00893;
	Mon, 21 Sep 2026 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993658;
	bh=npVan5VYT3AMl8n3RsICnE+OLDep7BXyveNoQgrKcOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A1Cb4P8ThKMPt2giCW4nM7EaQmmLM33Ov/QZQmZa2tIcFUjS8Q7l9LaKF6xwPTAyb
	 xFHga9ra0KEbMXmpWx+sVZqNKmutZBveKjqGjRhkIV+S84Lq0mgyEP5yW4NSG8SD4/
	 dDVWFR94zsYs8mHpKyZhXlOe+k0xNlYSLuDK5jugzVHc1fNr0RV3T9XY4ZY0Z/zzLF
	 iA4zjbpCooMCQdKYj63+sKREzy75dn7cP8XMPKfQ2b0hNbrxuULvO0P91pV25XhEDs
	 fT7ENzTXbDfCjyN3N5mDTPvh5OO3H0jVLh8eQxFFwbi7r6TS4fDAhmHiDtJdkzUbso
	 8PUTqwSZAhPCg==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Date: Mon, 21 Sep 2026 12:27:03 +0000
Subject: [PATCH RFC v4 3/4] RISC-V: paravirt: pvqspinlock: Add trace point
 for pv_kick/wait
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pvqspinlock-v4-3-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
In-Reply-To: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
 CHEN Jiankang <yubin.cjk@alibaba-inc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Leonardo Bras <leobras@redhat.com>, 
 "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

Add tracepoints for pv_kick and pv_wait to observe the paravirt
qspinlock behavior:

  # cd /sys/kernel/debug/tracing
  # echo 1 > events/paravirt/enable
  # cat trace
  TASK-PID   CPU#  |||||  TIMESTAMP  FUNCTION
     | |       |   |||||     |         |
    sh-100   [001] d..2.  28.312294: pv_wait: cpu 1 out of wfi
  <idle>-0   [000] d.h4.  28.322030: pv_kick: cpu 0 kick target cpu 1

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
 arch/riscv/kernel/qspinlock_paravirt.c           |  7 +++
 arch/riscv/kernel/trace_events_filter_paravirt.h | 58 ++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
index c534447437fe..04b13994e971 100644
--- a/arch/riscv/kernel/qspinlock_paravirt.c
+++ b/arch/riscv/kernel/qspinlock_paravirt.c
@@ -7,8 +7,13 @@
 #include <asm/qspinlock_paravirt.h>
 #include <asm/sbi.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace_events_filter_paravirt.h"
+
 void pv_kick(int cpu)
 {
+	trace_pv_kick(smp_processor_id(), cpu);
+
 	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
 		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
 }
@@ -25,6 +30,8 @@ void pv_wait(u8 *ptr, u8 val)
 		goto out;
 
 	wait_for_interrupt();
+
+	trace_pv_wait(smp_processor_id());
 out:
 	local_irq_restore(flags);
 }
diff --git a/arch/riscv/kernel/trace_events_filter_paravirt.h b/arch/riscv/kernel/trace_events_filter_paravirt.h
new file mode 100644
index 000000000000..8d57efda2c17
--- /dev/null
+++ b/arch/riscv/kernel/trace_events_filter_paravirt.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 GUO Ren (XuanTie) <guoren@kernel.org>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM paravirt
+
+#if !defined(_TRACE_PARAVIRT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PARAVIRT_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(pv_kick,
+	TP_PROTO(int cpu, int target),
+	TP_ARGS(cpu, target),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+		__field(int, target)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->target = target;
+	),
+
+	TP_printk("cpu %d pv_kick target cpu %d",
+		__entry->cpu,
+		__entry->target
+	)
+);
+
+TRACE_EVENT(pv_wait,
+	TP_PROTO(int cpu),
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu %d out of wfi",
+		__entry->cpu
+	)
+);
+
+#endif /* _TRACE_PARAVIRT_H || TRACE_HEADER_MULTI_READ */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../../arch/riscv/kernel/
+#define TRACE_INCLUDE_FILE trace_events_filter_paravirt
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.43.0

