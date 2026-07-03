Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26245348C4E;
	Fri,  3 Jul 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113727; cv=none; b=kCB1IQlwbRyYAtlyaKXO934J3pfukG2nsbBQVFRu23/MjhjrPtFx/o5p9KtLZPvNrq5MIGfh1KeMKOR7JxkVAAjYUod+BLL6Lmwp2Z8unz+kZqmXCuHtTx19CvK8C2P4ORMZDzu4/KaWxQuzjCEeVngIAd1VmXeQUkcs3zVUVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113727; c=relaxed/simple;
	bh=0LNAa1ifjTFpxR26pziZghGbfpY+Md+UZhwHacc1/48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2mCWlx4xjdN9jLNdhamEgV+8L3cWOYL9iG0n+rIXSNua23Jul9VFKUsrSMoLWh9L+ucjU5gcRe0pVm+4p8EUwGHPIN99YHJ1E0r2N3PAxEThqbIDCTXQSPqqbf8/m1q9Nc8QfipcY/ru4fg63ZBZpKNFESQgbzMJe1OZY6JeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTF1YHey; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTF1YHey"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=CzWz4Us7r/rEWP66HSxuHNlM7/EVQzg+tC4fjHgL8hU=; b=mTF1YHeydnaypEa+INXWx9qXoR
	M0PqgmKfFa4z677E1dsW1eEvyWkF6xUV1PdB8gg/x+CCYBbTc8AfTSe7OkZPaq2U5ubShAbVjKgct
	kCMUrQtwKWJRjjP9W7glXLslomFXL1Uab3oPmtTv/VeXByun+aTfqAFILzp5HUTkuKh4m1NdyROs6
	HNxK1P0nee9tkb0MG2OqepLt57YqRuJjvJlfa11a8OWJs2g1z30A2IGWV3whrfTOf0xpAlQC1+teG
	DfqFxOoVBfqyecjXVw+McN+dGdz8Nmn7AjS0GmGwMHLWHq8299lfwPp8dMCfRogqtIfbHaA41RpTZ
	GQMkyl5A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflKX-0000000AsYG-1i3E;
	Fri, 03 Jul 2026 21:21:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKX-00000001RPb-1H0I;
	Fri, 03 Jul 2026 22:21:49 +0100
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
Subject: [PATCH v6 27/36] KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
Date: Fri,  3 Jul 2026 22:18:06 +0100
Message-ID: <20260703212145.343527-28-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When a masterclock update is triggered (e.g. by the clocksource change
notifier), KVM_REQ_MASTERCLOCK_UPDATE is set on all vCPUs. Without this
fix, each vCPU independently processes the request and redundantly
re-executes the entire pvclock_update_vm_gtod_copy() sequence, serialized
only by tsc_write_lock. Each redundant re-snapshot of the master clock
reference point introduces potential clock drift.

Fix this by having __kvm_start_pvclock_update() check, after acquiring
the lock, whether the requesting vCPU's KVM_REQ_MASTERCLOCK_UPDATE is
still set. If another vCPU already did the update and cleared it, bail
out. Otherwise, clear the request on all other vCPUs before proceeding.

The caller in vcpu_enter_guest() now uses kvm_test_request() (non-clearing)
since the clearing is done inside __kvm_start_pvclock_update() under the
lock.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kvm/x86.c | 60 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2a1e1a1ab6ee..80fe69974ded 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3282,10 +3282,39 @@ static void kvm_make_mclock_inprogress_request(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
 }
 
-static void __kvm_start_pvclock_update(struct kvm *kvm)
+static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
 {
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
+}
+
+static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu *requesting_vcpu)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
 	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
+
+	/*
+	 * If another vCPU already did the update while we were waiting
+	 * for the lock, our request will have been cleared. Bail out.
+	 */
+	if (requesting_vcpu &&
+	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
+		kvm_clear_mclock_inprogress_request(kvm);
+		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
+		return false;
+	}
+
+	/* The update is VM-wide; prevent other vCPUs from redoing it. */
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
+
 	write_seqcount_begin(&kvm->arch.pvclock_sc);
+	return true;
 }
 
 static void kvm_start_pvclock_update(struct kvm *kvm)
@@ -3293,7 +3322,7 @@ static void kvm_start_pvclock_update(struct kvm *kvm)
 	kvm_make_mclock_inprogress_request(kvm);
 
 	/* no guest entries from this point */
-	__kvm_start_pvclock_update(kvm);
+	__kvm_start_pvclock_update(kvm, NULL);
 }
 
 static void kvm_end_pvclock_update(struct kvm *kvm)
@@ -3302,22 +3331,25 @@ static void kvm_end_pvclock_update(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
-	write_seqcount_end(&ka->pvclock_sc);
-	raw_spin_unlock_irq(&ka->tsc_write_lock);
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 
 	/* guest entries allowed */
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
+	kvm_clear_mclock_inprogress_request(kvm);
+
+	write_seqcount_end(&ka->pvclock_sc);
+	raw_spin_unlock_irq(&ka->tsc_write_lock);
 }
 
-static void kvm_update_masterclock(struct kvm *kvm)
+static void kvm_update_masterclock(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	kvm_hv_request_tsc_page_update(kvm);
-	kvm_start_pvclock_update(kvm);
-	pvclock_update_vm_gtod_copy(kvm);
-	kvm_end_pvclock_update(kvm);
+	kvm_make_mclock_inprogress_request(kvm);
+
+	if (__kvm_start_pvclock_update(kvm, vcpu)) {
+		pvclock_update_vm_gtod_copy(kvm);
+		kvm_end_pvclock_update(kvm);
+	}
 }
 
 /*
@@ -10144,7 +10176,7 @@ static void kvm_hyperv_tsc_notifier(void)
 	kvm_caps.max_guest_tsc_khz = tsc_khz;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		__kvm_start_pvclock_update(kvm);
+		__kvm_start_pvclock_update(kvm, NULL);
 		pvclock_update_vm_gtod_copy(kvm);
 		kvm_end_pvclock_update(kvm);
 	}
@@ -11522,8 +11554,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_mmu_free_obsolete_roots(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
 			__kvm_migrate_timers(vcpu);
-		if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
-			kvm_update_masterclock(vcpu->kvm);
+		if (kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+			kvm_update_masterclock(vcpu->kvm, vcpu);
 		if (kvm_check_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu))
 			kvm_gen_kvmclock_update(vcpu);
 		if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu)) {
@@ -13260,7 +13292,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
 	if (!vcpu->kvm->arch.use_master_clock)
-		kvm_update_masterclock(vcpu->kvm);
+		kvm_update_masterclock(vcpu->kvm, NULL);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.54.0

