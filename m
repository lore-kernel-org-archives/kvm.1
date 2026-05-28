Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033D1C862F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984401; cv=none; b=jAn3FpUGoFrmuXUQLbv9p4/HjvuZMHHxXK3OzulVdUub9kdYS/QFXnl63lqNBebNunOv40/9rz1hu8EJM6J59I3N+4U9WyeSmSboDo/L89rxkRVmQMsAjSFuD1SJlg03hLXD7o4HNuidjp/jjQCue2+4cM5MSwhkldMga3jONdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984401; c=relaxed/simple;
	bh=DgpdVwipEiezIRvxfF5seL/n9LZzli6PHkGtUkR1sEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O80JVmK2Eg+0NR/+uapXO5/fsetj4u+8Vj6+jaU+JnucLdWQwj/ln8Lb0BwVKirQWUmdIknRc5b8KIylVqHyn27rDa9vfFf7numepv/w6T7D9jiVWdVY08cvJBWMdcPGLKL9M/I8qJvYAJ/vR7lZfoMoN7EUWfPsK7ZFZ5cLRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwgvgrzT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwgvgrzT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so139358385ad.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984398; x=1780589198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IYmX7v3xAuE6rco3LwL5u5r8CjUiC1V8pXCUJsSp6Y=;
        b=IwgvgrzTq2NshUe8LgKnuG5n3VYyrFUQAWt6LoqkDshZiJVJZE99RsZIXpXwj0VVBa
         Pt0xcsFbA7lOpQWnzRCaEyv/1khyyU2CspuErYjxoIQWqJJvLfWCR9whpC7MQy7E73+M
         1uB7yDpJG0hbM/+E8eDDA+PBDYzclTc0iteIp9+IGE+jC+q8l3Nl44Rw4rabuUM5Md6B
         5pJvObkLbtZeJ/kj8cYlCeu4kKX3QLaw+qtSqADeFru99DViTxtp/olV/LJuNrkM0uAT
         LBDGUDZm0p+9pPJWrHuSPrkoxLou1mg+l5AbNGc7Xk/bHHs3d0K+tFqNHsByF5jYbUsj
         nYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984398; x=1780589198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IYmX7v3xAuE6rco3LwL5u5r8CjUiC1V8pXCUJsSp6Y=;
        b=QMMjNtc97WiK+bi62UAC5nNrD/yFkSx6FgmtXF4/pxxu6x2J/4ojBkKvOS5ihjmQso
         05OavHFfUjhoh+oev3BiIhTL6dU/ri3PCIBAja4UQ3p3oArls+2lVwP+3u2ntoNlZ9/u
         DLQEwhUu9YK38ks4dlaoIdOFZIomD3S1m2s+VJ0+tO2+fqjNJRCXwmPA9N5hCqtF+pfU
         2GFLQGkLsZDr7SReVeCnD8CRwyTcrFIus8qnBnUkEaCfC0QiDodKjVNj+w/lGedh9l6m
         7kqh1mNc54xUmppb/5+LLTMI6Az+4y5wTj+OOo1Q/vAvpGLwU+COhOvl/uKW0S+uj1MP
         tpkA==
X-Forwarded-Encrypted: i=1; AFNElJ/M+qazDMOHu89AP+CIyg5cwlUNCtSBVXmgr7pQTOeIUxGdmWl3tgN8XNwwO6pUA2C6iDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOmr0QE0UGflgmz8n4Mc2oZWC+p5K7y44tULQlDb2urly0blf
	BYiy2AqdhA0j8tX6gWrRdrem6TBNAM9qic/dlu0SuKkXgeUI4MB6IjpT/bARomt58lpObtg12c1
	DSmfKRQ==
