Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263C35202B;
	Fri,  3 Jul 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113816; cv=none; b=S2miQItrJoyjrwlE8J1taUoyGOFSVXD7R2QDnk/kTm87ONnScf/5a7/KB1MVEtX7LwbmmidKY20CUd+4KIbKVCLwG4gcy/W154M9EbwkdPRSrRbpXOo8a7VyE1W36KwJx2fjsFBjgNQ4GYl326JY7DA81KUioA1MCfCJ/ywckVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113816; c=relaxed/simple;
	bh=6G9Zt1WXZ46Y8dvQYl99uV5C+tkchegI2KQsBzBJNw8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Grlh4d0MAQGUahDfiV/Iu0pwUay1CxVG6SRnc66qVKGCCJ1ZgwKoBEFZi7qlHMIS8o2eeK/NvpZXxQM8V+i5x+jygLb/xhohObbUKeRzoesl3LCxrXJd/DJOJHH/DjetIQ+9+ZdnhwMlwXNXiCk+ZpbyWFVKxr8o1WQYE3OgT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iAY6MPfX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iAY6MPfX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=1OUv5CdFlAHAtCyTuuEwus8cGCX4Zb6KK8eBdOb5xl8=; b=iAY6MPfXrlFmZymwYSi+vVUVlO
	Foj75r55Pg0RY2rE1G43N+8fD9XfvQ9wvrkZ6IQFehekLM47aqnS2WyUEiaEq45e/K3+QqpL883g2
	oxc0gIJzsIQslagkNwURfAqdrJBtEiZF1ADO/kBfNTsCiCu2whVOx6OV+YtpWXnWiJjHf/km1xwi8
	BjZeLG8R28itKIdJU2ORDJdGL/twrFkXyZF4cfcv/Ls01m6xV3PS2mcL+rBFHVol6Gi9uDe/rCWHY
	weB/t2G31ola0QBkAmIxp7fDT6IzQ5OkKGjhGdZVLn5cAiSUfsWQGKBUU3K3pD2jWVTS4EmGKfQAR
	jmWut/Bw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKe-000000059OE-0v6i;
	Fri, 03 Jul 2026 21:22:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKX-00000001RPx-2LRG;
	Fri, 03 Jul 2026 22:21:49 +0100
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
Subject: [PATCH v6 32/36] KVM: x86: Use ktime_get_snapshot_id() for master clock
Date: Fri,  3 Jul 2026 22:18:11 +0100
Message-ID: <20260703212145.343527-33-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Replace the KVM-private vgettsc()/do_kvmclock_base()/do_monotonic()/
do_realtime() timekeeping reimplementation with calls to the generic
ktime_get_snapshot_id() interface.

The snapshot provides both the system time and the raw_cycles (TSC)
atomically paired. When raw_cycles is zero, the clocksource could not
provide a raw hardware counter value, which is equivalent to the
previous vgettsc() returning VDSO_CLOCKMODE_NONE.

For kvm_get_time_and_clockread(), the kvmclock base time is
CLOCK_MONOTONIC_RAW + offs_boot. The snapshot provides the raw time
atomically paired with the TSC; offs_boot is added separately as it
only changes at suspend/resume boundaries.

This is a step towards eliminating the pvclock_gtod_data private copy
of timekeeping state and the associated notifier callback.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 arch/x86/kvm/x86.c | 53 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 37a768b2fe16..56afd5e66c06 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -35,6 +35,7 @@
 #include "smm.h"
 
 #include <linux/clocksource.h>
+#include <linux/timekeeping.h>
 #include <linux/interrupt.h>
 #include <linux/kvm.h>
 #include <linux/fs.h>
@@ -3154,14 +3155,39 @@ static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
  * reports the TSC value from which it do so. Returns true if host is
  * using TSC based clocksource.
  */
+static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
+				u64 *tsc_timestamp)
+{
+	/*
+	 * ktime_get_snapshot_id() cannot fail for standard clock IDs
+	 * (only for invalid/aux clocks or during suspend, with a WARN).
+	 */
+	if (!snap->valid)
+		return false;
+
+	if (snap->cs_id == CSID_X86_TSC) {
+		*tsc_timestamp = snap->cycles;
+		return true;
+	}
+
+	if (snap->hw_csid == CSID_X86_TSC && snap->hw_cycles) {
+		*tsc_timestamp = snap->hw_cycles;
+		return true;
+	}
+
+	return false;
+}
+
 static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap = {};
+
+	ktime_get_snapshot_id(CLOCK_MONOTONIC_RAW, &snap);
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
-						     tsc_timestamp));
+	*kernel_ns = ktime_to_ns(ktime_mono_to_any(snap.systime, TK_OFFS_BOOT));
+	return true;
 }
 
 /*
@@ -3170,12 +3196,14 @@ static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
  */
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap = {};
+
+	ktime_get_snapshot_id(CLOCK_MONOTONIC, &snap);
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_monotonic(kernel_ns,
-						 tsc_timestamp));
+	*kernel_ns = ktime_to_ns(snap.systime);
+	return true;
 }
 
 /*
@@ -3188,11 +3216,14 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
 					   u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap = {};
+
+	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
+	*ts = ktime_to_timespec64(snap.systime);
+	return true;
 }
 #endif
 
-- 
2.54.0

