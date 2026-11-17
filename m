Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944281;
	b=K1mPWD5uhr9m138+iEktEQEeOr9g0zy1zI1HVo2pVPns1WeU8OIixlO14AhcUJwR0L/z
	 +OsurwrkGCtlHyY32UurHL797TqQf/kRv1OKGHcNjVJWSYdU1ThqDubY9LOVCOX42OT6J
	 4UkTFCGUecqIy4aEs5f6WUf+uDJ3HsXX4sIlAkfHHspdmnVyeYD3sDveoS3zKJN2z5TrM
	 j0cxgUar85IWdJXosDwinR662/HwK3Z2haBJvmB7HAbJNU0xmwPGd675AJUpr1whPxnfF
	 Op8776PKfCMHkZBh1hHOvGhV4aHSX/c/Mlg4NL3b+0vZufjPr+UMnYsEpz+b/I4M/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5/vHAZGe7S9PuEhTy7BQu6tAJsTjB19cuWDO6dDg/VA=;
	b=Y5kbCgSDfekRkauZLIf+sD/4HP0lxss9GsdLkRxATyidQNcWDfM6FksAw+bwAEBkGskk
	 fW5JXKKsOSpxPCyrSanN1h8anhh7PMhxj0mIPWR64nkJe+kBvzLUSf0sbG2OMxM41Sk0p
	 3h/pxACBvbtH5e/fSybmJx7jseB7W+JWYsgtmmKGYdDNmHHyzBlUbOpYld4TTB1wzsi4z
	 pS+1/ePdgb6iuaVXurddzMK6SGL3M/CM7yd1ekfJEJQ1ejP05U/CLU92fjriiN2DCVDaG
	 TC6cI8CO3Tj06dYx/rd8rKrLTD8BffRipEVdCYspM0vXOofrnfsRBTz6Pm4FtaXyPKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KeoE82iV;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7C606A330
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 19:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A7C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KeoE82iV
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed00709df0so1132435ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 11:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794944280; x=1795549080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/vHAZGe7S9PuEhTy7BQu6tAJsTjB19cuWDO6dDg/VA=;
        b=KeoE82iVMMT2zJBgoV+e9oDAvJROLQDtmEft4/IiA65eKdyPd/BgcIwVM+lxwNY0qC
         9oJeenwc6gjZNMUWp8khr2M+fcQxZon8DJjl8xhiHMC+IvR2VTHOXf+jJeJ5aSEayhnY
         t/9OLKKjnyAmNcXl8YjsxvA+/LrA3mMlGrHfjjCdjZo0cJuFJmS1uB1T84dfwzRBYUxH
         VoBTknKoB07/nlPsTMS7LW+hxVFmY3ggdrn2j0TpV46O50Bioe+lHOrYSrzDIVvKgpE6
         kAXr5XQVIfAh44DafQEUsls/+b8JHWZ2jgNnmLPv/Dc03haN4+e8GBEJUYZlmrf8HUoE
         LReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794944280; x=1795549080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/vHAZGe7S9PuEhTy7BQu6tAJsTjB19cuWDO6dDg/VA=;
        b=dopG3bpMk4JtmKZBjAOdxA/qzPdj6sSM2r0oBDPo0VBsvHZnzme0hUq2BJRh9M7C8R
         LG0Y+WmGmacoLMNlGdvbtZmQkX/i+LPLuohPZf27RZesci+8S0eOi0RGBtZYfyyV1q4t
         wiT9uSNx5Z5VvCUMkLkEj7RR8jCvShdlRfMurYWMQGhv96FvBW70PXhWgkIoQBTv9tRq
         pJQu4+gy7V8aFFKl62ifsGmkDbcV+5hn4skHkHtthoVF9I/JH7rfvYWcvXrKPGrZeg42
         /q++mykHouWNGZry7e9nPj3z5XXydwkinqrwwAJ08Ohazo8j0nAAANEbs4Q0/0NWgd/8
         w8cw==
X-Forwarded-Encrypted: i=1; AL+hErGkpueKQBGc2INa2Wgh3RTeFG72NGAKv1kFp73RRcPFHOvLkrbQtJK8f6NFZUUV3qE94EE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xtDbv8bxsdJ/MW90GY9dvb7P8Oj/jGhrnMGvMNX1HnNk5VjJ5
	RXND+mtBF6+Q+kMixzg5O3PR4kD7cBz+/fvFKDoz3F7Upo5s1f36OATCE6Hq5T22+zZiSplxVxs
	YdHTJ7A==
X-Received: from ploh2.prod.google.com ([2002:a17:902:f702:b0:2e3:1b6e:33bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64e:b0:2ed:12a1:c4a9
 with SMTP id d9443c01a7336-2eff752924cmr3212835ad.11.1794944279883; Tue, 17
 Nov 2026 11:37:59 -0800 (PST)
Date: Tue, 17 Nov 2026 11:37:59 -0800
In-Reply-To: <20261117190714.GAavyl4lS15Gwpc29U@fat_crate.local>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117190041.158949-1-nik.borisov@suse.com> <20261117190714.GAavyl4lS15Gwpc29U@fat_crate.local>
Message-ID: <avytF4CYn5FUkA4F@seanjc-mac.roam.internal>
Subject: Re: [PATCH] x86/virt/tdx: Don't print error if CPU doesn't support TDX
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 17, 2026, Borislav Petkov wrote:
> On Tue, Nov 17, 2026 at 09:00:41PM +0200, Nikolay Borisov wrote:
> > There's still plenty of Intel CPUs which do not support TDX and when a
> > recent kernel is booted on those the user always sees the following
> > error:
> > 
> > 	virt/tdx TDX not supported by hostplatform.
> > 
> > The same is also printed on all AMD CPUs. Fix by using pr_info.
> > 
> > Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> > ---
> > 
> > Contrary to Pet Shop Boy's song - it's not a sin to not support TDX, yet :)
> > 
> >  arch/x86/virt/vmx/tdx/tdx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 96ced0494b68..b2962da24701 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1276,7 +1276,7 @@ static __init int tdx_enable(void)
> >  	int ret;
> >  
> >  	if (!cpu_feature_enabled(X86_FEATURE_TDX_HOST_PLATFORM)) {
> > -		pr_err("TDX not supported by the host platform\n");
> > +		pr_info("TDX not supported by the host platform\n");
> >  		return -ENODEV;
> >  	}
> >  
> > --
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

FWIW, I prefer Jiri's version which just drops the printk entirely:

https://lore.kernel.org/all/27b6d824f7aee7078167944ce96d95676eee25cb.1793602266.git.jirislaby@kernel.org
