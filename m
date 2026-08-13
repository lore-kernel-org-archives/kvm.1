Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9813E02A
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608630; cv=pass; b=QOvPFyDZyDrspkIcEA+YiJJlh/ivdRHsa3eECfgAEO+VfKfg2a6sFgSVnHRjGHkGqhuV/HBh6vOOmsTIou86zjvcGlCM+vCdZd9QaufhXDcRtWGr77oJLCTPm5YZkmvlQg2lUmvZcCEidRmk9Eh2nUmP/py1K03aS52H7jtl48M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608630; c=relaxed/simple;
	bh=niJTrQimvgcND0qsT4lU4KxAPaq3dvYplsB6A+l+Zog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea1BQr6jX49W+t8yCb7BpJf0/xD4HunAcZ/hvFJyaJ/tMcGmFz52RS3BAgkdHmr3ipQ1QrYUOlBKL+2DVt8ffvxrTpqFl7Tg2g0sBkp1AqolgGiQZj47zxJ/IPdQ1IYEQZfn1iNmpJJ4XmCw1hEgM2X8K8UHSWnAImOMKlS4Qj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZHnKcc9; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZHnKcc9"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-669944f60b3so2036694d50.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 01:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786608628; cv=none;
        d=google.com; s=arc-20260327;
        b=HphMR9I7norqrhInNu0o6JG5R4Bc0FRJLEImj7Y7Oah7SAR7AMkgGTuxzE0yyJfX3C
         cNziy/MTuADgHBfd01JSAkrLrY1sqhDZL+yjSO2GmPqFJOMF8DAGacnV1xeDCtyN/MqM
         rLUHPQnbQswt6ktVQ5WVvGZ+mj9Y2U/HZMjfTYsDejH2enQYJl6MIRIuonp3lGD2E/Ua
         K0183eDu7FvFnQR+vVYOy15Fu1MWgL+oRSJbQ2QRGjIHnfliMbsGxnipO0wZH1zB5Qso
         N4Mhrxexzprs65ROxpNqDhRsXkLP6/IdvYy2OWzpW3xUJ53tg6GKbamFO1/T40+SUsy+
         DPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKtx0i4elGHzS/TrpdIRihoilG6TmZJLuqjz3TSb5KI=;
        fh=FonJYf1ANnisU4uqs4ZRAk47a6DggmByevp78CSlRTE=;
        b=J+I2OluzGYLXPonDMrFuUe1kZ5Z8Xqe7ocXctcxD1fO1IF/uV6rghcGvzsiuXxxq3m
         MFM7ua1i+mqOU/88MFaQhQWsl3WnzKzZDbst7hIu6u+LnC6JJj/e+oOFwfL+Gg1q7D1Y
         zX9mLriax/3/FGUlfK2frRTWqKwHie5+nx3QQ7MC6X4VYN5wg0nrvx1QhtEasi2WqoZA
         wlhEKCUD42jCWMOLg2sjV4Uu7Pd/g5PTXQvkj3dXCZwOJgtnXpbrmoRvR6RLg2KGcLuV
         0p4gYPM51nsjUSdhW9h1mAzTEKMTYgQ+nooRfzNTg64Z+QlWXhvQDFPkFLMCLMDUkSDN
         yGsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786608628; x=1787213428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKtx0i4elGHzS/TrpdIRihoilG6TmZJLuqjz3TSb5KI=;
        b=XZHnKcc9usy2RjvxFGdweWY24uDtcjLNR2hQRxMhrLwh/h7k87BA6hMnHlaeXIQuXG
         tdGiqEL/cY38LGRS+5Qv+XZsrRNF8L6Fcw/CUZwh0EHSQf11frAkflbPWZBeDDokLP0J
         NJ3CzjGOyHoOOIiv4McA5RvypZl9Cn+PkDSdq9CM0PozHDGDdN8Wp6bYdu3UBmD0+0f8
         zIvu0dqPx/qctAe6lsdGbS5uixrTG8DhJ+fl5fnDq4OAsrOI/hR4OX8tp1LuC8sGqRz6
         U8TKm6pVyoJ3ozMQTasC/Oyce5dD0GArLMCuDnfiI4uTnpwumHvxFbN9BPvY3uKsoQtF
         U6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608628; x=1787213428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKtx0i4elGHzS/TrpdIRihoilG6TmZJLuqjz3TSb5KI=;
        b=mY5s16ZECRwoZjkTUwTzCaj1CSK/eJDt3OZ1SpQ05gYsPbTdzMfxS6Om5tVbCvBdKM
         2ltPXkGA1I3exOSCRKc/8JteBs35Gt7tqkUfykuOkAjdiegc7WCag8m23bpTYLLwcl+A
         gnyyvb9NPc4FH9avPWOJb5WF4NyzmL1uVYHpaG7kJAafzNX2YH59MvfyaQDadVeNg44s
         yy49Id1ACYV685E4Vi2FCsvB1Ltdpor4EjiXrEazmRmuxKRFtpkiuZJ0aUl7bOMmRua6
         9M1FLK1xlWFfP5DF0KfrVGS/gZPrl8s8gxOK49QQGsSNHrYOLg652+3+9edVtwVDrP8V
         hViQ==
