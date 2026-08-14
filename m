Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558B3451AB
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722420; cv=none; b=H8PK7dKN6JUx6XMHIxu+pTF7OXNCvioUTbm1smBW4t1IQKFRS6+sXZ8F42tIfbWpCvPIwVouCumRkbTsyjdKgYKxDshAPKgDKTvR5h5BT19bTo7XTnuL+o9pUTPAm2bqhhdJSWwqtxdCNMAn5l7oyHXmT/1NR88fl4yA05aEMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722420; c=relaxed/simple;
	bh=gZQkoVaAFOmTY3m1sYFYvHE001BRKNgszU9tlSAzwJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJoi9PSLYYQNsHalPX9QqbXo1rmNTXMeYmchBBOHFTeO66p3CeOpYTHjVlSYm7e7iPZtS5S/AOFDe2CYwoEawb1sD4NrFNgYKRUU/cBMXi7Q+jKkzWYOGNj/y5pQLJy6NNyQly219TM57XlzZzW66ile8pqdkOCJdOH17CDQBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwI1b4J9; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwI1b4J9"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so16071065ad.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722418; x=1787327218; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vj129hgq53XjDebLrehf04tZFQC4vvxtUD+vRkJLjFg=;
        b=TwI1b4J9IIYzCGPl3RS3qIUqg4YMK1JQ1pSCt4KV2GgjOBlicHhLa5uEvADqD9VOkX
         WZe3xVCasx4s6fCDuBEjPOhO42hjf8HEZhK7JXZfkit5njvpJzsrX/Uv5T6qY4pnkGgc
         WmcudqHQ6A6T2YWG1HAEqwenXdvAhfDMb4IymPTrUW1q0iBHf7Er6vbJ1WG47Rkq+7eW
         qawPmRfg3NAub5K5Fn6Ba8XLuY7BUvoGo93M8VUvOTVbEZlkoAJGlZSYe/DGl5ylHuzL
         zKhWHrciaiods2lHPaIynE0KY8TSvP2gSzloK0ofTCCljqQY+Dms3RJmQ571lSZ5h9pi
         1O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722418; x=1787327218;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vj129hgq53XjDebLrehf04tZFQC4vvxtUD+vRkJLjFg=;
        b=VMAeTavpFlxYJlultJ5cXs+GlrE+09/PfMoc5gNsvQyfQAd0lL+vGbSgzLRHNL07J9
         yNoSQDAgfQvhTvHyp8uwK2VMCfF8HQX0zpj0SaCX8t4aCxdFoUrQoMDR9fx6IkqGsvzy
         17qCb6oODbTLEWoRsjGQO3kgxB/vhOOZgEokv62uB7U7MlMqoM8sUQNdc22/KPpGQPLJ
         aehcfpArmOeVwn+Ki1KK+q7vLm1F+Mthg0wh1KPFdySwwMthHujJbUSHwcZAqg/qRf4R
         0oPcB86T7QmX4cxN5ZUWZPfeQq0X7JGLldi54uZ+8dsPLYB3lDIAf7BJsU+ZwuKTlTsc
         aLuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpejPADZsy6E2O3BQGmO6EnlWZ+X7Lxw+cQDl5OxKwG1KvQJogfTdp88XwKTSzKC21F2so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZPGDVg26EQzCQZCxzQAdGt6KFaBOw31FEWbe2ef+hCcV7hub
	Bxf1Ud7ZceZV4Ym209Ca0H4lVQK+2C48mOG3AWx9U1sH4BzbVD5UpoHV/ASdB7nu+qVApBHGRQR
	2l+Aw1g==
X-Received: from plbky6.prod.google.com ([2002:a17:902:f986:b0:2cf:75c1:ab87])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aed:b0:2c9:e846:a589
 with SMTP id d9443c01a7336-2d3affcc1f5mr59975515ad.13.1786722418007; Fri, 14
 Aug 2026 08:46:58 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:46:57 +0000
