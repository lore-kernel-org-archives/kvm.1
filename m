Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884983FE652;
	Sat,  9 May 2026 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366946; cv=none; b=RRrTB4ufWlVDPy+iESBXz1JWTH6UbIvLlNexpS9Wt78un38aKdr8d1zc8LZfjyZt1N+j0xr7pVZsBj6vQqEe3PzogUy4TGH/e1uIakJL9oD1RNwDttdkrK/3DucAlM4UP0PwiNw9S/Zd06d+eL0xLBhFLBZs39BEQUdp6hVH3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366946; c=relaxed/simple;
	bh=Rv1p/ZtX2sgZa4r3asEorMOdeYWi11Ae3VIGJnf6u1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/PVSGPgihrnr8ggVZepLkIgIkbrSe7aWrqcTSwjirOdKh1KZnHciajPbNWwDPHFrbXh6CzbuVLAzM2l0AQyIcASRkWfWVBAWCn4ZrrE1MNKyqKbI1rIgHTURDRR5Nq504YFLIx/FKQIDm1pjX9prcuOTrBuvkVLC++wo6Oo9Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AEobeMID; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEobeMID"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zXYXQPXLzd2dcTYMg1gTvCK26tkN2cOEOzkWZ733ogk=; b=AEobeMIDugUN7eiHan6hG45ktT
	R8amBcPRPjDj++/KH0EpUAl64+jTiq4HqRCpFlKNJbg0Of6kv36aIL7EvtIvglcW5i5jGHAErQ/Vc
	dKqUBmeqrAnIe6LEB2fkB/ovB+UQdK3lXaCR+dnU6korDQshJ5DAdhqpWOyaEv2G77UTRa8f2x22C
	vKZ63Pm6BoF5585QClj84e8/cDylBglkhaMYVB2KseLvn9zQSkWprSvtDDW1OWTfLa57WKhE62eZM
	6HqViX8GtTkrFcAN4TnSazhzMhDCuRlzY/mlo7x8njgH/Krm4SCYrSqNM4P0sypNw9QrDVk8fCKh2
	5QfynusA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzJ-0RiQ;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhIT-3ti3;
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
Subject: [PATCH v4 19/30] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Sat,  9 May 2026 23:46:45 +0100
Message-ID: <20260509224824.3264567-20-dwmw2@infradead.org>
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
 arch/x86/kvm/x86.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9cbebd6a92a..097df58749c3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -203,6 +203,9 @@ module_param(mitigate_smt_rsb, bool, 0444);
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
  * returns to userspace, i.e. the kernel can run with the guest's value.
  */
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
 #define KVM_MAX_NR_USER_RETURN_MSRS 16
 
 struct kvm_user_return_msrs {
@@ -2854,14 +2857,22 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
+	u64 offset, host_tsc, ns, elapsed;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		ns = get_kvmclock_base_ns();
+		host_tsc = rdtsc();
+	}
+
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-	ns = get_kvmclock_base_ns();
+
+	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2904,12 +2915,25 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
+		/*
+		 * If synchronizing, the "last written" TSC value/time
+		 * recorded by __kvm_synchronize_tsc() should not change
+		 * (i.e. should be precisely the same as the existing
+		 * generation).
+		 */
+		data = kvm->arch.last_tsc_write;
+
 		if (!kvm_check_tsc_unstable()) {
 			offset = kvm->arch.cur_tsc_offset;
+			ns = kvm->arch.cur_tsc_nsec;
 		} else {
+			/*
+			 * ...unless the TSC is unstable and has to be
+			 * synthesised from the host clock in nanoseconds.
+			 */
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 		}
 		matched = true;
 	}
-- 
2.51.0

