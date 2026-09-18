Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304550B8B9
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746963; cv=none; b=EOdGSJrc21+LkRniFE0NpD3uMcSOKvyBqSwfEz4lcqLsjcg2TFX1JB2nU4RwCLHx0K9sdGWQrYer0Nk0e19MRJWRRGHfhATgwOewXTcqIDLJ9iI4SuIy0jzXpS8lcRRNWz5XtkspWdrZ0k3ZicBXwvWPrNAhcDo1khcaZYbONqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746963; c=relaxed/simple;
	bh=VzBIg2DX36nG7X+/n7IlCo2fJMZUGrggpdgEwOAV7I0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cqXk14XAvG4dEhRS858SEyjMaAYdzC24w9x87L7Qg9aLc5Zw5AbCQ5vaZG/ve88T2xfEKVVr0l0QjBtfi+cd0Nj6txmmI2IRIs09QY8z0KzNH10jrEjd/xO14pmKL+phJ0n6KRHz+DGSRHljy1JWGc+OeMlQrSYqaWcHR1DBQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2hMNglS; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2hMNglS"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1234074a91.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789746961; x=1790351761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBkctlRBevMkXW3iFcvrG/AH6FpsnkeJtwK+1UWTkNM=;
        b=p2hMNglSnFx7HTcQKFe5jAbvd0RDevERIaZMchDjV3AmlsWBJJu/N2yL0Skxy8KB26
         ei2XPZi9h+A99UmHIPYtRc+/W5P2ADr9G0QzLFoux5P0wEqWs8aX1ww3JoREuFV8p8zl
         yKlOp+OW3qGNf6rQK4n079oV8pV/HuuznElZxq0atQTA8o2sXmitrRzCShjRGZ+0dEhH
         TI3odKSDrvLNrXkDvm2waaNNnrGd4H4t6jVsiaWbK9dtanC/xeWDDk79xXHImYOqWYyv
         WpIiJV2o9bYhDFMu88uyyXuRUvplX6ZnVZmwMrTRGSpUeCnVRnGp2jDXXMuhhS3nAk1n
         7GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746961; x=1790351761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBkctlRBevMkXW3iFcvrG/AH6FpsnkeJtwK+1UWTkNM=;
        b=R+TqYS/4XC52kBQZ0OJcos+7rToOz56CflkhSaPrFDWc4EQ32PAVoEq/f7RiLYmChF
         g/qYpT73qqunXSMW9V1IkgOdM3+/J7f3m+152s22Xfd/Fb7dEMMAbuBKXByzdbRMGUyc
         70A6cfV8eHttT6B3dIvauhRAXpKhWdgX8qksKbMjBm9OR4UjnS/odYjl0mj0JzpW9WqT
         m5owpqVMG/IItvX1T9AzqrSC/xqwCHAYGZzzjvhgastARx1hYz9nPBhOo7foTgK48rKf
         fPQnZKJ1jN+rk7e9mUaG0JywLc0q927FhsWD7Gueh3w0h5LhbknAU0UbIDqOYePKI0Nq
         dLuQ==
X-Forwarded-Encrypted: i=1; AKwUvByjsrfD4vhSoqouBVpqWN+PJkmStZM8I3WW+BtOoRtwLpuZ0ixJvXR32Jb/gInEwmQdU9M=@vger.kernel.org
X-Gm-Message-State: AFuF++nkMnOziwZkxL8NuowwLGcaVnJ1s9+Y1Wqx8NWinR/GGfZZzGRD
	Jjqqfvf4T66V6KkT+gdXZgMK416+VrrrUoyrk5uB7J9JDPWh7ChKHwXFJYdTXYh0ErT+NZFz3bC
	azU3HZA==
X-Received: from pjbpm7.prod.google.com ([2002:a17:90b:3c47:b0:39e:64b2:d2e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cc:b0:39d:e43c:5a0d
 with SMTP id 98e67ed59e1d1-39e54ce0f4cmr7161460a91.8.1789746961199; Fri, 18
 Sep 2026 08:56:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:56:00 -0700
In-Reply-To: <20260918154530.4129698-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com>
Message-ID: <aq1fEBajndF8qRV-@google.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikunj A Dadhania <nikunj@amd.com>, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Jim Mattson wrote:
> Reject guest writes to EFER (and nested VMRUN with VMCB12 EFER) that set
> EFER.LMSLE when CPUID.80000008H:EBX.EferLmsleUnsupported[bit 20] is set
> in the guest's CPUID.
> 
> Commit c53c632592a4 ("KVM: SVM: Disallow EFER.LMSLE when not supported by
> hardware") prevented EFER.LMSLE from being enabled in supported_efer_bits
> on hosts that set EferLmsleUnsupported, but missed checking the guest
> CPUID capability in __kvm_valid_efer(). As a result, on a host that
> supports EFER.LMSLE (e.g. Rome), a guest whose userspace VMM sets
> EferLmsleUnsupported in guest CPUID (e.g. for migration compatibility
> with Milan, Genoa, or Turin) can still set EFER.LMSLE without triggering
> a #GP.
> 
> Fixes: c53c632592a4 ("KVM: SVM: Disallow EFER.LMSLE when not supported by hardware")
> Assisted-by: LLM
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/msrs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index dd3bb04878ca..6dbaf063cc8d 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -598,8 +598,11 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
>  		return false;
>  
> -	return true;
> +	if (efer & EFER_LMSLE &&
> +	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
> +		return false;
>  
> +	return true;

In case anyone else was wondering, this is NOT whitespace damage, the "movement"
of the "return true" is due to deleting a trailing spurious newline, e.g. my
configuration of diff yeilds:

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..6dbaf063cc8d 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -598,8 +598,11 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
 		return false;
 
+	if (efer & EFER_LMSLE &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
+		return false;
+
 	return true;
-
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
