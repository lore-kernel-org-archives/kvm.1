Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41F3F12E5
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377212; cv=none; b=BfOS7QRs62PX6e9CunNMCfwg7aFGo+MQfY948I0uSBgtu8zPrHwyZwibTRewbw6QFeX9ooeWJ9wDnwhfs43KYPcoMrW/GntnyUnJOsvshBHP/nj5P/fjdrwV49q8PcIhe7newEGk0F+R0/aitvcA+Z6zw/gin8O+grWDb2JyqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377212; c=relaxed/simple;
	bh=tAjpovCcX7+vwIp6cdIHTeyqeVLs+MxBwdjbPJHGhHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9rMDdaS1RwTF35YJ+LDn1rIY2ejRmkiCNMDqH6SEVAOXz/DxrEn02brpVVrwVLW+DWAXIodGm9T2V6RsUL9KAfx3G4ffPNbqDySDg0zYhmPtbU4HMNFjtO8mGfi7fnmWc4uOoVmhGBsJk6J89s4AXS1tW2cfibqkhRZz/Mdb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOWWcbFW; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOWWcbFW"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso24416385ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377210; x=1790982010; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+UNxOFkHV0gdr/o2+5r60XSKOGFhrcs+9bdGuD0ED8k=;
        b=aOWWcbFWXiX9k35L8Rfz1OUeRWnPjaJx8Vdnsg6wjnPjrUVbiWeUZQDMKr/Gj7uts4
         Vz4ZoI69aTOd++s1AJ+0FAZFQeEJpGON7jywGvYH+UlzDXZc3oWc9sBkoC3nAc3mQ6sK
         rw6qivOVsplLLWiAFvW1UD+rlqBIt4OKPtLDBAvztjIwm2eyYgvy76UYCeZUBwMtY0q+
         e5nI7oAaL8ANkl3BRsU2DAiffCO1SWsTPIAAUWe0VavDc/aelctMzeXLGxilaDukGzTR
         mWwZbjRZcn4I6fLIzputjirctciaPT44fRy+LoOFTOzqXBTVIqA2vi7xTCmtv7aGAESA
         HEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377210; x=1790982010;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+UNxOFkHV0gdr/o2+5r60XSKOGFhrcs+9bdGuD0ED8k=;
        b=yVLyFGH7YulSdBaPmsEviGRVWRP0EnWzfmSgj2S+m8XPliIRkrAYjONGh0FsFhz241
         Eo4yGVzDE8pnGzUTU5fHsVKcBznIVl3b6yMNsUgBzSm2VEBiQ0RBR4v0SmkiCyl1xhMI
         JnRIOTbzHwrAf3s1kddFDQv6P77iM7kDdHl0K2NwseJjKxKfV3V/I0ML4NTuNevJsY5R
         5E6OhtIQJ60h5nGQUuDyFOZtXFh0SPZXgJ6vipsCEEZRVEkM6Guk2IH33/HS4zZghi1X
         aSTECq1HXHVl3uh5c79SlSj+2uusXWVRsSyVq0x7ng9zqGekL2/7K4IMWuTA0XKJwdUn
         hfNw==
X-Gm-Message-State: AFuF++m1Fir19CldtC2hukk4K9v5hcQPlVo/b/KWvudWMwP2sAiZk0nw
	jXhoAFKDo2TJzDFpfW/EYV2wGxk6g0qP61mEafKKUifWV9vcro8hlEU74qC88gXcyDyxVVy7cpv
	h17LNQQ==
