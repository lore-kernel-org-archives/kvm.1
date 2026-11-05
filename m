Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893804;
	b=P04TB/+ywEeX9PaB5Ub4hbfLces9BPsKiD5bwBTdhNzScjqQ31tGN9vhJcQnV3qOf5yE
	 4eD2u/AqtWHsUdCy8ZlKoNpc55gV5zjMIysS337+mkbrVvuQe8SqalmP8YbGt5qA5oyYt
	 vwKP9hmzcchCjNv4ic4Hu9gWB3neAwSIMImlXB0icVG3Y5f4JXBBc1kR1/Kg+N9K+4SN8
	 e2xorWTLfIJ25lAv+ATUMEM6QM0hlopxSZfFj40RiTN2oPO7bZq5mJLl9SZ7Su2ub79y2
	 D58cCy9A/e4SIuJ8a1/LRHdsRrMU7HvEdTJdXaJuLi9Y9yXWnF+l2cSxdzen+81C2JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893804;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=SgAfDm8bN4RqfSb2fwUeH424ylBGQ7EFh9qchEyHoe4=;
	b=G6Dri1Z1UYm1LtESy6yVTamWN5/ARE7dcKrCRNJ/R5yfuPPIhHYfwXlIK7MjEma8CeMp
	 xOTbwAOnbHX3969zAkT9p00Gedp2zcQc4YHikhHsqgW3uCmW7e1ifRIUSfaqWmCHyicHe
	 FiZtdUb8XBXOjz1fUyn+ibWMyd/b/3d7afRYIILAiVBPSaZ/3DToWfXCbCT2C3mPWp5GA
	 AI9gnZSyOoeh0+TBgOoidLDE92eDT0riDnegNnGlPqTy7Uj5b5zBUenT4fB84zfSNCY4G
	 J/RJwV/UJVKOLS6RpwCsKHO9RF5Qmso2iO2jsfdIad/jM1KbPuCq9mBZl5FuCtDm1bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=O67LUaon;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EC606D806;
	Thu,  5 Nov 2026 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40EC606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=O67LUaon
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=SgAfDm8bN4RqfSb2fwUeH424ylBGQ7EFh9qchEyHoe4=; b=O67LUaon3zOu2RRYEHrPk6Kc6/
	aOsaftCYm5t/3xUfRjLjX+gdpFalVYmp3KOPo+Ajox6sk13/0+3uYDmV8c5wKlUH2RrKipa5rf7WA
	zbVTcARFzdT0aVnX9Rn4NxgCGxk9dj5mkdl4FXTkdRgwBQkbl2eufdt0mQHbTMqSL+GLP7pGFsIvj
	wq/GhMnSqHd9kd+eNfx0j89WJnpZU2DJljTmJjc5MJTWuom6j/+s+E0DpO5i7xET/iBN58pFGvoOi
	2lMe6wcMmuUWyqPDjzDrXVhF+tz+3b86ltTP5AbLv06QpHukifsvFrs9x3SMCm7gYM8ve14iPzadC
	k8r/yu7g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziw-00000003Bo4-2989;
	Thu, 05 Nov 2026 15:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOziu-0000000Aazq-1KtU;
	Thu, 05 Nov 2026 15:49:56 +0000
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
Subject: [PATCH v11 16/23] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
Date: Thu,  5 Nov 2026 07:49:47 -0800
Message-ID: <20261105154955.2525419-17-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The documentation on TSC migration using KVM_VCPU_TSC_OFFSET is woefully
inadequate. It ignores TSC scaling, and ignores the fact that the host
TSC may differ from one host to the next (and in fact because of the way
the kernel calibrates it, it generally differs from one boot to the next
even on the same hardware).

Add KVM_VCPU_TSC_SCALE to extract the actual scale ratio and frac_bits,
and attempt to document the process that userspace needs to follow to
preserve the TSC across migration. Add a self test to function as an
exemplar.

Only enumerate KVM_VCPU_TSC_SCALE when kvm_caps.has_tsc_control is true,
since the scaling ratio is only meaningful when hardware TSC scaling is
supported.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 Documentation/virt/kvm/devices/vcpu.rst       | 130 ++++-
 arch/x86/include/uapi/asm/kvm.h               |   6 +
 arch/x86/kvm/x86.c                            |  21 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/pvclock_migration_test.c          | 520 ++++++++++++++++++
 5 files changed, 648 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_migration_test.c

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index deb5c51bc00c..3daa77c5d215 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -239,6 +239,7 @@ including the layout of the stolen time structure.
 :Architectures: x86
 
 4.1 ATTRIBUTE: KVM_VCPU_TSC_OFFSET
+----------------------------------
 
 :Parameters: 64-bit unsigned TSC offset
 
@@ -253,7 +254,10 @@ Returns:
 Specifies the guest's TSC offset relative to the host's TSC. The guest's
 TSC is then derived by the following equation:
 
