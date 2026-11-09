Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187280;
	b=l6qH+TVYUbbd3Oj+/h1NWfaIOsmhDUpT2UuQ4pNX71X0fTRJ1tds48BAfPg1p/OTse13
	 eycI99S6lMw3bxeSDBq/huRAgZKbV2W/RXDnRyIcOeWTYwjFtfp+WMcaHuZADIZPPZ2jz
	 CXhtzP5jHt4g8F/ve3ctqmJJiNTUcaHmftvcroRI4Q7dmodVeYQO2LSg+HUQeB7oh7LGL
	 PNSAhp8/qeXcgCA+gvm6EQl8S/LLAngSoiFC6NAzx9DbmYKNyhL6pOc/R93EEZcutBQcA
	 /izHWFGfS5NJdh1WfuYX76qdiXTcuq8jXKXmLvYZx19F94J9oNhx+5dG6cJbSKILoAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=hMvljJnllU7aDRXmXMvZrMdzo7ACgZ9fJ569T/ac5uM=;
	b=ua44IFRrbwkjgdARcvjarhUwvf0Mze5OR4yHW9V4n4BAAO/7Yhjz9B4IdpYfRukKwVb6
	 Wzp8PYAlRhZ9/9knuSz16nfr/nT0WaKkUK0IX0+h2hpBzZW0uDVp/GczHdEV+OZepUe9I
	 rH18lZlrFDTp8lerSNMN4rFmVCL/cbR3HdaEoSRcwo2059tSnN/rt5Z2YxH3yihXI9oXl
	 2lx4PXNEwjPICRT321cBjj57A2ELG0AglmPWdYmsMEDcReog0N9FC6yUdUigqlE3G6EfL
	 8S6ZUNU5XLgmHrbGtZU0exA0XLUJ+ucpFdTQGbScRGG4eer+U9c1qM0PMuL4TLNhBbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KKFNx3dO;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B5606A331;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714B5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KKFNx3dO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hMvljJnllU7aDRXmXMvZrMdzo7ACgZ9fJ569T/ac5uM=; b=KKFNx3dOVMS9oS3gP03ZDQC80V
	a0QXN3E6tXhOyT4C0udEbqQ6COzincx/L8+MphVECcNxues0E3zqg3i6Y0Lgf/T/aY5sZ55pwto7G
	Ktvx1AQQWrxNnvldgoSUpSoDVtsPEG7HqVk71jqU75egEv5kS9GrzME5yro6+1g9uRnN94DeIrTCI
	ScL8W0jiqBNpa3pDU4aTcPiCymwlcdSjxR1Ad+CDAGo9u+MUnYgJbbAOAkIxBBkdrTqBP0LUnvy2F
	tmySDeOka1cESQEi2iI7Rp7JcjJlp82WrqPlxHdHeWy2S6JOCSF7KvLqK0tPnRT3Q9HEspUDVk+dw
	xzPKpwLg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4O-00000007Pvu-3wfB;
	Mon, 09 Nov 2026 01:21:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUV-2uCe;
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
Subject: [PATCH v12 07/24] KVM: x86: Avoid redundant masterclock updates from multiple vCPUs
Date: Sun,  8 Nov 2026 17:20:53 -0800
Message-ID: <20261109012112.3415328-8-dwmw2@infradead.org>
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

kvm_end_pvclock_update() now broadcasts KVM_REQ_CLOCK_UPDATE and clears
KVM_REQ_MCLOCK_INPROGRESS while still inside the interrupts-off lock
section with the seqcount held open. That ordering is load-bearing for
the bail-out path: a vCPU whose request was consumed by another updater
must be guaranteed to observe either the open seqcount or its pending
KVM_REQ_CLOCK_UPDATE before it can enter the guest.

