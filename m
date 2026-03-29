Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745628371;
	Sun, 29 Mar 2026 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824183; cv=none; b=Zlc95RLT0tIl7/NG2sruMi2oEg9ko8Y1o42XYkbDYUXX9bfjGCtvk4x4WB1HDXAmu1pZaG079kJjzFjQv0Kc+i96aHsC7YjYs6+XKrespXjlskgQN+nKTNOK5RuWZR7/QcmEhMKBRM1Kyk4wR1KQox8kIkF9NhpKgQ7coVfStds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824183; c=relaxed/simple;
	bh=NiLzS0ipCyy1PIu6j+RCs67vPXkVNcliEURzQ7pg0xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dn00dF6a1/rdu5K/jbFhxMa57krpnhtvWRI8i6BJyoKlMiBgqe4gh9MW3IMBvi5LHUCfL5FB3+ajreVZl8YsjshLdp9Vp23KqWC9Y4MMyfoxOkKmijDu/xun7RmBpIsVUiJJKvQD1QUeQrOWNiBb4fDz9sEZhPMNTTEteav+izw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya9Q/DrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya9Q/DrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034FC19423;
	Sun, 29 Mar 2026 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774824183;
	bh=NiLzS0ipCyy1PIu6j+RCs67vPXkVNcliEURzQ7pg0xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ya9Q/DrXKr8xf3yXWTE5tZxeRICuYbCCyfxq/ekmn6xUxenboZ2NzLtFqa40u0Mq3
	 H9I8frnxCT9jBaVBbQq8PGPhYCnwyvoP4GxAqnWlGmfovgKmQOyi1voLMRN9TtA6hI
	 NTNVRd2q94Fm9XP7Psg4CsvSO+zKqoUMB+9Viz55p2k6IsT15wYOOuk5S8xURc34Fh
	 2Zylh9aqJXm/5rVjOogG6adPgUaZ5/LIOPjphUHMEGakjYAaDHIr2zWHcrHZCIeclY
	 gvLV34cQj9MT2nRg15e3PM7U3T4jmjeYEORYXj6Z3ZUcAJ4SzqMDkeLdFRfIpGOfC+
	 Umjnz9GdA0JiA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Bird, Tim" <Tim.Bird@sony.com>, "pmladek@suse.com" <pmladek@suse.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org"
 <senozhatsky@chromium.org>, Shashank Balaji <shashankbalaji02@gmail.com>,
 "john.ogness@linutronix.de" <john.ogness@linutronix.de>
Cc: "francesco@valla.it" <francesco@valla.it>, "geert@linux-m68k.org"
 <geert@linux-m68k.org>, "linux-embedded@vger.kernel.org"
 <linux-embedded@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, x86@kernel.org, Paolo Bonzini
 <bonzini@gnu.org>, Sean Christopherson <seanjc@google.com>, KVM
 <kvm@vger.kernel.org>
Subject: RE: [PATCH v3] printk: fix zero-valued printk timestamps in early boot
In-Reply-To: <87jyuvboo2.ffs@tglx>
References: <39b09edb-8998-4ebd-a564-7d594434a981@bird.org>
 <20260210234741.3262320-1-tim.bird@sony.com> <87zf3ud92r.ffs@tglx>
 <MW5PR13MB5632FC91EE0EF8754331400DFD57A@MW5PR13MB5632.namprd13.prod.outlook.com>
 <87jyuvboo2.ffs@tglx>
Date: Mon, 30 Mar 2026 00:42:59 +0200
Message-ID: <87fr5ib6ks.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tim!

On Sat, Mar 28 2026 at 22:59, Thomas Gleixner wrote:
> The only clean way to solve this cleanly is moving the sched clock
> initialization to the earliest point possible and accepting that due to
> hardware, enumeration and virtualization constraints this point might be
> suboptimal. Everything else is just an attempt to defy reality.

As the wheather was lousy, I sat down for a couple of hours and
implemented the obviously incomplete PoC below for illustration.

As the FIXME comment in tsc_early_boot_setup() tells clearly, this is far
from complete and needs way more thoughts and scrutiny, but it's good
enough to prove the point:

[    0.000019] tsc: Boot sched clock enabled

As early as possible, but with at least the minimal safe guards in place.

[    0.000041] Linux version 7.0.0-rc5+ (tglx@tglx-pladt) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #893 SMP PREEMPT_DYNAMIC Sun Mar 29 21:38:08 CEST 2026
[    0.000043] Command line: BOOT_IMAGE=/boot/vmlinuz-7.0.0-rc5+ root=UUID=fa44d501-1716-402a-8602-6315c3166f7b ro console=tty0 console=ttyS0,115200n8 ftrace_dump_on_oops earlyprintk=ttyS0,115200n8 tsc_early_khz=2095070 no-kvmclock

   1) tsc_early_khz is required because KVM does not provide the frequency
      leaf.

   2) no-kvmclock is required because KVM thinks it is more important than
      everything else.

