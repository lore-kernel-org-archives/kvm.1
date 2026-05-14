Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A43F413B
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793160; cv=none; b=Uq3dHRqxw4owN3Q/MOFaCS46ysZRnmqrHFaoyxAFaLRiQ8UuvxECtJQq2IK7CZzdn+8g9xgHa5SafP9VfP1cBK2QdS74gxVU4bEQMWy4skxzcBw7kxKQdLxkkMHiryjCxYfWXTRAmmQRTY5ZKamBDORRLC7CUJKfiLnj+1KXUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793160; c=relaxed/simple;
	bh=VD3wdqBkDbkDC1XQeLl3ZChUK4YoYUZRNOttfDG+cH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a/mhatbV4WUq94LG+irc/wXxMP2oygCoe16ltip5UqahxHziahELVjDsGTFX8erI7wsAOf1ddgBdKWNKp25i/yHJ4uaVsty2Ovn6ut8ZW5rD/3hU3IVj6GD56ghVtwKxQQ2ggVIg57llxytwmJCvJ8bqIPzwjwHt/vq+k7KJaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bL883Y9i; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bL883Y9i"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82894155ceso6491907a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778793159; x=1779397959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY5wQT0+AR8B9aqpdnfkWWpcF2oSSO/yovQtnMcY/AQ=;
        b=bL883Y9iyFzGXZs64qb2jfvHAooTylX0/6e4jfz1TFlsHhu8R9lzhrXhtS75V7gUw3
         6GuAzGciVicRlb7FjxioHc7HKUDndseeZOvHqDiUnCYUFPe9VZvXFNiZvO2W4ZmZxWYx
         8Fa3yDMPSUVHJFbBeBFCjWLKTcXinzFe9PAcV9xcyrEp33fOIX3bOK87jJObeU5ipNXi
         DVz+uRc5caCgBB4lIJy5BsYkFKIW/bM1oEOQKt+P3fR0COueNDQg4nrqpvbvVk3i8Bsl
         9yG8RdYhxdIpILaSvYsxoj0BLA1Ur64nj9SiruQdbaXdC2oe1/L6mRfPvoQdIabZ00Kg
         OY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793159; x=1779397959;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY5wQT0+AR8B9aqpdnfkWWpcF2oSSO/yovQtnMcY/AQ=;
        b=qP44BdWfIKMcu0kVkaCI3oFxFBREWm6TltSSUz/IjwYn1yZI3wG+uzxWkGSShVdFAw
         8k4p8lIO7X0UipyjBog3+FicuX7s2hLyBf+DvXBjO4ACr9j60u3lnik1fIZpBjw2moYU
         gT87IqCOqBF8cQtPHEkIeOcQLqAcdMdrWfuQWlLWkRhV0aA8GPSJb4nUzb2bwNwgjNqB
         1WXmQuy5ohdH3SjpkR2MHF3nOkNyNRYq1UFg7vNQ5vB7KxreWWMID0WwzW6+wyAHcNs4
         9GYInXkcbDDAdHYEOIfcwpGAgHH1c1Q0fGQGlWLxydr+JplQGNncIz6Px1CNNpv4DJv7
         Z0uA==
X-Gm-Message-State: AOJu0YzZYnT3n0kKjamL78STm0MkyXpfZQCwYxM3CA40qBYAO6Rvr7Rh
	P0afy3HOXVYdu1cV8T2eFrVy/l9WpxZvjAlwlwh8HGfE++PpkG+zdmgmk21Y5EkFKWX76nTlcBW
	f7DRKWA==
X-Received: from pfde26.prod.google.com ([2002:aa7:8c5a:0:b0:835:4037:1869])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a06:b0:82c:9c90:54cf
 with SMTP id d2e1a72fcca58-83f33f14de3mr1166232b3a.43.1778793158452; Thu, 14
 May 2026 14:12:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:12:37 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514211237.1629774-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/debug: Verify DR6 is always empty on an
 INT1/ICEBP #DB
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the single-step + INT/ICEBP #DB testcase to verify that DR6.BS==0
on the ICEBP #DB, even when single-step is fully enabled.  Per the SDM:

  The INT1 instruction also uses a one-byte opcode (F1) and generates a
  debug exception (#DB) without setting any bits in DR6.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/x86/debug.c b/x86/debug.c
index 09f06ef5..36235370 100644
--- a/x86/debug.c
+++ b/x86/debug.c
@@ -281,11 +281,12 @@ static noinline unsigned long singlestep_with_movss_blocking(void)
 static void report_singlestep_with_movss_blocking_and_icebp(unsigned long start,
 							    const char *usermode)
 {
-	report(n == 4 &&
+	report(n == 5 &&
 	       is_icebp_db(dr6[0]) && db_addr[0] == start &&
-	       is_single_step_db(dr6[1]) && db_addr[1] == start + 6 &&
-	       is_single_step_db(dr6[2]) && db_addr[2] == start + 6 + 1 &&
-	       is_single_step_db(dr6[3]) && db_addr[3] == start + 6 + 1 + 1,
+	       is_icebp_db(dr6[1]) && db_addr[1] == start + 1 &&
+	       is_single_step_db(dr6[2]) && db_addr[2] == start + 1 + 6 &&
+	       is_single_step_db(dr6[3]) && db_addr[3] == start + 1 + 6 + 1 &&
+	       is_single_step_db(dr6[4]) && db_addr[4] == start + 1 + 6 + 1 + 1,
 	       "%sSingle-Step + ICEBP #DB w/ MOVSS blocking", usermode);
 }
 
@@ -311,7 +312,8 @@ static noinline unsigned long singlestep_with_movss_blocking_and_icebp(void)
 		"popf\n\t"
 		"mov %%ax, %%ss\n\t"
 		".byte 0xf1;"
-		"1:and $~(1<<8),%%rax\n\t"
+		"1:.byte 0xf1;"
+		"and $~(1<<8),%%rax\n\t"
 		"push %%rax\n\t"
 		"popf\n\t"
 		"lea 1b(%%rip),%0\n\t"

base-commit: 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff
-- 
2.54.0.563.g4f69b47b94-goog

