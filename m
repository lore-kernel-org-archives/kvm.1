Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49C38AC9A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130521; cv=none; b=lRW3XFhPf5aVzlu91nXtFS2dbeyGbDhLio6kxg9T9ZDgtXKmWeC64PwMqtxngnHzA76+k4a79FqswyO/jSKr9UcvE9Xfare32oP9oRPNILaQb+QUDvSPg1XcDLzc2NdllxOnw7vMHVnRzF1a7asEj+CBsi3Fv1GAZpzfpeq2F/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130521; c=relaxed/simple;
	bh=Fm0zenpub186Y5PGDR2tkGnepizk9hRkqfMM5G5d6/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rPNwrXyZVUYJgAu59oSfdTHPTImRp+GD35bQ8ZECy2ezzTpxO2a9otNZCHs83XDdrtKycWEbkwbpLluCLPMye4m5fxNG2OqydpBRm/yZVh5Z6DBOyBiB7kpobjilHu93eg4qHFDIWwPtAtIyjeQkkGacE5Ifs2ZhdTK+rMEtwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpFJoUTK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpFJoUTK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc860066a6so19774625ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130519; x=1779735319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0w4FcTUBSptpRyfeZI3fU3NdbJlyivP4/AgURVtItys=;
        b=tpFJoUTKEvTOss7Tisemtq+XiOPmqucRD/Ij7/cLaHIZFYdR1+0aLcCP41mq1mByHI
         nAikye82dmgTdfO0UsTEtCaHF2Trvevm/9sHYDGYLsj8DUez7UItqWdkZwrpcattV2K/
         9OLx6BD8wvJ6CRPr8+Rtbv9dqAtEPABdCJtzbzTwXF4cBzFtJjsshi8rEO41/uQqp5LW
         GAeYBYIU1/Jfdqxb0dm5bGhXjIOSbZrpO4sAztEitIKb+asuPxu5dGCPwStbD1mBSTtn
         0kMcijUlzu1UqD9MATDrOcgWYyuW9IYhf5c13kG8y64yC4Vgvsi7y8Y3Yo22n0R49sK5
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130519; x=1779735319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w4FcTUBSptpRyfeZI3fU3NdbJlyivP4/AgURVtItys=;
        b=pB2PxNr+u5Lb59n8+2qpV70Eqt0Rfu1aTHMBqRCtZgRAzordQ+vQabA3fBrdP8QuFm
         p9bYtiT+yT9Qbu0W22gyF1bBqm+skzatDCLDS1VSUHr/Voq2DG3mW9p2Jx4ChrdLLhbj
         Fud0WSyZ8WHz81W8c5FfbJAGcu1hd/LATI7CGU8FgEd2n8SDmpyRzVDBNttfzMDc/2zE
         8LM3gWyDP0QxhCc4Bx0/8w9u3G8kUuYiNEtKUzJGd2ocJVPaue0EzxZAPNAo534LTv2j
         gxxGQW2NlGJb2WuDc4r3mMRldg5qN+hLyLh7bZpPeoiOiB8VRrl4qklrX8HzgycK0xlU
         0e5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zSNFLFpNep3wZk2HZZ2xNPHnwHOaEOFzCEqNAmC8ZTcSy+NTyvtyYvUXUL+nhbW9+xDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspwIxp/tf8wGeVmjUTZpB5ZILr+OUcODxQWK4i59+sDo3fkCY
	t+YpU8AibeB79Kz38ZuI78tGOP3ZKCgf26Y2LTILSxrAcfQbCrNzSoH2jnlSoDaX6hhdilqwXk7
	2ZUlaRA==
