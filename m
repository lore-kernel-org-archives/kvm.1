Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818A3A63EF
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270927; cv=none; b=AhWx1EHbFhUFrAN9WGIAU4zn5EgQ8Op5k/ZklExGv1gffp1vCEU9xNr3iex1OrTiDusLMTku6wAjPgyDaE/oP7EcIohr0oU/qmgUrqp9HpuBTd39LuuiZ+5dDo3qYOSijSCf4pgx+lEFItpZsy4ybcxOLUliobEHVIQjIGWeTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270927; c=relaxed/simple;
	bh=o8zP0pmVKJHK436lt+gwavyyFKfoMnYRsY7gSDGk9mQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsrXaukwNysuDSiPW15iEfe7I4Em1BEJaHVKb9asf6xiDeFMEGmcyvY1Xgw+Je3HkUdrW/jsRu/VEgGby79Rp2CM634lgFILzn8eDKOn/r6/1O2zUcQx2j3gQc326J5kRMgPzpMxq21FWQcmGkEEPX9T9CzNcv2xGnsUqiEQ+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4L3sxuj; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4L3sxuj"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a8041a532eso1620998a91.3
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791270922; x=1791875722; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkjMXQJP19zpOzNKOeXflQoWTgmBDI+ZMIE8jzjAz3Q=;
        b=r4L3sxuj6Bvc+2GOmTlQZHbA9CgUna5v4JGsTy31RUMZLVQo5OqHULR8rRC76IOB+t
         VH0vjwbeAzjxOTJ1X3gY0tIRqd4VwhRFeaRaHq1DWeslcHm6V5pVMLTZsGTnxXxc24YK
         qS7qiIqm4uneGhbKsIQrHe8uawQazXMWPSl/W0/BOpxv3FB0iXur9axS8BBxjOIE6ebb
         fSA1dMIzM426G/f2kxnuWdZ05LRvbjL34RGhl7zSlUhULDMPm0Y8HbG/Hp0EGF84Obl9
         O+Z5c+HyxYPN8hNo0ddn/0I475OjlTllPzzZpDJmVmn+jkd7mvml2VOGsQLYzDSzTkDm
         4XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270922; x=1791875722;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkjMXQJP19zpOzNKOeXflQoWTgmBDI+ZMIE8jzjAz3Q=;
        b=pCGNWEMxkSmSg+xZBHAFmPXntkBQl0RQfLx7fJ+y5wKorsKMclZvsjq+OR+SS1BkdY
         lvWlHWD/TjzQnhIjlxS4sdDFhYtIpv5f+wQURuUohMqNxbR/qjTbzVdqGtT9cocfeRu1
         nr7txLVoozZmvh8vPvsns2SR/cpSWO4ue6WytDPn+dev+zv6GeWl8hZ53rGAdRxjISP4
         luJdI63A09fIzSkbZ7qZBD5AfkIokOhj9d2+LBZFXQUs4Ob0cYZj7GcONftVIJrAWij9
         dRna7sWLvsv6TgrFSJtsy+QuieCfCL2AT8AgoXCrC7ZMAXbfK43ii6MZq5oKq+lHoUmR
         Twjg==
X-Gm-Message-State: AFq9FYI48tIErRq4RZzpHmk8Tgz5p708cYjo0yfuxhlJLK1ZIGmDI87y
	Omw7q5/YXuTd83TPY13i0b3B7T6L1kllwHXXqu2PN3wVL+8aIilRQPRCHfYK4r9cP8+C8Gl9uBo
	isHwUhg==
