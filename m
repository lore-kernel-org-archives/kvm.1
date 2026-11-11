Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=at8tau5PZ9kVYteYAWqQUaFgJALvWbfK/V1oUIv9PF7YtTz6YkjeuNDvktnzKlghp9hL
	 9vHQiN/WjLGEd9vQlKZ3JUcGp1oTjqyxvYXq7csI3Wk6sAA6jSCcu/mUnRQqG/UmG4Nw9
	 RPHY+CU+FSyeFB0omUvh27KB2wOLYzjQxD7+pnwCAm8Ke4Wv0tpbSzC2ENDSh1lhrKk7/
	 sSR2o0XNe//oWGdDTE7ofa1xjMEW3I9KA++19DWHuTf8VSWoNV95+vNW+7SriRTbd89sE
	 V/chFWvjtDLhdvEL1Dx1rYJgogISoNEOwUpE650jXGTzrI1yfJicY7xXqGBEytskG/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=iIYMQDfTQ0ULEEJl8+/Ov/AE8lIxjPKWswOvOCyc1OM=;
	b=lDK+VYoq240Jq5cZdNLEw08h7GNPLozAWKAE9cYK2AaJSUvwczrtnNBe0wu+YJXoKcHA
	 OOvh5xt+iHc5YuTNykubZf4Qrcn8WmzeMjQXQYs4RfivivSP30d0N2qD3uVvyIMDvcKmR
	 Gw3IBaxgh0laB2dRfx3/GNfJGfM3TRu3I+p/CoURElGXQ6zAxlEu818dOWGB4fumiStOx
	 1uc9CwfF1VwkJbaaQBoyMX0sdUD/E1DBZOfofO0uUF1wsU+vj4Rqf+G0b0Qel34PyMtX3
	 DIlnH7QUZdoklqLty9Ltd0PRRZQbN9V2IXWr8tAQejPvxde/1MUEMZVgXk2jzebolzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=efTTLN+X;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39456606B789;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39456606B789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=efTTLN+X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iIYMQDfTQ0ULEEJl8+/Ov/AE8lIxjPKWswOvOCyc1OM=; b=efTTLN+X2ESK4J6l6MZpAjrLfl
	50KBNF9qmHwoujN2WeQ7k/kQmP6ctq3v/I9AdKBS8KGTZHLpqTLJLLY2nM+fCDX0+HrjE1lelRtpQ
	EpLlMUklhPaZn5QRIFXdLhBGb68r9AmC1cFfEdJlCrVVqYfAMnkrZft2O/mcehO8w25QHh0/m9gtW
	jXCyXSOeETrwPhmBhLQ+41vazEZ0KFBlNZxE4/C27PImq/xAOPVnMBfWFi/TtUNsOZXuBqBHwsyTm
	lEEhiXf3P9BQd/B1AypeHprvMyT50vxK+SUl0o4REgHaGInx6oPsVQGTUH7Ik9ikRG+43YuGaUUGb
	RD/CEatg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvR-3Ctb;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWt7-23xv;
	Wed, 11 Nov 2026 18:09:23 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v13 17/26] KVM: selftests: Add library helpers for clock and TSC-offset ioctls
Date: Wed, 11 Nov 2026 10:09:13 -0800
Message-ID: <20261111180922.4177927-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Add wrappers for KVM_[GS]ET_CLOCK_GUEST, the KVM_VCPU_TSC_OFFSET device
attribute and KVM_[GS]ET_CLOCK to the x86 library header, so that the
KVM clock selftests don't each open-code the same ioctl invocations,
and convert the existing open-coded call sites in kvm_clock_test,
hyperv_clock, xen_shinfo_test and system_counter_offset_test.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../selftests/kvm/include/x86/processor.h     | 50 +++++++++++++++++++
 .../kvm/system_counter_offset_test.c          |  3 +-
 .../testing/selftests/kvm/x86/hyperv_clock.c  |  2 +-
 .../selftests/kvm/x86/kvm_clock_test.c        |  6 +--
 .../selftests/kvm/x86/xen_shinfo_test.c       |  2 +-
 5 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..4062bdb32716 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -12,6 +12,7 @@
 
 #include <asm/msr-index.h>
 #include <asm/prctl.h>
