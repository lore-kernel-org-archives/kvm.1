Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8C489881
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780010; cv=none; b=esiyb4Pag0mXGQ08IAFM/jVMBi6Vxh/BnvcUQ22TDtSsGihmTtLnhCN7us/AHjYso63L26SBsUuCupUhybCo1KocvbHEJi+MAfuwnbUNr3kxCZVVxtJpae3j9sHe7cHerb1h3jxZKrJBEKz4our3b26eaSBGy7M2iAHRyrE8KnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780010; c=relaxed/simple;
	bh=J7awBibVXHg+ZynoE1GTv8WNYcoD5LqJUOY9xR1n0xE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMOu0KW/8/wdCCD5SB2AJhdjIAebrog5gPnCnw9ioEIeKYUgrBeKMgtYCCCs/PCJ8nkIQt9EMsh8mLpi0lFU/z9dEO8mRlfg91RuAlZETQcn2pWfegwpMBegSwoAK+XYLGCMtX0jbYvy3Fqqpo8sYwgI9JC0dbb5FrdwkRiOHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVKQepFr; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVKQepFr"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso27881a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780008; x=1788384808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cl9yrkZ+dGZ9BiHgGOnk9QZOqiTp6OUnu1pYLMOniSs=;
        b=aVKQepFrPva+opNOkPQuvPBDbvjbdJLW6eh2rcI4ut4ImP31ggpHnIwoh2KHO+l52W
         ZlFhaOubrS0BgjylYaU54ARLgppnxb8XFujnMp1+esngwj+EG2JaGt8lg0c4MbwJSrRs
         eHumljUyvCELUlrU3LCyAkWxqF4hEY8xC3skAuveS+U7U6qSPSAlborBsPGIMNXsKiXT
         JLxEePsZ9pCzEj+n/gC2nnwxLRC8MTDA1xhY86CmVzNIvKez/IDbifcjx24EbtlfqTaA
         iqj9qGafluVb9tVUk02jByb+OA2iQI2hzXyxlXpUMNbko46X/XlvzNKnpeCcy2lRf60k
         Vmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780008; x=1788384808;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cl9yrkZ+dGZ9BiHgGOnk9QZOqiTp6OUnu1pYLMOniSs=;
        b=bus/4Jos6HRBC5RzPZQ6htRfBVYqbeoh3oCRoewOJWG2RyPwB9Z46CcyakgfnINViZ
         cdwkpPIr+NKuzpS+NXazBPeEe5nnYcwSkyHlQis8xxyPm/FufnJ48Q6zKqNjdmkDR74W
         iGGIk94biOFzSl9UUcH3rveRUE3MSYk8tI/AqFDiO3ftIGyEjaf2v+rUe3aBGz92+QD6
         IgX2Tvr3C0SJ7KTKNh61kNT/K6Pa6SKMEEuGEF6qrzAhBVl9qduoIAiu8aj6QHtNr0/w
         LC32RznC3vSWcBpGwqON7UDBOJB95b1woZdiouc+44gblxyJ3YYyEdCDKsj1Xqe1dNP6
         c2Cg==
X-Gm-Message-State: AFuF++lH4Hb9maB2WMO5T9iZCMI0G1Wo5Dh+B0dbpGryzxDLxf1u2IP6
	d8f0viLqCz+4gIZz7gOHK65GmPKmEoKwdPjlCXTIYeRBBceFNtomyr642QFyj92XVQ4glz6UAuB
	PkasTXg==
X-Received: from pgal6.prod.google.com ([2002:a63:3e06:0:b0:c9a:d174:5315])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a03:b0:3c3:9c4e:de3a
 with SMTP id adf61e73a8af0-3cf82a348a3mr22345482637.6.1787780007516; Wed, 26
 Aug 2026 14:33:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:33:00 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-21-seanjc@google.com>
Subject: [PATCH v10 20/21] KVM: x86: Use kernel timekeeping snapshot for
 monotonic clock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Replace the KVM-private vgettsc()+/do_monotonic() timekeeping
reimplementation with calls to the recently crafted, generic
ktime_get_snapshot_id() interface.  As noted previously, the snapshot
provides both the system time and the raw_cycles (TSC), atomically paired
using a sequence counter.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: separate from other conversions]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32390b20a2b4..0352bd147c40 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1438,29 +1438,6 @@ static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
 	return v * clock->mult;
 }
 
-/*
- * This calculates CLOCK_MONOTONIC at the time of the TSC snapshot, with
- * no boot time offset.
- */
-static int do_monotonic(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-		ns += ktime_to_ns(gtod->clock.offset);
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
 static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
 {
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
@@ -1528,12 +1505,14 @@ static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
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
-- 
2.55.0.887.g758fc8c411-goog

