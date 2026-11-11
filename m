Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420570;
	b=NoNxxNYHJeXU9irhGDFtEshJkwHeHxFxRT8xC/xwifmt7aewPPK233/ms8WICoHMLtCR
	 hmbiRZynIxnDsCivgDHoWwLWczUGgfraQv2unuEckBLbcQBXiVbJYf/vPg8L5d26OiNSq
	 DaTNXSQQQLteuhBVC1FhvOEEf7szagv2rm8GTCG/ZzTzO03OuTb1+5M7Oblc2KK/B2QC0
	 DAMjlaGflP2t/UbfqG0/SgqezNL/FF8lxbFKsBY+z7/J7Fkj+l7dpCV5QRhhyS46Q4P86
	 4lJjyHM7vNa6dlV682M7NdU8yOC0MOpa2tcst7F8Ta4ltM+s3ny1nOFk5XliWFh2Ipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420570;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=c7IHUPvn0FTv4nhZrlIYskcq6KzbA1Y3PUHGVTFDTII=;
	b=e32yKrfoS/CtFEWISk8iHs2ga86CtsUTWMXb6HpaX3TlmqTI5HLd+OTEQk3y2GmTMpsY
	 GRUK7JOzWJypkD8VO3VkMsTV8sZ1lM4rpPTA2QazMK16QM7KRS6zFUl1dl2M6JSg3bNwb
	 0dZoExOCZlS4VPx5KPAod1bsIwJpybyB/CRlTgMNQmwgC5Y3hUtOmr0C4y1XTGnFJ8L2O
	 +grxMOV+/iNXMh4hBpd1oFcsO1W3NDzD3+4ktCadjJIglpNUVbS2Ar+ND6yQIAGZYkEs+
	 dNB8ewdLfuaTxYzjCrUpVAIlCqvGxKDNPuFCW8nta8ehUgzEXFxBWHizIAYCRc8bTyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="W/Kqrfs9";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4763606A321;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4763606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=W/Kqrfs9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c7IHUPvn0FTv4nhZrlIYskcq6KzbA1Y3PUHGVTFDTII=; b=W/Kqrfs9FVuwmhDDBSfI5xq9nL
	apeIKqR4cGBVdji2JSe0HO2czujbhfwt7nveDrRewLK0txz7G8hX55QRDP9MDJZac8mkgOl7oDQi1
	QJoGLbLOQJAhnveFvuBNg5PUTE2cjnIaDStpChL0f7xJO36OM/jEfVcnTBQ4OymblQN2ZYLRx4a1W
	po686OGJGScsBQXWsoEwFRURJZMf9Xe6OLPHNi1gOhve/RCbmus/kcYZnpLPzKSKYVmUEio+8nBkQ
	585LTUxUmEHjcE+R0TvwMMCwPLhxXfbyVX7cKOj81QkSYIQHgcRvQSe0ys6cn8GA+5qHe6j2CTbBJ
	SJtlEeeg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKvc-1ynj;
	Wed, 11 Nov 2026 18:09:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsm-181T;
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
Subject: [PATCH v13 12/26] KVM: x86: Remove pvclock_gtod_data and private timekeeping code
Date: Wed, 11 Nov 2026 10:09:08 -0800
Message-ID: <20261111180922.4177927-13-dwmw2@infradead.org>
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
index f7dd4129dc51..bd82c9b38233 100644
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
@@ -7455,8 +7401,6 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 {
 	struct timekeeper *tk = priv;
 
-	update_pvclock_gtod(tk);
-
 	/*
 	 * Pairs with the READ_ONCE() in the lockless readers; the race is
 	 * benign by design, relying on eventual consistency (the notifier
-- 
2.43.0

