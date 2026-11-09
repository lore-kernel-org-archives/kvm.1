Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187280;
	b=3yuVxjA6ZbHlIQ/FcbaJKNhiTGWyyNcK0ssp9icNnG3GJMpoCswZZVdw/g85sRvFAuFL
	 xbJ9eFI2DHrit7AWUjDSRkuABUtuiVouXWnH1KOS0LsLjUaAGcx/5SLOfAAQBhdKu6zAV
	 6yPCVOhtuAX/JbFsANxij/9L9JEoJeW19vLqd1nog+PfbNUskU40sKXy1dhyiaA53FcFG
	 n/tHVQfLUuULF7o6bn9E8sQugLK6nbeitD6P/74uNSCC57WXME1EHG0n9HpFxASt5gVLN
	 ynCOLtXPhoAr7oItptM3LoDBz0Tc9FWwwyiX2PR9Cd552ZXW7oVEWSlBy9DpDOGHZNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=jhbHTsXlkafiijDqKYXVFTZ8kLMGsWqGWQ4/HbRTNCs=;
	b=31qQ8TGX+I8v0lo1228RF+xNP7SWcGAaZ13wHhhjgNYHOUDoRsUv4wO3Jdw09VJbxn/b
	 GRg6rcAAVuHEPSlYgRf1Ats6z22A5WckijWo3M3iqqzjS3Dt2qij6KCwmiEzuhdT9DfsB
	 OfR1REn392rX1HU/3sZpwtPyXvYz22KX6d3YXFGg+B9XsSq8HatKS0Bk4MfIgCzCwh5lw
	 lTwjvwp0ODXE9ubX55DCg/IW3BmUELGgNdnmisah34Crv8M2eqRDmqtR9DdVjQIRfx5KB
	 QTdhnqZ8ws9v49IvBxNsZqJz890DOEMCPR4g6h6JjrcRJ5RTUQOa7SJxmTJuM3WPNfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UMiTYyaJ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71438606A32A;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71438606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UMiTYyaJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=jhbHTsXlkafiijDqKYXVFTZ8kLMGsWqGWQ4/HbRTNCs=; b=UMiTYyaJUWRPpigzSX/2R4AfNf
	Vms5l1HWVobQvkUIuIvqktD0UgljhqxSbtoiRrsneCppCdTNcKxy8ly0tJqBPhNnip96ELPYdAV46
	pTVBeOf2FCjl/Af314myhUZtQJTMYO4fTEWjC7W4CRrHfJL9OCXfV0gY+9eWIvOmjvEfNd31l/eJf
	R4VjoZJ9AcTbMWMfKdwocZ6BBEQZ90As+82F9cuKSVmnjwBy9MGTCNesvzdaYTKGxrPgjh1eH5vCX
	Cj2T5dSA1IPFIUfOpUZYN5G+Li/Wd+b4emrOkVGbedGPy+R+eyALKGKOIA/+GXVUAjSqPdDoChUhj
	VOAyAk6g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4P-00000007PwJ-2HJo;
	Mon, 09 Nov 2026 01:21:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKVS-1Vui;
	Mon, 09 Nov 2026 01:21:13 +0000
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
Subject: [PATCH v12 21/24] KVM: selftests: Test that the first user TSC write is honoured exactly
Date: Sun,  8 Nov 2026 17:21:07 -0800
Message-ID: <20261109012112.3415328-22-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The 1-second "slop" heuristic in kvm_synchronize_tsc() is only
supposed to apply between successive userspace TSC writes, i.e. once
kvm->arch.user_set_tsc has been set by a previous write. The kernel's
own internal TSC synchronization on vCPU creation (and frequency
changes) must not arm it, otherwise the first genuine userspace write
falling within 1 second of virtual cycle time of the kernel's default
generation is "corrected" back to that generation instead of being
honoured — breaking the restore of a guest with less than one second
of runtime.

Add a test which creates a vCPU and immediately performs a first
host-initiated write of a TSC value corresponding to ~500ms of guest
runtime, then verifies the value reads back exactly (modulo elapsed
time) rather than being snapped back to the kernel's default
generation near zero.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/tsc_user_set_test.c     | 153 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tsc_user_set_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1edc78845fd3..fd063806a7fb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -151,6 +151,7 @@ TEST_GEN_PROGS_x86 += x86/xcr0_cpuid_test
 TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
+TEST_GEN_PROGS_x86 += x86/tsc_user_set_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_cpuid_timing_test
 TEST_GEN_PROGS_x86 += x86/xen_migration_test
