Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=fjGLwlkmSJIvTPH1YjG2s59lt6XIWGN3EVOYKSYCHSDfu3FWnWtcbAKfxhumCSFHtuhn
	 LvrMRXmT4RlhQfbctAQfzam6R15WJiRsHTRh2sesfTlyuEO7fFYXIZA/lmgHA8aPmqb/T
	 GHmemD/IBFuFFj5Ef+JwVg30WuoQ21Yb0N82Vv7h2y8j4/22Ao/UyOUMpSurHgK7vvpif
	 uQktza/N8O5DRFPE/Zcu6aGrz0UF34il707ki0AEZKmsOfSS7zc+NAHCAbP2Gc6yFMFXW
	 l+ahQRd3kdLj807nd0g27kCIik661lAh0OshWZUWd2wJUVThRMr03rhh1u1KT6vZ/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=1V/mMwjMcC+MDxHM1oxRcKL+FYzfa4UsShC/QgnT6ts=;
	b=UHvq9hO1ACn4MJ/p20Ma1jzzPw5ZMs9jC21sTYxsHjwUlTYEBJebh/lkgou4+a6vSQ9v
	 gXm+I0BtwpHagULJ+OukpXUqnij0t1OKCO/if7bOXI/WhcTLYjgDMzoHSnvsR7m5XjGky
	 5Ehs19KE6tUlhDQ4NO3qUmWiFfXcpFD20zU/lHuv3NY/J8nhLdzt2nGpde2uDWndJDrnH
	 eLWa2Evz8+zzdrWzer6imeVcP2M6Afh3PV29WGmfHmJZHgZxAhSrgxUTGZgrL0ASJOVZY
	 d87XR/8MFpF3nnrwSs6ys5bk1Jce4Mg1s2xitJRCeZnaDpeO8scHQVd5kiZ27TqMhTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rdCdM0Bg;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09A606C155;
	Wed, 11 Nov 2026 18:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B09A606C155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rdCdM0Bg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=1V/mMwjMcC+MDxHM1oxRcKL+FYzfa4UsShC/QgnT6ts=; b=rdCdM0Bga8RtX//t2h5oWGV5nk
	NrobMdHnlsWWu0fgt/I6d+ha7L+1JiD2Yc69jvBxcI0t87Fu1wdOzrbXUF9Sl9320wCVdwrZw9cJj
	NbhmdPRAuOGTvIuEGQLSGH9X+krDkyse4Uw4uoGtbdSBbLPrCx26hLJfYW/Yiz3obm/FgivEyR71R
	KOTaGZLj6mqMvr1sMoN9zYhouAr/CwehIYcUGB+yqMCzdNILkxNX+221aePpyOCf+nOIMb5T6xD5m
	B1LVp9DnDtrKs93W47JR2nQ+MoRKidU8EDEwvrJ/xvN0opSznxIg6wJh1sgPhmS7Vl3rjPD7iBDcr
	4P99dECw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvM-3ChP;
	Wed, 11 Nov 2026 18:09:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsS-0BMB;
	Wed, 11 Nov 2026 18:09:23 +0000
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
Subject: [PATCH v13 07/26] KVM: x86: Don't latch the Hyper-V TSC page from a superseded snapshot
Date: Wed, 11 Nov 2026 10:09:03 -0800
Message-ID: <20261111180922.4177927-8-dwmw2@infradead.org>
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

The Hyper-V TSC page is rewritten from kvm_guest_time_update() when its
HOST_CHANGED state is set, and latches to HV_TSC_PAGE_SET, which blocks
further rewrites. But the state is set before the new pvclock snapshot
is published (setting it takes hv_lock, a mutex, so it cannot happen
inside the tsc_write_lock section), and nothing validates the snapshot
the consumer is holding. Two interleavings latch stale parameters which
nothing then rewrites until some unrelated clock event invalidates the
page again:

 - A vCPU handling an unrelated KVM_REQ_CLOCK_UPDATE completes its
   pvclock read, is preempted (or sleeps in kvm_write_guest(), holding
   hv_lock), a KVM_SET_CLOCK completes meanwhile, and the vCPU then
   writes the page from the old snapshot and sets HV_TSC_PAGE_SET —
   consuming the state intended for the new one.

 - The state is consumed legitimately an instant before the publish,
   writing values which were current at that moment and superseded the
   next; the CLOCK_UPDATE broadcast which follows the publish finds
   HV_TSC_PAGE_SET and rewrites nothing.

For a KVM_SET_CLOCK stepping kvmclock_offset — a live migration
restore — the page is left disagreeing with the restored clock by the
full step.

Close the first at the consumer: kvm_hv_setup_tsc_page() revalidates
the pvclock seqcount under hv_lock — it must be under the lock, or the
consumer could be preempted between a check and the consumption — and
requeues the clock update rather than consume the state against a
superseded snapshot. Close the second by re-marking the page once the
new snapshot is published, with a CLOCK_UPDATE queued on every vCPU
behind the re-mark: the broadcast from kvm_end_pvclock_update() can
have been entirely consumed by then, and no vCPU in particular is
guaranteed to ever run again. The hv_lock mutex which lets a consumer
sleep across the whole update is also what serializes its write
against the re-mark, so the queued consumer always finds either fresh
page contents or the HOST_CHANGED state; guests which never enabled
the page skip the broadcast entirely.

