Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033903D9042;
	Sat,  9 May 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366944; cv=none; b=cBr+Mu/64Q+m788QdojLvbFA4uY2WTMiPMR6/MH0TfRvvCqKU0yS7sfK10SJ5CKyQNAmytJbtgnF8gPFkiLLX00wuxdpjknJ23+aSp9C1H1vJteRdmdNtOfERBJ82RbtLMmS59T+QJy4qT4YbIxJTdUcj4xx4gXIysc5TpJDLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366944; c=relaxed/simple;
	bh=/XpNXklW/9qV8vmEf2dfdIBHHO5PfolfGSfgulHimNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwbzGLrFX8kxCQONylVq/MOmhUI4JwnnuKpidXO+sk2VPttQIFjd8ClGKmtWr33syPOL9c/HXYKk51PUf0Uvgp2+FKAODMBJpQZeMAB4vYN2aWYBEEN1HLB0+B7OZtkd8jBK8C9OmW1XTHEYsqNfwFxcbb2XMILb45Qi6YwOGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QRXeSw9e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRXeSw9e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=gfI2hlP2ghO7kkyYaxpeS6acpLBXM/Xjzeg1dOVvOBY=; b=QRXeSw9e0EZn2zrMh0ZMFdeOuH
	gWYH1Am3+0BI9z6x5jPUh85q3k5sy+S+6PCYf+8U0ulYWYrn5/9WtjOSvz+Fb4yRPvNn8wMEVq2Ee
	FqXuKANiZmVNTzEwuvyyzfQAkk5rPcDM94g8+018sWE0TCxEZYMBGG0dANDcR7FGqRlFbpFf7uuVt
	L++xNEjHUy1cqZyLQx3TVzs2EHXd6EoPsZIbj3oBDvKW5wu6DgH0+fohc1QpxXw+gtceIic+69G9B
	p1nYyIjwdlj0NMHJxzeg3E8VYyVWxIgA+QxNsssMNKPpcSi3HsTIune8KieKthZ++YCViDvVKCj83
	1riSTOmA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzL-0Tzi;
	Sat, 09 May 2026 22:48:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhIn-0aFl;
	Sat, 09 May 2026 23:48:27 +0100
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
Subject: [PATCH v4 24/30] KVM: x86: Avoid gratuitous global clock updates
Date: Sat,  9 May 2026 23:46:50 +0100
Message-ID: <20260509224824.3264567-25-dwmw2@infradead.org>
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

Eliminate three sources of unnecessary KVM_REQ_GLOBAL_CLOCK_UPDATE:

1. kvm_write_system_time(): The global clock update was a workaround for
   ever-drifting clocks based on the host's CLOCK_MONOTONIC subject to
   NTP skew. On booting or resuming a guest, it just leads to running
   kvm_guest_time_update() twice for each vCPU for no good reason. Use
   KVM_REQ_CLOCK_UPDATE on the vCPU itself, and only when the clock is
   being enabled, not disabled.

2. kvm_arch_vcpu_load(): Use KVM_REQ_CLOCK_UPDATE instead of
   KVM_REQ_GLOBAL_CLOCK_UPDATE. There is no need to update all vCPUs'
   clocks when one vCPU is loaded.

3. kvm_gen_kvmclock_update(): Skip the periodic global update entirely
   when in master clock mode, since the clock is defined precisely by
   the guest TSC and doesn't drift.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0656d901fe79..7d9ec0638d28 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2457,13 +2457,13 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	}
 
 	vcpu->arch.time = system_time;
-	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 
 	/* we verify if the enable bit is set... */
-	if (system_time & 1)
+	if (system_time & 1) {
 		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
 				 sizeof(struct pvclock_vcpu_time_info));
-	else
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+	} else
 		kvm_gpc_deactivate(&vcpu->arch.pv_time);
 
 	return;
@@ -3638,6 +3638,10 @@ static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
 	struct kvm_vcpu *vcpu;
 	struct kvm *kvm = v->kvm;
 
+	/* In master clock mode, the clock doesn't need periodic updates. */
+	if (kvm->arch.use_master_clock)
+		return;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		kvm_vcpu_kick(vcpu);
@@ -5339,7 +5343,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 * kvmclock on vcpu->cpu migration
 		 */
 		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
-			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		if (vcpu->cpu != cpu)
 			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
 		vcpu->cpu = cpu;
-- 
2.51.0

