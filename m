Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096092EB10
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680557; cv=none; b=G0fNwBh3CSyNg2SBOsDFBD5qj0dG1pNXN0VgP9aeCPl1Tzo9EbugcpFdnJGfGwVkUWX66+1G2TSFKOF8m0R2pv4iXRQOU/WgODNyekXyjZYbH3IcdAKBv88amRRU5qCLJ9/qI7GUaU3jjGTVWPZKwi3fS+QAwa1IL0Jml7QUCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680557; c=relaxed/simple;
	bh=81p1ApmLrZ9gdWnCr6w3Ee2F2PvIhG8I+hlvjaq3OLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l4JwC47af+R+aG6u83Y5UTGMLDc7kihSx9VjT//uSNWKpSsJEaeGUI0TQQPhGUvZ8oOW0CYi7OD+MOnlyzivtojAMcB7QlQtdyUQN9ibgNQaRlyvrwJHwcgbvdjYOg9c2M3xZEdJagPuS1FiZbvPQRi4k+Nmy40Z/153WWvPvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUHq8aYi; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUHq8aYi"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so8415048a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784680555; x=1785285355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrY9AOEbOfmgmQ5rjf4ZQZ93aTqP2R+p2EVwQaDUIoI=;
        b=RUHq8aYi6zQ8lKjc3kwIYso0SFUCtziIxt+9Uj9pIrvXwVjy434QoCnF0wN1cIOmc1
         AOM3A9yssNzbRbEwubGnmQCk/2IDZnUuB9SwI01ct+IwAWBJnfEotlQ0lhtwunRgh0hj
         2F0Rz0gQFm/eYbBVV/9X+uYbPhKQx1p1+TYVhq0/QpiP5CeTVw2J6vq/m87KcVkScPqZ
         8RRVs4dl/a4oIs0BVo2P9VOM6zIlWktoBALafMnFAatvIh+wD1tK2uBhoFicrn/Cowna
         nQbe1dudDXJVnnlVJFr+UiK5g3wiX4kpMVonlqymZUN4quTx8JvGywbjXYHwW5IGhCzh
         stoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680555; x=1785285355;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrY9AOEbOfmgmQ5rjf4ZQZ93aTqP2R+p2EVwQaDUIoI=;
        b=EcJeQDW0n4PRDv+2yo1eBioeDBDoOE4uqav7bBkHo6nTY1vpyYoO8ZyyjhNoG0bO/3
         cOt6T1cfTk3opiJpt4Z4C3Sjdd/sW6K/gncW0uAbdQthxYtcmOCOVIScM+p/jjB/HwiR
         QRmuXcuc8AkCcZO1J1R1B4Ni5CUodtds9R2A7jxZhqrDlTATozHBnQzI/Ozdq8kGtwKK
         yeMC9z4dZL+s3QTTQFKwcx4tEch/xS3lm/QR6P89hd0+A0yCBCMF1ZhZm5I3Q1lMXuwQ
         pfymf35mqpCSVNLEJOEuKuXOTWUIfZEKGgt7U/9Ap+J/ht+J5vIbQjFGX81OwrPAyq0p
         qkuA==
X-Forwarded-Encrypted: i=1; AHgh+RqjyEnVYWQY2zIdRteHXeAYOB5cDB5rA0bWImqr/OW4aQeQpJbVnl4iVBKLQp/Y2OqESPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyauol7KuT1F/2JRiD96vlPQ4B3sumCFAuRhSpFwJ6YEp8iEMu
	YT/LOsn8HifPIcFnfeYZNa9vkTnDblaqQvZ2UaMLAU6680VFsCSdCuerx6RytZPvn9hoowbW4mq
	l5XpNsQ==