Both issues are completely unrelated to the problem at hand.

[    0.009415] BIOS-provided physical RAM map:
[    0.009416] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] System RAM
...
[    0.009473] printk: legacy bootconsole [earlyser0] enabled
...
[    0.021037] Hypervisor detected: KVM

Without 'no-kvmclock' KVM would take over sched clock and reset sched
clock time to 0 because KVM... Trivial problem to be solved and left as
an exercise for the reader.

[    0.021256] last_pfn = 0x7ffdb max_arch_pfn = 0x400000000
[    0.051429] tsc: Fast TSC calibration using PIT
[    0.051699] tsc: Detected 2094.808 MHz processor
[    0.051990] tsc: Detected 2095.070 MHz TSC

That's in tsc_early_init() which enables the sched clock static key.

[    0.052871] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved

Unsurprisingly time continues without a gap, jumping backwards or whatever.

If you want to have early timestamps then you have to go through the low
level code on every architecture and do the proper sanity checks,
enumerations, etc. no matter what. There is no guarantee that you can
use any clock unconditionally during very early boot.

As you have to do that anyway, there is _zero_ justification for an
extra facility side stepping sched clock, which would just create
another pile of technical debt.

Quite the contrary, I'm going to get rid of technical debt:

  The get_cycles() related changes in tsc.h are going to end up in a
  obviously revised formal patch tomorrow as there is exactly _zero_
  requirement to provide this as a functional interface.

  1) The default implementation in asm-generic returns 0

     Ergo any code depending on a functional implementation is broken
     by definition.

  2) The ops/cycles metrics are as bogus as the infamous BogoMIPS metrics
  
     The "cycle" counter runs on almost all contemporary CPUs at a fixed
     frequency, which is completely unrelated to the actual CPU
     frequency and therefore to the actual CPU cycles.

     The only realistic metric is ops/sec and nothing else and that can
     be trivially achieved by using the generic time getter interfaces.

     Those might end up resulting in bogus benchmark results too if the
     underlying clocksource is jiffies, but that's again a matter of
     accepting reality.

     If people really mandate that ops/bogo_cycles is required for the
     very wrong reasons, then I'm happy to bring it back with a global
     name change from get_cycles() to get_bogo_cycles() which excludes
     it from any serious usage including printk.

Thanks,

        tglx
---
 arch/x86/include/asm/tsc.h        |   11 ++--
 arch/x86/kernel/platform-quirks.c |    2 
 arch/x86/kernel/tsc.c             |   96 ++++++++++++++++++++++++++++++--------
 3 files changed, 85 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -76,10 +76,7 @@ extern void disable_TSC(void);
 
 static inline cycles_t get_cycles(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return 0;
-	return rdtsc();
+	return 0;
 }
 #define get_cycles get_cycles
 
@@ -114,6 +111,12 @@ static inline void tsc_verify_tsc_adjust
 static inline void check_tsc_sync_target(void) { }
 #endif
 
+#if defined(CONFIG_X86_TSC) && defined(CONFIG_X86_64)
+void tsc_early_boot_setup(void);
+#else
+static inline void tsc_early_boot_setup(void) { }
+#endif
+
 extern int notsc_setup(char *);
 extern void tsc_save_sched_clock_state(void);
 extern void tsc_restore_sched_clock_state(void);
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -32,6 +32,8 @@ void __init x86_early_init_platform_quir
 
 	if (x86_platform.set_legacy_features)
 		x86_platform.set_legacy_features();
+
+	tsc_early_boot_setup();
 }
 
 bool __init x86_pnpbios_disabled(void)
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -18,6 +18,7 @@
 #include <linux/static_call.h>
 
 #include <asm/cpuid/api.h>
+#include <asm/cmdline.h>
 #include <asm/hpet.h>
 #include <asm/timer.h>
 #include <asm/vgtod.h>
@@ -48,6 +49,7 @@ EXPORT_SYMBOL(tsc_khz);
  */
 static int __read_mostly tsc_unstable;
 static unsigned int __initdata tsc_early_khz;
+static bool tsc_early_boot_enabled __ro_after_init;
 
 static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
 