Fixes: cc9cfddb0433 ("KVM: x86: hyper-v: Track Hyper-V TSC page status")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 20 ++++++++++++++++++--
 arch/x86/kvm/hyperv.h | 10 ++++++----
 arch/x86/kvm/x86.c    | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..56da410a7f32 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1182,9 +1182,11 @@ static inline bool tsc_page_update_unsafe(struct kvm_hv *hv)
 		hv->hv_tsc_emulation_control;
 }
 
-void kvm_hv_setup_tsc_page(struct kvm *kvm,
-			   struct pvclock_vcpu_time_info *hv_clock)
+void kvm_hv_setup_tsc_page(struct kvm_vcpu *v,
+			   struct pvclock_vcpu_time_info *hv_clock,
+			   unsigned int seq)
 {
+	struct kvm *kvm = v->kvm;
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	u32 tsc_seq;
 	u64 gfn;
@@ -1202,6 +1204,20 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 	if (!(hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE))
 		return;
 
+	/*
+	 * @hv_clock derives from the pvclock snapshot current at @seq.
+	 * Consuming the HOST_CHANGED state against a superseded snapshot
+	 * would latch stale parameters as HV_TSC_PAGE_SET, which nothing
+	 * then rewrites; the check must be made here, under hv_lock, or
+	 * this vCPU could be preempted between a check and the
+	 * consumption while an update completes. Leave the state alone
+	 * and requeue; the retry reads the new snapshot.
+	 */
+	if (read_seqcount_retry(&kvm->arch.pvclock_sc, seq)) {
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
+		return;
+	}
+
 	gfn = hv->hv_tsc_page >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
 	/*
 	 * Because the TSC parameters only vary when there is a
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 622a6553e9ac..62e7922440aa 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -284,8 +284,9 @@ static inline bool kvm_hv_invtsc_suppressed(struct kvm_vcpu *vcpu)
 
 void kvm_hv_process_stimers(struct kvm_vcpu *vcpu);
 
-void kvm_hv_setup_tsc_page(struct kvm *kvm,
-			   struct pvclock_vcpu_time_info *hv_clock);
+void kvm_hv_setup_tsc_page(struct kvm_vcpu *v,
+			   struct pvclock_vcpu_time_info *hv_clock,
+			   unsigned int seq);
 void kvm_hv_request_tsc_page_update(struct kvm *kvm);
 
 void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu);
@@ -377,8 +378,9 @@ static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu,
 
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
 #else /* CONFIG_KVM_HYPERV */
-static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
-					 struct pvclock_vcpu_time_info *hv_clock) {}
+static inline void kvm_hv_setup_tsc_page(struct kvm_vcpu *v,
+					 struct pvclock_vcpu_time_info *hv_clock,
+					 unsigned int seq) {}
 static inline void kvm_hv_request_tsc_page_update(struct kvm *kvm) {}
 static inline void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu) {}
 static inline void kvm_hv_init_vm(struct kvm *kvm) {}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 05c801973a7f..f7af94d8b3bb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1789,6 +1789,36 @@ static void kvm_end_pvclock_update(struct kvm *kvm)
 		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
 }
 
+/*
+ * Re-mark the Hyper-V TSC page once a new pvclock snapshot is published:
+ * the mark made before the update may have been legitimately consumed an
+ * instant before the publish, writing values the publish then superseded.
+ * The consumer must be queued after the re-mark: the CLOCK_UPDATE
+ * broadcast from kvm_end_pvclock_update() can have been entirely consumed
+ * by the time the re-mark lands, since a consumer may sleep in
+ * kvm_hv_setup_tsc_page() (hv_lock is a mutex) across the whole update —
+ * the same sleep which serializes it against this re-mark. Queue on
+ * every vCPU: any one suffices (the page is VM-wide), but none in
+ * particular is guaranteed to ever run again.
+ */
+static void kvm_hv_remark_tsc_page(struct kvm *kvm)
+{
+#ifdef CONFIG_KVM_HYPERV
+	kvm_hv_request_tsc_page_update(kvm);
+
+	/*
+	 * Racy, but benign: a transition to HV_TSC_PAGE_SET in the
+	 * instants after the re-mark means a consumer has just written
+	 * the page from the current snapshot, and a guest which never
+	 * enabled the page (UNSET/BROKEN, the common case) needs no
+	 * broadcast at all.
+	 */
+	if (READ_ONCE(to_kvm_hv(kvm)->hv_tsc_page_status) ==
+	    HV_TSC_PAGE_HOST_CHANGED)
+		kvm_make_all_cpus_request(kvm, KVM_REQ_CLOCK_UPDATE);
+#endif
+}
+
 static void kvm_update_masterclock(struct kvm *kvm)
 {
 	kvm_hv_request_tsc_page_update(kvm);
@@ -1961,6 +1991,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 #else
 	const bool use_master_clock = false;
+	unsigned int seq = read_seqcount_begin(&ka->pvclock_sc);
 #endif
 	/*
 	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
@@ -2056,7 +2087,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 		hv_clock.flags &= ~PVCLOCK_GUEST_STOPPED;
 	}
 
-	kvm_hv_setup_tsc_page(v->kvm, &hv_clock);
+	kvm_hv_setup_tsc_page(v, &hv_clock, seq);
 
 #ifdef CONFIG_KVM_XEN
 	/*
@@ -4572,6 +4603,9 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 		now_raw_ns = get_kvmclock_base_ns();
 	ka->kvmclock_offset = data.clock - now_raw_ns;
 	kvm_end_pvclock_update(kvm);
+
+	/* As in kvm_update_masterclock(): re-mark after publishing. */
+	kvm_hv_remark_tsc_page(kvm);
 	return 0;
 }
 
-- 
2.43.0

