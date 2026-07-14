Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72241A902
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054524; cv=none; b=fGDQQFZDG64hgMU6ZJPPONi1if1LEY28zPtflzFBxG2yrSXKSYV9ZkAQDl5zGLKSy96wZYH/ZR5D606hwjyknu4d+DazC5PU2jgMaJwz6OX+yiH5cf/Jce5Nd47/U8EN39UrGZfnL04MRw89Fzss0io0JnNrTYQidqge5x8P+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054524; c=relaxed/simple;
	bh=PaQBkS90a4rPCv/dq+YRWwLuz5fATYts+TOoZzoPZj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ns6E3G0RBtuD0F8EoEGmDXSgxiWhuq4TUPLnhwJ47kIb5bp4BdXQyT+wjWP9EHzU4LscJPitcEroSPkr9L2SfFRe1+suHO1an7Te/0BKRGfg65z1K2BsrQG2h1L9tcXmxaJWrYL/dzZi/7QGCZyR2yXBe7dWtYEEUJ1hu+Wd82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNCK1ue6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNCK1ue6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8482b95574dso5844094b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054517; x=1784659317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=rNCK1ue6708Vv/JHVtlGRjDGmBg7q7721OgtbVuL7BIIm4HkNGVJG1vYzTGM9MDe5z
         1OUpxXC0cOGbLG+Jzn1WMctTPA+1IfA1i77sPtNKFgOEjmuSt06dIks3incEeubf428m
         zSITgaZnP86MMavZ181GykbtaURT2oBdYUpnDPxXERg/EWu+mul+RMoxZll7Pjf9AEfo
         Vm/SyCa5dOmFVfkZOWFptvYLO38cjr/ZZBMFQdzRv6KzEGbecMfb8ryqEBDI8RTMYfZS
         mZjgu9H3fKEOon8Rr9RbYgQaJAGn8urwRUCOqbTNxWJAs0meHhowCK3PmlfZYDb8nqci
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054517; x=1784659317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=sU9RUlJG6P7JBHeaNpkcsMaItsfs/4TLpwv2p8hkFcNDFbo+Urq5yyAO7U4pivf/r8
         gy0eXpyMgGXO7yl/fZFJcx/+ImopIbH5dE9GsaixjXk8FJjRtTwBQNaVVBTHLcf2UtPB
         FNjAmli2sleCFVTslpA2I/u/yZeLtQ7Ed8fuEccwWxc0M3CgclHqPbhVmUrUW2G170XB
         4w6xmg2c6iCkOwXoB7ADFqi8vJ9GADlTeB0drMghmgRev6LfhG1tRz1ibOtx22U/eJqC
         jGdxJhjZUBAUxW3Ep+DX8+1llHDmCVbXNgE/kjY112cqyPl8YqaVw8H2jBwzYnxZF18A
         eLuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfVcdR5E4+E6XIWo4Ph5WvoqjjMgtnjXYUaPYv54bBHenCC5YyBKzo+MdibnALAnUcbY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc0XoUnaz5EIaMUbLjgAIfui/0HlvZlbG0DdMMplqRJB8Dyfu
	rbKkqjedAClUcsEFejQCurpuY4VvX7Y/JpjGPKjihHMli3lIsT9NbYMqWqAKjSdH7JtTo3Ngz/j
	xm5YP9w==
X-Received: from pfmy4.prod.google.com ([2002:aa7:8044:0:b0:848:56a2:f6a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9289:b0:848:2ae4:d2ba
 with SMTP id d2e1a72fcca58-84889687b36mr12770821b3a.28.1784054516663; Tue, 14
 Jul 2026 11:41:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:01 -0700
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405419095.3137257.15966365152304045590.b4-ty@google.com>
Subject: Re: [PATCH v3 0/4] KVM: Miscellaneous SEV/SNP related fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Atish Patra <atish.patra@linux.dev>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 02 Jun 2026 15:36:31 -0700, Atish Patra wrote:
> This series addresses a few issues found during code audit of the
> KVM SEV/SNP and CCP driver code. The fixes include a incorrect lock state
> and incomplete state handling during intra-host migration for SNP VMs.
> 
> To: Sean Christopherson <seanjc@google.com>
> To: Paolo Bonzini <pbonzini@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Tom Lendacky <thomas.lendacky@amd.com>
> To: Peter Gonda <pgonda@google.com>
> To: Brijesh Singh <brijesh.singh@amd.com>
> To: Youngjae Lee <youngjaelee@meta.com>
> To: Ashish Kalra <ashish.kalra@amd.com>
> To: Michael Roth <michael.roth@amd.com>
> To: John Allen <john.allen@amd.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: clm@meta.com
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> [...]

Applied patches 1 and 2 to kvm-x86 fixes, thanks!

[1/4] KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      https://github.com/kvm-x86/linux/commit/6ee414078823
[2/4] KVM: selftests: Verify SNP VMs are rejected from migration and mirroring
      https://github.com/kvm-x86/linux/commit/df371f2c6244

--
https://github.com/kvm-x86/linux/tree/next
