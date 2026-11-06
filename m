Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983659;
	b=4MIt1q6GEEyNYgmtjaz6fzitE5j4EzO5ZLDy3yEKe4+Nfj2MGSZVyBoda90vyrDHF0iQ
	 IwNWNJv5e5mRrdsLywLV3wfMZYCzgtcv1r0jEBnIT9LBvmo4JvChLqOTaJZPK3xh+q361
	 EyizxY8OIIq+zQxuaYvo1E7sK9hZUeifIgLOypyH8P8eoUUF0oSeMx9xIE2GYoXJ/5TlX
	 2fMEH5Pnu+gL93IdyK70RXu8W+6vXM+D3Is4X+g3xbMBZ+nOwFhtxIGIGSfFrmfmJgoSR
	 vXztMbv5xp2u3I5sdkPDBCYuE4Ina58Tf2wCAdMCIChkWEMo3Tjm9i7+iVYBKPx3uCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zti4JuFLZG8tZuk4JJOYaWVhoy6VLoz9Y+1Og8ZFPPU=;
	b=Peb+DeniLoeJy5LLTxKkLhM8YseYC9YUTo4xnZ9vJTAeEzEMH+6fDTrppox9bHuffabR
	 Pg59WJcX1tBJkZVkCD/N2c7rtmXbkK3Ki7nFrhI/AR+SevOA/QLhRIHLoQhL5R+V68xr6
	 /6Qet5/n0nVNrZjac4iz2ScsfQD/U2EflJqpwuOhjLMP+Xr8V/x+rH7eXJBuGHW5GSTbb
	 LuTS10VUNXdHFLofG3ePifY173hl+rOoYrj7xgBIMnQSdgA1VgtLn59AmL4Ai93g8IAy4
	 0iKVkN6D0KROsO5LjR74aqk90ilAvEs+NmIOykgFPMi4ni5UWvMT+rAQEU9Dbctv5qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EU+y8ts+;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD510606A33A
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD510606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EU+y8ts+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so626404b3a.2
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793983658; x=1794588458; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zti4JuFLZG8tZuk4JJOYaWVhoy6VLoz9Y+1Og8ZFPPU=;
        b=EU+y8ts+c5IPNHBp7a/U5oL5cJJGNP6x78Zjw2VAaB5X5VijDh7NNxVGqF3c9JiMGT
         M597ZT0+idqiWEcsSUPqWfWX5VEdcXMB+1S6rQ3POGjfAccdgZZsOERarQs/5bIEHZtD
         /7SFGiNmgYdtCP1FpdiQQDXPOyr6gG9JFJaOKYo1nx4bQMeXKC2njLa+i0g1e5XL+HK1
         zsqzw391h1iYcAuYhjjsupo0Qekkr95p50iteAee9eK9pbuxPZqj11DON/5gdgSiuRMc
         j+8dK3jlA3j+i2ic9P712FZNTmECJ4Tux0JLHAITgnGNRy4qH7MUtM0qd66pGzTJoyhZ
         Bk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983658; x=1794588458;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zti4JuFLZG8tZuk4JJOYaWVhoy6VLoz9Y+1Og8ZFPPU=;
        b=B82W8RCMxDiRmb8QcQPz+GGohdNk/LL5z3o/g2ZWGGD0uRDM+4xaaIZ2YD4eso0hMY
         ZNERuxD0PrqruCY0+IKcz8hbBB5HABbMmARxjw4N4sq8PAd4iI7UHb+HvnVKcriiPMz1
         iHGHEW/nnXACmYY5E3fSefD2KEpiNjT+hKYN0fBHzHXd4FbHykXM4BLGueTZnxoS6pmi
         E4nmVB2m0qKWbigz5bse8CZilpHvADq7nPnXCQROi+zOdcOkwKoCg9LlkpjwPuNMjSee
         SF1HIOIYueKEGxyriDceHmOKn/AvrD4zJ57skO/I5FQQsLTSV9PVNUPfgQwPdJvppbNQ
         VP8A==
X-Gm-Message-State: APuU4Z+X75taU+w+vmp5HHml7jhy7RFQ7qYhRnoy8bugSuqYMnqq3wby
	aMoh23xrpQIndk6Tn5QB/MsCNvG8IReWcfF3kHke0A/PaT8PmMOau7VIWWH0rEF13lXXubuA4aJ
	uKpG0wA==
X-Received: from pfbfw6.prod.google.com ([2002:a05:6a00:61c6:b0:8a0:6a08:e927])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140b:b0:8a0:3336:4b45
 with SMTP id d2e1a72fcca58-8b37aa9f637mr3084436b3a.12.1793983657844; Fri, 06
 Nov 2026 08:47:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  6 Nov 2026 08:47:32 -0800