+#include <asm/pvclock-abi.h>
 
 #include <linux/kvm_para.h>
 #include <linux/stringify.h>
@@ -1029,6 +1030,55 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
 	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
 }
 
+static inline int __vcpu_get_clock_guest(struct kvm_vcpu *vcpu,
+					 struct pvclock_vcpu_time_info *pvti)
+{
+	return __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, pvti);
+}
+
+static inline void vcpu_get_clock_guest(struct kvm_vcpu *vcpu,
+					struct pvclock_vcpu_time_info *pvti)
+{
+	vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, pvti);
+}
+
+static inline int __vcpu_set_clock_guest(struct kvm_vcpu *vcpu,
+					 struct pvclock_vcpu_time_info *pvti)
+{
+	return __vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, pvti);
+}
+
+static inline void vcpu_set_clock_guest(struct kvm_vcpu *vcpu,
+					struct pvclock_vcpu_time_info *pvti)
+{
+	vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, pvti);
+}
+
+static inline u64 vcpu_get_tsc_offset(struct kvm_vcpu *vcpu)
+{
+	u64 offset;
+
+	vcpu_device_attr_get(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
+			     &offset);
+	return offset;
+}
+
+static inline void vcpu_set_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+{
+	vcpu_device_attr_set(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
+			     &offset);
+}
+
+static inline void vm_get_clock(struct kvm_vm *vm, struct kvm_clock_data *data)
+{
+	vm_ioctl(vm, KVM_GET_CLOCK, data);
+}
+
+static inline void vm_set_clock(struct kvm_vm *vm, struct kvm_clock_data *data)
+{
+	vm_ioctl(vm, KVM_SET_CLOCK, data);
+}
+
 const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 					       u32 function, u32 index);
 const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index dc5e30b7b77f..f864e66dc789 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -35,8 +35,7 @@ static void check_preconditions(struct kvm_vcpu *vcpu)
 
 static void setup_system_counter(struct kvm_vcpu *vcpu, struct test_case *test)
 {
-	vcpu_device_attr_set(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
-			     &test->tsc_offset);
+	vcpu_set_tsc_offset(vcpu, test->tsc_offset);
 }
 
 static u64 guest_read_system_counter(struct test_case *test)
diff --git a/tools/testing/selftests/kvm/x86/hyperv_clock.c b/tools/testing/selftests/kvm/x86/hyperv_clock.c
index 7a1b3b5d1e62..ced3d9873f9a 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_clock.c
@@ -254,7 +254,7 @@ int main(void)
 		if (stage == 7 || stage == 8 || stage == 10) {
 			struct kvm_clock_data clock = {0};
 
-			vm_ioctl(vm, KVM_SET_CLOCK, &clock);
+			vm_set_clock(vm, &clock);
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/x86/kvm_clock_test.c b/tools/testing/selftests/kvm/x86/kvm_clock_test.c
index 5ad4aeb8e373..0028a40b8a3e 100644
--- a/tools/testing/selftests/kvm/x86/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_clock_test.c
@@ -99,7 +99,7 @@ static void setup_clock(struct kvm_vm *vm, struct test_case *test_case)
 		data.realtime += test_case->realtime_offset;
 	}
 
-	vm_ioctl(vm, KVM_SET_CLOCK, &data);
+	vm_set_clock(vm, &data);
 }
 
 static void enter_guest(struct kvm_vcpu *vcpu)
@@ -112,10 +112,10 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		setup_clock(vm, &test_cases[i]);
 
-		vm_ioctl(vm, KVM_GET_CLOCK, &start);
+		vm_get_clock(vm, &start);
 
 		vcpu_run(vcpu);
-		vm_ioctl(vm, KVM_GET_CLOCK, &end);
+		vm_get_clock(vm, &end);
 
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 9045f03cf2d3..f251f8ea29ec 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -985,7 +985,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(wc->version && !(wc->version & 1),
 		    "Bad wallclock version %x", wc->version);
 
-	vm_ioctl(vm, KVM_GET_CLOCK, &kcdata);
+	vm_get_clock(vm, &kcdata);
 
 	if (kcdata.flags & KVM_CLOCK_REALTIME) {
 		if (verbose) {
-- 
2.43.0

