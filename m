Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577793;
	b=oz6T9x2aj6IwMrJYo5kK2PUQtQQRdRTr8lH1eNb//ZneYoWi4kca8xd6BtuxGqIPwjjr
	 y1nMPyyZQQNA996Z2ptvY6ZHiRqPdTXME3+2PxgzsurawQ8w990w61srDYdUTo3E09CAr
	 MQ4fh9Z9rpAbNkepOwwQ/m07Iw05ZJN8cTNGQVZDP+U4YzljpfAJungqUD+19HGQ95dDT
	 kQTnyLlEhi/lST73Hmaw2Cv5b9WjgfAeKodpmCde7MJwSS7U9J/Sj93fOgChjMmX7Sgom
	 0BBnSaHQN9tzGTsNs4n66rai3ktApg6YZjVHt4rW9spc8wqSRTyBEAMzyT63iSEOwnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=b69T+QcugpATwxwKqdMEujcVwSj6b7odGHK++WaklpQ=;
	b=2QMMdcO4GgLgSwknHtzkAOGBzaIlSRRWTOzUmwY5oKD1f+Ls4Xz4j3MjdPubRP7h0xSC
	 aAKv8Kn/hbpHGVLUpORN/nWGpIBTLUJI4V0Jeai6Bu/ytFNw0mrcIb5OVtbI8u3+Z8dFa
	 DFEGuM3bvFCTv+nN1W+OCLQibXva1NSQpRWwu3jRDKR8Mxfo7Iiv0rOFPjr5oaGFyevAz
	 einGca18bRvATPokh3AKRt0ljxta3VewqEEl6mi5yCbmTF41GjmqSFJaFKNCCGebBvHFq
	 RFcT9GCJN4J9HaisfRH2Ii4cd3SPg8QOxZWUCutxgli78MrsLqKnUHO4cynRPHT7UZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NTpCEFA5;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68260A2624
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C68260A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NTpCEFA5
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8dd9b9743so13465905ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577792; x=1795182592; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b69T+QcugpATwxwKqdMEujcVwSj6b7odGHK++WaklpQ=;
        b=NTpCEFA58Pmno0zFLkNqa0oGWJF88P9imPpX+E5AfxnbiWWMyRW94nDaKo2SeeyO2z
         AEmG42yTokrScGY8bygZhWASPfhMBRlJNvopg4rmHLGqeCo5EErL4aBV8IPLWCOAbkXb
         WKSJQifPR1F6o15fMlysacrd7L/eAK8UD9l8TLU9G4ZOe1sxu0VplnQLXoqPXfR4W6xb
         TeTg46VFw3TYiKkAPaKZTktAJHqfZRLsb4QE02M6F4qKhfWWJJT3xpkwspmHYWMKsC/c
         xpl0nmxvcm4WN8udxn0oZF/OgDhrQ6MfSn2WOBzjU3h9dm+gG7w5uLzbYsFiCrAMnSsF
         0qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577792; x=1795182592;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b69T+QcugpATwxwKqdMEujcVwSj6b7odGHK++WaklpQ=;
        b=eGC3JhpNPbZaVtZLayN+u0/I7dN7qslC71y0VXR4ayKiNFrTeu/QrRD5DQN9UL5Xsu
         EfIHOBM50vO+nqKZLiA5ckI+KbBwv5X6fQKz7QoDTXBgBT3lNc2t9lJ+469Y4CK6tDVe
         MwRGCDcSe4fCso9GWFW8ER/Z4G60Kt3Aa1uVLO4r6ORLLVUwWLUT9sa0MNRSYY+4IR1z
         aIy0zqJA/P7N/CFtMutbbajrZ4Dyuq/Q8kHwrS2wFgynl/OhxXFDrMkllGaLBk1fGKPT
         6OtFWhEhsrRIQIRw4rUVELlpvvbodEz07iWKziP2ryWPMVMDZY8aqJ1MiGB++OIT2GRA
         cWiw==
X-Forwarded-Encrypted: i=1; AL+hErG6Vck5akNZJLJD9NLxLB8lS1BBXRtsl9KduPJdU9HWZX7qCZgaSie+37kxi4g41+irT9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sBAnOASPoVZmI4j+Z6ufHXOBPWnN2ldEMeCLv3THUJXqpLl3n
	5IiIs0U+y2B0zYqh7eyzWyD4g2aCqCKjRgIMb2aryxVzrWBFaGogJ23CzT1ps6hZu8/w972fRwI
	+RUpXMw==
X-Received: from plpw11.prod.google.com ([2002:a17:902:9a8b:b0:2e9:db6f:41b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1846:b0:2d9:599e:df95
 with SMTP id d9443c01a7336-2ee0d6600acmr27342415ad.3.1794577792313; Fri, 13
 Nov 2026 05:49:52 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:46 -0800
In-Reply-To: <20261104212456.9835-1-laurian.iacob@yahoo.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104212456.9835-1-laurian.iacob@yahoo.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441817794.79965.13636393461318165442.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Fix spelling typo 'RECIEVED' to 'RECEIVED'
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Laurian Iacob <laurian.iacob@yahoo.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 04 Nov 2026 23:24:56 +0200, Laurian Iacob wrote:
> 


Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Fix spelling typo 'RECIEVED' to 'RECEIVED'
      https://github.com/kvm-x86/linux/commit/1d58c6b5db04

--
https://github.com/kvm-x86/linux/tree/next
