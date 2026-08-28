Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D73290B9
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926733; cv=none; b=OgiZi4YICeaxehj6qR/CnOov1aIPpjIeONIWWBCCxV0BWMv1tO1d6dc5W0WdhbrB9JbOW11QvDPgjoU1h8IwHcvxUGNtFc95ehwD3GWgH0AbhYYViG3crDXKh211sMD9W6Ck5+5Eoa/yZfBjxdygOaTKQuVi6uUGlwCuCiEaMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926733; c=relaxed/simple;
	bh=tOIayJ92xrw6pvO0WbOfaDSneoKGHjWYUfTGAkwGxd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pWIFaqKLf9Du2A9mx1b3nONOIz/IfMP41qK6qoVVfvaqvPbrPILlljAAkr6hUCDjlwUkI5ZwILfOec85wpKGXt+ctZVmt9dqBoD9cYwQhLHLonboDDwDK5W36ipDkRO/2Q0UWQ4rlUD5KfQqXOB3Fa4uBxnKFuHAD6RbtL1R5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhjLpdP8; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhjLpdP8"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f75c1219so20091825ad.3
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787926729; x=1788531529; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lk1PtauESgfcOmIWGAdMCfx87NYe0QEmwPgHNpnVCRk=;
        b=vhjLpdP8DQlQy/sH4sHNDuCNj5M06VQvRF6J2Ee3he8ZbdPsda9fUpgkxT+XyQYnzi
         5FBWNvs3Sf+17NsdEGAT2LVHVg/zBo95fliWhNMjxrLjzrUO1ovK0lMkSucZcLtMHPr3
         N1RnEaxMbKmRtdroMSZgmJOWoSCej0Shtm5v86qeLzPliPxePQcgQ39PDjc1FGsa4bLJ
         pr/GFy909Y5DathoVdvQaxht0iBHjepPUwfxRStyZFP773OhPx/zUQBHyWx64HdPdgeZ
         lqS0mL0PO/KMhiJvAH5CXqf67t0VVwTNUgpm+NBUzmBgIOkHVqnrl8HEsGRLQazV0mQj
         9gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926729; x=1788531529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk1PtauESgfcOmIWGAdMCfx87NYe0QEmwPgHNpnVCRk=;
        b=DyENtFa/LvPUP4pOM1BRqgLtcnKlhdJyri9x0XLVym0qFJ42K1Z/A2ABhbyVEGz5eG
         rRQ0o5btlpC+bbw9rfPBv3VEhdtXn746+2twZfkvB9nY0xOeGXzhLczZmoDZnB/oUr+d
         N8/3nkURNiInBC8kSgOm1MmRM6bLnhpgmG4U3rC5iMbw7YfZ/wX+/99aQxVyYP2rwPuO
         O6Rag0gcmY318i//Rw9UQ0lU7R/HoFxzr07Hb3wRS4/ukdGzlzE72iKnf12hIpk0fMx9
         A9x/GL4ya96NRSRb0gW+gtZdeXcQAMS/lCaimRf6obhNvZQXsapms8JbxF6QJFwTm94W
         hwjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYGZLPHi6Fa19K+KLXL7q0gnlXQAnCicMI0qkA1DSTWKJ4nW1DYk6OIszTw5Y2jKb0Dcc=@vger.kernel.org
X-Gm-Message-State: AFuF++k3udqLfEjIajj2f3C+vCX2oubqsPThbSyUCWgk5PHFsi/jj9Sw
	599B/avw9MCg+iHJMv4ApIQEohI0RjxqcbKgF4JQRWyGgQAx72dcDNgLeem44CbPG7RkTNOWDwr
	SlNEIYg==
X-Received: from plbmq14.prod.google.com ([2002:a17:902:fd4e:b0:2d7:3fb9:fada])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec91:b0:2d7:4f55:f40c
 with SMTP id d9443c01a7336-2d74f55f6edmr103578625ad.6.1787926728323; Fri, 28
 Aug 2026 07:18:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:18:47 -0700
In-Reply-To: <20260828042044.GG33657@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com> <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
 <20260828020612.GF33657@pedri> <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
 <20260828042044.GG33657@pedri>
Message-ID: <apGYxwdCSuC-X732@google.com>
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: multipart/mixed; charset="UTF-8"; boundary="D8ScZ73OZF7fi6Cd"


