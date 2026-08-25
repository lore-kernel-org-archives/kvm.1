Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7F35C6AC
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685031; cv=none; b=hzGWsMzA32buZ3ePMClgEJIvDjixhSiVgfnn/7fu7mv5vZsT2YGBYaa1K7t6q5/glhdy86yHugJukTZpo35okH3PkLKrJkDMaH0OV8KoMVG/UOF/OfpsJMqAIngAQ1ZE/FdpFWj9jMqOEp5zUglSZccKNivkWcdmHjEhCDRp2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685031; c=relaxed/simple;
	bh=GETmOiGo2L/g6lLcuBRxR9mY/ci64uyDlTFcOWNAjy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvK2cyr4rVlSQB2JYof8l0aYYfDJO/zhwrGc9cJu/nqBt2xfGFqcc+z+5LKWMzYUsuL1732UNOYM6ew0pl8Gv4yOLttzQL5MhuJBGYDQ/rBGVJuDw5mlTkkxjjIxJP6SFZgYhwWxGGUql84v9szclyLqSVfvvlGOQZFJB5RkoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwLD/YYP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwLD/YYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787685028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TUtIvfv2gg0aRDhrAhGSbFo8JLrTo92AiN7/f51Xts=;
	b=WwLD/YYPuGJTxCjvqmzvwCsair/FIkEkd+ZGKA+TBfDi/L3ytaJktxHLUmJwDLEunGfhT7
	zGGk1S6wM+8Oyp2khxvVXThSh/B3My9fJ7oFJ/P4MgUitiVlqdUR0Zf2RdTRkmVAS6ugvP
	ezn56dUo/q1lFTe2HiE95X1rMWy+GR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-OvU-n3L3NAu4ASG2Wf-Wcw-1; Tue,
 25 Aug 2026 15:10:24 -0400
X-MC-Unique: OvU-n3L3NAu4ASG2Wf-Wcw-1
X-Mimecast-MFC-AGG-ID: OvU-n3L3NAu4ASG2Wf-Wcw_1787685023
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 797321921ED5;
	Tue, 25 Aug 2026 19:10:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77E2718005B4;
	Tue, 25 Aug 2026 19:10:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:12 +0400
Subject: [PATCH v4 05/49] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-5-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7649;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GETmOiGo2L/g6lLcuBRxR9mY/ci64uyDlTFcOWNAjy0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiGpZoIq2GxbaAKdZbxvMWapR4YLDEC5N0ZX
 xyDgWtpVamJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohgAKCRDa6OEJdZac
 5YHMD/9AnjS+wCbYmvbrrKYh04k+LlykQJYI7k2MtvZg8vFsUD7THMizAQWdOVKgJr9BwC0iTR0
 +l5Bt8DK0HwWyfHiQ8+YYfCv0da5Hi3rKzPWNOgnDStNERawkDh3GxNuyBq+MhiQPIni8syT4VE
 VSqqGIcx2q/eN/NSBqsnOlnXq/jz513Le7D2Pz2GC5hwDUFHQ9NshOBv4i2BMAFf2DOKtJsybAc
 SmbW+eqf96ASq1AC9xgwpK2ME0yOsoty0HtfQxMqXlhpzVlNsJhWVLnrNIUNVkkehOXPD3qtEYM
 BDmLRu8PE01ano6NeNYIpVi5Wa/emUbtKqcjLleP9Chw5j7HpoCPd5cbg+veyMs7fbCbtJ9djjW
 oJYsPZ3Paj2ww9xCJteQMp/F1HJ91UIgPifRkqTIqVbG6pWZDJhHJpmdvSOHAlqU9ymF59CGTWf
 yc/TkrJVUey6IESAeVoBYv+eZysQwkEfo59i3QtMXDdZ5Q4Zov6xGvnVi3oW1ReKWrcGQw737gD
 ld076uFEv01fzpzEzPBS/fS8JAd76WWf9/la8tdcI8vLbzO/OdOWRLW+wntqp9Ti+S/XteSwGiE
 ipzJTUFGBoRUXMvmDXKlsOPl5FUJnrk3Z8es+8m0uxN4R8jtvmtZ5e7H8GyX8BsMzbba/7pMmcR
 sth3MiqXkjgeTbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace monitor_printf() error reporting with the standard **errp
pattern. Drop the Monitor *mon parameter and return bool to indicate
success, improving the function usage from non-HMP contexts. Update the
KVM MCE injection path and hmp_mce() accordingly.

Notes:
 - we may want to print the error in KVM path too

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.h     |  4 ++--
 target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
 target/i386/kvm/kvm.c |  4 ++--
 target/i386/monitor.c |  6 ++++--
 4 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2fd..dc5047cfb25a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2859,9 +2859,9 @@ void do_cpu_init(X86CPU *cpu);
 #define MCE_INJECT_BROADCAST    1
 #define MCE_INJECT_UNCOND_AO    2
 
-void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
-                        uint64_t misc, int flags);
+                        uint64_t misc, int flags, Error **errp);
 
 uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 683621416213..4133b5f244c6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
