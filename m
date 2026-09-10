Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1E47ACF5;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041268; cv=none; b=uS/Ds14E4XfR/i8pXyojLA07vIGQFMj7gdSSTRLDzcrP58tsYlPCrCsQyRiT14oMgvrLB9Y6HyNXj+Ps7wT4h6w458P+Lkz6xOUL5cqCSZcKLUKS+qbhIugZkHRsS8qG4T0nyxJXB0yQV7/Wi0jmkjls0t6BJRgonf/EWC3A09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041268; c=relaxed/simple;
	bh=tTXDCM2k+g6tGK/capTs1+AXF1GoPjlGkiMLBJER8Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvezRA8St/ZNijD0OKMhi5y39cDGkjz/azvkZFf7SFPm06sM73xGbRWKbXRC9WWHnnpnC3BblFETtHKNQ53IgQtlRHY4pBpHXJMX1BQdU23I1P9mnAlDlecpG44s8AxOkrdCqjAfBe3Mi4KVGgZS3Tjm9LA/DoGWj4Es9yziuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf0YWJzbKSsm;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgc5qCMzb0tj9;
	Thu, 10 Sep 2026 19:54:20 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP23c8df9234e54c3a91491374cb4650e2
	Thu, 10 Sep 2026 19:54:20 +0800
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
Subject: [PATCH v2 1/9] KVM: selftests: Add Zhaoxin CPU detection support
Date: Thu, 10 Sep 2026 19:54:06 +0800
Message-Id: <20260910115414.3015260-2-ewanhai-oc@zhaoxin.com>
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

Add helpers to detect Zhaoxin CPUs using the "CentaurHauls" and
"  Shanghai  " vendor strings.

KVM handles Zhaoxin CPUs with its VMX backend. Add
host_cpu_is_intel_compatible for selftests that exercise behavior shared
by Intel and Zhaoxin CPUs, while retaining host_cpu_is_zhaoxin for
Zhaoxin-specific behavior.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 8 ++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035..5d2be3399 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -23,6 +23,8 @@ extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 extern bool host_cpu_is_hygon;
 extern bool host_cpu_is_amd_compatible;
+extern bool host_cpu_is_zhaoxin;
+extern bool host_cpu_is_intel_compatible;
 extern u64 guest_tsc_khz;
 extern struct kvm_mmu guest_mmu;
 
@@ -782,6 +784,12 @@ static inline bool this_cpu_is_hygon(void)
 	return this_cpu_vendor_string_is("HygonGenuine");
 }
 
+static inline bool this_cpu_is_zhaoxin(void)
+{
+	return this_cpu_vendor_string_is("CentaurHauls") ||
+	       this_cpu_vendor_string_is("  Shanghai  ");
+}
+
 static inline u32 __this_cpu_has(u32 function, u32 index, u8 reg, u8 lo, u8 hi)
 {
 	u32 gprs[4];
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d31fa81ea..a183cf005 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -26,6 +26,8 @@ bool host_cpu_is_amd;
 bool host_cpu_is_intel;
 bool host_cpu_is_hygon;
 bool host_cpu_is_amd_compatible;
+bool host_cpu_is_zhaoxin;
+bool host_cpu_is_intel_compatible;
 bool is_forced_emulation_enabled;
 u64 guest_tsc_khz;
 struct kvm_mmu guest_mmu;
@@ -819,6 +821,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, host_cpu_is_hygon);
 	sync_global_to_guest(vm, host_cpu_is_amd_compatible);
+	sync_global_to_guest(vm, host_cpu_is_zhaoxin);
+	sync_global_to_guest(vm, host_cpu_is_intel_compatible);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 	sync_global_to_guest(vm, pmu_errata_mask);
 
@@ -1444,6 +1448,8 @@ void kvm_selftest_arch_init(void)
 	host_cpu_is_amd = this_cpu_is_amd();
 	host_cpu_is_hygon = this_cpu_is_hygon();
 	host_cpu_is_amd_compatible = host_cpu_is_amd || host_cpu_is_hygon;
+	host_cpu_is_zhaoxin = this_cpu_is_zhaoxin();
+	host_cpu_is_intel_compatible = host_cpu_is_intel || host_cpu_is_zhaoxin;
 	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	kvm_init_pmu_errata();
-- 
2.34.1


