Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922462;
	b=F89J+5wetCv62AGZLXk+Vl0Gp71+e/dQHSHPhdP5ZGXG/UGMB62qKOmgfK94JuGu5vQy
	 YCiQ7oFh8MyUxPnZAoQeS8pz/L1m9xf6CXoNs6ZMrd8R8okc4XAYhcYMDkzOFLX1XppiE
	 DsMU6oUVB6fF4taFQnYn3UbLvX12VG49+tQqZEg3KR31w50Rdx7B78NOxx7m3f9tUUXON
	 90F5rtO8fFua5hh4j45gnI2lOsBhSV5IrYwN5lhn8j72Qz3CzF39PLrlHLxSo+LEskBfK
	 x06BzSg395o9jl7NnNNNgGSaUQhWfOoK0mJx8auE1uJm4sCwtQureggNqGQpPcmhw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tDICajUls+MVU3nlT8BKXeQcBxsJx76UetcWcsPTkIY=;
	b=lOWJPLiWFBaEUWeU9fvffXb8EMyUGNx8Wn0vWgVHROG2XKmSVwAokMLIQC8leWSDic4b
	 N7h/E2CAvlRxOyx5AJXKFejx0CWhryjRuBWU8/kbrswsBQMphlXuQj80gcJ1fi9EJhJZ7
	 UQ4JImYGIFJzkGpdzi089epZvGS3t9/2GpVEaUJN9LhlgPS5ZPrbEzcd3sZW45fJl3q1+
	 YG/rX9h7HZRU4oG+cZQtXvayqu0HL4vcnuW8AhN5hR27hKj6caIHSQR+tLKZFaQkZIlgD
	 W7q0XeNGAeGtbk5QTtCru6v07FiIt7K2JalvuBRP2XRmy7CK5FHNp8hMp7dX6RUoJvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pmYE2HT1;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DC7606EE9C
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63DC7606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pmYE2HT1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae62796dso729085ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922457; x=1794527257; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDICajUls+MVU3nlT8BKXeQcBxsJx76UetcWcsPTkIY=;
        b=pmYE2HT1PcVqgvrHLgIWEZZ4qCR42Qv5bXVeM0Ng6q3xKckEHuH3f9g9uGfYCn99KT
         SHygWaI543l/yPFyrn/F0fmmf+vYazoCH7f/RyabX1NfE1QWfBh+tr5Vbl5PMVcBCwiv
         QTShbBl5edW/s9FoKS8LQ0+T8pPOC9aQGq1UTcC8X/vX+Vvp/pbwPH0aFYumdy0LK7Mm
         oHUAO0svgUzV3FogLfObgK91My4FlJ4kqk+eleB5xhz1FVypxOV6IK9AOHrN6FoqomWo
         FkjE432E8IR4YXhPER8IJ6hrX5jZYVlvucNTKMVcdszmG8c3wU926rCTXRyR38LULWGR
         J+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922457; x=1794527257;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDICajUls+MVU3nlT8BKXeQcBxsJx76UetcWcsPTkIY=;
        b=ZQPMnElag+/uvc19rx1+wCf7QVP/atnCy/n8QesRycteYmKfXW6QO6bP0Cghn9lala
         0GWYp7tehoSKwXRCUE7P+XEkod8MEtFSh5vsfhW2C69Wl1Vb7gy50MH+FR9NveB/X25G
         E6Z5GUoqdZMh0Nhdemr3PSfz0Ud8vm65A3SzZnS+UnYaNgkkCtUSQ0VASTv5Iu2cidiC
         5pznjtju/X4X4sGgseJ0Jhv2SOme3WsHRBYiW8XyRd4MP0zW1I8ag/kT78UngSoiWIih
         CJE88fMhQTj2zLMJgGB+rtu/89die0VGnB57e0WWJDtzUFW093ywieL29CgYxNnqnkrG
         E+vQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1qoOqGUCtjTa5ZpEzR+MiSqVICmselemlN4bhej3crP4NDpaQtp2K2mmwcBEfizhX98s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pqEDCeiauyxELhCZuE7fWM9xOOF/ZMPO1/mzybs4RNc3C33zS
	lC/WXCm6t7NipKq1mNrcHk8xi/98Ria2AME129zlK9GAi7U2un6N4OoNkbH+0SX15QqkCvsDePK
	RWuJ0TQ==
X-Received: from plby6.prod.google.com ([2002:a17:902:ed46:b0:2e9:6f2c:71c3])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d586:b0:2ed:1df2:8b3c
 with SMTP id d9443c01a7336-2ed40bfdea1mr11999425ad.35.1793922456623; Thu, 05
 Nov 2026 15:47:36 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:48 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=1874;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=IUPFZFhS7USNqKMmulO0C0asUQ2Oci8U479LkW/s9KA=; b=AR5YKEO3dhz9+FQd/gbj96lSfiYyiK9uIPX1gpsBLe2AZJFI3pI8PL/ZgFBfiz3mTltPh4Eqr
 JHjwka7cH0lCTq6KIBdUR42ALzeVAoz1L0b2N2Rzd7iP7yvVyB1wpHE
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-4-2024e8fa517a@google.com>
Subject: [PATCH v16 04/20] KVM: selftests: Expose segment definitions to
 assembly files
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
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Extract kernel segment definitions into a separate header for assembly
files.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor_asm.h | 12 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c         |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
new file mode 100644
index 000000000000..713b6bc0aeb7
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Used for storing defines used by both c and assembly code.
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
+#define SELFTEST_KVM_PROCESSOR_ASM_H
+
+#define KERNEL_CS	0x8
+#define KERNEL_DS	0x10
+#define KERNEL_TSS	0x18
+
+#endif  /* SELFTEST_KVM_PROCESSOR_ASM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 7bbc0df49a18..fe56df0c7aa4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "pmu.h"
 #include "processor.h"
+#include "processor_asm.h"
 #include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
@@ -18,10 +19,6 @@
 #define NUM_INTERRUPTS 256
 #endif
 
-#define KERNEL_CS	0x8
-#define KERNEL_DS	0x10
-#define KERNEL_TSS	0x18
-
 gva_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;

-- 
2.56.0.455.g6c5a503b38-goog

