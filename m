Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385834;
	b=v8aEckAsZzl5R0KO9pt34m5A4YOSfpO6zxbNtkea1CnbcQW/O+3FwtpupdrkhQGvtxUM
	 ucY16p1beFHJQlHyTeGPU45aGBKohabSWKTUk12ep7FgoN0FnaU2zE9F50SBMgCt7wz2y
	 KWr1Ofiy54MPkMZCrjFleMH48hXe+KO8XynLRxZxeHbbee2TaVjQoek13KCIzXPicxUfU
	 E8vQMqFrgV4vJaWh3+1XIdoU/f7+Y0/34mq3mme4onWTnAxSem+5VXwp/N9MweLwwsvWk
	 DkPuHlWBLZJ54SvoHdtB+7Hto2Vnx9HfuqxduxUFQuUv/pLXJnfz/EJCX7oFVApK/Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385834;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	b=e/xCqtWyb+S26JcP28zq9RNDyUn49PkJKu8OodtDmvUWYkCwy0O0Cvg9XmAOql8ox224
	 M0GTTsOoRykcqy5FhQpPa+jEs52BgeLlGUlmIwvdm9XwCwdkrRkMHzhel7484YSCZKljY
	 LF9bVSIvbZ2kBYnN53+muYfuSW72mKdhuaHt5ukkk8cCMSZ2ZMqfWki/HxrfjopnuXQ1r
	 Oi3nFN/ek/rBdp6EyWMvRlHaFlBr1Tbkv0gDDRJJu4lY0aJgcODiDNjVJplBOAs5hph9Z
	 U7ABJ0QSKurW3elx5H/q4yy1TG9ismNkG5mODc5sv340jYQaCe1Kpqa0Lm98J3kT3fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwVTyPj3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Nni6Jgu8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7B606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C7B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwVTyPj3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Nni6Jgu8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794385832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
	b=TwVTyPj3/lQP9JwFqfkiRPNNf3IFdlo8fxH8x8M6XZSERy0hUAgnuapHu/NgMN1tgsgr03
	Xk7fUthBDT+7uEqhWZLL4PFI24gNv8j+ua9V722lXFouOKB0njPNnOzddflW0KtwxjyRL5
	A58p4JbbBLI7R7d4GTrJnNKSOu1T5ys=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-FH6l2vHQMyKpusVuPahw5g-1; Wed, 11 Nov 2026 03:30:31 -0500
X-MC-Unique: FH6l2vHQMyKpusVuPahw5g-1
X-Mimecast-MFC-AGG-ID: FH6l2vHQMyKpusVuPahw5g_1794385830
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso21197095e9.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 00:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794385830; x=1794990630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
        b=Nni6Jgu8hzP8pXi6vbq9MMa7TYe326yIX4NFRlgJio9dzwLYhUVY6vjtgmPX5M3FPV
         s52kyluCZKesIu1ViohLpEqtcZf0fHS9d9UGpc3Kji1bpzFmLfYH9yF+PVhfqVsx+Y0T
         TYj1JrUOn0tNkICTS4Kry7IQuukCgAgoHCr0tzF3SLc5NAEdWfO5x4pIODx79Eeedolv
         rfCREpzG+0zr/jUIa+Q6gfmyad2c1rp2eC161RhD6D2bfv53UOe1aonjVyEHUuieexGn
         QfwQ5CV98oTCVhsoHemah/JNXnqccN01y6ZgHhqTZ0pZM7uwybvrOgxb6Dw+lgU/h/zw
         n8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385830; x=1794990630;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpfsiWos8F/vl9UH8UsPq3EZ0RisGA+Dhf9KlrFQ204=;
        b=VgRzF047VehsUIhr9Ep8ZshsMHpBONnmXMlZLDhLiNK3aKSMn7ARUPqEXdhHRGZacv
         pQgL1y8Z1MPPbXAYeMBarMlNjcV+RUuPTeAFnS+hpzdTLv8FWp233gFiJq0/rVShu3yh
         3nUOPOL10IfulLGtodYUbFadmircvMSdY/dSqc1Hi4ZPhR4mFx4CoSFIj06+F6FxevKw
         ZuqzHgUkoWp7MBSnFBKiliSsMNW+HXjo5omIhuTEWKh+tROLPlN7LwonrDfSgEHJjuZI
         Ckiz06ZrQbkkm4JzSFtI/9Ti65uuku8XMIhB2iaC4I2Tis+GSnFK2BGLMfaR0nJPTd7Q
         ik9w==
