Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A84DAF81
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017948; cv=pass; b=GuhUSdZkOV7ALQwSGlwC9AI5tCfSPu57vHvG5Vyw/D5fCE84X6a17p8F9b4igk3S//m4AkuB/jE4tmBZz5kT5p3X6ngq09wAsEmXQcz99UXfqbDzbATSllE8JShGRVTk7gVxNKu+D7Feq+qG7SDmeEeNulxqosbJuDUz6qhKkkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017948; c=relaxed/simple;
	bh=FaLLI17eGdjyn5N84JJJAxyH9MytVJDuiLxXqWyVw5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhxfpBEVs/QI0QH2vx/hqXCtWvgmtHyVm9a2qsf8H5Q36EZiyVKfYMlUZu+x8L8NB5pWaA0g+rjFRurNL2gV46yp3NclGtzMZ3GIM20I77lpNkqz+0rPoGtrFeQ8KuoGMajs2IEbBA4KGdPR05ozMEh2evwmusAIhNXd+GRu/7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lu9ZiAqR; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu9ZiAqR"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so845a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792017943; cv=none;
        d=google.com; s=arc-20260327;
        b=QWYUGAIVva8b0KfaSr6G03ec8nYr3VD+gJCjuDA3DSCqPz/2Dxs1hozjMqcTaA/fKx
         ydEZ8rbFmGtryn3WyxFuKmySedhtiqjOLNvIIcF33+b1RMJoDknWQ93DwqpN5DRnOShw
         QYXOsB9CrepvlfmOOWT5uIddtTMPgHfPp4I/g+NdEmk6igfRhpiiuwKLf7xKKVgao9kl
         LVwIfFwQcLPYJV8D17hG4tpy+kAu/I06KnKqroiip1Lya6QxI7qBU5p4lb+/faaVhgPO
         E/yFBf+VFkWPYFHqgzYTIWO2zrEBNx+//pr3lZhhAXv3Eq0JNtd/ooaHAXUW7P77RgoG
         ybPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNhlAzluPgq2vRINJzjMs3q40Gz5dj3N3e0lDI/4Izo=;
        fh=BXpO7ROr4egscexN24M+7MoF5TpezRlgI8Xu4yf5bEM=;
        b=okMoyFZdq7gPrYZz2Pj83UlSojLuSwMMqfYqLSRRk7avNoORDmK2/g8bEgTwBH0lIj
         2SwCvnTUy0kcOlnWdXVLj4PoEjo+RmKBVrelAlluX0Sos9cCi6GLWdLAkXLk1f/r5Wt9
         aeCEmaS2GyubE7nNdIDA4Ff58cWD5EfaI2qAx09/he01euz+utpAN8DC7GNwWqK0OCdE
         T6m/IKSCtnG8CgJ1lAFTAcXCxPY9gzXVL+1n0vMyvRbqp506ubBBNhVeTW9+6JAtXOne
         yl+BtRqpntQrxngsHY0LCgRssvLEeHVf0dU1bGZ2MRrc+5+gd5SuxGoJYQtijEsZbVjz
         qXSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792017943; x=1792622743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vNhlAzluPgq2vRINJzjMs3q40Gz5dj3N3e0lDI/4Izo=;
        b=Lu9ZiAqRlEqCUZgxmyzxtFyuXYNYS/9nYP5xjXZa3ZzY3Ew+pG2wYM9s5v98O9gJTH
         LW2iSzGgeklAc25V9Y+YGwmPqgKaOFonOE7ShrLuENRm5bSNKtHj+bt4HyQK3yC1suwz
         F1gC2aAIsQBuG+5r/qkgQowjI3sZXnIv2HaR23+EemtnheyYMmVscCfL7dXkPVpk4ony
         voZywp2r33mQH6fBieoPk7lj5XyAzywcnyoeey+UfHH/KBlxqrLFjhHc5/YG3IY5hlqD
         Hyb77gyZ0rsm1n8YSWl1i31OGDUrNgCJGjJxf/AmI4KCpJ/gcWUSF/feBtp5qFHNLnwn
         YmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017943; x=1792622743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNhlAzluPgq2vRINJzjMs3q40Gz5dj3N3e0lDI/4Izo=;
        b=NtPyIc6Sj/wtCuNSrBWQvpR6rqwHQ32pPfN/+HZl4h4yz3/fpxuxd2U9wBqGjQ91hi
         m0PhJGzBikZJBHacqE18tFVrZ3MU+UHaopT18BgYQ0ouL49wQtj+pddniug48kC1yGa/
         MPE/1TculOqVc1czFOQQ80gLzGEz7bE4gHxJQd9vc7pTQtnL5fH6c1d3RnqdTyg71FP+
         J++RCZo+th/mK2WExdK9eEuJP4mtwYToDC6fcG2FTNZkGcl2Cv8oTnduf1zNk/+3F42m
         wQv3kpuGF7JCY2yMeizJO7ocWxabwWP10UG6nJKLpLESsk0SZfVlhG6lkfula1EPePiI
         Ne7A==
