Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B243CED6
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383341; cv=none; b=NRfE5N05IGT30bRSkVr0yQG7+mX2QLcs9De0m1WJzVx3y/tfAuGMWSAYXX/EqMu5JZsbKJ+sVHlDzP3cjlcb1bXF5NhEg+wOixTnFXa5CcWOL5EJN/jz5H93t8uwFKq8Wit2boyFg34PAXScg5J0vM5Lk8njw+YnphLqW0ZUbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383341; c=relaxed/simple;
	bh=qxplnc/JBQyyyGTyLoPjndr1NOiChBJT8A4Z0PcAMWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duEWM9GXjiNVoz3Xpnah/U1qtmB7DILzN4Uexd+kd37RFBABDl0JAAgyJsdw8irjlJ6/IEKrZKM/wI0FyfZAMKr+X1BLr2UuZrRmPKYH7LIfq1m7lLn4xgWost8dQ6DknWD810oveKm4GITo/INTK6eBbX3LR3LUUw/HryjhEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+X38T2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+X38T2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777383338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lB4Y/5cqM0khTaQSgF8Vzt4Eb20B1iT0B3MRjtH5Vyw=;
	b=T+X38T2jRlFFHsu8fZ97ZKBYqrREpH/d5XXKfXbIv9sI4OH6YcKJ771pw+Co/7keD/9I6R
	4I6UM/BhpktLdmvWk4j/Vz8hCyJiSifyGZOwvUmTi6nmdRu+82a0hVy4K4RsUaD7U53DNo
	3IH+a0WMvXN+lkq+Xta3UIVlg6+V/do=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-kMCbZgEZONuA5cps0NeEcw-1; Tue,
 28 Apr 2026 09:35:35 -0400
X-MC-Unique: kMCbZgEZONuA5cps0NeEcw-1
X-Mimecast-MFC-AGG-ID: kMCbZgEZONuA5cps0NeEcw_1777383331
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E1891802439
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB60C19560AB;
	Tue, 28 Apr 2026 13:35:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Subject: [kvm-unit-tests PATCH 1/2] x86/apic: separate reporting from actual measurements
Date: Tue, 28 Apr 2026 15:35:23 +0200
Message-ID: <20260428133524.3628482-2-imammedo@redhat.com>
In-Reply-To: <20260428133524.3628482-1-imammedo@redhat.com>
References: <20260428133524.3628482-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move report() calls to the end of the function so that serial I/O
does not interfere with timer measurements.

