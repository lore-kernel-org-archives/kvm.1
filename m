Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A663A963E
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787570; cv=none; b=G+MM31a/nqIIVPgiTRqglhoDIxGeruhDuZSTXmbEpAYKu0LbnNbYz20xrCmqLeecTdUZNyhMjJMwO9FnmzBGnZkrRUEmksEYZnqJhWSaDKRcg0oDZYtvBG9vAGz65o+C6M6GsiI39xxqLyshRxLjxmlGrlyDKDGN343hvI51S8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787570; c=relaxed/simple;
	bh=HVRt4L6InN7M6G41qKMEsuKYCAqAetC2DaO3Q/0Mgmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pzjcm+DrxUyLx8D78AYe+gOpTJfIqbhRaufyXD3hiv8ASq00mhNalOe3+f2WI7vm3FGwSfco70H55o9Hz8GYQa9bJuCPKjx81CYztkiNgmDUYVM+IGOkiSGHBTGywnDiABT7f21BFB0T9sp8Dr9cPsLtYvnS428hTah3W4IULxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLXaTjcf; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLXaTjcf"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso1476766a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787568; x=1788392368; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=noIWe1uiKOM5ci2qf7N1VbgwtzcnjgofaQ/OsIxf3uk=;
        b=cLXaTjcfgPDKIQZrJk43w8NAsuT8IWkwUGEg7eoxQKyLp0u04WBAjRoX3nOKxbFSL/
         mepXPtdrI/Dg10+APkrB/BepHlmo91Sy315pKk+6xPScnKW/MEIRzsh07g7UCauq/CMY
         pv3SlqIc/pa8IngLZ6gz3CBX8muPx61UcWX9pcIPPiwVNQ4OXfHt1RZpj5CDfBxsX/H2
         9PkOQnYDGf7fJ4uawF2K/jAE2Mo1nnXBskz3c8Z8seszfDXBii+CnU1iKu2f6MRJnRz+
         Vr9naoLVMa/nQaKfBCrQTzAvnDHXgTLAKON77ERBbOmTcH8QIGvpZlnAZayxESVnZtYP
         6QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787568; x=1788392368;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noIWe1uiKOM5ci2qf7N1VbgwtzcnjgofaQ/OsIxf3uk=;
        b=FxEzxTJYYGsBMCfPUV41GeChE7h9w/87Z/IxTE9zbV5pki7smtwI7DI8Q5iGAz9fea
         kdJuLUgNLqWDNv6l7RlbpijNNjnOuYzSoniRPCX8AokxV6liUoMmtmHx3i8o8mD3mOvx
         JmXVnE4raz4+cIyDkE4O7+5Fxx9QiK9ptqRx/HqogQ47pQdodq6CZA/Jq/1QTBxIoA+L
         R3hThbMqOcA9864nkfkRHRArWSHhhwBRKPGeFbxs5PusnCyO0TyzEsM/xWJ2HbTSnXiH
         Xb1TdLIZXvG3NBdQphus3D/93FO/QxbcSpZ92yw/a7mL11CR4bU3H7WItAT29KqC5dcg
         GnZw==
X-Gm-Message-State: AFuF++nxMGFZe1yJKHEMKxtStHCQ3qOC3rTXy1s7MfvzekL1qCYVXqA+
	yNzwaA4L+4kqMKlETmwRNEX1sUaL8Y4E82m67pa8wPydZoYEbagM+aw+S8QbcMLLVpAKF2QqLg1
	yRVxZvA==
X-Received: from pfvx23.prod.google.com ([2002:a05:6a00:2717:b0:84c:282c:5608])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438c:b0:851:c1d2:c48d
 with SMTP id d2e1a72fcca58-85372fa9890mr21458366b3a.8.1787787568162; Wed, 26
 Aug 2026 16:39:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:12 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-7-seanjc@google.com>
Subject: [PATCH v3 06/13] KVM: selftests: Assert success in vmptrst(), kill
 off vmptrstz()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assert success in vmptrst() instead of punting to the caller, as literally
every user expects VMPTRST to succeed (and because '0' is a valid physical
address).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 19 ++++---------------
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  4 ++--
 tools/testing/selftests/kvm/x86/state_test.c  |  8 ++++----
 .../kvm/x86/vmx_preemption_timer_test.c       |  2 +-
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index a161dbee7e04..04f638fcd3ba 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -366,27 +366,16 @@ static inline int __vmptrld(u64 vmcs_pa)
 	return vector ? vector : failed ? -EINVAL : 0;
 }
 
-static inline int vmptrst(u64 *value)
+static inline u64 vmptrst(void)
 {
-	u64 tmp;
+	u64 value = 0;
 	u8 ret;
 
 	__asm__ __volatile__("vmptrst %[value]; setna %[ret]"
-		: [value]"=m"(tmp), [ret]"=rm"(ret)
+		: [value]"=m"(value), [ret]"=rm"(ret)
 		: : "cc", "memory");
 
-	*value = tmp;
-	return ret;
-}
-
-/*
- * A wrapper around vmptrst that ignores errors and returns zero if the
- * vmptrst instruction fails.
- */
-static inline u64 vmptrstz(void)
-{
-	u64 value = 0;
-	vmptrst(&value);
+	__GUEST_ASSERT(!ret, "vmptrst failed");
 	return value;
 }
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index f953a9755a76..0c9cf620c87d 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -97,7 +97,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_evmcs(hv_pages));
 	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
-	GUEST_ASSERT(vmptrstz() == -1);
+	GUEST_ASSERT(vmptrst() == -1);
 
 	GUEST_SYNC(4);
 
@@ -123,7 +123,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
 	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == hv_pages->enlightened_vmcs_gpa);
 
 	/*
 	 * NMI forces L2->L1 exit, resuming L2 and hope that EVMCS is
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 4a1056a6cb8d..9d4e0c1f7c18 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -78,17 +78,17 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_vmcs(vmx_pages));
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	GUEST_SYNC(4);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, vmx_l2_guest_code);
 
 	GUEST_SYNC(5);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* Check that the launched state is preserved.  */
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index eb8021c33cd4..523aab667d85 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -73,7 +73,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
-	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmptrst() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
-- 
2.55.0.887.g758fc8c411-goog

