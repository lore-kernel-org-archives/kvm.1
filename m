Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420571;
	b=SjonVUR8SP3niVCYOarEZI4UMHZlZh0fKCTCRjUCUO8rUt/BLz+5KiTAFAZ+mA1BvH65
	 wbB5JxZmUJkQQxQtMmkakyv7tXw8EWsHdWjrOvPM+W9bJX5Mz53uqEtU/FUnxOfcCfwru
	 ue+i1Pw6nk/gjuz+EP5ExEhN0kn8tzM9FgQUzf59aq16hA4v/yOYz1VEoSAWywGNI1GYU
	 9UjHlGon7gniz7wENklltPJdu59kV5JXkmmPZ284DWQKbyARfq5upwoFs8cg2G6aZECVA
	 rfuZtciijqIGhlLGu1xp/4jr3feAwEiqMkY+CggGi3bvOlo6z2qCI5WV2joqqYA7BoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=0Cp728EjuFyU5LORJlGxffVkYMCDOu/AruEqIXPRi9Q=;
	b=YX8r/0b1HVgu4ugyvSLTL6oV6GV8AhLJP21OgKp5iHLx4zbRz6XewDWAOAvzlYDdEvnP
	 j3T6zK+CPy96FlajRcHu4/oQmZiMtftxVRQrK1XU4TuT8jK+Bt4BNBjs/DMkSbFAQi1p/
	 L/nBdE5pStsqr6G+YNyGE7kYy2o6LfaPoobC2jT2ug1q5oHEs4jjAgpfXLgEgmY6ZkLxT
	 9ExIdw2kCUgj0QnOYQsCbQ+ebiIQ+Pwnv/CkTW8BjolUhltwPgyhY85QIoIESfyhCRXNw
	 YncOdeDIHhjlC5WB+HWdxIGTnWeLJcaV3ZqHDJLLUYTBJHFluuxH6d+RJLV2lmHA1Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="c/SVvFgU";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BE60A260A;
	Wed, 11 Nov 2026 18:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60BE60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c/SVvFgU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0Cp728EjuFyU5LORJlGxffVkYMCDOu/AruEqIXPRi9Q=; b=c/SVvFgUYUltwDQy6ocScA7wHO
	KDoZoGedwvN5LpuW2FtpeUkIzdNyiihEgq/LyX3Uq9oy4j2LonpGeYMKQ2RS7yWZg/eoSCv4oq0lw
	S3ZM/Ld9X5h+qTJmhBdET9q9IU1URjld7jQ97nkeAXiDOIjz2DuigjH/hSzftnBD/GQCJO/Z84IGb
	+MqHzegkwud4+Mg0M9MHMIvcgU3aq3YHQQaJxKEtO7ENMjcH0Bfs45lk33sMt6uqagCYqp2qRy4ML
	0xSRAaYu8hxpabFkbj0vog8BZcwL1alMG9b3Zp007JNE0pWlPNS3PdBh/9CFY+XkXZgtDfc6cDq/0
	ce2fmYJg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClA-0000000CKxI-0Kt3;
	Wed, 11 Nov 2026 18:09:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtk-3gXj;
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
Subject: [PATCH v13 25/26] KVM: x86: Use a single time snapshot in kvm_vm_ioctl_set_clock()
Date: Wed, 11 Nov 2026 10:09:21 -0800
Message-ID: <20261111180922.4177927-26-dwmw2@infradead.org>
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
 arch/x86/kvm/x86.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b9d3b2715403..921d834b9682 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5143,19 +5143,49 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
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
+		 * the few ns in between, give or take NTP slew. In the
+		 * absurd case that the projection would take a
+		 * CLOCK_REALTIME set to within moments of the 1970 epoch
+		 * (legal with CAP_SYS_TIME) below zero, clamp it to zero;
+		 * the anchor must still move to master_kernel_ns, from
+		 * which the master clock consumers compute system_time,
+		 * lest a near-zero data.clock wrap it below zero.
+		 */
+		if (ka->use_master_clock) {
+			u64 delta = now_raw_ns - ka->master_kernel_ns;
+
+			now_real_ns = now_real_ns > delta ? now_real_ns - delta : 0;
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
 
-- 
2.43.0

