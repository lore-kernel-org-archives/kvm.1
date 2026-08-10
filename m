Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F763446842
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402530; cv=none; b=EYkouC2tZkiDVGB7na08nx7UlCpPvFATbSElskJ4MhZbouGEYnFU6Iy8K03ImGW8vsxlgaTiTWlkDwHYiBu82/Wj0NnF3rTOHilRr0Z19X+aoeXS3vPVyIXmgblMhc3n2bEYRDdsSVedmxP29iU5Mdu0112JMclBjurwVu5vL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402530; c=relaxed/simple;
	bh=hhQjHicQbVby2oFYCswEc1FMH9bMTv/ejeWgfY93B5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2vrIGCQZHFdQ//uzImNEbVPPwdAxaQsfn6Imsf0a+6gI9lBIAYA3KuYKTve8BSKlCRR1pAP08zfk6ds0JXwJaOaJ2+IiLMsqUmhWa1aQJmfU8YGd6y9eLWDVeQEN34e8r/Ftf4QDorDcIiVbdWwyjy1H8an8eSKNocksxrSfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJaow7m2; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJaow7m2"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67b16217so4065276b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402527; x=1787007327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qiJ2rCuFTNV6LsYeeN4PZpKxEhzfSbT5iPntzURy2DA=;
        b=cJaow7m2WBrGLGPBTnS8FQz+/2Iao6vG6MbuBcHt1eBWeZIEWSvVJd4ceUTMUEyEkT
         PcxaKS1KVSI+BkG+wwfv7iBYUvTMAbf11FAWsUAkiPe5ZrDmz8lTDOWlO51+jSmO1sC+
         vP/FWzR1mCJO1oOta1ko9+BLq08BbkvBxQikbIPZscm133pJmx/bvkCimGVx4xzEPj2m
         K47269iKPuksmJLv7gQq15lFB6kyIcwCIsJsIPYbqlot6EKfJ9f5fYGLrRQgpHinUJvv
         ZIvDEVPLoc+xP0QfSfquVEM5GwcPbQowMmmwBRu3DHn8/s3LnqTondVeIrsQaKq9CreG
         Xlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402527; x=1787007327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiJ2rCuFTNV6LsYeeN4PZpKxEhzfSbT5iPntzURy2DA=;
        b=gEJMhMYsNwgWeS3aps3YXYRBnf+9VnQKpUZKA8g6W3Zz/SIkQB+6ZDLb8mZB7cTiKK
         p7pXGMiz6w8MlEaDkEVzUM+0UeBGTL6H8fhdO6lVtlwCM3YaJjMbejYG3vsasMnvObi1
         TLItaYlb6guYtcioM0kb7qnu9reMCK+/Hv8i0CvBSOA/D1b5OPQaw7PdXfPh9n4k7Uto
         Y5kC4fLAxvm4vJVLdVVFjWPloeOlMjxd8e34OiGqS3wU6VdWKSfKELgrI0+2IGhyKDbA
         5O3rd+GBRYNupG4I4M21yaX0DdZJlqQRMep7kogjF/VFGAYF6sLudBpZQDri3Vj1lKEk
         pFgw==
X-Gm-Message-State: AOJu0YxhNp7Uenqn/LF1nomT1fmJJVH+hYfimQrdEkNv/kWYc/91Ocj7
	sllo18bgIqheEmTt7cUYZTasIuImtJMjdkjDu+IhQEI0ms94Sw+HA28IPXhMXC8sl+DkdW1hQ8a
	gDe3ddA==
X-Received: from pfoi24.prod.google.com ([2002:aa7:87d8:0:b0:847:98fd:5a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3486:b0:847:9aa8:d3bb
 with SMTP id d2e1a72fcca58-84f694910cfmr26202403b3a.12.1786402527233; Mon, 10
 Aug 2026 15:55:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:58 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-21-seanjc@google.com>
Subject: [PATCH v9 20/21] KVM: x86: Use kernel timekeeping snapshot for
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
index 85c456dd29d5..1513e4ae2353 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1436,29 +1436,6 @@ static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
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
@@ -1526,12 +1503,14 @@ static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
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
2.55.0.679.g6767b8d81c-goog

