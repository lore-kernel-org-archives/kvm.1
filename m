Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D23C457C
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893927; cv=none; b=Qw/PwbCw2sUZ0cblUS8CBTNefDTQE+/b35mTMLWkNmnSxBXlINFImIos9Lx8eA3ITafeXInBj+nowE3BCA3fbU8vxOZSBsOTub5q0ZqQHhDpkyw5gob8YZrCodNFL8wQFN0lu0k44kqzSwfbezlhoAYOQ/BPBDYjxDWcadYUVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893927; c=relaxed/simple;
	bh=POhwBORKps/gzvHlvFKv9CaseaiKv2S+Sn1S4fL/tnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=icoA7tRBAxt7D1fyfLCTDNzCQaRKO/+VozjC6e+UlgTVTf4nfF/XjmUK6E39ugE4TDQMjTR4Y3LIyYLT4zQLhI8P0KQPVysVqMFE7LvN0OgCgEOySjpgS6V+EUjHGkaXobQrOZdtZDZbBYf+Vz5IyJ+8voxv0G8Ie4/LuXop5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jouzj4hW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jouzj4hW"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso17011881b3a.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779893925; x=1780498725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEkKHH9KS+DkrgbPqzp+bIyWqKUJtXuAEmTVrmhxUrs=;
        b=Jouzj4hWLRvdS7oy+VAoMBoYaaYVcdzqo4BrMWDagiOgWsoC1KNiKKJEa725gdgiDV
         4VgrrIeu/FsNXvoLUcNkCW5UQqMLkoWL50JwSPYwlJVY9IahiBCS43cWogiZyY+1r5yb
         ZVrGOD3hK/sRusjvyx4kqbB+9Oj0QCKruHicjhBnJFjOW/gQHsWiDxdX9+cThVeuqL6t
         t2bzAYbwCeBFcPENH9n3gKiHxhAcugwBg3ciOila1f4h71zcr0FyxyAe1IrSzsUZrHe0
         S4fJJK5tmmikPl/RWuqSzoPy3JA/hOa3iZj8NqCvfkCGIQ1VBZ5OJhgAENpMMyD56Zyr
         sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893925; x=1780498725;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xEkKHH9KS+DkrgbPqzp+bIyWqKUJtXuAEmTVrmhxUrs=;
        b=Xv0UfqrMDDNEhiLnnGX+jg8DXaIoaTzItIfXYSJ2l5juUxbhIfb7lNxBLvo+GbsIyP
         VWR1oWnb+4tbAZcKzAuTCKfk+YzD5vyU3gxPA7KJmw5Q8BIXJ686IcKhqAel40Jdc7EK
         uOoaY1Oz4uCyTfdzZBZ0s4Jf6q1lZNo9wnbi0H3RJemDuqNihB2g/WKg5sBzaqgOlCAo
         foEz6WID26TFl3Vph++YHgNVGWfDhoy61VfafzHl+4/YM3Pv1HS1zyGI8NqCUk9KV/vu
         +16kTNEoVYf82DvqSex1unQ3/vbc4Ga7tiyoXtTW3L8M56ap9aAcm1ETtpE3Q2P0vnzP
         +p5g==
X-Forwarded-Encrypted: i=1; AFNElJ+7zlRDvb6NL39uEHkVRsTZBrRxV7732VGzyjzL53/5PIMrTOozrVeuds/dFLj9NO5/NsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcDF31/1LATIEmwHLcx6MQnKwwpVCZkeBOEsgi1RmCXJH9lWo
	VJUc4GX8unQc9qgWEIbUa6pgtJBz1Zuz4jJAt6RwC7prw8vMz1VDXUzqozbjSuMAGui5DqSHibr
	1D7LtgA==
