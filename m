Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C43B19CA;
	Fri,  5 Jun 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669850; cv=none; b=iGDZ3CL4QANdkG1INfPd5R69JL5kjxyVuZbpOPpdzBbE2t9KmhBaPU8PMeSjI0u7nFsD/E2/O+Ds5WWyoduuAC+EtW0mFGvVd9t1UjbYMKzdLPj0QNL8OL9be7URjIod9hF4Qbjyee3wmMx6920VrOvgWdU5olsjaIvDPFNA3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669850; c=relaxed/simple;
	bh=DNnGn2OnfpPBVTZZIweivJoAdbtiO5JytDbfWNhUziE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGtlMS2rnSqstv5vi2CkavYJU27tXPkC5oYVALvYWtbG64Cb/p/7ngIXHmhcGi5h9ISOlPgQmkYSPWT3ZthvmTl/7c8ZLWkciFQD09sH8bBxaLZUIZG2JTT2f4M0o1RAxCR1xQ1WZ0GEv7e9KdJWBg9uNU73n8/54RTLmjCrPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bMT/MRk6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMT/MRk6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YCyxV+ifjXIAhZC0d0vp2nQWP3P1f4jws00DSBIbGQY=; b=bMT/MRk6B5CMIVz0D9bt6Te6Da
	FkviKAIEwIpfMINoNl/YFiuB/FAfgq4uOACoWvVIGZPgfZTst7IPR7jab6t//mas+f0Him7pENPDW
	Cg6pytAv8e8gitZVsP1MGLMyjKWQaVh6wfqR2f91MV998Vojt/sIHCGdy33UGdAtRITuLSI4PneRS
	e+ciR6uohbFQlN1Hrp1U/uCj8NMtlLvVascJfZJFvjKfEaf6vZL7F2E0ipyG9L1Zx8k14eRFZSnSC
	/Lb723w1gSDGatiztA5qdHUtVJ2nDaQAr5CrsXBoT/kBXKaZBYr0gn1Jcyz95THp8EWJdABMdbmBh
	NSHeyk+g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848d-26wE;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013U-1Ij3;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
Date: Fri,  5 Jun 2026 15:17:27 +0100
Message-ID: <20260605143034.3603-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
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

Add a kvm_xen_has_64bit_shinfo() helper macro to replace the repeated
pattern of 'IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode'
throughout the Xen emulation code. The macro uses READ_ONCE() to
ensure a consistent snapshot of the flag, which can be changed by
another vCPU at any time.

This is the KVM equivalent of Xen's !has_32bit_shinfo().

Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 16 ++++++++--------
 arch/x86/kvm/xen.h |  5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a7ab19f38b59..acd3cd87dd2f 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -72,7 +72,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	BUILD_BUG_ON(offsetof(struct shared_info, wc) != 0xc00);
 	BUILD_BUG_ON(offsetof(struct shared_info, wc_sec_hi) != 0xc0c);
 
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+	if (kvm_xen_has_64bit_shinfo(kvm)) {
 		struct shared_info *shinfo = gpc->khva;
 
 		wc_sec_hi = &shinfo->wc_sec_hi;
@@ -390,7 +390,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	BUILD_BUG_ON(sizeof_field(struct vcpu_runstate_info, time) !=
 		     sizeof(vx->runstate_times));
 
-	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
+	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		user_len = sizeof(struct vcpu_runstate_info);
 		times_ofs = offsetof(struct vcpu_runstate_info,
 				     state_entry_time);
@@ -661,7 +661,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	}
 
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
-	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode) {
+	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		struct vcpu_info *vi = gpc->khva;
 
 		asm volatile(LOCK_PREFIX "orq %0, %1\n"
@@ -978,7 +978,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		 * address, that's actually OK. kvm_xen_update_runstate_guest()
 		 * will cope.
 		 */
-		if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode)
+		if (kvm_xen_has_64bit_shinfo(vcpu->kvm))
 			sz = sizeof(struct vcpu_runstate_info);
 		else
 			sz = sizeof(struct compat_vcpu_runstate_info);
@@ -1424,7 +1424,7 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 
 static inline int max_evtchn_port(struct kvm *kvm)
 {
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode)
+	if (kvm_xen_has_64bit_shinfo(kvm))
 		return EVTCHN_2L_NR_CHANNELS;
 	else
 		return COMPAT_EVTCHN_2L_NR_CHANNELS;
@@ -1446,7 +1446,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 		goto out_rcu;
 
 	ret = false;
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+	if (kvm_xen_has_64bit_shinfo(kvm)) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	} else {
@@ -1820,7 +1820,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+	if (kvm_xen_has_64bit_shinfo(kvm)) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
@@ -1861,7 +1861,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+		if (kvm_xen_has_64bit_shinfo(kvm)) {
 			struct vcpu_info *vcpu_info = gpc->khva;
 			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 59e6128a7bd3..3e8c9306eb89 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -248,6 +248,11 @@ struct compat_shared_info {
 #define COMPAT_EVTCHN_2L_NR_CHANNELS (8 *				\
 				      sizeof_field(struct compat_shared_info, \
 						   evtchn_pending))
+
+/* Latched VM-wide mode; the KVM equivalent of Xen's !has_32bit_shinfo(). */
+#define kvm_xen_has_64bit_shinfo(kvm) \
+	(IS_ENABLED(CONFIG_64BIT) && READ_ONCE((kvm)->arch.xen.long_mode))
+
 struct compat_vcpu_runstate_info {
     int state;
     uint64_t state_entry_time;
-- 
2.54.0

