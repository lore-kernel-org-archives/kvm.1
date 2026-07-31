Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6438DC73
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528721; cv=none; b=He3OgcrbovnMc9nX4y4iYmuBCWtVqYQlpU/nxHy3UgLlZkUDeXgwHYY8Nev1DLMXkpEAO4dwQrK4O9r0yYOUvpsbn6ULKH2C2B8npHkxkTA5NT1v2kxQE2ivaimUG2VgU71wMiL28axWi/pxkdyId2t87EJN2MwxPTNDrCdc960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528721; c=relaxed/simple;
	bh=LsxCt0uEIhcpsehgdvvIOKBHVtrKHpP5FJAUxoXds9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9gZSt7No+lRQCInolwFfmTB+mlN2Nqs2PhOH/MJL8Q/ZB2g722YhYqivEDionxq5ylAvI9WXCOii97xMbVoauiYi5+PsHCz5aS4fhBQzuzsWlMhpUdBJ59VwPwbtEb3A8JoLr6W/KUteuYl1GHGIDhJYLlXfoxwfZYIyKnLCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiW/9n+7; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiW/9n+7"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so926736a12.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528720; x=1786133520; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsiVRs6jnmAlESksc7iGDBgskXSWOmg7PnBLPjYLXno=;
        b=jiW/9n+7cO6cUwS4Uj/Gze2eRVKWeiA6OdJ/bqtZgpwuuGXy+GSCYKC33D5ABc5w3O
         zpWfn4lNGdRJEvsYBThqCloLLHx2LAEF1pvDJNMbzUW6JnLp0E81eY/G57tODkii+0ZK
         9ybEHSMxfC06X4FRALW/yZJ+3HZhBHj2m6H3EvPB0ojnd7i3yLDlwil6fU4m1oUVvE3E
         ZXGcY1pthtNjuazbGA5QUn+VbPCJJ+KmTe7TfOmjZTPLQCpW8TZySuyJsf33tK0vaNvb
         vHbtaSc+FDGXBdTRnT2n3WS0C7yEkvDJhkZhuPC8fRzRu0VlZ+glS5gokxtt+0oDJD1e
         4vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528720; x=1786133520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsiVRs6jnmAlESksc7iGDBgskXSWOmg7PnBLPjYLXno=;
        b=g5GpLEDnv0bHjnHd7qw9VVuo0E1kZlnnwLZYZukYTXYu29ncX6DMayrzGlT+52IaXk
         Hz9s7yf22fyHXBz+H8hO/E1Rxq/xSQuPHI7nwB/bCF0a5Ofz89H8Z1V+IGJjiO/I0Pb+
         4g/ZziFWcCW+JLLmIY7U2B7aGAI5YW/PeJMpABeyEEzhivGh9BsqVo3PDjNq+udAF6Bj
         X5359YXJXz/MK2MnIDKKmUhTBbtydHhyHMjmdvuCK4S2zkdkUE12qGKjae4hvxcCa5i1
         VH2tS1j1fTumucdWb6/EBO+bE2bTbSM1lLE8NORr26P2AWaqVpHYTutRdQmk7QDHpdZB
         LoFw==
X-Forwarded-Encrypted: i=1; AHgh+Rrp5xfFrw7TOg9YXzAypzT5XkN3KyOJb4rWufPJCQbk04g3+ws27B+5sSyObsJjbcEJbk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDePuV+2FMBLTeFbQTHSB34NEEYiGM23mC67NrAmI92CAtcfT
	FMJ1ECWsgIT72lFFFgjrJiwTngY+/RQNanUDp4cdKkYaQsF30w1CN9kB6HybB2U7aBVAZAo0fsa
	ilUyP8w==
X-Received: from pgq15.prod.google.com ([2002:a63:104f:0:b0:c85:9c9a:ab4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:43a3:b0:3b4:7eb0:47aa
 with SMTP id adf61e73a8af0-3c92a8192acmr984192637.25.1785528719476; Fri, 31
 Jul 2026 13:11:59 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:17 -0700
In-Reply-To: <20260722230128.1587363-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722230128.1587363-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552829512.2708367.2323102326773578820.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 22 Jul 2026 23:01:28 +0000, Yosry Ahmed wrote:
> KVM services local TLB flushes on "full" nested VM-Exits (through
> __nested_vmx_vmexit()), but not if a nested VM-Enter fails (e.g. due to
> failed VMCS checks in nested_vmx_enter_non_root_mode()).
> 
> However, it is possible that KVM had queued TLB flushes that need to be
> performed, even if the nested VM-Enter was not successful. For example,
> if VPID is disabled for L2 (via nested_vmx_transition_tlb_flush(), or if
> via the MSR load lists, as the SDM says:
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
      https://github.com/kvm-x86/linux/commit/05a0b701d108

--
https://github.com/kvm-x86/linux/tree/next
