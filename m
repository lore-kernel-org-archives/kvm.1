Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893807;
	b=GZTEgVmuvnm8LajnPBW9p9mxL+fiBYc1ZJC9tjjwD21FwTcAQEPjP0jj0BuGS0eFlOV8
	 //e9V0zoMtAlQenEz9E/OHx0P5IupqoogSPZKYfxvaihA+i4RF0wYO91vUkW/ZOi8hcnf
	 0wirG4/zfPWZ7IfuP3cwGp5V+tB69HW+/FUhHESUICAO+SdAIKx+vcHnrgYE2TP9mOtuK
	 /PL5UZxjJ8ksY4TpGqddGh6Q3BB308bp8DECCpg9TRHlzAN+QO+BtvtwjgWqqBzAScRlQ
	 RsW2UTT9ycqLLYV1cDgH7H+O3feirEOEet02+6nVA46GEgUWQIiQut4F4pSHO6tMZ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=+Bp/FraEPNEKgnVnaEnw6iNuhtXFkslibvECwlTvHqE=;
	b=Uu8aPKbo6cAJ9izXxqtLIwKvCAWZLuZZfvC0qONmt94ROczlXJrHPxd43RK0nWr1JDA+
	 BTkcbCtr7KQrCxEJJ46MJWdqopKWhVFd3J2Hd97CfxLGNqW33VjNkc4rkYGC7jmwP0StX
	 qAZ89GtlX+KRu9tYDwJ6vzv+G3D3ObCU9ELUg5OO/Z8uqTFE7yefJSc7SWLikIR34ENzc
	 hVM+RV+2ttwiuzHf/dKnGPKycvgHHBF99MsNJmBSq5NZZorDQvlUYVdkkaj+7yzt3DDyr
	 WDmZBJuw3U63hkzskPOKMkNjFV6oL78Nwh8wtszC8dLpTbYvc3rDNV0U7MsMQg+pG9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZcdGpA6p;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D160A6F7B;
	Thu,  5 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20D160A6F7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZcdGpA6p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+Bp/FraEPNEKgnVnaEnw6iNuhtXFkslibvECwlTvHqE=; b=ZcdGpA6p4Jpvl/hnSOPP0PjHv/
	eeUSBwF7bh55qJGD+CCING13IN7mFqESX25yk51b9VeLvgG4rbjs5xe8s0UTFKm4LqdldDD/tIZtF
	dG9+rgKGgqNn+BAiv5ZHViWGFDcT4mJofE0dNYAWQLik25Qdtkp0ppZIWLyPpyr0zLWPB/Po5fjUm
	SfkH/qeYivekcHSnsWOKZmJWKHBT/J3eS7feqBmxhrn5A22MEYZ0n23XYt2SfhqEMiY4bFLQpkXHS
	8/H/c+LfweYD+K4wNyQjIGJEe5BI/YFpAfzjG68e/WD1+lP4eOLg2hXQCYo9jfVgcSPILWa33Nuy1
	yRkQlxag==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziu-00000009aoq-0dWx;
	Thu, 05 Nov 2026 15:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOzit-0000000AazM-3xHY;
	Thu, 05 Nov 2026 15:49:55 +0000
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
Subject: [PATCH v11 10/23] KVM: x86: Remove pvclock_gtod_data and private timekeeping code
Date: Thu,  5 Nov 2026 07:49:41 -0800
Message-ID: <20261105154955.2525419-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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

Remove the now-unused KVM-private timekeeping infrastructure:

 - struct pvclock_clock and struct pvclock_gtod_data
 - update_pvclock_gtod() and its seqcount-protected state copy
   (the private readers were already removed when their last callers
   went away)

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 56 ----------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e81e527e7b99..940168528721 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -889,60 +889,6 @@ static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
 
-#ifdef CONFIG_X86_64
-struct pvclock_clock {
-	int vclock_mode;
-	u64 cycle_last;
-	u64 mask;
-	u32 mult;
-	u32 shift;
-	u64 base_cycles;
-	u64 offset;
-};
-
-struct pvclock_gtod_data {
-	seqcount_t	seq;
-
-	struct pvclock_clock clock; /* extract of a clocksource struct */
-	struct pvclock_clock raw_clock; /* extract of a clocksource struct */
-
-	ktime_t		offs_boot;
-	u64		wall_time_sec;
-};
-
-static struct pvclock_gtod_data pvclock_gtod_data;
-
-static void update_pvclock_gtod(struct timekeeper *tk)
-{
-	struct pvclock_gtod_data *vdata = &pvclock_gtod_data;
-
-	write_seqcount_begin(&vdata->seq);
-
-	/* copy pvclock gtod data */
-	vdata->clock.vclock_mode	= tk->tkr_mono.clock->vdso_clock_mode;
-	vdata->clock.cycle_last		= tk->tkr_mono.cycle_last;
-	vdata->clock.mask		= tk->tkr_mono.mask;
-	vdata->clock.mult		= tk->tkr_mono.mult;
-	vdata->clock.shift		= tk->tkr_mono.shift;
-	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
-	vdata->clock.offset		= tk->tkr_mono.base;
-
-	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->vdso_clock_mode;
-	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
-	vdata->raw_clock.mask		= tk->tkr_raw.mask;
-	vdata->raw_clock.mult		= tk->tkr_raw.mult;
-	vdata->raw_clock.shift		= tk->tkr_raw.shift;
-	vdata->raw_clock.base_cycles	= tk->tkr_raw.xtime_nsec;
-	vdata->raw_clock.offset		= tk->tkr_raw.base;
-
-	vdata->wall_time_sec            = tk->xtime_sec;
-
-	vdata->offs_boot		= tk->offs_boot;
-
-	write_seqcount_end(&vdata->seq);
-}
-#endif
-
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
@@ -7092,8 +7038,6 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 {
 	struct timekeeper *tk = priv;
 
-	update_pvclock_gtod(tk);
-
 	/*
 	 * Pairs with the READ_ONCE() in the lockless readers; the race is
 	 * benign by design, relying on eventual consistency (the notifier
-- 
2.43.0

