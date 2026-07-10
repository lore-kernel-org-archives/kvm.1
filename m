Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BF13AF2
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642307; cv=pass; b=oDk2CjS2K9EMPOP8WYPsyHQUhUMYh9MZpWHtVvcu3UKAilLKruApbTnrkoA7OF6pp/ds7fVNgQtsvGiJOjvyim/a70fzvMbRNPPcVUUjBiSIDjGIhAPCDsmuFM4HObFLGFfCyHH0sm7Xu8VF/gcKBBx3h8aDD3ivNyJ8R6LAGtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642307; c=relaxed/simple;
	bh=HvcVX71qd0aT4O8iPeOvYVlQuXVDqr0lXWE9nyqKcF0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX9sT4RqJ0ReSj/xPSj42mn2pPfDPEhsyCdewbsjeuuBqPdB/jRN3iG3yQOnUZW0IB9EZl/EJVg+03931NOeyXr2GTcmG/eAfdphQ97mr+dgq0d8D7wx3S2M/0fbT8tGuFJzRK/Hb+a/C9gyduzd60hroJlnSpvDFzNCZ3JFzyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qosq6jRV; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qosq6jRV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so272657a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783642306; cv=none;
        d=google.com; s=arc-20260327;
        b=IGDN7JfEzSi6x1avhnaoZ94TOo4tRzRreHBttiFTuJI4GSrH5pulUU3q9zPxl9A+L3
         IjyqBItp0+A05lTz+V4qGHlLxaAulCuAxwbAehsPoz1HQXcdE1B5gwcbqJq7zAKwGYLr
         +tnFy2oAiCVpFeGZMUcphHPrFNewrBWmFVYOzArY7cY0yKV/ccaMKWkcS+WmBbSUgd0d
         ZJBfj3QdVPXpbtpR+5qMEFAkxNzz3KPUghMiHWUpcH6uT1cZHl0ciaDD6v9lYsWOPQ+Y
         z1FrIluVtIgxfuwBcCfrxMAUUng1XuS6erO2JOoGWEcV8d8KVDSk/xrqe+Vdrk23WaSg
         9itA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=sHuYg+0GXW+krIUQaLbR0V6D0305UeWNfa8oDSTZF+U=;
        fh=wfw0hEOlkq3EUE6azXKmcRqOiVR9wJZgs69aE8Vkuuc=;
        b=TofEKUvm6NtJSikMGlnikQwQQP/JkIqugxu8T4PGE5fvH5Qic1CQoHPRbrnPNlyU9B
         oLhHIUyViVYPwKab5WRf5+4JnRjyITMgOyDKgHwL0381hMIkYBGOAn2Atwuv+YF8PSbV
         kLn4N2usDya62aajklG4jNGmQJT6yjZ6Nhqkhq8vOwWd0pVJURsm6XCg1ioOqELiuR0G
         pc4VSV/y32d9nLl7GZHU1z5BFxAxTV9mrKfjLJJgujdvii4550Eh5Pv8kI7eTKRR6xpu
         F1WXWMyDr3t/fWd6UMxBZuIggAJ2JYH777WpS95ilWKJxRWXIbFCwuQ7TSqFMpafJ6FA
         Ucng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783642306; x=1784247106; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHuYg+0GXW+krIUQaLbR0V6D0305UeWNfa8oDSTZF+U=;
        b=qosq6jRV7r4kMT9S/qoi7x9QIlhKhlqHWIjsJ2KJ+mCiD4vxp4ytYfBMTGypD9XaTR
         Cu83WU3JePQ44NGCaQDDN8Z3IDBj5YnuBtvupXlsx37Od0QB8dHeSQTq9B1507UrBP1y
         9/G020ufeIoRTigeJM8rQsSS/GH9Xbby69B67hovzN6MrZahgOzkj+kxTBFAL/5kaaRG
         E32teazs5Cy3vo0+Obis6bW49BUkEZP9DFrkSDMgSM3x2uwXw5XBr713UtGrUKAmSwqM
         PO2Va41YnWprhlGpUpUsevWOBmScbkFC26Qomok/9W7H4Mc3g0HVnUT34JskOQy2lEpA
         HN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642306; x=1784247106;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHuYg+0GXW+krIUQaLbR0V6D0305UeWNfa8oDSTZF+U=;
        b=q8ck9hi3lVIUPvBYXZsopamNcy7dlAyvq22HpnRqL5URpbog+3KvFfSPgzBoaWeJBr
         a/MgYVuk2iU2KDkjyUZ6CwaY+a+XLZGbFUlGJk8C81OG085QSu45kQVkd6X3F228Z5xe
         vouuL1juA8FQiU85odFHMKzOStc0aoZe7wjU63X+6g+C2qfq9dlHCMtH7DokbyvKU2qL
         bf+YrE5mlq8ZN1mj5ytVV8u0oc+2wxlZvM3uStsmAu8QKAt6UDwHKFN06UlduxTorJ4n
         L+Sgp/k7+awDXx/IXsLl06nvY82L6qNEoKkUYks3k4Pgk1tkGN53/3utXlqndVfjQvVx
         OUmQ==
