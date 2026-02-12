Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3D28DB54;
	Thu, 12 Feb 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893110; cv=none; b=qMFwrX0oq3aj0tgfh++CrJsF0keqzz+kK4jcP8hHheuebUUT+vZFLlgY3rDVrVcha6+rt2HB/rBVjJHdF0rGtw4clBrzc+tKRcpc2K2BgbiQ2LUaaOSWxKpj2W9Wbk5IlKaoXLfWVSKS2fNEipQmKG8SO/jtAlrofM8QzzbPui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893110; c=relaxed/simple;
	bh=q9FkRkt9XTtnYFNQYulC4RjiWoYQrI+55cT2OIRD+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAAAv1xvksRI/fW/G3k7RukvzekM3h2ZqgDxpO4YtAnM38vLnYIHcn+2gYWzFLFzJatc/tZmobd/+GyOSa3USD6fDiJ/fEo+HeYJXEwLQ0xF9Z8C+y666BWhyGE1D7MXg8dgS+jmv0DOdB1vDX0p7ZpFWh/RJbnsPTrroRsnqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZYglXK1R; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZYglXK1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Io
	7wlVzfMw58uZVcDRMHjuLTKFMhqga3Ka5BB7KcPEU=; b=ZYglXK1RN0i2cTtoej
	pu05eYjndRabtlVxf4g19G/vcc0wzwNtieRMDvKBAsKrgaCode9RhtqpLe0Sj+By
	8TXCw8mTMhg8XZ2vC0ptFChPLQI5opzpRq4k9S1q0pDxeQcJGzs6GD95Db69iVuR
	XGR/Wo+/Jsh1UcwGrQLPkO6Po=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA38f4Tr41pL2eqLA--.10527S3;
	Thu, 12 Feb 2026 18:44:39 +0800 (CST)
From: Zhiquan Li <zhiquan_li@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan_li@163.com
Subject: [PATCH v2 1/4] KVM: x86: selftests: Add CPU vendor detection for Hygon
Date: Thu, 12 Feb 2026 18:38:38 +0800
Message-ID: <20260212103841.171459-2-zhiquan_li@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212103841.171459-1-zhiquan_li@163.com>
References: <20260212103841.171459-1-zhiquan_li@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA38f4Tr41pL2eqLA--.10527S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW5Zw48Zr17KF17Cr17Wrg_yoW5Jw45pF
	ykAr1rKF10gFnrta4xXr4ktry8XrZ7Wa1Iq34DXry3Aa12yry7Xrs7Ka4jvrZI9FWrW3s8
	Za4xtF4YgFsrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1rWUUUUUU=
X-CM-SenderInfo: 52kl13xdqbzxi6rwjhhfrp/xtbC6Reul2mNrxfYOAAA37

Currently some KVM selftests are failed on Hygon CPUs due to missing
vendor detection and edge-case handling specific to Hygon's
architecture.

Add CPU vendor detection for Hygon and add a global variable
"host_cpu_is_hygon" as the basic facility for the following fixes.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 6 ++++++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 4ebae4269e68..1338de7111e7 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -21,6 +21,7 @@
 
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
+extern bool host_cpu_is_hygon;
 extern uint64_t guest_tsc_khz;
 
 #ifndef MAX_NR_CPUID_ENTRIES
@@ -694,6 +695,11 @@ static inline bool this_cpu_is_amd(void)
 	return this_cpu_vendor_string_is("AuthenticAMD");
 }
 
+static inline bool this_cpu_is_hygon(void)
+{
+	return this_cpu_vendor_string_is("HygonGenuine");
+}
+
 static inline uint32_t __this_cpu_has(uint32_t function, uint32_t index,
 				      uint8_t reg, uint8_t lo, uint8_t hi)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index fab18e9be66c..f6b1c5324931 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -23,6 +23,7 @@
 vm_vaddr_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
+bool host_cpu_is_hygon;
 bool is_forced_emulation_enabled;
 uint64_t guest_tsc_khz;
 
@@ -792,6 +793,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 
 	sync_global_to_guest(vm, host_cpu_is_intel);
 	sync_global_to_guest(vm, host_cpu_is_amd);
+	sync_global_to_guest(vm, host_cpu_is_hygon);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 	sync_global_to_guest(vm, pmu_errata_mask);
 
@@ -1424,6 +1426,7 @@ void kvm_selftest_arch_init(void)
 {
 	host_cpu_is_intel = this_cpu_is_intel();
 	host_cpu_is_amd = this_cpu_is_amd();
+	host_cpu_is_hygon = this_cpu_is_hygon();
 	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	kvm_init_pmu_errata();
-- 
2.43.0