X-Received: from plcw20.prod.google.com ([2002:a17:903:3114:b0:2bf:1a8c:8a46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e550:b0:2b2:5491:e32f
 with SMTP id d9443c01a7336-2beb0378091mr321997735ad.16.1779984397879; Thu, 28
 May 2026 09:06:37 -0700 (PDT)
Date: Thu, 28 May 2026 09:06:36 -0700
In-Reply-To: <20260528091357.GB343181@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com> <20260527174347.2356165-2-jmattson@google.com>
 <20260528091357.GB343181@noisy.programming.kicks-ass.net>
Message-ID: <ahhoDGUz39KSGZ6o@google.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jim Mattson <jmattson@google.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ctpence@google.com, David.Kaplan@amd.com, binbin.wu@linux.intel.com
Content-Type: multipart/mixed; charset="UTF-8"; boundary="ib8lfqx9reG8y5p3"


--ib8lfqx9reG8y5p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026, Peter Zijlstra wrote:
> On Wed, May 27, 2026 at 10:43:43AM -0700, Jim Mattson wrote:
> 
> > [jim: Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl) so that KVM vendor
> > modules can call kvm_is_cpuid_allowed(). Fix typo in commit message.]
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 1578c0ecbbd1..72bd3cddb026 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -151,6 +151,7 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
> >  #include <asm/kvm-x86-ops.h>
> >  EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
> >  EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
> > +EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
> 
> Are you aware of the distinction between EXPORT_STATIC_CALL_GPL() and
> EXPORT_STATIC_CALL_TRAMP_GPL() ?

No, but it's a moot point at the moment, because EXPORT_STATIC_CALL_TRAMP_GPL()
doesn't actually work?

For CONFIG_HAVE_STATIC_CALL_INLINE=y, __static_call() references the key

	/*
	 * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
	 * the symbol table so that objtool can reference it when it generates the
	 * .static_call_sites section.
	 */
	#define __STATIC_CALL_ADDRESSABLE(name) \
		__ADDRESSABLE(STATIC_CALL_KEY(name))
	
	#define __static_call(name)						\
	({									\
		__STATIC_CALL_ADDRESSABLE(name);				\
		__raw_static_call(name);					\
	})

which leads to

  ERROR: modpost: "__SCK__kvm_x86_cache_reg" [arch/x86/kvm/kvm-intel.ko] undefined!
  ERROR: modpost: "__SCK__kvm_x86_get_cpl" [arch/x86/kvm/kvm-intel.ko] undefined!
  ERROR: modpost: "__SCK__kvm_x86_get_cs_db_l_bits" [arch/x86/kvm/kvm-intel.ko] undefined!
  ERROR: modpost: "__SCK__kvm_x86_cache_reg" [arch/x86/kvm/kvm-amd.ko] undefined!
  ERROR: modpost: "__SCK__kvm_x86_get_cs_db_l_bits" [arch/x86/kvm/kvm-amd.ko] undefined!

Ahh, it requires using static_call_mod.

Argh, and it's actually broken for PPC32, which selects HAVE_STATIC_CALL_INLINE
but doesn't provide ARCH_ADD_TRAMP_KEY.

> Specifically, the former allows modules to do static_call_update(),
> while the latter does not. Whenever possible use the TRAMP thing, this
> allows modules to *call* the static_call, but not to redirect it.

Hmm, should we kill off EXPORT_STATIC_CALL{,_GPL}() entirely and figure out a way
to fold them into EXPORT_TRACEPOINT_SYMBOL{,_GPL}()?  Or create macros that are
quite cleary only for tracepoints.  KVM x86 is the only other user, and all of
KVM's usage is unnecessary, KVM just wants to let vendor modules invoke the call.

  $ git grep EXPORT_STATIC_CALL_GPL
  arch/x86/kvm/pmu.c:EXPORT_STATIC_CALL_GPL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
  arch/x86/kvm/x86.c:EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
  arch/x86/kvm/x86.c:EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
  arch/x86/kvm/x86.c:EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
  include/linux/static_call.h:#define EXPORT_STATIC_CALL_GPL(name)                                        \
  include/linux/static_call.h:#define EXPORT_STATIC_CALL_GPL(name)                                        \
  include/linux/static_call.h:#define EXPORT_STATIC_CALL_GPL(name)        EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
  include/linux/tracepoint.h:     EXPORT_STATIC_CALL_GPL(tp_func_##name)

  $ git grep -w EXPORT_STATIC_CALL
  include/linux/static_call.h: *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
  include/linux/static_call.h: * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
  include/linux/static_call.h:#define EXPORT_STATIC_CALL(name)                                    \
  include/linux/static_call.h:#define EXPORT_STATIC_CALL(name)                                    \
  include/linux/static_call.h:#define EXPORT_STATIC_CALL(name)    EXPORT_SYMBOL(STATIC_CALL_KEY(name))
  include/linux/tracepoint.h:     EXPORT_STATIC_CALL(tp_func_##name)

As for KVM, if we're going to hack on the static call exports, this would be a
good time to add EXPORT_STATIC_CALL_FOR_KVM{,_INTERNAL}.

The attached patches appear to do what I want, and pass my build tests.  If they
seem reasonable (I would say "sane", but none of this is sane :-D), I'll write
changelogs and post them.

--ib8lfqx9reG8y5p3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-static_call-Add-stub-for-ARCH_ADD_TRAMP_KEY-if-not-p.patch"

From 9e96186654e41f957e6499a64c5bfcb145a5f9f0 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 08:09:56 -0700
Subject: [PATCH 1/4] static_call: Add stub for ARCH_ADD_TRAMP_KEY if not
 provided by arch

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/static_call.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..7539c82dd35f 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -210,6 +210,10 @@ extern long __static_call_return0(void);
 
 #define static_call_cond(name)	(void)__static_call(name)
 
+#ifndef ARCH_ADD_TRAMP_KEY
+#define ARCH_ADD_TRAMP_KEY(name)
+#endif
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))

base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.54.0.794.g4f17f83d09-goog


--ib8lfqx9reG8y5p3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-KVM-x86-Don-t-export-static-call-keys-to-vendor-modu.patch"

From a32b2d999e6c441139534b86b2288376c87d2609 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:01:36 -0700
Subject: [PATCH 2/4] KVM: x86: Don't export static call keys to vendor modules

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/pmu.h              | 2 +-
 arch/x86/kvm/x86.c              | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6ae7d539af90..918684f01aba 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2062,7 +2062,7 @@ extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
-#define kvm_x86_call(func) static_call(kvm_x86_##func)
+#define kvm_x86_call(func) static_call_mod(kvm_x86_##func)
 
 #define KVM_X86_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a5821d7c87f9..77cdee3e4aa6 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -54,7 +54,7 @@ struct kvm_pmu_ops {
 	const u32 MSR_STRIDE;
 };
 
