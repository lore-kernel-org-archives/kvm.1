Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D130566F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542273; cv=none; b=dOpJpgdvsj/9hdZcsopni26PK7aMUW3ib3mcGf8xsfee3HcSvbdB376zjOjBjlBEUy9NGLFHKwAQQXDvkwyv40FLg4ozX3daCTgOvGgEdC5r/U3O5ujXZcQLJN7GyhacgUBrlt+fLD8QSRB9QO1P4zMaJmShGbvS2qI5XR+AzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542273; c=relaxed/simple;
	bh=7IrbNTGaHeKOVrxzFjq7meMvrGXDzTJWWuaUASD7OJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWqb/t+cgPPKIHnOtqDxmuEeZG8NU1oYpIbcnCWJPIPRm0SzSuYx7r/LVxKhDu1fm1oerjsiJmXCDz7hELrHAs+z2C0s580lYSOTGLt9QuLZSBa6v9OuDltu7TmqGu9mRiD2OPRMEd7lMToWvnGn5E5ltOJJc7t22R350i/NsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=av06XMAT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="av06XMAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542272; x=1812078272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7IrbNTGaHeKOVrxzFjq7meMvrGXDzTJWWuaUASD7OJ8=;
  b=av06XMATCep2XJe1naYDrua8Go1IHWRUHomAc7uu1ZKBpVucgnkmZ9q2
   R3VEp3r1anJLV4BYOHhwqrQ8bOHHcT9DlGT2C3BdVdFogEQEEZ4nZjQR/
   AIhqEkRJ/P/fzj53K0vcGF5kdYgu/ULaVXXocKRNAOZ6lB8k1TF0ielgi
   CF0bbatD9RmdckGPmJG0t6WEZWgiJUH8UDv+uzLlHcZUPde6Q8zYag1hK
   zwjMmPU2ds6tlE+MSxO7W2jM6WW5zh2nNqEs1/3PYzlCao+jLtyisMDDq
   o7NcUmDCHh9cIIB2hB7niTviWnlJjtfrrIF/+T7oDnNYDQaZFlYT4fiI1
   Q==;
X-CSE-ConnectionGUID: yE5DPwpyT1eH8ykl8ZlIhg==
X-CSE-MsgGUID: bgsgd7OcSzqEXQnjMrr+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399647"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80399647"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:29 -0700
X-CSE-ConnectionGUID: R55l5KQNT7ujpkmLghg67g==
X-CSE-MsgGUID: 17oPsdMmRqCpBHtIAuf1yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241915849"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:04:28 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 5/6] target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls
Date: Wed,  3 Jun 2026 19:55:45 -0700
Message-ID: <20260604025546.19378-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604025546.19378-1-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer Intel server CPUs support a large number of PMU MSRs.  Currently,
QEMU allocates cpu->kvm_msr_buf as a single-page buffer, which is not
sufficient to hold all possible MSRs.

Increase MSR_BUF_SIZE to 8192 bytes, providing space for up to 511 MSRs.
This is sufficient even for the theoretical worst case, such as
architectural LBR with a depth of 64.

KVM_[GET/SET]_MSRS is limited to 255 MSRs per call.  Raising this limit
to 511 would require changes in KVM and would introduce backward
compatibility issues.  Instead, split requests into multiple
KVM_[GET/SET]_MSRS calls when the number of MSRs exceeds the API limit.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Add assert on kvm_init_msrs() to catch the error of KVM_SET_MSRS
  has negative return.
v3:
- Address Dapeng's comments.
---
 target/i386/kvm/kvm.c | 110 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a99c1dba83f2..9b6407794e43 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,9 +97,12 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-/* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
- * 255 kvm_msr_entry structs */
-#define MSR_BUF_SIZE 4096
+/* An 8192-byte buffer can hold the 8-byte kvm_msrs header, plus
+ * 511 kvm_msr_entry structs */
+#define MSR_BUF_SIZE      8192
+
+/* Maximum number of MSRs in one single KVM_[GET/SET]_MSRS call. */
+#define KVM_MAX_IO_MSRS   255
 
 typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
 typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
@@ -4099,21 +4102,99 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
     }
 }
 
-static int kvm_buf_set_msrs(X86CPU *cpu)
+static int __kvm_buf_set_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
 {
-    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
+    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, msrs);
     if (ret < 0) {
         return ret;
     }
 
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
+    if (ret < msrs->nmsrs) {
+        struct kvm_msr_entry *e = &msrs->entries[ret];
         error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
                      (uint32_t)e->index, (uint64_t)e->data);
     }
 
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
-    return 0;
+    assert(ret == msrs->nmsrs);
+    return ret;
+}
+
+static int __kvm_buf_get_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
+{
+    int ret;
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, msrs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (ret < msrs->nmsrs) {
+        struct kvm_msr_entry *e = &msrs->entries[ret];
+        error_report("error: failed to get MSR 0x%" PRIx32,
+                     (uint32_t)e->index);
+    }
+
+    assert(ret == msrs->nmsrs);
+    return ret;
+}
+
+static int kvm_buf_set_or_get_msrs(X86CPU *cpu, bool is_write)
+{
+    struct kvm_msr_entry *entries = cpu->kvm_msr_buf->entries;
+    struct kvm_msrs *buf = NULL;
+    int current, remaining, ret = 0;
+    size_t buf_size;
+
+    buf_size = KVM_MAX_IO_MSRS * sizeof(struct kvm_msr_entry) +
+               sizeof(struct kvm_msrs);
+    buf = g_malloc(buf_size);
+
+    remaining = cpu->kvm_msr_buf->nmsrs;
+    current = 0;
+    while (remaining) {
+        size_t size;
+
+        memset(buf, 0, buf_size);
+
+        if (remaining > KVM_MAX_IO_MSRS) {
+            buf->nmsrs = KVM_MAX_IO_MSRS;
+        } else {
+            buf->nmsrs = remaining;
+        }
+
+        size = buf->nmsrs * sizeof(entries[0]);
+        memcpy(buf->entries, &entries[current], size);
+
+        if (is_write) {
+            ret = __kvm_buf_set_msrs(cpu, buf);
+        } else {
+            ret = __kvm_buf_get_msrs(cpu, buf);
+        }
+
+        if (ret < 0) {
+            goto out;
+        }
+
+        if (!is_write)
+            memcpy(&entries[current], buf->entries, size);
+
+        current += buf->nmsrs;
+        remaining -= buf->nmsrs;
+    }
+
+out:
+    g_free(buf);
+    return ret < 0 ? ret : cpu->kvm_msr_buf->nmsrs;
+}
+
+static inline int kvm_buf_set_msrs(X86CPU *cpu)
+{
+    return kvm_buf_set_or_get_msrs(cpu, true);
+}
+
+static inline int kvm_buf_get_msrs(X86CPU *cpu)
+{
+    return kvm_buf_set_or_get_msrs(cpu, false);
 }
 
 static void kvm_init_msrs(X86CPU *cpu)
@@ -4149,7 +4230,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-    assert(kvm_buf_set_msrs(cpu) == 0);
+    assert(kvm_buf_set_msrs(cpu) == cpu->kvm_msr_buf->nmsrs);
 }
 
 static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
@@ -5042,18 +5123,11 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
+    ret = kvm_buf_get_msrs(cpu);
     if (ret < 0) {
         return ret;
     }
 
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
-        error_report("error: failed to get MSR 0x%" PRIx32,
-                     (uint32_t)e->index);
-    }
-
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
     /*
      * MTRR masks: Each mask consists of 5 parts
      * a  10..0: must be zero
-- 
2.54.0

