Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604743F0A87;
	Mon,  8 Jun 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930519; cv=none; b=UCGBZbzoe8Oao+vO8z8kdmwmsgcO67AcYfIAg03oeaf4ItP8uuYmvtrP29gqqkBVAFVf3WWHvrJbxrrAlLArP2YT8KUd5vqEYPX03gz69D+a8zBX6pkoN2W2V19GBC3nXcXlazpVOOfpepmJcXco7nECplvQmQhfDPB8WMUsvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930519; c=relaxed/simple;
	bh=2UbQVwoYRa8SaEUxm1COfihoMV5CVkoKRu5CIMM/Qxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl/d24mg3KMCbJPN1MeWUekwC06sFEbRmCpGY1k/qsbamoSGPLj6h0acAKXbvlaCDG+JkIOPG+FOAEyfPH631PRdzTSygBLH1wCoqRG3u+2uCcSdBeZkavuam8SjBn1YoOaWjoIebW3F8mx4Gqfyn7Pvp4eqRwGrRATSwuJ7UyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MSZfuWqi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSZfuWqi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=6Oiy0XgmrdblbNNhRhh9uvWEqZS/fcG3BHbMB9gqe6c=; b=MSZfuWqiZiqALtY1MLC6v0WbvH
	cpxENKVttZkGvUcUnfH3cmXTyHF3n/98pkcgu7CvfrdZYKiuL6WuWY0AZcqinMnfKB+/Rg9Yt95g3
	yaATLRg4awYZ0QThmGe6xgS2YzYF+UYyqEwCEPwExEhXVXmzZmBTD3aFHGyMiygVIGd7INsNPIXZB
	HodVYABRpzYthI/nQjlXg9LBoL4JsE/P04Lx7m0sGPt/WKsEAFrYugZyax7C14LGzIuV9ltqZ0Co5
	htE40im31t6H9LcfAt3wwZLgv0lDLBGf6rVZiWaAiQ0wEjqbxzkg4SJ9PTo72VNEt8wbX4RaIDYD9
	4qnXWU6Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNS-0000000Dtxp-3tSE;
	Mon, 08 Jun 2026 14:54:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNT-00000000NGv-0Yy9;
	Mon, 08 Jun 2026 15:54:59 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 34/34] KVM: x86: Remove pvclock_gtod_data and private timekeeping code
