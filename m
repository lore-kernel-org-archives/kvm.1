Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863928;
	b=3RTfzw15mXy0DuK9HkK9jUSuSljUzJhXEcmnNnxaORuGqU2WeehRmxEMm4RRQNDcvzCz
	 P9sp+lBL7tvZS5HSYqj3z9TNSCP9OSBLyljP/kYwf0ZypQloYtXxkF959m8e0oxomWcWQ
	 T9HwqRCusxHtS7YMU0qcGKeGivYNrZsPp0GoWoQa5d7Oap2vZHzarZXAqBOQeKmD7Nfe4
	 A1fxA+TdeK1w3WLGQJmZlpDYBLSDts1xiZTjILT5DMnisJEyPqQZivvr7DmUJHbELIDPj
	 UgrEq3BiIUsnDhHFg0pICa0q9xRsQS+U1cRUW2WtLSu/kHAezDhOr50liksGacgLEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YPntnK5/sTqgJzzmr8vORbmE7z2ohaOAG1bhPVxZBnc=;
	b=ZLCxI3ioM/vHH0vn0TrfVzOC4RVC14xmZI5e1QyZ+4MUZNsUTsIxQ6q+0wXBXlmpep33
	 bwzBlrt2AVUHqp7X/Yg21Dt8Jg8nO8BOF9PeUQ++WICp2+WmZAuO/yFifq4vvgCwno9Zq
	 q1DIikuLNAvo89O1aFF4gxnl34UhcuNcfCQvtlg2IG6sAGuXove6ZcUWYJHS+0R8JJRfS
	 VyC8xa3vVPBAVfXWejecg5hY2y7K+vM1bq8FLYDfEVZx24dK1/kjcoFuTyNUC8PSPzCQ7
	 ziEztv/Pp4Uy+riCUjJ5nKiErqa//v/hK33bCS5naMwGcn490p8qPJRxQJwPY0O/5Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZV55JokN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B6606A31A;
	Sat, 24 Oct 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZV55JokN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC561F01825;
	Sat, 24 Oct 2026 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863927;
	bh=YPntnK5/sTqgJzzmr8vORbmE7z2ohaOAG1bhPVxZBnc=;
	h=From:To:Cc:Subject:Date;
	b=ZV55JokN4t9sQ+Hr+sbHPsm6P7K7HBgl60hdmptGKYcK4lRWi05GrdE8tA6WHmfiB
	 DmjRmD2WCUpa9oVbmejv8c2Bv3etcx3xmBlcA7dMYG3fUeYh8QSKdehHI2Ag/Vq+y7
	 ss6YEmMm3YUxnEhJf0qkTvrD0MkS4O51jwT9PLqoLXM+SPrik7TgRMCUksJF78gwnu
	 3mqFGeLLOESD6iWHBSUsVffCd2BZc0kUwNTPama3loAW7NyjFJIAiptXAqCX41/XFW
	 LP4nUnIgoPjfxRzXx/hEEmt5cQF/UyivAswrSu0uXEL/X4Tyg4LvC+HNr2wZyKmDUB
	 fe3hKVDSC2pEg==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Compute the max guest TSC frequency from the current tsc_khz
Date: Sat, 24 Oct 2026 13:45:25 -0400
Message-ID: <20261024174525.1218244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

KVM computes the highest frequency that KVM_SET_TSC_KHZ accepts once,
during vendor init, from the tsc_khz of the time. When KVM is built in,
that runs before tsc_refine_calibration_work() refines tsc_khz, about a
second later. If refinement raises tsc_khz, the cap stays below what the
maximum scaling ratio gives for the refined frequency, and
KVM_SET_TSC_KHZ rejects frequencies that set_tsc_khz() would accept, as
set_tsc_khz() computes the ratio from the current tsc_khz.

nested_tsc_scaling_test runs into this on AMD: its last case asks for
the frequency KVM_GET_TSC_KHZ reports times SVM's maximum ratio, and gets
-EINVAL on boots where refinement raised tsc_khz. KernelCI sees it
intermittently on a DL345 Gen11 (EPYC). On Intel the cap is limited to
INT_MAX, so the test does not hit it there.

