Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B544E379B
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286796; cv=none; b=HubO3mWpC36xD04Swv8TskBR1irApnAMW2USaKE7EX5TLo6os4O902y+f/skNcSoaI9wi9dK3hLNB9P5JGgSRsdv3EEJ/O/nBzZrcYaSCSNq+nHVHvDoZP9HIPRxZ+LDRbQXdQ/PcIcnscakWeppVoY0sVb18zSdpIQBtH6Ql9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286796; c=relaxed/simple;
	bh=RbSuvXpZGJzj7DyvR5wUr6ym4Nnq30Ym0ZQqCgZv2e4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fSakh8QOu3Y3FdoyhnNBDvNllt5Ldk/NR29OjmBvbHiNWSgKpRQ3stXtCsWhGAA+2uMqEj9l9t3Sog8K33xw9XOqhTvRJrIpdM+1X8BUtWzlJ0X77jrNVBdM3/Emr//jY0TWua6zHpQ3FwVhHr3m48HXNY6/MG8LXSOdbR+oMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8ip4hsX; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8ip4hsX"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso268414a91.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286791; x=1790891591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LkhgjIPo4LQGHd0bFnsw+pSTli362MQLpClW50HsSw=;
        b=u8ip4hsXZjYKo0/NLX1BwjJaC4gBAmy1XdO39VjPw5H3XSxbB7GkGlJKrpQUAK4s8A
         du6dRREUDc/txuUNqgmifo0zXCjZOUJRvecq0Ij2rrIObXgozG3ROlk3p96eqV3Rlq6H
         0VZgFQggx6if0cRZKzYWCC6YjVcXBpqxK17eahjRUX/oA1AEJ/SdXmiz8cn0L8rm1Yon
         Y13vLKjLsQ7xvCBH3yzR/Qeeu22BiJb6CB/joUSsLJIAnoRhJFRTW5ilTW4mJ92UzG3q
         GuHUfErxnYmJ4J0LOQGgRGfeB9VKqhDQE7jSsTblK46+OBE0rEozAsPCk9yb4gxtAEjp
         osWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286791; x=1790891591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LkhgjIPo4LQGHd0bFnsw+pSTli362MQLpClW50HsSw=;
        b=WXwPLQS/3xokzFGwIhXwK5uDJx7ZrrMyBgzyctsS10w0Pfr5tVGIECxhmqS7M1fUbn
         BVc3A+PyWO3baPxOuhy5k2EQ1F7rJ5liwNBR+RIMjXf7qQDeHMzBM4Qeb+8/KsI8FrYo
         mUcRej/oCN8hnbTovTk/9sUeRdRIRVCkKurSK7tKKE1hekFDDpOSVD5ExnnLdYs+uyRO
         Nn/gSTGDos06RuBTAUb9nXdcGrTyEFovMfDnuJbl1K4tdM1GWMY3M8owl1RDK5S/DNQa
         enULpvVl/vJMZ30uCTiOorOEBqsX0002G8Yu3YDs189CQhKn1PiA153Win94TGa7b49F
         Cq8Q==
X-Gm-Message-State: AFuF++nbcp0PeD4sQ2Q8xGmq0bUwox57szB6tlXcfWVpoquCHsJvUZO7
	PhoIuHUyhqLlUq7+xUi2wovGvwBrVMFu660blrf1LzOycEp9huWzyf1kznK3dnIFlrIf3s7znWN
	HCgeBkA==
X-Received: from pjrv22.prod.google.com ([2002:a17:90a:bb96:b0:3a0:9658:1de6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2703:b0:3a0:2ffd:1a4b
 with SMTP id 98e67ed59e1d1-3a098ce5269mr3354853a91.25.1790286791218; Thu, 24
 Sep 2026 14:53:11 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:51 -0700
In-Reply-To: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028368772.2007408.8775233545709825615.b4-ty@b4>
Subject: Re: [PATCH v4 0/5] Stop returning struct page from guest_memfd PFN lookup
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 09:01:45 +0000, Ackerley Tng wrote:
> v4 splits out a new patch (3) that makes use of KVM MMU invalidation logic
> introduced into the RMP fault handling in patch 2 to avoid warning on a
> benign case.
> 
> Other changes in v4:
> 
> + Took Sean's version of the changelog for patch 2
> + Picked up Fuad's Reviewed-by: and Tested-by:
> 
> [...]

Applied to kvm-x86 coco, thanks!

[1/5] KVM: SEV: Treat unassigned RMP entry as benign race on PSMASH failure
      https://github.com/kvm-x86/linux/commit/211606532680
[2/5] KVM: SEV: Drop page refcount early during RMP fault handling
      https://github.com/kvm-x86/linux/commit/375b32931b5d
[3/5] KVM: SEV: Check for invalidation before warning on unassigned RMP entry
      https://github.com/kvm-x86/linux/commit/acafcf32c83e
[4/5] KVM: SEV: Drop page refcount early in VMSA reload
      https://github.com/kvm-x86/linux/commit/3c427e5c0347
[5/5] KVM: guest_memfd: Stop returning struct page from PFN lookup
      https://github.com/kvm-x86/linux/commit/89fbe3de01cc

--
https://github.com/kvm-x86/linux/tree/next
