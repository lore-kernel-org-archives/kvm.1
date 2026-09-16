Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D649A3D6
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586044; cv=none; b=Z2NZ8t2DmZWYgONtLAkbc2xZdOxdhVaPBcMvzp6TBnUFcgk/R0rRVF7i+4SRQV8v3DTWsy8on9+Ar3HLhglVd/mr3Yr6pUpVTi8z41asIeQTa4t0NPfvyYZKU5nsIrrgPUsiiAwkC1oo4UojC/t978asi900LGGASMdlB1Wv9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586044; c=relaxed/simple;
	bh=grwLO1oGGakIcjyeBqZgaIPwJ051uAvHakl+Xbh/guE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7C58paJeZkizCS3uU6KYq78qiJXDeu8KBtvFJIUtFPS8DDIMDgwQy3qXIkdvt27+whsJ5PR62oz//ii9ymqxc+ouiRtlg3mixvInX7BpsTzX0XOcoJ9qtJWGA/jFMcoX6qpY95N4F67ND9uyeC59Ov9lqtQ++dCQ2Cw1OO9T5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO3K1TFz; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO3K1TFz"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso39166a91.2
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789586032; x=1790190832; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmeBzkTcsvJUd+BuTZhEbp8GE3iyf2+WK+kS+r8qWE4=;
        b=CO3K1TFzCHBozy5GfMmpnNUpJZ/H/28OPscBZfMkmOCH1H3tI248sQF6FCZJYiiwJm
         n4zBnAw+CCaKi9aBxwTFvp2W0WmKvtTPQeFQHp+JbX4ov+sx1HKazSmRK7aphQH7EJd8
         NoKDlfT0IaI7P/zmMqFhYYlcAH3rIXHcgnimVt6I4ZInl0fMZa8Mk6XwR3Zj3JnUmsLQ
         UeMSVTQkil/QU9iKZGZOBoVNasbMYXjtvL2c7AOlMMWZuxdG2RMxeha3nuZ5scOpZoDd
         KYP6HGi91qVBx6K7fW4WNkeCn+0B8t72eYLBh+VzD1ockKC53CrYEK8uGGsp/qhp5VCi
         kp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586032; x=1790190832;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmeBzkTcsvJUd+BuTZhEbp8GE3iyf2+WK+kS+r8qWE4=;
        b=DwzA98KRgrWPnmH7WU8JjXFimOtajfxVcLUbveIEKwXiYpwWcgXe/368bJOsV1boDJ
         J47aAkeZof6KPhFVhrhCtxwtRaizmGIhTjlsGTGWlU2VmY2ovsJusq/q9arjGdlvwMn3
         3Fd4QzG5ad/IuNITMUVjtOLOSjuc1LgSbcMn7vrV/kTGEgURsDsFdqVVUOzUTYytiiGm
         kDAXivTCSlr13eGLvpYUXUnwnpWWx2YdWzdIZvnJyCELFR2o3w619IEjrPDwKRRzDlj6
         FnszXKHSe63WONaTXEKpAXlgoXfkbF7bZqEc4za4+lPV2raOt9YJng1MtJtYNqmLHzQZ
         DRDw==
X-Forwarded-Encrypted: i=1; AKwUvBwYaGswAG05WDWYAVjVWqCfbjkBoaeZzbuOG3LFkVYZU/hNnr7E7MqWjJj3uzWT90rAUZw=@vger.kernel.org
X-Gm-Message-State: AFuF++kB7kDST40U3FxMOXmRrGqR8TM752KjEnSWj0qcY70J5ITxNI1d
	7+H9yNTvIXTBwW4eWUWi8ehDJqVAzDer7OeJ9WQ6Samd7J5/NhXp5ymQ/8obHbcuFoPA09zm8SK
	VdPPxqQ==