@@ -202,12 +204,12 @@ static void set_cyc2ns_scale(unsigned lo
 /*
  * Initialize cyc2ns for boot cpu
  */
-static void __init cyc2ns_init_boot_cpu(void)
+static void __init cyc2ns_init_boot_cpu(unsigned long khz)
 {
 	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
 
 	seqcount_latch_init(&c2n->seq);
-	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
+	__set_cyc2ns_scale(khz, smp_processor_id(), rdtsc());
 }
 
 /*
@@ -231,17 +233,24 @@ static void __init cyc2ns_init_secondary
 	}
 }
 
+static __always_inline u64 __native_sched_clock(void)
+{
+	u64 tsc_now = rdtsc();
+
+	/* return the value in ns */
+	return __cycles_2_ns(tsc_now);
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
 noinstr u64 native_sched_clock(void)
 {
-	if (static_branch_likely(&__use_tsc)) {
-		u64 tsc_now = rdtsc();
+	if (static_branch_likely(&__use_tsc))
+		return __native_sched_clock();
 
-		/* return the value in ns */
-		return __cycles_2_ns(tsc_now);
-	}
+	if (tsc_early_boot_enabled)
+		return __native_sched_clock();
 
 	/*
 	 * Fall back to jiffies if there's no TSC available:
@@ -371,12 +380,12 @@ static u64 tsc_read_refs(u64 *p, int hpe
 	int i;
 
 	for (i = 0; i < MAX_RETRIES; i++) {
-		t1 = get_cycles();
+		t1 = rdtsc();
 		if (hpet)
 			*p = hpet_readl(HPET_COUNTER) & 0xFFFFFFFF;
 		else
 			*p = acpi_pm_read_early();
-		t2 = get_cycles();
+		t2 = rdtsc();
 		if ((t2 - t1) < thresh)
 			return t2;
 	}
@@ -468,13 +477,13 @@ static unsigned long pit_calibrate_tsc(u
 	outb(latch & 0xff, 0x42);
 	outb(latch >> 8, 0x42);
 
-	tsc = t1 = t2 = get_cycles();
+	tsc = t1 = t2 = rdtsc();
 
 	pitcnt = 0;
 	tscmax = 0;
 	tscmin = ULONG_MAX;
 	while ((inb(0x61) & 0x20) == 0) {
-		t2 = get_cycles();
+		t2 = rdtsc();
 		delta = t2 - tsc;
 		tsc = t2;
 		if ((unsigned long) delta < tscmin)
@@ -553,9 +562,9 @@ static inline int pit_expect_msb(unsigne
 		if (!pit_verify_msb(val))
 			break;
 		prev_tsc = tsc;
-		tsc = get_cycles();
+		tsc = rdtsc();
 	}
-	*deltap = get_cycles() - prev_tsc;
+	*deltap = rdtsc() - prev_tsc;
 	*tscp = tsc;
 
 	/*
@@ -745,19 +754,23 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
+	struct cpuid_regs regs;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	/* Do it manually as this can be called _before_ boot_cpu_data is initialized */
+	cpuid_leaf(0, &regs);
+	/* Intel only */
+	if (regs.ebx != 0x756e6547 && regs.ecx != 0x6c65746e && regs.edx != 0x49656e69)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+	if (regs.eax < CPUID_LEAF_FREQ)
 		return 0;
 
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
+	memset(&regs, 0, sizeof(&regs));
 
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid_leaf(CPUID_LEAF_FREQ, &regs);
 
-	return eax_base_mhz * 1000;
+	/* EAX contains base MHz */
+	return regs.eax * 1000;
 }
 
 /*
@@ -1512,8 +1525,9 @@ static void __init tsc_enable_sched_cloc
 
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 	tsc_store_and_check_tsc_adjust(true);
-	cyc2ns_init_boot_cpu();
+	cyc2ns_init_boot_cpu(tsc_khz);
 	static_branch_enable(&__use_tsc);
+	tsc_early_boot_enabled = false;
 }
 
 void __init tsc_early_init(void)
@@ -1576,6 +1590,48 @@ void __init tsc_init(void)
 	detect_art();
 }
 
+/* Only 64bit guarantees that CPUID is available */
+#ifdef CONFIG_X86_64
+void __init tsc_early_boot_setup(void)
+{
+	struct cpuid_regs regs;
+	unsigned long khz = 0;
+	char optstr[64];
+
+	if (cmdline_find_option_bool(boot_command_line, "notsc"))
+		return;
+
+	// FIXME: This needs way more sanity checks vs. virt etc.
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		return;
+
+	// Why don't we have proper leaf structs yet?
+	cpuid_leaf(0, &regs);
+	if (regs.eax < 1)
+		return;
+
+	/* TSC enabled in CPUID? */
+	cpuid_leaf(1, &regs);
+	if (!(regs.edx & BIT(4)))
+		return;
+
+	if (cmdline_find_option(boot_command_line, "tsc_early_khz", optstr, sizeof(optstr)) > 0) {
+		// Shut up must check by doing a pointless zeroing
+		if (kstrtoul(optstr, 10, &khz) < 0)
+			khz = 0;
+	}
+
+	if (!khz)
+		khz = cpu_khz_from_cpuid();
+	if (!khz)
+		return;
+
+	cyc2ns_init_boot_cpu(khz);
+	tsc_early_boot_enabled = true;
+	pr_info("Boot sched clock enabled\n");
+}
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * Check whether existing calibration data can be reused.

