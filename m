Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46B37E5DD
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113516; cv=none; b=qtRmp8BtxoSjUnEBwKBSNJbI5Iq6/sWC1kNo8FTq7cGDAeAGlevl15xyHyeKMQm7j3V8QCjE8Wa7N4c19bZIpg8bUkfPzydtrD/ykLVH9m28zItNs6OwYrS0aliyrgUZ6ybvk6UdvEx2yBnmrdW9eTtfZcdDpfWqmYvB0k05JVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113516; c=relaxed/simple;
	bh=/8eBC4cBcmk/OOwRZMskFCKDvUHCS1O1Ty0m2S3GOb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a9fgknrtn9rZzVHlTpJFZ5L73DzKcrJWjCNNyi3+7/icJnQwSLLsh572usHcOX0g7A1T07v6lvB9Fv2LVN5aGsyKmDZhPv6VjZQEbSqcnr64xJ+3Sh+YU6OX7fbsqBm2mOQyghzeromIvI5bMe5jcpU2ibOxeyRH+FDnL2jibOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z409DCqQ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z409DCqQ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfca8558d2so47457755ad.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786113509; x=1786718309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wfh7ukRj1lyo1oKSry2hYUgnDccy+4/yKqQMGL09KaI=;
        b=Z409DCqQQIeuuMzg5WwomjZrsXJfC39thP4Z5k1P9ZNVZVk0fKhg6bFbSEvp8MyA6v
         10YRMtDnHQOhU1+gVhQaM5UGl5IYhHuGvkKJxdnX4zFeBhkyxBfDl/Yzoj+fcmw68glr
         LD4axN2PVXKdZNo8xU7KEwTtlzuvEjsZsC5kWDtO4avTv13ag+Fm48x2EIMhPzHXxTMA
         YbMwn8+GEPGjWeyHmfWEdxObqZsCU7bbRGGIEhWGHzOBmosL2BQXYAdPYGfylQf3xSJ8
         qRym7OsP5dhV5AsY0FZO5pUs9CyWRf3JTFezkyKJ2Tu4ARHWum14Zn2BUWPL0+xM0Q+F
         5W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113509; x=1786718309;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfh7ukRj1lyo1oKSry2hYUgnDccy+4/yKqQMGL09KaI=;
        b=esgwDeJtx8PyovrboTlygFQcNPQB98HPakcSMdlPw3Y2IL+rFAUxU6xtGrx1Xdx1IR
         SH5GCkOU5AHEgT+OaBVCUHIj0R8/up+4IlH3rvRo4f8I+0NUpA89OzNyQ60NNZW1B5O8
         wJ6daLrwX4eGEbpDy8eYGvFMiP+QJfLqTN2ahvtQP4QzXtwLGMTrYLrEzN3HIzpzgVCq
         p2Fxv58d9E8ySpQq9aIlB56qOTP47/H75szq2HVO0Eyw4+TdR58jONNWVlm3qQJrAbdm
         4Vu2xlS3eXf5Uz/I5bIYQJKa3S+kE+9cbfS/55pl+9sssM9gcTcATdbs8p2/QWCXwDNd
         Qcdw==
X-Forwarded-Encrypted: i=1; AHgh+RoYQ3CCGLQjw5VSDEK2EXFinUWZ9mq4SASc4PSXTchiQfFQxqxbaAegjY1PkyjNLlaoPIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3IPs4ZvGfEiMJsecQdhjwdGzWlzh2phEZvr5ZBO/6xK9xEi4
	1SfwrM3OfNNNgo6sV4lI19RIK4nGH2L0w+2ntB6iib5PTUSZYSa0Z+YYu1P6ZCfPR7+uaJjRKAU
	u7DUAOg==
