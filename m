Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867938A72B;
	Sat,  9 May 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366930; cv=none; b=r3uv6CbH5HcMZcGWOBWIVGwoDaqvMK5rLpwRd9n/H5CGs2DFxh6gE2qE+5sQB1L84sRkZrXN9lm5WuoxDNePpllYcutOQ2KNNWIChwEWn70uaQ2kE5b6sb2i0GYkdkxObZGbieY3x7knYMrwC+qf9o8ibh/Hw+07Ke74CLQgFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366930; c=relaxed/simple;
	bh=6eRgO9a0TdMyl3kDNezPfvarIKiMvJQm1IFVVZsAcA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdBj7sVc7zsNsjC5I/IO3dP/7AoX29gyqFphPzO+NdpdacmaQj1FTWWMlfPtDTv0m71PUVUrMh3C5N2Wvwuv4CkobxXYlBz8pKTCDlsq9pxE2gqWHRX8p7NbAvvl9uGiZKQ60f6qGgNUUSz6ziRGMK4gCcDzn5FufBAFzqZfRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WH1+Pf0s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WH1+Pf0s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=wfrMtj5ZnQw5qzm4tVj9nJs76L69YTBE+psOfwhJUqs=; b=WH1+Pf0sgeUE/1kLOZi2zQe61+
	clX/XjFXxTT+HlO735BJ+oBKA2xFoMIwzCRYs9uPFc+tsR2LTvxBT9YU2rhNSq4xECjvRfuLc5zvP
	uUPr2hiZ/luP/qeJhQYWXATigOx1W799RsiWGCpFIGVbB6n1zkpYPwFnjZDgbFJLCzS+5x7nuIzvk
	aISbB4j22HT0p5iIcmczYYifqI4UCo1f4iaIVWGou3HmdziKDWtow1GUkQEwb1vSxtNUPcvB1WESA
	20D4xRu8stcXhQ493WDRq1vz29jJfNmBc2S8KOifh8+DNtKnbo0Js6r6FJVLPKtAmF3LKaTEaWwmV
	SJuOPcbw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wz6-0Xpp;
	Sat, 09 May 2026 22:48:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTB-0000000DhHM-4BHL;
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
Subject: [PATCH v4 02/30] KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
Date: Sat,  9 May 2026 23:46:28 +0100
Message-ID: <20260509224824.3264567-3-dwmw2@infradead.org>
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

The kvm_guest_time_update() function scales the host TSC frequency to
the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
scaling ratio previously calculated for that vCPU. Then calculates the
scaling factors for the KVM clock itself based on that guest TSC
frequency.

However, it uses kHz as the unit when scaling, and then multiplies by
1000 only at the end.

With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
the KVM clock advertised to the guest is based on a frequency of
2,499,999,000 Hz.

By using Hz as the unit from the beginning, the KVM clock would be based
on a more accurate frequency of 2,499,999,999 Hz in this example.

Use u64 for the hw_tsc_hz field since an unsigned int would overflow for
TSC frequencies above 4GHz. Use div_u64() for the Xen CPUID leaf to
play nice with 32-bit kernels.

Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/cpuid.c            |  2 +-
 arch/x86/kvm/x86.c              | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..37264212c7df 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -950,7 +950,7 @@ struct kvm_vcpu_arch {
 	gpa_t time;
 	s8  pvclock_tsc_shift;
 	u32 pvclock_tsc_mul;
-	unsigned int hw_tsc_khz;
+	u64 hw_tsc_hz;
 	struct gfn_to_pfn_cache pv_time;
 	/* set guest stopped flag in pvclock flags field */
 	bool pvclock_set_guest_stopped_request;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..621d950ec692 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2131,7 +2131,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 				*ecx = vcpu->arch.pvclock_tsc_mul;
 				*edx = vcpu->arch.pvclock_tsc_shift;
 			} else if (index == 2) {
-				*eax = vcpu->arch.hw_tsc_khz;
+				*eax = div_u64(vcpu->arch.hw_tsc_hz, 1000);
 			}
 		}
 	} else {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..d9ef165df6a1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3314,7 +3314,8 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags, tgt_tsc_khz;
+	unsigned long flags;
+	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct kvm_arch *ka = &v->kvm->arch;
@@ -3340,8 +3341,8 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
-	tgt_tsc_khz = get_cpu_tsc_khz();
-	if (unlikely(tgt_tsc_khz == 0)) {
+	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
+	if (unlikely(tgt_tsc_hz == 0)) {
 		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
@@ -3376,16 +3377,16 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	/* With all the info we got, fill in the values */
 
 	if (kvm_caps.has_tsc_control) {
-		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
+		tgt_tsc_hz = kvm_scale_tsc(tgt_tsc_hz,
 					    v->arch.l1_tsc_scaling_ratio);
-		tgt_tsc_khz = tgt_tsc_khz ? : 1;
+		tgt_tsc_hz = tgt_tsc_hz ? : 1;
 	}
 
-	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
-		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
+	if (unlikely(vcpu->hw_tsc_hz != tgt_tsc_hz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_hz,
 				   &vcpu->pvclock_tsc_shift,
 				   &vcpu->pvclock_tsc_mul);
-		vcpu->hw_tsc_khz = tgt_tsc_khz;
+		vcpu->hw_tsc_hz = tgt_tsc_hz;
 	}
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
-- 
2.51.0

