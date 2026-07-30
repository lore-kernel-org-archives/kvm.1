Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBF408026;
	Thu, 30 Jul 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410110; cv=none; b=Jnwvk//oP+13pcuOAa8YVo7NJ578EcHgxTjSNKiJ/znmqV2utHYRyz8VURvTIEzmNShBuyUbfpoNjhM33WCpyFGIpzpbdCnQeB6w9UDqRIpJv56Ce9M9LcJlVQQTxrjbhCmYR1kOA/Alm2tbOB1iPXS+b8LjYHSGUeIyL7mXHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410110; c=relaxed/simple;
	bh=k+Rr/t1LlEauZDblUqwGM/cxuUrgweW8iZJeaQ0qrGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4UWldwRjVDQMV4E2ZkWOi9ErLRXOOSsRs/40IaeYKImE/vH0OBb3XvLhtNOQXMba5Lpr6H4UKfDkx+2snoXeAZVw0scqgcK3aDhWZ09XXAsOoKvEKihhSqz9FMcvT0pAzGe8WFkVf9mWOW1Gg/WQ76ocG/rzrLfaefbzrVhGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk1N56zYq2gw;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZj3jMwzbLW71;
	Thu, 30 Jul 2026 19:05:33 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP75d1373766bcd616be5878b67b0850b8
	Thu, 30 Jul 2026 19:05:32 +0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] KVM: selftests: Add Zhaoxin (ZX) CPU detection support
Date: Thu, 30 Jul 2026 19:05:17 +0800
Message-Id: <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

Add infrastructure to detect Zhaoxin CPUs in KVM selftests. Zhaoxin
CPUs use vendor strings "CentaurHauls" or "  Shanghai  " and implement
VMX-compatible virtualization technology.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 7 +++++++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index b161174ece45..9840b583877c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -23,6 +23,7 @@ extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 extern bool host_cpu_is_hygon;
 extern bool host_cpu_is_amd_compatible;
+extern bool host_cpu_is_zx;
 extern u64 guest_tsc_khz;
 
 #ifndef MAX_NR_CPUID_ENTRIES
@@ -744,6 +745,12 @@ static inline bool this_cpu_is_hygon(void)
 	return this_cpu_vendor_string_is("HygonGenuine");
 }
 
+static inline bool this_cpu_is_zx(void)
+{
+	return this_cpu_vendor_string_is("CentaurHauls") ||
+	       this_cpu_vendor_string_is("  Shanghai  ");
+}
+
 static inline u32 __this_cpu_has(u32 function, u32 index, u8 reg, u8 lo, u8 hi)
 {
 	u32 gprs[4];
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ef56dcefe011..a8ea591ebe8e 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -26,6 +26,7 @@ bool host_cpu_is_amd;
 bool host_cpu_is_intel;
 bool host_cpu_is_hygon;
 bool host_cpu_is_amd_compatible;
+bool host_cpu_is_zx;
 bool is_forced_emulation_enabled;
 u64 guest_tsc_khz;
 
@@ -816,6 +817,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, host_cpu_is_hygon);
 	sync_global_to_guest(vm, host_cpu_is_amd_compatible);
+	sync_global_to_guest(vm, host_cpu_is_zx);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 	sync_global_to_guest(vm, pmu_errata_mask);
 
@@ -1430,6 +1432,7 @@ void kvm_selftest_arch_init(void)
 	host_cpu_is_amd = this_cpu_is_amd();
 	host_cpu_is_hygon = this_cpu_is_hygon();
 	host_cpu_is_amd_compatible = host_cpu_is_amd || host_cpu_is_hygon;
+	host_cpu_is_zx = this_cpu_is_zx();
 	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	kvm_init_pmu_errata();
-- 
2.34.1


