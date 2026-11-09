Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187280;
	b=bGyUfvZ4kwpdLFJUKNU7K0LFZp5OWqV7wh9RlfFAXmgrUcef8jpNgegdSJ+gaWxn2Qq1
	 2NOaMrWReESHD+iLxQpAgF13vD/shR5sAQDoECEnjFreSOqL96y2FZKxGgGJe7X5Cnlq2
	 2Jv4s7+Py0d/uK05+9tZrThvXe+G7Lx+uc2ToF2t22AFcqr48q2ctC9FVmsZlR3UxsYt+
	 8PdUNaayMJPZIkLBcKG/c2dGMUvI/qAxwgwANvVpI6N2nU4BO3UiM51m63qsks6qExxhY
	 ud0U4LprYbtn8fMNFodBplsFxW7Kg8GbePMpsZbHVE/Np7ypogwB6DKmd/nDUtXBXhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=9xDfu8Ojz205IpnlCE1EQapOMUr1A9VRl7iiM94PLJk=;
	b=BukwoqTW2woa8w0pqnP0gJ1z/a9C6dr+2ZbuMcTzx03IA5SQNtYchqwZUfi1eWqZ5KHB
	 Drcfy4khBKeC+sjEhZ//pYVKwAUwL4I6+l90vobGW9lGyTjtVHpvPIolxMcbxd2jJmN1h
	 9cU8zWI1r3g7M3IIbHsv5DhG1KAsSTBU28ufSo5jKwD0sWlBZIbQX18AUWSH0hO3WU5Fb
	 wlnIHt2X1t0mKuBFYlvmhcl36Yf03s0UWLhmNgsrhpASkutYOg28BYSraUfhhTLJ8Zvmh
	 eh5uX9pcct9kHSwMv5q5kLeWSBs99ZUw4dPwNGpd9YqcgAtv0IjTwyXqvXZhwZE0jwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pjAb4njA;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136F606A321;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7136F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pjAb4njA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=9xDfu8Ojz205IpnlCE1EQapOMUr1A9VRl7iiM94PLJk=; b=pjAb4njAzYV4ChfITlxraQAAEe
	UmaqXTAdDNDRuGYwR+oUOPp1YQhHWS0R6skFXJRbAIhMhd6nwYAVjxOLuCnxgHhRIgJsfjqWut16r
	9So/ig6i7x1GgpDvs+paMb7F5lGvhazmtb/8znDz26Hj8MsttuXX1c/ygMJX6lanwnQQRE/lGHIqx
	F+sTqJ47ZiLtjbOZ5dEKgq6IqYUcvYNHO94CuUb0NbtA7hpdprMPtS0+UBw6U1M9K8xMs8/tgcVPS
	6JdbuRaN6LGRp2pxyIBj1n6ebU4KOfBzCXrYy/Y3CuehlrRuLsKb2IPTRJ7sxb1GdWD2P4pvwOgbr
	XQsUWbqg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4P-00000007Pw6-0wab;
	Mon, 09 Nov 2026 01:21:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKUx-0Bmc;
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
Subject: [PATCH v12 14/24] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
Date: Sun,  8 Nov 2026 17:21:00 -0800
Message-ID: <20261109012112.3415328-15-dwmw2@infradead.org>
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

From: Jack Allister <jalliste@amazon.com>

In the common case (where kvm->arch.use_master_clock is true), the KVM
clock is defined as a simple arithmetic function of the guest TSC, based
on a reference point stored in kvm->arch.master_kernel_ns and
kvm->arch.master_cycle_now.

The existing KVM_[GS]ET_CLOCK functionality does not allow for this
relationship to be precisely saved and restored by userspace. All it can
currently do is set the KVM clock at a given UTC reference time, which
is necessarily imprecise.

So on live update, the guest TSC can remain cycle accurate at precisely
the same offset from the host TSC, but there is no way for userspace to
restore the KVM clock accurately.

Even on live migration to a new host, where the accuracy of the guest
time-keeping is fundamentally limited by the accuracy of wallclock
synchronization between the source and destination hosts, the clock jump
experienced by the guest's TSC and its KVM clock should at least be
*consistent*. Even when the guest TSC suffers a discontinuity, its KVM
clock should still remain the *same* arithmetic function of the guest
TSC, and not suffer an *additional* discontinuity.

To allow for accurate migration of the KVM clock, add per-vCPU ioctls
which save and restore the actual PV clock info in
pvclock_vcpu_time_info.