In-Reply-To: <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com> <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com> <an3YFiDbjRs3PUwn@google.com>
 <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com>
Message-ID: <an84cenJjf7EqhVM@google.com>
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Xiaoyao Li wrote:
> On 8/13/2026 10:43 PM, Sean Christopherson wrote:
> > On Thu, Aug 13, 2026, Xiaoyao Li wrote:
> > > On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:

...

> > The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
> > With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
> > captures the logic instead of subtly rerouting KVM away from meaningful handling.
> 
> tdx_is_exit_reason_valid() doesn't work unless we update the vp_enter_ret to
> one that isn't one of the status code with valid Exit Reason. See below.

Correct.

> About the idea, isn't the purpose of setting the Exit Reason to a synthesized
> one is to avoid the undefined Exit Reason causing false-positives when it
> happens to match one of the existing ones?

Yes.  The nuance is that I'm against clobbering the *full* exit reason.  I am
not against setting exit_reason.basic to something like EXIT_REASON_INVALID_STATE.

> If we are going to use tdx_is_exit_reason_valid(), does it mean we can drop
> the synthesized Exit Reason entirely and check tdx_is_exit_reason_valid()
> everywhere when KVM is going to consume Exit Reason?  e.g., for this initial
> bus_lock_detected bit handling here. we can avoid it by below. (Which makes
> it different for VMX, and somehow prevents consolidating the code between VMX
> and TDX around the exit handlers that we plan to do after series)

I'd rather not, as it would make checking for tdx_is_exit_reason_valid() much
more load bearing.  I.e. I want to minimize the number of flows that *need* to
check tdx_is_exit_reason_valid(), and an easy way to help on that front is to
ensure that exit_reason[31:16] is accurate with respect to what to the last
(attempted) entry to the guest.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b6c30c4c6b84..52360313dd82 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2169,7 +2169,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t
> fastpath)
>         int ret = __tdx_handle_exit(vcpu, fastpath);
> 
>         /* Exit to user space when bus lock was detected */
> -       if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
> +       if (tdx_is_exit_reason_valid(vcpu) &&
> +           vmx_get_exit_reason(vcpu).bus_lock_detected) {
>                 if (ret > 0) {
>                         vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>                         ret = 0;
> 
> > diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> > index 95d89d809c19..a1f5b5dc1fa3 100644
> > --- a/arch/x86/kvm/vmx/main.c
> > +++ b/arch/x86/kvm/vmx/main.c
> > @@ -157,6 +157,14 @@ static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
> >          return vmx_vcpu_run(vcpu, run_flags);
> >   }
> > +static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> > +{
> > +       if (is_td_vcpu(vcpu) && !tdx_is_exit_reason_valid(vcpu))
> 
> No, this doesn't work.
> 
> The previous vp_enter_ret was TDX_SUCCESS with
> EXIT_REASON_EXTERNAL_INTERRUPT. KVM handled it and is going to re-enter the
> TD. But wait_for_sept_zap is set by other vCPU thread, KVM decides to return
> directly but the vp_entere_ret isn't updated.

Oh, right, it really is the same situation as emulation_required, sort of.  The
key difference is that wait_for_sept_zap is per-VM, not per-VM, and so if it's
*cleared* between tdx_vcpu_run() and vt_handle_exit_irqoff(), then KVM would get
a false negative and again synthesize a duplicate IRQ.

Actually, can't we just do this?  Logically it's sound: if the exit was handled,
then there's nothing to be done.

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 0626e835e9eb..6cace57e45fd 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -8374,7 +8374,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
        if (vcpu->arch.xfd_no_write_intercept)
                fpu_sync_guest_vmexit_xfd_state();
 
-       kvm_x86_call(handle_exit_irqoff)(vcpu);
+       if (exit_fastpath != EXIT_FASTPATH_EXIT_HANDLED)
+               kvm_x86_call(handle_exit_irqoff)(vcpu);
 
        if (vcpu->arch.guest_fpu.xfd_err)
                wrmsrq(MSR_IA32_XFD_ERR, 0);
