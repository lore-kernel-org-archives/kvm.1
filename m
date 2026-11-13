Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578009;
	b=djD1jEKZpTf/VR4ZmjNQYQg31hYhllc5JtYw8JDa4G4i65WBGtk6kBi7/LoFryVObDVs
	 I6WbdF1wljzr6rTGsnphq7AGd4/xxkb4UIXQZMAaOi4ZTsslS9ksX4rE60R+z/CDeSN9q
	 AShKuRQvvsP6X4knfERQhDCGQh0gHEU9sXPc+C5Hl1etPI0oWiLKPDxzylQNKtjvWZnoi
	 wEmrNz+1Bu5s+gWMlHvyBZAb1arxqqbmdZubMFbkhI25PCSbCHYaHksiVWFALvm5iMwdo
	 Idxo0JUF0ECWLACmepZTqGqk7+so4PTTPasmxQNRWRSRF1a1IG0Ts/e4k304nQH2fXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=OpvfzW9Dt2ae2NU+aWz0za7rartm1yMIX237xsigiwk=;
	b=B+aqc30jM6+pSYaKCCfRUYfs4zBWdmMJvvcXQGijjzKH2nP/XNg49NTtNlQj7y2yfOfK
	 vy40utXWmPFmGrnJBsezTPgqpH5nSnr7x60H+evie3YorNCBo+QI5QfHzlhl/tAmtED89
	 e3madmEOYh7hqTMuoRg2ZK5LYzyc1NFtfcQqZBCAIg5IhS6CKHeZpOqlU0zKnrMaruJK2
	 TD9vfDmAfLrQnwNm84tIrK30dO2QXrW9/VPNA+eu8UyRVm5Cqcuo/KfURBjWAkYniZXDb
	 AHrLo0twuoqgGDXEwTfvNLDu0oMRLat0v5lwivjK+CRVPXjeJTYWISKePL/dPN58l5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="IyRE+h6/";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0C606A331
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB0C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IyRE+h6/
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso9462895ad.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794578009; x=1795182809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OpvfzW9Dt2ae2NU+aWz0za7rartm1yMIX237xsigiwk=;
        b=IyRE+h6/BprbiT9YfKqROdO8bQAo+A9P5DBpWh7NAFxsTtHmRb+PVB5foakalhsJLd
         //dRxsU74v70M8ZO1jT99iOuMazMM8iqLyrZx1WAEt1BUTP4FKjYMYPPFNI97wq+wt02
         lfjJE07r/cctnslWn/iqQVQmSSfRNdwiTbfXFSygjUlo+g6GKgv5Luz2SAuCbiNANTMk
         oYKThmDNsjeKbGRyB+ZLHPyVHvIZy4k64/K2ghexG51Edu589TTsc/CZm98VspHefSBZ
         gxoYYRO/HhDZPMP8MehkGZYX1ZiGTzy7mDHjrcuCZdTGDEj0E1yEQTLXR+ChBQPA4KCd
         Y9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578009; x=1795182809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpvfzW9Dt2ae2NU+aWz0za7rartm1yMIX237xsigiwk=;
        b=ln0N1NVV3G8g2+WauOe/9bp8a7/ZYWtY2lx+n+6ENb0VwZRK1Gxg7zAKcqckNiUR1H
         5j6MDHnctJ3oX8V+4BxDloNATaBReHQq966p4WMa1DZz4QeyxxZSG5EmxNjStxWvFUfC
         wTN6Sv25HJgP2bsG3OTGFKJ1e710dugBUb1/XYY2Bb90UA5fI+gyZ8dxOG9zL0UdmTb+
         8MhPTBdsag4d/BjJUmOv7sG5yxL3PHcfroCzi9f4H+DY6WqyIbBAQuWgjW89v7UYK7JZ
         e8YJma+ITXeDzT8SqNkmL36nnIwbewKpknvH1d3ZAmbhFHLy0WAWYcmdFqAs2iwIQnfm
         fkGw==
X-Gm-Message-State: APuU4Z/lRr3PKzCfmMxcJj4qhL5uVpyE6bNA6C6/hrx+y8KZ7qOJKL84
	PrKadCpuXn0PUGrNU7QPdcLbgzT7jVOkVc7a/mSIw+ADPQVzf5qTWg5E1D+OSdEa/JuIo01p7e9
	IN0THnQ==
X-Received: from plbkr11.prod.google.com ([2002:a17:903:80b:b0:2ed:8abb:208a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:2e9:9a19:c5b
 with SMTP id d9443c01a7336-2ee0dd2382emr24969425ad.47.1794578008628; Fri, 13
 Nov 2026 05:53:28 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:43 -0800
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441819203.80207.10000872984066251793.b4-ty@b4>
Subject: Re: [PATCH v3 0/5] KVM: nVMX: Honor L1-owned CR0 bits for LMSW
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 30 Oct 2026 14:37:42 -0700, Sean Christopherson wrote:
> Fix a bug where KVM ignores vmcs12's CR0 guest/host mask when emulating an
> LMSW from L2, i.e. an LMSW tha exits to L0 but not to L1.
> 
> v3:
>  - Handle the read_shadow in handle_set_cr0() (and for CR4, because why not).
>  - Kill off kvm_lmsw() entirely.
>  - Add a bunch of comments to the selftest to explain the dangers of running
>    with CR0.TS=1.
>  - Test MOV CR0 as well as LMSW.
>  - Add a patch to take full ownership of the must-be-1 CR0 and CR4 bits.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/5] KVM: nVMX: Preserve L1-owned bits in CR{0,4} read shadows
      https://github.com/kvm-x86/linux/commit/3193e9153882
[2/5] KVM: nVMX: Honor L1-owned CR0 bits when emulating intercepted LMSW for L2
      https://github.com/kvm-x86/linux/commit/7e538a7bb16b
[3/5] KVM: nVMX: Synthesize #GP if L2 writes a "bad" CR0 value via LMSW
      https://github.com/kvm-x86/linux/commit/7672fa397f00
[4/5] KVM: nVMX: Take full ownership of the post-VMXON CR{0,4} must-be-1 bits
      https://github.com/kvm-x86/linux/commit/565c14684d6f
[5/5] KVM: selftests: Verify KVM handling of L1-owned CR0 bits on writes from L2
      https://github.com/kvm-x86/linux/commit/798e54a8c0bc

--
https://github.com/kvm-x86/linux/tree/next