The restoration in KVM_SET_CLOCK_GUEST works by creating a new reference
point in time just as kvm_update_masterclock() does, and calculating the
corresponding guest TSC value. This guest TSC value is then passed
through the user-provided pvclock structure to generate the *intended*
KVM clock value at that point in time, and through the *actual* KVM
clock calculation. Then kvm->arch.kvmclock_offset is adjusted to
eliminate the difference.

Where kvm->arch.use_master_clock is false (because the host TSC is
unreliable, or the guest TSCs are configured strangely), the KVM clock
is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
returns an error. In this case, as documented, userspace shall use the
legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
case since the clocks are imprecise in this mode anyway.

On *restoration*, if kvm->arch.use_master_clock is false, an error is
returned for similar reasons and userspace shall fall back to using
KVM_SET_CLOCK. This does mean that, as documented, userspace needs to
use *both* KVM_GET_CLOCK_GUEST and KVM_GET_CLOCK and send both results
with the migration data (unless the intent is to refuse to resume on a
host with bad TSC).

Both ioctls return -ENODATA when the KVM clock is not in master clock
mode. That covers the case of an unknown TSC frequency on the current
CPU (possible only on hosts without CONSTANT_TSC): the masterclock
update performed under the same IRQs-off critical section disables
master clock mode when the frequency reads as zero. Advertise the
ioctls with KVM_CAP_CLOCK_GUEST so that userspace need not probe for
them.

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Jack Allister <jalliste@amazon.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/virt/kvm/api.rst  |  53 +++++++++
 arch/x86/include/uapi/asm/kvm.h |   1 +
 arch/x86/kvm/x86.c              | 202 ++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h        |   4 +
 4 files changed, 260 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 9487afc4431f..44c6152c5768 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6767,6 +6767,59 @@ if the guest_memfd memory was pinned in IOMMU page tables.
 
 See also: :ref:`KVM_SET_MEMORY_ATTRIBUTES`.
 
+4.147 KVM_GET_CLOCK_GUEST
+----------------------------
+
+:Capability: KVM_CAP_CLOCK_GUEST
+:Architectures: x86_64
+:Type: vcpu ioctl
+:Parameters: struct pvclock_vcpu_time_info (out)
+:Returns: 0 on success, <0 on error
+
+Retrieves the current time information structure used for KVM/PV clocks,
+in precisely the form advertised to the guest vCPU, which gives parameters
+for a direct conversion from a guest TSC value to nanoseconds.
+
+The structure is in terms of the given vCPU's TSC. It must be passed back
+to KVM_SET_CLOCK_GUEST on the *same* vCPU (on the destination VM, for
+migration); vCPUs may legitimately have different TSC offsets, which would
+otherwise be silently folded into the restored KVM clock.
+
+When the KVM clock is not in "master clock" mode, for example because the
+host TSC is unreliable or the guest TSCs are oddly configured, the KVM clock
+is actually defined by the host CLOCK_MONOTONIC_RAW instead of the guest TSC.
+In this case, the KVM_GET_CLOCK_GUEST ioctl returns -ENODATA.
+
+4.148 KVM_SET_CLOCK_GUEST
+----------------------------
+
+:Capability: KVM_CAP_CLOCK_GUEST
+:Architectures: x86_64
+:Type: vcpu ioctl
+:Parameters: struct pvclock_vcpu_time_info (in)
+:Returns: 0 on success, <0 on error
+
+Sets the KVM clock (for the whole VM) in terms of the vCPU TSC, using the
+pvclock structure as returned by KVM_GET_CLOCK_GUEST. This allows the precise
+arithmetic relationship between guest TSC and KVM clock to be preserved by
+userspace across migration.
+
+When the KVM clock is not in "master clock" mode, and the KVM clock is actually
+defined by the host CLOCK_MONOTONIC_RAW, this ioctl returns -ENODATA. Userspace
+may choose to set the clock using the less precise KVM_SET_CLOCK ioctl, or may
+choose to fail, denying migration to a host whose TSC is misbehaving. A host
+whose CPU TSC frequency is unknown (only possible without
+X86_FEATURE_CONSTANT_TSC) is never in "master clock" mode, so it also returns
+-ENODATA.
+
+If the mul/shift fields of the provided pvclock structure encode a TSC
+frequency inconsistent with the vCPU's actual TSC frequency, this ioctl
+returns -ERANGE.
+
+If the vCPU's current TSC is behind the tsc_timestamp in the provided
+structure, this ioctl returns -EINVAL. Restore the guest TSC (which the
+documented migration procedure keeps monotonic) before invoking it.
+
 .. _kvm_run:
 
 5. The kvm_run structure
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1585ec804066..9e3cdc3adb65 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 #include <linux/stddef.h>
+#include <asm/pvclock-abi.h>
 
 #define KVM_PIO_PAGE_OFFSET 1
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 2
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4afafe7ed8b8..00e6b2bdaffb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2542,6 +2542,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
 	case KVM_CAP_ONE_REG:
