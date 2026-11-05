Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922480;
	b=CFOhes3lD+rgvmqbTmLGcqD2Pp6nL2b/G8q+D6zieY+H6PGy7kQjsI5fFEbnto++1it4
	 Qx+b2qlQoft39a1xj+1KOMp75aOr0P39BG+8ABOMmTTcwaNVAldlUsMt/p3p3De73PBUy
	 3mAgAFGQJkL/KCz42tUk4UXj3JxHnkKj6hkFipGKcXS0BeQktUGzKiAXlOt7kQnQrXt9u
	 E+urtzvRjGat23t0s/OqUZRi7T1nb4qLETZtbFn1rnUU57GbPgDNFwVsyixYO36o9dMI5
	 xcvvnEn9s7/xkM5ZSkFsRf3tqk3PWn+81AhGMDlJXCKzoiwA0VnlICX+LbO3BBGG/6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5XK1YSSiiA4WmmUnF56HGEq5CRIfmQKX3JC+zcltYJQ=;
	b=ztrZ0JqoTVJ3ozsNZPifArHXYPizjBpGRRPWM+64/K9iKLGWGqClvY08VK+qzOL+3SpR
	 oIa/RTODdSbX7Lml1LQ3xaft02BqfvozJHtw/wqQflf+xJAP+tFpfJgzZw163AQ8wJ9mh
	 WYWymNnHfirWFIENTtgv2mEeg+pxaqZ8BWJTBezBJQNIRDD0XqdusRpxrc2fw1LZ2hMLt
	 msxWr5243wBzTtfXcqATasVXjuo7g+ExCLC4psL2P03AtbCiBBY3uryb1hstk6h5GFwWI
	 j9t6JNQWgQyehikhd4Gc9DEMLW/alT7ZpPyb4jyT+hWzI8tZAYPB1BIaoD2HO27pW3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L2OJqkDY;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA760A2600
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBA760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L2OJqkDY
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb92868263so46063a12.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922479; x=1794527279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5XK1YSSiiA4WmmUnF56HGEq5CRIfmQKX3JC+zcltYJQ=;
        b=L2OJqkDY00Ei84tyj090agN7jq7OSbM2DIwzAe5QTPlsMt/jLeV9IYJMHZ1IxiDvKk
         v3irotusiCUCj1lu2S8gH0qvU3ESbrUmcuFLQI0D4oE/xTgt3NR4zw2PIKVhPCveWfnG
         avsvJxJ6xLIHiwc8sBVcNJk2v/ZPpiClfjHeIOb15xwqc40ZS7SotUQCSP6Ncbugp9dA
         Hkp8PjI5fXVyDYOw5jRyPmMLcEu7jIemRWFw7d6QWQQ6SeqV0Z+hylSUIu4vx+ZFf/Yp
         mvN8JzHfsNEqZQLNP6fvOW3vD0SEi3yA7jcAJpdaBaqzeKlDKrWacJ6isaCm+SVRzjTz
         oBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922479; x=1794527279;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5XK1YSSiiA4WmmUnF56HGEq5CRIfmQKX3JC+zcltYJQ=;
        b=CO7SKeBeAGA8119SW9BVld5vfl8Uaj31wY7A8stJLJAzXERmESY6Zi+m8+6Mf8Lg8G
         6sgiJwFJwKhHVJ8yArNh4Rld3I7F1pWQ0g2txzdLijpg41OqeN9hUXDZ6YaBzzT7rx7L
         BYsSn0Lyg3ddJW1Idd5HnkWpFnXxNdvPiCOa5PrTAhEpVPk7oEC2Jv8Ew9f/Nnzn7BAQ
         rZPM+uD6xrbJUPa6QS14/5R27BdTYq9idSH7IYlfIA8g5fcs6xdMMl4cD62i8SrxBpO/
         cD3j84/YBgSLb2EZ9xs5m6IyCEo3fj52AGZg4o01ahwlcfm054wOW3xgUJwj6WNTJgoq
         h9mA==
X-Forwarded-Encrypted: i=1; AKwUvBwEfjs6ARf2Yc/D+zTaGZxu8Q7EENyNE3MisN9+KTD77EhKw3EjUGcHRSQYD8gDO/lMj1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XcD0z+r1hN72xT4vPZsPvTXyNXlhX+7v7pMwlZnsunJhjsW5G
	RyFBxgho4Mrr3uAljXkMYQEPVruV4it1xe3LEdBKHwUvUJ1tcNLQKQndjnfFRC+7jaxc9crw9Bi
	EyujB+Q==
X-Received: from pjpu13.prod.google.com ([2002:a17:90a:a20d:b0:3a8:7374:19e9])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c0d:b0:3ab:b39f:41da
 with SMTP id 98e67ed59e1d1-3b0db6e04e3mr565340a91.11.1793922479064; Thu, 05
 Nov 2026 15:47:59 -0800 (PST)
Date: Thu, 05 Nov 2026 23:47:02 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=2640;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=pWnEq5zFqLJWNHptUXsnYM2oqxjXaqm1yYG5yOoXRkw=; b=6HoXdebY+5MC2Bax7uAk7M565VRvG1CnBtQiks6B3HlFCi1vONcu/O4Qbx1bADHdnysslN1gQ
 WEPkKqgTL0vAb1EWC/If5Q+oalKtxK68LszInLxgOUz/lmZ1tWcD41l
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
Subject: [PATCH v16 18/20] KVM: selftests: Add support for per-VM ucall ops on x86
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

Add a layer of indirection to x86's ucall infrastructure to allow wiring up
a different set of {do,get}_ucall() operations for TDX VMs.  TDX can't use
port I/O (at least, not robustly), as the TDX ABI doesn't allow the guest
to share arbitrary register state with the host on a PIO exit, and the PIO
data payload is limited to 4 bytes, i.e. would potentially truncate the
address of the per-ucall structure.

No functional change intended, as the ops are still hardwired to the common
x86 ucall functions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/ucall.h |  6 +-----
 tools/testing/selftests/kvm/lib/x86/ucall.c     | 27 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

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
index 38050c60a067..3aec4dd46d1b 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -8,13 +8,13 @@
 
 #define UCALL_PIO_PORT ((u16)0x1000)
 
-void ucall_arch_do_ucall(gva_t uc)
+static void ucall_x86_do_ucall(gva_t uc)
 {
 	asm volatile("in %[port], %%al"
 		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+static void *ucall_x86_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
@@ -26,3 +26,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	}
 	return NULL;
 }
+
+static struct {
+	void (*do_ucall)(gva_t uc);
+	void *(*get_ucall)(struct kvm_vcpu *vcpu);
+} ucall_x86_ops = {
+	.do_ucall = ucall_x86_do_ucall,
+	.get_ucall = ucall_x86_get_ucall,
+};
+
+void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+	sync_global_to_guest(vm, ucall_x86_ops);
+}
+
+void ucall_arch_do_ucall(gva_t uc)
+{
+	ucall_x86_ops.do_ucall(uc);
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	return ucall_x86_ops.get_ucall(vcpu);
+}

-- 
2.56.0.455.g6c5a503b38-goog

