Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187280;
	b=aG8FREQ5F5RYfxrfZgUUJA5eeHN9ARpGFPUajUEoIOVE77D121kTnBvTUkEl+8ArrRB8
	 Q+yQPmsI8q4nTQDXD7av0i6YOgyhipCu7Zuh2L+Q9Nu7LqJ0snYNqGM0ui7opTtrmWLu2
	 o3ZH85TULBTzvGvZgIGNME3NGCfBEphHPWAmwC+q2UaJvv8PFdWQ/xgvn/1pOOk3qdnfV
	 66eTQ+usUC1LvmMFf/VGnlLFJb2KWaKQs1RGLcPF73tDHOXfazDaZSa/xELd1gEwFOi8/
	 EVGlSKdYUJvCY166N6fu9RbMgQsThJgKkFcyvddVa/9TwFLxcFFKfYfaUkEZ/etb1aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187280;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=8WjDO1KwcsvAUqxQwIXFac02DYVHmNDQBxlAENSfD/U=;
	b=fpeIwW0vz8J4EhwxX37LUoE6zWVIwb1r7yLXXRProEDukLShZmySRaWmiHcgZ1q4WR+o
	 NVYCbV97XJ5O9v/YOteeN0ZtWQM7RvGxVNozBFKJYX9T9nDad/jizNfGNkAjtUMYf55Qo
	 zmwT6420tq5HnioP4QporBT0BlI1Wn/euTHlpw2RvxK23W2HtQdWz94xv3FkYBHAuNtcW
	 jpGGGwQFkBuDusAZdFE4xpykeo12iY4AefYi80ODQo4rUoTPc1SDDZIw+IAm7mwrgLGB1
	 ylja8ZAQHVN5ymkJ+2cSMNZlj4mEbexamWJSpG4Rt0o+q9LG2PDCZC4ipYGd5s1PIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=liV+FqUf;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147B606A330;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7147B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=liV+FqUf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8WjDO1KwcsvAUqxQwIXFac02DYVHmNDQBxlAENSfD/U=; b=liV+FqUfEo9NbHpQPBtOnhS+dK
	kxTHX08rmlsewZVb58AgqOwtXwlDB1MwvcGE9QapYEpgHcWESi4JZsWp0dqPwIGfOXu6qo8X45EUs
	DJbY4efx/Ovk3xhzByAIa4dNpIEV+/JKOnJT3ZC8IywuH/JUI0dF7iup7ZdQjV/eL62wlGaT7XmWj
	/J6YlNlUPpFDy21UK0G1jWaEfeR8I6FyQ0NXBGNZF7ntCi/wJQ9AABu7Org/SjP9LsQvixuHY+rFB
	eHftO7+6ftiTooo8YbLwd+Zf9UwX4b0KWa6EWBozxo2KTPNxgHBpBEa07P/5pPmZybA4Jm1wlpBHD
	AeNCkTgQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4P-00000007PwK-2fAH;
	Mon, 09 Nov 2026 01:21:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKVa-1pLG;
	Mon, 09 Nov 2026 01:21:13 +0000
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
Subject: [PATCH v12 23/24] KVM: x86: Use a single time snapshot in kvm_vm_ioctl_set_clock()
Date: Sun,  8 Nov 2026 17:21:09 -0800
Message-ID: <20261109012112.3415328-24-dwmw2@infradead.org>
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

The KVM_CLOCK_REALTIME handling read CLOCK_REALTIME with
ktime_get_real_ns() and then anchored the result at a different
instant: the master clock reference point captured a few lines
earlier, or a separate get_kvmclock_base_ns() read. The time elapsed
between the two reads is added to the restored clock as error --
bounded by the interrupts-off critical section, but gratuitous now
that the timekeeping core can snapshot CLOCK_REALTIME and
CLOCK_MONOTONIC_RAW at the same instant.

Take one ktime_get_snapshot_id(CLOCK_REALTIME) snapshot and derive
both the realtime correction and the raw reference point from it. In
master clock mode, keep anchoring at master_kernel_ns -- so that
'system_time' cannot go negative for a very small data.clock, as the
existing comment explains -- by projecting the snapshot's realtime
value back to that reference point; CLOCK_REALTIME and
CLOCK_MONOTONIC_RAW tick at the same rate across the few ns in
between, give or take NTP slew.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4642a9087df4..de3b5086f17c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4855,19 +4855,45 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 	 * 'system_time' when 'data.clock' is very small.
 	 */
 	if (data.flags & KVM_CLOCK_REALTIME) {
-		u64 now_real_ns = ktime_get_real_ns();
+		struct system_time_snapshot snap = {};
+		u64 now_real_ns;
+
+		/*
+		 * Snapshot CLOCK_REALTIME and CLOCK_MONOTONIC_RAW at the
+		 * same instant, so that the elapsed time applied to
+		 * data.clock and the reference point the result is anchored
+		 * to are coherent.
+		 */
+		ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
+		now_real_ns = ktime_to_ns(snap.systime);
+		now_raw_ns = ktime_to_ns(ktime_mono_to_any(snap.monoraw,
+							   TK_OFFS_BOOT));
+
+		/*
+		 * When the master clock is in use, anchor at its reference
+		 * point instead, projecting the realtime value back to the
+		 * same instant. The two clocks tick at the same rate across
+		 * the few ns in between, give or take NTP slew. Skip the
+		 * projection in the absurd case that it would take a
+		 * CLOCK_REALTIME set to within moments of the 1970 epoch
+		 * (legal with CAP_SYS_TIME) below zero and wrap.
+		 */
+		if (ka->use_master_clock &&
+		    now_real_ns >= now_raw_ns - ka->master_kernel_ns) {
+			now_real_ns -= now_raw_ns - ka->master_kernel_ns;
+			now_raw_ns = ka->master_kernel_ns;
+		}
 
 		/*
 		 * Avoid stepping the kvmclock backwards.
 		 */
 		if (now_real_ns > data.realtime)
 			data.clock += now_real_ns - data.realtime;
-	}
-
-	if (ka->use_master_clock)
+	} else if (ka->use_master_clock) {
 		now_raw_ns = ka->master_kernel_ns;
-	else
+	} else {
 		now_raw_ns = get_kvmclock_base_ns();
+	}
 	ka->kvmclock_offset = data.clock - now_raw_ns;
 	kvm_end_pvclock_update(kvm);
 	return 0;
-- 
2.43.0

