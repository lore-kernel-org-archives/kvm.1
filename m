Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2D311C37
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345459; cv=none; b=LC+JeMxAtCPsTZ0lnDxVqnkFX5Djw0mgVAAGx1zuM9tVV00aJlWAAkzIZWH2dSQcifbbQsufQrNLAwx0ousjhDUFACDeQCLTWuIoUmzdLekN3YhkJrDJXxs/UfFosnk6znhKCSTxEUNshrIM9jIAwpBhqNMAYCWe/8cAzgVp7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345459; c=relaxed/simple;
	bh=Zjn60P3a0MCfpYmnVXPwkjc1nebYDYCx2P+hOpnFyjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5IGa6Lp8Y8Lx03RF0mHoTpqBPEEbW8FqIpnRx3kmBtipogrxzDVYwtsEm9hDi92pR3J5dUiy6X491//R4lqydGlymii30nO7rkXUA8iLMVKdWt+/OST3q2AZ1gAXqHs+QRVWjYk12uYZRESYdsWp9z97xs742/S2fYyieGVsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Vdwkhvl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Vdwkhvl"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so832590a12.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345458; x=1773950258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vBcIi+K8mVx0/9gUKAput/MKyloCRnekYK1lqbAehg=;
        b=0Vdwkhvl7hDD8k8xnDdErblUj7xH5+sn+oS5Fpt5XHHa2/u3XzSykXSf360d0AtF42
         ydih+VYcuimkUGIuvpM2rrbTyRTbfZ+q4D7lLYVKV0f3IJ9WgeA+JGjBCBE+CFu4vHEq
         siht/0ZFtMKFmARiC0mIH622HNIWWquIVQi1/OozhXFOMDODsdK17LKW9WYnNPzIpc1W
         hFWLtBJWRmOkohezLwCvTsb9jEmY0wkgHTAH1QJLJ/IoIkvqEvQ7PaKflzOjY9hzm7vZ
         ObNlS8sJOuskzxgOl0mKroW9apBPVUqC0Cxo+XPua76U4F3YYogXsATcZH4T/79FWR6G
         Q0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345458; x=1773950258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vBcIi+K8mVx0/9gUKAput/MKyloCRnekYK1lqbAehg=;
        b=EnQ0VupYzITnzKFb97gOaESL083jp/i+6B1zP4MVL7cRI59ZVEYFezslAdnWHkQuDm
         bsgwJBz3Cm71oPlA5XGeQOyMkk3OGrryMDcmE+u2C2HPfITOdFVwsIrNYtqN0zrhDkvQ
         1YNxiZB0NQr4EERM/ZoOOta11ATgwVKYcVVXdwIfbcNsFp/QRS1eKZ0B1qUH7ej2aKUB
         omuL79ugv2kR2P4dozX1qY/oz1g8Xda3bm+nwI/Hd0FkPijKC/86WP8qCy8bl+NQeR9H
         yQlKNM1hy8qh2dsfkmL5xrROiU7hfmokr/BGGaYhmawzPxDfbELxaDPrI39DItm0g1lN
         C8lg==
X-Forwarded-Encrypted: i=1; AJvYcCXPUJrSHOTLR89cDJFPWFpAYIzOaRGiVqvz+2CI0n3wXkSMnpPUQDwgtrnEG6M/rftVpSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLrIed3flwaJIAmJu+YN9d5PUnpm9DZ2zV6BF/aXwpH5dO59l
	RyexE604PzoqB89gWvR8q+08vYlKXG80kbObzNgiFVEukvcn8t9ujuc8n2KRV1mYg4K70L+yknS
	CIgMjjg==
X-Received: from pfch18.prod.google.com ([2002:a05:6a00:1712:b0:829:9a65:4170])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e99:b0:827:2ee0:411f
 with SMTP id d2e1a72fcca58-82a196f6386mr650133b3a.4.1773345457771; Thu, 12
 Mar 2026 12:57:37 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:57:36 -0700
In-Reply-To: <20260303191509.1565629-5-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303191509.1565629-1-tycho@kernel.org> <20260303191509.1565629-5-tycho@kernel.org>
Message-ID: <abMasOy0A0OAwnJd@google.com>
Subject: Re: [PATCH 4/5] kvm/sev: mask off firmware unsupported vm types
From: Sean Christopherson <seanjc@google.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Shuah Khan <shuah@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: SEV:

On Tue, Mar 03, 2026, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> In some configurations not all VM types are supported by the firmware.
> Reflect this information in the supported_vm_types that KVM exports.
> 
> Link: https://lore.kernel.org/all/aZyLIWtffvEnmtYh@google.com/
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> ---
>  arch/x86/kvm/svm/sev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f941d48626d3..eeae39af63a9 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2976,6 +2976,8 @@ void __init sev_set_cpu_caps(void)
>  		supported_vm_types |= BIT(KVM_X86_SNP_VM);
>  	}
>  
> +	supported_vm_types &= sev_firmware_supported_vm_types();
> +
>  	kvm_caps.supported_vm_types |= supported_vm_types;

To save one whole line (two, counting whitespace!), and to guard against future
changes, I vote for:

	kvm_caps.supported_vm_types |= supported_vm_types &
				       sev_firmware_supported_vm_types();

or if parentheses would make it clearer:

	kvm_caps.supported_vm_types |= (supported_vm_types &
				        sev_firmware_supported_vm_types());

I spent a silly amount of time fiddling with the code to try and avoid the local
variable, and failed.
