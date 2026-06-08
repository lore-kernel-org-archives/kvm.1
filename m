Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E83F23B3;
	Mon,  8 Jun 2026 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930522; cv=none; b=bDYijYJ/wPkjHT2Hza/NeYG3M/uZC0VQ8SbZmPomr6RoPrJAzEI7rsjlk8horOZeT2hh9Ail+Wqa0S4PASyITyFPP0htQvYA+zPbFTKxHZ0cC6nUW0MV8CsFrW3kCMPOgzP06Hoo7f1oZHfPEIIS0+8verb+JQqMpTvJLgYpaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930522; c=relaxed/simple;
	bh=CuFlpoe4KYpllAIShWHKpPKYgOy+YKaliFMSx6C3Mq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF8PSX8qsklA5TchTqq/p9qELUGQ/Y947+HuaZJ12meOayu9FcT67jv8DwIahciawQUZFj5gAs5O9l/jXPffW83S6lGi0BuYSut8LPxKR63x5SjbusumweVOUAz8HJ64LxTdAmTy3/BCQnHN3vJt6XimfPlQRWh7BLOo3SOeuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cynKPFl8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cynKPFl8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=Z11TCooN3o79fGtJQIRZglBTEce9tdBf389vknMfIOQ=; b=cynKPFl8GgekA9SKrwFXVB9r9J
	WAbFVCHdiWGH0CeOokQFuPCsXJ5o3iDL2cPV9hIMKQxr1N7MXHK6yEk9iJjsb9GAWXZOHgTi0DsXj
	JzQ+Nkq02WPUfyO9KNXEhSze7KlpaKZOXEG2oJjzfevRTF18SPRZ1yBRI8hEftHxaDX+zmpufV/QS
	pzA0W4c7cG6cx+ReYdtKYBmjJnHYRBJBqQeLcoh/2sc7BaFdzsuH2Xs71Xgo66vPsfPFQqbgY1cjp
	2Ssmi5qG4wR/HkVXxhTRcfvPypwbpq2lU6dJxpPrNxctwK779aMrXdCeYKsaCKu079gHZ/Lr2+gJO
	ADa0uoTA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNS-0000000DtxP-0Uh1;
	Mon, 08 Jun 2026 14:54:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFi-1I3p;
	Mon, 08 Jun 2026 15:54:58 +0100
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
Subject: [PATCH v5 19/34] KVM: x86: Kill last_tsc_{nsec,write,offset} fields
Date: Mon,  8 Jun 2026 15:48:00 +0100
Message-ID: <20260608145455.89187-20-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
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

These pointlessly duplicate the cur_tsc_{nsec,write,offset} values.
The only place they were used was where the TSC is stable and a new
vCPU is being synchronized to the previous setting, in which case the
cur_tsc_* value is definitely identical.

Rename last_tsc_khz and last_tsc_scaling_ratio to cur_tsc_khz and
cur_tsc_scaling_ratio respectively, since they are properties of the
current TSC generation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/include/asm/kvm_host.h |  7 ++----
 arch/x86/kvm/x86.c              | 42 ++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5348fd5ea3f3..59298a8f78eb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1486,11 +1486,8 @@ struct kvm_arch {
 	 * preemption-disabled region, so it must be a raw spinlock.
 	 */
 	raw_spinlock_t tsc_write_lock;
-	u64 last_tsc_nsec;
-	u64 last_tsc_write;
-	u32 last_tsc_khz;
-	u64 last_tsc_offset;
-	u64 last_tsc_scaling_ratio;
+	u32 cur_tsc_khz;
+	u64 cur_tsc_scaling_ratio;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8c0633263fb..bbd642e0dc54 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2813,14 +2813,12 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		vcpu->kvm->arch.user_set_tsc = true;
 
 	/*
-	 * We also track th most recent recorded KHZ, write and time to
-	 * allow the matching interval to be extended at each write.
+	 * Track the TSC frequency, scaling ratio, and offset for the current
+	 * generation. These are used to detect matching TSC writes and to
+	 * compute the guest TSC from the host clock.
 	 */
-	kvm->arch.last_tsc_nsec = ns;
-	kvm->arch.last_tsc_write = tsc;
-	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
-	kvm->arch.last_tsc_offset = offset;
-	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
+	kvm->arch.cur_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	kvm->arch.cur_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -2833,8 +2831,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		 * nanosecond time, offset, and write, so if TSCs are in
 		 * sync, we can match exact offset, and if not, we can match
 		 * exact software computation in compute_guest_tsc()
-		 *
-		 * These values are tracked in kvm->arch.cur_xxx variables.
 		 */
 		kvm->arch.cur_tsc_generation++;
 		kvm->arch.cur_tsc_nsec = ns;
@@ -2874,7 +2870,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	}
 
 	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
