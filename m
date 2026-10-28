Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207487;
	b=wYqWLDTxlRmlUE77YTocYRAc/MMOKIVjCuwIRTIXmCEzEi7krW5V8x7bMHxUiTxOCYhh
	 hODMNKy6O/SF99bhXLC/huR10+bJPWuVQdh+/uW3VWJha0Ry8MRkQr2aAsVtXGQOTArSH
	 tydpF4rP+aZ1BnGxk7S0Dl2Gh28BFLr7FVGBjdKC4LvdLoGeDX2DdF42WAHDSExYIe1Mo
	 eaj2NuKGNpf5xQidx/dFUdFg/r+jEy8UHwVQB5RxXYtNj7YoiFhwrgcVKc/eg2lbJunNw
	 gsUX/g8dfMhBdZdY/ibBeUVIh2igjCX/hjxn4da39F9sObZi8x4YnbLl3LHSYL/KApw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XhK75528MoHByOVxCJxhQ0foCg6UVn23+RKhIXHX2s4=;
	b=YCaHUW8FEXvOAsQ0gzkBh1Uz/CCH2DtwtQAOyIo0AvTM12x4F8HamHiEh122hwreXLgp
	 ZkdHhlBBkgCmWmMw3dBPY10JpViwJ4uSORUVZKivyhRa+GhmFe69TeC2CADAgVKEc8CWy
	 876yOOVVNq2CduZoMCv/K8Sp2HQw4E6ybp1YYXTVt4cPsdRS2TVHyKptRHWTjVN9ffHfr
	 EYWhGHXPMa4YMygZz3ZO822FxEA0b3Upx0tAHIsNQkur8oGA2YD16OSpxyzQU7oe8TfJJ
	 gi3K8PR0CgWzhhwGaq6YKyCsGwOU0ZD5aiUjRSofop+6qe9qF8U+pPXHbcomazxYe6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NpUGmY1M;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8422606A320
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8422606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NpUGmY1M
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e94f72fb9fso11233005ad.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793207486; x=1793812286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhK75528MoHByOVxCJxhQ0foCg6UVn23+RKhIXHX2s4=;
        b=NpUGmY1Mj16wVzNUXjjzxGVWnE7CVwg/f0IurxCXdvy3WLeJC87FBTDoJIIfVZLWla
         ND4hInzRx7k5ngq5qRJch9j0/smCslskhv9KSdpfaZVo0yBhiY6eBV2ejmt0D91fDBG9
         7uSUoTKxqUxNYXf/uwE8XiCRQi4kOJ1XrMzuvYaqU7fjJA+MxSPH+7wXYse3f7wf92tF
         OBN2bp5JQsNTvTDC47xyjvoDi9gCangQ1J5vgaa88IxInhn8kOKNRlmxLh0XLDvl4xFR
         ImUxYNRwzzTK108jU16R5KmwDReAjaU01hZQQwIPxamPbbyuyTMyDSQEwOygMmNbK+Jk
         pFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207486; x=1793812286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhK75528MoHByOVxCJxhQ0foCg6UVn23+RKhIXHX2s4=;
        b=D3avPMnsCmgxKkUpgaPnoZAe5KeA4G94cgBv+tR/+xVUdcVf9WtrG2D0N3/W1BXIWp
         /06SCJVSb5ESp8sqxOAjK09THz1GlrlzT5+FIUTJhwS7Ifbk0CK84AXP/v0yhQUhhpef
         rzYSv5aV/AZPLDbogPs7I1xPNxTs/kEh/E+qbpghMlS53WmkzZu90BrpU8rXp/gtkA0Y
         rqviHb6AXUzemfhkqJDHGP9Jd/7HAdWYt/kVdhFU67nOx7XA0d8M6ZY8UgL5t/v71NKP
         A+DsOYt3AixU9OD+Yn31EAl4op1vsvqqjE4+OMs/kjOkhn9pid5HfoNMOIE47HGGjIcC
         GAcw==
X-Forwarded-Encrypted: i=1; AKwUvBw3lGqCQJVKtF3wu71zk+q062x+GIWkcpbY9eFqA9enL5Au5TwU/sAj7PQ8pYHOthPiTKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPCD3AFF+cGURjZ0uQdM6PtksaP8Jev5aks6G+EG+Le5DlsEdW
	bVwx03a0Zrz2/CpwGNAJRetTIUQ7YWifLTp/T/OW2R/4Kpeyn8eR1qogaSCELTxg/qJ+7evMsZE
	ZzzFK+A==
X-Received: from plld11.prod.google.com ([2002:a17:902:728b:b0:2e9:5b68:4b7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c4:b0:2e5:dce7:5c43
 with SMTP id d9443c01a7336-2eb002427f7mr28403405ad.6.1793207485987; Wed, 28
 Oct 2026 10:11:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:11:25 -0700
In-Reply-To: <20261028132657.1416783-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028132657.1416783-1-jmattson@google.com>
Message-ID: <auIsvY_Z5Fbej9U8@google.com>
Subject: Re: [PATCH 1/2] KVM: nSVM: Set NMI_VECTOR in synthesized NMI exit_int_info
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

I'm mildly disappointed you didn't go with:

  KVM: nSVM: Really synthesize correct EXITINTINFO on vmexit

:-D

On Wed, Oct 28, 2026, Jim Mattson wrote:
> Include NMI_VECTOR (2) in the vector field when synthesizing exit_int_info
> for a pending injected NMI in nested_save_pending_event_to_vmcb12(),
> matching nested VMX's idt_vectoring_info_field synthesis and the APM.
> 
> Per AMD's APM (Vol. 2, "Intercepts During IDT Interrupt Delivery", Figure
> "EXITINTINFO" and Table "Guest Exception or Interrupt Types", and "Event
> Injection"), bits 7:0 of EXITINTINFO hold the 8-bit IDT vector of the
> interrupt or exception, and injected events are recorded in EXITINTINFO as
> though they had occurred normally in the guest.  Although hardware ignores
> EVENTINJ.VECTOR on VMRUN when TYPE is NMI, EXITINTINFO records vector 2
> (#NMI) if a #VMEXIT occurs during NMI delivery.
> 
> Commit 36e2e98363e6 ("KVM: nSVM: synthesize correct EXITINTINFO on vmexit")
> replaced the raw copy of vmcb02->control.exit_int_info (where hardware
> populates vector 2) with nested_vmcb_save_pending_event(), now
> nested_save_pending_event_to_vmcb12(), which sets only SVM_EVTINJ_VALID |
> SVM_EVTINJ_TYPE_NMI and leaves the vector field as 0.  As a result, L1
> hypervisors that check EXITINTINFO.VECTOR == 2 for NMIs (e.g. FreeBSD's
> bhyve) or inspect the vector field of exit_int_info observe an invalid
> vector 0 on nested #VMEXIT.
> 
> Fixes: 36e2e98363e6 ("KVM: nSVM: synthesize correct EXITINTINFO on vmexit")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d..9b62113f0cf6 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -673,7 +673,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
>  		}
>  
>  	} else if (vcpu->arch.nmi_injected) {
> -		exit_int_info = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
> +		exit_int_info = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI | NMI_VECTOR;
>  
>  	} else if (vcpu->arch.interrupt.injected) {
>  		nr = vcpu->arch.interrupt.nr;
> 
> base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
> -- 
> 2.56.0.307.g5fe7bd680c-goog
> 