--D8ScZ73OZF7fi6Cd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2026, Peter Fang wrote:
> On Fri, Aug 28, 2026 at 10:31:14AM +0800, Xiaoyao Li wrote:
> > > 
> > > Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
> > > with the same architectural approach. GPAW is available through
> > > TDG.VP.INFO or the initial RBX value. This does require a bit more
> > > plumbing though.
> > 
> > I'm afraid not. Because below is host code, and vm->arch.s_bit is not used
> > in guest code.
> > 
> > Or are suggesting something like dropping the
> > 
> > 	if (is_tdx_vm(vm)) {
> > 		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
> > 		sync_global_to_guest(vm, ucall_mmio_gpa);
> > 	}
> > 
> > entirely and use below hardcoded value instead in guest code?
> > 
> > 	UCALL_MMIO_GPA | 1 << (GPAW - 1)
> 
> Yeah this is what I meant. Just drop sync_global_to_guest() entirely and
> do things like a normal TDX guest would.

Blech.  Every time I come back to this series we're still discussing ucall crud,
and "doing thing like a normal TDX guest".  Selftests aren't normal guests.

I know I suggested using the HPET base, but I only did so very begrudgingly as I
couldn't come up with a better alternative to emulated MMIO, and the end result
is quite gross.  Not only does the code ignore @mmio_gpa but still obviously use
emulated MMIO, it requires synchronizing data to the guest because KVM disallows
"private" MMIO.

  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
  {
         vm_type = vm->type;
         sync_global_to_guest(vm, vm_type);

         if (is_tdx_vm(vm)) {
                 ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
                 sync_global_to_guest(vm, ucall_mmio_gpa);
         }
   }

Retrieving GPA via TDG.VP.INFO isn't any better, it's still an absurd amount of
"work" for something that should be trivial.

Can't we just abuse TDVMCALL_REPORT_FATAL_ERROR?  AFAICT, there's no restriction
on the data payload, and there's enough space to all but guarantee we'll never get
a false positive.

Pulling in Xiaoyao's idea about using CPUID...