Like commit 741e511b4208 ("KVM: x86: Don't snapshot "max" TSC if host TSC
is constant") did for the default frequency of new VMs, compute the cap
from tsc_khz when it is used instead of taking a snapshot at load time.
This covers KVM_SET_TSC_KHZ on both the vCPU and the VM file descriptor.

This also drops setting the cap to tsc_khz in the Hyper-V reenlightenment
notifier, which left no room for scaling up once the host TSC frequency
had changed; commit 0092e4346f49 ("x86/kvm: Support Hyper-V
reenlightenment") gives no reason for that limit. The cap now follows the
new frequency the same way. The notifier still does not recompute the
multipliers of vCPUs that already exist.

Fixes: 92a1f12d2598 ("KVM: X86: Implement userspace interface to set virtual_tsc_khz")
Link: https://d.kernelci.org/test/maestro:6adc828a55fda507607f79c3
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Reproduced on an AMD DL345 Gen11 booted with tsc_early_khz= 500 kHz below
the refined frequency, so that refinement always raises tsc_khz after KVM
is initialized. With KernelCI's x86 build of mainline 5b0764a53235,
nested_tsc_scaling_test failed 3 out of 3 times with KVM_SET_TSC_KHZ
returning -EINVAL. With the same config plus this patch it passed 3 out
of 3, and tsc_scaling_sync, tsc_msrs_test, kvm_clock_test and
nested_tsc_adjust_test still pass. A nested SVM guest with the same
tsc_early_khz trick gives the same result, and with tsc_early_khz above
the real frequency (refinement lowers tsc_khz) mainline passes.

This does not change the existing window between the cap check and
set_tsc_khz(), which read tsc_khz separately.

 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/x86.c              | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ee4b127004df..35a74f0eb45e5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -260,8 +260,6 @@ struct kvm_x86_pmu_event_filter;
 struct kvm_caps {
 	/* control of guest tsc rate supported? */
 	bool has_tsc_control;
-	/* maximum supported tsc_khz for guests */
-	u32  max_guest_tsc_khz;
 	/* number of bits of the fractional part of the TSC scaling ratio */
 	u8   tsc_scaling_ratio_frac_bits;
 	/* maximum allowed value of TSC scaling ratio */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..9e22072f39c18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1156,6 +1156,19 @@ static inline u64 __scale_tsc(u64 ratio, u64 tsc)
 	return mul_u64_u64_shr(tsc, ratio, kvm_caps.tsc_scaling_ratio_frac_bits);
 }
 
+/*
+ * Use the current tsc_khz, not the one at load time, as the TSC frequency can
+ * be refined after KVM is initialized.  Make sure the user can only configure
+ * tsc_khz values that fit into a signed integer, otherwise KVM_GET_TSC_KHZ
+ * would return a negative value and confuse userspace.  A min value is not
+ * calculated because it will always be 1 on all machines.
+ */
+static u32 kvm_max_guest_tsc_khz(void)
+{
+	return min(0x7fffffffULL,
+		   __scale_tsc(kvm_caps.max_tsc_scaling_ratio, tsc_khz));
+}
+
 u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 {
 	u64 _tsc = tsc;
@@ -3728,7 +3741,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		user_tsc_khz = (u32)arg;
 
 		if (kvm_caps.has_tsc_control &&
-		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
+		    user_tsc_khz > kvm_max_guest_tsc_khz())
 			goto out;
 
 		if (user_tsc_khz == 0)
@@ -4695,7 +4708,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		user_tsc_khz = (u32)arg;
 
 		if (kvm_caps.has_tsc_control &&
-		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
+		    user_tsc_khz > kvm_max_guest_tsc_khz())
 			goto out;
 
 		if (user_tsc_khz == 0)
@@ -6749,7 +6762,6 @@ static void kvm_hyperv_tsc_notifier(void)
 		for_each_present_cpu(cpu)
 			per_cpu(cpu_tsc_khz, cpu) = tsc_khz;
 	}
-	kvm_caps.max_guest_tsc_khz = tsc_khz;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
 		__kvm_start_pvclock_update(kvm);
@@ -7188,18 +7200,6 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (!tdp_enabled)
 		kvm_caps.supported_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
-	if (kvm_caps.has_tsc_control) {
-		/*
-		 * Make sure the user can only configure tsc_khz values that
-		 * fit into a signed integer, otherwise KVM_GET_TSC_KHZ would
-		 * return a negative value and confuse userspace.
-		 * A min value is not calculated because it will always
-		 * be 1 on all machines.
-		 */
-		u64 max = min(0x7fffffffULL,
-			      __scale_tsc(kvm_caps.max_tsc_scaling_ratio, tsc_khz));
-		kvm_caps.max_guest_tsc_khz = max;
-	}
 	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
 	kvm_init_msr_lists();
 	return 0;
-- 
2.53.0