X-Received: from pgbci11.prod.google.com ([2002:a05:6a02:200b:b0:cc7:9970:4594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580e:b0:3a8:1745:6bfe
 with SMTP id 98e67ed59e1d1-3a817456d8amr3834023a91.47.1791270921549; Tue, 06
 Oct 2026 00:15:21 -0700 (PDT)
Date: Tue, 6 Oct 2026 00:15:20 -0700
In-Reply-To: <20260428133524.3628482-3-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428133524.3628482-1-imammedo@redhat.com> <20260428133524.3628482-3-imammedo@redhat.com>
Message-ID: <asSgCLgeSCKh33_n@google.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] x86/apic: add retry logic to test_apic_change_mode
From: Sean Christopherson <seanjc@google.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 28, 2026, Igor Mammedov wrote:
> The APIC timer runs at wall clock time under KVM. If vCPU is stalled for
> long enough, timer can expire before the guest reads TMCCT or tick well
> past expected values, causing various false test failures [1].
> 
> Add retry attempts with increasing timer period (10ms, 60ms, 700ms)
> if any test fails, to handle spurious failures due to vCPU stalls.
> 
> 1) Failures we sometimes observe in CI are:
>   "FAIL: TMCCT should have a non-zero value"
>   "FAIL: TMCCT should be reset to the initial-count"
>   "FAIL: TMCCT should not be reset to TMICT value"
> Seen on both Intel and AMD hosts.
> 
> PS:
> on most test runs, test completes fine on the 1st iteration.
> The patch would affect only failure path which will be slowed down
> due to retries but still fail if there is a bug with benefit of
> getting rid of false positives caused by vCPU stalls.
> 
> PS2:
> Number of tries and tmict delta comes from analyzing vcpu stalls
> on heavily overcommited Haswell host with test being bounced between
> 2 sockets.
> Typically 2nd iteration (60ms) is enough to get rid of
> false positives.

Blech.  I would rather rework the testcases to simply not be flaky.  I don't see
any value in waiting for the TMCCT to be half of TMICT; just validate that it
counts down across switches, and that it can wrap in PERIODIC but not in ONESHOT.
We have a KVM selftest to validate the timer counts at the correct rate, so just
validate the core functionality here.

E.g. roughly something like this? 

diff --git a/x86/apic.c b/x86/apic.c
index ed8be25a..1fe6877d 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -532,37 +532,6 @@ static void test_physical_broadcast(void)
 	report(broadcast_received(ncpus), "APIC physical broadcast shorthand");
 }
 
-static void wait_until_tmcct_common(uint32_t initial_count, bool stop_when_half, bool should_wrap_around)
-{
-	uint32_t tmcct = apic_read(APIC_TMCCT);
-
-	if (tmcct) {
-		while (tmcct > (initial_count / 2))
-			tmcct = apic_read(APIC_TMCCT);
-
-		if ( stop_when_half )
-			return;
-
-		/* Wait until the counter reach 0 or wrap-around */
-		while ( tmcct <= (initial_count / 2) && tmcct > 0 )
-			tmcct = apic_read(APIC_TMCCT);
-
-		/* Wait specifically for wrap around to skip 0 TMCCR if we were asked to */
-		while (should_wrap_around && !tmcct)
-			tmcct = apic_read(APIC_TMCCT);
-	}
-}
-
-static void wait_until_tmcct_is_zero(uint32_t initial_count, bool stop_when_half)
-{
-	return wait_until_tmcct_common(initial_count, stop_when_half, false);
-}
-
-static void wait_until_tmcct_wrap_around(uint32_t initial_count, bool stop_when_half)
-{
-	return wait_until_tmcct_common(initial_count, stop_when_half, true);
-}
-
 static inline void apic_change_mode(unsigned long new_mode)
 {
 	uint32_t lvtt;
@@ -576,64 +545,87 @@ static inline void apic_change_mode(unsigned long new_mode)
 			    lvtt & APIC_LVT_TIMER_MASK, new_mode);
 }
 