Date: Mon,  8 Jun 2026 15:48:15 +0100
Message-ID: <20260608145455.89187-35-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Remove the now-unused KVM-private timekeeping infrastructure:

 - struct pvclock_clock and struct pvclock_gtod_data
 - update_pvclock_gtod() and its seqcount-protected state copy
 - read_tsc() (KVM's private TSC reader with cycle_last clamping)
 - vgettsc() (KVM's private clocksource interpolation)
 - do_kvmclock_base(), do_monotonic(), do_realtime()

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 Documentation/virt/kvm/devices/vcpu.rst       |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |   2 +
 arch/x86/kvm/x86.c                            | 177 +-----------------
 .../testing/selftests/kvm/x86/pvclock_test.c  |   7 +-
 4 files changed, 9 insertions(+), 181 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 167aa4140d30..3d1a89c2b4f7 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -243,9 +243,9 @@ Returns:
 Specifies the guest's TSC offset relative to the host's TSC. The guest's
 TSC is then derived by the following equation:
 
-  guest_tsc = ((host_tsc * tsc_scale_ratio) >> tsc_scale_bits) + KVM_VCPU_TSC_OFFSET
+  guest_tsc = ((host_tsc * tsc_ratio) >> tsc_frac_bits) + KVM_VCPU_TSC_OFFSET
 
-The values of tsc_scale_ratio and tsc_scale_bits can be obtained using
+The values of tsc_ratio and tsc_frac_bits can be obtained using
 the KVM_VCPU_TSC_SCALE attribute.
 
 This attribute is useful to adjust the guest's TSC on live migration,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ed207cc7692d..1aaf3924a799 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8674,6 +8674,8 @@ __init int vmx_hardware_setup(void)
 
 	if (cpu_has_vmx_tsc_scaling() && boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		kvm_caps.has_tsc_control = true;
+	else
+		vmcs_config.cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
 
 	kvm_caps.max_tsc_scaling_ratio = KVM_VMX_TSC_MULTIPLIER_MAX;
 	kvm_caps.tsc_scaling_ratio_frac_bits = 48;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 93a428c37847..966057913366 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2347,58 +2347,6 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }
 
-struct pvclock_clock {
-	int vclock_mode;
-	u64 cycle_last;
-	u64 mask;
-	u32 mult;
-	u32 shift;
-	u64 base_cycles;
-	u64 offset;
-};
-
-struct pvclock_gtod_data {
-	seqcount_t	seq;
-
-	struct pvclock_clock clock; /* extract of a clocksource struct */
-	struct pvclock_clock raw_clock; /* extract of a clocksource struct */
-
-	ktime_t		offs_boot;
-	u64		wall_time_sec;
-};
-
-static struct pvclock_gtod_data pvclock_gtod_data;
-
-static void update_pvclock_gtod(struct timekeeper *tk)
-{
-	struct pvclock_gtod_data *vdata = &pvclock_gtod_data;
-
-	write_seqcount_begin(&vdata->seq);
-
-	/* copy pvclock gtod data */
-	vdata->clock.vclock_mode	= tk->tkr_mono.clock->vdso_clock_mode;
-	vdata->clock.cycle_last		= tk->tkr_mono.cycle_last;
-	vdata->clock.mask		= tk->tkr_mono.mask;
-	vdata->clock.mult		= tk->tkr_mono.mult;
-	vdata->clock.shift		= tk->tkr_mono.shift;
-	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
-	vdata->clock.offset		= tk->tkr_mono.base;
-
-	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->vdso_clock_mode;
-	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
-	vdata->raw_clock.mask		= tk->tkr_raw.mask;
-	vdata->raw_clock.mult		= tk->tkr_raw.mult;
-	vdata->raw_clock.shift		= tk->tkr_raw.shift;
-	vdata->raw_clock.base_cycles	= tk->tkr_raw.xtime_nsec;
-	vdata->raw_clock.offset		= tk->tkr_raw.base;
-
-	vdata->wall_time_sec            = tk->xtime_sec;
-
-	vdata->offs_boot		= tk->offs_boot;
-
-	write_seqcount_end(&vdata->seq);
-}
-
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
@@ -3037,128 +2985,6 @@ static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
 
 #ifdef CONFIG_X86_64
 
-static u64 read_tsc(void)
-{
-	u64 ret = (u64)rdtsc_ordered();
-	u64 last = pvclock_gtod_data.clock.cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	/*
-	 * GCC likes to generate cmov here, but this branch is extremely
-	 * predictable (it's just a function of time and the likely is
-	 * very likely) and there's a data dependence, so force GCC
-	 * to generate a branch instead.  I don't barrier() because
-	 * we don't actually need a barrier, and if this function
-	 * ever gets inlined it will generate worse code.
-	 */
-	asm volatile ("");
-	return last;
-}
-
-static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
-			  int *mode)
-{
-	u64 tsc_pg_val;
-	long v;
-
-	switch (clock->vclock_mode) {
-	case VDSO_CLOCKMODE_HVCLOCK:
-		if (hv_read_tsc_page_tsc(hv_get_tsc_page(),
-					 tsc_timestamp, &tsc_pg_val)) {
-			/* TSC page valid */
-			*mode = VDSO_CLOCKMODE_HVCLOCK;
-			v = (tsc_pg_val - clock->cycle_last) &
-				clock->mask;
-		} else {
-			/* TSC page invalid */
-			*mode = VDSO_CLOCKMODE_NONE;
-		}
-		break;
-	case VDSO_CLOCKMODE_TSC:
-		*mode = VDSO_CLOCKMODE_TSC;
-		*tsc_timestamp = read_tsc();
-		v = (*tsc_timestamp - clock->cycle_last) &
-			clock->mask;
-		break;
-	default:
-		*mode = VDSO_CLOCKMODE_NONE;
-	}
-
-	if (*mode == VDSO_CLOCKMODE_NONE)
-		*tsc_timestamp = v = 0;
-
-	return v * clock->mult;
-}
-
-/*
- * As with get_kvmclock_base_ns(), this counts from boot time, at the
- * frequency of CLOCK_MONOTONIC_RAW (hence adding gtos->offs_boot).
- */
-static int do_kvmclock_base(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->raw_clock.base_cycles;
-		ns += vgettsc(&gtod->raw_clock, tsc_timestamp, &mode);
-		ns >>= gtod->raw_clock.shift;
-		ns += ktime_to_ns(ktime_add(gtod->raw_clock.offset, gtod->offs_boot));
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
-/*
- * This calculates CLOCK_MONOTONIC at the time of the TSC snapshot, with
- * no boot time offset.
- */
-static int do_monotonic(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-		ns += ktime_to_ns(gtod->clock.offset);
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
-static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
 /*
  * Calculates the kvmclock_base_ns (CLOCK_MONOTONIC_RAW + boot time) and
  * reports the TSC value from which it do so. Returns true if host is
@@ -6231,7 +6057,7 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 		break;
 	}
 	case KVM_VCPU_TSC_SCALE:
-		r = -EINVAL; /* Read only */
+		r = kvm_caps.has_tsc_control ? -EINVAL : -ENXIO;
 		break;
 	default:
 		r = -ENXIO;
@@ -10405,7 +10231,6 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 {
 	struct timekeeper *tk = priv;
 
-	update_pvclock_gtod(tk);
 
 #ifdef CONFIG_X86_64
 	kvm_host_has_tsc_clocksource =
diff --git a/tools/testing/selftests/kvm/x86/pvclock_test.c b/tools/testing/selftests/kvm/x86/pvclock_test.c
index aecd62fc8a93..4c1869fa482e 100644
--- a/tools/testing/selftests/kvm/x86/pvclock_test.c
+++ b/tools/testing/selftests/kvm/x86/pvclock_test.c
@@ -14,7 +14,6 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
-#include "apic.h"
 
 #include <asm/pvclock-abi.h>
 
@@ -262,10 +261,12 @@ int main(int argc, char *argv[])
 	return 0;
 }
 
+static volatile uint32_t vcpu_counter;
+
 static void guest_code_stable_bit(void)
 {
-	uint32_t apic_id = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
-	uint64_t gpa = KVMCLOCK_GPA + apic_id * sizeof(struct pvclock_vcpu_time_info);
+	uint32_t idx = __atomic_fetch_add(&vcpu_counter, 1, __ATOMIC_SEQ_CST);
+	uint64_t gpa = KVMCLOCK_GPA + idx * sizeof(struct pvclock_vcpu_time_info);
 
 	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, gpa | KVM_MSR_ENABLED);
 	GUEST_SYNC(0);
-- 
2.54.0