diff --git a/tools/testing/selftests/kvm/x86/tsc_user_set_test.c b/tools/testing/selftests/kvm/x86/tsc_user_set_test.c
new file mode 100644
index 000000000000..a74eb78a975b
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tsc_user_set_test.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that the first userspace write to MSR_IA32_TSC takes effect
+ * precisely, and is not subjected to the 1-second "slop" heuristic
+ * which is only supposed to apply between successive *userspace*
+ * writes (kvm->arch.user_set_tsc).
+ *
+ * The kernel synchronizes the TSC internally when a vCPU is created
+ * (and when its frequency is set). If any of those kernel-internal
+ * paths incorrectly sets user_set_tsc, then the first genuine write
+ * from userspace which happens to fall within 1 second of virtual
+ * cycle time of the kernel's default generation is "corrected" to
+ * match that generation instead of being honoured exactly. That
+ * breaks the restore of a guest which has genuinely been running
+ * for less than one second.
+ *
+ * Simulate exactly that: create a vCPU (kernel establishes a default
+ * TSC generation starting near zero), then perform the first
+ * host-initiated write with a value corresponding to ~500ms of guest
+ * runtime. If the slop heuristic fires, the written value is snapped
+ * back to the kernel's generation (near zero) and the TSC reads back
+ * hundreds of milliseconds low. Repeat with an explicit
+ * KVM_SET_TSC_KHZ on the never-run vCPU before the write: that is
+ * another kernel-internal synchronization which must not arm the
+ * heuristic (nor open a generation that swallows the first write).
+ */
+#include "kvm_util.h"
+#include "processor.h"
+
+/*
+ * Returns false when the attempt was inconclusive: a snapped-back value
+ * tracks time since vCPU creation, so if creation-to-write time gets
+ * anywhere near the written 500ms, a buggy kernel's value could land
+ * inside the assertions' tolerance and pass. The caller retries.
+ */
+static bool test_first_write(bool set_freq)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 freq_khz, t_write, t_read, slack_cycles, mono_ns, create_ns, read_ns;
+	struct timespec ts;
+	int r;
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
+	create_ns = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	if (set_freq) {
+		/*
+		 * Halve the frequency so this is a real change, exercising
+		 * the frequency resynchronization path rather than the
+		 * unchanged-frequency no-op.
+		 */
+		r = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+		TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ failed");
+		vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ,
+			   (void *)(unsigned long)(r / 2));
+	}
+
+	r = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ failed");
+	freq_khz = r;
+
+	/*
+	 * The first user write: a guest TSC corresponding to 500ms of
+	 * runtime. This is within 1s (of virtual cycle time) of the
+	 * kernel's default generation, so it is exactly the case that
+	 * the slop heuristic would destroy if it were (incorrectly)
+	 * armed by the kernel's own internal TSC synchronization.
+	 */
+	t_write = freq_khz * 500ULL;		/* khz * ms = cycles */
+
+	/*
+	 * Measure only the write..read window (a window measured from
+	 * before creation would also bound a snapped-back value), and
+	 * insist the write lands well before 500ms of creation time so
+	 * a snapped-back value cannot sit inside the tolerance.
+	 */
+	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
+	mono_ns = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+
+	if (mono_ns - create_ns > 250000000ULL) {
+		pr_info("  creation took %lu ms, retrying for a conclusive run\n",
+			(mono_ns - create_ns) / 1000000);
+		kvm_vm_free(vm);
+		return false;
+	}
+
+	vcpu_set_msr(vcpu, MSR_IA32_TSC, t_write);
+
+	t_read = vcpu_get_msr(vcpu, MSR_IA32_TSC);
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
+	read_ns = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+
+	/*
+	 * Bound the whole creation..read interval too: a snapped-back
+	 * value tracks it, so letting it approach the written 500ms
+	 * (via a stall between the two MSR ioctls, which the slack
+	 * below would otherwise absorb) would let a buggy kernel pass.
+	 */
+	if (read_ns - create_ns > 400000000ULL) {
+		pr_info("  creation..read took %lu ms, retrying for a conclusive run\n",
+			(read_ns - create_ns) / 1000000);
+		kvm_vm_free(vm);
+		return false;
+	}
+
+	mono_ns = read_ns - mono_ns;
+
+	/*
+	 * The TSC advances between the write and the read; bound the
+	 * difference by the measured elapsed time around the two ioctls
+	 * plus 10ms of slop, so a descheduled test cannot flake. If the
+	 * write was snapped to the kernel's default generation, the
+	 * value read back is ~500ms low (i.e. below t_write), which is
+	 * unambiguous.
+	 */
+	slack_cycles = freq_khz * (mono_ns / 1000000ULL + 10);
+
+	TEST_ASSERT(t_read >= t_write,
+		    "TSC went backwards from explicit write: wrote %lu, read %lu"
+		    " (first userspace write was subjected to 1-second slop?)",
+		    t_write, t_read);
+	TEST_ASSERT(t_read - t_write < slack_cycles,
+		    "TSC read back too far from written value: wrote %lu, read %lu",
+		    t_write, t_read);
+
+	kvm_vm_free(vm);
+	return true;
+}
+
+static void run_first_write(bool set_freq)
+{
+	int i;
+
+	for (i = 0; i < 5; i++)
+		if (test_first_write(set_freq))
+			return;
+
+	TEST_FAIL("vCPU creation repeatedly too slow for a conclusive run");
+}
+
+int main(void)
+{
+	run_first_write(false);
+
+	if (kvm_has_cap(KVM_CAP_TSC_CONTROL))
+		run_first_write(true);
+
+	return 0;
+}
-- 
2.43.0