X-Received: from pjqt13.prod.google.com ([2002:a17:90a:ae0d:b0:398:9c5e:d8f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ccb:b0:39e:433:23b5
 with SMTP id 98e67ed59e1d1-39e1e24f9f4mr8606870a91.5.1789586032240; Wed, 16
 Sep 2026 12:13:52 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:13:51 -0700
In-Reply-To: <aqnNAsGF_iUQsVX1@com-75606>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915222625.99965-1-kylebot@openai.com> <20260915224104.4EB441F000FF@smtp.kernel.org>
 <aqnNAsGF_iUQsVX1@com-75606>
Message-ID: <aqrqb-lz2f0gCwuF@google.com>
Subject: Re: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 15, 2026, Kyle Zeng wrote:
> On Tue, Sep 15, 2026 at 10:41:03PM +0000, sashiko-bot@kernel.org wrote:
> > > @@ -6454,7 +6456,18 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> > >  
> > >  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
> > >  		if (vcpu->arch.mmu->root_role.direct) {
> > > -			ctxt->gpa_available = true;
> > > +			ctxt->gpa_access = ACC_READ_MASK;
> > > +			/*
> > > +			 * Always allow writes for SEV guests, as the guest's
> > > +			 * page tables are encrypted, i.e. KVM can't walk the
> > > +			 * guest's page tables and so must always use the GPA
> > > +			 * from the initial fault.  Restricting use of the GPA
> > > +			 * to the access type that faulted would prevent KVM
> > > +			 * from emulating RMW operations for SEV guests.
> > > +			 */
> > > +			if ((emulation_type & EMULTYPE_PF_WRITE) ||
> > > +			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
> > 
> > [Severity: High]
> > Could this lead to an out-of-bounds read and type confusion?
 
...

> Is there a configuration that gets past the initialization checks and
> demonstrates an incorrect access? I'd like to establish that before
> treating this as a functional issue.

Eh, doesn't matter, my suggestion was terrible.  I forgot that is_sev_guest()
needs to check embedded data; I was thinking of TDX and SNP VMs, which have
dedicated VM types.

I think the right way to handle this is to track if a VM has protected page
tables.  That'd also help communicate/document why KVM has this weird behavior.

Untested...

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 30ffaa65f589..90c950c12900 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1166,6 +1166,7 @@ struct kvm_arch {
 	u8 mmu_valid_gen;
 	u8 vm_type;
 	bool has_private_mem;
+	bool has_protected_page_tables;
 	bool has_protected_state;
 	bool has_protected_eoi;
 	bool has_protected_pmu;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b56c39c53c98..7f544658b1cc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2955,6 +2955,7 @@ void sev_vm_init(struct kvm *kvm)
 		kvm->arch.has_protected_state = true;
 		fallthrough;
 	case KVM_X86_SEV_VM:
+		kvm->arch.has_protected_page_tables = true;
 		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
 		to_kvm_sev_info(kvm)->need_init = true;
 		break;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 014545c1839b..35022f308e06 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -616,6 +616,7 @@ int tdx_vm_init(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 
+	kvm->arch.has_protected_page_tables = true;
 	kvm->arch.has_protected_state = true;
 	/*
 	 * TDX Module doesn't allow the hypervisor to modify the EOI-bitmap,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f36b952624c8..7e5e2e587086 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -33,7 +33,6 @@
 #include "lapic.h"
 #include "xen.h"
 #include "smm.h"
-#include "svm/svm.h"
 
 #include <linux/clocksource.h>
 #include <linux/timekeeping.h>
@@ -6412,15 +6411,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		if (vcpu->arch.mmu->root_role.direct) {
 			ctxt->gpa_access = ACC_READ_MASK;
 			/*
-			 * Always allow writes for SEV guests, as the guest's
-			 * page tables are encrypted, i.e. KVM can't walk the
-			 * guest's page tables and so must always use the GPA
-			 * from the initial fault.  Restricting use of the GPA
-			 * to the access type that faulted would prevent KVM
-			 * from emulating RMW operations for SEV guests.
+			 * Always allow writes for guests with protected page
+			 * tables, as KVM can't walk the guest's page tables,
+			 * i.e. KVM can't get the RMW protections for a given
+			 * GVA to see if the write side of a RMW operation
+			 * should be allowed.
 			 */
 			if ((emulation_type & EMULTYPE_PF_WRITE) ||
-			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
+			    vcpu->kvm->arch.has_protected_page_tables)
 				ctxt->gpa_access |= ACC_WRITE_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}