In-Reply-To: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261106164732.3939387-1-seanjc@google.com>
Subject: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sagi Shahar <sagis@google.com>, Lisa Wang <wyihan@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for doing ucalls on TDX by abusing TDVMCALL_REPORT_FATAL_ERROR
to pass the address of the payload to the host.  The "fatal error" TDVMCALL
is perfectly suited for passing information to host userspace, as both the
TDX Module and KVM allow the guest to pass (almost) all registers to the
host, i.e. provide enough of a data payload to make a collision with a real
fatal error practically impossible.

TDX can't use port I/O, as the TDX ABI doesn't allow the guest to share
arbitrary register state with the host on a port I/O exit, and the port I/O
data payload is limited to 4 bytes, i.e. would potentially truncate the
ucall address.

Alternatively, TDX could use MMIO, but using a magic emulated MMIO address
is fragile (see the TODO in __vm_create()), especially for TDX since TDX
doesn't support read-only memslots, i.e. doesn't have line of sight towards
addressing the TODO.  E.g. TDX could hardcode the address to something that
is all but guaranteed to be unused on x86, e.g. the I/O APIC base address
or the HPET address, but that doesn't truly address the fragility concerns,
and it's ugly because ucall_arch_init() would completely ignore the passed
in @mmio_gpa despite obviously utilizing emulated MMIO.

Use a simple flag to route vCPUs/VMs to the right do_ucall() routine, and
take care to set the flag via write_guest_global() so that ucall_arch_init()
is thread safe (in the *extremely* unlikely scenario a single test creates
both TDX and non-TDX VMs *concurrently).

Alternatively, a virtual function pointer could be used to dispatch to the
correct do_ucall() via an indirect branch, but that has zero advantages
other than making ucall_arch_do_ucall() look prettier, at the cost of being
slightly harder to understand and making ucall_arch_init() uglier.  KISS.

Cc: Sagi Shahar <sagis@google.com>
Cc: Lisa Wang <wyihan@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  7 +++
 .../testing/selftests/kvm/include/x86/ucall.h |  6 +--
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 53 +++++++++++++++++--
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index d41a1efc8a63..9982aaaba885 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -4,6 +4,13 @@
 
 #include <linux/types.h>
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_GET_TD_VM_CALL_INFO		0x10000
+#define TDVMCALL_MAP_GPA			0x10001
+#define TDVMCALL_GET_QUOTE			0x10002
+#define TDVMCALL_REPORT_FATAL_ERROR		0x10003
+#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT	0x10004
+
 u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
 
 #endif /* SELFTEST_KVM_TDX_TDX_H */
diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index 0e4950041e3e..aca582bb2cd5 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -2,12 +2,8 @@
 #ifndef SELFTEST_KVM_UCALL_H
 #define SELFTEST_KVM_UCALL_H
 
-#include "kvm_util.h"
+#include <linux/kvm.h>
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
-{
-}
-
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 38050c60a067..bb4a7215d9b1 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,16 +5,40 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
-#define UCALL_PIO_PORT ((u16)0x1000)
+#define UCALL_PIO_PORT		((u16)0x1000)
+#define UCALL_TDX_MAGIC		0xabacadabaULL
 
-void ucall_arch_do_ucall(gva_t uc)
+static void ucall_tdx_do_ucall(gva_t uc)
+{
+	__tdvmcall(TDVMCALL_REPORT_FATAL_ERROR, UCALL_TDX_MAGIC, uc, 0, 0);
+}
+
+static void *ucall_tdx_get_ucall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	/*
+	 * KVM_SYSTEM_EVENT_TDX_FATAL stores R0..R15 in data[0..15].  R12
+	 * holds the ucall magic and R13 holds the ucall GVA.
+	 */
+	if (run->exit_reason == KVM_EXIT_SYSTEM_EVENT &&
+	    run->system_event.type == KVM_SYSTEM_EVENT_TDX_FATAL &&
+	    run->system_event.data[12] == UCALL_TDX_MAGIC)
+		return (void *)(run->system_event.data[13]);
+
+	return NULL;
+}
+
+static void ucall_x86_do_ucall(gva_t uc)
 {
 	asm volatile("in %[port], %%al"
 		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+static void *ucall_x86_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
@@ -26,3 +50,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	}
 	return NULL;
 }
+
+static bool ucall_is_tdx_vm;
+
+void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+	write_guest_global(vm, ucall_is_tdx_vm, is_tdx_vm(vm));
+}
+
+void ucall_arch_do_ucall(gva_t uc)
+{
+	if (ucall_is_tdx_vm)
+		return ucall_tdx_do_ucall(uc);
+
+	return ucall_x86_do_ucall(uc);
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	if (is_tdx_vm(vcpu->vm))
+		return ucall_tdx_get_ucall(vcpu);
+
+	return ucall_x86_get_ucall(vcpu);
+}

base-commit: 4aeb1c3931544fb3bb64397391c2e7153a81f824
-- 
2.56.0.567.gdb80ae8cd5-goog

