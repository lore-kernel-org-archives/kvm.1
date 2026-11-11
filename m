Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420571;
	b=nlT1fuArCa/Yt6RMXueCDdHuglt2YpXUiDdTHNLpYOr3lN4aPOj3VndnoIVtCVcMorCN
	 zVvPvMyQCHe2va7ywrPMR/Cue0YFES0phHL5byvvw2u3+4Wn09vDjotWzA0kqy2JpFE/v
	 gz6k+c9rSXkIjZEUrluZusewV7MX4rsQ0PbWmlfT6X8aOfa2m6m5RDIzqc2UfuS4YCUqZ
	 N9hYrg5GjxtCBgNPwyy1UtP30hF8gRJQZse4+gru6Wf9XcfyIWVBCdEcmS2o9NbWVK8pL
	 p5IJcCgbCRx8VkA969ZD/bbI34Kb5JzqsSneG1laDt+D/fHPfQZ72eyLNVCQHGt6/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=UkL+2EqqLZWeKCYphLSu8F5DwrRa+T7c95HDl48bUzo=;
	b=gFpe0uo5DTRi748PxQB2jpxcUWpQ60iP8zgZ8fbXf4N7YpHfrG2KnRMS//yyT2HI/mP5
	 +XxdDEvac9luuTd7qXotpRWQltsdZ+ojIZ5cfNu/KQWH3/Bv/nR8Tir5VLkbvGqPnn2d2
	 /Wfx8pDb3eikISoG3FSbRYhVLsUDMCi8MD6CFf0Fo4dwCyCF0PD4y7f5sOSGIQ98J4RaG
	 8WoovMRKLQL8+wcj82ZWVcn4NCoAiwFiejgJ4l3zRknG79F2PwB/FKRKbyTFK4cCoSvsI
	 78FpAyaUeVbQjSKmyUBXkzbOBar875vCuAWnVNEtgVC39xSygE4y4Taf6r3RiEPfq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="sZNh/csW";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E960A260E;
	Wed, 11 Nov 2026 18:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D06E960A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=sZNh/csW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=UkL+2EqqLZWeKCYphLSu8F5DwrRa+T7c95HDl48bUzo=; b=sZNh/csWJLZTNxolsU2BKknfNs
	Qo3U14mot2qyCMtFvD9jtZisiBr/I7ogzhnU9xRkrWV6H9GRcR77uA+SP/DW9/oFAKho1+vpbl6nV
	k/o+ygtKtoplpCD0cOl+l/V8tA3N0rZrux2exarY//L0Puagr8bACfFFjR6w0BlPgn5ab+YfmqTjt
	jvtgW2NeNsopaInB7Vj/ZfQ4Btlijyx2r1SZ3HApttlBpFSzD74xX4GjcxzaTM6YtpdfJW9kyPvkt
	zamsqJf7mfEI0WtfR0/adfos4lWf3nhifZQy/BgisEixdn03aiKUwnz6N/iUGoRuQCP+gdIcrCye1
	gtHpGXVg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClA-0000000CKxH-09O8;
	Wed, 11 Nov 2026 18:09:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtd-3VQ5;
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
Subject: [PATCH v13 24/26] KVM: x86/xen: Drop open-coded fallback clock read in kvm_xen_start_timer()
Date: Wed, 11 Nov 2026 10:09:20 -0800
Message-ID: <20261111180922.4177927-25-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
which is continuous with the last valid snapshot — though up to
~0.1ppm of the snapshot's age (multiplier quantization) away from the
guest's own pvclock arithmetic — and tolerable for the timers that
can be started before the pending masterclock update lands (the
clocksource change is noticed via a two-stage deferral, so it is not
strictly one).

Drop it and fall back to the existing get_kvmclock_ns() path.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..2a157cba1c7c 100644
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
@@ -230,43 +231,42 @@ static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 guest_abs,
 		if (r)
 			break;
 
+		/*
+		 * With use_master_clock set, the clocksource was TSC-based
+		 * when the master clock was last updated. The clockread can
+		 * only fail here if the clocksource has changed since, in
+		 * which case a masterclock update is already pending and
+		 * get_kvmclock_ns() returns the raw-clock fallback value —
+		 * continuous with the last valid snapshot, though it may
+		 * sit up to ~0.1ppm of the snapshot's age away from the
+		 * guest's own pvclock arithmetic. Only timers armed
+		 * before the pending update is consumed see it.
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

