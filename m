Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650050AC33
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883526; cv=none; b=MNNT5XfZl5OfQfqxBQ+VTy9Runi3eTr0Cc+eFaTzUp08UE926qtZGHlQb+WMmKhswbPSGnM+6mz2FlzH/BnQzzcj3+d2HDlKtzMX0dASJg5CWWqnMf9TId+jNJB//Mcfosaxo6f9QIIhcDR8g81VRjTX9njq2Vk4T7U4SHgkItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883526; c=relaxed/simple;
	bh=qxkfdoOz77H+HUvwagh4OJO5TYMmdDlmCgK4NuPofnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hkpb8aaiPWWk/YLD/Be//xQP24vWEeC9EacvrK/9dbQ7ia5f6jt0iHZ9hLv6zJOte8zam7uyIySDGcFTswVukHByJfd8b04TQ4hnC1vSJEEvuXHveDSESF56r+f1eS4ccv8j5Q2PQsuxMqblT/NHEW/Uq27AiILD0GYLce+j0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzijRiKl; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzijRiKl"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so56317455ad.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883524; x=1791488324; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRA8eHvPSJgAQEOmbd1O/CbESc/R97pEVe2Nxiy3I3w=;
        b=uzijRiKlGDSo8PnNCIBlSWtzT+TFP47oLRjjIxThlTKPvI8Q7yUv2uFsaK5qXfQn2R
         lY/ykuLUUjBqmtY/zngUJdtmA8urhamhG3mGTZnOMnFBdJSj1Vt0fTKqUTLfUL5QAXLG
         xKUo0JK8xX/ZfN5WZlH/qpMMSLdrboL/ypthtOt08WPhzDh50t9ksWCXmmQQ0/HNjjeP
         bbUOOOBwK2c1dJjvRaIPauPnRSyMQM9Aj1VuVqkGnSikkMDVGljWluJbRCkH//iyHt2X
         NOsePEjkgiAS/T7sJmoXvYH0zvUTtMuNDAjZyEECfRH5I1BodV6T9VXxIDZI/GN7KiaD
         fgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883524; x=1791488324;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRA8eHvPSJgAQEOmbd1O/CbESc/R97pEVe2Nxiy3I3w=;
        b=p4l5AZ/ABVzoj3gjy9CXECpx7hma6vi4saAOtvI0OFif/rchK+1eob0NuJnO4UOVEI
         A40WBcWloWHdnDGyeqQGJiZonN5UFVbH2KcPxxlXcO+fbrcyj/7cqI/MoSXxHL5NSiiB
         2n+e2Xf+eUzY6fVYyosNp2ya8v6H276MPIDr8HMmPMs/zmbD6gD++z1BStjZ9iawcTTb
         MqgY+vk5kIYBe3r/FQkxKMExUxLDBNYtifkNL1W+OYYky+Dor764lsBBGjj847xsyhT0
         FuiLIVjmpGVOVU0ZM5BYL2GGkeXbxS889G6Pkv8imTMSfseFbOZz7J9nR18jNViHNphY
         em3w==
X-Forwarded-Encrypted: i=1; AKwUvBz4vMejUDjfO3JaIWEGLzjTym0v+Bd2YgJ6xpjFPmf1LxIdGBpep2lwunbcdQQG+ne0lU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJvORgtW1Fdb0hNo3pYGaysJi3Eee05lza9Tyx4LhMcIkkMNZ6
	/2PxAY+M5q3rU7UBVrFXNWv7XdGVASQ5em9XSEcg+kBAjCyOJk/Rib8T/iXtwEieM66ZsixXrIX
	QVdpLtQ==
X-Received: from plsd22.prod.google.com ([2002:a17:902:b716:b0:2db:1fc8:4e2e])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec92:b0:2e2:bf79:3cbc
 with SMTP id d9443c01a7336-2e49b4e2a2fmr4637155ad.14.1790883523793; Thu, 01
 Oct 2026 12:38:43 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:29 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=2835;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=DW/6EpNF2WplxQYir4TA0kFPBYD+uNW2zXhuAmi1ip8=; b=e2t+cuZSTEesNo/L46pvlAEvH3ClwUA+3LqLDSyVjnRm14E6gXv5tHEpx+r3cITV7QLqizX7A
 dKFgmtG3kS3BeN/8XSec5K/CTPUKZz7SsAJdKf4o+RT66zwQ/ChYNkp
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-2-7c62a5d8a992@google.com>
Subject: [PATCH v15 02/23] KVM: selftests: Update kvm_init_vm_address_properties()
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
index d31fa81ea075..24395a8e654a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -11,6 +11,7 @@
 #include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 #include "vmx.h"
 
 #ifndef NUM_INTERRUPTS
@@ -1330,12 +1331,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
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
2.56.0.rc1.315.gc6ed9934b7-goog

