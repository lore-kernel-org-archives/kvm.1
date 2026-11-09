Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=dFCNnU9zqt4EZKxJXUgvpdJTG2WJ12hjOA9lCALlX3VqDv1SHjOVHL3dQSQyHw3FMdxc
	 +/lhF61z5b74UQ554ICn4rrZccp8qRN2CuVQs9Tm6QScVdpEii+bpVGMrAC5GzQQdf2gi
	 dwq1YFcU5hxyKqw15YynTxZZg50i85k8e7zT+xnpndD2Ch9VxOzHHNRenBtMaRoXA6dZ7
	 wenGZ2fFMNNTsWiH2tz/ukUI+x3xoZdZEmx8W/yvETvBabLux3f2BPLTywjzyvYNzZQRJ
	 WYx5hwTNDk5z8DpOy7w2kbYAsyjPXiQoPnhvFht62jLCP6dNK9qh6aW1tIdVJF9+37w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=vYXMTPtnDfVFKHKWc3c8IyF9mzywvLRRgeMcfGElahM=;
	b=vzljbSfK3lsk2Rbo93tqVLEEvCD1gFN7WMUrME5oQL/xkSjzR3j7S7ObeAK4IP0TXvAL
	 V7xdMHlN9wcVibgY9ySGbbGYQ13eBfVmtjZtOJwrX8ZxXY/56ubboziccouovzGV05z8R
	 xWKu3v0n51hmwjqmQd71jrleH3nLl5ildkS6SN/uZqf/DRSHSXQWfn8IoZaLxpK7sVd17
	 +kWcV8WMJixXRGi/be3mOmC5L/6zCfm0mXK0cNamqGWHTL9Vexx848wYgjbAQ5tYZvScM
	 sVKbVNW9xLBSxztCEO1044F5eKwIKafOuMz0Aybsk72UJ6/K5w186l0t2EyjJXjd1Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bAanfjHy;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39A606EE8F;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C39A606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bAanfjHy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=vYXMTPtnDfVFKHKWc3c8IyF9mzywvLRRgeMcfGElahM=; b=bAanfjHyV7TavYGHIZnkK69C9G
	12HTjFW/G7IRuAmyVt8XCOmSXwn2P/hkoyxNXpkHQ12M8cLU1RKyIRylmtTIzL1QFwvqR93pAJrqQ
	dN2pcBydO4GhvE8vkSon0mr8KAzLaSE+/9zN5M7ZZiDkrj/Y0lerujUwUd7qI+RIKPLrLamL02Vb4
	KiyU7wmJFhulip/G9Hk48sKF0fHEFTYtD7oLNSc84TV0ONapekzPChPyBNaImEV+qtlzmBYXGPL4/
	3KY7ItIe85uVdba2njjo7mWt0QLTW93psPjWv9iKzLUFkTvIXTN+OOmHukzUs8KLtyL9zvvhRHpZO
	JVWH1DEA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AYA-296r;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUJ-2VXs;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 05/24] KVM: x86: Factor out kvm_use_master_clock()
Date: Sun,  8 Nov 2026 17:20:51 -0800
Message-ID: <20261109012112.3415328-6-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Both kvm_track_tsc_matching() and pvclock_update_vm_gtod_copy() make a
decision about whether the KVM clock should be in master clock mode.
They used *different* criteria for the decision though. This isn't
really a problem; it only has the potential to cause unnecessary
invocations of KVM_REQ_MASTERCLOCK_UPDATE if the masterclock was
disabled due to TSC going backwards, or the guest using the old MSR.
But it isn't pretty.

Factor the decision out to a single function. And document the
historical reason why it's disabled for guests that use the old
MSR_KVM_SYSTEM_TIME.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 73015825f218..ade7e71eb57f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1112,11 +1112,30 @@ static inline bool gtod_is_based_on_tsc(int mode)
 {
 	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
 }
-#endif
+
+static bool kvm_use_master_clock(struct kvm *kvm)
+{
+	struct kvm_arch *ka = &kvm->arch;
+
+	/*
+	 * The 'old kvmclock' check is a workaround (from 2015) for a
+	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
+	 * its kvmclock was too far behind the current time. So the
+	 * mode of just setting the reference point and allowing time
+	 * to proceed linearly from there makes it fail to boot.
+	 * Despite that being kind of the *point* of the way the clock
+	 * is exposed to the guest. By coincidence, the offending
+	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
+	 * only because it resided in the wrong number range. So the
+	 * workaround is activated for *all* guests using the old MSR.
+	 */
+	return ka->all_vcpus_matched_freq &&
+		!ka->backwards_tsc_observed &&
+		!ka->boot_vcpu_runs_old_kvmclock;
+}
 
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 {
-#ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	bool prev_matched_tsc = ka->all_vcpus_matched_tsc;
@@ -1171,7 +1190,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 	 * are fine — each vCPU's pvclock has its own tsc_timestamp that
 	 * accounts for its offset.
 	 */
-	bool use_master_clock = ka->all_vcpus_matched_freq &&
+	bool use_master_clock = kvm_use_master_clock(vcpu->kvm) &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -1186,8 +1205,11 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
 			    atomic_read(&vcpu->kvm->online_vcpus),
 		            ka->use_master_clock, gtod->clock.vclock_mode);
-#endif
 }
+#else
+static inline void kvm_track_tsc_matching(struct kvm_vcpu *vcpu,
+					  bool update_mclock) {}
+#endif
 
 /*
  * Multiply tsc by a fixed point number represented by ratio.
@@ -1661,10 +1683,9 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	int vclock_mode;
-	bool host_tsc_clocksource, freqs_matched;
+	bool host_tsc_clocksource;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	freqs_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -1674,9 +1695,8 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && freqs_matched
-				&& !ka->backwards_tsc_observed
-				&& !ka->boot_vcpu_runs_old_kvmclock;
+	ka->use_master_clock = host_tsc_clocksource &&
+				kvm_use_master_clock(kvm);
 
 	if (ka->use_master_clock) {
 		u64 tsc_hz;
@@ -1704,7 +1724,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					freqs_matched);
+					ka->all_vcpus_matched_freq);
 #endif
 }
 
-- 
2.43.0