X-Forwarded-Encrypted: i=1; AL+hErFRlWJP7T5jc3Ltw3FY8ZOlbtgNYGzJWRkCZcZ0e4Ep92fygDvQOKbWOq47dkrbgmJsgx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p5S/1DfVNocGw6z6sMWnjngJeg8bFxhiyC1XLIzFGUJ/qX6yZ
	joGFOYPIvuAie06eq+tNe+Ivq0niJlbYH3yZHHC5egQNMTMmT6tU+hs0oJqhP8L/bpge4K1OqL1
	Gb2JDMLlUwOE8KQRYzUGYohAsTYubq30Sefkk067EdJWIIqaQ7QgFpg==
X-Gm-Gg: AYBFou17VC2aRN2pPxZZvqr2rUDrwPYJUEAD6CldrmsDMLxKaVr1rMrXnGbOjv5qyts
	1mYHFusZVJB+P8eZrqgTXb8LXRcdSRVXh2dxCcy7G3JHIKX8m9WXHLoQLzwCKg8T9CdN6U/PriX
	9EhI2uRMBPXG7Z7CmXKfiHOkoY6v8VOTdIftw2wZjPwqJRh/5nNBMi/dZtP0FVq4h2TRYMVr7tA
	TD0OhmomtvO4YgjvHJWjuwOfE8HfoPViFXMHM2RNAek4lS/RPSxCHUTxR1DqDe4snIeCG9oUpqD
	ssSzn30N3U44h5HxpPLQ6bRRs3ZpwOyjXXjinUxgmCUnS0H3HmxlBqIa2SBpUwP/aFzvLGNmqFL
	lwBIGuoTJYf6iCOaOfKOI22aEJAmUoXDlaP07nnbaMMQJ
X-Received: by 2002:a05:600c:3554:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ba0937ded6mr26339995e9.31.1794385829961;
        Wed, 11 Nov 2026 00:30:29 -0800 (PST)
X-Received: by 2002:a05:600c:3554:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ba0937ded6mr26339535e9.31.1794385829582;
        Wed, 11 Nov 2026 00:30:29 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951f237sm26744945e9.4.2026.11.11.00.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 00:30:28 -0800 (PST)
Message-ID: <620ad58f-50ed-4b0b-9d13-b4df34276448@redhat.com>
Date: Wed, 11 Nov 2026 09:30:26 +0100
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
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261110154415.46220-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> test binaries:
> 
>    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> 
> The tests are linked with -pie and relocate themselves at boot (see
> relocate() in powerpc/reloc64.c, called from powerpc/cstart64.S).
> Newer GNU ld rejects relocations in read-only segments by default.  The
> Makefile already checks after linking that only R_PPC64_RELATIVE
> relocations are present.
> 
> Fix this by adding `-z notext` to the powerpc linker flags, as was done
> for arm64 in commit 5d67db4e1860 ("arm64: Link with -z notext").
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   powerpc/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/powerpc/Makefile b/powerpc/Makefile
> index 41e752b070bc..35fe58835726 100644
> --- a/powerpc/Makefile
> +++ b/powerpc/Makefile
> @@ -78,7 +78,7 @@ include $(SRCDIR)/scripts/asm-offsets.mak
>   
>   FLATLIBS = $(libcflat) $(LIBFDT_archive)
>   %.elf: CFLAGS += $(arch_CFLAGS)
> -%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
> +%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n -z notext
>   %.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
>   	$(LD) $(LDFLAGS) -o $@ \
>   		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
Another thought: Why are we only using -pie for the LDFLAGS, but we rather 
seem to compile with -fno-pic in the CFLAGS? That looks weird ... I guess 
the -fno-pic is required for certain targets (s390x and the non-EFI builds 
of the other targets?), but maybe we should only add it only where it is 
required and compile the targets that have relocation code with -fpie in the 
CFLAGS instead?

  Thomas

