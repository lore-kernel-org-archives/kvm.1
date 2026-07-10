Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03B26296
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642711; cv=pass; b=NCLC0CuHxYy+SZ3P/uKzgFyjouH4HJ2mMYX4nqZuNaZJsjilP6XnDAP5APjL2jUgUVKLc7/srOedkfg10corWMqGh2OvYhNxO7rsBwkuMbgs2SzLGrdQAwiicqPmlJKNaBSQQvGvPmt8voIW0U9Xk6OZu57u6vePnd80PjjXtlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642711; c=relaxed/simple;
	bh=Az1f414sx0QnHwPSWlWHpHqwlLXInclSBLfw4bqKWL4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScitAg1FMZVFLdKZEvaliO8H3CsBu95bnARBm5atZQscRTgb41fnRTrDVJfPb8SwbqhmWBD5Xoa0GFEEU8mcNs8hfXtbv5Gv7NJRnsVRgbMTqTdcJEBeYZpjtqVP2xRJfKh/W2YzHb1REak6mv2fNaiDHafs2eVj0SSDRQc4Lik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sc/pdAzQ; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sc/pdAzQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so338174a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783642710; cv=none;
        d=google.com; s=arc-20260327;
        b=GxC5OKx5Ct30cZpu+okZHKcijQClD3g0/tvdzgw2BpoAhW8ilqRkgQQ8tBOHPlSzs+
         kAQSATymnc3oPyp7n+PW3OH26hGH5cPa8peaqULbLCAtZeVZVKJsXv3zffiHD9k2JtaW
         bLWBZ5qxHUg413HoUOp39jqc/utYbsW+lE96dUdDzbUPAdVunTUz59j2/GkzlHFRSA3N
         grfovyQeokhrbRtAR3ZSXoMTvRGDIVtBjY7kLArMtqSB3rz9Sxtw2/OCsHgfctD8/XVP
         GAMJFmavJUIgQOzN6KGW8XCWSUrAmCeUWwZ5Xf96+iLU0xcGunaNQuJeMo7Olxe6JNFi
         /qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CHJR4EVB7NnFssCr/4t5krLEsAcl+hLhlJzWcshS9nE=;
        fh=wfw0hEOlkq3EUE6azXKmcRqOiVR9wJZgs69aE8Vkuuc=;
        b=Ay44LuvZOcaXBxNMHCZfvbyuXrlLcOugY78kOF/aGrvoXqRNNOoS6NB4M0nlxJEphC
         4P7RdwpE0hhtHxD/8KU45PmQxVvbVp1B8w+yfaOl9krL9hJC0He8i9sGDt+hxamAI8Y4
         4mwVC1+2/OEp39jEuyVANEOUxZNlRAg3J4BJi+7h1WKDAsAQyXn3HssKGsYvcEkSLedO
         9hcfU6wCmI1Qz/SSEPSG2zJbgBoe3SGRWNlpromwonj21vJL58KGFJErhkS+EbsnXsVJ
         VtmpjpZAdoSdqhL5BcnFM0RKs3t7FL2cXsPV9V2hOffO3CES0XXt/EvTpEtyL+hF/Wz/
         KgiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783642710; x=1784247510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHJR4EVB7NnFssCr/4t5krLEsAcl+hLhlJzWcshS9nE=;
        b=Sc/pdAzQOymo2z4lB+R+T5riODcMxNuA5w9I1uQ2lWyLL5BvkoaXvU4TPfjC7nv796
         LZoquW/cSlEj2piGNNCdFXQI1hFfauZggRazCUKFjmVRVlxHFGNAQhE6VerH90GlG8XQ
         usEIS9QOTKWBinXs3Kxi6GFjxk66ziU2Uyosya1fM/dmHDUVM4KfxGevDb+PClYX9s6q
         4FgAvRzXzr3a0WTJ//ZMIl/u1wD59y8PRNNO77RdYxzjE7MwRVKzY3CTqvRV3weBtnf0
         ybrsai5+N0NJJVDtGLXE+Xo+DkCc1hYM5M835GC4QublT9F9ixjapfvbOueGzgw+znyP
         SE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642710; x=1784247510;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHJR4EVB7NnFssCr/4t5krLEsAcl+hLhlJzWcshS9nE=;
        b=ou9c+Lan0Y81YaB8JMxAorcUUIkSu6TcGJk2p4tpR5Pv3FEvpUblMaizI50qdDihBP
         4YHa7XkHOC+yAxuDJAjtx7BlVP3c7Ww2k5/CmwWcDLs+HHfzSb34x4jMrnPMk6SrWp6P
         H4Bkne0Wggo8LB8UKN47vI9fNZjconEfsrN2wpY3jqemQws8mocGyZfhb9Pdc7+3sIGm
         J+04ljI6ktUgC6UsLG/ArQ7YmtehgduFzg4UE6dCUXI4FiRpBhAsWFjs4cb3B+MLbszd
         OlR0rlPS4MybqjgdVJKEo/QAROlrRtpfDBdVVmXdu15JOGzxJve9coIJ4VtiSi6eHEVo
         FGgw==
