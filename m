Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224323;
	b=DISW0oT2pIXuGLjyfPsn6zFpNTJS7poubW+9O37tf/eg9Sul3Zwt7IIIlgpHvq7ETj+A
	 CMilguYILhPfCnQAaR2GtpdzXL4oSqLxPQo/2qAJph9GFp5CHFhPdqCOv4ISq9NqLeQ+P
	 PGMIKSNr5AX6SDAKdPTIJnJ6QNCdri8XihLgRP5NYIACZumOWlb12YwizwyjfK9Hc0kfG
	 iX29oSimoN2dymrCSN5PFxAKmmzYbfE0vsDflQ5dJrnif7EB9yfTY5Au/IQfnoDTv9Qn1
	 UlpP1Ivd7DsWFvTj/myAonwFoJUF7kp3PCOlL0jVY/pHeNTYg5b+EkL+b8z5tK2g1Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mPtExrnKGOMQtspuIP7yF8Ip7fswDzEEpF0H728OVnI=;
	b=JOD3fa9vJtm5/thlMGW1oqs/Nuqs/CXCm8tIXNBfJVFlX7uz9Y5u0wEGDOJV24r5kwkk
	 6+1e+3vWbYFPjJWN9OX033tgmZVaXrabwstt6O+Nbz+OvYHIlnpz3OrQ6Y5TlI4R8xapA
	 7T6T04Cu+QlZv2rpB/0q1k6qw7ek0F4Uy9XZWHcHVGex3aV6VuW/i02t08pl3NEyK8xup
	 FeR4dPj2BySqf1xAw87vUzsXuxROoMDF0/Eb4QOj8+Ekieg+ODm10kbrMGkWJujERbnlp
	 UiILnGNXibR6w35ToXYrnOuS8YdnbGJFAD8Z1qZOHoj73LBq20zNWq7FYvCQakSPOJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MVKsgzc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D7606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C0D7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MVKsgzc
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d1114320so10885105ad.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793224323; cv=none;
        d=google.com; s=arc-20260327;
        b=GRUcgPqQcDfXmCXnEgoAw9bHV4MDF1xzQT3T78fTtcJr6uHrEaI1ErL8+oy///tz/Z
         5GFrriPBrVjlgzDWHUjJ0lfpgZTsK4AXhWj5YajUwKclFa7PBXXSYYFeVE3stJMj61V7
         P574qXfIJpmJ5WNmTm+8d2/+PwaCFR8z2fIRU/iB9N5JY4bkGlf22XK42sgKVo7rOpe7
         NrW96+TGcEHHX3jnGnZZKP36ew4zg6x/YerbEzhLZVeDf+fK4wvXc7xCtg2AsjM3DxmY
         x/Fhs9L4cZb54dVaqYamgNxoKLUhJjNIpIotxj6NE/BHPE49JJWZfZIFqniC7RfpqQ97
         89xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mPtExrnKGOMQtspuIP7yF8Ip7fswDzEEpF0H728OVnI=;
        fh=XYRZS7aex+ac40Ni/Z569MYpVP1floXb0E7UU5MnDGY=;
        b=S56ZH0mx6NT/FcjKvnup+nE+9JgGhFcPL98/k0uvoC0z/wb9eAIGRclcW3UOiIazAe
         841xI1FXnATuBndANa/7XanFEGmY6cWaSuFb6WwVC4UKphsSRu9IsTeoJUl5+yhfxmqL
         vkCqB4O5UkXsn6bX2EhWu4hNt9cJyOJurwMGbcn3B/ppwgJLIMMcYpVySkxLceTK0XJT
         RTryiA62ICspS3xaBmlWSmt2j0R5X5rKXkoiWHi0TSkJNSkmEOYErUhNXe8m2sTlMYEf
         f/XRbbTKcyUNrpEduaepSg7YkDI08ZPATFd9ajiph/D00LoUm0E6JG8uauMe48rrBhCO
         fd5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793224323; x=1793829123; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPtExrnKGOMQtspuIP7yF8Ip7fswDzEEpF0H728OVnI=;
        b=0MVKsgzcw3XsZH5xCrtY10JGwrODxblZvE9fjvtxdDOfDlIewMlbTr/AUZBdZAdIRv
         0XG1+CGZb8xXRLmCTL6fiRGDyomJDYNr4QM/uqJT3iK5SsdywoNabbCFBqs20TpdPKHo
         in5si+Hxd/5IJI1ttPwmNlRbnyEf7ik3UqRrWwEDueLvq+WLrU5IvQztNMXNwEjvW6dZ
         lda1In9bhFdsinJ5V6NZsO3emcR9VATiODrcC+AuKtafi5TVHEkqYzpz991Ua0p3pwg0
         COypZaI+4OuJhTuNOwGZP6bn2ajsgpsRfQfS895cWAKcgB9eqUvxR0b+lK4tm8EuZVwp
         0RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224323; x=1793829123;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPtExrnKGOMQtspuIP7yF8Ip7fswDzEEpF0H728OVnI=;
        b=uKUj5/Y0jUiFqKZnAb9f4rfgGnLbBSx46+Za5QXXd7cLo5QdUUyS9l2WQQVAqs0kJm
         FP+EcdzBJLRhdiz8gLu8hE2KTJbrcPrkMnA8Dz648oMMpnCcHY9gzoF5JzZXcLtWVt4A
         5UbuHsocGFuVvw5NIrfS+YDMLRD2qttldVxUX9auDt991lZUqOtZIFvWZJou5sqAzP9U
         2BPVqE+H3NB6pB6zFZ3sXVsbx4jLMPNgbHOmixzvL+OuKc3DBKRMv8RnxsnkueYzTOwF
         BDdqZBoPtoRgkL9iL2n+CtFOHr0Xxr2J0P4UrmVuKBXigGvoML7zCHsNanCagnCijCDv
         P/kg==
