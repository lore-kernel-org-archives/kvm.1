Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EB36CE1C
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405447; cv=none; b=CdRMPrOxcfqqCH+pS4gbwPJnsAzzs8Zt1I3LQsoXqAetzq/EB8jlV1/uJdoPKxZ+6MBj0/OlsNBNc9ZwtUwQpMlCKNRccrQK3qAKtgqWRZoZx0qxqnK8N0Ws4CgAth5l9GS1KnUoDRC+vJRJf6WCS9nj5KGc8GaWZ+4dBJuKoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405447; c=relaxed/simple;
	bh=RIR1dGxcq4VEIfYiThYtlk/4kmxE7++RxDLWv+eCXrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ayh3B0o2+DBbc96DWbAjxb7Rt48W7z7ETybNZCOfVQpsNUagxQxBRtX0m4uDpjpztYJ5OGFJ4ib9fcB7MAt4mgf01pPLSk0ORadydZleKXloDNmk1jLk92OJCiso6XCpsxsS9YyAzYxcJKIL2qfeBnGU12Q+Cf6s9LIdxGMPy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URw65pb5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URw65pb5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba838d3fa4so63370985ad.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405444; x=1780010244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M90a7tnp7iacqS5P6uyhPKxrpu73J+iw0HSxj+ExSLc=;
        b=URw65pb5zU36PQ3q51XzlhIhKNFlvJIS5u98mCbH1HqFafXA8DZqnwlz5hua4cQZ8F
         D4xeSIToYnSlwrWnh+6BN5/1rJrHhuBAarizh0Te7QLIYt2EGWEId4Jini/O8zFhTxyP
         in8NfCYB2feHu7urt/SCM7v2TyEebMJkoQDnbxewhOCpS2sRjaR4O3vCV0v7Ix5B9DIw
         dfZBUf1Vlf8kwM8bf7q6Dko5x55QfzvHHUm/OgX3HfooRwoMZyymm3z5R6ktRh3eqZnp
         XxWhLnME9y4KGp804zf0P0yN1lIy+1dDglOXNaEkHfs41i6aQhANIbFsYM5RXFsldUJM
         Xyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405444; x=1780010244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M90a7tnp7iacqS5P6uyhPKxrpu73J+iw0HSxj+ExSLc=;
        b=q7OirtuqIg9u1REeCTLKM2QfENTo4wY8sIQnj1BrLMQoH/rcJU2OjZ2dCDYIkPGCWS
         skizhLVTVHzBlxmCFpu5AHLdH5VNrCVhzjVyq/lGI9pdFYDGciKHBRuhlajpVYfybaTH
         8D/XWjcUXEgFMrrgxwbhetVJ6JwlvBqYTzrfCo/qi1rDNmztzGKVB+RWhxFzI0kVnNCh
         O+aZGQ56JdNWcRxBzP/9WqZ8AO1D1Qj60BTSg1MvT5X1ThPMDhFN4Ie17e/Qo8gKlT0Q
         Do+trOZFWDGu1A29zEc2TsA80mL0I5T3FYjUmtc9YrloKjchm8iirIeynrMGMPB9ESSQ
         cSJw==
X-Forwarded-Encrypted: i=1; AFNElJ9fDFraoPVgHPIPKom5KgJeH31rKRKkbep0EDJ/0UlT7VaFAfqxpVC+ZHFfK1KZubwf54c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ygvhrzqCCQrhDOZ94nnLXVtEpp7jtrgZJeKnhDEw1wucqcfh
	DsMzWZVl/erxdPdOzJj6kt2t0Xu6wmbJli8f4ZBVn7UT1rHP9DMAwysraYbuTK6UTHNJvpXjRNy
	jw7/5MA==
X-Received: from pgn32.prod.google.com ([2002:a63:d60:0:b0:c85:123d:1ae0])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:398a:b0:3a2:c683:fa84
 with SMTP id adf61e73a8af0-3b328e5a459mr965243637.27.1779405443980; Thu, 21
 May 2026 16:17:23 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:44 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=6985;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=sZhbUwLmGA97CQa4ynmsZKv+RX+miGLowBebjw8z+ng=; b=GF1hqvSOdAuOldHXqofvpgbLnK2xrZnfLatmmXbbgAGecn10YoiPBVvpT7sQ0iaeb9KQVdbzO
 McP/21Cny9gBcWxCiSDvT0h1wwYF9yYVOQ5gqQ8IZ4GZnwPr4l9kKee
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 03/22] KVM: selftests: Initialize the TDX VM
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Add tdx_init_vm() to handle the mandatory VM-level initialization
sequence required for Intel TDX.

