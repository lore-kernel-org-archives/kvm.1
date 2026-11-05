Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922456;
	b=w6D6tJf6lRgGLN9hyj0hMdmLE0Ae0et5ORhxgggzINlIgqMd8SpuC8DFXYUsl7MovOCJ
	 LLyI5khTLvi5C96TQ1YRKjLXR0Y1OsV0zanHeFEfB+0ij4ITk+U7+HpSfn0m9PN7/vbPn
	 Dt4qoNr/KnYWEXsSQ2ZY2JZGU57agJ0DkLo11uP+7jtKM11nsFNtTwJ8/ccTEKLOsWS2e
	 x04bJaB6ht0660Qz5Y2AwmG0nD2TjhuSA38wLfZQ3AKdcM+/Sv/I4ng1Scu45tG1Zqn6z
	 mlBUSXm1oxF4GVOfEFK/mNDx2j9EzYNBoKeSNkqi5RSlG3wPhvB84kerivzfgIJA4dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HSVxAxPHxLWJb+QPPocaz3W4kDp/YO8WZ+4Cex73wUQ=;
	b=qbtGhL4nCAZwIp3dgwB7uVVq23oM93UFawzd7uL7Y9ZUO4yzsy5yPJ5LCc/c78fP7e5L
	 yxMTN6skecQyl8FkmL60zU2eBo63nTK4EcWr8P0MSa+V2ngzbreOD2hhkXP3MdhjxqMiA
	 IFqMVKRXqg/xyiuZH1Crq2lxlZBq6+t/cmB3y/QT+SLdH51TBYnts5VFeX/Sk8AIismah
	 slKPzAdqe1bE9N7iXNm0yKFPlQxtQUOh8TaRCama3i1oj31YZUWhu/yALMfr0J5eBC00Q
	 ZXBXRqopYasZlHyuRqRseqy8l+GUHu1gyIIULNIsHvrQTBp+iX4JKmBAw3GF/X/3UHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="d+5tXgr/";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC03606A33A
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC03606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d+5tXgr/
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so41163a12.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922455; x=1794527255; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSVxAxPHxLWJb+QPPocaz3W4kDp/YO8WZ+4Cex73wUQ=;
        b=d+5tXgr/pwbnJE/4WlePeztTsJz7ADyEAjtrGCSdBBBNcbk1cX8jnol/CPK32N9rGL
         mHKkV+c4+FwDgokVCUeUitMj9A8Q1qR0+eEYu0jzMGuwuKOkSVj/HOn43j+KZVKByyDM
         ezI2J2qRtJxS16fg+TdYrf1Eph8Ba9qtuHsYq9qpW66lsWokesoowkhnc1b4Y8MY128X
         7sqhQKSAQYYQagKNje3ucoul+NnMlfOKINgjl60ScGJ30Z2iXHxZ5ruf/Jh9Vob01ffK
         NpIc7lOR0y1VFJXSJnwCGUjzqV9TGjMY38ywnZhg2OIB3H3YLqnBHzv/GP6gNDoVgQv7
         G5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922455; x=1794527255;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSVxAxPHxLWJb+QPPocaz3W4kDp/YO8WZ+4Cex73wUQ=;
        b=Lz3Y71Qe2rvMRk8WpMGj7AD0KKdYU8rQnYiqHUWH3GgnPygy6NKjDQacqfZDBfy5xj
         RXlOOKE0xwkBNGaeQitVbZ9IB/P286pEsgViX1nayHzm8AjXSKWVyrZiGCh96t3vb5rq
         8lOOQQEMW5sxElCn6RAQ4SkV0APtPf7TAXFyZIwPMhemhDmpKwpqKbLcJMrLwzpIRTCG
         QFU7V7tOoXcoihmM92Ehow+WlJStQS6ukwKT8Ipcn2dfwaz7N68/vLyXBAVJGJrBHH+Q
         mv5STTEnDYqMpbnnApZPL/aeAw1tqpelEKPr22BMkPBoVMtZIN5Pg1dO3TyWcC4lxoeD
         oEmA==
X-Forwarded-Encrypted: i=1; AKwUvBxR8g+JZG0TPmsg16XfjGGHr5IOvDLyKSSliOoEPRj/KHMc1P8jHguO9qL9pATF8AKqOy4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P3GtzvgGl9kv8oTf2DqwPmd9xW7tL9Ipi6KbVWf3uUg/POze4
	yLt4X/8G2uofjkFlpDxbW6XMHs0dE4TWcCa7fxEFQLU4u2o2oSXWvTNy/MfczPCjlHR7vgdDR3D
	O9pcLaQ==
X-Received: from pgdu12.prod.google.com ([2002:a05:6a02:2f4c:b0:cdb:58e2:7cb7])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8f:b0:3a0:b312:1fbe
 with SMTP id 98e67ed59e1d1-3b0db6c99a4mr578689a91.23.1793922454815; Thu, 05
 Nov 2026 15:47:34 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:46 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=2831;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=TsmjAstaSjFYixQhUYbJbOkD7vAXJprj3EzMr2Dw2cA=; b=v+qqqNmrw6MMK/e1gCj/lL1NXgXSnN2daUTFtgMasIYlyr9pv1EkxsDPEdCOygMDueOA2GoPI
 lOq7jE2xRQNDXan3XM0CV7U61a7ubrgmr7yreT7TB9VfkU0sqfxfFEr
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-2-2024e8fa517a@google.com>
Subject: [PATCH v16 02/20] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Initialize the TDX S-bit and the GPA tag mask in
kvm_init_vm_address_properties() for TDX VMs, similar to how the C-bit
is initialized for SEV VMs.

The TDX S-bit is used to distinguish between shared and private guest
physical addresses. Its position is determined by the guest physical
address width, which is either 48 or 52 bits for current TDX
implementations.

Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h | 14 ++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c        | 12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
new file mode 100644
index 000000000000..f647e6ca6b34
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_UTIL_H
+#define SELFTESTS_TDX_TDX_UTIL_H
+
+#include <stdbool.h>
+
+#include "kvm_util.h"
+
+static inline bool is_tdx_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_TDX_VM;
+}
+
+#endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8374afd08baf..d705e9269a41 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -11,6 +11,7 @@
 #include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 #include "vmx.h"
 
 #ifndef NUM_INTERRUPTS
@@ -1337,12 +1338,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	u32 gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
+
+	vm->arch.sev_fd = -1;
+
 	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
-	} else {
-		vm->arch.sev_fd = -1;
+	} else if (is_tdx_vm(vm)) {
+		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
+			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
+		vm->arch.s_bit = BIT_ULL(gpa_bits - 1);
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	}
 }
 

-- 
2.56.0.455.g6c5a503b38-goog

