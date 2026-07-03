Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C85379EE2;
	Fri,  3 Jul 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113737; cv=none; b=LhAG/Ordlu5mbMmKrrcc7mkGfW5xWZz+cwJ+CnbW44Z2RME4tNFRnYidbIKB6eS1ZAB1UDA43roBu4wWIg22WleluUBo3kHfD3ePWcL5FwwOWLNCOtYnbt0HqyrxDWsbCtoUaceyZtvuMMQX/3Kver75c/UOnhNI+EE3OW5T5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113737; c=relaxed/simple;
	bh=zIfalp8LZWMiVTYMojC8XTSc1HCLAx9kHuSvjbgg5Hs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgUPTgOwOlFXES1N5jJXeFqBfOQwL4PL/xTTcqmot4h/vVBYcx48h3RIkwapGokCxPRXAHWT4L2mkliN2X5yY7wDE3EydvW/9hR4kSNeQbFJgJg9PacoaMrqhXs17SLn0hhpt9jmpLwD39KOJ+GvyQoVYXI7Ye7g+CY1DwW/Jus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HPj7neF/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPj7neF/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=s+7qUlbLcb8dcHIU9yxWWuYHzICS9PPJgOOAoGyBp5o=; b=HPj7neF/edX8jbo/JX8quja682
	cEZuozcFmVKIQrBdJlzohG2fuYYQuNFcycqs5FWy96RgLuuCtsgPNENsXWM1BtzCtDYj1EbxULEiz
	FLnDUQn4MBs3GFp1PKN0NeVRrmqEWCnvYXdjIEPT0PPSKKwX+xlLnZfg37I9KK8Dp8hRsppgYkT8k
	sJz+4rBN3tgwri8rHwondVAyaMDPbqxGfNKNT1Mf5ShXTpgoE/LlIqlFF0q2ledbnIuzB0Z2Y/oK4
	bMTCbCB/sTsOzQyuyvF7zwSQ3/zygcdDmM/tQILbMrqw5OpyejMR+PvuyewpDD3JmZASo2/07mat4
	e/rL9FOw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflKW-0000000AsY2-1TLA;
	Fri, 03 Jul 2026 21:21:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001ROP-12v9;
	Fri, 03 Jul 2026 22:21:48 +0100
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
Subject: [PATCH v6 10/36] KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
Date: Fri,  3 Jul 2026 22:17:49 +0100
Message-ID: <20260703212145.343527-11-dwmw2@infradead.org>
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
index 26b4649dfb94..21603feb44c5 100644
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
@@ -10184,6 +10176,7 @@ static void pvclock_irq_work_fn(struct irq_work *w)
 }
 
 static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
+#endif
 
 /*
  * Notification about pvclock gtod data update.
@@ -10191,26 +10184,26 @@ static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
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
@@ -10399,9 +10392,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
-#ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
+#ifdef CONFIG_X86_64
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
@@ -10458,8 +10451,8 @@ void kvm_x86_vendor_exit(void)
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

