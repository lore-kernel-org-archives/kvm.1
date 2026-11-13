Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577919;
	b=IAlEeCTa87BwceWJqNqz3R8K53Ck6KJtL3yDFw1w4+NJYEFbYJCP4eJH6OIXXYchcwM1
	 r4tkpc2bWUKC3aabQTcYn9Wqw4XgI1lpDd+GenTph5w8WKS4IKTo9Sd8A3BelAgD35HBH
	 37No2zT1EISI1H9vDZv9II1krt4Xgk8PnmFiDWymxMKjQimLvITHxWlvSk7AwkyX4Tib4
	 2Ubuq1zV6lip4vIzWDfwu6SyGsh7TOHBgDNakSh9ZKIqinbWpndBl2a1NjywQ+eXUI9Lh
	 cU0wB9+NhmbmnV5bxHl1KGdry841PEFNi9q0n0DFBJBC3yuUkpwyWwQoFMZi1gbg9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7iOQh6oJAMU34U5WNO1f4JDUIZhUKKNoQ3y6TH5HxY4=;
	b=GmH0AxZS7XwKPAWUUMqXlgFYJEvZOBT5ffQFgG13L/4saKSVupxmzYpgztZvacuMLaJv
	 2vOGRMMzx917++I/El2ul82+UI4u81uupv0wag3tkmSlpJAAAyTRdCmqSMgvbz1Sd1/mj
	 ouub2v7pT5l2m+3nZqYzk60LxnlHaR8Mhj5kGCzFCRsX9wBAXDCGNF5g4v3cK3fmXqFC2
	 DK5/FmSj2GQAwxJ4AdmJC78fhBL2FMWZoVKxYgNbIfFW7+2fHwJoCWBfQoFPlAQUxL+SW
	 Z20WnUKTy1nYrGCF/WKOCsgYIlqTNHZpa2xN/tfqh7EmbvO3eV6sI3exWraSLqHVTDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FPyf8Ilf;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9C606D691
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B9C606D691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FPyf8Ilf
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a064f294cbso683257b3a.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577919; x=1795182719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iOQh6oJAMU34U5WNO1f4JDUIZhUKKNoQ3y6TH5HxY4=;
        b=FPyf8Ilfs7u7AaJsMMV6r3d94pfGyY7/LDBBwvNUPsxfj3LmrDI9hgMHq3yFbap+GZ
         m5zoscaDeq9rtkD46WPQ9tzJKth1ynDDzJVK9JdrgxAuW0/BRfqQ2ki0w9E6n2aUxJgv
         cvGAsoaskmKWLJ2asxsrAJA85uBCnOS6CdgpJLD8noCRc9ptW5xZmIFmsFviaBQJ5/MZ
         NmUDBBSNecKjaIVrwro8T2UTLLwvaYvBKyBDDn3mMLZgxG6eWDBkKIMdWW1Om/2gQucM
         FdOTnhaRd7wt/a4nlVGFyVpKzd2nLTdHsl9RBj0EddthkA4Zx7H4/UQ5CCp54MbruaIt
         pExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577919; x=1795182719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iOQh6oJAMU34U5WNO1f4JDUIZhUKKNoQ3y6TH5HxY4=;
        b=0+OJDmGYmGAUyJ0Qs2pV8Vvjo9655S4FtaPdaLVtFNlxTi1x+32C4FX7VJijOxk88l
         /GlrMImRqn5pn3zIOJ4y/t0KkPHvVrNuUzCla9OyBCD2D0O5J63zmHSGLwsgh8BkcGWM
         ayNL5yV3tgPe4AVfYk/6x6TRBo5A49dr0wx69JHooGDpTZgjiVdjoEZLIGjD3HPBfwg3
         1hsSd2LvaCujQ8L/wHBICfKX2aKNZGuqZARONWlMBj72JbkyefOnKEgii5MkNHOhwKSg
         qB+RnrdzVHSleHuuNK2kKqm8hzhVyaCdUSuIjr6jkC1/XwnugQTs4euID2GmgpGNVIT1
         YkAA==
X-Forwarded-Encrypted: i=1; AL+hErFs0q2cWNfODoYu3g6COVaGoCsefwrEUY/NarZk2g50i2DeKM9b0Zm6SDUReODzChvdLOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2amkUfcoqApPnDOfBFpfIGi8WvIAQGGdvYhCpa8YX1CmEHoNw
	VWREwX7m76mwPesnej/IY5ttAvWcSHC5i0N50NjFHlJB5+WNaBTPNBlvIwWGH8f6Oy/Fh60ovjT
	uO7reCQ==
X-Received: from pffi11-n1.prod.google.com ([2002:a05:6a00:c28b:10b0:8a0:3171:5410])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b53:b0:886:a737:e0fe
 with SMTP id d2e1a72fcca58-8beb6197585mr2672431b3a.23.1794577918466; Fri, 13
 Nov 2026 05:51:58 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:22 -0800
In-Reply-To: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441845917.83089.279363969551127970.b4-ty@b4>
Subject: Re: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, kas@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="utf-8"

On Fri, 21 Aug 2026 17:39:57 +0800, Binbin Wu wrote:
> Add a tdx_hkid_alloc() helper that charges the misc cgroup before
> allocating an HKID, and unwind the charge if HKID allocation fails.
> 
> __tdx_td_init() currently allocates an HKID before charging the misc
> cgroup. If the charge fails, the error path calls tdx_hkid_free(), which
> uncharges a resource that was never successfully charged. This can make
> the misc-cgroup usage negative.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: TDX: Charge misc cgroup before allocating HKID
      https://github.com/kvm-x86/linux/commit/93f1e8445a2f

--
https://github.com/kvm-x86/linux/tree/next
