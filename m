Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577996;
	b=2iY1mAuWAmvxaoliFqjzlt+LsF/PLmvgBwpBggxys5a88B1VBJw8aAaqzoTtnqGDT11g
	 eKWW8F2bRWdowa/nPoTEVX9x8xiFDzHJApfOPZIgJ4l3esa5deY631dfTmSoVwn0IjTWR
	 Hvgwgqh1oXh8688kvuBwT/SRjvVBIID93uHWIEQr9wKKS+1fVUwJFGdGPt9CSdbZ0nJ5g
	 A/jY2u63S4XWXzVUm3bwPn/de0xrzPshuki9Gbf6WkRV+agspl+qO0IvAr9HCPv0k4lcX
	 U76WCfZGIknNd/PQPo4MdoVjtC0wFs92Jbk1hWUYQCRneMFENcZhVTJhEA9xVC6JsXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6l5WqWAolDE7/fvkgj89NEfKlQfjgjFofvc+SFBHNQg=;
	b=fwcprv3hzEQYdH/8HcOBEGfnq9aEM4gTdnIDUy8EzKY909ckWNpYNDEbL9i7ZvzNwWgQ
	 K9uDf2+qWAUZWJtkY/Bfi72t75Ui/uPsjdxyR1SfSRvc+jntzz3098SM6jqQyxldy3RLf
	 PdoKKSyjC7P42wGrq4y0bEDeFOI1s1iKg+q29YBQwfSY0xzrP0CTGf21IMQW/glwcpFAg
	 3Hm0c/1q+fCyZFsQYSt1AVPqzrAeofZ6rfpJb8QkAE5AROTwTWjF/MHCUzoau2b3HjTsL
	 68gRMvrmWwYqZNmU7+KZQu/ReDL5Km8EsssjCtja9+Vzsfl9PMDDPzHzqyRiAzAivvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dwviWv4R;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B02606EB27
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B02606EB27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dwviWv4R
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9501034c4so16899765ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577995; x=1795182795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6l5WqWAolDE7/fvkgj89NEfKlQfjgjFofvc+SFBHNQg=;
        b=dwviWv4RXPg/0YKA9tNPmjnBamsDtJRYEgdw/iNJuMl3+2ESIlYdZiMFlijmewQ/J7
         4+c2WvMA0xvT8HvG7CrT8is/B27x2qVmIOo/YGPLAXiRlFIiZIhiCri4Hv8t33LeTboI
         IZTWuy3GpVU0sp8892OMcpp8UtsSr0pWqNAAhehkG38PG/9FiC4B5Ypq1t89ZYJJeOGY
         GbBh0YjxI6G+3ex2hrpEFVmboVBiUxubV/ibzUD/RyDDQoIYuXvzwIGWWk4+3f0WLgEJ
         ZWBZLvskInULdXISyaZd+P1BG+2EnrFv7HqcfcjuTpO04XWVyhLPjDVzHDXQPPte+zv6
         sTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577995; x=1795182795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6l5WqWAolDE7/fvkgj89NEfKlQfjgjFofvc+SFBHNQg=;
        b=r053qLgkTsSM0UvfqbjXiOhqRIcjUsjK0d1MgQEjnbwo9Ubbz7fJhlAARO1yqX13uq
         uvFrb/dCgWUH2u6dM9Uj/6Pyh60S/fTtNDrdGREP3pY+AIkorqAPMrN4YYqua2fF4hn2
         nehTVe6p5VB9bVcWCjG3sX6G9fVd2ZwUufvuLqSZjbXZ56DHVoytkOMUmlmopqJxpzlV
         VPeQB7C/j0yaPdEnp5ZIhKpTSL000OSAZbIkbz24aXladkVLIt3HjKl9gsUWnp1Ey0pU
         k0HPJNH/bfdok2OPKR+71FZYM8QM10Tl9V3ccGsMW/5ZH02T/UPCqeHEhfE5vBFT0v/P
         wpkg==
X-Forwarded-Encrypted: i=1; AL+hErFKC4l2ew46GSsxhQ5p+n5o9Ea+FyjnSdrqRaqHMWqqskS9A38baeM9C+ip2wj4IXhUdt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pATEEfUBR2rLINsEqoO50mHB1UCQmui4+BthWg2UOnuLJOFL8
	0oWBVTB73uguwmJC0mdvguH78OIw++8+O5Z6QuBh4wysVW9dsMBjIce+zgX2sBOBrg7HGcraXNe
	pBThLrQ==
X-Received: from plri13.prod.google.com ([2002:a17:903:32cd:b0:2eb:515:b000])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f641:b0:2ed:2a1d:e36d
 with SMTP id d9443c01a7336-2ee0de17949mr29320655ad.36.1794577994748; Fri, 13
 Nov 2026 05:53:14 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:39 -0800
In-Reply-To: <20260930001127.3170009-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441843259.82868.13458135372084486676.b4-ty@b4>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT Violation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 29 Sep 2026 17:11:24 -0700, Sean Christopherson wrote:
> Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted page and
> has disabled EPT Violation #VEs on such accesses.  Returning -EIO is all but
> guaranteed to mislead the VMM into thinking KVM (or the VMM) messed up, and
> will likely result in the VM being terminated instead of rebooted.
> 
> v2:
>  - Return SHUTDOWN directly, via a new helper. [Rick]
>  - Ratelimit the error message. [Sashiko, (and past me, amusingly)]
> 
> [...]

Applied to kvm-x86 vmx.  I moved the ratelimit patch first, as Yan suggested
(ignore the ordering below).  Thanks!

[1/3] KVM: x86: Add a helper to prepare vcpu->run for a SHUTDOWN exit to userspace
      https://github.com/kvm-x86/linux/commit/def30ba0b6c3
[2/3] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO on unhandled EPT violation
      https://github.com/kvm-x86/linux/commit/a1b89df10ed8
[3/3] KVM: TDX: Ratelimit the "EPT Violation on pending acceptance page" warning
      https://github.com/kvm-x86/linux/commit/0b1431a34f1a

--
https://github.com/kvm-x86/linux/tree/next