-#define kvm_pmu_call(func) static_call(kvm_x86_pmu_##func)
+#define kvm_pmu_call(func) static_call_mod(kvm_x86_pmu_##func)
 
 #define KVM_X86_PMU_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_pmu_##func, *(((struct kvm_pmu_ops *)0)->func));
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6f1dd84f22d..e37937b4af95 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -149,9 +149,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
-- 
2.54.0.794.g4f17f83d09-goog


--ib8lfqx9reG8y5p3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-static_call-Restrict-exporting-of-static-call-key-to.patch"

From 5f45d849f0034bac3d2f30d2ad2d7490e9c7548e Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:03:24 -0700
Subject: [PATCH 3/4] static_call: Restrict exporting of static call *key* to
 tracepoints

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/amd/brs.c      |  2 +-
 arch/x86/kernel/apic/init.c    |  4 +--
 arch/x86/kernel/cpu/mshyperv.c |  2 +-
 arch/x86/kernel/traps.c        |  2 +-
 arch/x86/kvm/x86.c             |  6 ++--
 arch/x86/xen/enlighten.c       |  2 +-
 include/linux/static_call.h    | 59 +++++++++++++---------------------
 include/linux/tracepoint.h     |  4 +--
 kernel/sched/core.c            |  8 ++---
 9 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5..b9a246989bd4 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -424,7 +424,7 @@ void noinstr perf_amd_brs_lopwr_cb(bool lopwr_in)
 }
 
 DEFINE_STATIC_CALL_NULL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
