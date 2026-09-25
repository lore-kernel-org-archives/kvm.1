Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B93921CD
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377209; cv=none; b=jiVtdJUZgcaJtheN+vXmxCb9Ig5mt6iMBAXd0RRg4UEdSxNw+8S1/8sNDaoD2c5U0UPXvMpS06nms37pW70PjkIu5puTJTYk7HwtxZs0cC53Pp8wd2aQ4f6kwaGX3JJhpwuAUDYYficrA6M9PciYfK+WnzXv8ASHkatU9eXYNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377209; c=relaxed/simple;
	bh=LfxYB+xAj0jpIDlSV7eL1AL0uXguZFBJ9z7Gpv/rg0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+N5vM9Wp8FjvtxFoekSPhsFaRvR9itU0laB+8v8HP6XQNczSJtmxHTJMHFyO9DVsgNS66k8uevoqzKtXQgRPLy+O4tbnqgvb2LNGMGrwZa7MRK4Gan2ZEYRpmds/rkgFY1sPaRV91ggswGdKOEaBGswYyHX9RbhDPp5Q4a2xFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRakSMyo; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRakSMyo"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so13334585ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377207; x=1790982007; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FfhG7ZUzTLU8r8yIGma1v8l1GNynpmVAxgkthmo9nSc=;
        b=LRakSMyoVOMbeCeAVbYgY28fwX8XZrO8EFx1q8uExLpDdfm8WCnZUK/NgLqTsR+Xuj
         39XDyp87lr81hZVnqeQr4L411X/DkXhsbZ3QGF0yv0qg2L6uv9QCF3WBqZb7GvMfnIf7
         g9Zuvo0RH/pSY8rBLfioCPoYf7Fo3YjWapwHpBDxJrS3wik4RvbvPSNnsbgHfJEXTrJX
         nD3aPJj9X8pzn2fkTpA2mjJC1llAWkjGhElEastt7VBe9ifg4TwiXGvRQFXpg4bFC3b1
         1FTNn2S5aXLqEEuw0lRkai4xPUxOYv/gp9le3UBRp4B6B787U5iwzVBIumg2Okkp9LUl
         mIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377207; x=1790982007;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FfhG7ZUzTLU8r8yIGma1v8l1GNynpmVAxgkthmo9nSc=;
        b=vUDgLNWQ217WrbImUbe1yTKaW7ipB0Nm267dcT3C2aw4CfYITw9pkoOhJ0bOhbXiVY
         bQUC/lAM/dHOAwXg1lpKDDtwQuoX+wxdCpkEirtQX5To3otVC1Y3DPi/fr8x1x++JaXF
         SyHPPQVmU8FAj9dS5kmYc0HU1QmEyko6O7KkQThvsWsJncStHVUn7fhhx50wAhzqX7j3
         vATmVJmtEXoJlUqSGk+0x2gz73n6O+PAgE1oz5joNbYcaIZZumnFYuFV604xwc6TmRPo
         rtLZomekev1xaEpHZxQAqYJhqlEJSU/42Vx8F8pgwAjLoYT111DrRhWBkTUaUzhfwulO
         pdEg==
X-Gm-Message-State: AFuF++ne65gzlYUASLLyenm2/5MVH7X+XZOBsO61GtPtl0RMW1sSbaeC
	CacfpMOBZhr5yt6UaMzPazuF2vE6XSQcqWsfM2JQHN7ItM6pKo513uBXVfx+294eSPQZoXBWqlc
	mS35ocQ==
