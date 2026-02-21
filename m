Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF423195F5
	for <kvm@vger.kernel.org>; Sat, 21 Feb 2026 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771637074; cv=none; b=YMxIJ9S7+DlId5Yz/JOcuwN0is5rPoMB4JpO667yaNsMet76/y9bFSPqkfIAdvs5kuW/fJKVPa1UbBX6ltNyEtsxfbWRA2Y10B1XxMzV9aJWAJkY2UOvWcmBVnqLlmpMtLPiAr935rasgDsJLv53picLj9dCzVRk9A/O0755eDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771637074; c=relaxed/simple;
	bh=dyyolq6QYL1vx+owLx0Z7PhVaQxT9oCUBf55Xme4PXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3xcpS9/lkdlrkjkbNMAIuNzfrh/82yeaMI1fkBWK3Dss8UjiFjxaEhE1yNCPTx8bA3yQ20qtAlNFceOuon2YedkuWP6jSviVv6Noz+kMvFnWhjSxDFko7pV7gQwBhSq6Z2B11cOBBNdhBR53Gj0cMUYsOo3UQpJP9omaMhEtC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsTFeu9c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsTFeu9c"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso17819914a91.1
        for <kvm@vger.kernel.org>; Fri, 20 Feb 2026 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771637072; x=1772241872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7vmKD3Um12JS7qpp2L+ZgiUNaYnAvcQIOGCUjb5bcA=;
        b=ZsTFeu9cjwf+xjqFsvnpXksCrNIUw17qdqG11hYvI88cvjycrUnftzlIdlpBWtr4BC
         QgewIo9FCvl19h3GJfZr/gK5a1ZVhUfH551khgR+xmhCWo9AXi/iKRwDJX5BmXFI8dwO
         kCsccSf3Gcn86zD7IxzyUereY+pNTSh4qnb4Oc0gn4ugF9Tpl2WinDTcrk44phiWDJSA
         Axs8gQySzFJGvL3DNcy3hEJhMS/nSxuwqnGC408euttvMqaqtUVShID1QLo20NPl9U+I
         Pn8PVlhh9RlK9zSYPT687dWd58RApXGWl8RflA8YTnqntbBY+CmbmeZPQVeqO9k3vNJE
         O+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771637072; x=1772241872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7vmKD3Um12JS7qpp2L+ZgiUNaYnAvcQIOGCUjb5bcA=;
        b=Y6klb9hM4/sj7sFY7p2BeKyITGVd1u1WsOJ2agf99ToUDeVvJdKEWXtNU8nN4/vgKL
         zigg8/ZpjTXdeuXTIE2ZKBDtSHElGqIXO8Ufi1ATyPYvu/5DJOggFNDSK3p9KAGT3727
         UYiWfiPtzJPk/OiUysZKzl+5r3gWvdNp4uZNjZxuvUl6fVCAvr8A7UJ6XbYjuM41Zfrm
         xnpZ3ElmZ2h6P/NTmw0D0Sy2apvxSTrwrYl/jU8BtcJSeaXgfkrU+oT2e71ajCTGNh7o
         o6fPm2qm4WoCc6AyhlqmdkraKtOq9q7m1pC9kWbVL+p8k23oM9E2Hz9mcAXhSqCm1Qia
         AecA==
X-Forwarded-Encrypted: i=1; AJvYcCUboh/uY7gxs+5GbsTawFi44VRHGdzicVBcjgPuQYbCdAq8ph+O/4iy6ws1AY1ALOx8zHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRNfNkyRlP9d1MeMGJDf9X9RNwW7aRpUE6NfB/DmgJ2x2iZuv
	nEIWCu2C026L7Oh5fOna/P61HyxOBFeA+CW6GeyjhtYwIdesb9yh00gXjqd+1xyYucF3UuVoEjS
	N433Akw==
X-Received: from pjbnh21.prod.google.com ([2002:a17:90b:3655:b0:354:e874:cf5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d43:b0:354:a780:6667
 with SMTP id 98e67ed59e1d1-358ae7e9168mr1361436a91.3.1771637072461; Fri, 20
 Feb 2026 17:24:32 -0800 (PST)
Date: Fri, 20 Feb 2026 17:24:30 -0800
In-Reply-To: <20260206190851.860662-25-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev> <20260206190851.860662-25-yosry.ahmed@linux.dev>
Message-ID: <aZkJTmuIoEwNPnML@google.com>
Subject: Re: [PATCH v5 24/26] KVM: nSVM: Restrict mapping VMCB12 on nested VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b1f3e9df2cd5..0a7bb01f5404 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1102,26 +1102,56 @@ static void __nested_svm_vmexit(struct vcpu_svm *svm, struct vmcb *vmcb12)
>  		kvm_queue_exception(vcpu, DB_VECTOR);
>  }
>  
> -static void nested_svm_vmrun_error_vmexit(struct kvm_vcpu *vcpu, struct vmcb *vmcb12)
> +static void nested_svm_vmrun_error_vmexit(struct kvm_vcpu *vcpu, u64 vmcb12_gpa)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct kvm_host_map map;
> +	struct vmcb *vmcb12;
> +	int r;
>  
>  	WARN_ON_ONCE(svm->vmcb == svm->nested.vmcb02.ptr);
>  
>  	leave_guest_mode(vcpu);
>  
> +	r = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
> +	if (r) {

Drop the 'r' since KVM doesn't do anything with it, i.e.

	if (kvm_vcpu_map(...)) {
		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
		return;
	}

(I can do this when applying).

> +		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> +		return;
> +	}
