Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DF3F4117;
	Mon,  8 Jun 2026 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930525; cv=none; b=EL9jEnqRS7C8Ya5tXv+67DfesZYC1vV+gUYS5ZH6TMHFQt9BVmiQzW5NEnFW4HttT7KMbjtvdxsQsrm0LQWK/C+RPK0C8GRdsPsFUxyKcXDVX0Y2Ifdh0vImcC1WSJZ2H5NivRzbVMeDGZHo6ssMXGel5xqzWrReo9Bb7IW7W/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930525; c=relaxed/simple;
	bh=NmfD/XR9Mts1sc8UY9uFVGl+EIbudCJcNuUXuEoLzsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDWThVDxZKnlEKLLkApUICAByVrIXOCtaH/971pnF1vRTeMK9Xhwhdf90Z/6RbvpMYK19U+2bj9+KJxnTKzOZBeJAOILUJgaTq5Nosg7PUxTEZQaQ4fJ4fLx5GZsaeC3fwIdpDbpkn0HtHJ+TDOE5tjSGBNR1hhPBZJ2kkiI18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kLSsiyZS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kLSsiyZS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=xzlpkIa4DyVp/6DXKWYEMYtET/4mCymMWHGnH0+qq44=; b=kLSsiyZSY0uGzPuLZzMZQccrVR
	oTMwbu3mZjvmNhy96ViattvnzwQ+QV18hQW7ybAGW1CGjiQhSeUgL2J4Jzj//FNmuQjhiM0CxEQS1
	CDwWtDn9r+BmPjdxWsklCo4lGIEq6WfFOT2E6hnWdy0iLskgVQrHnnU/3eWGPG2+gm8q2W01vA/uB
	sH8MdtdYARjHCHwjGxL1mHLSn3+DXcpzJcHVbVjJ6FZjMQAnyAfpkiSIGG9+XMGd7geUCTibXf2bO
	l/0m5k9Z077Xju2PFw+r28+BrkRx24ypwLqcU9YBjtrc0aDa81AjhM3lirvqUrHRDgaDoCuX/t+cQ
	7JLgP+GQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNU-00000001Afx-2Mwq;
	Mon, 08 Jun 2026 14:55:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNR-00000000NEw-3Lzb;
	Mon, 08 Jun 2026 15:54:57 +0100
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
Subject: [PATCH v5 09/34] KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
Date: Mon,  8 Jun 2026 15:47:50 +0100
Message-ID: <20260608145455.89187-10-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to monotonic raw
clock") did so only for 64-bit hosts, by capturing the boot offset from
within the existing clocksource notifier update_pvclock_gtod().

That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
clocksource changes") but only on x86_64, because its original purpose
was just to disable the "master clock" mode which is only supported on
x86_64.

Now that the notifier is used for more than disabling master clock mode,
enable it for the 32-bit build too so that get_kvmclock_base_ns() can be
unaffected by NTP sync on 32-bit too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6337f9b9d7ac..50bd2871b051 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2342,7 +2342,6 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }
 
-#ifdef CONFIG_X86_64
 struct pvclock_clock {
 	int vclock_mode;
 	u64 cycle_last;
@@ -2400,13 +2399,6 @@ static s64 get_kvmclock_base_ns(void)
 	/* Count up from boot time, but with the frequency of the raw clock.  */
 	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
 }
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-	return ktime_get_boottime_ns();
-}
-#endif
 
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
 {
@@ -10173,6 +10165,7 @@ static void pvclock_irq_work_fn(struct irq_work *w)
 }
 
 static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
+#endif
 
 /*
  * Notification about pvclock gtod data update.
@@ -10180,26 +10173,26 @@ static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
 static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 			       void *priv)
 {
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	struct timekeeper *tk = priv;
 
 	update_pvclock_gtod(tk);
 
+#ifdef CONFIG_X86_64
 	/*
 	 * Disable master clock if host does not trust, or does not use,
 	 * TSC based clocksource. Delegate queue_work() to irq_work as
 	 * this is invoked with tk_core.seq write held.
 	 */
-	if (!gtod_is_based_on_tsc(gtod->clock.vclock_mode) &&
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode) &&
 	    atomic_read(&kvm_guest_has_master_clock) != 0)
 		irq_work_queue(&pvclock_irq_work);
+#endif
 	return 0;
 }
 
 static struct notifier_block pvclock_gtod_notifier = {
 	.notifier_call = pvclock_gtod_notify,
 };
-#endif
 
 void kvm_setup_xss_caps(void)
 {
@@ -10388,9 +10381,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
-#ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
+#ifdef CONFIG_X86_64
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
@@ -10447,8 +10440,8 @@ void kvm_x86_vendor_exit(void)
 					    CPUFREQ_TRANSITION_NOTIFIER);
 		cpuhp_remove_state_nocalls(CPUHP_AP_X86_KVM_CLK_ONLINE);
 	}
-#ifdef CONFIG_X86_64
 	pvclock_gtod_unregister_notifier(&pvclock_gtod_notifier);
+#ifdef CONFIG_X86_64
 	irq_work_sync(&pvclock_irq_work);
 	cancel_work_sync(&pvclock_gtod_work);
 #endif
-- 
2.54.0

