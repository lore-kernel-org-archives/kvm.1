Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799392;
	b=DseTZOTHUszsj833qerri/Zo3TfVV1TDBP3w/Zt/QFs0PgN0W14IfyiuMooVhZXrTLZi
	 9PIPmAk5AUhTzdJmc/Kd2JYubTFXj5n1LH7ZZXm72c3t2FH/5W4U7ZeYZC5QfV8lC72mo
	 OKKn3fq8BXH6/4wgCYSTzMVTYmUBR+gYewVYPtdFn2oTCehWG1f/TvGa7FjExiPIsBpzZ
	 qcmELI1VkeARip6XDNT1vR5n2koLguWafpa73sz4z7TBeYa1lNymFD4Tnw79GtHJBkKmj
	 RAyi2ZSRTZEeo2hl6Dggh4ugEC9R0DuI5bDh0k6HXg42xp4C6e3e62hPN2v+lsrIt+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sqYPU2TH4ZpVQU5dx6i0fuxfEm+4/xI1XBznqOgTzQY=;
	b=WEJesZBQLN3kM4wbbe5AYJjbuhk81welzwxENaHAY5WiAPIF/ygYng82LNYTq/SBbR4z
	 tVIgtpE0bDgVXClxFoUdtL3ciFuF33ca3ork9PoLQq3koTmaFzVk+6DOKJaa23qSHcQya
	 ZpUuo9uOv6DMU7l001/u8K4F/kYGHgjC/XZzdzutnDIefVOcV1ytoedv6fi9PNwHnuvQv
	 AQtEYEc/jHvZhJcsIKZxRDBebtQigLVJLN6+94KyrbeS7Wz6poNmR9ojV0O6iar707H5Q
	 0JvF4pYbPQXvlugwMQ9zcZo9IrN24PNnlGECerVpIamunQjbjBFWHZr/yfDVz7fs/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AcGO8PAf;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F385606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 13:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F385606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AcGO8PAf
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eaf3f829b3so6594995ad.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793799392; x=1794404192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqYPU2TH4ZpVQU5dx6i0fuxfEm+4/xI1XBznqOgTzQY=;
        b=AcGO8PAf9SmeyNVCu7zsVFbrJUOQF9rKiDfOKLWeHjHPhurUweVemaXtKYFxc6/st4
         xX75K7ymGyCAW4Z14nQUgHyMAEZLZJzdUdE0O32LQOhfA2xW0wqs4y4Qamzu4jsn7tjS
         8CgnE6sg/uNnvtLWBUKxrXRWcbNzAjNxNYuSsUsaHJzLHlthF4OExcw6y6WoqyuZ72g3
         NsEIgI0NtPb9LX9sdjwQNQaEMSpXzo1Yq8ILottgNafLSl8pUvOLp15WZ3ArVN9Q1mAE
         jKi6NfZBSgOPAuQZxx0Cv4S2O5RVDsa3BER/3diaVRbJeMebcEgv/emPvElXduY8BLsa
         STyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799392; x=1794404192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sqYPU2TH4ZpVQU5dx6i0fuxfEm+4/xI1XBznqOgTzQY=;
        b=aUY9zS1sA2o96+bwwvFWg0XbH6qBJAMuZsKMAZ5qOpaE11trRWA1GgNUnu2i5hvyjv
         xB1e9Tgm1K7Q8Hy29T74h2QaHC1SwIRrT2gX2WGAZhMOeLgVt2NBmaxCdhd/9MF+dNsl
         9LZWVU5QEoPz6DsV/B2HA+ZMcKcTD7ufnz0n04E1HT1JxFPGANja5liTZ6VzPNO43dyX
         muraNe668Z/z1d+BQ63vrc97+mWFKkX9pMy+6JfiWrne3LxsaFwHdu22KL6mXWdV1Xhj
         6R6Sh4zUZD3AXuYM9rad4hfo0CqKg5/ies9MAgYj/pVWzS4qkgVE0lBcGkeNPRFdFq/9
         msag==
X-Forwarded-Encrypted: i=1; AKwUvBwDefN/Np/UGR9D1hfczZbjA4FLWmnF+WKU9fL45A6pON1HZ87AkOfJqCn+TozBbcEHqm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RCXlt9LNoZPi3sPWCy1Tn4WnbYXvJBg63AkbySWwnMEwvVa11
	E2YcDOkzG4RyQqb6oUkG6QXb+SPO3jcoKX5LH9Q6V+XETeZWt+FsRQ3OiZlvrxHU1aFtV3o3bwZ
	p4DOenw==
X-Received: from plhc12.prod.google.com ([2002:a17:903:234c:b0:2e5:a015:564e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7d8a:b0:2ed:146c:cbb7
 with SMTP id d9443c01a7336-2ed146df644mr5080405ad.16.1793799391397; Wed, 04
 Nov 2026 05:36:31 -0800 (PST)
Date: Wed, 4 Nov 2026 05:36:29 -0800
In-Reply-To: <20261103015238.3780910-11-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103015238.3780910-1-sashal@kernel.org> <20261103015238.3780910-11-sashal@kernel.org>
Message-ID: <aus03eVALC1m86Aa@google.com>
Subject: Re: [PATCH v2 10/20] x86/sev: Use non-instrumented bitops in the GHCB accessors
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Chuck Wolber <chuck@wolber.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, 
	Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Sasha Levin wrote:
> The GHCB accessors are used from noinstr code, such as
> __sev_es_nmi_complete(), but use test_bit() and __set_bit(), which
> call the KASAN and KCSAN checks. arch/x86/coco/sev/Makefile disables
> KASAN and KCSAN for noinstr.o, which turns those checks into empty
> stubs, but they still have to be inlined. Instrumentation such as gcov
> can prevent that and leave calls to kasan_check_write() behind in
> noinstr code.
> 
> Use the arch_ bitops, which aren't instrumented, as is done elsewhere
> for noinstr code.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
