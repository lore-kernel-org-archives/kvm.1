Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709DA29993D
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354988; cv=none; b=IqKExzCnHd49Hb2BwYqxL3ycvZXr16q3TIEwVJFpxvBifgZ4/H4QlB+yJ0KWS3o7/GG9Eb25TB+IUY6UA2EnOHqI/oScTLa1/Bt9XENpXNHZryfq5l9VYC6UdbRt19Rp4joRdNU0FwunoZ0wOWovVHtHe37fsN0t/WIr4+80vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354988; c=relaxed/simple;
	bh=99F56sql+lTceZfJkgoewPAYKcEX9L5lls+RVGn7SNY=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=nlb9Uid0aW9UKHPMAgyTdqf2LKicLvrvyT32cVaQZ40B/jVsyV0ypNhiLiDQTHrtz/mW50+C5h84UqDxgIEvNIx24s9xDRppL8c37zxlMEg/1wjQnBBQgUIoi6WRsGk4hIDSlndC0DRHfagt+zMK6ojtEA/ZBo3pDjLy5A/l6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kbhikPiB; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kbhikPiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779354975; bh=udC3u4nUzfmbSLr5MaGeJJWeqWl4C54Fbdjxw+NQhTg=;
	h=Date:From:To:Cc:Subject;
	b=kbhikPiBTOJ/Jim3vYCY1c//ilIAhRYyrTzLW6xXzqdcs4Ydf6kCusJJF5wVXS1eb
	 hQLWe0pBA9eof/gX/Wt8t2t9YI+hw3zbuTXQcvavGsTtMCRETxv3QU11/YTSeafaRz
	 TFOVVvSJioJvJ6Myzn+aGbJtZ5LjRijOkFVCdseQ=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 40D0E277; Thu, 21 May 2026 17:16:13 +0800
X-QQ-mid: xmsmtpt1779354973tkfezbvwe
Message-ID: <tencent_2A66410581309346060C5BDC8CD108053005@qq.com>
X-QQ-XMAILINFO: MDuh8jTfiFWwFRNRm+1pRxaw6ZWH95Nb8YcF26XugbfOnX2764drhX7qh4QY8F
	 mCsIdK4Y+iCXrDR8z9k0t+jBX6/iHZDn4BT0SXFmf4jaQeBuKP3uK5+VBADyY0YkFo1etABcsXXV
	 kJ/QJE0rlTKUXtfFnpSBj3vlK91h8WrPykCG8a5ESkOE0UpiSoPRDUDXcAC9IpHsq1P51JkbRVTX
	 VGJVVaSlfVc1MLFyzULoPMrueLmm/gABxQ9CzRDs8cK2ixOSypDCCgnc/rvMSIPAdfsgZmCS3SBY
	 Ur1rBj6ePjUW/GfdGC6u+bIw7ZKRXg7FzVBd+i/GeVGdU1/VeuTG/Scivp4nBFYBd8Px8Qf6ekRU
	 ULj3mh7asFpC7ZZwJ8c1ExE1g3FmwJBARQfHn210FOVNAbhvdhgbOLy2QtHa4E7WT83SbQBej1pF
	 L9G65g0oWehLSmz17vfUKi6Zeu3kkUvvIiPxN3RgryH60BmFS49yUJCjPMr8snZ0K7h9oGhsZbNl
	 tdhoVlkDL/X1itnf/4nINyFpFQV7eSVXxccuxHOpJKS1w0b29Tx7KLqxYIZ4vUv9LdHomhocWq/5
	 jYmHJpiSK52hl5MDC8XO95Q3dvaJJOS6EntermXw+jDM5I7weItG1dPgQpgWYOg32K21+3wu48R4
	 fW7Nc8O4jIh2j9YnsVOlIYDvZjjOZBpVNOppl697eeGWaoW+EglhLdLtKXOEsA9nGMCOEoioS1wU
	 /zqldF7ehHWR8QZ1unS1VtrrfafwvAU+gwYguNJ9gDg7Uq6hDqeqFNl1vxBaHqCO9gz8+fedin+r
	 l2Sehwsf0YkgriY3R624VlPtBZEXQFK4sfyFhDPrlJZPrS/MpDRNXjbtpjfWL5UjI28cV+cKjoQj
	 58CoVDoVz1DVMeX90tCltwNVtcuzF40d5OqV9ICq4FwV6+yfy9KmDQLDDzuwMII6q5vQS3+XbL1s
	 DcQ5pZYnTPQgvEVH8+IWFhsf2nMkSGSJ3zu1+kSYOBZVSLGMoXsNyxCp6CbFIOcs8C/rrhOG/72a
	 wNbom9vXVU+InDvJre4vuyHK33bVS//Ag7nej8HmqBJxm5s3qLr/OTayaXK/n8XgYBU1pUFx5ozi
	 /GiN74Ptu31i/6Maur7jIGiTAZZA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Date: Thu, 21 May 2026 17:16:12 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: Add tracepoint for vCPU wait/yield paths
X-OQ-MSGID: <20260521091612.GA202377@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From 0c8d4428390a1238a956f713c1ddced18eac83da Mon Sep 17 00:00:00 2001
From: Hao Zhang <zhanghao1@kylinos.cn>
Date: Thu, 21 May 2026 16:30:37 +0800

Add a KVM x86 tracepoint that reports when a vCPU reaches selected
wait/yield handling paths in KVM.

The tracepoint is informational only. It does not change KVM scheduling
behavior, vCPU placement, directed-yield policy, or host scheduler state.
It also does not report the outcome of scheduling decisions.