X-Received: from plbjc21.prod.google.com ([2002:a17:903:25d5:b0:2ca:d66c:97b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68b:b0:2c9:e846:a57e
 with SMTP id d9443c01a7336-2d2a55ecec6mr12985345ad.0.1786113508614; Fri, 07
 Aug 2026 07:38:28 -0700 (PDT)
Date: Fri, 7 Aug 2026 07:38:28 -0700
In-Reply-To: <caedad66-8a7b-4182-9fbb-d4abe1f1696f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com> <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
 <caedad66-8a7b-4182-9fbb-d4abe1f1696f@intel.com>
Message-ID: <anXt5Mwa_kRXwRqM@google.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026, Xiaoyao Li wrote:
> On 8/6/2026 9:33 PM, Nikolay Borisov wrote:
> > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > index 545b03d9d10b..cdc0d24657ac 100644
> > > --- a/arch/x86/kvm/vmx/tdx.c
> > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > @@ -2129,6 +2129,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu,
> > > fastpath_t fastpath)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - If i=
t's not an MSMI, no need to do anything here.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> > > +=C2=A0=C2=A0=C2=A0 case EXIT_REASON_NOTIFY:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NMI blocking state is =
handled by TDX module */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __handle_notify(vc=
pu, false);
> >=20
> > I'd rather there be a private handle_tdx_notify function in tdx.c than
> > exposing __handle_notify and introducing the boolean. This is needed
> > because the TDX module handles the NMI unblocking, so let's keep the
> > implementation specific to tdx.
>=20
> The initial version just implemented a separate handler for TDX. It had t=
he
> exact same code as VMX's handle_notify() except the "NMI blocking handlin=
g".
> So to eliminate the code duplication, I changed to current code.
>=20
> Sean, please let me if you have a preference. Otherwise, I'll follow
> Nikolay's preference in a v2.

Handling this like __vmx_handle_ept_violation() and __vmx_deliver_posted_in=
terrupt()
seems like the obvious answer.

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 08005676702c..c179fb34c336 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -4,6 +4,7 @@
=20
 #include <linux/kvm_host.h>
 #include <asm/posted_intr.h>
+#include <asm/vmx.h>
=20
 #include "mmu.h"
=20
@@ -183,6 +184,25 @@ static inline void __vmx_deliver_posted_interrupt(stru=
ct kvm_vcpu *vcpu,
        kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
 }
=20
+static inline int __vmx_handle_notify(struct kvm_vcpu *vcpu,
+                                     unsigned long exit_qual)
+{
+
+       bool context_invalid =3D exit_qual & NOTIFY_VM_CONTEXT_INVALID;
+
+       ++vcpu->stat.notify_window_exits;
+
+       if (vcpu->kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_USE=
R ||
+           context_invalid) {
+               vcpu->run->exit_reason =3D KVM_EXIT_NOTIFY;
+               vcpu->run->notify.flags =3D context_invalid ?
+                                         KVM_NOTIFY_CONTEXT_INVALID : 0;
+               return 0;
+       }
+
+       return 1;
+}
+
 noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
=20
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9abd2ed3aeae..e77c1037e95d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6289,9 +6289,6 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vc=
pu)
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
        unsigned long exit_qual =3D vmx_get_exit_qual(vcpu);
-       bool context_invalid =3D exit_qual & NOTIFY_VM_CONTEXT_INVALID;
-
-       ++vcpu->stat.notify_window_exits;
=20
        /*
         * Notify VM exit happened while executing iret from NMI,
@@ -6301,15 +6298,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
                vmcs_set_bits(GUEST_INTERRUPTIBILITY_INFO,
                              GUEST_INTR_STATE_NMI);
=20
-       if (vcpu->kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_USE=
R ||
-           context_invalid) {
-               vcpu->run->exit_reason =3D KVM_EXIT_NOTIFY;
-               vcpu->run->notify.flags =3D context_invalid ?
-                                         KVM_NOTIFY_CONTEXT_INVALID : 0;
-               return 0;
-       }
-
-       return 1;
+       return __vmx_handle_notify(vcpu, exit_qual);
 }
=20
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
