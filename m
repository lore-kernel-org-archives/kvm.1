Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=TXeKnQg275OclMt6rQjmYvFpzBEBAfPxtIBMmglqNScCTBLYwDnsqT4SqCxPawNtH5VA
	 nQ/Q/hOGylISSHqCx1CjPLzojvmy9oDK9204Pn8A6cLnj8ymRMz6IJN+vtdV+daWIgo2H
	 6QWmR9+yvR51oHyy3qN2SyQTFPXcwfxN4H7GDOazFeywio+Uf1CKaxz6EQeHFrSZGyznf
	 2ReMf1qXiGVXxFQsoJl8mmPg5q4NPlrPvmMUwn6DchvC7ZlzgKO5Rnz/GyAVgxtqe595k
	 9kMSKjHtBXU2UTIiPxGApd7gacIZonSzKIoyvTzsZKGTbYzwju+3IM3x9XH/9nszESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=LHsRlifsljGRXRN3+a2hsoPBPeF/jXGyHr0leVXSUNM=;
	b=tuuczCSVajnGylmG5QsSl8njUTzJyAcBJX2zZMahTEOTZBkKNBa3tSUmouhtMNbN3q98
	 emTCx95pyeaiq14ztQH8UwYiFm0gM8lzV3q6i0TG39Nuac0g3G4wB+7/GYdqz5Maaft0k
	 pH8KVk3LUXfisYp+vS9yrVELYoZrNu828bmUHeRRYUZ75qA2Qt1Nh069u78dsv0yA0yG6
	 s7oFfnsqhDVKU3ohwT1INboaL4OEGpbKtSmCIsJjBrEc2s7O9dZ+08BdQiIjorweTDhJD
	 DkMwqxrjTOJAZxQzrOMfvw6mm7MZxhzewD4qknzhrY2EvTpHfGpBRJ3jTt6v53sR1qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SW3hAMqY;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161F606B7B1;
	Wed, 11 Nov 2026 18:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1161F606B7B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SW3hAMqY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=LHsRlifsljGRXRN3+a2hsoPBPeF/jXGyHr0leVXSUNM=; b=SW3hAMqYnnh+DDe/fvssjLS794
	HFUUxdTw+KRaktlO2adxyKfroG22VsEs4s72KIpB9Ij60T3pJSA0dDhrFBWi3/wztujBJMcB9kklk
	b9yLwWo7/HYOYV9jwCB1TsYSNLobgHAKKkhtciTvYxc1BMu1M2Fb7u4GJOxlU8ne0yXHztrxJdZwc
	thi80wPSh/P0FCxdaCzB9EX7FlaejKI//Ug4I8cst2TTp3Vx1m1K2/iu34tVGBh/NhDSIV7U5gBtf
	Xsv86+T+Bn6c0DGhfIxu4Nz5IbC6ktTdCQaYuXtry/ILHVstnqk1DQ/S+lLaTJVXhMX1l1wRrZwCe
	RH9hjY3Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvI-3CEJ;
	Wed, 11 Nov 2026 18:09:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl8-0000000HWs4-3DmC;
	Wed, 11 Nov 2026 18:09:22 +0000
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
Subject: [PATCH v13 01/26] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Wed, 11 Nov 2026 10:08:57 -0800
Message-ID: <20261111180922.4177927-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
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

When synchronizing to an existing TSC (either by explicitly writing
zero, or the legacy hack where the TSC is written within one second's
worth of the previously written TSC), the last_tsc_write and
last_tsc_nsec values were being misrecorded by __kvm_synchronize_tsc().
The *unsynchronized* value of the TSC (perhaps even zero) was being
recorded, along with the current time at which kvm_synchronize_tsc()
was called. This could cause *subsequent* writes to fail to synchronize
correctly.

Fix that by extrapolating the generation's TSC value to the current
time (data = cur_tsc_write + elapsed cycles) before passing it to
__kvm_synchronize_tsc(), so the recorded {data, ns} pair always lies
on the generation's line and the one-second matching window slides
forward with each synchronized write. When the TSC is stable, reuse
the generation's offset exactly; when it is unstable, compute a new
offset for the extrapolated value.

Furthermore, there were *three* different TSC reads used for calculating
the "current" time, all slightly different from each other. Fix that by
using kvm_get_time_and_clockread() where possible and using the same
host_tsc value in all cases.

Extrapolating from the generation's origin at the nominal frequency
means a guest within tsc_tolerance_ppm of the host (where hardware
scaling is not engaged) drifts out of the one-second window after
about 67 minutes; a write which then fails to match still installs
the exact value, at the cost of a fresh generation. The old per-write
re-anchoring bounded that drift, but recorded points the generation's
line did not pass through — the bug this patch exists to fix.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..7a2b0b99373f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -210,6 +210,10 @@ module_param(pi_inject_timer, bint, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
+
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
@@ -1374,14 +1378,23 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
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
@@ -1424,13 +1437,21 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!kvm_check_tsc_unstable()) {
+		/*
+		 * If synchronizing, advance the reference point to "now"
+		 * so the matching window slides forward with each vCPU.
+		 * Extrapolate from the generation's own origin: 'elapsed'
+		 * is measured from the most recent write, which lies on
+		 * the generation's line only for the first matched write.
+		 */
+		u64 delta = nsec_to_cycles(vcpu, ns - kvm->arch.cur_tsc_nsec);
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
2.43.0

