Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187287;
	b=nqCsnuyTrYH5rYg+qzq/ynaWg7dn/IodTOZ4LEkYd73r4JtKQGD8Y43KsrUdZ08VA7qu
	 HAERsnMZ5HUDmG0fgrZErL4TsvdOUeGYyR6gdSDpNlpY3DMzTAGqu/njCWH1ggSrTxPGR
	 ZpmuQoA+PJ9dW8fI7s9dLTTPheMDK1Q/U/I5zRLUXoUMEizrVy3zzSCgmdKxE/Mjw8MLv
	 yRHZfVyYhtimYYfOm3seziddQ38Kbh8jH4RxWdayX7k4DCvCQOI9lvmna5EAkYVx+UEcN
	 s5kXyxtqjLNBZqY9txb0T5OLQVKTCkDngUPwVDSh8vAtboRmQtQUEWHp+4yz8PXBC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187287;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Ab0Mw4iSTNA2k5eZaP75VVaX8Iz1KNLj1JlNYy/km+U=;
	b=bSc24wjlVpQDZWEjv0HF63OUa9MonhwwTCHHj7U2QJlbd3dUbcAsSQqiQ/mPW1RR7jrh
	 RlKip2lwxPnj+pLiSC3KgZvptzB1U0k3n87ls539mOGK1Tv+s/4kn0NVfIYOm6Kjla3P/
	 TfvchSa5U5SGxSU7mz2uNiG8hy9F39ftxTWs3j+WTpunP6xsJ9RCInpauEXlSYx1t1vUO
	 sBzPQYaLBVJLLy1GrKMN2bGvrvgzsF735ORxvU8hauDXtGo2UZx2k7yga6J32CunP4Z9n
	 znLoBEVBR0K17Y1lnjThjewnLRJXXMFjbXTkW4zCRxKLHLO3f9E+RCcvTjTIjInyVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bS27lcWH;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B0606D810;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462B0606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bS27lcWH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Ab0Mw4iSTNA2k5eZaP75VVaX8Iz1KNLj1JlNYy/km+U=; b=bS27lcWHZuP1+9EjRMhxO9quQF
	UK2/7axrd3yAA+3DgK3Sl98QEgWuDVQT4UUtLo6XJNtbmsBI1eS9RqodBSLBRXq+dU2bAXF1ObSAS
	iv58LgoHw6D+nhYss932nAeAMr4MATlz6T2uEYvlIUrHtR8yWl0e4UWuuHFldHn2yJLdKnlDxhjgC
	muOwvWZ1+L+oHb1hxSia9EkthCmqEO34GimkJh+RJDnXM/VuOaWhkuj9cjiIIE1mN6x/HFY+0DuiB
	EyN81hq4I2I6mnq+6JSxG031oQtRNmBZpwHEGMrxYIjJTbjiuiPsh8VXaGoh/5p/NOurPtl5Td0WM
	8MupR2SQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4S-00000006AYK-02Bj;
	Mon, 09 Nov 2026 01:21:16 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKVW-1fdS;
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
Subject: [PATCH v12 22/24] KVM: x86/xen: Drop open-coded fallback clock read in kvm_xen_start_timer()
Date: Sun,  8 Nov 2026 17:21:08 -0800
Message-ID: <20261109012112.3415328-23-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When no coherent (CLOCK_MONOTONIC, TSC) pair was available,
kvm_xen_start_timer() computed one from separate ktime_get() and
rdtsc() calls rather than using get_kvmclock_ns(), with a comment
explaining that the latter had a systemic error from scaling host TSC
directly to nanoseconds instead of scaling to the guest TSC first.

