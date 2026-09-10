Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC548095B;
	Thu, 10 Sep 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041271; cv=none; b=sQOSnkanRK/2rUGiIFHUNnMuwUGC1tu/asLdg0t30PLx5xhuTq9vmd4SqLiyBhC3ijT26NbbecHTF5AyAcbE+Qbvll2hvu1oJQanS832UdNwWKr+meubiFDVTUPMGPb/QcDYmOe58iqillKDbBQGBdK+nqnIpSqbdKJjWt+sHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041271; c=relaxed/simple;
	bh=GVz/0+2wXhOgOylyIOhn5wJcNTCxzKxd7Ss+VaLJn4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZz82fO6V5yzEaZHn7UdfgW0gHld+WLPHqJ8G2heRw3HRAd94AMs7gogvEDnV5Jdg4jCTu54vlmlR/vN0IjUNZphUd9Ig1KXod+mkTNcJyasUYY/euRZxhRxc1n19NB9Clc0TUy80c+2dBPMNIYKQz3nwDrLUf6NeRSyCWqHmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgj0ZFZzbKSt1;
	Thu, 10 Sep 2026 19:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgh5y8hzb0tj9;
	Thu, 10 Sep 2026 19:54:24 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPda0b0659b9d7789122ef7a8f548450e2
	Thu, 10 Sep 2026 19:54:23 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Frank Zhu <frankzhu@zhaoxin.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ewanhai@zhaoxin.com,
	cobechen@zhaoxin.com
Subject: [PATCH v2 9/9] KVM: selftests: vmx_apic_access_test: Check APIC virtualization support
Date: Thu, 10 Sep 2026 19:54:14 +0800
Message-Id: <20260910115414.3015260-10-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

Not all CPUs that support VMX necessarily support the "virtualize APIC
accesses" secondary processor-based VM-execution control. For example,
some Zhaoxin CPUs lack this feature. Add a capability check before
running the test to properly skip on unsupported hardware instead of
failing.

Add kvm_cpu_has_vmx_apic_access_virt() helper to vmx.c, following the
same pattern as kvm_cpu_has_ept().

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h     |  1 +
 tools/testing/selftests/kvm/lib/x86/vmx.c         | 15 +++++++++++++++
 .../selftests/kvm/x86/vmx_apic_access_test.c      |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 04f5e34de..b196651bd 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -557,6 +557,7 @@ bool load_vmcs(struct vmx_pages *vmx);
 bool ept_1g_pages_supported(void);
 
 bool kvm_cpu_has_ept(void);
+bool kvm_cpu_has_vmx_apic_access_virt(void);
 void vm_enable_ept(struct kvm_vm *vm);
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 089e1a8af..e512191f1 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -390,6 +390,21 @@ bool kvm_cpu_has_ept(void)
 	return ctrl & SECONDARY_EXEC_ENABLE_EPT;
 }
 
+bool kvm_cpu_has_vmx_apic_access_virt(void)
+{
+	u64 ctrl;
+
+	if (!kvm_cpu_has(X86_FEATURE_VMX))
+		return false;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) >> 32;
+	if (!(ctrl & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS))
+		return false;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32;
+	return ctrl & SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
+}
+
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm)
 {
 	vmx->apic_access = (void *)vm_alloc_page(vm);
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index 463f73aa9..a1b6da4c0 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -78,6 +78,7 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has_vmx_apic_access_virt());
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
-- 
2.34.1