For TDX, the guest's CPUID configuration must be "sealed" during
KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
the TDX hardware directly virtualizes CPUID and includes the
configuration in the guest's initial security measurement.

The helper calculates the required CPUID values by filtering the host-
supported bits (kvm_get_supported_cpuid) against the "directly
configurable" bits reported by KVM_TDX_CAPABILITIES, ensuring
compliance with the strict requirements of the TDH.MNG.INIT SEAMCALL.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  30 +++++
 tools/testing/selftests/kvm/lib/x86/processor.c    |   3 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 137 +++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index f647e6ca6b34..48d4bd36c35b 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,4 +11,34 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * TDX ioctls
+ * Use underscores to avoid collisions with struct member names.
+ */
+#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (u32)(_flags),				\
+		.data = (u64)(arg),				\
+	} };								\
+									\
+	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
+({									\
+	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
+})
+
+void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
+
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b68ad1dc7e02..8d06e7186df1 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -802,6 +802,9 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
+	if (is_tdx_vm(vm))
+		tdx_init_vm(vm, 0);
+
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
new file mode 100644
index 000000000000..868ff62e22f2
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/tdx_util.h"
+
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+	int nr_cpuid_configs = 4;
+	int rc = -1;
+	int i;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
+					   sizeof(tdx_cap->cpuid) +
+					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
+		TEST_ASSERT(tdx_cap,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->cpuid.nent = nr_cpuid_configs;
+		rc = __tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
+		 "tdx_cap: supported_xfam 0x%016llx\n",
+		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
+
+	for (i = 0; i < tdx_cap->cpuid.nent; i++) {
+		const struct kvm_cpuid_entry2 *config = &tdx_cap->cpuid.entries[i];
+
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->function, config->index,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
+static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
+						      u32 leaf, u32 sub_leaf)
+{
+	struct kvm_cpuid_entry2 *config;
+	u32 i;
+
+	for (i = 0; i < cap->cpuid.nent; i++) {
+		config = &cap->cpuid.entries[i];
+
+		if (config->function == leaf && config->index == sub_leaf)
+			return config;
+	}
+
+	return NULL;
+}
+
+/*
+ * Filter CPUID based on TDX supported capabilities
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   cpuid_data - CPUID fields to filter
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * For each CPUID leaf, filter out non-supported bits based on the capabilities reported
+ * by the TDX module
+ */
+static void tdx_filter_cpuid(struct kvm_vm *vm,
+			     struct kvm_cpuid2 *cpuid_data)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+	struct kvm_cpuid_entry2 *config;
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	i = 0;
+	while (i < cpuid_data->nent) {
+		e = cpuid_data->entries + i;
+		config = tdx_find_cpuid_config(tdx_cap, e->function, e->index);
+
+		if (!config) {
+			int left = cpuid_data->nent - i - 1;
+
+			if (left > 0)
+				memmove(cpuid_data->entries + i,
+					cpuid_data->entries + i + 1,
+					sizeof(*cpuid_data->entries) * left);
+			cpuid_data->nent--;
+			continue;
+		}
+
+		e->eax &= config->eax;
+		e->ebx &= config->ebx;
+		e->ecx &= config->ecx;
+		e->edx &= config->edx;
+
+		i++;
+	}
+
+	free(tdx_cap);
+}
+
+void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
+{
+	struct kvm_tdx_init_vm *init_vm;
+	const struct kvm_cpuid2 *tmp;
+	struct kvm_cpuid2 *cpuid;
+
+	tmp = kvm_get_supported_cpuid();
+
+	cpuid = allocate_kvm_cpuid2(tmp->nent);
+	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
+	tdx_filter_cpuid(vm, cpuid);
+
+	init_vm = calloc(1, sizeof(*init_vm) +
+			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
+	TEST_ASSERT(init_vm, "init_vm allocation failed");
+
+	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
+	free(cpuid);
+
+	init_vm->attributes = attributes;
+
+	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
+
+	free(init_vm);
+}

-- 
2.54.0.746.g67dd491aae-goog

