Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893811;
	b=GB+PzELGvxFjJyqMcBhe+FhPVA1w++gu2RNNWhK+Ne+ESMr01i8zT2eUoGpzjfVT/MsL
	 Lv8M76b6auB+dvgmRL/P6zyCVO4xW0ltoU38lVlKDfp2ts3HU9I4FZiGxoNWYRABTUi7n
	 9Zo1tuTA+JwRh8awTyOhdAjPEXDkzNiZydC8EYdOU0/tQsATfZ+JP5ppW8sa0iKNEghEX
	 /lvb0Ifq+qBc32tfMEyxN3mpzZPDZ4MurIuGfPpQb8IAr4P6DMcuPRPvvUK7s9DlX2Tlk
	 w9HkhP8MDWCUoPH08A8p9UTRJnJPlCn7ss8ZofEZua6BdDTLuyLzq5CNPwdA+A0McQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893811;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=4PUyL7sZNDc2BWRiB64jpro3+lQx5Ezd+14nQXzY7IA=;
	b=Nhd52YbHTg5xAPn8dv69g8BfxJnz0H94BUlV3LErUAl8IIBKcn2/Qp7yQ8xP66ghWWbG
	 +LhGADEaRGV9f+nW/t1zPgow8J44BJ0h+W3gxHf6iv4ASZoYoImIDgzdnPV12KMnh2oDX
	 fyUhiNOgfPRXDJ3lsnRYYWLu8HWEoXn/0WWUFE0rNPyDuknQgnF9Ny7A4GiGSZSkVQTKz
	 2Nz/l86hUaWgL45YuZKqt+Z7TDIK8aCsd+b/8edQwYsCfhsn1FWPxKe3p5nJPwJQ6kIX8
	 L1zutUtHgRVI38ZTqNEbwFkk48hBwJ1hcv1HO1uWV/d/XC5KMDrZxIW8e/KErYHSPsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Cf3duvba;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6A606BE88;
	Thu,  5 Nov 2026 15:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C6A606BE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Cf3duvba
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4PUyL7sZNDc2BWRiB64jpro3+lQx5Ezd+14nQXzY7IA=; b=Cf3duvbac+7rHXJGDQKcnYlCNr
	IcgIMSruZf01InZFMw3B+GOLOGUka35oR0dUYdvC+ttjra2EwODA2C86VHgppSzQhSLibltcabYDc
	8toCTdldTkhNFnZgmqBnfyh2j6+N35WPCP8LvUmt9G6bgyoHXpOr/pA8CbzEb047at4xYFgHj6tIF
	9I9UByH1H1lKoJDq9bF+ZBfiyzvzpfBoXlZEx7/vWy0zZsyyzfSSSOxJCV9R/yYfCqFgkCs4ACV1x
	xp1Mhm3S3r2Jvs38W7BWDUl5FDkIxxuyECP6cGHMQuqn39hhGR7JDfmUC7/bPEisfHSh+V3AZFCkI
	/099zKAg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziu-00000009ap3-3jWL;
	Thu, 05 Nov 2026 15:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOziu-0000000Ab0M-2wXi;
	Thu, 05 Nov 2026 15:49:56 +0000
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
Subject: [PATCH v11 23/23] KVM: x86: Use a single time snapshot in kvm_vm_ioctl_set_clock()
Date: Thu,  5 Nov 2026 07:49:54 -0800
Message-ID: <20261105154955.2525419-24-dwmw2@infradead.org>
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
 arch/x86/kvm/x86.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 17544b3cc035..4db0c809d120 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4693,19 +4693,41 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
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
+		 * the few ns in between, give or take NTP slew.
+		 */
+		if (ka->use_master_clock) {
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