X-Gm-Message-State: AOJu0Yz2tS24s0s4/vCKwtbf04UZuNKcxg+igulFbqLjyEQYgW3CWnbT
	ZuKZyHsyFqPOTABUQ/f7MUkS5Ak0vvF29CLxbhIW/1DETf9oaVDg8Y5Q6HmqhMn5IsP8yFx05WE
	OrbNfMbAjDAeiyrUaGp5ipsk2KSood1MV+zKbUucI
X-Gm-Gg: AfdE7clZdKvAGbIO45nbWslsDz+hCos5PR7Gz4D+i8gQKxMR8D/8MNenwj73oJuh69T
	IwjlH02wXOz1rdlRX5iLJkBO4oW10RWoiUIf5yQjZGB4qeTxnJtdqhEBYJifujw5Q2tRYNsglG1
	s2103mTJBmjmkkpFbw0Wj+mZFqbUKEAh/vFb4E38BgoQkTVAxdwyIpkImk0SmaKFA01mS3xy1vg
	C27uwQH7ccngWnK+VIP+DHRnDiDZjTzDKwe9UN9cf+jP/3ake5KRG+C07iLoHLPt5UOrRe5H3Y6
	0n7B7OdE8yWCG9dZl+0H0NMKNVMiIaIR3DgLrVCwyEcve1ClKVkuJGr5G964CgkMn/zsmA==
X-Received: by 2002:a05:6a20:2d06:b0:3bf:6c08:2844 with SMTP id
 adf61e73a8af0-3c0bd252e38mr12296483637.51.1783642709176; Thu, 09 Jul 2026
 17:18:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:18:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:18:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709204948.1988414-15-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-15-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:18:28 -0700
X-Gm-Features: AVVi8Ccj07FhNmdc7DJdunulB_lDcDocjQM1T5gQv1jOPRaAVjBkl9w4Ho_T_Tc
Message-ID: <CAEvNRgFzxSM8LVFy46puAuL3u-JT0Vdm=mGfy_ZHkrCgm7KLhg@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] KVM: guest_memfd: Drop the redundant printk on
 arch gmem_prepare() failure
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
> SNP alreads logs more precise messages in all error paths, and whether or
> not failure to convert the pfn to private is "unexpected", i.e. warrants
> logging, is firmly an architecture specific detail.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 7ad656e30f9f..f4f8635d1a10 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -66,15 +66,11 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  	kvm_pfn_t pfn = folio_file_pfn(folio, index);
>  	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
> -	int rc = kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
> -	if (rc) {
> -		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
> -				    index, gfn, pfn, rc);
> -		return rc;
> -	}
> -#endif
>
> +	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
> +#else
>  	return 0;
> +#endif
>  }
>
>  /*
> --
> 2.55.0.795.g602f6c329a-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