-EXPORT_STATIC_CALL_TRAMP_GPL(perf_lopwr_cb);
+EXPORT_STATIC_CALL_GPL(perf_lopwr_cb);
 
 void __init amd_brs_lopwr_init(void)
 {
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
index 821e2e536f19..933b8d2d3af5 100644
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -30,8 +30,8 @@ DEFINE_APIC_CALL(wakeup_secondary_cpu);
 DEFINE_APIC_CALL(wakeup_secondary_cpu_64);
 DEFINE_APIC_CALL(write);
 
-EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_mask);
-EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_self);
+EXPORT_STATIC_CALL_GPL(apic_call_send_IPI_mask);
+EXPORT_STATIC_CALL_GPL(apic_call_send_IPI_self);
 
 /* The container for function call overrides */
 struct apic_override __x86_apic_override __initdata;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b5b6a58b67b0..9adfc12be1db 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -333,7 +333,7 @@ static void __init x86_setup_ops_for_tsc_pg_clock(void)
 
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
-EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
+EXPORT_STATIC_CALL_GPL(hv_hypercall);
 #define hypercall_update(hc) static_call_update(hv_hypercall, hc)
 #endif
 #endif /* CONFIG_HYPERV */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0ca3912ecb7f..df05ad454414 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -218,7 +218,7 @@ static inline unsigned long pt_regs_val(struct pt_regs *regs, int nr)
 
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 DEFINE_STATIC_CALL(WARN_trap, __WARN_trap);
-EXPORT_STATIC_CALL_TRAMP(WARN_trap);
+EXPORT_STATIC_CALL(WARN_trap);
 
 /*
  * Create a va_list from an exception context.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e37937b4af95..e6f1dd84f22d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -149,9 +149,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 23b91bf9b663..ec14d2017909 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -23,7 +23,7 @@
 #include "xen-ops.h"
 
 DEFINE_STATIC_CALL(xen_hypercall, xen_hypercall_hvm);
-EXPORT_STATIC_CALL_TRAMP(xen_hypercall);
+EXPORT_STATIC_CALL(xen_hypercall);
 
 /*
  * Pointer to the xen_vcpu_info structure or
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 7539c82dd35f..c2c667baf8fe 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -26,7 +26,7 @@
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
- *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *   EXPORT_STATIC_CALL{,_GPL}()
  *
  * Usage example:
  *
@@ -121,14 +121,6 @@
  *   completely eliding any function call overhead.
  *
  *   Notably argument setup is unconditional.
- *
- *
- * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
- *
- *   The difference is that the _TRAMP variant tries to only export the
- *   trampoline with the result that a module can use static_call{,_cond}() but
- *   not static_call_update().
- *
  */
 
 #include <linux/types.h>
@@ -214,19 +206,8 @@ extern long __static_call_return0(void);
 #define ARCH_ADD_TRAMP_KEY(name)
 #endif
 
-#define EXPORT_STATIC_CALL(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
-
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
-	ARCH_ADD_TRAMP_KEY(name)
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
+#define __EXPORT_STATIC_CALL(name, scope)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name));			\
 	ARCH_ADD_TRAMP_KEY(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
@@ -274,18 +255,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
-#define EXPORT_STATIC_CALL(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
-
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define __EXPORT_STATIC_CALL(name, scope)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name))
 
 #else /* Generic implementation */
 
@@ -348,9 +319,25 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
-#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define __EXPORT_STATIC_CALL(name, scope)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#define __EXPORT_TRACEPOINT_STATIC_CALL(name, scope)			\
+	EXPORT_SYMBOL##scope(STATIC_CALL_KEY(name));			\
+	__EXPORT_STATIC_CALL(name, scope)
+#define EXPORT_TRACEPOINT_STATIC_CALL(name)				\
+	__EXPORT_TRACEPOINT_STATIC_CALL(name, )
+#define EXPORT_TRACEPOINT_STATIC_CALL_GPL(name)				\
+	__EXPORT_TRACEPOINT_STATIC_CALL(name, _GPL)
+
+/*
+ * For non-tracepoint usage, leave the key unexported, so modules can't change
+ * static call targets, i.e. can only invoke the static call.
+ */
+#define EXPORT_STATIC_CALL(name)					\
+	__EXPORT_STATIC_CALL(name, )
+#define EXPORT_STATIC_CALL_GPL(name)					\
+	__EXPORT_STATIC_CALL(name, _GPL)
+
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 763eea4d80d8..97f46cbf3c66 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -415,12 +415,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
 	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
