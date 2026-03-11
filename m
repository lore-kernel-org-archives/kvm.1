Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FA3A169F
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270330; cv=none; b=r+gx7KKq38Fm5Kl+akgq7R5tZRKqLiQwEThzWvpNkovlWI9YOtrg8/aQpIBneR5Qx4OSXP+OGyIXE1Ey+S1NUwwrZFfPrQryEB4xbphkMimYoOdNHE8KjdImEC/+ylgk5apkn+DvZGsTeI7jAEvWkcenQCg/bB6bSr9Ek6mZ2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270330; c=relaxed/simple;
	bh=WfMzJepZQufHfeFbmAj6wod/g2t4AaXDKoOxwYUDxWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwJ7uW0QfoKZaHmQ9fNKHmguQWwzjFtCHkN/+IOLJlsr80JW8c7zWNhWrMfvaBXF/kOENYEBCtxgpzMgldmwUqh7bnz2MTbCtBmnlC9SkTwWbkbb2AbPPzlEeCoH1L4qlZWdPUYvFp6m7rnEO5KpA31BfsuYn9WSBpryhqLPxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAX3JbH/; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAX3JbH/"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-128ce536fe0so4107c88.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773270328; x=1773875128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6gegApxL8KyG7p7ftnWFqHKVt/5DrxD+pUpVnG9ZLo=;
        b=kAX3JbH/JDWFitMyVtWh37SaYZ12vimFejd+SRYAB8OKT+gmKLlKyrnPu41xUO+P0+
         MajNqORjMu2+S813oPreDVwupuA58zluUdr/Xg5ipSH3OaYqumN+zcdekKzP20crXvHb
         bJFxOEPAC4f4P6sfgSF+xuG1jCqGS48llzBWkqKUHiB0eie1Wi1TPZuDYyvDXj1Nh5sd
         UHFhmu8MStRILaXPa+8XnSt/qe6t/l2hyU04qx/voeG5PnY1JZdjvhbYsFZ+wWE3b8vr
         mO50QvTGlG0l+x+kouj91v3IWiyfLd7Hx+K3EiGiVoAvrgX2AIaSyqnqhT5dEIeo/Plp
         IMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270328; x=1773875128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6gegApxL8KyG7p7ftnWFqHKVt/5DrxD+pUpVnG9ZLo=;
        b=p4sdGUFJd4t6PyLi27TiCD6dCjO1V+kH8hQkl414TwUAlfeGCV1SRVKe4TKeS3d9uW
         FMvp5JVlePaeCKcbVi2gIKbWKtBe/ccd6JB5xgTmB462NYWJdyd+7YV0HAXww14988U+
         wDbm9SoioMZwNU6ITYjkWb08iXVOPNLqHdh+RCirijGdhEzdYvAOQrEOEIak3SpseKdA
         g+YnycM2dEMWliYWQzeQm+TBFYi69jf7RFO0ynS7tK+XDntlIa37aKXj61GaBiG1++4B
         hEei+JwR/0X184yw7nGn6S206BrSFf/ZRpxb/tK2jlIh3TMXFDTbqVJL6YgQH8zcp57n
         D5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLaR1xosvbGO1Yt6WQpgOlUxCtuuwXjmVC5pwRnvJ0Ok5GzvDQZr+Cx/fFRwL3yg5z9Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHP4l6wlM5dnWJZ2baibj7SB6ORDWHnagMIcSoS89s609ciD/
	5/ApiCyNR0fC/jxEkLVe20Q+EPXIyRz0fK7iyI13Egga+huZH2+znM/ejHnrWhKOzw==
X-Gm-Gg: ATEYQzwz+ayBI8UU3Qbs/vdPgJQK1msOMdRwYaVpqy+dSjC531NrBI6gtOD+FqDAi8+
	VFDvl/GH1eSb5ZPzWlL+qFx4BPDx2AkWT/OW+fx+jsGJ8dlQCJtqGcsROMX9/+XQmMqbLYs1Cbu
	E4vF4oZ0URl+HEpoZOMn3ECVIPNz4C7TvziKm1FU3aAlv0Yyo40yqHDNUILSaEdOMB6EP2dSNhr
	inLxVWJASWlmNPaw+xDyYsLBNvs4AEBbqLUif14j9Tt3p+ONWT0FrBxLOoMRDg3mq5ahkdpKVIQ
	50yHxci9BCqbeuZTdwn5zIxKm4QeyKvbBtTjzMwVXPeXslmBNOjNdMKqOa6teO++iBv6ewhlkah
	Tx7NFRaqhTxfyE+J7nYToZF3RPHAPdW6vyYWPatzsQUsalipzUnBueQYkYSoJWVD4rw7aPSbXyp
	TBGmT2mnmqLJf1LC7XI0qQxFuwrY1pGmbotY6BvQkSJtzRL1pKVp0AMKX9pddhM9axsJGIsHQc
X-Received: by 2002:a05:7022:b88:b0:128:dfb1:61ab with SMTP id a92af1059eb24-128edc2e654mr30066c88.7.1773270327111;
        Wed, 11 Mar 2026 16:05:27 -0700 (PDT)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cb5208sm6853358c88.9.2026.03.11.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:05:26 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:05:22 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <abH1Mkm-MV7fLNsp@google.com>
References: <20211111020738.2512932-1-seanjc@google.com>
 <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
 <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
 <202202061011.A255DE55B@keescook>
 <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
 <202202061854.B5B11282@keescook>
 <aa8fNT3P54t5W53T@google.com>
 <20260309223156.GA73501@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309223156.GA73501@google.com>

On Mon, Mar 09, 2026 at 10:31:56PM +0000, Sami Tolvanen wrote:
> Hi Carlos,
> 
> If you need a stub with a matching CFI type for an arbitrary function,
> perhaps you can do something like this (arm64, untested):
> 
>   #define DEFINE_TYPED_STUB_RET0(name, reffunc)			\
> 	typeof(reffunc) name;					\
> 	__ADDRESSABLE(name);					\
> 	asm(							\
> 	"	" __ALIGN_STR "				\n"	\
> 	"	.4byte	__kcfi_typeid_" #name "		\n"	\
> 	#name ":					\n"	\
> 	"	bti c					\n"	\
> 	"	mov x0, xzr				\n"	\
> 	"	ret					"	\
> 	)
> 
> For the !CONFIG_CFI case, or architectures that implement static calls,
> you can probably just point the stub to __static_call_return0:
> 
>   #define DEFINE_TYPED_STUB_RET0(name, reffunc) \
> 	typeof(reffunc) name __asm__("__static_call_return0")
> 
> Sami

Alright, I've sent out a patch for this here:
https://lore.kernel.org/all/20260311225822.1565895-1-cmllamas@google.com/

It might seem "incomplete" because it only handles the RET0 case and it
doesn't export the stubs either. However, I didn't find any static_calls
for which the lack of these things would be an issue.

I can address such things in a v2 if really needed though.

Cheers,
--
Carlos Llamas
