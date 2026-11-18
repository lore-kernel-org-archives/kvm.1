Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034266;
	b=eVB5+XsslyGg732yrgI8//BGeTXMcCuFM1L+FORQ1uWF1yj/B5E5zcS/e03vT2C6r6ck
	 cpZuNqdOzf7OvBxqPh/UuZV/SlrqHbrpUfs23PAHIV3HSaRc05ubsWuahpmLLUY6GzNBe
	 50MLGZazu/H5WJpyEEQbwhsp0NpgozybDwUcu1ftgVIqmqbHzJIvJn6D8jcsSMwfIBY/6
	 HmfX4z8YD4SDIRzwazDZlYzXFCFBTXgfQKY/q1r5HLyTsgSNvbJcscvCk/NX7P2nVYwO7
	 aBvCexOpq2m2EmsZeTl0koo0vRfUZjy14VYOV3HX3DkIH5TM7NAvDKPg1ZJBAuc7ZYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NP9MdhxeGHGArR9vL9Mt1yif1925+jhMGTONFGDTnqM=;
	b=YtT83sLZFCCld9ZqVdt7uGil6UF9OTRtboIBdC78dxteuYbAO2LFCPw9bWLVgMUpK/li
	 hi8s+46cVRdG5A8QzNHp0MsRBlCM2vBMQe0J5w/S7X1bUFPC4U3njcpxGS4RIPIIEmefe
	 Kf3j4e7LUxudYI0se1dJ7WV8Dj0AMH/95QbUmfDMjp4P0JBuT/Eg2eQGnvM+gO7q0XvvN
	 YRt7TjX3fAjfb4daE2LhCP/lASdvzSPcky1VCZ/i/1KFZ0DrQxiVurGeAzFzPKjKG8ihe
	 2mixRXGbZcPoP8W17auP4Eg9dJxBfId/Lcv/u7Z7bDGuLjaU9WDUxINtx587On7h6CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O3fAVGZW;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1118606A32A
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 20:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1118606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O3fAVGZW
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05a4396d2so1310649b3a.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795034265; x=1795639065; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NP9MdhxeGHGArR9vL9Mt1yif1925+jhMGTONFGDTnqM=;
        b=O3fAVGZW5GSWcR94MlQk7II4ZeROs0Moys3uH7ZZUPkp+c3jhUSfRUXQHymuefy/KX
         Gw1cXCpUckYqQV1CsaqIOvN3PFMFeoeIgMfQvCOO63fpBkNV395jgBxrfdPAU/iivg+q
         Io2Bk9MQ2rXK1n2st05Ku7993imfqvyDPJD95xfOqZ5sGu1p6DrBj/nBYj2DGWp0uUaf
         iTYjbGQ7KwGgj8nJy37lxyAaVEQ3tV7o3OE8ndxsqiSWJIbID1Ml1oYRC+1nTadxa0uZ
         rJFWzK7KZat1dSverTONkN3+enXSLcvIDY83YUabTsdrbRUpIgRdt3+Ag37vZ9HSw0Wo
         8iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034265; x=1795639065;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NP9MdhxeGHGArR9vL9Mt1yif1925+jhMGTONFGDTnqM=;
        b=08vmoJ+bfdSFstSsywIjy9ZPfVi0ne/KgDNNO0nAXD0MPdpbiJjrvwgHq6Xqx5lGw3
         MlpgUjAVer7zs64hp/JJ95nXoujQSQuz+arBVww0r3JGiIz3mvY70CjvG3c8YXsBcNzr
         kqImXIvRmNZB3pj1+bUUosfV/iduqnUSzR9//++AGlzaq2ttqeiQih5nT3WVNLGdRbPh
         blj8QpZgrUCfUlAODBmqhf3i+UXAmeG0WFsaJMP3Wv0gwyHHEasC1gKSJMA3CO9gmZeH
         sWGJATs7A/HamAhibc4OxNJyafuYnoD+UVJ60Z3GhVYcIaSjEEHDaNrTF53u6zrjxtKD
         Rn6A==
X-Forwarded-Encrypted: i=1; AL+hErHMI/s5xLpqxVwk/BE1HiYfxrPeRKpEtvGb0KKvZqCWrlMz+swnMU19KM7XFai9H7avlwQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hqa8qZm1hfudfJn0j//yNjt3PcGJtA3kixZVl5R99h7U58MnX
	2MNNRyLgcX0P/W+/E58CdmvmeKn7X+VufCj4c+5D5sgZfyYy815e+8MY6Qag2zMGn3hk1vI8cGe
	02q6Zeg==
X-Received: from pfx48.prod.google.com ([2002:a05:6a00:a470:b0:8a0:8283:82bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e26:b0:8a0:7140:7fbb
 with SMTP id d2e1a72fcca58-8c5d558e278mr3054253b3a.51.1795034264755; Wed, 18
 Nov 2026 12:37:44 -0800 (PST)
Date: Wed, 18 Nov 2026 12:37:43 -0800
In-Reply-To: <20261118203408.98649-1-streetster@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118203408.98649-1-streetster@gmail.com>
Message-ID: <av4Mlz7fOP-EeFA5@seanjc-mac.roam.internal>
Subject: Re: [PATCH] KVM: x86/mmu: Defer TDP MMU RCU callback barrier
From: Sean Christopherson <seanjc@google.com>
To: Mark Street <streetster@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, seiden@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 18, 2026, Mark Street wrote:
> TDP MMU pages are freed from RCU callbacks, which return their headers to MMU
> slab caches. Waiting for an rcu_barrier() during every VM teardown makes each
> VM wait for all pending RCU callbacks, including callbacks queued by
> unrelated VMs.

Wrap your changelogs.

> Move the barrier to kvm_mmu_vendor_module_exit(), immediately before the MMU
> caches are destroyed.

This was *just* posted.

https://lore.kernel.org/all/20261118-feat-kvm-tdp-mmu-rcu-barrier-v1-1-24106947c616@linux.dev

> Set the owner of KVM stats and per-VM debugfs files to the vendor module so
> open files pin the module and prevent its exit while those files are active.

What does this have to do with anything?  AFAICT, this is a completely unrelated
bug fix.