While at it, wrap the test body in a for loop as preparation
for adding retry logic to deal with failures due to large
enough vCPU stalls.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 x86/apic.c | 109 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/x86/apic.c b/x86/apic.c
index 0a52e9a4..d4eb8e11 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -573,62 +573,79 @@ static inline void apic_change_mode(unsigned long new_mode)
 
 static void test_apic_change_mode(void)
 {
-	uint32_t tmict = 0x999999;
+	const uint32_t tmict_values[] = {
+		0x999999,    /* ~10ms */
+	};
+	int retry, max_retries = ARRAY_SIZE(tmict_values);
+	uint32_t tmict;
+	bool tmict_reset = false, o_nonzero = false, o_reached_zero = false;
+	bool p_nonzero = false, p_not_reset = false, p_after_wrap = false;
+	bool p2o_not_reset = false, p2o_reached_zero = false, p2o_stay_zero = false;
 
 	printf("starting apic change mode\n");
 
-	apic_write(APIC_TMICT, tmict);
+	for (retry = 0; retry < max_retries; retry++) {
+		tmict = tmict_values[retry];
+		apic_write(APIC_TMICT, tmict);
+		apic_change_mode(APIC_LVT_TIMER_PERIODIC);
+		tmict_reset = apic_read(APIC_TMICT) == tmict;
 
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
+		/* Testing one-shot */
+		apic_change_mode(APIC_LVT_TIMER_ONESHOT);
+		apic_write(APIC_TMICT, tmict);
+		o_nonzero = apic_read(APIC_TMCCT);
 
-	report(apic_read(APIC_TMICT) == tmict, "TMICT value reset");
+		wait_until_tmcct_is_zero(tmict, false);
+		o_reached_zero = !apic_read(APIC_TMCCT);
 
-	/* Testing one-shot */
-	apic_change_mode(APIC_LVT_TIMER_ONESHOT);
-	apic_write(APIC_TMICT, tmict);
-	report(apic_read(APIC_TMCCT), "TMCCT should have a non-zero value");
+		/*
+		 * Write TMICT before changing mode from one-shot to periodic
+		 * TMCCT should be reset to TMICT periodicly
+		 */
+		apic_write(APIC_TMICT, tmict);
+		wait_until_tmcct_is_zero(tmict, true);
+		apic_change_mode(APIC_LVT_TIMER_PERIODIC);
+		p_nonzero = apic_read(APIC_TMCCT);
 
-	wait_until_tmcct_is_zero(tmict, false);
-	report(!apic_read(APIC_TMCCT), "TMCCT should have reached 0");
+		/*
+		 * After the change of mode, the counter should not be reset
+		 * and continue counting down from where it was
+		 */
+		p_not_reset = apic_read(APIC_TMCCT) < (tmict / 2);
+		/*
+		 * Specifically wait for timer wrap around and skip 0.
+		 * Under KVM lapic there is a possibility that a small amount
+		 * of consecutive TMCCR reads return 0 while hrtimer is reset
+		 * in an async callback
+		 */
+		wait_until_tmcct_wrap_around(tmict, false);
+		p_after_wrap = apic_read(APIC_TMCCT) > (tmict / 2);
 
-	/*
-	 * Write TMICT before changing mode from one-shot to periodic TMCCT should
-	 * be reset to TMICT periodicly
-	 */
-	apic_write(APIC_TMICT, tmict);
-	wait_until_tmcct_is_zero(tmict, true);
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
-	report(apic_read(APIC_TMCCT), "TMCCT should have a non-zero value");
+		wait_until_tmcct_is_zero(tmict, true);
+		/*
+		 * Keep the same TMICT and change timer mode to one-shot
+		 * TMCCT should be > 0 and count-down to 0
+		 */
+		apic_change_mode(APIC_LVT_TIMER_ONESHOT);
+		p2o_not_reset = apic_read(APIC_TMCCT) < (tmict / 2);
 
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
+		wait_until_tmcct_is_zero(tmict, false);
+		p2o_reached_zero = !apic_read(APIC_TMCCT);
 
-	wait_until_tmcct_is_zero(tmict, true);
-	/*
-	 * Keep the same TMICT and change timer mode to one-shot
-	 * TMCCT should be > 0 and count-down to 0
-	 */
-	apic_change_mode(APIC_LVT_TIMER_ONESHOT);
-	report(apic_read(APIC_TMCCT) < (tmict / 2),
-	       "TMCCT should not be reset to init");
-	wait_until_tmcct_is_zero(tmict, false);
-	report(!apic_read(APIC_TMCCT), "TMCCT should have reach zero");
-
-	/* now tmcct == 0 and tmict != 0 */
-	apic_change_mode(APIC_LVT_TIMER_PERIODIC);
-	report(!apic_read(APIC_TMCCT), "TMCCT should stay at zero");
+		/* now tmcct == 0 and tmict != 0 */
+		apic_change_mode(APIC_LVT_TIMER_PERIODIC);
+		p2o_stay_zero = !apic_read(APIC_TMCCT);
+	}
+
+	report(tmict_reset, "TMICT value reset");
+	report(o_nonzero, "one-shot: TMCCT should have a non-zero value");
+	report(o_reached_zero, "one-shot: TMCCT should have reached 0");
+	report(p_nonzero, "periodic: TMCCT should have a non-zero value");
+	report(p_not_reset, "TMCCT should not be reset to TMICT value");
+	report(p_after_wrap, "TMCCT should be reset to the initial-count");
+	report(p2o_not_reset, "TMCCT should not be reset to init");
+	report(p2o_reached_zero, "TMCCT should have reach zero");
+	report(p2o_stay_zero, "TMCCT should stay at zero");
 }
 
 #define KVM_HC_SEND_IPI 10
-- 
2.47.3