X-Received: from pgjs23.prod.google.com ([2002:a63:f057:0:b0:c92:460e:4f73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8213:b0:3c3:a804:8eed
 with SMTP id adf61e73a8af0-3c3ad9e5886mr20144900637.56.1784680555061; Tue, 21
 Jul 2026 17:35:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 17:35:54 -0700
In-Reply-To: <CALMp9eQN_UDhd7RVP8v4wBTaEbq0GXmbAiay+uXgzSEV7T1uQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720231639.1592848-1-jmattson@google.com> <al9cWDWvIK6RCrnN@intel.com>
 <CALMp9eQN_UDhd7RVP8v4wBTaEbq0GXmbAiay+uXgzSEV7T1uQw@mail.gmail.com>
Message-ID: <amAQamArzJOaZwEL@google.com>
Subject: Re: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around
 Intel errata
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026, Jim Mattson wrote:
> On Tue, Jul 21, 2026 at 4:47=E2=80=AFAM Chao Gao <chao.gao@intel.com> wro=
te:
> Do we want to keep the hv_timer 64-bit only?

Hmm, yes.  I don't want to open up a can of worms either.

> AFAICT, this was only done out of convenience.
> See https://lore.kernel.org/kvm/1465000951-13343-3-git-send-email-yunhong=
.jiang@linux.intel.com/.
>=20
> I think something like this should work for 32- and 64- bit kernels (unte=
sted):
>=20
>  /* (a << shift) / divisor, return 1 if overflow otherwise 0 */
>  static inline int u64_shl_div_u64(u64 a, unsigned int shift,
>                                   u64 divisor, u64 *result)
>  {
> -       u64 low =3D a << shift, high =3D a >> (64 - shift);
> +       u64 high =3D shift ? (a >> (64 - shift)) : 0;
>=20
> -       /* To avoid the overflow on divq */
> -       if (high >=3D divisor)
> +       if (high >=3D divisor || !divisor)
>                 return 1;
>=20
> -       /* Low hold the result, high hold rem which is discarded */
> -       asm("divq %2\n\t" : "=3Da" (low), "=3Dd" (high) :
> -           "rm" (divisor), "0" (low), "1" (high));
> -       *result =3D low;
> -
> +       *result =3D mul_u64_u64_div_u64(a, 1ULL << shift, divisor);
>         return 0;
>  }
>=20
> But I don't want to open up a can of worms.
>=20
> Sean? Thoughts?

I vote to go in the opposite direction, and double down on the code being 6=
4-bit
only.  If we do that, then the annoying 32-bit issues Sashiko keeps pointin=
g out
should naturally go away.

Compile-tested only...

---
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 22 Jul 2026 00:30:46 +0000
Subject: [PATCH] KVM: VMX: Bury all of the VMX preemption timer code under
 CONFIG_X86_64=3Dy

Double down on using the VMX preemption timer only for 64-bit kernels, and
bury the setup and runtime adjustment code, and all global variables, under
CONFIG_X86_64=3Dy.  This will allow addressing various Intel erratum withou=
t
running afoul of unused-but-set-variable and __udivdi3() warnings/errors on
32-bit kernels.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 122 +++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..a07faa066ef0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -150,10 +150,12 @@ module_param(dump_invalid_vmcs, bool, 0644);
 #define KVM_VMX_TSC_MULTIPLIER_MAX     0xffffffffffffffffULL
=20
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
+#ifdef CONFIG_X86_64
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer =3D 1;
-#ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUG=
O);
+#else
+#define enable_preemption_timer false
 #endif
=20
 extern bool __read_mostly allow_smaller_maxphyaddr;
@@ -7408,32 +7410,6 @@ static void vmx_refresh_guest_perf_global_control(st=
ruct kvm_vcpu *vcpu)
 	pmu->global_ctrl =3D vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
 }
=20
-static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediat=
e_exit)
-{
-	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
-	u64 tscl;
-	u32 delta_tsc;
-
-	if (force_immediate_exit) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
-		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
-	} else if (vmx->hv_deadline_tsc !=3D -1) {
-		tscl =3D rdtsc();
-		if (vmx->hv_deadline_tsc > tscl)
-			/* set_hv_timer ensures the delta fits in 32-bits */
-			delta_tsc =3D (u32)((vmx->hv_deadline_tsc - tscl) >>
-				cpu_preemption_timer_multi);
-		else
-			delta_tsc =3D 0;
-
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
-		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
-	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
-		vmx->loaded_vmcs->hv_timer_soft_disabled =3D true;
-	}
-}
-
 void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_=
