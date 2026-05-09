Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C73D7D90;
	Sat,  9 May 2026 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366935; cv=none; b=TJI2ROzl2Akz656wLEqxiRaWH8lrmCtG/SLsWUEVtY1EqDtXvvNyZnNKF/jaLmFPKhOc+SojPhS9njsP4FKVgpu3mGNv45l9T3nteBTG66Y2uMtLeIN2k9FqecpjkLYcxClLDml4tK0tduFV8b7Or0YLYq3AnTLxEgto/gz6xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366935; c=relaxed/simple;
	bh=/WZVVMtvkpnGBJPuNTi3Cc48zJr0m8SppsDKAxrcaAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB6gA8yxuk8BM6uykhMAxZk6MrZap2519qBPkL8PxleXBN5F1zgvbX9MNbh7rR+r5iggmtsxU2rJPqlFBZMCvSVyIy2a63ZTNeYHBlZrm6inOHTf2raxmCzn/8XHo2QdGU6LGJ/W7oWuLDPw7C3MVAFollc+ZVKNbuhaIrg/2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DoOTPUu0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DoOTPUu0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=QaE/jvGdpKCrMu7vuBQqqJqP5vWDROke7W8G0eRZk4g=; b=DoOTPUu0tDOpDhNUD5GD3VymGC
	agkMnNVNF3tXlzjfcJ3f8fgMLH0TVNE6lTDA+SmaBZpdndkRQvdUfYpNNQUjYo4h9pmFg1ghTy6JK
	TJTD6SNzc2p9xzSd92A3Nod6poc4y3RYpG6snRh5AMmLjSitEoxCD9SnH0EZvrtQ4BiPzgnLMFjUy
	usxXQCvIHAmTY5b1qUnWerxbab01zCu1M4crES3M4j2BRAHhvBHu1n2xa4oyoj0CIviPuT/Ak90um
	Wp9wF78NVSSs0glwlOn0E3FZMCPVRqMhutT0hqOqdevTMtFNPl2n/xRBHkhARcz3GtW5FPLogwoms
	3soFmUOA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTC-000000060L9-2Pfv;
	Sat, 09 May 2026 22:48:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhHV-0c3b;
	Sat, 09 May 2026 23:48:26 +0100
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
Subject: [PATCH v4 04/30] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
Date: Sat,  9 May 2026 23:46:30 +0100
Message-ID: <20260509224824.3264567-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Jack Allister <jalliste@amazon.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/virt/kvm/api.rst |  37 ++++++++
 arch/x86/kvm/x86.c             | 151 +++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |   3 +
 3 files changed, 191 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..2268b4442df6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6553,6 +6553,43 @@ KVM_S390_KEYOP_SSKE
   Sets the storage key for the guest address ``guest_addr`` to the key
   specified in ``key``, returning the previous value in ``key``.
 
+4.145 KVM_GET_CLOCK_GUEST
+----------------------------
+
+:Capability: none
+:Architectures: x86_64
+:Type: vcpu ioctl
+:Parameters: struct pvclock_vcpu_time_info (out)
+:Returns: 0 on success, <0 on error
+
+Retrieves the current time information structure used for KVM/PV clocks,
+in precisely the form advertised to the guest vCPU, which gives parameters
+for a direct conversion from a guest TSC value to nanoseconds.
+
+When the KVM clock is not in "master clock" mode, for example because the
+host TSC is unreliable or the guest TSCs are oddly configured, the KVM clock
+is actually defined by the host CLOCK_MONOTONIC_RAW instead of the guest TSC.
+In this case, the KVM_GET_CLOCK_GUEST ioctl returns -EINVAL.
+
+4.146 KVM_SET_CLOCK_GUEST
+----------------------------
+
+:Capability: none
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
+defined by the host CLOCK_MONOTONIC_RAW, this ioctl returns -EINVAL. Userspace
+may choose to set the clock using the less precise KVM_SET_CLOCK ioctl, or may
+choose to fail, denying migration to a host whose TSC is misbehaving.
+
 .. _kvm_run:
 
 5. The kvm_run structure
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9ef165df6a1..d1327d5fba3f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6205,6 +6205,149 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
+static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info hv_clock = {};
+	struct kvm_vcpu_arch *vcpu = &v->arch;
+	struct kvm_arch *ka = &v->kvm->arch;
+	unsigned int seq;
+
+	/*
+	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the pvclock
+	 * has never been generated at all, call kvm_guest_time_update().
+	 */
+	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) || !vcpu->hw_tsc_hz) {
+		int idx = srcu_read_lock(&v->kvm->srcu);
+		int ret = kvm_guest_time_update(v);
+
+		srcu_read_unlock(&v->kvm->srcu, idx);
+		if (ret)
+			return -EINVAL;
+	}
+
+	/*
+	 * Reconstruct the pvclock from the master clock state, matching
+	 * exactly what kvm_guest_time_update() writes to the guest.
+	 */
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
+
+		if (!ka->use_master_clock)
+			return -EINVAL;
+
+		hv_clock.tsc_timestamp = kvm_read_l1_tsc(v, ka->master_cycle_now);
+		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+
+	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
+	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
+	hv_clock.flags = PVCLOCK_TSC_STABLE_BIT;
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
+	/* Maximise precision. Shift right until the top bit is set */
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
+	if (shift > 0)
+		return tm >> shift;
+	else
+		return tm << -shift;
+}
+
+static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info user_hv_clock;
+	struct kvm *kvm = v->kvm;
+	struct kvm_arch *ka = &kvm->arch;
+	u64 curr_tsc_hz, user_tsc_hz;
+	u64 user_clk_ns;
+	u64 guest_tsc;
+	int rc = 0;
+
+	if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
+		return -EFAULT;
+
+	if (!user_hv_clock.tsc_to_system_mul)
+		return -EINVAL;
+
+	user_tsc_hz = hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
+				    user_hv_clock.tsc_shift);
+
+	kvm_hv_request_tsc_page_update(kvm);
+	kvm_start_pvclock_update(kvm);
+	pvclock_update_vm_gtod_copy(kvm);
+
+	if (!ka->use_master_clock) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	curr_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
+	if (unlikely(curr_tsc_hz == 0)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (kvm_caps.has_tsc_control)
+		curr_tsc_hz = kvm_scale_tsc(curr_tsc_hz,
+					    v->arch.l1_tsc_scaling_ratio);
+
+	/*
+	 * Allow for a discrepancy of 1 kHz either way between the TSC
+	 * frequency used to generate the user's pvclock and the current
+	 * host's measured frequency, since they may not precisely match.
+	 */
+	if (user_tsc_hz < curr_tsc_hz - 1000 ||
+	    user_tsc_hz > curr_tsc_hz + 1000) {
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
@@ -6605,6 +6748,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
index 6c8afa2047bf..9b50191b859c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1669,4 +1669,7 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_SET_CLOCK_GUEST	_IOW(KVMIO, 0xd6, struct pvclock_vcpu_time_info)
+#define KVM_GET_CLOCK_GUEST	_IOR(KVMIO, 0xd7, struct pvclock_vcpu_time_info)
+
 #endif /* __LINUX_KVM_H */
-- 
2.51.0

