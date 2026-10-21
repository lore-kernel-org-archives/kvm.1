Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582978;
	b=MZWgyaQIvoICFun4TeBc5s30i1RoUk5q/FcUrj/d2Fd4slSXfC7G3zudhxmfZnZ2Ehn9
	 vaR/ff/MA1p38fKsFM/DnX6Il600b6Tx37rsCEXs/GLweiHcUSOdkLQu2vWpkcwSa9eWx
	 l12r3Rs1BOXczn/H3uu9/uBvHcx4tKmpDlluVkMOPoWvpTu5qpBJ+dpi1I4zdakKzooxu
	 /qMuJDLjhJj8o3NTB9viTeK8m/dTTMiGNvOxjQhjG74Q9N8PfIosuJLAPdGJUfyZTLq89
	 XpnLRdUj+DUvjCcupCwZF3z4hw6ynhxaZhGAD2DkZFWGVFJOML+ynvkLPNdK1WTXMaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=M87r41iuqvCpmvbuB7XwGxNLJEegfo1qBE6eCLf1DZI=;
	b=THLMjnoFgrb+lc39X92Tjtiqtcn5VdCXpPZ5TjHdh61gzpXVKgfJK9U65rdARdfB+udd
	 xf3TW/ZVsJrMZu4Ja2UXI+hykwAt/pGEttaSs2q/GlzosZuSsanlUcYLItxI5W+WOd95J
	 FaE3XsGnvCyqoWtUDxSu9YZr0F9F0qQ1Ke8sgizFqVBVTVlBXw30nvy1lUWYCTLBeB7M2
	 URlK0Y6m9RNxDiElP+Y/ejZOuDYNMIF87Kf93Eofiw0NZPjF63aXPLmL5Tg3rQ7mH8WL3
	 Ou57GbLafsTnEIF/9BEylbcsQrsS1rkQvEHnW2tDobufCxnw7rZ7dOPOTFd6JNv6fZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=gnw1PoyJ;
	arc=none smtp.remote-ip=129.187.255.137
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D731606A31A;
	Wed, 21 Oct 2026 11:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D731606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=gnw1PoyJ
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4j8nTS24t0zyTg;
	Wed, 21 Oct 2026 13:42:52 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=tu-postout21; t=1792582971; bh=M87r41iuqvCpmvbuB7XwGxNLJEegfo
	1qBE6eCLf1DZI=; b=gnw1PoyJGSPXwH70+ePOcZ3ddRaDNqjvd6Nc36OvlN8YsX
	wlAb1LQYCcJwCq4dDIYLxtbN6Kzja6MaZQgiN2WiLV+N2VUSrYGj66p1zLBSHtao
	Q0+XQeTKaGH/kFibxcgrKakLWvcQ5LjBWrzqRo4wyM4Fxpiqu8Lll1kdL5NtiXXD
	/pW2TlGqq8OW9H7b5sWZ+PafgdY4qgMq1KDtWBW4JGkD2UIatuj57ZHHmxTytT0P
	tC/e8BC93ltaVn4XDC/q4u38e/XA06cDIxNcxfJkdfUWLWmfuw9Ao0DemK84Kl/W
	449YC1S5UPkffUnxXsvu6l+9hitgU91qwnDnV0Uw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id nFk3514vqUJs; Wed, 21 Oct 2026 13:42:51 +0200 (CEST)
Received: from [IPV6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614] (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4j8nTR4MLHzyVF;
	Wed, 21 Oct 2026 13:42:51 +0200 (CEST)
Message-ID: <17ae73e9-c460-4ffc-9fc0-5fe2e8e1a08a@tum.de>
Date: Wed, 21 Oct 2026 13:42:51 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyper-v: Don't WARN on VM-Enter if eVMCS sees
 VMFUNC[63:32] != 0
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>
References: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
 <atfxm7Tj7nYB_6Kr@google.com>
Content-Language: en-US
From: Manuel Andreas <manuel.andreas@tum.de>
Autocrypt: addr=manuel.andreas@tum.de; keydata=
 xjMEY9Zx/RYJKwYBBAHaRw8BAQdALWzRzW9a74DX4l6i8VzXGvv72Vz0qfvj9s7bjBD905nN
 Jk1hbnVlbCBBbmRyZWFzIDxtYW51ZWwuYW5kcmVhc0B0dW0uZGU+wokEExYIADEWIQQuSfNX
 11QV6exAUmOqZGwY4LuingUCY9Zx/QIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEKpkbBjgu6Ke
 McQBAPyP530S365I50I5rM2XjH5Hr9YcUQATD5dusZJMDgejAP9T/wUurwQSuRfm1rK8cNcf
 w4wP3+PLvL+J+kuVku93CM44BGPWcf0SCisGAQQBl1UBBQEBB0AmCAf31tLBD5tvtdZ0XX1B
 yGLUAxhgmFskGyPhY8wOKQMBCAfCeAQYFggAIBYhBC5J81fXVBXp7EBSY6pkbBjgu6KeBQJj
 1nH9AhsMAAoJEKpkbBjgu6Kej6YA/RvJdXMjsD5csifolLw53KX0/ElM22SvaGym1+KiiVND
 AQDy+y+bCXI+J713/AwLBsDxTEXmP7Cp49ZqbAu83NnpBQ==
In-Reply-To: <atfxm7Tj7nYB_6Kr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 00:56, Sean Christopherson wrote:
> I think the WARN is correct, this code is broken.  Unless I'm missing some eVMCS
> magic/quirk, this, and the secondary controls check, should be conditioned on the
> field actually being used.
> 
> This, over two patches?
> 
> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index fa41d036acd4..a1daf8f2ec5a 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -169,7 +169,8 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>  					       vmcs12->cpu_based_vm_exec_control)))
>  		return -EINVAL;
>  
> -	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
> +	if (nested_cpu_has(vmcs12, CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) &&
> +	    CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
>  					       vmcs12->secondary_vm_exec_control)))
>  		return -EINVAL;
>  
> @@ -186,11 +187,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>  	 * controls in bits 63:32, i.e. dropping those bits on the consistency
>  	 * check is intentional.
>  	 */
> -	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
> -		return -EINVAL;
> -
> -	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
> -					       vmcs12->vm_function_control)))
> +	if (nested_cpu_has_vmfunc(vmcs12) &&
> +	    (WARN_ON_ONCE(vmcs12->vm_function_control >> 32) ||
> +	     CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
> +						vmcs12->vm_function_control))))
>  		return -EINVAL;
>  
>  	return 0;
> 
> 
Looks sane to me. However, I still don't see a reason for this being a
WARN at all, what exactly is the intended signal here?

Best,
Manuel