X-Received: from plme16.prod.google.com ([2002:a17:903:4910:b0:2dd:63c:daa3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4405:b0:2dd:c100:3133
 with SMTP id d9443c01a7336-2df7e23684dmr52370575ad.47.1790377209226; Fri, 25
 Sep 2026 16:00:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 16:00:02 -0700
In-Reply-To: <20260925230003.2362261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925230003.2362261-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925230003.2362261-4-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 3/4] x86/debug: Verify that KVM correctly
 emulates DR6 active-low and fixed-1 semantics
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Run the main debug testcases with a control DR6 value (the value written to
DR6 prior to doing a #DB test) with both active-low bits set and active-low
bits clear.  Setting only one or the other means the test will miss bugs,
e.g. will fail to detect cases where hardware/KVM incorrectlys sets/clears
an active-low bit.

Note, DR6.RTM and DR6.BLD have different semantics.  DR6.RTM is modified by
all #DBs, i.e. is explicitly set/cleared based on whether or not a #DB
occurred in an RTM region.  DR6.BLD on the other hand is never supposed to
be set by hardware; it's cleared on Bus Lock #DBs, and otherwise isn't
modified.  Or at least, it's not supposed to be modified.  AMD CPUs appear
to have a ucode bug where DR6.BLD is forced to '1' on *all* writes to DR6
if Bus Lock Detect isn't fully enabled, including DR6 loads via VMRUN.  To
fudge around the quirk, simply enable BUS_LOCK_DETECT in DEBUGCTL so that
the test can write DR6.BLD at will.  As a bonus, enabling BUS_LOCK_DETECT
will help catch spurious Bus Lock #DBs.

Don't bother running the test that clobbers the #DB IDT entry directly
with both configurations; just run it once at the end to avoid having to
restore the IDT.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/debug.c | 109 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 26 deletions(-)

diff --git a/x86/debug.c b/x86/debug.c
index c677af99..5427797f 100644
--- a/x86/debug.c
+++ b/x86/debug.c
@@ -16,6 +16,9 @@
 #include "desc.h"
 #include "usermode.h"
 
+static unsigned long dr6_control_value;
+static unsigned long dr6_base_value;
+
 static volatile unsigned long bp_addr;
 static volatile unsigned long db_addr[10], dr6[10];
 static volatile unsigned int n;
@@ -49,17 +52,17 @@ static void handle_db(struct ex_regs *regs)
 
 static inline bool is_single_step_db(unsigned long dr6_val)
 {
-	return dr6_val == (DR6_ACTIVE_LOW | DR6_BS);
+	return dr6_val == (dr6_base_value | DR6_BS);
 }
 
 static inline bool is_general_detect_db(unsigned long dr6_val)
 {
-	return dr6_val == (DR6_ACTIVE_LOW | DR6_BD);
+	return dr6_val == (dr6_base_value | DR6_BD);
 }
 
 static inline bool is_icebp_db(unsigned long dr6_val)
 {
-	return dr6_val == DR6_ACTIVE_LOW;
+	return dr6_val == dr6_base_value;
 }
 
 extern unsigned char handle_db_save_rip;
@@ -100,7 +103,7 @@ static void __run_single_step_db_test(db_test_fn test, db_report_fn report_fn)
 	bool ign;
 
 	n = 0;
-	write_dr6(DR6_ACTIVE_LOW);
+	write_dr6(dr6_control_value);
 
 	start = test();
 	report_fn(start, "");
@@ -114,7 +117,7 @@ static void __run_single_step_db_test(db_test_fn test, db_report_fn report_fn)
 		return;
 
 	n = 0;
-	write_dr6(DR6_ACTIVE_LOW);
+	write_dr6(dr6_control_value);
 
 	/*
 	 * Run the test in usermode.  Use the expected start RIP from the first
@@ -336,7 +339,7 @@ static void report_singlestep_with_movss_blocking_and_dr7_gd(unsigned long start
 
 static noinline unsigned long singlestep_with_movss_blocking_and_dr7_gd(void)
 {
-	unsigned long scratch = DR6_ACTIVE_LOW;
+	unsigned long scratch = dr6_control_value;
 
 	write_dr7(DR7_GD);
 
@@ -452,17 +455,34 @@ static void bus_lock_test(void)
 	got_ac = false;
 }
 
-int main(int ac, char **av)
+static void run_tests(unsigned long __dr6_control_value)
 {
+	u64 debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
 	unsigned long cr4;
 
-	handle_exception(DB_VECTOR, handle_db);
-	handle_exception(BP_VECTOR, handle_bp);
-	handle_exception(UD_VECTOR, handle_ud);
-	handle_exception(AC_VECTOR, handle_ac);
+	dr6_control_value = __dr6_control_value;
+
+	/*
+	 * DR6.RTM is modified on all #DBs, and is '0' if and only if the #DB
+	 * occurred in an RTM region.  This test doesn't do RTM, and so DR6.RTM
+	 * should always be set, even if it's '0' in the control value.
+	 */
+	dr6_base_value = dr6_control_value | DR6_FIXED_1 | DR6_RTM;
+
+	/* DR6.BLD is fixed-1 if Bus Lock Detect is supported. */
+	if (!this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		dr6_base_value |= DR6_BUS_LOCK;
 
 	bus_lock_test();
 
+	/*
+	 * Enable Bus Lock Detect to workaround an AMD ucode bug where DR6.BLD
+	 * is clobbered to '1', i.e. is "reset" (it's an active-low bit), on
+	 * *any* DR6 load, including asynchronous loads via #VMEXIT => VMRUN.
+	 */
+	if (this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		wrmsr(MSR_IA32_DEBUGCTLMSR, debugctl | DEBUGCTLMSR_BUS_LOCK_DETECT);
+
 	/*
 	 * DR4 is an alias for DR6 (and DR5 aliases DR7) if CR4.DE is NOT set,
 	 * and is reserved if CR4.DE=1 (Debug Extensions enabled).
@@ -471,15 +491,16 @@ int main(int ac, char **av)
 	cr4 = read_cr4();
 	write_cr4(cr4 & ~X86_CR4_DE);
 	write_dr4(0);
-	write_dr6(DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP1);
-	report(read_dr4() == (DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP1) && !got_ud,
-	       "DR4==DR6 with CR4.DE == 0");
+	write_dr6(dr6_control_value | DR6_BS | DR6_TRAP1);
+	report(read_dr4() == read_dr6() && !got_ud,
+	       "DR4 (0x%lx) == DR6 (0x%lx) with CR4.DE == 0",
+	       read_dr4(), read_dr6());
 
 	cr4 = read_cr4();
 	write_cr4(cr4 | X86_CR4_DE);
 	read_dr4();
 	report(got_ud, "DR4 read got #UD with CR4.DE == 1");
-	write_dr6(DR6_ACTIVE_LOW);
+	write_dr6(dr6_control_value);
 
 	extern unsigned char sw_bp;
 	asm volatile("int3; sw_bp:");
@@ -500,21 +521,21 @@ int main(int ac, char **av)
 	asm volatile("hw_bp1: nop");
 	report(n == 1 &&
 	       db_addr[0] == ((unsigned long)&hw_bp1) &&
-	       dr6[0] == (DR6_ACTIVE_LOW | DR6_TRAP2),
+	       dr6[0] == (dr6_base_value | DR6_TRAP2),
 	       "Wanted #DB on 0x%lx w/ DR6 = 0x%lx, got %u #DBs, addr[0] = 0x%lx, DR6 = 0x%lx",
-	       ((unsigned long)&hw_bp1), DR6_ACTIVE_LOW | DR6_TRAP2,
+	       ((unsigned long)&hw_bp1), dr6_base_value | DR6_TRAP2,
 	       n, db_addr[0], dr6[0]);
 
 	n = 0;
 	extern unsigned char hw_bp2;
 	write_dr2(&hw_bp2);
-	write_dr6(DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP1);
+	write_dr6(dr6_control_value | DR6_BS | DR6_TRAP1);
 	asm volatile("hw_bp2: nop");
 	report(n == 1 &&
 	       db_addr[0] == ((unsigned long)&hw_bp2) &&
-	       dr6[0] == (DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP2),
+	       dr6[0] == (dr6_base_value | DR6_BS | DR6_TRAP2),
 	       "Wanted #DB on 0x%lx w/ DR6 = 0x%lx, got %u #DBs, addr[0] = 0x%lx, DR6 = 0x%lx",
-	       ((unsigned long)&hw_bp2), DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP2,
+	       ((unsigned long)&hw_bp2), dr6_base_value | DR6_BS | DR6_TRAP2,
 	       n, db_addr[0], dr6[0]);
 
 	run_ss_db_test(singlestep_basic);
@@ -527,7 +548,7 @@ int main(int ac, char **av)
 
 	n = 0;
 	write_dr1((void *)&value);
-	write_dr6(DR6_ACTIVE_LOW | DR6_BS);
+	write_dr6(dr6_control_value | DR6_BS);
 	write_dr7(0x00d0040a); // 4-byte write
 
 	extern unsigned char hw_wp1;
@@ -537,11 +558,11 @@ int main(int ac, char **av)
 		: "=m" (value) : : "rax");
 	report(n == 1 &&
 	       db_addr[0] == ((unsigned long)&hw_wp1) &&
-	       dr6[0] == (DR6_ACTIVE_LOW | DR6_BS | DR6_TRAP1),
+	       dr6[0] == (dr6_base_value | DR6_BS | DR6_TRAP1),
 	       "hw watchpoint (test that dr6.BS is not cleared)");
 
 	n = 0;
-	write_dr6(DR6_ACTIVE_LOW);
+	write_dr6(dr6_control_value);
 
 	extern unsigned char hw_wp2;
 	asm volatile(
@@ -550,18 +571,36 @@ int main(int ac, char **av)
 		: "=m" (value) : : "rax");
 	report(n == 1 &&
 	       db_addr[0] == ((unsigned long)&hw_wp2) &&
-	       dr6[0] == (DR6_ACTIVE_LOW | DR6_TRAP1),
+	       dr6[0] == (dr6_base_value | DR6_TRAP1),
 	       "hw watchpoint (test that dr6.BS is not set)");
 
 	n = 0;
-	write_dr6(DR6_ACTIVE_LOW);
+	write_dr6(dr6_control_value);
 	extern unsigned char sw_icebp;
 	asm volatile(".byte 0xf1; sw_icebp:");
 	report(n == 1 &&
-	       db_addr[0] == (unsigned long)&sw_icebp && dr6[0] == DR6_ACTIVE_LOW,
+	       db_addr[0] == (unsigned long)&sw_icebp && dr6[0] == dr6_base_value,
 	       "icebp");
 
+	write_dr7(DR7_FIXED_1);
+	write_dr0(0);
+	write_dr1(0);
+	write_dr2(0);
+	write_dr3(0);
+	write_dr6(DR6_ACTIVE_LOW);
+	write_cr4(cr4);
+	wrmsr(MSR_IA32_DEBUGCTLMSR, debugctl);
+
+	n = 0;
+	value = 0;
+	got_ud = false;
+	got_ac = false;
+}
+
+static void test_watchpoints_precise(void)
+{
 	write_dr7(0x400);
+	write_dr1((void *)&value);
 	value = KERNEL_DS;
 	write_dr7(0x00f0040a); // 4-byte read or write
 
@@ -606,5 +645,23 @@ int main(int ac, char **av)
 	extern unsigned char sw_bp2;
 	report(n == 3 && bp_addr == (unsigned long)&sw_bp2,
 	       "MOV SS + watchpoint + INT3");
+}
+
+int main(int ac, char **av)
+{
+	handle_exception(DB_VECTOR, handle_db);
+	handle_exception(BP_VECTOR, handle_bp);
+	handle_exception(UD_VECTOR, handle_ud);
+	handle_exception(AC_VECTOR, handle_ac);
+
+	run_tests(DR6_ACTIVE_LOW);
+	run_tests(0);
+
+	/*
+	 * Run the "precise" test only once as it is destructive (clobbers the
+	 * #DB IDT entry).
+	 */
+	test_watchpoints_precise();
+
 	return report_summary();
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

