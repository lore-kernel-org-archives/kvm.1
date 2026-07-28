Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A541BA82;
	Tue, 28 Jul 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278450; cv=none; b=XfNNQ8p3mLixevUk+4+DeKnZUKGCJo3wnOu/sp+Lv8Hs7eZG8PKfjdnzNylpgVzTg5ANUgh6rXqURffRLYeITKzE0uvex4y5dRAX5H2Nxkflj0lRaJ05N2wIMOxGhn9+v4JYXYFQR/4Kidg5YNjMxSWrE/vGgwYQHh68HXdTA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278450; c=relaxed/simple;
	bh=ExwwVNBktXnu9UARBPrflxeYriHzWoshnkBEQh0Y6CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVQK2gCDU86mVHGEDYoNahrAEsKU0BJtF/M6reMIGF9ZHKGLpu3Ax5itNEgnuQBDAcfaKQllF+SwnGGMqGE2mJ9Go7xIwFeqONkBI9rlMlyLXsPXhoR79gx4yfkJSQu72fvCDLvFKdF5kVwtTi5e+Q7zsxyACXtZLJB0zm+zU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.16.7] (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 7F727233AC;
	Wed, 29 Jul 2026 01:40:42 +0300 (MSK)
Message-ID: <b79158b0-6b08-261c-1007-3a83a5fc5504@basealt.ru>
Date: Wed, 29 Jul 2026 01:40:41 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] KVM: x86: Re-pend NMI in vNMI hardware when injection is
 blocked
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Santosh Shukla
 <santosh.shukla@amd.com>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260728015416.1371404-1-kovalev@altlinux.org>
Content-Language: en-US
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <20260728015416.1371404-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sean,

On 7/28/26 04:54, Vasiliy Kovalev wrote:
>   [...]
> 
> Before falling back to a window, retry .set_vnmi_pending() as process_nmi()
> does. Hardware has already delivered the NMI it was holding, so the retry
> succeeds, nmi_pending drops to zero, and no window is requested; hardware
> delivers the re-pended NMI once the guest IRETs. On the first pass hardware
> still holds the earlier NMI, so the retry fails and single-stepping is
> unchanged. Without vNMI .set_vnmi_pending is NULL and the branch is a nop.
> 
> [...]
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7724,6 +7724,9 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
>   			can_inject = false;
>   			WARN_ON(kvm_x86_call(nmi_allowed)(vcpu, true) < 0);
>   		}
> +		if (vcpu->arch.nmi_pending &&
> +		    (kvm_x86_call(set_vnmi_pending)(vcpu)))
> +			vcpu->arch.nmi_pending--;
>   		if (vcpu->arch.nmi_pending)
>   			kvm_x86_call(enable_nmi_window)(vcpu);
>   	}


Fuzzing on 6.12 (AMD EPYC 9754, vNMI) still hits this WARN with this patch
applied, no stable reproducer. I dumped the vNMI state on entry to the NMI
block in kvm_check_and_inject_events(), plus a line in the re-pend branch
the patch adds:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 35ba3551f..f7615674f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -34,6 +34,8 @@
  #include "xen.h"
  #include "smm.h"

+#include "svm/svm.h"
+
  #include <linux/clocksource.h>
  #include <linux/interrupt.h>
  #include <linux/kvm.h>
@@ -10485,6 +10487,16 @@ static int kvm_check_and_inject_events(struct 
kvm_vcpu *vcpu,
  #endif

         if (vcpu->arch.nmi_pending) {
+               {
+                       struct vcpu_svm *svm = to_svm(vcpu);
+                       pr_warn("NMIdbg: entry pending=%u int_ctl=%#x 
VB=%d VP=%d shadow=%d allowed=%d\n",
+                               vcpu->arch.nmi_pending,
+                               svm->vmcb->control.int_ctl,
+                               !!(svm->vmcb->control.int_ctl & 
V_NMI_BLOCKING_MASK),
+                               !!(svm->vmcb->control.int_ctl & 
V_NMI_PENDING_MASK),
+                               !!(svm->vmcb->control.int_state & 
SVM_INTERRUPT_SHADOW_MASK),
+                               kvm_x86_call(nmi_allowed)(vcpu, false));
+               }
                 r = can_inject ? kvm_x86_call(nmi_allowed)(vcpu, true) :
                                  -EBUSY;
                 if (r < 0)
@@ -10498,7 +10510,11 @@ static int kvm_check_and_inject_events(struct 
kvm_vcpu *vcpu,
                 }
                 if (vcpu->arch.nmi_pending &&
                     (kvm_x86_call(set_vnmi_pending)(vcpu)))
+               {
                         vcpu->arch.nmi_pending--;
+                       pr_warn("NMIdbg: re-pended, pending now %u\n",
+                                vcpu->arch.nmi_pending);
+               }
                 if (vcpu->arch.nmi_pending)
                         kvm_x86_call(enable_nmi_window)(vcpu);
         }

The WARN fires with V_NMI_BLOCKING and V_NMI_PENDING both set and an NMI
still queued - and no "re-pended" line precedes it, i.e. set_vnmi_pending()
returned false because the slot is already occupied:

	NMIdbg: entry pending=1 int_ctl=0x7000a00 VB=0 VP=1 shadow=1 allowed=0 
  (repeated)
	NMIdbg: entry pending=1 int_ctl=0x7001a00 VB=1 VP=1 shadow=0 allowed=0
	WARNING: CPU: 3 at arch/x86/kvm/svm/svm.c:4027 
svm_enable_nmi_window+0x703/0x8e0
	 kvm_check_and_inject_events+0x10ed/0x16a0
	 vcpu_run+0x1922/0x4ed0
	 kvm_vcpu_ioctl+0x469/0x1590

So V_NMI_PENDING is already set: there's nowhere to re-pend, nmi_pending
can't be drained, and the window is still requested. The patch fixes the
interrupt-shadow path (original reproducer no longer triggers) but not this
one. I couldn't minimize the exact sequence, but it looks like
KVM_SET_VCPU_EVENTS setting nmi.masked while a vNMI is pending
(svm_set_nmi_mask() sets V_NMI_BLOCKING without touching V_NMI_PENDING).

In this state svm_enable_nmi_window() just takes the early return and
hardware delivers the pending vNMI on IRET, so nothing malfunctions -
b4bd55646747 makes the same "still function correctly" note for the
STI-shadow/GIF=0 cases. Drop the WARN_ON_ONCE(), or is reaching this state
(V_NMI_BLOCKING + V_NMI_PENDING set, nmi_pending != 0) itself a bug to fix
elsewhere?

-- 
Thanks,
Vasiliy