X-Forwarded-Encrypted: i=1; AKwUvByrCQdx4u/FCiHf7cb+6MaVI5OMlJpcFykGVlEf1oAZsVOEb/ZGID6zcky/orlFjBh/qvA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1FmoHsZ2K9S60qommbSFHA7KPx1UWJ0HPMPEmLSG46d5F3hsI
	R/AlMtQWVLLHCv+sR6EjNfPDWeitp+5Hgi9G0s0PljhOraOJethwj7ACv8p/pajhFoeg1lkm0Fm
	p4b6+fwJfiSq9wTZJOGP8wRcWijIxt2g=
X-Gm-Gg: AYBFou0p8HoJ4/ZrHHQRnwieufha0yAywocZw2/WJuifxlHc2X9szP2WctjQpkNaT9a
	fNx0O3FV6Cih9L5ITTGHZCdnKcppJm/Y1UyVrcrjHlp7nEUNAkJLO/FNYhR70N2Obp9E9s9vLHG
	QzEug6DzCC7zWqEJEq2x9yJMMjECPhbrtT4vgQSsezOm+ygEkus6P0R1OmGbVb9oWudyOUMF7Xl
	bfYKDbhBTI7+mAbw0sDmqoDhLE8iqzHu0lVE3tmVdtAsgn1OCYTDABaaFT+GsCkEC9MxkH4UXiA
	wawj8Cr5JxOvOxDnksdetKMGULy+nCdFdWOdHbnoNAFpraSl3xXCrX+ceC6yyoNhdQ4hUxoB8oz
	gyfGTqbh4dUYRKl9WKrUuEq6l8AdKb9eMyMco0fk=
X-Received: by 2002:a17:903:94d:b0:2e8:1d5c:f6f2 with SMTP id
 d9443c01a7336-2eb003bd5f2mr34821655ad.24.1793224322720; Wed, 28 Oct 2026
 14:52:02 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793216372.git.ashish.kalra@amd.com> <56da047d63b22f03a7e709fc172a5543da894d67.1793216372.git.ashish.kalra@amd.com>
In-Reply-To: <56da047d63b22f03a7e709fc172a5543da894d67.1793216372.git.ashish.kalra@amd.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 28 Oct 2026 22:51:51 +0100
X-Gm-Features: AclHuK-lLMUGo00CsLuRjBYLJYO8QfoO65WYw2V8BbtyozSJ3LTmNXJa2V5HQzw
Message-ID: <CAM9Jb+gBzgwvtOkV32bNudAqb4sU5+40zuj54py+JoLVvV+naA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/sev: Clear RMPOPT when segmented RMP is
 disabled by firmware
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org, pbonzini@redhat.com, aik@amd.com, 
	Michael.Roth@amd.com, KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, 
	Nathan.Fontenot@amd.com, ackerleytng@google.com, jackyli@google.com, 
	pgonda@google.com, rientjes@google.com, jacobhxu@google.com, xin@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com, dyoung@redhat.com, 
	nikunj@amd.com, darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Segmented RMP has two independent states: the CPU *advertises* support via
> the X86_FEATURE_SEGMENTED_RMP CPUID bit, and the firmware *enables* it via
> MSR_AMD64_RMP_CFG[SEG_RMP_ENABLED].  A platform can advertise segmented RMP
> (CPUID bit set) while the firmware leaves it disabled (SEG_RMP_ENABLED
> clear) -- e.g. through a BIOS option to disable Segmented RMP -- in which
> case the system runs with a contiguous RMP.
>
> snp_probe_rmptable_info() clears X86_FEATURE_RMPOPT only when the CPU does
> not advertise segmented RMP, or when the segmented RMP table probe fails.
> It misses the advertised-but-firmware-disabled case: that path falls
> through to the contiguous probe with X86_FEATURE_RMPOPT still set.
>
> X86_FEATURE_RMPOPT is a CPUID bit advertised independently of whether
> segmented RMP is enabled, but RMPOPT requires an enabled segmented RMP.
> With the capability left set, RMPOPT_BASE is programmed and the RMPOPT
> instruction issued, both of which #GP on a contiguous RMP:
>
>   unchecked MSR access error: WRMSR to 0xc0010139 ...
>   general protection fault ... snp_enable_rmpopt
>
> Clear X86_FEATURE_RMPOPT on the common contiguous fall-through so it covers
> both "segmented RMP not supported" and "segmented RMP supported but
> disabled by firmware".
>
> Fixes: 15d974be0a3b ("x86/sev: Initialize RMPOPT configuration MSRs")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>  arch/x86/virt/svm/sev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index bd70c4d0b774..cd0412b9d251 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -827,10 +827,10 @@ bool snp_probe_rmptable_info(void)
>                         setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
>                         return false;
>                 }
> -       } else {
> -               setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
>         }
>
> +       setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
> +
>         return probe_contiguous_rmptable_info();
>  }
>
> --
> 2.43.0
>
>