-  guest_tsc = host_tsc + KVM_VCPU_TSC_OFFSET
+  guest_tsc = ((host_tsc * tsc_ratio) >> tsc_frac_bits) + KVM_VCPU_TSC_OFFSET
+
+The values of tsc_ratio and tsc_frac_bits can be obtained using
+the KVM_VCPU_TSC_SCALE attribute.
 
 This attribute is useful to adjust the guest's TSC on live migration,
 so that the TSC counts the time during which the VM was paused. The
@@ -261,44 +265,110 @@ following describes a possible algorithm to use for this purpose.
 
 From the source VMM process:
 
-1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (tsc_src),
+1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_src),
    kvmclock nanoseconds (guest_src), and host CLOCK_REALTIME nanoseconds
-   (host_src).
+   (time_src) at a given moment (Tsrc). The host_tsc field is only valid
+   when the returned flags include KVM_CLOCK_HOST_TSC.
+
+2. For each vCPU[i]:
+
+   a. Read the KVM_VCPU_TSC_OFFSET attribute to record the guest TSC offset
+      (ofs_src[i]).
+
+   b. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scaling
+      ratio (ratio_src[i], frac_bits_src[i]). If the attribute is not
+      supported (-ENXIO), there is no hardware TSC scaling and identity
+      scaling applies: use ratio 1, frac_bits 0.
 
-2. Read the KVM_VCPU_TSC_OFFSET attribute for every vCPU to record the
-   guest TSC offset (ofs_src[i]).
+   c. Use host_tsc_src and the scaling/offset factors to calculate this
+      vCPU's TSC at time Tsrc:
 
-3. Invoke the KVM_GET_TSC_KHZ ioctl to record the frequency of the
-   guest's TSC (freq).
+      tsc_src[i] = ((host_tsc_src * ratio_src[i]) >> frac_bits_src[i]) + ofs_src[i]
+
+      Note that frac_bits may be as high as 48, so this multiplication
+      needs a 128-bit intermediate to avoid overflow.
+
+3. Invoke the KVM_GET_CLOCK_GUEST ioctl on the boot vCPU to return the KVM
+   clock as a function of the guest TSC (pvti_src). (This ioctl may not
+   succeed if the host and guest TSCs are not consistent and well-behaved.)
 
 From the destination VMM process:
 
-4. Invoke the KVM_SET_CLOCK ioctl, providing the source nanoseconds from
-   kvmclock (guest_src) and CLOCK_REALTIME (host_src) in their respective
-   fields.  Ensure that the KVM_CLOCK_REALTIME flag is set in the provided
-   structure.
+4. Invoke the KVM_SET_TSC_KHZ ioctl to set the scaled frequency of the
+   guest's TSC (freq) — either on the VM before creating the vCPUs, or
+   on each vCPU after creating it (as the exemplar test does).
+
+5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_dst) and
+   host CLOCK_REALTIME nanoseconds (time_dst) at a given moment (Tdst),
+   again checking KVM_CLOCK_HOST_TSC in the returned flags.
+
+6. Calculate the number of nanoseconds elapsed between Tsrc and Tdst:
+
+   ΔT = time_dst - time_src
+
+7. As each vCPU[i] is created:
+
+   a. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scaling
+      ratio (ratio_dst[i], frac_bits_dst[i]).
+
+   b. Calculate the intended guest TSC value at time Tdst, taking care
+      with the units (ΔT is in nanoseconds; freq, as set by
+      KVM_SET_TSC_KHZ, is in kHz):
+
+      tsc_dst[i] = tsc_src[i] + (ΔT * freq[i] / 10^6)
 
-   KVM will advance the VM's kvmclock to account for elapsed time since
-   recording the clock values.  Note that this will cause problems in
-   the guest (e.g., timeouts) unless CLOCK_REALTIME is synchronized
-   between the source and destination, and a reasonably short time passes
-   between the source pausing the VMs and the destination executing
-   steps 4-7.
+   c. Use host_tsc_dst and the scaling factors to calculate this vCPU's
+      raw scaled TSC at time Tdst without offsetting:
+
+      raw_dst[i] = ((host_tsc_dst * ratio_dst[i]) >> frac_bits_dst[i])
+
+   d. Calculate ofs_dst[i] = tsc_dst[i] - raw_dst[i] and set the resulting
+      offset using the KVM_VCPU_TSC_OFFSET attribute.
+
+8. If pvti_src was provided, invoke the KVM_SET_CLOCK_GUEST ioctl on the boot
+   vCPU to restore the KVM clock as a precise function of the guest TSC.
+
+9. If KVM_SET_CLOCK_GUEST was not available or failed (e.g. because the
+   master clock is not active), fall back to the KVM_SET_CLOCK ioctl,
+   providing the source nanoseconds from kvmclock (guest_src) and
+   CLOCK_REALTIME (time_src) in their respective fields. Ensure that the
+   KVM_CLOCK_REALTIME flag is set in the provided structure.
+
+   KVM will restore the VM's kvmclock, accounting for elapsed time since
+   the clock values were recorded. Note that this will cause problems in
+   the guest (e.g., timeouts) unless CLOCK_REALTIME is synchronized between
+   the source and destination, and a reasonably short time passes between
+   the source pausing the VMs and the destination resuming them.
+   Due to the KVM_[SG]ET_CLOCK API using CLOCK_REALTIME instead of
+   CLOCK_TAI, leap seconds during the migration may also introduce errors.
+
+4.2 ATTRIBUTE: KVM_VCPU_TSC_SCALE
+---------------------------------
+
+:Parameters: struct kvm_vcpu_tsc_scale
+
+Returns:
+
+	 ======= ======================================
+	 -EFAULT Error writing the result to the
+		 provided address.
+	 -ENXIO  Attribute not supported (no TSC scaling)
+	 -EINVAL Invalid request to write the attribute
+	 ======= ======================================
 