-	EXPORT_STATIC_CALL_GPL(tp_func_##name)
+	EXPORT_TRACEPOINT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
 	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
 	EXPORT_SYMBOL(__traceiter_##name);				\
-	EXPORT_STATIC_CALL(tp_func_##name)
+	EXPORT_TRACEPOINT_STATIC_CALL(tp_func_##name)
 
 
 #else /* !TRACEPOINTS_ENABLED */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..c4d0db00d036 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7403,7 +7403,7 @@ EXPORT_SYMBOL(preempt_schedule);
 #   define preempt_schedule_dynamic_disabled	NULL
 #  endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+EXPORT_STATIC_CALL(preempt_schedule);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
 void __sched notrace dynamic_preempt_schedule(void)
@@ -7476,7 +7476,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #   define preempt_schedule_notrace_dynamic_disabled	NULL
 #  endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
 void __sched notrace dynamic_preempt_schedule_notrace(void)
@@ -7723,12 +7723,12 @@ EXPORT_SYMBOL(__cond_resched);
 #  define cond_resched_dynamic_enabled	__cond_resched
 #  define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
 
 #  define might_resched_dynamic_enabled	__cond_resched
 #  define might_resched_dynamic_disabled ((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
+EXPORT_STATIC_CALL(might_resched);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
-- 
2.54.0.794.g4f17f83d09-goog


--ib8lfqx9reG8y5p3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-static_call-Add-FOR_MODULES-static-call-exports-use-.patch"

From f11d22a3d10693796dcf8ae2e2e0cb681a071be6 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:32:41 -0700
Subject: [PATCH 4/4] static_call: Add FOR_MODULES static call exports, use 'em
 in KVM

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c          |  2 +-
 arch/x86/kvm/x86.c          |  6 +++---
 include/linux/kvm_types.h   |  8 ++++++++
 include/linux/static_call.h | 12 +++++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e58335..7e4f6e5ff436 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -100,7 +100,7 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
 #define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
 #define KVM_X86_PMU_OP_OPTIONAL_RET0 KVM_X86_PMU_OP
 #include <asm/kvm-x86-pmu-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6f1dd84f22d..e52eba5fe373 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -149,9 +149,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..3bf9d113b001 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -13,8 +13,14 @@
 	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
 #define EXPORT_SYMBOL_FOR_KVM(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
 #else
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(symbol)
+
 /*
  * Allow architectures to provide a custom EXPORT_SYMBOL_FOR_KVM, but only
  * if there are no submodules, e.g. to allow suppressing exports if KVM=m, but
@@ -23,8 +29,10 @@
 #ifndef EXPORT_SYMBOL_FOR_KVM
 #if IS_MODULE(CONFIG_KVM)
 #define EXPORT_SYMBOL_FOR_KVM(symbol) EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm")
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
 #else
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif /* IS_MODULE(CONFIG_KVM) */
 #endif /* EXPORT_SYMBOL_FOR_KVM */
 #endif
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index c2c667baf8fe..9b38f82b35c4 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -206,8 +206,8 @@ extern long __static_call_return0(void);
 #define ARCH_ADD_TRAMP_KEY(name)
 #endif
 
-#define __EXPORT_STATIC_CALL(name, scope)				\
-	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name));			\
+#define __EXPORT_STATIC_CALL(name, scope, ...)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name), ##__VA_ARGS__);	\
 	ARCH_ADD_TRAMP_KEY(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
@@ -255,8 +255,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
-#define __EXPORT_STATIC_CALL(name, scope)				\
-	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name))
+#define __EXPORT_STATIC_CALL(name, scope, ...)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name), ##__VA_ARGS__)
 
 #else /* Generic implementation */
 
@@ -319,7 +319,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-#define __EXPORT_STATIC_CALL(name, scope)
+#define __EXPORT_STATIC_CALL(name, scope, ...)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
@@ -339,5 +339,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	__EXPORT_STATIC_CALL(name, )
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	__EXPORT_STATIC_CALL(name, _GPL)
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)				\
+	__EXPORT_STATIC_CALL(name, _FOR_MODULES, mods)
 
 #endif /* _LINUX_STATIC_CALL_H */
-- 
2.54.0.794.g4f17f83d09-goog


--ib8lfqx9reG8y5p3--
