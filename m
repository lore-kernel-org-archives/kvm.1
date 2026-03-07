Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD91227565
	for <kvm@vger.kernel.org>; Sat,  7 Mar 2026 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849235; cv=none; b=lBY7akhoRfc7BZW58exhoH48tdY3420/9FJ+B5nQYaQ6Mpv4kCjiLpVCdw/KgK5ZaRy0aRw11RQrJGoLanMR7PaIif4RODZUMaX4vB36AHWOK5MX7CO4t0/G151aOUY5oOUjVlDZrbfWeIzR4MWipiKxRH1mC6SdHU8YNBKq5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849235; c=relaxed/simple;
	bh=zl3C3R9LMNZuD8fFBXpLcvHjwMV/uqnWTf/1hBT8wsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hZVLUaHOKArgiclEh2NdKXGzEuAVPK9eycpow6FbEbCRgEPfKP8V4zWQTFTq+gHFp7AXMkk2CRdUFR5O75cWnMTsNkLV36UpDRgq8r7zvvjMmBE32vHx1XXEsvPLncZy6Z7hAvlfrbwSyok1XgsBqWQ2eD9tJRValDrcvsGYeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwxBtjP+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwxBtjP+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3f446ccfso66715425ad.2
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 18:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772849233; x=1773454033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+UoRrpddV2Fy8n72X0PUQuiXrofIoHgnww81/fG+ME=;
        b=XwxBtjP+3acTVw1qfu1vBIGSen5vXPQ70icSX/Wfxi4Rw8jo8gyuXWXA+d/E4hZZ5i
         CTqZTMaa7n2CsNEpp9ZaiF4kK1RYtaTRYiubXa9aUHpx5BZJ4fdmAReQ256Hyv/hF+/m
         uxSrWC2OSd3M647XXb2pJ11duCMJIysXWVMpUqf8o/CuTt57nyVHGsFIdGT7o9aGkKxu
         mt/qpkx5+g7u79E9AqX+aIEZxf6ID7jgWs61g8SfZdI61WNlCcOOgd3v/qy09EFKEcWY
         2fukQqOuvH2W0GYllUnv9icP3LAr/bhPw/Jh/cLOLa+dkk8XatkB0jaoAwIpHDU2qhyy
         pw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772849233; x=1773454033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+UoRrpddV2Fy8n72X0PUQuiXrofIoHgnww81/fG+ME=;
        b=SkPGjPXP4FS5ps7QSCw/2VF0oYmetWUFvGrL8wnomWxQAq5wBPTvaebqVhtKzq3Ohj
         6E3ZKHTCqCGSRErXXtr2xq4MYerqckCnA0a3PgMu3/eN8HkDJSEMcA65mqQIG33UwDR/
         jMVnTLA+E6d7mxq4MG/ur2ty1e9SRpmnsWR/Ziyc2yzh4xi0VnwlPLRRrcQsFhJ/Txuv
         zFdjczdkUXKwVeeup5mgeQQfRstui3V1zoybe/gW0Yg3mh7FYWjt+SRoqjiF+L/uYoKm
         6yVuzg3sBqUUuAS26/8DZh/6cwONpMeycQMB0xojx4PNpju585dvTkpOSc1MKnEO5EXw
         gMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3a4vyPH8HfaH1sdOmjJ8jsxYe5J7EfgWHrD2+QZSPkji+exCk1jgxJWh+JYKC48inJfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUTSGDwCX97os5vDshHQCnM8mY4RALQtr5qwxJR4edMQQtLnp
	QBO+LFwtSPdAYz8bA8OT2xZuroWgRzY96EO1vG67c77ZnaHae7kHqGzSRDaet3KR1q186Mf+Jzn
	x1YhOwA==
X-Received: from plcp17.prod.google.com ([2002:a17:902:e351:b0:2ae:5344:9e72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c406:b0:2a9:484c:ff2f
 with SMTP id d9443c01a7336-2ae823a1df5mr41713865ad.23.1772849232601; Fri, 06
 Mar 2026 18:07:12 -0800 (PST)
Date: Fri, 6 Mar 2026 18:07:11 -0800
In-Reply-To: <20251026201911.505204-14-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026201911.505204-1-xin@zytor.com> <20251026201911.505204-14-xin@zytor.com>
Message-ID: <aauIT-6fK5Jl2Ig6@google.com>
Subject: Re: [PATCH v9 13/22] KVM: VMX: Virtualize FRED nested exception tracking
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com, chao.gao@intel.com, 
	hch@infradead.org, sohil.mehta@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 26, 2025, Xin Li (Intel) wrote:
>  arch/x86/include/asm/kvm_host.h |  4 +++-
>  arch/x86/include/asm/vmx.h      |  5 ++++-
>  arch/x86/kvm/svm/svm.c          |  2 +-
>  arch/x86/kvm/vmx/vmx.c          |  6 +++++-
>  arch/x86/kvm/x86.c              | 13 ++++++++++++-
>  arch/x86/kvm/x86.h              |  1 +
>  6 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 550a8716a227..3b6dadf368eb 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -760,6 +760,7 @@ struct kvm_queued_exception {
>  	u32 error_code;
>  	unsigned long payload;
>  	bool has_payload;
> +	bool nested;
>  	u64 event_data;
>  };
>  
> @@ -2231,7 +2232,8 @@ void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
>  void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
>  void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
>  void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
> -			   bool has_error_code, u32 error_code, u64 event_data);
> +			   bool has_error_code, u32 error_code, bool nested,

I think we should pick a different name, as both VMX and SVM declare "nested" as
a global boolean.  I.e. this creates some nasty variable shadowing.

Maybe is_nested?