rsp)
 {
 	if (unlikely(host_rsp !=3D vmx->loaded_vmcs->host_state.rsp)) {
@@ -7519,6 +7495,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vc=
pu *vcpu,
 	guest_state_exit_irqoff();
 }
=20
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediat=
e_exit);
+
 fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	bool force_immediate_exit =3D run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
@@ -8328,6 +8306,36 @@ static inline int u64_shl_div_u64(u64 a, unsigned in=
t shift,
 	return 0;
 }
=20
+static __init void vmx_setup_preemption_timer(void)
+{
+	if (!cpu_has_vmx_preemption_timer())
+		enable_preemption_timer =3D false;
+
+	if (enable_preemption_timer) {
+		u64 use_timer_freq =3D 5000ULL * 1000 * 1000;
+
+		cpu_preemption_timer_multi =3D
+			vmx_misc_preemption_timer_rate(vmcs_config.misc);
+
+		if (tsc_khz)
+			use_timer_freq =3D (u64)tsc_khz * 1000;
+		use_timer_freq >>=3D cpu_preemption_timer_multi;
+
+		/*
+		 * KVM "disables" the preemption timer by setting it to its max
+		 * value.  Don't use the timer if it might cause spurious exits
+		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
+		 */
+		if (use_timer_freq > 0xffffffffu / 10)
+			enable_preemption_timer =3D false;
+	}
+
+	if (!enable_preemption_timer) {
+		vt_x86_ops.set_hv_timer =3D NULL;
+		vt_x86_ops.cancel_hv_timer =3D NULL;
+	}
+}
+
 int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		     bool *expired)
 {
@@ -8372,6 +8380,39 @@ void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->hv_deadline_tsc =3D -1;
 }
+
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediat=
e_exit)
+{
+	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
+	u64 tscl;
+	u32 delta_tsc;
+
+	if (force_immediate_exit) {
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
+		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
+	} else if (vmx->hv_deadline_tsc !=3D -1) {
+		tscl =3D rdtsc();
+		if (vmx->hv_deadline_tsc > tscl)
+			/* set_hv_timer ensures the delta fits in 32-bits */
+			delta_tsc =3D (u32)((vmx->hv_deadline_tsc - tscl) >>
+				cpu_preemption_timer_multi);
+		else
+			delta_tsc =3D 0;
+
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
+		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
+	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmx->loaded_vmcs->hv_timer_soft_disabled =3D true;
+	}
+}
+#else
+static __init void vmx_setup_preemption_timer(void) { }
+
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediat=
e_exit)
+{
+	BUILD_BUG_ON(1);
+}
 #endif
=20
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
@@ -8734,32 +8775,7 @@ __init int vmx_hardware_setup(void)
 	if (!enable_ept || !enable_ept_ad_bits || !cpu_has_vmx_pml())
 		enable_pml =3D 0;
=20
-	if (!cpu_has_vmx_preemption_timer())
-		enable_preemption_timer =3D false;
-
-	if (enable_preemption_timer) {
-		u64 use_timer_freq =3D 5000ULL * 1000 * 1000;
-
-		cpu_preemption_timer_multi =3D
-			vmx_misc_preemption_timer_rate(vmcs_config.misc);
-
-		if (tsc_khz)
-			use_timer_freq =3D (u64)tsc_khz * 1000;
-		use_timer_freq >>=3D cpu_preemption_timer_multi;
-
-		/*
-		 * KVM "disables" the preemption timer by setting it to its max
-		 * value.  Don't use the timer if it might cause spurious exits
-		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
-		 */
-		if (use_timer_freq > 0xffffffffu / 10)
-			enable_preemption_timer =3D false;
-	}
-
-	if (!enable_preemption_timer) {
-		vt_x86_ops.set_hv_timer =3D NULL;
-		vt_x86_ops.cancel_hv_timer =3D NULL;
-	}
+	vmx_setup_preemption_timer();
=20
 	kvm_caps.supported_mce_cap |=3D MCG_LMCE_P;
 	kvm_caps.supported_mce_cap |=3D MCG_CMCI_P;

base-commit: 3aec122bdcaf6f8c4ecfc7f6adf6773015ced676
--
