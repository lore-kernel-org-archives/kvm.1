Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3143CED6
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383337; cv=none; b=gsZ3OifdTcuSCiJAhAgcZFrq+BqbobI2Q+rzqMWe1in71E3TcPGsBToX9huGm4rbmlFEEpq7FHVIg6IjVVr1zos1VY195EwKBCZcE9VqKagGa29Vi7wZ8RIOr+kB7c8QlJb1Ya9eL5xjAiNkf+B5EA61FnNwYJtmGD3XozZSH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383337; c=relaxed/simple;
	bh=dBaDq7DDtU0aTlgQ5s8CMa+83DSC3thz5fkCkbIj/Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5OesRG0Yr20zA5QNypm2jXNHJH6//wQAR6AA7/XooxXY/wxwfcTha3TZ0he3kpmaWzdft3MupWWDR/nOKx3gMTmiJwVtjBHknmIardk6H1UNPO9VbIt5bXK4cNpYXxll7KDs1EIooYiUdn0vOx8+qodeY2Vhixa16jdeK0fu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXjyk9TZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXjyk9TZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777383335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWWZVJcA4Bjor51Fqp6C5iiJ6Bii0wYwQw98xBxMno0=;
	b=LXjyk9TZL+9jRYJ7Zr/x13ZeTzMCizqFdMuZaCFEwyCPs4rma7sHf2mxFpQ6obeD56mbTY
	0JRl6gYl0LRs3q68ZeIiv8G8SNwr6qRTaFHe1K2VTq6GmQg6/I5B3eg6EvC2zB/wrnJXXJ
	+AL6U2x78I5SAzFrdpDI49RnwjyZEQU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-WVz3OuZoNcKumkEQuylhBg-1; Tue,
 28 Apr 2026 09:35:33 -0400
X-MC-Unique: WVz3OuZoNcKumkEQuylhBg-1
X-Mimecast-MFC-AGG-ID: WVz3OuZoNcKumkEQuylhBg_1777383332
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD4D61954B0B
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:30 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA35419560B7;
	Tue, 28 Apr 2026 13:35:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Subject: [kvm-unit-tests PATCH 2/2] x86/apic: add retry logic to test_apic_change_mode
Date: Tue, 28 Apr 2026 15:35:24 +0200
Message-ID: <20260428133524.3628482-3-imammedo@redhat.com>
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

The APIC timer runs at wall clock time under KVM. If vCPU is stalled for
long enough, timer can expire before the guest reads TMCCT or tick well
past expected values, causing various false test failures [1].

Add retry attempts with increasing timer period (10ms, 60ms, 700ms)
if any test fails, to handle spurious failures due to vCPU stalls.

1) Failures we sometimes observe in CI are:
  "FAIL: TMCCT should have a non-zero value"
  "FAIL: TMCCT should be reset to the initial-count"
  "FAIL: TMCCT should not be reset to TMICT value"
Seen on both Intel and AMD hosts.

PS:
on most test runs, test completes fine on the 1st iteration.
The patch would affect only failure path which will be slowed down
due to retries but still fail if there is a bug with benefit of
getting rid of false positives caused by vCPU stalls.

PS2:
Number of tries and tmict delta comes from analyzing vcpu stalls
on heavily overcommited Haswell host with test being bounced between
2 sockets.
Typically 2nd iteration (60ms) is enough to get rid of
false positives.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 x86/apic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/x86/apic.c b/x86/apic.c
index d4eb8e11..27597323 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -575,9 +575,12 @@ static void test_apic_change_mode(void)
 {
 	const uint32_t tmict_values[] = {
 		0x999999,    /* ~10ms */
+		0x3938700,   /* ~60ms */
+		0x29b92700,  /* ~700ms */
 	};
 	int retry, max_retries = ARRAY_SIZE(tmict_values);
 	uint32_t tmict;
+	bool fail;
 	bool tmict_reset = false, o_nonzero = false, o_reached_zero = false;
 	bool p_nonzero = false, p_not_reset = false, p_after_wrap = false;
 	bool p2o_not_reset = false, p2o_reached_zero = false, p2o_stay_zero = false;
@@ -635,6 +638,11 @@ static void test_apic_change_mode(void)
 		/* now tmcct == 0 and tmict != 0 */
 		apic_change_mode(APIC_LVT_TIMER_PERIODIC);
 		p2o_stay_zero = !apic_read(APIC_TMCCT);
+		fail = !(tmict_reset && o_nonzero && o_reached_zero &&
+			 p_nonzero && p_not_reset && p_after_wrap &&
+			 p2o_not_reset && p2o_reached_zero && p2o_stay_zero);
+		if (!fail)
+			break;
 	}
 
 	report(tmict_reset, "TMICT value reset");
-- 
2.47.3