-	elapsed = ns - kvm->arch.last_tsc_nsec;
+	elapsed = ns - kvm->arch.cur_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
 		if (data == 0) {
@@ -2884,7 +2880,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 			 */
 			synchronizing = true;
 		} else if (kvm->arch.user_set_tsc) {
-			u64 tsc_exp = kvm->arch.last_tsc_write +
+			u64 tsc_exp = kvm->arch.cur_tsc_write +
 						nsec_to_cycles(vcpu, elapsed);
 			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
 			/*
@@ -2915,14 +2911,14 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	 * it's better to try to match offsets from the beginning.
          */
 	if (synchronizing &&
-	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
+	    vcpu->arch.virtual_tsc_khz == kvm->arch.cur_tsc_khz) {
 		/*
 		 * If synchronizing, the "last written" TSC value/time
 		 * recorded by __kvm_synchronize_tsc() should not change
 		 * (i.e. should be precisely the same as the existing
 		 * generation).
 		 */
-		data = kvm->arch.last_tsc_write;
+		data = kvm->arch.cur_tsc_write;
 
 		if (!kvm_check_tsc_unstable()) {
 			offset = kvm->arch.cur_tsc_offset;
@@ -3207,7 +3203,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 		 * get_kvmclock() to compute kvmclock from the host TSC
 		 * without needing a vCPU reference.
 		 */
-		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
+		ka->master_tsc_scaling_ratio = ka->cur_tsc_scaling_ratio;
 		tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
 		if (tsc_hz && kvm_caps.has_tsc_control)
 			tsc_hz = kvm_scale_tsc(tsc_hz,
@@ -6088,8 +6084,8 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 
 		matched = (vcpu->arch.virtual_tsc_khz &&
-			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
-			   kvm->arch.last_tsc_offset == offset);
+			   kvm->arch.cur_tsc_khz == vcpu->arch.virtual_tsc_khz &&
+			   kvm->arch.cur_tsc_offset == offset);
 
 		tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
 		ns = get_kvmclock_base_ns();
@@ -13543,13 +13539,15 @@ int kvm_arch_enable_virtualization_cpu(void)
 			}
 
 			/*
-			 * We have to disable TSC offset matching.. if you were
-			 * booting a VM while issuing an S4 host suspend....
-			 * you may have some problem.  Solving this issue is
-			 * left as an exercise to the reader.
+			 * Adjust the TSC matching reference by the same
+			 * delta applied to each vCPU's offset, so that
+			 * future KVM_SET_TSC / vCPU creation still matches
+			 * correctly against the adjusted TSC timeline.
+			 * Scale from host to guest TSC rate.
 			 */
-			kvm->arch.last_tsc_nsec = 0;
-			kvm->arch.last_tsc_write = 0;
+			kvm->arch.cur_tsc_write -=
+				kvm_scale_tsc(delta_cyc,
+					      kvm->arch.cur_tsc_scaling_ratio);
 		}
 
 	}
-- 
2.54.0