X-Gm-Message-State: AOJu0YwlEdgpPiw99jcw68b3JsrLyG/AmdgmR27uOn3HiD6Xioo+0MH/
	KbwqC8NGmYkdkg02leiAQWaFIyV/bf69gf3jY+Zd9pEjg7C1IJyNwyUF7kYaF5gu0wHTxNrmwH6
	5BNrJ0xMYadvrRznHVhkU9ePBgWl8JSWs2s5hqQH3
X-Gm-Gg: AfdE7clAQYpJodiVnogs9QUjT8nr7xH7buZBAiLqhy2au5mkg5xo0/LM3ddjKlKiB4c
	ea2Eq5UrJUmq9nhBKTGri0LTLuixVWwHY1a/foD44fTcUd34TNPXZyUJ5c1O8bP6Pg6GsAbABoQ
	blrcVVH4sTFQIM3bEKh7bsi6ALqqX/e//RCmfZQ40KGMwcqRLTHt0zoeqnVONsFbgkFWfg21lm2
	7Q00j1qnL0HVXRwRLyf3Jouk5yogMyESh01+MPVp0kUwZDwEUCfF1nb3Ugv7TWewQKmSKAksZRO
	hUA/LFsQ6+7RFZ6Rq7l6E+TOHJOdPGp2CmCXGSE5bs2O3BUlzqVaIHcwdNo=
X-Received: by 2002:a05:6a20:6a06:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3c0bcbe9525mr11031548637.11.1783642305105; Thu, 09 Jul 2026
 17:11:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:11:44 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:11:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709204948.1988414-5-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:11:44 -0700
X-Gm-Features: AVVi8Cfpb7GKlqo1aZAoAyzq5pKTs_t2820oRkUI0bv7My7nMjf6e9UsTLQAzUQ
Message-ID: <CAEvNRgFfRe+1LDVR+YqWcQ=ho4gPz2Ac9jU0Z55yU592b3AUog@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and
 only if CONFIG_KVM_AMD_SEV=y
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Wire up the SEV-SNP guest_memfd kvm_x86_ops hooks if and only if SEV is
> actually enabled, and drop the now-unnecessary stubs.  Leaving the hooks
> NULL allows the static call infrastructure to elide the CALL+RET, and more
> importantly, referencing the hooks if and only if SEV support is enabled
> will allow conditionally definining the hooks using their corresponding
> HAVE_KVM_ARCH_GMEM_XXX Kconfig.
>
> No functional change intended.
>
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c |  8 ++++----
>  arch/x86/kvm/svm/svm.h | 10 ----------
>  2 files changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..79c818d91dda 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5448,6 +5448,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>
>  	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
>  	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
> +
> +	.gmem_prepare = sev_gmem_prepare,

Here .gmem_prepare assignment is gated on CONFIG_KVM_AMD_SEV but later
the definition of .gmem_prepare is gated on
CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE.

CONFIG_KVM_AMD_SEV selects CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE, but I
wonder if there's a chance due to config disconnects this will cause
compilation issues? Like .gmem_prepare will get assigned but it was not
declared? Or is that actually intentional?

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +	.gmem_invalidate = sev_gmem_invalidate,
> +	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
>  #endif
>  	.check_emulate_instruction = svm_check_emulate_instruction,
>
> @@ -5459,10 +5463,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
>  	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
>  	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
> -
> -	.gmem_prepare = sev_gmem_prepare,
> -	.gmem_invalidate = sev_gmem_invalidate,
> -	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
>  };
>
>  /*
>
> [...snip...]
>