In particular, the target field is the guest-supplied value when one
exists. It does not imply that the target exists, is runnable, or that a
directed yield succeeded.

Report events for PAUSE-loop exiting after hardware has already delivered
a PLE exit, guest HLT emulation, and paravirtual yield-style paths,
including KVM_HC_SCHED_YIELD, Hyper-V long spin wait, and Xen sched yield.

Use -1 as the target when there is no explicit guest-supplied target.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/hyperv.c  |  2 ++
 arch/x86/kvm/svm/svm.c |  2 ++
 arch/x86/kvm/trace.h   | 46 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c |  2 ++
 arch/x86/kvm/x86.c     |  6 ++++++
 arch/x86/kvm/xen.c     |  2 ++
 6 files changed, 60 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..7f3b4698083f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2593,6 +2593,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
+		trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_PV_YIELD,
+				      KVM_SCHED_INVALID_TARGET);
 		kvm_vcpu_on_spin(vcpu, true);
 		break;
 	case HVCALL_SIGNAL_EVENT:
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..a3390a051ab2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3199,6 +3199,8 @@ static int pause_interception(struct kvm_vcpu *vcpu)
 
 	grow_ple_window(vcpu);
 
+	trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_PLE,
+			      KVM_SCHED_INVALID_TARGET);
 	kvm_vcpu_on_spin(vcpu, in_kernel);
 	return kvm_skip_emulated_instruction(vcpu);
 }
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 0db25bba17f6..83b291de9665 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -11,6 +11,17 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
 
+#ifndef _KVM_SCHED_EVENT_TYPES
+#define _KVM_SCHED_EVENT_TYPES
+enum kvm_sched_event_type {
+	KVM_SCHED_EVT_PLE,
+	KVM_SCHED_EVT_HLT,
+	KVM_SCHED_EVT_PV_YIELD,
+};
+
+#define KVM_SCHED_INVALID_TARGET	(-1LL)
+#endif
+
 #ifdef CREATE_TRACE_POINTS
 #define tracing_kvm_rip_read(vcpu) ({					\
 	typeof(vcpu) __vcpu = vcpu;					\
@@ -1965,6 +1976,41 @@ TRACE_EVENT(kvm_rmp_fault,
 		  __entry->error_code, __entry->rmp_level, __entry->psmash_ret)
 );
 
+TRACE_DEFINE_ENUM(KVM_SCHED_EVT_PLE);
+TRACE_DEFINE_ENUM(KVM_SCHED_EVT_HLT);
+TRACE_DEFINE_ENUM(KVM_SCHED_EVT_PV_YIELD);
+
+/*
+ * Trace when a vCPU reaches selected wait/yield handling paths.  This is
+ * informational only and does not report the outcome of scheduling decisions.
+ * @target is the guest supplied value when one exists, and does not imply that
+ * the target exists, is runnable, or that a directed yield succeeded.
+ */
+TRACE_EVENT(kvm_sched_event,
+	TP_PROTO(unsigned int vcpu_id, int event, s64 target),
+	TP_ARGS(vcpu_id, event, target),
+
+	TP_STRUCT__entry(
+		__field(unsigned int,	vcpu_id)
+		__field(int,		event)
+		__field(s64,		target)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id = vcpu_id;
+		__entry->event = event;
+		__entry->target = target;
+	),
+
+	TP_printk("vcpu %u event %s target %lld",
+		  __entry->vcpu_id,
+		  __print_symbolic(__entry->event,
+				   { KVM_SCHED_EVT_PLE, "ple" },
+				   { KVM_SCHED_EVT_HLT, "hlt" },
+				   { KVM_SCHED_EVT_PV_YIELD, "pv_yield" }),
+		  __entry->target)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 49feecb286b2..d60026c64fc9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6104,6 +6104,8 @@ static int handle_pause(struct kvm_vcpu *vcpu)
 	 * never set PAUSE_EXITING and just set PLE if supported,
 	 * so the vcpu must be CPL=0 if it gets a PAUSE exit.
 	 */
+	trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_PLE,
+			      KVM_SCHED_INVALID_TARGET);
 	kvm_vcpu_on_spin(vcpu, true);
 	return kvm_skip_emulated_instruction(vcpu);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..09d1d8242017 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10482,6 +10482,7 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_SCHED_YIELD))
 			break;
 
+		trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_PV_YIELD, a0);
 		kvm_sched_yield(vcpu, a0);
 		ret = 0;
 		break;
@@ -11807,6 +11808,10 @@ static int __kvm_emulate_halt(struct kvm_vcpu *vcpu, int state, int reason)
 	 * handling wake events.
 	 */
 	++vcpu->stat.halt_exits;
+
+	if (reason == KVM_EXIT_HLT)
+		trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_HLT,
+				      KVM_SCHED_INVALID_TARGET);
 	if (lapic_in_kernel(vcpu)) {
 		if (kvm_vcpu_has_events(vcpu) || vcpu->arch.pv.pv_unhalted)
 			state = KVM_MP_STATE_RUNNABLE;
@@ -14553,6 +14558,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_msr_protocol_enter);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_msr_protocol_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_rmp_fault);
+EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_sched_event);
 
 static int __init kvm_x86_init(void)
 {
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..f7033f0e7e13 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1586,6 +1586,8 @@ static bool kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, bool longmode,
 			return true;
 		fallthrough;
 	case SCHEDOP_yield:
+		trace_kvm_sched_event(vcpu->vcpu_id, KVM_SCHED_EVT_PV_YIELD,
+				      KVM_SCHED_INVALID_TARGET);
 		kvm_vcpu_on_spin(vcpu, true);
 		*r = 0;
 		return true;

base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.25.1

