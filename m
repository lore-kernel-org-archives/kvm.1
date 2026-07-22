Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D9445AC4
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762062; cv=none; b=EljOH+f7QMDQBv3H53+WO1FOvLGIKLwWy1XOmBRbhIMSx1F0ykrCfZ/PGUVioc1jbCknRK/0RpzoSz19DzNgLYtzMmAdR1qlZyc+sfCfKHb378ITOy3QKv0gk+CSgoB4qzflxS1/FhTlUQGX7o3cYxzGy+LY8dG07zymt9uIgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762062; c=relaxed/simple;
	bh=Su8BLXrmP/U6RRB63g2rSdhJdPNX+A4jtFkTGIzKLgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoRvMKe/tBhN+nlKZ+DwZaxczdEfZue8bUqMfZo86NPQFRJlz4AGJ24SMaYwmwe2MFYWbcyTTBNwLAO7MnS+dSFFkEX+XDTZc5cgfitatfXM9VLlD8TZ1OP7vS2cpPw8HGsnteWhnJ16zR2JnAuL2lng+fQ7q+2IWBqqHQ6XNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soft7oJq; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soft7oJq"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso117652a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762060; x=1785366860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsEVnqgXZZ/AnSWixFUfO9+Yk/+wAM9+eYelUJZ+lPc=;
        b=soft7oJqsj728t1GMeL4v5ehUKE4CoOOwdhpCpKkhiqFP626Po7w16iY7Xi/ZRamDD
         w7M7HtqLrygytcgHJoFdJ9odMVE/u9m6wSiDsRwvusalrWWhehrYNoaGftKfr6jE24DO
         mw3Vcj7ihRxivnPUt8JnHOhWRKEhafek3EGj7QLFfsjl24iIf9y8k23Heo4Ox1JCGl8H
         jFD9izkYaWoT1qEZ5fD5aZ+bpuDqFbwdTTIZGeT3lYrjX5EZ2uHygdhzpd9Q2bz1Igpe
         wp/l+lvPbyjsoCsXLil6KA5J+A4gzXtPZrPTj4O1gPFyEStLP78OGzTnaYWDV1uOEBwt
         wYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762060; x=1785366860;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsEVnqgXZZ/AnSWixFUfO9+Yk/+wAM9+eYelUJZ+lPc=;
        b=dmYN8/fkxlMZB46DmQgUOUUgfjJ7FQTmeTjaunZqV9Im3nzjLl7NRGgp//+Tc0DLtG
         u1yJ4wi8G2LeBuOHlrGCg+X4Kb/aExjqgUc2SsFZh2rYc2TzjxCIiWEHK7wW2e+lasv9
         PNOVN/pTq9nJ+Yyj/QYlKeusWaJhWAFha6LP45allXKxgSg6KUGeWsyHpYpeU3RYaDRF
         gI1oGStREFkfRN8xZlOUSwmdt6FMcldaPbm5YEgTKk8lqWk/8Mq6cvAVxa6CLgJInOB0
         YA0+YcwUrUp6Yf8sXII7Zf3MBtIuaD8SfOsGCBAij6PR7pzFdNCOci6KVlCiB/P5nfgs
         TLbw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5YsdhuhDHPyoTCBKZzekUosoAUwDX7bE2JsilyBMFOQQomJ+LujicZczwYUf4ULl9t0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeyw+YGJd/xPTn2PQb4Cl2z6TX08e0bxnaryzNvux8ou3kqzy
	2wkd3q+DCqu7Gd74JfHMh8GXtP7ApJtU8dSu2+1lbzXR1uHK1jpm8v6Q6ElO4YWTz+edsx4fQP1
	CivO/aw==