X-Gm-Message-State: AOJu0YxkmA7iivtFK7GVuhnzggLVttGP2xmGHtV00+PyG2bmmc3070uG
	fVFy2ZQSiFgam4SXu7FNJm5P2R+DRzQQvLZ7aYJASk1P8CZdJb502yIHCNZW6R/gCvZBjGxhJiR
	EghqwypT2+xJ1wTgu9+wcpNwbZ3GV/ds=
X-Gm-Gg: AR+sD129xg/3j//xxwVeydVz+22kTMf0dYN1G1QiqiSG3gtFGcviTd1U3agjF34SbNH
	ZQi1oqs4H9noZO8wYQ4Ta8tN8zsrr/sQbZL3jOKre9DYJ/1LbNji+uIYJbMfGzcwhrc/CEeishE
	XkH+u09gdM/1uu9Vd33ONvWEO/7VaTTbWkv+4OQhRG85DAWpUPLX/Jtl3hFUhnDAlhyndmbtEtX
	1E2RPcmZO9EiBDw/2UCuzf+e5czmHanaEafQ1eCpgfevv0lOEaXMiunslGZEPJpTOn/ukWeW+IU
	CbZKjhhW5hNZBUiGx5g1DOCS14IyJhMf9I85nIN5+Ocu6B+cwG7/eDr8Lc5fnUB7C71ejvgr2Nw
	8
X-Received: by 2002:a05:690c:e0ce:10b0:826:8d41:897a with SMTP id
 00721157ae682-83471a15e8emr15505347b3.13.1786608627750; Thu, 13 Aug 2026
 01:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813043932.3214460-1-rkskek9254@gmail.com> <20260813045727.903981F000E9@smtp.kernel.org>
In-Reply-To: <20260813045727.903981F000E9@smtp.kernel.org>
From: Jinwoo Lee <rkskek9254@gmail.com>
Date: Thu, 13 Aug 2026 17:10:14 +0900
X-Gm-Features: AUfX_my7pDDZdtOGVM6xAlmp3xb5ZCqcno-jeV0YYXEDFl_sKpw6E4hQlOTbqJ4
Message-ID: <CALz4YMQa4h0oHxrpsiFsPd2qWZO1Q-pE2mbDwvT2wV1b+ukZdg@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the
 pages fails
To: sashiko-reviews@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending as plain text; the previous copy was rejected by
kvm@vger.kernel.org because Gmail included an HTML MIME part.  Sorry
for the duplicate on lists that received the first copy.
---
Thanks for the review.

> This is a pre-existing issue, but should the same re-arm be applied to
> vmx_get_nested_state_pages() and svm_get_nested_state_pages()?

At the request-lifetime level, yes.  kvm_check_request() consumes
KVM_REQ_GET_NESTED_STATE_PAGES before get_nested_state_pages() is called.
If the callback returns false, the request needs to remain pending;
otherwise a later KVM_RUN can skip the deferred setup.

On further inspection, re-arming the request in
nested_get_vmcs12_pages() is too low-level.  That helper is also called
directly from the normal nested VM-Entry path, before enter_guest_mode(),
and that caller switches back to vmcs01 if the helper fails.  I will move
the retry to the KVM_REQ_GET_NESTED_STATE_PAGES consumption path in
vcpu_enter_guest(), or to an equivalent wrapper, so that the request is
re-armed only after it was actually consumed.  That will also cover
failures returned by both the VMX and SVM get_nested_state_pages()
callbacks.

The eVMCS path needs additional handling beyond a generic re-arm.
nested_vmx_handle_enlightened_vmptrld() releases the old eVMCS mapping
before attempting to map the new GPA.  If kvm_vcpu_map() fails,
hv_evmcs_vmptr is left as EVMPTR_INVALID, whereas
nested_get_evmcs_page() retries the mapping only when hv_evmcs_vmptr is
EVMPTR_MAP_PENDING.  Re-arming the request alone would therefore not
necessarily retry the failed eVMCS mapping.  I will preserve or restore
a retryable eVMCS state on that failure path in v2.

For SVM, I agree that failures in load_pdptrs(),
nested_svm_merge_msrpm(), and kvm_hv_verify_vp_assist() can lose the
consumed request, and that L2 must not resume until the deferred setup
has completed successfully.

