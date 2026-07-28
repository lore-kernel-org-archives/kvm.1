Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797046C4BB;
	Tue, 28 Jul 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250223; cv=none; b=oF1Hr/3/UIjjDU+cGzFiQkxi9J0vQqXmjbbv2M1kAX9vmtqcwT6Q2H9T7MegQDp6RMs6mz9cdJzhVsPIUUEHPial5ABJpuvFhuyt1vp9FQ9DVmqjkAm4tlij+fdMvfwZ5V/BIlHsZA6A82k9hvNuMWo3WeIF8F+6iNYud1ywRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250223; c=relaxed/simple;
	bh=oRBwHwL+ZS9dbKti9sX7t7Sm6sZUMYuiJ/BupQe9als=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvCssojGllI1jhiM2Wib0JTMNsv1ritrcQIRd8LmLX1eFneBU1VmpY6NW+Nbea7cwNw5TBiGWVJg/6YVUhl2+MSN3YLxO8XbepzbeVjhBd6HOb816LdS7pHYYB8fW762xBLB3NLqtvlHWb+FeJ/MWMvShGinnGGWyM8i3XkM0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fuHlOX82; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fuHlOX82"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=J+FoXXHW2aZXUy4Ob7wzvgD81fRpgwA9RyjzfWOxyos=; b=fuHlOX82zNfcmsvl/s0Clvv3ae
	VAHvlPDCsV2YW1FWTA/Lmha/q4csvDdk+8pyqY4Dc3kGQllKcdVmyXRnGHYglkSBfoDrWIqO0b2RX
	1/uD3Mc9uStr0HYg1nokgrpeKaWqgYbMypIIKBlL5wDO+SdpoC17izkO3yxRc8JONFdMUQ26nfyZy
	IXWHDDt/tH2/j+3Ix4lrXzhVistPwkrw5QGEq4sXcqdZkx4qtwSmayaf5kXyR0io0OqW1nriGwnaS
	ShZDvx8erjA3wyBfq8+d5dyPmkV0ZeO9C4AU4xtC4azLVLwKaVxDy0gAXhwM+pFfk2998npbMXDty
	VpJ1BW+w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052Vb-36KX;
	Tue, 28 Jul 2026 14:50:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYV-2Y5w;
	Tue, 28 Jul 2026 15:49:55 +0100
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
Subject: [PATCH v7 14/36] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Tue, 28 Jul 2026 15:39:54 +0100
Message-ID: <20260728144954.355376-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When synchronizing to an existing TSC (either by explicitly writing
zero, or the legacy hack where the TSC is written within one second's
worth of the previously written TSC), the last_tsc_write and
last_tsc_nsec values were being misrecorded by __kvm_synchronize_tsc().
The *unsynchronized* value of the TSC (perhaps even zero) was being
recorded, along with the current time at which kvm_synchronize_tsc()
was called. This could cause *subsequent* writes to fail to synchronize
correctly.

Fix that by resetting {data, ns} to the previous values before passing
them to __kvm_synchronize_tsc() when synchronization is detected.
Except in the case where the TSC is unstable and *has* to be synthesised
from the host clock, in which case attempt to create a nsec/tsc pair
which is on the correct line.

Furthermore, there were *three* different TSC reads used for calculating
the "current" time, all slightly different from each other. Fix that by
using kvm_get_time_and_clockread() where possible and using the same
host_tsc value in all cases.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c4fd2367686c..812657f7c984 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -209,6 +209,10 @@ module_param(pi_inject_timer, bint, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
+
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
@@ -1314,14 +1318,23 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
+	u64 offset, host_tsc, elapsed;
+	s64 ns;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-	ns = get_kvmclock_base_ns();
+
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+	}
+
+	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -1364,13 +1377,18 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!kvm_check_tsc_unstable()) {
+		/*
+		 * If synchronizing, advance the reference point to "now"
+		 * so the matching window slides forward with each vCPU.
+		 */
+		u64 delta = nsec_to_cycles(vcpu, elapsed);
+
+		data = kvm->arch.cur_tsc_write + delta;
+
+		if (!kvm_check_tsc_unstable())
 			offset = kvm->arch.cur_tsc_offset;
-		} else {
-			u64 delta = nsec_to_cycles(vcpu, elapsed);
-			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-		}
+		else
+			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 		matched = true;
 	}
 
-- 
2.55.0