Commit abdef42276d8 ("KVM: x86: Fix KVM clock precision in
get_kvmclock() with TSC scaling") removed that systemic error: in
master clock mode, get_kvmclock_ns() now scales the host TSC delta to
the guest TSC and converts it with the guest's own mul/shift,
computing precisely what the guest would.

The fallback is also nearly unreachable. It sits behind the
use_master_clock check, so on 32-bit (where the master clock is never
active) it is dead code, and on 64-bit kvm_get_monotonic_and_clockread()
can only fail there if the host clocksource changed after the last
master clock update, in the window before the resulting masterclock
update is processed. In exactly that window get_kvmclock_ns() takes
its raw-clock fallback path rather than the guest TSC computation,
which is continuous with the last valid snapshot and tolerable for
the one timer that can be started before the pending masterclock
update lands.

Drop it and fall back to the existing get_kvmclock_ns() path.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 48 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..dae43acb3cc3 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -188,7 +188,7 @@ static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 guest_abs,
 	struct kvm_vcpu_xen *xen = &vcpu->arch.xen;
 	int64_t kernel_now, delta;
 	uint64_t guest_now;
-	int r = -EOPNOTSUPP;
+	bool fallback = true;
 
 	/*
 	 * The guest provides the requested timeout in absolute nanoseconds
@@ -210,6 +210,7 @@ static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 guest_abs,
 	do {
 		struct pvclock_vcpu_time_info hv_clock;
 		uint64_t host_tsc, guest_tsc;
+		int r = -EOPNOTSUPP;
 
 		if (!cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC) ||
 		    !vcpu->kvm->arch.use_master_clock)
@@ -230,43 +231,40 @@ static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 guest_abs,
 		if (r)
 			break;
 
+		/*
+		 * With use_master_clock set, the clocksource was TSC-based
+		 * when the master clock was last updated. The clockread can
+		 * only fail here if the clocksource has changed since, in
+		 * which case a masterclock update is already pending and
+		 * get_kvmclock_ns() returns the raw-clock fallback value —
+		 * continuous with the last valid snapshot, which is as good
+		 * as it gets in that transient window.
+		 */
 		if (!IS_ENABLED(CONFIG_64BIT) ||
-		    !kvm_get_monotonic_and_clockread(&kernel_now, &host_tsc)) {
-			/*
-			 * Don't fall back to get_kvmclock_ns() because it's
-			 * broken; it has a systemic error in its results
-			 * because it scales directly from host TSC to
-			 * nanoseconds, and doesn't scale first to guest TSC
-			 * and *then* to nanoseconds as the guest does.
-			 *
-			 * There is a small error introduced here because time
-			 * continues to elapse between the ktime_get() and the
-			 * subsequent rdtsc(). But not the systemic drift due
-			 * to get_kvmclock_ns().
-			 */
-			kernel_now = ktime_get(); /* This is CLOCK_MONOTONIC */
-			host_tsc = rdtsc();
-		}
+		    !kvm_get_monotonic_and_clockread(&kernel_now, &host_tsc))
+			break;
 
 		/* Calculate the guest kvmclock as the guest would do it. */
 		guest_tsc = kvm_read_l1_tsc(vcpu, host_tsc);
 		guest_now = __pvclock_read_cycles(&hv_clock, guest_tsc);
+		fallback = false;
 	} while (0);
 
-	if (r) {
+	if (fallback) {
 		/*
-		 * Without CONSTANT_TSC, get_kvmclock_ns() is the only option.
+		 * Without CONSTANT_TSC and the master clock,
+		 * get_kvmclock_ns() is the only option.
 		 *
 		 * Also if the guest PV clock hasn't been set up yet, as is
 		 * likely to be the case during migration when the vCPU has
 		 * not been run yet. It would be possible to calculate the
 		 * scaling factors properly in that case but there's not much
-		 * point in doing so. The get_kvmclock_ns() drift accumulates
-		 * over time, so it's OK to use it at startup. Besides, on
-		 * migration there's going to be a little bit of skew in the
-		 * precise moment at which timers fire anyway. Often they'll
-		 * be in the "past" by the time the VM is running again after
-		 * migration.
+		 * point in doing so. Without the master clock, the
+		 * get_kvmclock_ns() drift accumulates over time, so it's OK
+		 * to use it at startup. Besides, on migration there's going
+		 * to be a little bit of skew in the precise moment at which
+		 * timers fire anyway. Often they'll be in the "past" by the
+		 * time the VM is running again after migration.
 		 */
 		guest_now = get_kvmclock_ns(vcpu->kvm);
 		kernel_now = ktime_get();
-- 
2.43.0

