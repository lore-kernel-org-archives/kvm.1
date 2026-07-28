Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63983AB269;
	Tue, 28 Jul 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250214; cv=none; b=BeAxLunxC1ZffiMETpVCZQO8ffDUWa2aGFq9q1REL30NvEP5Ip5B50qgsBQNjebngP2EQiY/RJutFor28EDotxUKHFEbLwL683Hn1XlcjlGJSCnKgPiaOjhUDuArh2Xe1QRIF8rgzerIOlihuolSTQnXAtOB2IhYnsNJmNgZKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250214; c=relaxed/simple;
	bh=kqCe6XuBCMCl5+kIgZ85f4YxqOVrpK1siIcDu6z+qSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmByA91nQZ7GY3gpUIUHL2h449oKKJ2qXiqS1TOOYxqQsayBBIyv2aQoWcIs85ywo4wYwo2Q/kKVoGcSYNeT/KbougXuvtej4KYd6q1Q24lFRF4/sbM1UqUNyWWpk/OJAO4shdMsibXqOZYd43iZ4NmtDLRBw98sVDlGHUup86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nAlu2ZNB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAlu2ZNB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=OcinU7F8ySdx3TMu6WQ2XjEDb7WdPVDm7/nt9gYyqkI=; b=nAlu2ZNBFj7RoDK+o/fLPokcPX
	KZGiMkYazGDdzj9bpf/HKlVj8HK7f7ixhe5KgpXFRfvUavsKP/XW+1mnKbmAntcRTbbcHLljolYPM
	KJPrFEdxq3IELitrEtqc/4YI7yCuJQtcTEeOKHjG3LOMnLa9d16Fux5FEylebZrjqXlFLDdQc1k3k
	N8IhfhUE12DcXL/qAumkZXH/rFhnAlmBX0E1p9KzJUpjM/hrw4u12nrZOWxKbswc7IMYCrX+GRlok
	D6uOkRvBYynsEPQA0P0D5hHGvlSJJTN3s8j9++TK8jyS060zEWePMStZzeQIEC/90jumIxJsRr4wH
	otc36jbA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOj-0QNw;
	Tue, 28 Jul 2026 14:49:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYM-21Id;
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
Subject: [PATCH v7 11/36] KVM: x86: Restructure kvm_guest_time_update() for TSC upscaling
Date: Tue, 28 Jul 2026 15:39:51 +0100
Message-ID: <20260728144954.355376-12-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Restructure kvm_guest_time_update() so that kernel_ns/host_tsc are
always "now" when doing TSC catchup, then swap in the master clock
reference values afterward for the hv_clock.

This makes the TSC upscaling code considerably simpler: the catchup
adjustment is computed as the delta between what the guest TSC *should*
be at "now" and what it actually is, rather than mixing "now" and
"master clock reference" timestamps.

The seqcount loop now also contains the kvm_get_time_and_clockread()
call (matching get_kvmclock's pattern).

Based on a suggestion by Sean Christopherson.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 78 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 52c9268007f8..12c3d7d503ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1793,45 +1793,60 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags;
 	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct kvm_arch *ka = &v->kvm->arch;
 	s64 kernel_ns;
 	u64 tsc_timestamp, host_tsc;
+	u64 master_host_tsc = 0;
+	s64 master_kernel_ns = 0;
+	s64 kvmclock_offset = 0;
 	bool use_master_clock;
 
-	kernel_ns = 0;
-	host_tsc = 0;
-
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
 	 * to the guest.
 	 */
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
+
 		use_master_clock = ka->use_master_clock;
+
+		/*
+		 * The TSC read and the call to get_cpu_tsc_khz() must happen
+		 * on the same CPU.
+		 */
+		get_cpu();
+
+		tgt_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+
+#ifdef CONFIG_X86_64
+		if (use_master_clock &&
+		    !kvm_get_time_and_clockread(&kernel_ns, &host_tsc) &&
+		    !read_seqcount_retry(&ka->pvclock_sc, seq))
+			use_master_clock = false;
+#endif
+
+		put_cpu();
+
 		if (use_master_clock) {
-			host_tsc = ka->master_cycle_now;
-			kernel_ns = ka->master_kernel_ns;
+			master_host_tsc = ka->master_cycle_now;
+			master_kernel_ns = ka->master_kernel_ns;
+		} else {
+			local_irq_disable();
+			host_tsc = rdtsc();
+			kernel_ns = get_kvmclock_base_ns();
+			local_irq_enable();
 		}
+
+		kvmclock_offset = ka->kvmclock_offset;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 
-	/* Keep irq disabled to prevent changes to the clock */
-	local_irq_save(flags);
-	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
 	if (unlikely(tgt_tsc_hz == 0)) {
-		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
 	}
-	if (!use_master_clock) {
-		host_tsc = rdtsc();
-		kernel_ns = get_kvmclock_base_ns();
-	}
-
-	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
 
 	/*
 	 * We may have to catch up the TSC to match elapsed wall clock
@@ -1841,17 +1856,32 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	 *      entry to avoid unknown leaps of TSC even when running
 	 *      again on the same CPU.  This may cause apparent elapsed
 	 *      time to disappear, and the guest to stand still or run
-	 *	very slowly.
+	 *      very slowly.
 	 */
 	if (vcpu->tsc_catchup) {
-		u64 tsc = compute_guest_tsc(v, kernel_ns);
-		if (tsc > tsc_timestamp) {
-			adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
-			tsc_timestamp = tsc;
-		}
+		s64 adjustment;
+
+		/*
+		 * Calculate the delta between what the guest TSC *should* be
+		 * and what it actually is according to kvm_read_l1_tsc().
+		 */
+		adjustment = compute_guest_tsc(v, kernel_ns) -
+			     kvm_read_l1_tsc(v, host_tsc);
+		if (adjustment > 0)
+			adjust_tsc_offset_guest(v, adjustment);
 	}
 
-	local_irq_restore(flags);
+	/*
+	 * Now that TSC upscaling is out of the way, the remaining calculations
+	 * are all relative to the reference time that's placed in hv_clock.
+	 * If the master clock is NOT in use, the reference time is "now".  If
+	 * master clock is in use, the reference time comes from there.
+	 */
+	if (use_master_clock) {
+		host_tsc = master_host_tsc;
+		kernel_ns = master_kernel_ns;
+	}
+	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
 
 	/* With all the info we got, fill in the values */
 
@@ -1871,7 +1901,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
 	hv_clock.tsc_timestamp = tsc_timestamp;
-	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	hv_clock.system_time = kernel_ns + kvmclock_offset;
 	vcpu->last_guest_tsc = tsc_timestamp;
 
 	/* If the host uses TSC clocksource, then it is stable */
-- 
2.55.0