Since the update now consumes pending KVM_REQ_MASTERCLOCK_UPDATE
requests, the Hyper-V reenlightenment notifier must invalidate the
Hyper-V TSC page itself; previously a pending request survived the
notifier and refreshed the page via kvm_update_masterclock() later.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kvm/msrs.c | 11 ++++--
 arch/x86/kvm/x86.c  | 89 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index a2dffa1c706f..26eb30f10c43 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1278,10 +1278,15 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 
 	if (vcpu->vcpu_id == 0 && !host_initiated) {
-		if (ka->boot_vcpu_runs_old_kvmclock != old_msr)
+		/*
+		 * Store the flag before requesting the masterclock update:
+		 * the update may now be performed by another vCPU (which
+		 * consumes this request), and it must observe the new value.
+		 */
+		if (ka->boot_vcpu_runs_old_kvmclock != old_msr) {
+			ka->boot_vcpu_runs_old_kvmclock = old_msr;
 			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
-
-		ka->boot_vcpu_runs_old_kvmclock = old_msr;
+		}
 	}
 
 	vcpu->arch.time = system_time;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0348f24cfd1d..290a3c3bb44f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1733,10 +1733,51 @@ static void kvm_make_mclock_inprogress_request(struct kvm *kvm)
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
+	 * for the lock, our request will have been cleared. Bail out,
+	 * clearing the KVM_REQ_MCLOCK_INPROGRESS kicks made on entry to
+	 * kvm_update_masterclock() so vCPUs can enter the guest again.
+	 *
+	 * Clearing them VM-wide can also clear kicks just made by yet
+	 * another updater still waiting for tsc_write_lock, letting
+	 * vCPUs run while that update is in flight. That is not new:
+	 * kvm_end_pvclock_update() has always cleared the request on
+	 * every vCPU regardless of which updater made it. The window is
+	 * harmless to readers (the pvclock seqcount covers the master
+	 * state); a vCPU which slips in runs on the old snapshot until
+	 * its KVM_REQ_CLOCK_UPDATE is serviced, exactly as if it had
+	 * entered just before the update began.
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
@@ -1744,7 +1785,7 @@ static void kvm_start_pvclock_update(struct kvm *kvm)
 	kvm_make_mclock_inprogress_request(kvm);
 
 	/* no guest entries from this point */
-	__kvm_start_pvclock_update(kvm);
+	__kvm_start_pvclock_update(kvm, NULL);
 }
 
 static void kvm_end_pvclock_update(struct kvm *kvm)
@@ -1753,22 +1794,35 @@ static void kvm_end_pvclock_update(struct kvm *kvm)
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
+	/*
+	 * The Hyper-V TSC page request is made before the dedupe check
+	 * in __kvm_start_pvclock_update() because it takes a mutex and
+	 * so cannot sit inside the tsc_write_lock critical section where
+	 * the winning updater is known. A losing vCPU may therefore mark
+	 * the page HOST_CHANGED after the winner has already rewritten
+	 * it; the next clock update then rewrites the page again with
+	 * the same contents, which the TSC-page sequence protocol makes
+	 * safe against concurrently running guests.
+	 */
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
@@ -6869,7 +6923,14 @@ static void kvm_hyperv_tsc_notifier(void)
 	kvm_caps.max_guest_tsc_khz = tsc_khz;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		__kvm_start_pvclock_update(kvm);
+		/*
+		 * Invalidate the Hyper-V TSC page explicitly: the update
+		 * below consumes any pending KVM_REQ_MASTERCLOCK_UPDATE,
+		 * which would otherwise have refreshed the page from
+		 * kvm_update_masterclock().
+		 */
+		kvm_hv_request_tsc_page_update(kvm);
+		__kvm_start_pvclock_update(kvm, NULL);
 		pvclock_update_vm_gtod_copy(kvm);
 		kvm_end_pvclock_update(kvm);
 	}
@@ -8275,8 +8336,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
@@ -9665,7 +9726,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
 	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
-		kvm_update_masterclock(vcpu->kvm);
+		kvm_update_masterclock(vcpu->kvm, NULL);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.43.0