@@ -27,7 +28,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "system/hw_accel.h"
 #include "system/memory.h"
-#include "monitor/monitor.h"
 #include "kvm/kvm_i386.h"
 #endif
 #include "qemu/log.h"
@@ -381,7 +381,7 @@ out:
 }
 
 typedef struct MCEInjectionParams {
-    Monitor *mon;
+    Error **errp;
     int bank;
     uint64_t status;
     uint64_t mcg_status;
@@ -428,9 +428,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
          * reporting is disabled
          */
         if ((cenv->mcg_cap & MCG_CTL_P) && cenv->mcg_ctl != ~(uint64_t)0) {
-            monitor_printf(params->mon,
-                           "CPU %d: Uncorrected error reporting disabled\n",
-                           cs->cpu_index);
+            error_setg(params->errp,
+                "CPU %d: Uncorrected error reporting disabled",
+                cs->cpu_index);
             return;
         }
 
@@ -439,10 +439,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
          * reporting is disabled for the bank
          */
         if (banks[0] != ~(uint64_t)0) {
-            monitor_printf(params->mon,
-                           "CPU %d: Uncorrected error reporting disabled for"
-                           " bank %d\n",
-                           cs->cpu_index, params->bank);
+            error_setg(params->errp,
+                "CPU %d: Uncorrected error reporting disabled for bank %d",
+                cs->cpu_index, params->bank);
             return;
         }
 
@@ -459,7 +458,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_printf(params->mon, "%s", msg);
+            error_setg(params->errp, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
@@ -488,14 +487,15 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     emit_guest_memory_failure(MEMORY_FAILURE_ACTION_INJECT, ar, recursive);
 }
 
-void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
-                        uint64_t misc, int flags)
+                        uint64_t misc, int flags, Error **errp)
 {
+    ERRP_GUARD();
     CPUState *cs = CPU(cpu);
     CPUX86State *cenv = &cpu->env;
     MCEInjectionParams params = {
-        .mon = mon,
+        .errp = errp,
         .bank = bank,
         .status = status,
         .mcg_status = mcg_status,
@@ -506,24 +506,27 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
     unsigned bank_num = cenv->mcg_cap & 0xff;
 
     if (!cenv->mcg_cap) {
-        monitor_printf(mon, "MCE injection not supported\n");
-        return;
+        error_setg(errp, "MCE injection not supported");
+        return false;
     }
     if (bank >= bank_num) {
-        monitor_printf(mon, "Invalid MCE bank number\n");
-        return;
+        error_setg(errp, "Invalid MCE bank number");
+        return false;
     }
     if (!(status & MCI_STATUS_VAL)) {
-        monitor_printf(mon, "Invalid MCE status code\n");
-        return;
+        error_setg(errp, "Invalid MCE status code");
+        return false;
     }
     if ((flags & MCE_INJECT_BROADCAST)
         && !cpu_x86_support_mca_broadcast(cenv)) {
-        monitor_printf(mon, "Guest CPU does not support MCA broadcast\n");
-        return;
+        error_setg(errp, "Guest CPU does not support MCA broadcast");
+        return false;
     }
 
     run_on_cpu(cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
+    if (*errp) {
+        return false;
+    }
     if (flags & MCE_INJECT_BROADCAST) {
         CPUState *other_cs;
 
@@ -537,8 +540,12 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
                 continue;
             }
             run_on_cpu(other_cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
+            if (*errp) {
+                return false;
+            }
         }
     }
+    return true;
 }
 
 static inline target_ulong get_memio_eip(CPUX86State *env)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..1eeadb99adac 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -748,8 +748,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
         flags = 0;
     }
 
-    cpu_x86_inject_mce(NULL, cpu, 9, status, mcg_status, paddr,
-                       (MCM_ADDR_PHYS << 6) | 0xc, flags);
+    cpu_x86_inject_mce(cpu, 9, status, mcg_status, paddr,
+                       (MCM_ADDR_PHYS << 6) | 0xc, flags, NULL);
 }
 
 static void emit_hypervisor_memory_failure(MemoryFailureAction action, bool ar)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c755a..785a13dd7107 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -580,6 +580,7 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     uint64_t addr = qdict_get_int(qdict, "addr");
     uint64_t misc = qdict_get_int(qdict, "misc");
     int flags = MCE_INJECT_UNCOND_AO;
+    Error *err = NULL;
 
     if (qdict_get_try_bool(qdict, "broadcast", false)) {
         flags |= MCE_INJECT_BROADCAST;
@@ -587,7 +588,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     cs = qemu_get_cpu(cpu_index);
     if (cs != NULL) {
         cpu = X86_CPU(cs);
-        cpu_x86_inject_mce(mon, cpu, bank, status, mcg_status, addr, misc,
-                           flags);
+        cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
+                           flags, &err);
+        hmp_handle_error(mon, err);
     }
 }

-- 
2.55.0.543.g5ebe2ebe4ea8