X-Received: from pgbcw4.prod.google.com ([2002:a05:6a02:4284:b0:cbb:9724:677b])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7344:b0:3c0:b3f7:e5c9
 with SMTP id adf61e73a8af0-3c44b18ce4cmr557300637.36.1784762059075; Wed, 22
 Jul 2026 16:14:19 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:08 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=9069;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=Y2c8cQDQcYfZUmkmmHn+9/G0qzpE1QbcUacmPC0a2l4=; b=FateLGKQC6st/No2fH5ELk5cOWTV6qpPd1FaM3hoLgtkcAB9pEuBxbqMiFZ5ocnYjA8yUIFju
 wvV7NulFc/mBWhw0ESe+Fz96gC94ZwIz3aWBkSQf2iNrC883DviGsGQ
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
Subject: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
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
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../testing/selftests/kvm/include/x86/processor.h  |   2 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  35 ++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    |  21 +++-
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 120 +++++++++++++++++++++
 5 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e5769268936a..3f98d1c6488c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -27,6 +27,7 @@ LIBKVM_x86 += lib/x86/pmu.c
 LIBKVM_x86 += lib/x86/processor.c
 LIBKVM_x86 += lib/x86/sev.c
 LIBKVM_x86 += lib/x86/svm.c
+LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 0aa6eecfcbde..76180dfaffea 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -956,6 +956,8 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
 	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
 }
 
+const struct kvm_cpuid_entry2 *__get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
+						 u32 function, u32 index);
 const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 					       u32 function, u32 index);
 const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index f647e6ca6b34..eb8602dce0bc 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,4 +11,39 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * TDX ioctls
+ * Use underscores to avoid collisions with struct member names.
+ */
+#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
+({									\
+	u64 r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (u32)(_flags),					\
+		.data = (u64)(arg),					\
+	} };								\
+									\
+	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
+({									\
+	u64 ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
+									\
+	if (ret) {							\
+		TEST_ASSERT(!ret,					\
+			    "%s failed, rc: 0x%llx errno: %i (%s)",	\
+			    #cmd, (unsigned long long)ret,		\
+			    errno, strerror(errno));			\
+	}								\
+})
+
+void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
+
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b68ad1dc7e02..7d23344854cc 100644
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
@@ -1328,8 +1331,8 @@ void kvm_init_vm_address_properties(struct kvm_vm *vm)
 	}
 }
 
-const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
-					       u32 function, u32 index)
+const struct kvm_cpuid_entry2 *__get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
+						 u32 function, u32 index)
 {
 	int i;
 
@@ -1339,11 +1342,21 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 			return &cpuid->entries[i];
 	}
 
-	TEST_FAIL("CPUID function 0x%x index 0x%x not found ", function, index);
-
 	return NULL;
 }
 
+const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
+					       u32 function, u32 index)
+{
+	const struct kvm_cpuid_entry2 *entry;
+
+	entry = __get_cpuid_entry(cpuid, function, index);
+	if (!entry)
+		TEST_FAIL("CPUID function 0x%x index 0x%x not found ", function, index);
+
+	return entry;
+}
+
 #define X86_HYPERCALL(inputs...)					\
 ({									\
 	u64 r;							\
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
new file mode 100644
index 000000000000..e1ffb67a106c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "processor.h"
+#include "tdx/tdx_util.h"
+
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	static struct kvm_tdx_capabilities *tdx_cap;
+	int nr_cpuid_configs = 4;
+	int rc = -1;
+	int i;
+
+	if (tdx_cap)
+		return tdx_cap;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
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
+ * For each CPUID leaf, filter out unsupported bits based on the capabilities
+ * reported by the TDX module
+ */
+static void tdx_filter_cpuid(struct kvm_vm *vm,
+			     struct kvm_cpuid2 *cpuid_data)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+	const struct kvm_cpuid_entry2 *config;
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	i = 0;
+	while (i < cpuid_data->nent) {
+		e = cpuid_data->entries + i;
+		config = __get_cpuid_entry(&tdx_cap->cpuid, e->function, e->index);
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
2.55.0.229.g6434b31f56-goog