X-Forwarded-Encrypted: i=1; AKwUvBxWWb1LVA6bID+qCt6S9xwdNHOyiRBUjYrd6Gee6K40cvshFVBav3dAmR+2dafCpVjfnvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuHFHmf/8hHZygiPtgf7t/MtbdNZC6pNFdWjd9e3HbrrzpFKyF
	tjcF4pbFuXsNPW5wPcGGpgeuavOCPbvEpaI08ngCyQ5Z0rKNhPg0T9IYOtfns6Yg1LVX0n1ne1d
	CRMN6y2xUxP2bHc+06ORM7xFoYpDF+N0/QHzr11bf
X-Gm-Gg: AYBFou38tV6KK2M1Tlajb7Fn44KvoTiIHcAutqn5Wj9ADTCmr9aDS1gfpsH/8fgDBXh
	GcAmVpm/aIbR3cKhWoLEt9hjiTF/4u9M5d/aZgRQ6kNCeA1vlB8M5AZAGbJlnG7cqyJYCES1uSe
	raaMtn93aFJSDl//gIvLdhXypiHdS1GXVhQFEHIwWb4t5H/ijuyUoJoJudxkzGcAMxCoYSsebg7
	LhcKgr11QbEwrLUEhoU3pCXC97gjN6hWDsvirAi13tUIidb95znbOMQH1g3qHWVUsz0Up+I8neN
	wEbizqMIwJEuJlqls4qjPsJRWILCRPUn7JfoqKVum3447kFb7dgqHdA=
X-Received: by 2002:a05:6402:a404:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b20aae70bamr66662a12.12.1792017943090; Wed, 14 Oct 2026
 15:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-7-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-7-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 15:45:30 -0700
X-Gm-Features: AclHuK_hKX_7RdeZVUGVmuxSKV88-Xz0CNGEMSKYVg4EtYtL0Qk7Zdmva1Zm8aE
Message-ID: <CALMp9eSZoXs8vAswymwdiX-0ge-EOef8TR2nZw814wa63LpR-A@mail.gmail.com>
Subject: Re: [PATCH v3 06/27] KVM: SVM: Fallback to flush everything if
 FLUSHBYASID is not available
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Currently, if FLUSHBYASID is not available when performing a TLB flush,
> the fallback is decrementing the ASID generation to trigger allocating a
> new ASID. In preparation for using a static ASID per vCPU (like VMX),
> just fallback to flushing everything if FLUSHBYASID is not available.
> This is probably worse from a performance perspective, but FLUSHBYASID
> has been around for ~15 years and it's not worth carrying the
> complexity.
>
> Move the fallback logic into vmcb_set_flush_asid(), as more callers will
> be added and will need the fallback as well. The only other current
> caller is from SEV code, and no CPUs support SEV but not FLUSHBYASID (at
> least according to AI).

A more compelling argument is that sev_hardware_setup() requires FLUSHBYASI=
D.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/svm.c | 5 +----
>  arch/x86/kvm/svm/svm.h | 5 ++++-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ad4f172f170d9..0c3befd9bc850 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4326,10 +4326,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vc=
pu)
>          * unconditionally does a TLB flush on both nested VM-Enter and n=
ested
>          * VM-Exit (via kvm_mmu_reset_context()).
>          */
> -       if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
> -               vmcb_set_flush_asid(svm->vmcb);
> -       else
> -               svm->current_vmcb->asid_generation--;
> +       vmcb_set_flush_asid(svm->vmcb);
>  }
>
>  static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ba5077b9838c0..3b59561d6cc2c 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -482,7 +482,10 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, =
u64 data)
>
>  static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
>  {
> -       vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> +       if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
> +               vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> +       else
> +               vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ALL_ASID;

This is unnecessary. Hardware that doesn't have FLUSHBYASID only looks
at tlb_ctl bit 0 to decide whether or not to flush the entire TLB.
The other bits are ignored.

>  }
>
>  static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
> --
> 2.56.0.385.gd3acb90ef8-goog
>