-5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (tsc_dest) and
-   kvmclock nanoseconds (guest_dest).
+This read-only attribute reports the guest's TSC scaling factor, in the form
+of a fixed-point number represented by the following structure::
 
-6. Adjust the guest TSC offsets for every vCPU to account for (1) time
-   elapsed since recording state and (2) difference in TSCs between the
-   source and destination machine:
+  struct kvm_vcpu_tsc_scale {
+	__u64 tsc_ratio;
+	__u64 tsc_frac_bits;
+  };
 
-   ofs_dst[i] = ofs_src[i] -
-     (guest_src - guest_dest) * freq +
-     (tsc_src - tsc_dest)
+The tsc_frac_bits field indicates the location of the fixed point, such that
+host TSC values are converted to guest TSC using the formula:
 
-   ("ofs[i] + tsc - guest * freq" is the guest TSC value corresponding to
-   a time of 0 in kvmclock.  The above formula ensures that it is the
-   same on the destination as it was on the source).
+  guest_tsc = ((host_tsc * tsc_ratio) >> tsc_frac_bits) + offset
 
-7. Write the KVM_VCPU_TSC_OFFSET attribute for every vCPU with the
-   respective value derived in the previous step.
+Userspace can use this to precisely calculate the guest TSC from the host
+TSC at any given moment. This is needed for accurate migration of guests,
+as described in the documentation for the KVM_VCPU_TSC_OFFSET attribute.
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9e3cdc3adb65..f8274d8e471d 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -964,6 +964,12 @@ struct kvm_hyperv_eventfd {
 /* for KVM_{GET,SET,HAS}_DEVICE_ATTR */
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
+#define   KVM_VCPU_TSC_SCALE  1 /* attribute for TSC scaling factor */
+
+struct kvm_vcpu_tsc_scale {
+	__u64 tsc_ratio;
+	__u64 tsc_frac_bits;
+};
 
 /* x86-specific KVM_EXIT_HYPERCALL flags. */
 #define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bdc838b12fdc..17544b3cc035 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3396,6 +3396,9 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
 	case KVM_VCPU_TSC_OFFSET:
 		r = 0;
 		break;
+	case KVM_VCPU_TSC_SCALE:
+		r = kvm_caps.has_tsc_control ? 0 : -ENXIO;
+		break;
 	default:
 		r = -ENXIO;
 	}
@@ -3416,6 +3419,21 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
 			break;
 		r = 0;
 		break;
+	case KVM_VCPU_TSC_SCALE: {
+		struct kvm_vcpu_tsc_scale scale;
+
+		r = -ENXIO;
+		if (!kvm_caps.has_tsc_control)
+			break;
+
+		scale.tsc_ratio = vcpu->arch.l1_tsc_scaling_ratio;
+		scale.tsc_frac_bits = kvm_caps.tsc_scaling_ratio_frac_bits;
+		r = -EFAULT;
+		if (copy_to_user(uaddr, &scale, sizeof(scale)))
+			break;
+		r = 0;
+		break;
+	}
 	default:
 		r = -ENXIO;
 	}
@@ -3455,6 +3473,9 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 		r = 0;
 		break;
 	}
+	case KVM_VCPU_TSC_SCALE:
+		r = kvm_caps.has_tsc_control ? -EINVAL : -ENXIO;
+		break;
 	default:
 		r = -ENXIO;
 	}
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 888a7530a280..18605318860e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -113,6 +113,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/pvclock_migration_test
 TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
