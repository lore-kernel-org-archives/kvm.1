Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922481;
	b=tpYFZXdgwUdAeDYpKGBuy1CCX6rhzMvvWLkdtj6BM9FBH3bhzTgnsmY0l9kr+7YqbZ3o
	 yQzJbA0Rv3brz/0KocYLrzYAKgmp34Se2yMT54uUFmmvxR9PW/PGyxkKeFYAixpEJVkOr
	 LG3nCEXRhiwQzEPA3FgykTArAczL+GN2M5BR5QYidSUrknOukK/Pa86pdxl9BrjIaqyVx
	 XWI0HExyNxeiy1e+LjkT921R8C0FrXMeIMmOEqDwQxMg27NDeO9x41E9v/wTvfqNwSB7c
	 EUjxI5BiWPXeUdZnihiYUD8I5tMpThiv8MEeKOVO+fstEUkGlhl/vrULsRt0oeOqVSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=a4has+3ZOallPubnO5PCgDkTmmWpt2dIq6/LlaB8Yy8=;
	b=BVMWGgjqqcWnRkD1EKFE8NIxWmrCT7IH6eG4oousnRjgtG5ctm6lvLwv3PsDH/0bqW/T
	 Ollji10z+oGA4tOQGZ4KF+pD3favy+IDruy+5k14U038yrsC5WtTqI1wWoTDFkYZB5VNl
	 zju5AB27jOucT20FuKjYr7tSZzXV5Qlp2kyzJQOxtSJYRVF1mj2OLlQsfZqZYDr6Kh8Xi
	 WA4Q0S5I9QgNcIcFexp3go66eVmtdl2T6EDlQpvjQvQzz9m+7INh4AG6A8eNgb6EJQxSk
	 cNpZizMTAUkIoZlH1Auia6EH+rzdrd4lfbqH60nuvKWUrIjCn8+45GuN04sdgJtGSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hzIQpwe1;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6D60A263C
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC6D60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hzIQpwe1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed05b3eaecso492105ad.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922480; x=1794527280; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4has+3ZOallPubnO5PCgDkTmmWpt2dIq6/LlaB8Yy8=;
        b=hzIQpwe1z4a3HZMu1AIKDugfXswvx2bIlWHKL28n78+s88M7wjwxzlMiHT6VwCc0AX
         CJySbB6avBx8SgAQHZpU+p+ut/cj2hXJJmsxeVv8lZYIEDTY6S/eJWXCIDvEFRfzxP8D
         zuIl3S3i7HSt7ZXP1HpBXguFkbENY+SF+oYpxAea0K8+WM5inuKGu3JS8WBBTgwrIXLQ
         hA7YH1c/eizrZW0RNI45uSkx44s3Gf7Yv7X04WYY0gbBA0+I4Fmaa0+gq8Yr6ffWElqD
         A0ZObMRCMiaxObtR8ZmC9otuZ0rbvpr/NJqbY+qcaZO6LEp7YJXd7pMIurhWrS0MsGD0
         uDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922480; x=1794527280;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4has+3ZOallPubnO5PCgDkTmmWpt2dIq6/LlaB8Yy8=;
        b=emv0tmmck2jrw3pwnQkVgZJ6ewm6gAZtSBd49EBnbVLiSZhE3ihYHrdtagsqWRXjnC
         VtpFyX3iS/9ytbiQi15q3NyLosB8mSck40O2o0VF7N9+0KDeXp2xnaVZHtZfYY/MtgmL
         qNEeprf8Hx3QNpTsergnsbLhBPNmyugbT/bTg0yFWW+2q4dF2daNXOClcmDi6GQ7EZs+
         hzV1VlJSzwPR/o8Mto5uWpEIvqbMSkL3FKgKbHzwsUV5YTo4Ntm54a6kqcB4ivdA2tnG
         y4vyOpPPE2+rlaPKAO69tTxetRkkA2hZ0lEe6yRu6WB64hSlmccNo1Q1p5KywqMnzSyq
         2tsg==
X-Forwarded-Encrypted: i=1; AKwUvBwHaxuuhfkX4uF9cO6Gwbx6vrepL4mSzKT+M4vmK1jknE99I5VhxJZhN3CBGAFpA+X9Ni0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RdKz/2OWr+nasC4dgaZG84p780Iwoamd5wdxt0l+5x9rP3WFs
	Q1exgcR7j2PwrhLnA70XiYxjgfbwSxcPVtCL1uoLRT9ZnQkPGiestIoVipuhVQkqrbgK6o/Fk6+
	UH+6n0w==
X-Received: from plcu11.prod.google.com ([2002:a17:903:308b:b0:2e3:bd2:38ec])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d05:b0:2e9:9522:ed3a
 with SMTP id d9443c01a7336-2ed4198726fmr11039015ad.22.1793922479962; Thu, 05
 Nov 2026 15:47:59 -0800 (PST)
Date: Thu, 05 Nov 2026 23:47:03 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=3781;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ye0dh2bn0KuuGDqjMywSIYVHmjvFFWLyKdkM/LtZa10=; b=vgff3Sgn5XANvkH0beXOhFTw4ETPjNQv8H6v3gSbnsRrc4f3vCOyzTiujFNd/P7ja9qHSfLIX
 gRypAWyRJDSChnyrxV5WGD7fjHqXI9tiPxKrooyiMg4b2CXatxrlq1x
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-19-2024e8fa517a@google.com>
Subject: [PATCH v16 19/20] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

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

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h |  7 +++++
 tools/testing/selftests/kvm/lib/x86/ucall.c       | 31 ++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

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
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 3aec4dd46d1b..2a1c61785e5f 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,8 +5,32 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
-#define UCALL_PIO_PORT ((u16)0x1000)
+#define UCALL_PIO_PORT		((u16)0x1000)
+#define UCALL_TDX_MAGIC		0xabacadabaULL
+
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
 
 static void ucall_x86_do_ucall(gva_t uc)
 {
@@ -37,6 +61,11 @@ static struct {
 
 void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
+	if (is_tdx_vm(vm)) {
+		ucall_x86_ops.do_ucall = ucall_tdx_do_ucall;
+		ucall_x86_ops.get_ucall = ucall_tdx_get_ucall;
+	}
+
 	sync_global_to_guest(vm, ucall_x86_ops);
 }
 

-- 
2.56.0.455.g6c5a503b38-goog

