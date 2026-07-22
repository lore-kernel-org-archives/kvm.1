Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C8459ACB
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762060; cv=none; b=VU1urK11Y9oEGYfjGiH6D7NaE/quVKq7HqTXVCCi/W4R9OZvweS/LossPFr2uvtitWvm9AGZmhx/PNBfO5JtbqXhU7EmdaV6/IkWq7l6cYoijRUIqLg/CmC3+G/XsWT58/QPknSGZClFwWmme3mgzavrZB90erDF2NGXKpNB3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762060; c=relaxed/simple;
	bh=HSUijWFM1BPOVfLPb88yrHGkaYxU/9q3xS5FLa0HHK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fc+cVH2XzaITZT1PBvcy0JENDN7sO0qxoNoxX9YqqkH6QT2PIyeQ0DkDHeuO8kRHxPEfj57vTq1t0Jb4AhuRJaCDjbEZSKeuWIHKTeqIWMvMkYPaBnerGafRz+Lp2YwCrxp+7BAfo+O2TrVGZxhpV0v1iJ2XY+Z2CJnZiWt+V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vp8dI9tL; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vp8dI9tL"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so30864a91.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762058; x=1785366858; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56NrxXkv0UVjMvjOx9by9wvi/d3mOyqzIaOMJLt53IU=;
        b=vp8dI9tL3yCcspxfIsku19170PagevuikLeeGNzNAwKlmO3mKFo4qR36AR4/DV0OR2
         FUpOv4uPQsqDvKQdzsbcNpkFWvKV8m8DfLF006I//gXT8F/EotZEMFTYlXPulgzucjk/
         XMjy2ln/e+VdhZvDk0/qRzXMbKpStJihAZ34+SaqaRIjwEQAovsvPcz/d1BK/fDSQyYt
         bFeE7Q+S3ayp5FjMDVXIMcqaZuFkxlvFfslPmuS57ib6Tf7koFizDYT/sI1WonbdaGGW
         7V1Rv8yUYIF9sYbWQk9qra8pux+D0xDZ0NsPDedMEFVFD+UWmTwZzpvT4BXhG3NgZ9ft
         xsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762058; x=1785366858;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56NrxXkv0UVjMvjOx9by9wvi/d3mOyqzIaOMJLt53IU=;
        b=TqNz7kGa7hsqorC3gV9UoTE9LOecGkM6Efm6IEAqurmZn505whdGP/m5wtB3lK93Kr
         g+0QNMvRlsnN5NKGtcgKpTjeRJbODLzFQ4oAzdoSwbWx+aEj3Lo6PRLaTKKX3U6bTOd0
         eOjwJnUXi22+S1TGn5GNmsN1TEPpzcfZAJtl/lOIQnU/a7qV7wc28IlHin1FcK3gObKN
         o4LmeCnwtORHPMVGzVUpJRnmws/aOd3EVN/8xrdO9Zhwpz+vkZJDMzuDa7BH8LRwRFoh
         76VCHca2fdp3L/zq1r3zQC6YXOG6yW6gd3jVBwxC7tKVY/jgL3nfT9gFKlUJAfp4cimC
         MsFA==
X-Forwarded-Encrypted: i=1; AHgh+RrpyT+s90jK5wiVStGePWY60QJGjJ55z82zO2Qfwe9ZRGpHjA1Op1NG6OLxZs8vvi9tghY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6U5G2g9jI3tY1fR8RXMPCnTQPk71J063sGfK9eDBtNk1tXly
	+82FThYxEmNDkYf548tEXqkVNNpxf6rizncwO61DGffJ64fF4ZCA38eQAvjXFbvpouiaO+ROIJr
	wopnXjA==
X-Received: from pgjf8.prod.google.com ([2002:a63:dc48:0:b0:c85:db34:d7a])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a120:b0:3c3:7d12:a98c
 with SMTP id adf61e73a8af0-3c44b1e9a44mr575991637.52.1784762058127; Wed, 22
 Jul 2026 16:14:18 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:07 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=2831;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=nMhWICLdSh2frl7tfIaV4/PZJX0MLcCDKg8/gFmmfRA=; b=DaBxIbGI4Q0JBXmDhiTdq0R4HtbImm2MoSdd8eyphcWciY2zj/Me0FR8j6E77p6MHWfkCdI9m
 uxtlRF4MdCVArlmm+NgiqHHnt0Vm2NLFNdYXiXh739s5M6YknSSRwMS
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-2-15ad654a50db@google.com>
Subject: [PATCH v14 02/22] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Initialize the TDX S-bit and the GPA tag mask in
kvm_init_vm_address_properties() for TDX VMs, similar to how the C-bit
is initialized for SEV VMs.

The TDX S-bit is used to distinguish between shared and private guest
physical addresses. Its position is determined by the guest physical
address width, which is either 48 or 52 bits for current TDX
implementations.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
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
index b51467d70f6e..b68ad1dc7e02 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -11,6 +11,7 @@
 #include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 #include "vmx.h"
 
 #ifndef NUM_INTERRUPTS
@@ -1311,12 +1312,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
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
2.55.0.229.g6434b31f56-goog