However, I do not currently see evidence that the SVM failures have the
same unpinned-HPA/UAF mechanism as the nVMX APIC-backed VMCS02 fields.
In particular, nested_vmcb02_prepare_control() initially copies
vmcb01's KVM-owned MSRPM address into vmcb02, and
nested_svm_merge_msrpm() switches vmcb02 to the KVM-owned merged MSRPM
only after the merge completes successfully.  Losing the request after
a failed merge can therefore allow L2 to run without L1's complete MSR
intercept state, but it does not appear to leave hardware pointing at an
unpinned guest page.  I will describe and test the SVM impact separately
instead of treating it as the same UAF without supporting evidence.

> Does this allow L2 to resume with unpinned HPAs and lead to a
> use-after-free?

Not uniformly across these paths.  The unpinned-HPA mechanism is the
concern for the nVMX VMCS02 address fields described in the patch, but I
have not yet reproduced host-page reuse or an actual use-after-free end
to end.  For eVMCS and SVM, the current evidence establishes that the
deferred setup request can be lost; it does not yet establish the same
unpinned-HPA mechanism.

I will also correct the commit message.  Not every failure reports
KVM_EXIT_INTERNAL_ERROR: the load_pdptrs() failure used by my RSM
reproducer returns with exit_reason unchanged, which is
KVM_EXIT_UNKNOWN in the test.

I will rework the patch and selftest accordingly and runtime-test the
fix before posting v2.

Thanks,
Jinwoo


On Thu, Aug 13, 2026 at 1:57=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch fixes the missing re-arming of `KVM_REQ_GET_NESTED_STA=
TE_PAGES` in `nested_get_vmcs12_pages()` for VMX but overlooks identical vu=
lnerabilities in `vmx_get_nested_state_pages()` (VMX eVMCS) and `svm_get_ne=
sted_state_pages()` (SVM).
> --
>
> --- Patch [1]: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapp=
ing the pages fails ---
> commit ce93ee9654c7f639f51372bb8a7e1b25a376436b
> Author: Jinwoo Lee <rkskek9254@gmail.com>
>
> KVM: nVMX: Re-arm the vmcs12 pages request if mapping the pages fails
>
> This commit ensures KVM_REQ_GET_NESTED_STATE_PAGES is re-armed if
> nested_get_vmcs12_pages() fails to map the pages. This forces KVM to retr=
y the
> mapping on the next KVM_RUN rather than resuming L2 with a stale vmcs02, =
which
> prevents hardware from accessing unpinned host physical pages.
>
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index ddf6df7bee93b..9e9bd6c541baa 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> [ ... ]
> > @@ -3525,6 +3525,20 @@ static bool nested_get_vmcs12_pages(struct kvm_v=
cpu *vcpu)
> >               exec_controls_clearbit(vmx, CPU_BASED_USE_MSR_BITMAPS);
> >
> >       return true;
> > +
> > +fail:
> > +     /*
> > +      * Re-arm the request so that KVM retries the mapping instead of =
running
> > +      * L2 with a stale vmcs02.  Bailing here leaves the vCPU in guest=
 mode
> > +      * with vmcs02 loaded and its APIC-access, virtual-APIC and poste=
d
> > +      * interrupt descriptor addresses still pointing at the host page=
s that
> > +      * were mapped for the *previous* nested VM-Enter, which have sin=
ce been
> > +      * unmapped and unpinned by nested_put_vmcs12_pages().  KVM retur=
ns to
> > +      * userspace without leaving guest mode, so if userspace resumes =
the
> > +      * vCPU, VM-Enter succeeds and hardware accesses those stale HPAs=
.
> > +      */
> > +     kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> > +     return false;
> >  }
> >
> >  static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
>
> [Severity: High]
> This is a pre-existing issue, but should the same re-arm be applied to
> vmx_get_nested_state_pages() and svm_get_nested_state_pages()?
>
> If nested_get_evmcs_page() fails in vmx_get_nested_state_pages(), it retu=
rns
> false and exits to userspace with KVM_EXIT_INTERNAL_ERROR without re-armi=
ng
> the request:
>
> arch/x86/kvm/vmx/nested.c:vmx_get_nested_state_pages() {
>         if (!nested_get_evmcs_page(vcpu)) {
>                 pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
>                                      __func__);
>                 vcpu->run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
>                 vcpu->run->internal.suberror =3D
>                         KVM_INTERNAL_ERROR_EMULATION;
>                 vcpu->run->internal.ndata =3D 0;
>
>                 return false;
>         }
>     ...
> }
>
> Similarly, in arch/x86/kvm/svm/nested.c:svm_get_nested_state_pages(), if
> load_pdptrs(), kvm_hv_verify_vp_assist(), or nested_svm_merge_msrpm() fai=
l,
> they also exit without re-arming.
>
> If a compromised QEMU sets KVM_REQ_GET_NESTED_STATE_PAGES and KVM clears =
the
> request but fails in these setup steps, a subsequent KVM_RUN could skip s=
tate
> setup and proceed directly to VM-Enter L2 with stale control structures.
>
> Does this allow L2 to resume with unpinned HPAs and lead to a use-after-f=
ree?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813043932.32=
14460-1-rkskek9254@gmail.com?part=3D1
