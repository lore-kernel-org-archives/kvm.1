Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C73E0C45;
	Sat,  9 May 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366958; cv=none; b=Qc8FxoCreSn+DIQeuEOGcjX5RlvarC0uP09OHzPa5SrtIxAEXCF/o2Sk+igaofuKoMtEsCOEQYrz9c2LViFeDzPpdSjWK4wdAlUYMacCt0hP/mmfwNpH1RnpS/+a31VKtxksBMX+rbHu4kb7J3DTjflfsNbBL1A7+vUeHPtwQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366958; c=relaxed/simple;
	bh=JDA5+1Tqe0bAUIcEuNpnm50QbTVOp/8UU7ylw2FU3hA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmdmbU0NkdMYlWJQnYxUCMt/m+KgYDf0rIqllG+gkAVlbmcnlACUaBq6sVcjI/GXZv5dkYaXwNshYtONImDS0gevF0JR2icEommDAojMstNx8z+xzewyWYgY623nRHE+UaJgMdn00laTgTNlJdyT6La+jQFK4Yidzq8WKs6vov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bkTTeIeQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bkTTeIeQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=LepzYKC8zChWcqxDUMiFOK7RmizpFH9hCCvlIfnf3aY=; b=bkTTeIeQ6yjciV79dnwOCTS3X8
	kWPljQM5uuCcLf9xYvOMvxwp0BudJtlKdezBUn+2HsrUtDHGE8X85ygS5I9M1clK6zpm2ifFrsLyI
	6vHlr9bbTcd192RWw5BeCaycQCXib9QwDp+uVtaExyL6cHh0l//vCGieuOmQt3Zb6k0V42gUmdzy2
	v+X/RNkqyGK6O828YYwwQwcGi7JC5ICV2+sjdn6xRCbShFs6B4a8UPDR2YF3J0Ue6G7OcdLr2c0KW
	mS9Em/atYVqzn+EMq4KLzVjs83ETumOZCG//oet13+jOZDJ2WZbahqUjO1qRQftiPO8dK8pbrQTVE
	zPdP0YPA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzI-0OeQ;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhIH-3IBh;
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
Subject: [PATCH v4 16/30] KVM: x86: Restructure kvm_guest_time_update() for TSC upscaling
Date: Sat,  9 May 2026 23:46:42 +0100
Message-ID: <20260509224824.3264567-17-dwmw2@infradead.org>
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

Restructure kvm_guest_time_update() so that kernel_ns/host_tsc are
always "now" when doing TSC catchup, then swap in the master clock
reference values afterward for the hv_clock.

This makes the TSC upscaling code considerably simpler: the catchup
adjustment is computed as the delta between what the guest TSC *should*
be at "now" and what it actually is, rather than mixing "now" and
"master clock reference" timestamps.

The seqcount loop now also contains the kvm_get_time_and_clockread()
call (matching get_kvmclock's pattern), with the same WARN for
unexpected failure.

Based on a suggestion by Sean Christopherson.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 67 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e281c49561fa..8e4993ef4f6b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3363,39 +3363,51 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	struct kvm_arch *ka = &v->kvm->arch;
 	s64 kernel_ns;
 	u64 tsc_timestamp, host_tsc;
+	u64 master_host_tsc = 0;
+	s64 master_kernel_ns = 0;
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
-		if (use_master_clock) {
-			host_tsc = ka->master_cycle_now;
-			kernel_ns = ka->master_kernel_ns;
-		}
+
+		/*
+		 * The TSC read and the call to get_cpu_tsc_khz() must happen
+		 * on the same CPU.
+		 */
+		get_cpu();
+
+		tgt_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
+
+		if (use_master_clock &&
+		    !kvm_get_time_and_clockread(&kernel_ns, &host_tsc) &&
+		    WARN_ON_ONCE(!read_seqcount_retry(&ka->pvclock_sc, seq)))
+			use_master_clock = false;
+
+		put_cpu();
+
+		if (!use_master_clock)
+			break;
+
+		master_host_tsc = ka->master_cycle_now;
+		master_kernel_ns = ka->master_kernel_ns;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 
-	/* Keep irq disabled to prevent changes to the clock */
-	local_irq_save(flags);
-	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * 1000;
 	if (unlikely(tgt_tsc_hz == 0)) {
-		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
 	}
+
 	if (!use_master_clock) {
 		host_tsc = rdtsc();
 		kernel_ns = get_kvmclock_base_ns();
 	}
 
-	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
-
 	/*
 	 * We may have to catch up the TSC to match elapsed wall clock
 	 * time for two reasons, even if kvmclock is used.
@@ -3404,17 +3416,32 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
 
-- 
2.51.0