+#ifdef CONFIG_X86_64
+	case KVM_CAP_CLOCK_GUEST:
+#endif
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -3674,6 +3677,197 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	}
 }
 
+#ifdef CONFIG_X86_64
+static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info hv_clock = {};
+	struct kvm_arch *ka = &v->kvm->arch;
+	bool use_master_clock;
+	unsigned int seq;
+
+	/*
+	 * Construct the pvclock purely from the master clock state. The
+	 * master mul/shift are computed for the guest TSC frequency, which
+	 * in master clock mode is the frequency of every vCPU; only the
+	 * tsc_timestamp is per-vCPU, translating the master snapshot into
+	 * this vCPU's TSC domain via its scaling ratio and offset.
+	 *
+	 * Note, this deliberately does NOT invoke kvm_guest_time_update(),
+	 * which would write the guest's pvclock pages: dirtying guest
+	 * memory after the final KVM_RUN would break post-copy migration
+	 * flows. The pvclock returned here describes the same clock as the
+	 * guest-visible copy (the same linear function of the guest TSC),
+	 * anchored at the current master clock snapshot.
+	 *
+	 * Translating the snapshot through the vCPU's *current* scaling
+	 * ratio and offset is correct even if they changed after the
+	 * snapshot was taken: the snapshot anchors a host TSC value, not
+	 * a guest one. A frequency change whose masterclock update is
+	 * still pending does leave stale mul/shift here, but that is the
+	 * paused-VM migration path reading a frequency userspace itself
+	 * has just changed — and the result fails safe, as the same-vCPU
+	 * KVM_SET_CLOCK_GUEST on the destination rejects a mul/shift
+	 * inconsistent with the vCPU's frequency with -ERANGE.
+	 */
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
+
+		use_master_clock = ka->use_master_clock;
+		if (!use_master_clock)
+			continue;
+
+		hv_clock.tsc_timestamp = kvm_read_l1_tsc(v, ka->master_cycle_now);
+		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+		hv_clock.tsc_shift = ka->master_tsc_shift;
+		hv_clock.tsc_to_system_mul = ka->master_tsc_mul;
+		hv_clock.flags = READ_ONCE(ka->all_vcpus_matched_tsc) ?
+				 PVCLOCK_TSC_STABLE_BIT : 0;
+	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+
+	if (!use_master_clock)
+		return -ENODATA;
+
+	if (copy_to_user(argp, &hv_clock, sizeof(hv_clock)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Reverse the calculation in the hv_clock definition.
+ *
+ * time_ns = ( (cycles << shift) * mul ) >> 32;
+ * (although shift can be negative, so that's bad C)
+ *
+ * So for a single second,
+ * NSEC_PER_SEC = ( ( FREQ_HZ << shift) * mul ) >> 32
+ * NSEC_PER_SEC << 32 = ( FREQ_HZ << shift ) * mul
+ * ( NSEC_PER_SEC << 32 ) / mul = FREQ_HZ << shift
+ * ( NSEC_PER_SEC << 32 ) / mul ) >> shift = FREQ_HZ
+ */
+static u64 hvclock_to_hz(u32 mul, s8 shift)
+{
+	u64 tm = NSEC_PER_SEC << 32;
+
+	/* Maximise precision. Shift left until the top bit is set */
+	tm <<= 2;
+	shift += 2;
+
+	/* While 'mul' is even, increase the shift *after* the division */
+	while (!(mul & 1)) {
+		shift++;
+		mul >>= 1;
+	}
+
+	tm /= mul;
+
+	if (shift >= 64)
+		return 0;
+	if (shift > 0)
+		return tm >> shift;
+
+	/*
+	 * A left shift can overflow for absurd user-supplied mul/shift
+	 * combinations; saturate (to a value which cannot itself overflow
+	 * the rounding in the caller's kHz conversion) so the frequency
+	 * check certainly rejects them.
+	 */
+	if (shift <= -64 || tm > (U64_MAX >> 1) >> -shift)
+		return U64_MAX >> 1;
+	return tm << -shift;
+}
+
+static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info user_hv_clock;
+	struct kvm *kvm = v->kvm;
+	struct kvm_arch *ka = &kvm->arch;
+	u64 curr_tsc_hz, user_tsc_hz;
+	u64 curr_tsc_khz, user_tsc_khz;
+	u64 user_clk_ns;
+	u64 guest_tsc;
+	int rc = 0;
+
+	if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
+		return -EFAULT;
+
+	if (user_hv_clock.pad0 || user_hv_clock.pad[0] || user_hv_clock.pad[1])
+		return -EINVAL;
+
+	if (!user_hv_clock.tsc_to_system_mul)
+		return -EINVAL;
+
+	if (user_hv_clock.tsc_shift < -31 || user_hv_clock.tsc_shift > 31)
+		return -EINVAL;
+
+	user_tsc_hz = hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
+				    user_hv_clock.tsc_shift);
+
+	kvm_hv_request_tsc_page_update(kvm);
+
+	/*
+	 * kvm_start_pvclock_update() takes tsc_write_lock and opens
+	 * the pvclock seqcount; kvm_end_pvclock_update() closes both.
+	 * All clock state modifications between them are atomic with
+	 * respect to readers in kvm_guest_time_update().
+	 */
+	kvm_start_pvclock_update(kvm);
+	pvclock_update_vm_gtod_copy(kvm);
+
+	if (!ka->use_master_clock) {
+		rc = -ENODATA;
+		goto out;
+	}
+
+	/*
+	 * Nonzero, or pvclock_update_vm_gtod_copy() — which read it on
+	 * this CPU, with interrupts still disabled — would have cleared
+	 * use_master_clock above.
+	 */
+	curr_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+
+	if (kvm_caps.has_tsc_control)
+		curr_tsc_hz = kvm_scale_tsc(curr_tsc_hz,
+					    v->arch.l1_tsc_scaling_ratio);
+
+	/*
+	 * The mul/shift in the provided pvclock structure encode the guest
+	 * TSC frequency at which it was generated. Sanity-check that it is
+	 * consistent with this vCPU's effective TSC frequency, allowing a
+	 * discrepancy of 1 kHz either way since independently calibrated
+	 * hosts will not measure precisely the same value even for the
+	 * same nominal frequency. Compare in kHz: the reconstruction of
+	 * each side's frequency in Hz carries a few Hz of rounding, which
+	 * must not push two hosts calibrated exactly 1 kHz apart over the
+	 * line.
+	 */
+	user_tsc_khz = DIV_ROUND_CLOSEST_ULL(user_tsc_hz, HZ_PER_KHZ);
+	curr_tsc_khz = DIV_ROUND_CLOSEST_ULL(curr_tsc_hz, HZ_PER_KHZ);
+	if (user_tsc_khz + 1 < curr_tsc_khz ||
+	    user_tsc_khz > curr_tsc_khz + 1) {
+		rc = -ERANGE;
+		goto out;
+	}
+
+	/*
+	 * Calculate the guest TSC at the new reference point, and the
+	 * corresponding KVM clock value according to user_hv_clock.
+	 * Adjust kvmclock_offset so both definitions agree.
+	 */
+	guest_tsc = kvm_read_l1_tsc(v, ka->master_cycle_now);
+	if ((s64)(guest_tsc - user_hv_clock.tsc_timestamp) < 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+	user_clk_ns = __pvclock_read_cycles(&user_hv_clock, guest_tsc);
+	ka->kvmclock_offset = user_clk_ns - ka->master_kernel_ns;
+
+out:
+	kvm_end_pvclock_update(kvm);
+	return rc;
+}
+#endif
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -4067,6 +4261,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
+#ifdef CONFIG_X86_64
+	case KVM_SET_CLOCK_GUEST:
+		r = kvm_vcpu_ioctl_set_clock_guest(vcpu, argp);
+		break;
+	case KVM_GET_CLOCK_GUEST:
+		r = kvm_vcpu_ioctl_get_clock_guest(vcpu, argp);
+		break;
+#endif
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_GET_SUPPORTED_HV_CPUID:
 		r = kvm_ioctl_get_supported_hv_cpuid(vcpu, argp);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e..1349387cceb0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_CLOCK_GUEST 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1690,4 +1691,7 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_SET_CLOCK_GUEST	_IOW(KVMIO, 0xd6, struct pvclock_vcpu_time_info)
+#define KVM_GET_CLOCK_GUEST	_IOR(KVMIO, 0xd7, struct pvclock_vcpu_time_info)
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