X-Received: from pfld16.prod.google.com ([2002:a05:6a00:1990:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d11:b0:839:dd77:3501
 with SMTP id d2e1a72fcca58-8415f11f2d9mr23039903b3a.1.1779893924936; Wed, 27
 May 2026 07:58:44 -0700 (PDT)
Date: Wed, 27 May 2026 07:58:44 -0700
In-Reply-To: <d08b2f6f-b2f1-4cd3-a1fe-588261e3ee10@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-3-chenyi.qiang@intel.com> <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
 <d08b2f6f-b2f1-4cd3-a1fe-588261e3ee10@intel.com>
Message-ID: <ahcGpKXNHOxMKNTo@google.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate DEBUGCTLMSR_BUS_LOCK_DETECT
 states during VMX transitions
From: Sean Christopherson <seanjc@google.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026, Chenyi Qiang wrote:
> On 5/26/2026 8:32 PM, Xiaoyao Li wrote:
> > On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> >> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> >> index 48835eba..c8426770 100644
> >> --- a/x86/unittests.cfg
> >> +++ b/x86/unittests.cfg
> >> @@ -471,6 +471,14 @@ arch =3D x86_64
> >> =C2=A0 groups =3D vmx
> >> =C2=A0 timeout =3D 240
> >> =C2=A0 +[vmx_bus_lock_detect_test]
> >> +file =3D vmx.flat
> >> +test_args =3D "vmx_bus_lock_detect_test"
> >> +qemu_params =3D -cpu max,+vmx
> >> +arch =3D x86_64
> >> +groups =3D vmx
> >> +timeout =3D 240

Why does this need a separate config, and with a massive timeout?  This sho=
uld
be nearly instantaneous, no?

Ugh, because you copy+pasted vmx_cet.  That thing doesn't need to exist, th=
e
testcase is run by the common "vmx" entry.  I'll send a patch to drop vmx_c=
et.

> >> +
> >> =C2=A0 [debug]
> >> =C2=A0 file =3D debug.flat
> >> =C2=A0 arch =3D x86_64
> >> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> >> index 91f417c6..a3e52d3b 100644
> >> --- a/x86/vmx_tests.c
> >> +++ b/x86/vmx_tests.c
> >> @@ -11737,6 +11737,100 @@ static void vmx_cet_test(void)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_set_guest_finished();
> >> =C2=A0 }
> >> =C2=A0 +static struct vmx_debugctl_test_data {
> >> +=C2=A0=C2=A0=C2=A0 u64 mask;

It's not a mask, it's an explicit value.

> >> +=C2=A0=C2=A0=C2=A0 u64 guest_debugctl;
> >> +} vmx_debugctl_test_data;

There's no need for a struct, only a single u64 is needed to pass informati=
on
back and forth since there's a VMCALL after every step.

> >> +static void vmx_debugctl_test_guest(void)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 vmx_debugctl_test_data.guest_debugctl =3D rdmsr(MS=
R_IA32_DEBUGCTLMSR);
> >> +=C2=A0=C2=A0=C2=A0 vmcall();
> >> +
> >> +=C2=A0=C2=A0=C2=A0 wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data=
.mask);
> >> +=C2=A0=C2=A0=C2=A0 vmcall();
> >> +
> >> +=C2=A0=C2=A0=C2=A0 vmx_debugctl_test_data.guest_debugctl =3D rdmsr(MS=
R_IA32_DEBUGCTLMSR);
> >> +=C2=A0=C2=A0=C2=A0 vmcall();
> >> +
> >> +=C2=A0=C2=A0=C2=A0 wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data=
.mask);
> >> +=C2=A0=C2=A0=C2=A0 vmcall();
> >> +}
> >> +
> >> +static void vmx_debugctl_transition_test(const char *label, u64 mask)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 u64 debugctl;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 vmx_debugctl_test_data.mask =3D mask;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 msr_bmp_init();
> >> +=C2=A0=C2=A0=C2=A0 wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
> >> +=C2=A0=C2=A0=C2=A0 vmcs_write(GUEST_DEBUGCTL, 0x0);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 /* Validate when save/load debug controls are set =
*/
> >> +=C2=A0=C2=A0=C2=A0 vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> >> +=C2=A0=C2=A0=C2=A0 vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 test_set_guest(vmx_debugctl_test_guest);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 enter_guest();
> >> +=C2=A0=C2=A0=C2=A0 skip_exit_vmcall();
> >> +=C2=A0=C2=A0=C2=A0 /* Validate VM-entry loads the guest DEBUGCTL valu=
e from GUEST_DEBUGCTL. */
> >> +=C2=A0=C2=A0=C2=A0 report(vmx_debugctl_test_data.guest_debugctl =3D=
=3D 0x0,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Loa=
d debug controls", label);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 enter_guest();
> >> +=C2=A0=C2=A0=C2=A0 skip_exit_vmcall();
> >> +=C2=A0=C2=A0=C2=A0 debugctl =3D rdmsr(MSR_IA32_DEBUGCTLMSR);
> >> +=C2=A0=C2=A0=C2=A0 /* Validate VM-exit clears host DEBUGCTL and saves=
 guest DEBUGCTL into the VMCS. */
> >> +=C2=A0=C2=A0=C2=A0 report(debugctl =3D=3D 0x0 && vmcs_read(GUEST_DEBU=
GCTL) =3D=3D mask,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Sav=
e debug controls", label);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl_exit_rev.set & EXI_SA=
VE_DBGCTLS) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\tDebug controls a=
re always loaded/saved\n");
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_set_guest_finished();
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
> >> +=C2=A0=C2=A0=C2=A0 vmcs_write(GUEST_DEBUGCTL, 0x0);
> >> +=C2=A0=C2=A0=C2=A0 /* Validate when save/load debug controls are clea=
r */

We should also test with only of the controls set.

> >> +=C2=A0=C2=A0=C2=A0 vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> >> +=C2=A0=C2=A0=C2=A0 vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 enter_guest();
> >> +=C2=A0=C2=A0=C2=A0 skip_exit_vmcall();
> >> +=C2=A0=C2=A0=C2=A0 /* Validate guest observes the host's DEBUGCTL val=
ue. */
> >> +=C2=A0=C2=A0=C2=A0 report(vmx_debugctl_test_data.guest_debugctl =3D=
=3D mask,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Gue=
st=3Dhost debug controls", label);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 wrmsr(MSR_IA32_DEBUGCTLMSR, 0x0);
> >> +=C2=A0=C2=A0=C2=A0 vmcs_write(GUEST_DEBUGCTL, 0x0);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 enter_guest();
> >> +=C2=A0=C2=A0=C2=A0 skip_exit_vmcall();
> >> +=C2=A0=C2=A0=C2=A0 debugctl =3D rdmsr(MSR_IA32_DEBUGCTLMSR);
> >> +=C2=A0=C2=A0=C2=A0 /* Validate VM-exit clears host DEBUGCTL and does =
not save guest DEBUGCTL into the VMCS. */

This can/should be done on *every* VM-Exit, using report_fail() to avoid po=
lluting
the PASS results with a relatively uninteresting testcase.

> >> +=C2=A0=C2=A0=C2=A0 report(debugctl =3D=3D 0x0 && vmcs_read(GUEST_DEBU=
GCTL) =3D=3D 0x0,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Don=
't save debug controls", label);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 enter_guest();
> >> +}
> >> +
> >> +static void vmx_bus_lock_detect_test(void)
> >=20
> > the name reads ambiguous to me.

The name would be great, _if_ the test were actually testing BUS_LOCK_DETEC=
T,
i.e. needs to actually generate a bus lock in L2 and verify L1 gets the VM-=
Exit.
That's what I was suggesting in my earlier feedback: actually test BUS_LOCK=
_DETECT,
and verify vmcs.GUEST_DEBUGCTL handling as a side effect.

But since you've already gone thorugh most of the effort... :-)

Rather than split this into three tests, bundle it all into one test.  Spli=
tting
makes sense _if_ the guest is actually validating functionality, but if the=
 goal
is purely to validate the values and not the semantics, then bundling is mu=
ch
more interesting as it allows testing combinations.

And since only three bits are set, just validate all combinations, for both=
 the
host and the guest.  It's a total of 8 values, so at most 64 total testcase=
s to
cover both host and guest.

This works for me, I'll post a v3.

---
 lib/x86/msr.h   |   2 +
 x86/vmx_tests.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 7397809c..8b019f7e 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -103,12 +103,14 @@
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
 #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
 #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
 #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
+#define DEBUGCTLMSR_RTM_DEBUG		(1UL << 15)
=20
 #define MSR_LBR_NHM_FROM	0x00000680
 #define MSR_LBR_NHM_TO		0x000006c0
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index aca93af9..2d6eb451 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11774,6 +11774,155 @@ static void vmx_cet_test(void)
 	test_set_guest_finished();
 }
=20
+static u64 vmx_debugctl_test_val;
+
+static void vmx_debugctl_test_guest(void)
+{
+	for (;;) {
+		vmx_debugctl_test_val =3D rdmsr(MSR_IA32_DEBUGCTLMSR);
+		vmcall();
+
+		wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_val);
+		vmcall();
+	}
+}
+
+static void __run_vmx_debugctl_guest(void)
+{
+	u64 val;
+
+	enter_guest();
+	skip_exit_vmcall();
+
+	/* Verify DEBUGCTL is unconditionally zeroed on VM-Exit. */
+	val =3D rdmsr(MSR_IA32_DEBUGCTLMSR);
+	if (val)
+		report_fail("DEBUGCTL =3D 0x%lx (not zeroed on VM-Exit)", val);
+}
+
+static u64 run_vmx_debugctl_guest(u64 msr_val, u64 vmcs_val, u64 write_val=
)
+{
+	u64 read_val;
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, msr_val);
+	vmcs_write(GUEST_DEBUGCTL, vmcs_val);
+
+	__run_vmx_debugctl_guest();
+	read_val =3D vmx_debugctl_test_val;
+
+	vmx_debugctl_test_val =3D write_val;
+	__run_vmx_debugctl_guest();
+
+	return read_val;
+}
+
+static void __vmx_debugctl_test(u64 host_val, u64 guest_val)
+{
+	u64 val, rand;
+
+	/* Validate VM-Entrywhen save/load debug controls are set */
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	/* Verify guest DEBUGCTL is loaded/saved when the controls are set. */
+	val =3D run_vmx_debugctl_guest(host_val, guest_val, 0);
+	report(val =3D=3D guest_val, "Load DEBUGCTL =3D 0x%lx, guest RDMSR =3D 0x=
%lx", guest_val, val);
+	val =3D vmcs_read(GUEST_DEBUGCTL);
+	report(!val, "Save DEBUGCTL =3D 0x0, guest WRMSR =3D 0x%lx", val);
+
+	/* Rerun the test with the guest values flipped. */
+	val =3D run_vmx_debugctl_guest(host_val, 0, guest_val);
+	report(!val, "Load DEBUGCTL =3D 0x0, guest RDMSR =3D 0x%lx", val);
+	val =3D vmcs_read(GUEST_DEBUGCTL);
+	report(val =3D=3D guest_val, "Save DEBUGCTL =3D 0x0%lx, guest WRMSR =3D 0=
x%lx", val, guest_val);
+
+	/*
+	 * If running without the LOAD control set is supported, validate that
+	 * the guest sees the host's value.  Scribble vmcs.GUEST_DEBUGCTL with
+	 * a random value to verify it's ignored.
+	 */
+	if (!(ctrl_enter_rev.set & ENT_LOAD_DBGCTLS)) {
+		vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+
+		val =3D run_vmx_debugctl_guest(host_val, rdtsc(), guest_val);
+		report(val =3D=3D host_val, "Host DEBUGCTL =3D 0x%lx, guest RDMSR =3D 0x=
%lx", host_val, val);
+
+		/* The guest value should still be saved on exit! */
+		val =3D vmcs_read(GUEST_DEBUGCTL);
+		report(val =3D=3D guest_val, "Save DEBUGCTL =3D 0x%lx, guest WRMSR =3D 0=
x%lx", val, guest_val);
+
+		vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	}
+
+	if (!(ctrl_exit_rev.set & EXI_SAVE_DBGCTLS)) {
+		vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+		/* Verify the guest's value is NOT saved on exit.*/
+		val =3D run_vmx_debugctl_guest(host_val, guest_val, 0);
+		report(val =3D=3D guest_val, "Load DEBUGCTL =3D 0x%lx, guest RDMSR =3D 0=
x%lx", guest_val, val);
+		val =3D vmcs_read(GUEST_DEBUGCTL);
+		report(val =3D=3D guest_val, "VMREAD DEBUGCTL =3D 0x%lx, VMWRITE =3D 0x%=
lx", val, guest_val);
+
+		/* And again with the values flipped. */
+		val =3D run_vmx_debugctl_guest(host_val, 0, guest_val);
+		report(!val, "Load DEBUGCTL =3D 0x0, guest RDMSR =3D 0x%lx", val);
+		val =3D vmcs_read(GUEST_DEBUGCTL);
+		report(!val, "VMREAD DEBUGCTL =3D 0x%lx, VMWRITE =3D 0x0", val);
+
+		vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+	}
+
+	if ((ctrl_enter_rev.set & ENT_LOAD_DBGCTLS) ||
+	    (ctrl_exit_rev.set & EXI_SAVE_DBGCTLS))
+		return;
+
+	vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	rand =3D rdtsc();
+	val =3D run_vmx_debugctl_guest(host_val, rand, guest_val);
+	report(val =3D=3D host_val, "Host DEBUGCTL =3D 0x%lx, guest RDMSR =3D 0x%=
lx", host_val, val);
+
+	val =3D vmcs_read(GUEST_DEBUGCTL);
+	report(val =3D=3D rand, "VMWRITE DEBUGCTL =3D 0x%lx, VMREAD =3D 0x%lx", r=
and, val);
+}
+
+static void vmx_debugctl_test(void)
+{
+	u64 supported_bits =3D 0;
+	u64 i, j;
+
+	if (this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		supported_bits |=3D DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	if (this_cpu_has(X86_FEATURE_RTM))
+		supported_bits |=3D DEBUGCTLMSR_RTM_DEBUG;
+
+	if (this_cpu_has(X86_FEATURE_PDCM) && pmu_lbr_version())
+		supported_bits |=3D DEBUGCTLMSR_LBR;
+
+	if (!supported_bits) {
+		report_skip("%s : No DEBUGCTL features supported", __func__);
+		return;
+	}
+
+	test_set_guest(vmx_debugctl_test_guest);
+	msr_bmp_init();
+
+	for (i =3D 1; i <=3D supported_bits; i++) {
+		if ((i & supported_bits) !=3D i)
+			continue;
+
+		for (j =3D 1; j <=3D supported_bits; j++) {
+			if ((j & supported_bits) !=3D j)
+				continue;
+
+			__vmx_debugctl_test(i, j);
+		}
+	}
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 =3D name }
=20
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -11890,5 +12039,6 @@ struct vmx_test vmx_tests[] =3D {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
+	TEST(vmx_debugctl_test),
 	{ NULL, NULL, NULL, NULL },
 };

base-commit: da6e732372e64a31010b0c8cbfc550a9d83195ba
--=20
