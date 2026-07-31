Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FE331222
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528642; cv=none; b=FMfO7deYpLI1R3ZkIlcVN5yu43eyiG/J8XTYT+gFU4KOTgGPog9a2OI0gq6qT+IagzevoqzZ4JC65HBTYcXqRUwq5nqebTImWR1ksfYpJtyeWpK8na7dZKPtvTr/NES/tnE5SgQkKSz0Zkt6jIO7l9EYCT/A42GOuQQj3lgCZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528642; c=relaxed/simple;
	bh=I6na69F/Nuy0VvfxxAcYJk/QzSruwLvHmQEDbjV5h2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9uq04be4psy8o867/9i/K1AtOEXROwd+brIsRnmIgRe4QFRABA6JtlpkJpwaPRhsSyh9QU5j1xqVFdNxwW8vm98o9+7bELx8AGg7+CCltU8ELyvB78jEHVMUhgPPQQ8dlhQGSAxLKzbDQsFk8+3Hv8NOQksMmLZLAccjLQVdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obIDrT0h; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obIDrT0h"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa55c9430so11918205ad.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528641; x=1786133441; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU39kIkoMhXTKKpE37dh0PJvK+pnljqlvEGquRB6geM=;
        b=obIDrT0hWY+wXtjielfWNeaP/hh9geESH9WBfktnprgs5OgxqIIgsvQ4PJppG+CYIi
         xX1t8Iq741ZUBvwfbYlVXzVTUnqEjh0rmRMcNSefeE4XyQfEbklkZ3Y1L2kxVTIZ0f+I
         BN2UZpBvWDU3wvbdV1T5j8Tn/2B3DMm57FbIk9qB0NLIj89ppzdaEcN3rLFtEmghFBWs
         OypFOAa67jHLiLHnPYHGQ5Ph+Z4SQK5+C0L4KRnvkUBzYuB9Q8ylFrBj37yhplV91y88
         K187XoToZ1tqmXVcbEUW9tBffIzq4cYLJrAp9h7idzeYDK/ecVn2LLZrtRhIcD8Za92j
         eSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528641; x=1786133441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU39kIkoMhXTKKpE37dh0PJvK+pnljqlvEGquRB6geM=;
        b=bDj5n58zHvfSXAGNaNYnZ/ys79GzxemGD9tiMJLnRFR7eGLJ5r/8iFszMujLydPkp/
         eZQS/cAtzKprDO1kVSTSjUlIl20p0A600QJ58xLI+DJS7ya7lxeH6SnMCCltluwC9Vbt
         808FuZH0wZMUnpceBsau0/q1Jn5WrtYcZ84l71zUoNYgdoyM7g9xHNMy5SiX3yhHRyrz
         kUOZ1pCuea8e0Y4A97SiOSjQ2baoiDM3nvywI2x+IuUS3/4OzOcd58q564KuUIjFxBCP
         BCBTbL44RqEP2wKkz2NtFXjBJlcezOTy/sBEncUTM1w++Wzn0ScpC1PH6932TenD3v6o
         72Vw==
X-Forwarded-Encrypted: i=1; AHgh+RphZbeTKhBTA7vM5rUk74Zxc10E6axbuDy6u47bC0k5PcO3DBrI71n2KCBmEolvj19hCns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQ8yIVLXNEIo5WjCX5aThlR+sKnGZB4qd9+EYoxvlAw/x7kMf
	1/JeNaJ+ARvQLiKnsoDrrjMg3GxGYlFx4rxoETq6GtYdm82fbVwHUyxbF5tz3gMa3Mq2SkpdlYf
	MzSdCkg==
X-Received: from plbi4.prod.google.com ([2002:a17:903:20c4:b0:2ca:caf1:5e10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390c:b0:2ca:ce92:6e44
 with SMTP id d9443c01a7336-2d05218984fmr11367635ad.8.1785528640749; Fri, 31
 Jul 2026 13:10:40 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:52 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552810478.2701886.12087185654970147716.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: Harden kvm_vcpu_map() usage against memory leaks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 23 Jul 2026 17:47:51 -0700, Sean Christopherson wrote:
> Harden kvm_vcpu_map() usage against memory leaks by yelling if there's already
> a valid mapping, and then unmapping the existing mapping before establishing a
> new one.  To get there, add a CLASS() for local, on-stack usage, to guarantee
> the map metadata is zero-initialized (well, so long as the CLASS() is used).
> 
> Prompted by 2f2312c422fd ("KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
> due to invalid guest state").
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      https://github.com/kvm-x86/linux/commit/11722439fb20
[2/6] KVM: nSVM: Add CLASS()es for automagically handling local kvm_vcpu_map() usage
      https://github.com/kvm-x86/linux/commit/d196e4d91e78
[3/6] KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
      https://github.com/kvm-x86/linux/commit/b717245a7b08
[4/6] KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap merging
      https://github.com/kvm-x86/linux/commit/6bb3493175d8
[5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz
      https://github.com/kvm-x86/linux/commit/e060b94a1cd4
[6/6] KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking references
      https://github.com/kvm-x86/linux/commit/e186d4e34ad5

--
https://github.com/kvm-x86/linux/tree/next
