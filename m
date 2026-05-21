Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527E36166A
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405445; cv=none; b=ZJ0JX+7hOllnUzrSTF/fZqAhSNTpHeRDe2oTG6TCFrTfM16UeK6vvqpvgaIdqpvPSNIx1uicc2MBpsezfZdgioGT7sFn2dChwcc2PHIZpoRhn+mJ5aqbXD5Nh1QiFJJyXkh8pYsFWLoPoiV2C7ngspoLytkovkhhT5DfCQ6cSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405445; c=relaxed/simple;
	bh=Nb9n5Zfl6XHD24e+MfA5DCrPRrVV/vR/vu521DzOCmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Op4L+8zHuezjfCK0wRLgyV8NNRcbNKQ7DP86jlZyU8wD2J4z7ibrdoRtprtP/eRqBHA6bSwbksizGmJXQYG2eWhYhOczuSQaad9PKS74GNYdqLhcsdb10xaPQOwoeRMLsGqe++QvntB2zxneEIv6pxo1p0gsHNsvwLV6/eSfaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdL8vRhN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdL8vRhN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc7f9b2213so49529365ad.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405443; x=1780010243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MlBPDYt2s87xgiEqgjzOOC/H+bt5La44h6DA7T2Yuc=;
        b=WdL8vRhN7iY5NS/H+TMSzaVQFNt/cF8DXJmQwKjK/GsxuP71bWqO2EIG16MJDp20tZ
         pflnFdaNBmWxypnYsrxMq25d8US9oX4hee9UoNUCd4XgRvXU+w3ZngfcT+x4+r7bhERf
         Li1Pj82FJU1OT9d8H5WWZ3/z2pbaAHkzxFjFDDMKQmdnscuUff2H5ItXFcjAlLUCxPm5
         RsebfeF4VJ/4wBJcHJhFHVVXz8V0rPWzWz3bbBbixfx5YgRqHeNcvsuPwUz3AidupsrN
         /hu8ST7Sc0GPnUihDaekXdbrA6lN122n9eKRfQnxFSX3UXMDSAAtAS7ZtP7pmS/3flFQ
         ZVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405443; x=1780010243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MlBPDYt2s87xgiEqgjzOOC/H+bt5La44h6DA7T2Yuc=;
        b=QVj+hVtj5vTH/JqJZqEu1gp0xloQk/b8/TeFbs/uV50V2TKEYhMa4CEmc+cL3WCh13
         Hlu/luOjnhfnDFCTWZAb68qEYmN1U7B9RJU2FVgrfHkxJjTjCikDH1ucamP7D/TlabwA
         FbrGUX9p2/ZO7vugB04Rpr0/Edab6QWIPPXv1Hn51QwCbOHcSNxqPcAVhiQBhicap8hv
         VxuldUGj+6RJpyWu3+TTiW/c1QBKHEPRkUe4k9XB58TYmGgB8xL1cLOgsV+sFXYwGF08
         D33JyljNfh/+fWFuXZS9QFfp/zeOcNTX5WfKquMvKRANHKhf9p4z9tbuNd0Ot7TcujsP
         MwYA==
X-Forwarded-Encrypted: i=1; AFNElJ++gK+LFQxLPta3HYgbRTj/ewMVeK1dLCwoaOfstUo3YN77aHDWWr5MFfbCRMPT2LlNGww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ePXnC+gPEOKbw7jVuuxzmF/Ppgcx97+qJVj4E1djB6u+KZa3
	FH5Pbkur+OC1SsurcGtEctSuih3UzfpuGPa+CgtOA+8IBQ2aY8bq8Dj2RTeoHjLxMNig3zg2x0b
	gVBjIOw==
X-Received: from plgx12.prod.google.com ([2002:a17:902:ec8c:b0:2bc:ac01:8af8])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48e:b0:2ba:5a20:1d94
 with SMTP id d9443c01a7336-2beb059944cmr9240185ad.13.1779405442560; Thu, 21
 May 2026 16:17:22 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:43 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=2783;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=75VEM4ux6bv2BMSA2rJTYBrB4tAAd8DHy97X2RY5WhE=; b=Pap4XfeqimmecoZJ/4z2V/ABOtYv7ILkzOaI2B/IHITplo1nVtl5507jg+jiIXu1rWzbs2Ygr
 d8P+nbFvBUhAdjCUGyN61J1VbP+964pHBMaHUdfkmOED3aRWwIFZA37
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-2-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 02/22] KVM: selftests: Update kvm_init_vm_address_properties()
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
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
2.54.0.746.g67dd491aae-goog