> > +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> > +{
> > +     vm_type = vm->type;
> > +     sync_global_to_guest(vm, vm_type);
>
> It works and it looks simple. But we have the architectural approach to
> test if a guest is TD guest, by checking the CPUID 0x21.
>
> Since checking CPUID 0x21 is not complex, and as a bonus it can help
> test if TDX module behaves correctly for CPUID leaf 0x21, I think we
> should switch to use CPUID 0x21 to check if it is TDX VM in guest code?

Absolutely not.  It will require at least one an extra VM-Exit for TDX and non-TDX
guests alike, and thanks to Intel's wonderful CPUID behavior of having unsupported
leaves return the last supported leaf, the guest would have to check CPUID.0x0 and
then CPUID.0x21 on modern hardware, i.e. would incur two extra VM-Exits.  I don't
care about the performance, but from a debug perspective that's going to be awful,
as what should be a super simple operation will be polluted with unwanted data.

Stop trying to reinvent the wheel and just use a virtual function table.

I've verified the attached patches don't break non-TDX selftests, someone just
needs to test the TDX changes.

--D8ScZ73OZF7fi6Cd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-KVM-selftests-Add-support-for-per-VM-ucall-ops-on-x8.patch

From 659487e0a9862900b052836229e3ac366c602f59 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 28 Aug 2026 06:46:51 -0700
Subject: [PATCH 1/3] KVM: selftests: Add support for per-VM ucall ops on x86

Add a layer of indirection to x86's ucall infrastructure to allow wiring up
a different set of {do,get}_ucall() operations for TDX VMs.  TDX can't use
port I/O (at least, not robustly), as the TDX ABI doesn't allow the guest
to share arbitrary register state with the host on a PIO exit, and the PIO
data payload is limited to 4 bytes, i.e. would potentially truncate the
address of the per-ucall structure.

No functional change intended, as the ops are still hardwirte to the common
x86 ucall functions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86/ucall.h |  6 +----
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 27 +++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index 0e4950041e3e..3639f03a4da9 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -2,12 +2,8 @@
 #ifndef SELFTEST_KVM_UCALL_H
 #define SELFTEST_KVM_UCALL_H
 
-#include "kvm_util.h"
+#include "linux/kvm.h"
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
-{
-}
-
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index e7dd5791959b..444d0f0ba138 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -8,7 +8,7 @@
 
 #define UCALL_PIO_PORT ((u16)0x1000)
 
-void ucall_arch_do_ucall(gva_t uc)
+static void ucall_x86_do_ucall(gva_t uc)
 {
 	/*
 	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
@@ -42,7 +42,7 @@ void ucall_arch_do_ucall(gva_t uc)
 		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
 }
 
-void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+static void *ucall_x86_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
@@ -54,3 +54,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	}
 	return NULL;
 }
+
+static struct {
+	void (*do_ucall)(gva_t uc);
+	void *(*get_ucall)(struct kvm_vcpu *vcpu);
+} ucall_x86_ops = {
+	.do_ucall = ucall_x86_do_ucall,
+	.get_ucall = ucall_x86_get_ucall,
+};
+
+void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+	sync_global_to_guest(vm, ucall_x86_ops);
+}
+
+void ucall_arch_do_ucall(gva_t uc)
+{
+	return ucall_x86_ops.do_ucall(uc);
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	return ucall_x86_ops.get_ucall(vcpu);
+}

base-commit: 8ab7454faa8be2d6c1fc29c857b9f9611ddb174b
-- 
2.55.0.897.gb25b4bd76c-goog


--D8ScZ73OZF7fi6Cd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-KVM-selftests-Add-support-for-TDX-ucalls-via-TDVMCAL.patch

From 60f3e988c65048c63217ec157e9ec228a4c484b7 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 28 Aug 2026 06:52:56 -0700
Subject: [PATCH 2/3] KVM: selftests: Add support for TDX ucalls, via
 TDVMCALL_REPORT_FATAL_ERROR

Add support for doing ucalls on TDX by abusing TDVMCALL_REPORT_FATAL_ERROR
to pass the address of the payload to the host.  The "fatal error" TDVMCALL
is perfectly suited for passing information to host userspace, is both the
TDX Module and KVM allow the guest to pass (almost) all registers to the
host, i.e. provide enough of a data payload to make a collision with a real
fatal error practically impossible.

TDX can't use port I/O, as the TDX ABI doesn't allow the guest to share
arbitrary register state with the host on a port I/O exit, and the port I/O
data payload is limited to 4 bytes, i.e. would potentially truncate the
ucall address.

Alternatively, TDX could use MMIO, but using a magic emulated MMIO address
is fragile (see the TODO in __vm_create()), especially for TDX since TDX
doesn't support read-only memslots, i.e. doesn't have line of sight towards
addressing the TODO.  E.g. TDX could hardcode the address to something that
is all but guaranteed to be unused on x86, e.g. the I/O APIC base address
or the HPET address, but that doesn't truly address the fragility concerns,
and it's ugly because ucall_arch_init() would completely ignore the passed
in @mmio_gpa despite obviously utilizing emulated MMIO.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  7 +++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 27 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 6355a30bb47f..6582e6c99697 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -4,6 +4,13 @@
 
 #include <linux/types.h>
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_GET_TD_VM_CALL_INFO		0x10000
+#define TDVMCALL_MAP_GPA			0x10001
+#define TDVMCALL_GET_QUOTE			0x10002
+#define TDVMCALL_REPORT_FATAL_ERROR		0x10003
+#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT	0x10004
+
 #define TDG_VP_VMCALL_VE_REQUEST_MMIO    48
 #define TDVMCALL_MMIO_WRITE		  1
 
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 444d0f0ba138..93686e1dd3f3 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,8 +5,28 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
-#define UCALL_PIO_PORT ((u16)0x1000)
+#define UCALL_PIO_PORT		((u16)0x1000)
+#define UCALL_TDX_MAGIC		0xabacadabaULL
+
+static void ucall_tdx_do_ucall(gva_t uc)
+{
+	__tdcall(TDVMCALL_REPORT_FATAL_ERROR, UCALL_TDX_MAGIC, uc, 0, 0);
+}
+
+static void *ucall_tdx_get_ucall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	if (run->exit_reason == KVM_EXIT_SYSTEM_EVENT &&
+	    run->system_event.type == KVM_SYSTEM_EVENT_TDX_FATAL &&
+	    run->system_event.data[12] == UCALL_TDX_MAGIC)
+		return (void *)(run->system_event.data[13]);
+
+	return NULL;
+}
 
 static void ucall_x86_do_ucall(gva_t uc)
 {
@@ -65,6 +85,11 @@ static struct {
 
 void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
+	if (is_tdx_vm(vm)) {
+		ucall_x86_ops.do_ucall = ucall_tdx_do_ucall;
+		ucall_x86_ops.get_ucall = ucall_tdx_get_ucall;
+	}
+
 	sync_global_to_guest(vm, ucall_x86_ops);
 }
 
-- 
2.55.0.897.gb25b4bd76c-goog


--D8ScZ73OZF7fi6Cd--
