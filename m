Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371837A840;
	Fri,  3 Jul 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113853; cv=none; b=tcCE4ZygEKPceJ421i7H9JLooyl/+g28xK0ER+sIYKN5EJmuGJURRKlVl4Zc2msXFRYxiyImgScwup49KlgCciNcJAQEc+FKhOA2k0CZD5NLhl0jE6QSpRz5QmnfN5Bh7vpEszYlzg6LGo8Z6gitflPjsKTom0xGy+PDq1iG6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113853; c=relaxed/simple;
	bh=Hz7guEiekaOt0/0XzItajV6QOslQxUBzAIkuP4aF14E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmsVn19Ok3Jyalp9CNOQipHrc73OSo6xdl0TwCy13CpPAkX57N59I6ETBcRj7zJZmrxrsMwNFe4d8es5GSvIzZCVeEEfyC1JxHKbiT0FrtjFQHbDDpUx1zVnRmqVedoKAd7yvwaheifvR+nG8tJYPP3P4og52fVr8RZFL/3JHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLhCX7LK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLhCX7LK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=mU5wFjlLT83r2DMLYPo2Un7WZ36IERFw89f8aTvqSMA=; b=pLhCX7LKJ9jL0Egq3v1CQ2lbNB
	6geYPA9+pnJQWRXzcRMfmIi6LmGdMv7pThTm9NBNqZ3oV/CLIRofkA9ghaM+kloYstTg6rGJ/uqbr
	GnQswAHHEQt//Hy0gqdhdsn2erC1pWE0fd77SkDgRHk6MqST5sk0bwspbMRnNR5szbd7Ymj8VJCst
	YU9p6hcjeyn6NnLTlQsfhXC1nz4OCMMSxlp07pY7lLsSATOEAODpqxY33VaH+awEptGUnxzsC6wQA
	YeA0u9LEqIHNkVIvkPfmzrOZ2vz+0FVTFKbgwlsKGY+yYpSVLKz1UcRj/XZobe/0Q+GwKKYcpYyCW
	9ykmkL4g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKd-000000059O5-3OG6;
	Fri, 03 Jul 2026 21:23:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001ROq-2d0k;
	Fri, 03 Jul 2026 22:21:48 +0100
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
Subject: [PATCH v6 16/36] KVM: x86: Restructure kvm_guest_time_update() for TSC upscaling
Date: Fri,  3 Jul 2026 22:17:55 +0100
Message-ID: <20260703212145.343527-17-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
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
index 55fb19fb7a88..9dc4213f0fa5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3349,45 +3349,60 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
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
+		tgt_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
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
-	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
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
@@ -3397,17 +3412,32 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
 
@@ -3427,7 +3457,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
 	hv_clock.tsc_timestamp = tsc_timestamp;
-	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	hv_clock.system_time = kernel_ns + kvmclock_offset;
 	vcpu->last_guest_tsc = tsc_timestamp;
 
 	/* If the host uses TSC clocksource, then it is stable */
-- 
2.54.0

