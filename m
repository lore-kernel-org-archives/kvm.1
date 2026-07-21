Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F61D9A5F
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636544; cv=none; b=E7HuQrT+IIcGoIlNtQmpsd62Pu3uieqC0KdJHXLc855rtaVWNIHXWxxDau7EasAXw7hVzl34BSTilafkIi0mCG9y1j3/VzPLPGnOaCeOFM/pQcsnQXIe41mx7tvf+DWL+krPMAMMKEdjD3MUERVQGDBe1B88ZqQMbKUIhr6oiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636544; c=relaxed/simple;
	bh=wTgtI8pdHg/VkmRa8Cd17JEgTEWUSVfUNRVVjHOLd9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBD44jSO44TBtJAlfOZt7IRgFq9nXCTgE59khu7j/KNHTHSvym9Aq889wX/OW0seRDdjPQ34YuCTgr3QveA4XmKac8Ppsw5UsJheiHj56Rphv+BUVH0Pr17yfj53qPtAmq/RI0H2UIDXoxTPmSf4QPMEmeuVAjeJPywd1FZbbc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrPRKuBm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrPRKuBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784636542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFizEQ3L1+n33MzQ7bLKxGbP2hKJHIJsYPDD7v+wt20=;
	b=BrPRKuBm8z8J158oG9xgv72PtCer71uTSzPataHTw4FS177tH0yp/3TsU5e9DVvHLfh76h
	cAh9EExxLIuo1xoFNfJ8YAlkRcQhfkb46HUc/2gcpwI53JcOqHr/YKT6MYYTIwLO6E/dUV
	HK7xYQTxr6veTZGA7sG0WHwdHQXtMQo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-mtfQBnRANmi2gOPigNnYJw-1; Tue,
 21 Jul 2026 08:22:18 -0400
X-MC-Unique: mtfQBnRANmi2gOPigNnYJw-1
X-Mimecast-MFC-AGG-ID: mtfQBnRANmi2gOPigNnYJw_1784636537
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2C219772DA;
	Tue, 21 Jul 2026 12:22:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E62A3004191;
	Tue, 21 Jul 2026 12:22:16 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com
Subject: [RFC PATCH v2] KVM: x86: RFC v2 for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)
Date: Tue, 21 Jul 2026 14:22:15 +0200
Message-ID: <20260721122215.1963145-1-aharivel@redhat.com>
In-Reply-To: <20260715124235.1444895-1-aharivel@redhat.com>
References: <20260715124235.1444895-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

v2: Correct internal flow to use kvm_vcpu_halt() + cpuidle constraint
instead of inline MWAIT. Expand enforcement mechanism design question
with three concrete options (A/B/C) and cpuidle call chain analysis.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 rfc/KVM_CAP_CSTATE_POLICY.txt | 57 +++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/rfc/KVM_CAP_CSTATE_POLICY.txt b/rfc/KVM_CAP_CSTATE_POLICY.txt
index f376adf77af1..dec369e328e2 100644
--- a/rfc/KVM_CAP_CSTATE_POLICY.txt
+++ b/rfc/KVM_CAP_CSTATE_POLICY.txt
@@ -1,6 +1,16 @@
 KVM: x86: Proposal for per-VM C-state policy enforcement
 ========================================================
 
+Changes since v1:
+  - Corrected internal flow (section 3): enforcement goes through
+    kvm_vcpu_halt() + cpuidle constraint, NOT inline MWAIT execution.
+    v1 was ambiguous on this point.
+  - Added rationale for why inline MWAIT in the exit handler is wrong:
+    monitor state cleared on VM exit (SDM 27.5.5), scheduler/RCU
+    invariant violations.
+  - Expanded design question (a) with concrete enforcement options
+    (A/B/C) and cpuidle call chain analysis.
+
 1. Problem statement
 --------------------
 
@@ -136,23 +146,52 @@ where power savings matter most (C3/C6), the overhead is under 3%.
 5. Design questions for discussion
 -----------------------------------
 
-(a) VMCS control toggling: switching "MWAIT exiting" at runtime when
+(a) Enforcement mechanism — cpuidle constraint
+
+    The enforcement point is kvm_vcpu_halt() → kvm_vcpu_block() →
+    schedule() → cpuidle. The problem: cpuidle has no per-task
+    C-state constraint. states_usage[].disable is per-CPU, and
+    forced_idle_latency_limit_ns is also per-CPU.
+
+    Three options I see:
+
+      Option A: Temporarily toggle states_usage[i].disable on the
+      pinned pCPU before/after kvm_vcpu_block(). Set
+      CPUIDLE_STATE_DISABLED_BY_DRIVER for states > max_cstate,
+      restore after wakeup. Simple, works with existing API, but
+      only correct with dedicated pinning — overcommit with mixed
+      policies would race on the disable flags.
+
+      Option B: Use forced_idle_latency_limit_ns on the pCPU.
+      Same per-CPU limitation, and latency-based rather than
+      state-index-based — less precise.
+
+      Option C: Propose a new cpuidle API for per-task idle
+      constraints (e.g. a per-task_struct annotation checked by
+      the governor during select()). Correct for all cases, but
+      bigger scope and needs cpuidle maintainer buy-in.
+
+    My use case is NFV with dedicated pinned cores, so option A
+    would work for v1 scoped to that case. But I'd rather not
+    invest in prototyping the wrong approach.
+
+    Is this use case too niche for upstream KVM? The target is
+    cloud operators running VNFs on dedicated cores who need a
+    host-side kill switch for deep C-states without guest
+    cooperation. If it is worth pursuing — would you accept
+    option A scoped to dedicated pinning for v1, or would you
+    want option C from the start?
+
+(b) VMCS control toggling: switching "MWAIT exiting" at runtime when
     the policy changes between -1 and >= 0. This requires a VMCS
     update on each vCPU. Safe to do via kvm_vcpu_kick() + request
     flag, or is there a better pattern?
 
-(b) MWAIT hint to C-state mapping: MWAIT sub-states (EAX[7:4] for
+(c) MWAIT hint to C-state mapping: MWAIT sub-states (EAX[7:4] for
     C-state, EAX[3:0] for sub-state) vary across CPU families. Should
     KVM maintain a per-model translation table, or should the policy
     operate on raw MWAIT hints directly?
 
-(c) cpuidle constraint mechanism: the proposed flow caps C-states
-    within kvm_vcpu_halt() via the host cpuidle framework. The
-    cleanest approach seems to be temporarily disabling states via
-    dev->states_usage[].disable before blocking. Is there a better
-    interface, or should we propose a new cpuidle API for transient
-    per-CPU state constraints?
-
 (d) Interaction with halt_poll_ns: when policy is active (max_cstate
     >= 0), interception is on, so halt polling applies again. The two
     knobs become orthogonal:
-- 
2.53.0