X-Received: from plap10.prod.google.com ([2002:a17:902:f08a:b0:2dd:c160:878b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3810:b0:2d8:d4d0:7930
 with SMTP id d9443c01a7336-2df7da839b9mr55820915ad.20.1790377206764; Fri, 25
 Sep 2026 16:00:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 16:00:00 -0700
In-Reply-To: <20260925230003.2362261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925230003.2362261-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925230003.2362261-2-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 1/4] x86/debug: Set all active-low DR6 bits
 when resetting DR6
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Set all active-low DR6 bits when resetting DR6 between testcases, as
clearing active-low bits causes test failures when run on (virtual) CPUs
that support such bits, due to the checks all expecting the active-low
bits to be set.  The bug has gone unnoticed because the default config uses
a virtual CPU model that doesn't support any active-low bits.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/debug.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/x86/debug.c b/x86/debug.c
index eef0dfd8..c677af99 100644
--- a/x86/debug.c
+++ b/x86/debug.c
@@ -100,7 +100,7 @@ static void __run_single_step_db_test(db_test_fn test, db_report_fn report_fn)
 	bool ign;
 
 	n = 0;
-	write_dr6(0);
+	write_dr6(DR6_ACTIVE_LOW);
 
 	start = test();
 	report_fn(start, "");
@@ -114,7 +114,7 @@ static void __run_single_step_db_test(db_test_fn test, db_report_fn report_fn)
 		return;
 
 	n = 0;
-	write_dr6(0);
+	write_dr6(DR6_ACTIVE_LOW);
 
 	/*
 	 * Run the test in usermode.  Use the expected start RIP from the first
@@ -336,7 +336,7 @@ static void report_singlestep_with_movss_blocking_and_dr7_gd(unsigned long start
 
 static noinline unsigned long singlestep_with_movss_blocking_and_dr7_gd(void)
 {
-	unsigned long start_rip;
+	unsigned long scratch = DR6_ACTIVE_LOW;
 
 	write_dr7(DR7_GD);
 
@@ -348,7 +348,6 @@ static noinline unsigned long singlestep_with_movss_blocking_and_dr7_gd(void)
 	 * General Detect #DB.
 	 */
 	asm volatile(
-		"xor %0, %0\n\t"
 		"pushf\n\t"
 		"pop %%rax\n\t"
 		"or $(1<<8),%%rax\n\t"
@@ -361,9 +360,9 @@ static noinline unsigned long singlestep_with_movss_blocking_and_dr7_gd(void)
 		"push %%rax\n\t"
 		"popf\n\t"
 		"lea 1b(%%rip),%0\n\t"
-		: "=r" (start_rip) : : "rax"
+		: "+r" (scratch) :: "rax"
 	);
-	return start_rip;
+	return scratch;
 }
 
 static void report_singlestep_with_sti_hlt(unsigned long start,
@@ -480,7 +479,7 @@ int main(int ac, char **av)
 	write_cr4(cr4 | X86_CR4_DE);
 	read_dr4();
 	report(got_ud, "DR4 read got #UD with CR4.DE == 1");
-	write_dr6(0);
+	write_dr6(DR6_ACTIVE_LOW);
 
 	extern unsigned char sw_bp;
 	asm volatile("int3; sw_bp:");
@@ -509,7 +508,7 @@ int main(int ac, char **av)
 	n = 0;
 	extern unsigned char hw_bp2;
 	write_dr2(&hw_bp2);
-	write_dr6(DR6_BS | DR6_TRAP1);
+	write_dr6(DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP1);
 	asm volatile("hw_bp2: nop");
 	report(n == 1 &&
 	       db_addr[0] == ((unsigned long)&hw_bp2) &&
@@ -528,7 +527,7 @@ int main(int ac, char **av)
 
 	n = 0;
 	write_dr1((void *)&value);
-	write_dr6(DR6_BS);
+	write_dr6(DR6_ACTIVE_LOW | DR6_BS);
 	write_dr7(0x00d0040a); // 4-byte write
 
 	extern unsigned char hw_wp1;
@@ -542,7 +541,7 @@ int main(int ac, char **av)
 	       "hw watchpoint (test that dr6.BS is not cleared)");
 
 	n = 0;
-	write_dr6(0);
+	write_dr6(DR6_ACTIVE_LOW);
 
 	extern unsigned char hw_wp2;
 	asm volatile(
@@ -555,7 +554,7 @@ int main(int ac, char **av)
 	       "hw watchpoint (test that dr6.BS is not set)");
 
 	n = 0;
-	write_dr6(0);
+	write_dr6(DR6_ACTIVE_LOW);
 	extern unsigned char sw_icebp;
 	asm volatile(".byte 0xf1; sw_icebp:");
 	report(n == 1 &&
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

