Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4433955FA
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122419; cv=none; b=eA/N0nkQ5oPlcDz05xvmEGJAo7XIagUNig9iBur+Uptaudo5o3dZw2HlU7b4WdmtcbznJA0rbqAP2xODKzPO0gciQ9wm01wpwMpf7vqxYDRlEe4I4Oy6TKdKMyLGRvphrp37HuwCyXxsuSObNhcJRjrmusZKMDZMgmioQIPbjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122419; c=relaxed/simple;
	bh=lku2N8fUyfDXpjMzfVjWbeC/nH+eWEUefbnvWuzIt8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCIg2vZhXN+ZOUVvwmVATczhBUz6JD7/YuAwMYuo54+FFX8BGqdO1FfsozjIjSKcyNeuZdpVQbSE3g5mhqF33sfM0DE4uZ7tD8Hz3EN5rzYXEKRXnaGhDQjbuAP11pyMhU/dzTykMqgkB8dgYailzKBZcKAxKlWyc6vzQVUMq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKpkTYpk; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKpkTYpk"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso3386841a91.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122417; x=1786727217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVN3mxHnahAdyvwIzzw2hf3DbBjSxNQ7ddlcDaqj3p0=;
        b=bKpkTYpk57S4ZNiKjNdgbWoeSOZZmDcPQnZjB6JW0+rvxFF9ZSXZyfWdho1pkd+zdn
         TxtmpiY7wWlVc1zdk+AIOKxMOykZAWDUH6deaK1U0SRJZFwtuwulnX1ss6qXNVwPoL66
         rpLoi2bH/8qeyl1IJOu1hZ10C2qfUTBRTRwSx26074bvFYTc302wOKxDzSi+HHdNnIfG
         1h/jxWz8+JFy3GESQQV/WAR3mzZKJdaptOYUTR4js1dVUctn2OZ6fW10XYDqWsrxRNvJ
         BpHBIYCZEXzsjq4gi3b0dDpuSywEq/7bGNBT7k1qrG3KZrw1zmwHQslc977/pnxzMPRg
         isfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122417; x=1786727217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVN3mxHnahAdyvwIzzw2hf3DbBjSxNQ7ddlcDaqj3p0=;
        b=h9Lb3oU1c9dDPp9tm1UgodMURoDS3UVEykg++PaGBv+jNMqqAcgxN87eNhP0p2u1sx
         /e/06KjT0gWrsgVkLg9vdjpamX07b5+5OkQbWdvmnAlGE9Yc7/KE8wPw+Z0egV4zipko
         1Gf5hIA4QIFS8ndzFVGjsvc8U1FDrgPXGcyCdU+I0+MjKD3VgbINi6yCTS9bP+kVsOhd
         ua+zQq98RV6KPUZ1THeL1TXWvfkDTWCU0MnJcvE00swW+6anM/CCF9qOokSq/cQuW38g
         Qh8QmQwMBYleo0D++3kXoP8HgHj9FVYnhrTQecn/a/suzZjKOIJ4s8JnS8ZE2VfIAKjk
         M2xQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKfL+Jv4mB0kd01EHIxoqoaeVndGF4Lhu5AcXcRXTC/ePheJQFa7T91jCXZIOvPB8REYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3alVv/TB+Ol7JsBALZfLeL4dk9kM8J/LFEwrpo2sE5TleFBLn
	p4yvT4r6qRfhQkfp/kTS8dUKx7trM2uTfLG/MkjXlzXhDzn35yz0S7DCOV2y52KL7egPupOZZsX
	az4Y5LA==
X-Received: from pjbbb8.prod.google.com ([2002:a17:90b:88:b0:38f:dee9:ffd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e42:b0:382:1a6f:ba3b
 with SMTP id 98e67ed59e1d1-3909d7d2f85mr12577958a91.5.1786122416773; Fri, 07
 Aug 2026 10:06:56 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:06:56 -0700
In-Reply-To: <20260807135327.2629594-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com>
Message-ID: <anYQsMnpS2kpYoqA@google.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Yosry

On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> - disable use of INVLPGA when NPT is enabled, because it doesn't seem
>   to flush TLBs correctly

...

> Paolo Bonzini (3):
>       KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled

Why did this get rushed in?  There was quite a bit of discussion, both on the
code itself[1][2] and on the assessment that this appears to be hardware issue[3].
IMO, neither of those discussions was resolved enough to merge the patch as-is.

I can appreciate wanting to get a fix into stable ASAP, but we could have gone
with a *much* simpler fix for stable@.  The bulk of this change is a performance
optimization masquerading as a bug fix, and I'm not convinced it's actually
optimizing anything meaningful, because SVM only queues the TLB flush, and that
is super cheap.  E.g. the "we don't know why this is failing, let's smack it with
a hammer" patch could have been:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3057ca7051db..58bc4a1cb7a4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4237,7 +4237,15 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 {
        struct vcpu_svm *svm = to_svm(vcpu);
 
-       invlpga(gva, svm->vmcb->control.asid);
+       if (!npt_enabled) {
+               invlpga(gva, svm->vmcb->control.asid);
+               return;
+       }
+
+       if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
+               svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+       else
+               svm->current_vmcb->asid_generation--;
 }
 
 static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)

I don't care _that_ much about the code itself, though I still think the out-param
is all kinds of ugly.  What frustrates me most is completely ignoring the processes
that everyone else is trying quite hard to follow.  I'm a-ok with getting overruled
on jugdment calls and matters of taste, but I'm not at all ok with doing so silently
and without what I would consider an honest attempt to address review feedback.

[1] https://lore.kernel.org/all/amPo-XdhFGIZquES@google.com
[2] https://lore.kernel.org/all/CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com
[3] https://lore.kernel.org/all/CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com