X-Received: from plbkp3.prod.google.com ([2002:a17:903:2803:b0:2ba:2935:3b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d4f:b0:2ae:450c:951e
 with SMTP id d9443c01a7336-2bd7e9040a2mr130308165ad.17.1779130518928; Mon, 18
 May 2026 11:55:18 -0700 (PDT)
Date: Mon, 18 May 2026 11:55:18 -0700
In-Reply-To: <agtGh82vLu4G6pWI@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518045916.2988667-1-nikunj@amd.com> <20260518045916.2988667-8-nikunj@amd.com>
 <agtGh82vLu4G6pWI@google.com>
Message-ID: <agtgltn2wLNFrS2f@google.com>
Subject: Re: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 4ef9bc6a553f3..dd30aef9fc497 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -882,6 +882,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
> >  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
> >  	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
> >  
> > +	/* Clear PML fields to avoid stale data in vmcb02. */
> > +	if (pml) {
> > +		vmcb02->control.pml_addr = 0;
> > +		vmcb02->control.pml_index = -1;
> > +	}
> 
> I think the comment here is misleading.

+1000

> vmcb02 is allocated with
> __GFP_ZERO, and IIUC pml_index should not matter when pml_addr is zero.
> This is strictly for hardening as far as I can tell, especially looking
> at commit c3bb9a20834f ("KVM: nVMX: Disable PML in hardware when running
> L2"), which introduced something similar for VMX.
> 
> So maybe something like:
> 	/*
> 	 * PML is never enabled in hardware for L2. Make sure that an
> 	 * unexpected PML write would trigger a PML_FULL VM-Exit.
> 	 */

Hmm, I was going to say we should drop the code entirely, but I do think it makes
sense to set PML_INDEX to -1 to ensure a VM-Exit occurs.

Actually, even better idea, at least for nVMX.  Rather than write '0' for the
address, which is what I really dislike (bad past-Sean!), we should write -1ull
so that unexpectedly enabling PML in vmcs02 results in VM-Fail, i.e. don't even
rely on the WARN for safety.

If SVM has a consistency check on the address, then do the same, otherwise I
guess just go with setting pml_index to -1 and WARNing on PML_FULL?

> Also, the above commit also hanlded a PML_FULL VM-Exit as unexpected,
> maybe we want to do that here as well? Or is that too paranoid?

Not too paranoid.

> Annoyingly, the unexpected exit reason handling is in
> svm_invoke_exit_handler(), but the guest mode check is in
> svm_handle_exit(), so if we do that we may need to move some code
> around.

Why's that?  Oh, if we want to reuse the unexpected exit code.  What about this?

We don't even have to document the same thing in two different places, because
the reasoning for nested_svm_exit_special() can and is different.  E.g. even if
we decided to utilize PML while running L2 (which would be possible, we'd "just"
have to translate the GPAs), the exits would still need to be routed to KVM.
Ditto for if we did actually enable PML in vmcb02 on behalf of L1: we'd need to
remove the check in nested_svm_exit_special(), but not the check in
svm_invoke_exit_handler() (though the latter's comment would need to be updated).

diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
index 4ef9bc6a553f..401a0ac44018 100644
--- arch/x86/kvm/svm/nested.c
+++ arch/x86/kvm/svm/nested.c
@@ -1782,6 +1782,13 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
                if (nested_svm_is_l2_tlb_flush_hcall(vcpu))
                        return NESTED_EXIT_HOST;
                break;
+       case SVM_EXIT_PML_FULL:
+               /*
+                * All PML full exits are handled by KVM.  KVM emulates PML in
+                * software for L1, but never enables PML in hardware on behalf
+                * of L1.
+                */
+               return NESTED_EXIT_HOST;
        default:
                break;
        }
diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
index e74fcde6155e..6bcb191d725b 100644
--- arch/x86/kvm/svm/svm.c
+++ arch/x86/kvm/svm/svm.c
@@ -3635,6 +3635,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
            (u64)exit_code != __exit_code)
                goto unexpected_vmexit;
 
+       /*
+        * PML is never enabled when running L2, bail immediately if a PML full
+        * exit occurs as something is horribly wrong.
+        */
+       if (unlikely(is_guest_mode(vcpu) && exit_code == SVM_EXIT_PML_FULL))
+               goto unexpected_vmexit;
+
 #ifdef CONFIG_MITIGATION_RETPOLINE
        if (exit_code == SVM_EXIT_MSR)
                return msr_interception(vcpu);

