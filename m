Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343902E738B;
	Tue, 28 Jul 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250213; cv=none; b=Wqk50Ys7XDpPv8D9A/ltH+oe8nkn7EJWb5JUMa2a4N3uXgW394ZZ+ewS889DkrEiiNoTJ0cHWbbefPrPYH0y57+bsZnIcHNHeF1W+cLPw5MN4rv0N7BX1zLdgQ11VmWjkFpXvWrk6t1PTUqhV/nra7WZcfd/0EaXpE/umg7KLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250213; c=relaxed/simple;
	bh=ZeDcAw+QszgPZGuWkMhVnu2N978Ng9Xx2OuFcP5mNvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+k5y8rpQqEAZr40G8lhUWKfITU65HEeWd9zfbKtN21VxV3jJXCMAKitx2sFvH6Y+RBHDARYOq5oUEG6hZ3xcI6lSxIC/I/pbTlEPROLbQqi6B2r3t3MNYp/rKHHGPNZ06vn4DKGBZD1WNyhv9YoTO9BYavKbN8egBJdSuc3g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MEL2niT5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEL2niT5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=+DxarpYo110/dFxnS/IKK6M+YoxESrTWdUshhMTCtwg=; b=MEL2niT5EFY+zAwbanklEWdU/M
	ApQfH7CLS75uHA+Ve3HnJPT3CDoY7Ntln8AyL0ZVazYC2xpkp9Qp5ZpItc3r34n3CiWySuY+rm0QR
	2K3bfN7zDWZ3w/8GVeqwrEMUwsjn7j/sYRJrpjKwP+RWVmXruv4VuM1PeRbegU7HDJdZsJpvc3Vrz
	NE1zUxOfjT7GfZg7LOrYGSKbUEyXjcJc2Vl1c1UFdAPYaWJ6UW+40dXr9zINFbDqKEjv0uEmcac36
	0wmBbegVWBsMrkr6O3FgL1arZdnJNfXuotkpgjO5jjCg9bg6ffA1PWZOalFNk7xcxUnFuFdylS5OG
	zwCbQT8w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOt-0YGR;
	Tue, 28 Jul 2026 14:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYn-3fCf;
	Tue, 28 Jul 2026 15:49:55 +0100
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
Subject: [PATCH v7 20/36] KVM: x86/xen: Prevent runstate times from becoming negative
Date: Tue, 28 Jul 2026 15:40:00 +0100
Message-ID: <20260728144954.355376-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
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

When kvm_xen_update_runstate() is invoked to set a vCPU's runstate, the
time spent in the previous runstate is accounted. This is based on the
delta between the current KVM clock time, and the previous value stored
in vcpu->arch.xen.runstate_entry_time.

If the KVM clock goes backwards, that delta will be negative. Or, since
it's an unsigned 64-bit integer, very *large*. Linux guests deal with
that particularly badly, reporting 100% steal time for ever more (well,
for *centuries* at least, until the delta has been consumed).

So when a negative delta is detected, just refrain from updating the
runstate times until the KVM clock catches up with runstate_entry_time
again.

Also clamp steal_ns to delta_ns to prevent steal time from exceeding
the total elapsed time, and handle negative steal_ns (which can happen
if run_delay goes backwards across a scheduler update).

The userspace APIs for setting the runstate times do not allow them to
be set past the current KVM clock, but userspace can still adjust the
KVM clock *after* setting the runstate times, which would cause this
situation to occur.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/xen.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f2c6757fc1fa..998cdcb6aa30 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -587,29 +587,45 @@ void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
 {
 	struct kvm_vcpu_xen *vx = &v->arch.xen;
 	u64 now = get_kvmclock_ns(v->kvm);
-	u64 delta_ns = now - vx->runstate_entry_time;
 	u64 run_delay = current->sched_info.run_delay;
+	s64 delta_ns = now - vx->runstate_entry_time;
+	s64 steal_ns = run_delay - vx->last_steal;
 
+	/*
+	 * If the vCPU was never run before, its prior state should
+	 * be considered RUNSTATE_offline.
+	 */
 	if (unlikely(!vx->runstate_entry_time))
 		vx->current_runstate = RUNSTATE_offline;
 
+	/*
+	 * If KVM clock went backwards, just update the current runstate
+	 * but don't account any time. Leave entry_time unchanged so the
+	 * next positive delta covers the full period once the clock
+	 * catches up. Update last_steal every time so stolen time only
+	 * reflects the interval since the most recent call.
+	 */
+	if (delta_ns < 0)
+		goto update_guest;
+
 	/*
 	 * Time waiting for the scheduler isn't "stolen" if the
 	 * vCPU wasn't running anyway.
 	 */
-	if (vx->current_runstate == RUNSTATE_running) {
-		u64 steal_ns = run_delay - vx->last_steal;
+	if (vx->current_runstate == RUNSTATE_running && steal_ns > 0) {
+		if (steal_ns > delta_ns)
+			steal_ns = delta_ns;
 
 		delta_ns -= steal_ns;
-
 		vx->runstate_times[RUNSTATE_runnable] += steal_ns;
 	}
-	vx->last_steal = run_delay;
 
 	vx->runstate_times[vx->current_runstate] += delta_ns;
-	vx->current_runstate = state;
 	vx->runstate_entry_time = now;
 
+ update_guest:
+	vx->current_runstate = state;
+	vx->last_steal = run_delay;
 	if (vx->runstate_cache.active)
 		kvm_xen_update_runstate_guest(v, state == RUNSTATE_runnable);
 }
-- 
2.55.0