+static void check_apic_tmcct(unsigned long mode, uint32_t *tmict)
+{
+	/*
+	 * Note, this also covers the case where the timer expired in one-shot
+	 * mode, i.e. if tmcct0 == 0.
+	 */
+	if (tmcct[1] > tmcct[0] && mode == APIC_LVT_TIMER_ONESHOT) {
+		report_fail(...);
+		return;
+	}
+
+	if (tmcct[0] == tmcct[1] &&
+	    (tmcct[0] || mode == APIC_LVT_TIMER_PERIODIC)) {
+		tmcct[1] = apic_read(APIC_TMCCT);
+
+		/*
+		 * Theoretically, this could get a false failure when the timer
+		 * is periodic mode.  In practice, the odds of all three reads
+		 * getting the same value is so absurdly small that it will
+		 * never happen
+		 */
+		if (tmcct[0] == tmcct[1])
+			report_fail(...);
+	}
+}
+
 static void test_apic_change_mode(void)
 {
+	unsigned long mode = APIC_LVT_TIMER_ONESHOT;
 	uint32_t tmict = 0x999999;
+	uint32_t tmcct[2];
 
 	printf("starting apic change mode\n");
 
+	apic_change_mode(mode);
 	apic_write(APIC_TMICT, tmict);
 
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
-
-	report(apic_read(APIC_TMICT) == tmict, "TMICT value reset");
-
-	/* Testing one-shot */
-	apic_change_mode(APIC_LVT_TIMER_ONESHOT);
-	apic_write(APIC_TMICT, tmict);
-	report(apic_read(APIC_TMCCT), "TMCCT should have a non-zero value");
-
-	wait_until_tmcct_is_zero(tmict, false);
-	report(!apic_read(APIC_TMCCT), "TMCCT should have reached 0");
-
 	/*
-	 * Write TMICT before changing mode from one-shot to periodic TMCCT should
-	 * be reset to TMICT periodicly
+	 * 1. ONESHOT => PERIODIC
+	 * 2. PERIODIC => ONESHOT
+	 * 3. ONESHOT => PERIODIC
+	 * 4. PERIODIC => ONESHOT => PERIODIC (final checks)
 	 */
-	apic_write(APIC_TMICT, tmict);
-	wait_until_tmcct_is_zero(tmict, true);
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
-	report(apic_read(APIC_TMCCT), "TMCCT should have a non-zero value");
+	for (i = 0; i < 4; i++) {
+		if (apic_read(APIC_TMICT) != tmict)
+			report_fail(...);
+
+		mode ^= BIT(17);
+		apic_change_mode(mode);
+
+		tmcct[0] = apic_read(APIC_TMCCT);
+		do {
+			tmcct[1] = apic_read(APIC_TMCCT);
+			check_apic_tmcct(tmcct);
+		} while (tmcct[1] && tmcct[1] < tmcct[0]);
+
+		tmcct[0] = tmcct[1];
+		tmcct[1] = apic_read(APIC_TMCCT);
+		check_apic_tmcct(mode, tmcct);
+		if (mode == APIC_LVT_TIMER_ONESHOT)
+			apic_write(APIC_TMICT, tmict);
+	}
 
-	/*
-	 * After the change of mode, the counter should not be reset and continue
-	 * counting down from where it was
-	 */
-	report(apic_read(APIC_TMCCT) < (tmict / 2),
-	       "TMCCT should not be reset to TMICT value");
-	/*
-	 * Specifically wait for timer wrap around and skip 0.
-	 * Under KVM lapic there is a possibility that a small amount of consecutive
-	 * TMCCR reads return 0 while hrtimer is reset in an async callback
-	 */
-	wait_until_tmcct_wrap_around(tmict, false);
-	report(apic_read(APIC_TMCCT) > (tmict / 2),
-	       "TMCCT should be reset to the initial-count");
+	apic_change_mode(APIC_LVT_TIMER_ONESHOT);
+	tmcct[0] = apic_read(APIC_TMCCT);
+	do {
+		tmcct[1] = apic_read(APIC_TMCCT);
+		check_apic_tmcct(APIC_LVT_TIMER_ONESHOT, tmcct);
+	} while (tmcct[1] && tmcct[1] < tmcct[0]);
+
+	if (tmcct[1])
+		report_fail(...);
 
-	wait_until_tmcct_is_zero(tmict, true);
-	/*
-	 * Keep the same TMICT and change timer mode to one-shot
-	 * TMCCT should be > 0 and count-down to 0
-	 */
 	apic_change_mode(APIC_LVT_TIMER_ONESHOT);
-	report(apic_read(APIC_TMCCT) < (tmict / 2),
-	       "TMCCT should not be reset to init");
-	wait_until_tmcct_is_zero(tmict, false);
-	report(!apic_read(APIC_TMCCT), "TMCCT should have reach zero");
-
-	/* now tmcct == 0 and tmict != 0 */
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
-	report(!apic_read(APIC_TMCCT), "TMCCT should stay at zero");
+
+	/* Switching to PERIODIC mode should NOT re-arm the timer. */
+	tmcct[1] = apic_read(APIC_TMCCT);
+	if (tmcct[1])
+		report_fail(...);
+	else
+	 	report_pass();
 }
 
 #define KVM_HC_SEND_IPI 10