diff --git a/tools/testing/selftests/kvm/x86/pvclock_migration_test.c b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c
new file mode 100644
index 000000000000..c4a64b6a2e42
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM clock precision across simulated live migration.
+ *
+ * Verifies that the documented TSC migration procedure (using
+ * KVM_VCPU_TSC_OFFSET, KVM_VCPU_TSC_SCALE, KVM_GET_CLOCK, and
+ * KVM_SET_CLOCK_GUEST) preserves the kvmclock's relationship to
+ * CLOCK_MONOTONIC_RAW — including for vCPUs whose TSCs are offset
+ * from one another (same frequency), which no longer disables the
+ * master clock.
+ *
+ * The test:
+ * 1. Creates a VM with 3 vCPUs, runs each guest to enable kvmclock
+ * 2. Applies divergent TSC offsets to vCPUs 1 and 2
+ * 3. Verifies the master clock remains active (KVM_CLOCK_HOST_TSC),
+ *    that the guests see PVCLOCK_TSC_STABLE_BIT clear, and that all
+ *    vCPUs' pvclocks agree on "now" despite the divergent offsets
+ * 4. Does a PTP-like ABA measurement of kvmclock vs CLOCK_MONOTONIC_RAW
+ * 5. Follows the documented migration procedure (same host, 1s pause),
+ *    migrating each vCPU's TSC individually but setting the KVM clock
+ *    only once, via KVM_SET_CLOCK_GUEST on vCPU0
+ * 6. Does the same ABA measurement on the destination VM
+ * 7. Verifies the kvmclock-vs-monotonic delta is preserved, the
+ *    cross-vCPU TSC deltas are preserved, and all destination vCPUs'
+ *    pvclocks again agree on "now"
+ */
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock-abi.h>
+
+#define KVMCLOCK_GPA	0xc0000000ULL
+#define NR_VCPUS	3
+
+/*
+ * Divergent TSC offsets applied to vCPUs 1 and 2, in guest cycles.
+ * Roughly +1s and -0.5s at 1.5 GHz — large enough that any failure
+ * to account for them is orders of magnitude outside the ABA bounds.
+ */
+static const s64 tsc_deltas[NR_VCPUS] = { 0, 1500000000LL, -750000000LL };
+
+static void guest_code(int idx)
+{
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, (KVMCLOCK_GPA + idx * PAGE_SIZE) | 1);
+
+	for (;;)
+		GUEST_SYNC(0);
+}
+
+static u64 read_kvmclock_ns(struct kvm_vm *vm)
+{
+	struct kvm_clock_data data = {};
+
+	vm_get_clock(vm, &data);
+	return data.clock;
+}
+
+static u64 pvclock_read_cycles(struct pvclock_vcpu_time_info *src,
+				    u64 tsc)
+{
+	u64 delta = tsc - src->tsc_timestamp;
+	u64 ns;
+
+	if (src->tsc_shift >= 0)
+		delta <<= src->tsc_shift;
+	else
+		delta >>= -(s32)src->tsc_shift;
+
+	ns = (unsigned __int128)delta * src->tsc_to_system_mul >> 32;
+	return src->system_time + ns;
+}
+
+/*
+ * ABA measurement: read CLOCK_MONOTONIC_RAW, kvmclock, CLOCK_MONOTONIC_RAW.
+ * Repeat 3 times, keep the reading with the smallest spread.
+ */
+static void aba_reading(struct kvm_vm *vm, u64 *lo, u64 *kvm_ns,
+			u64 *hi)
+{
+	u64 best_spread = UINT64_MAX;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		struct timespec ts1, ts2;
+		u64 m1, m2, clk;
+
+		clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
+		clk = read_kvmclock_ns(vm);
+		clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
+
+		m1 = ts1.tv_sec * 1000000000ULL + ts1.tv_nsec;
+		m2 = ts2.tv_sec * 1000000000ULL + ts2.tv_nsec;
+
+		if (m2 - m1 < best_spread) {
+			best_spread = m2 - m1;
+			*lo = m1;
+			*kvm_ns = clk;
+			*hi = m2;
+		}
+	}
+}
+
+static struct kvm_vm *create_vm(struct kvm_vcpu **vcpus, u32 freq_khz)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, NR_VCPUS, 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, NR_VCPUS);
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		vcpu_args_set(vcpus[i], 1, i);
+		/* Set guest TSC frequency (may trigger scaling) */
+		vcpu_ioctl(vcpus[i], KVM_SET_TSC_KHZ,
+			   (void *)(unsigned long)freq_khz);
+	}
+	return vm;
+}
+
+static void run_to_sync(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+}
+
+/*
+ * Compute a vCPU's guest TSC for a given host TSC value, using the
+ * vCPU's scale and offset as saved from KVM_VCPU_TSC_SCALE/OFFSET.
+ */
+static u64 host_to_guest_tsc(struct kvm_vcpu_tsc_scale *scale, u64 ofs,
+			     u64 host_tsc)
+{
+	if (scale->tsc_frac_bits)
+		return ((unsigned __int128)host_tsc * scale->tsc_ratio
+			>> scale->tsc_frac_bits) + ofs;
+	return host_tsc + ofs;
+}
+
+/*
+ * Verify that all vCPUs agree on the KVM clock, despite having
+ * different TSC offsets. Take one atomic {host_tsc, kvmclock} pair
+ * for the whole VM, derive each vCPU's guest TSC at that instant,
+ * and evaluate each vCPU's pvti at its own guest TSC. All must give
+ * the same nanosecond value (same instant, same clock), and must
+ * match what KVM_GET_CLOCK itself said.
+ */
+static void check_cross_vcpu_coherence(struct kvm_vm *vm,
+				       struct kvm_vcpu **vcpus,
+				       struct pvclock_vcpu_time_info *pvtis,
+				       const char *what)
+{
+	struct kvm_clock_data now = {};
+	u64 clk[NR_VCPUS];
+	int i;
+
+	vm_get_clock(vm, &now);
+	TEST_ASSERT(now.flags & KVM_CLOCK_HOST_TSC,
+		    "%s: master clock inactive with divergent TSC offsets",
+		    what);
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		struct kvm_vcpu_tsc_scale scale = {};
+		u64 ofs = vcpu_get_tsc_offset(vcpus[i]);
+		u64 guest_tsc;
+
+		vcpu_device_attr_get(vcpus[i], KVM_VCPU_TSC_CTRL,
+				     KVM_VCPU_TSC_SCALE, &scale);
+		guest_tsc = host_to_guest_tsc(&scale, ofs, now.host_tsc);
+		clk[i] = pvclock_read_cycles(&pvtis[i], guest_tsc);
+
+		TEST_ASSERT(!(pvtis[i].flags & PVCLOCK_TSC_STABLE_BIT),
+			    "%s: vCPU%d still advertises TSC_STABLE with divergent offsets",
+			    what, i);
+	}
+
+	for (i = 1; i < NR_VCPUS; i++) {
+		s64 d = (s64)(clk[i] - clk[0]);
+
+		pr_info("  %s: vCPU%d vs vCPU0 kvmclock delta %" PRId64 " ns\n",
+			what, i, d);
+		TEST_ASSERT(d >= -2 && d <= 2,
+			    "%s: vCPU%d kvmclock disagrees with vCPU0 by %" PRId64 " ns",
+			    what, i, d);
+	}
+
+	/* And all of them must agree with KVM_GET_CLOCK itself */
+	s64 d0 = (s64)(clk[0] - now.clock);
+	pr_info("  %s: vCPU0 pvclock vs KVM_GET_CLOCK delta %" PRId64 " ns\n",
+		what, d0);
+	TEST_ASSERT(d0 >= -2 && d0 <= 2,
+		    "%s: vCPU0 pvclock disagrees with KVM_GET_CLOCK by %" PRId64 " ns",
+		    what, d0);
+}
+
+int main(void)
+{
+	struct pvclock_vcpu_time_info pvti_src[NR_VCPUS];
+	struct pvclock_vcpu_time_info pvti_dst_ioctl[NR_VCPUS];
+	struct kvm_clock_data clock_src, clock_dst;
+	struct kvm_vcpu_tsc_scale scale_src[NR_VCPUS], scale_dst;
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	struct kvm_vm *vm;
+	u64 mono_before, kvm_before, kvm_after;
+	s64 delta_before;
+	u64 ofs_src[NR_VCPUS], tsc_src[NR_VCPUS], tsc_dst, raw_dst;
+	u64 ofs_dst[NR_VCPUS];
+	u64 host_tsc_src, host_tsc_dst;
+	u64 time_src, time_dst;
+	s64 delta_t;
+	u32 freq_khz = 1500000; /* 1.5 GHz — forces TSC scaling */
+	int i, pass;
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
+
+	/* === SOURCE SIDE === */
+	pr_info("=== Source VM ===\n");
+	vm = create_vm(vcpus, freq_khz);
+
+	/* Run each guest to enable its kvmclock */
+	for (i = 0; i < NR_VCPUS; i++)
+		run_to_sync(vcpus[i]);
+
+	/*
+	 * Apply divergent TSC offsets. Same frequency, different offsets:
+	 * this must no longer disable the master clock, but must clear
+	 * PVCLOCK_TSC_STABLE_BIT.
+	 */
+	for (i = 1; i < NR_VCPUS; i++)
+		vcpu_set_tsc_offset(vcpus[i],
+				    vcpu_get_tsc_offset(vcpus[i]) + tsc_deltas[i]);
+
+	/*
+	 * Re-run each vCPU twice. The offset writes leave a masterclock
+	 * update pending on vCPUs 1 and 2; the first pass processes it and
+	 * broadcasts KVM_REQ_CLOCK_UPDATE to every vCPU, and the second
+	 * pass has each vCPU rewrite its guest-visible pvclock page with
+	 * PVCLOCK_TSC_STABLE_BIT now clear. A single pass would leave
+	 * vCPU0's page stale: its rewrite happens before the broadcast.
+	 */
+	for (pass = 0; pass < 2; pass++)
+		for (i = 0; i < NR_VCPUS; i++)
+			run_to_sync(vcpus[i]);
+
+	/* Fetch each vCPU's pvti and verify cross-vCPU coherence */
+	for (i = 0; i < NR_VCPUS; i++)
+		vcpu_get_clock_guest(vcpus[i], &pvti_src[i]);
+	check_cross_vcpu_coherence(vm, vcpus, pvti_src, "source");
+
+	/* The guest-visible pvti pages must also show TSC_STABLE clear */
+	for (i = 0; i < NR_VCPUS; i++) {
+		struct pvclock_vcpu_time_info *pvti =
+			addr_gpa2hva(vm, KVMCLOCK_GPA + i * getpagesize());
+
+		TEST_ASSERT(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT),
+			    "vCPU%d guest pvti advertises TSC_STABLE with divergent offsets", i);
+	}
+
+	/* ABA measurement: kvmclock vs CLOCK_MONOTONIC_RAW */
+	u64 src_mono_lo, src_mono_hi;
+	aba_reading(vm, &src_mono_lo, &kvm_before, &src_mono_hi);
+	mono_before = (src_mono_lo + src_mono_hi) / 2;
+	delta_before = (s64)(kvm_before - mono_before);
+	pr_info("  kvmclock - MONOTONIC_RAW = %" PRId64 " ns (±%" PRIu64 " ns)\n",
+		delta_before, (src_mono_hi - src_mono_lo) / 2);
+
+	/* Step 1: KVM_GET_CLOCK for atomic {host_tsc, realtime} */
+	memset(&clock_src, 0, sizeof(clock_src));
+	clock_src.flags = KVM_CLOCK_REALTIME;
+	vm_get_clock(vm, &clock_src);
+	TEST_ASSERT(clock_src.flags & KVM_CLOCK_HOST_TSC,
+		    "KVM_GET_CLOCK did not provide host_tsc (no master clock?)");
+	host_tsc_src = clock_src.host_tsc;
+	time_src = clock_src.realtime;
+
+	/* Step 2: Save each vCPU's TSC offset and scale */
+	for (i = 0; i < NR_VCPUS; i++) {
+		ofs_src[i] = vcpu_get_tsc_offset(vcpus[i]);
+		memset(&scale_src[i], 0, sizeof(scale_src[i]));
+		vcpu_device_attr_get(vcpus[i], KVM_VCPU_TSC_CTRL,
+				     KVM_VCPU_TSC_SCALE, &scale_src[i]);
+
+		/* Compute this vCPU's guest TSC at Tsrc */
+		tsc_src[i] = host_to_guest_tsc(&scale_src[i], ofs_src[i],
+					       host_tsc_src);
+		pr_info("  vCPU%d: TSC freq=%u kHz, offset=%" PRId64 "\n",
+			i, freq_khz, (s64)ofs_src[i]);
+	}
+
+	/* Step 3: KVM_GET_CLOCK_GUEST (already fetched above as pvti_src[]) */
+
+	kvm_vm_release(vm);
+
+	/* === PAUSE (simulate migration) === */
+	pr_info("=== Pausing 1 second ===\n");
+	sleep(1);
+
+	/* === DESTINATION SIDE === */
+	pr_info("=== Destination VM ===\n");
+	/* Step 4: create + KVM_SET_TSC_KHZ (in create_vm) */
+	vm = create_vm(vcpus, freq_khz);
+
+	/* Step 5: KVM_GET_CLOCK for atomic {host_tsc, realtime} pair.
+	 * Master clock is active from VM creation.
+	 */
+	memset(&clock_dst, 0, sizeof(clock_dst));
+	vm_get_clock(vm, &clock_dst);
+	TEST_ASSERT(clock_dst.flags & KVM_CLOCK_HOST_TSC,
+		    "KVM_GET_CLOCK did not provide host_tsc (no master clock?)");
+	host_tsc_dst = clock_dst.host_tsc;
+	time_dst = clock_dst.realtime;
+
+	/* Step 6: ΔT */
+	delta_t = (s64)(time_dst - time_src);
+
+	/* Step 7: Compute and set each vCPU's destination offset */
+	memset(&scale_dst, 0, sizeof(scale_dst));
+	vcpu_device_attr_get(vcpus[0], KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_SCALE,
+			     &scale_dst);
+
+	if (scale_dst.tsc_frac_bits)
+		raw_dst = (unsigned __int128)host_tsc_dst * scale_dst.tsc_ratio
+			  >> scale_dst.tsc_frac_bits;
+	else
+		raw_dst = host_tsc_dst;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		tsc_dst = tsc_src[i] + (u64)((s64)freq_khz * delta_t / 1000000LL);
+		ofs_dst[i] = tsc_dst - raw_dst;
+		vcpu_set_tsc_offset(vcpus[i], ofs_dst[i]);
+	}
+
+	/*
+	 * The cross-vCPU TSC relationships must be preserved exactly:
+	 * every vCPU's offset moved by the same amount, so the deltas
+	 * between them are untouched by the CLOCK_REALTIME imprecision.
+	 */
+	for (i = 1; i < NR_VCPUS; i++) {
+		s64 src_delta = (s64)(ofs_src[i] - ofs_src[0]);
+		s64 dst_delta = (s64)(ofs_dst[i] - ofs_dst[0]);
+
+		pr_info("  vCPU%d-vCPU0 TSC delta: src %" PRId64
+			", dst %" PRId64 " cycles\n", i, src_delta, dst_delta);
+		TEST_ASSERT(src_delta == dst_delta,
+			    "vCPU%d TSC delta not preserved: %" PRId64 " -> %" PRId64,
+			    i, src_delta, dst_delta);
+	}
+
+	/*
+	 * The TSC offset delta introduced by using CLOCK_REALTIME to
+	 * estimate elapsed time. On same host, the correct offset is
+	 * ofs_src; the difference is the CLOCK_REALTIME-vs-TSC error.
+	 */
+	s64 tsc_ofs_delta = (s64)(ofs_dst[0] - ofs_src[0]);
+	s64 tsc_ofs_delta_ns = tsc_ofs_delta * 1000000LL / freq_khz;
+	pr_info("  Destination TSC offset=%" PRId64
+		", imprecision from CLOCK_REALTIME: %" PRId64 " cycles = %"
+		PRId64 " ns\n", (s64)ofs_dst[0], tsc_ofs_delta, tsc_ofs_delta_ns);
+
+	/*
+	 * Step 8: KVM_SET_CLOCK_GUEST — once, via vCPU0. The other
+	 * vCPUs' clocks must come out right too: the KVM clock is
+	 * VM-wide, and each vCPU's pvti relates it to that vCPU's
+	 * own TSC.
+	 */
+	vcpu_set_clock_guest(vcpus[0], &pvti_src[0]);
+
+	/* Run each guest to write its pvclock page on the destination */
+	for (i = 0; i < NR_VCPUS; i++)
+		run_to_sync(vcpus[i]);
+
+	/* Verify cross-vCPU coherence on the destination */
+	for (i = 0; i < NR_VCPUS; i++)
+		vcpu_get_clock_guest(vcpus[i], &pvti_dst_ioctl[i]);
+	check_cross_vcpu_coherence(vm, vcpus, pvti_dst_ioctl, "dest");
+
+	/* ABA measurement on destination */
+	u64 mono_lo, mono_hi;
+	aba_reading(vm, &mono_lo, &kvm_after, &mono_hi);
+
+	/*
+	 * The kvmclock is tied to the guest TSC via SET_CLOCK_GUEST.
+	 * The guest TSC is offset from the correct value by tsc_ofs_delta_ns
+	 * (due to CLOCK_REALTIME imprecision). So the kvmclock should be
+	 * offset from CLOCK_MONOTONIC_RAW by exactly:
+	 *   (original delta) + tsc_ofs_delta_ns
+	 *
+	 * The "original delta" has uncertainty from the source ABA spread,
+	 * and the measurement has uncertainty from the destination ABA spread.
+	 * Verify the expected value falls within the combined bounds.
+	 */
+	s64 delta_before_lo = (s64)(kvm_before - src_mono_hi);
+	s64 delta_before_hi = (s64)(kvm_before - src_mono_lo);
+	s64 expected_lo = delta_before_lo + tsc_ofs_delta_ns;
+	s64 expected_hi = delta_before_hi + tsc_ofs_delta_ns;
+	s64 actual_lo = (s64)(kvm_after - mono_hi);
+	s64 actual_hi = (s64)(kvm_after - mono_lo);
+
+	/* Show the shift relative to the source measurement */
+	s64 expected_mid = tsc_ofs_delta_ns;
+	s64 expected_err = (s64)(src_mono_hi - src_mono_lo) / 2;
+	s64 actual_mid = ((actual_lo + actual_hi) / 2) - delta_before;
+	s64 actual_err = (s64)(mono_hi - mono_lo) / 2;
+	pr_info("  kvmclock-mono shift: expected %" PRId64 " ns (±%" PRId64
+		"), measured %" PRId64 " ns (±%" PRId64 ")\n",
+		expected_mid, expected_err, actual_mid, actual_err);
+
+	/* The ranges must overlap */
+	TEST_ASSERT(expected_hi >= actual_lo && expected_lo <= actual_hi,
+		    "Ranges don't overlap: expected [%" PRId64 ", %" PRId64
+		    "] measured [%" PRId64 ", %" PRId64 "]",
+		    expected_lo, expected_hi, actual_lo, actual_hi);
+
+	/*
+	 * Direct pvclock verification: read each destination pvclock page
+	 * (as written for the guest) and verify that computing kvmclock
+	 * from the source pvti and the destination pvti at the same
+	 * instant gives the same result, for every vCPU.
+	 *
+	 * Get one atomic {host_tsc, kvmclock} pair, derive each vCPU's
+	 * guest TSC at that instant, then compute kvmclock from both
+	 * pvclock structs. The source pvti evaluates at the *migrated*
+	 * guest TSC, i.e. shifted by the CLOCK_REALTIME imprecision that
+	 * was baked into the offsets — which is exactly what "the clock
+	 * follows the TSC" means.
+	 */
+	struct kvm_clock_data clock_now = {};
+	vm_get_clock(vm, &clock_now);
+	pr_info("  KVM_GET_CLOCK:  %" PRIu64 " ns\n", (u64)clock_now.clock);
+
+	u64 host_tsc_now = clock_now.host_tsc;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		struct pvclock_vcpu_time_info *pvti_page =
+			addr_gpa2hva(vm, KVMCLOCK_GPA + i * getpagesize());
+		u64 guest_tsc_now = host_to_guest_tsc(&scale_dst, ofs_dst[i],
+						      host_tsc_now);
+		u64 clk_from_src = pvclock_read_cycles(&pvti_src[i],
+						       guest_tsc_now);
+		u64 clk_from_dst = pvclock_read_cycles(pvti_page,
+						       guest_tsc_now);
+		s64 pvclock_delta = (s64)(clk_from_src - clk_from_dst);
+
+		pr_info("  vCPU%d pvclock direct: src=%" PRIu64 " dst=%" PRIu64
+			" delta=%" PRId64 " ns\n", i, clk_from_src,
+			clk_from_dst, pvclock_delta);
+
+		TEST_ASSERT(pvclock_delta >= -2 && pvclock_delta <= 2,
+			    "vCPU%d pvclock src vs dst disagree by %" PRId64 " ns",
+			    i, pvclock_delta);
+	}
+
+	/*
+	 * Tight ABA: compare pvclock_read() directly (no ioctl) against
+	 * CLOCK_MONOTONIC_RAW. The spread should be much smaller since
+	 * there's no syscall between the two clock_gettime calls — just
+	 * rdtsc + userspace mul/shift.
+	 */
+	struct pvclock_vcpu_time_info *pvti0 = addr_gpa2hva(vm, KVMCLOCK_GPA);
+	u64 tight_mono_lo = 0, tight_mono_hi = 0, tight_kvm = 0;
+	u64 tight_best_spread = UINT64_MAX;
+	for (i = 0; i < 3; i++) {
+		struct timespec ts1, ts2;
+		u64 m1, m2, tsc, clk;
+
+		clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
+		tsc = rdtsc();
+		clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
+
+		m1 = ts1.tv_sec * 1000000000ULL + ts1.tv_nsec;
+		m2 = ts2.tv_sec * 1000000000ULL + ts2.tv_nsec;
+
+		/* Scale host TSC to vCPU0's guest TSC */
+		tsc = host_to_guest_tsc(&scale_dst, ofs_dst[0], tsc);
+
+		clk = pvclock_read_cycles(pvti0, tsc);
+
+		if (m2 - m1 < tight_best_spread) {
+			tight_best_spread = m2 - m1;
+			tight_mono_lo = m1;
+			tight_mono_hi = m2;
+			tight_kvm = clk;
+		}
+	}
+	pr_info("  Tight ABA spread: %" PRIu64 " ns (best of 3)\n", tight_best_spread);
+
+	s64 tight_expected_lo = delta_before_lo + tsc_ofs_delta_ns;
+	s64 tight_expected_hi = delta_before_hi + tsc_ofs_delta_ns;
+	s64 tight_actual_lo = (s64)(tight_kvm - tight_mono_hi);
+	s64 tight_actual_hi = (s64)(tight_kvm - tight_mono_lo);
+	s64 tight_actual_mid = ((tight_actual_lo + tight_actual_hi) / 2) - delta_before;
+	s64 tight_actual_err = (s64)(tight_mono_hi - tight_mono_lo) / 2;
+
+	pr_info("  Tight kvmclock-mono shift: expected %" PRId64
+		" ns (±%" PRId64 "), measured %" PRId64 " ns (±%" PRId64 ")\n",
+		expected_mid, expected_err, tight_actual_mid, tight_actual_err);
+
+	TEST_ASSERT(tight_expected_hi >= tight_actual_lo &&
+		    tight_expected_lo <= tight_actual_hi,
+		    "Tight ABA ranges don't overlap");
+
+	kvm_vm_release(vm);
+	pr_info("PASS: kvmclock offset matches TSC delta from CLOCK_REALTIME"
+		" (%" PRId64 " ns) within ABA bounds\n", tsc_ofs_delta_ns);
+	return 0;
+}
-- 
2.43.0

