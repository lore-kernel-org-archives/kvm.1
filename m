Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28234DCE0
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229263; cv=none; b=d4HkzosvRq0gjkiJ/SEE9f1OWoxfNZaZCHjhphl9RoJ5SXIp7UlFS761hBHssugF6ucmX8qPgrCkZim4ZrKO9KgYKmR2TAqLRSwGPXDyJjBErs7W3WvHG5YvlyWlSPIXCTMbp10eIYM6AhgtbyehILJNKMucjnwyZHeAE1Q5uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229263; c=relaxed/simple;
	bh=qlHtJ6m/TAoFsmqGRXpyKZKCSo2xyfqnaL/bit1YejE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TWfRCxtG04qwYvZNeQJ67zfN6M+UPitWFDPxuJZn4qaN+qLigGzoSiCS3QNVEvAY+iJzrluhs59Ilsqr4URxoN/D3kD7bDK0bp0+923YfkY/2qdgjMzwTPt82i8y/TX/9ECvqErhOiQxv0LvLpFWAL3ct6M3cQUgA0/Ad1H6XX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JH1Rk3ZL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JH1Rk3ZL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so957014a12.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229261; x=1775834061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCF+FtQNlCxdKiriZjT39tlEJVOXKvGPe+IPj1v45aY=;
        b=JH1Rk3ZLyMqd0R28wxFwAgABUFu+awSEpROekWHoyaEgsfL2484bZ9EJYbzGaSon/N
         +WrJekVR1L0W6ix2LPa1/1sTEQTfGnIwFDRjNfONQcYCWPEALAeca2sci4p5qK/Iv4jx
         Aqz1JoPN+bE/V3uQpEt+BJOIxX+crpZ3GuuE1uxiDX4dre346qKH+lJ66XvttEdPT95p
         vPyxhOdYfGImpFfkILKcbg+EKxMgmZb6+lbe2FWGppaO0rfR5OW6DKevzC/HzHqWnWJA
         krniG6BlC3K1gILaPCGevyHLQqZcOby8c7v1CSkPMKZAqhJTtQ/ldPyssJjrTplZp42V
         w92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229261; x=1775834061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCF+FtQNlCxdKiriZjT39tlEJVOXKvGPe+IPj1v45aY=;
        b=Uw1kSNm8Bu8RW+fHKIZxVtDYXSJO8ttlPbzVWf4gVmc3Y92cTpp5jofznOZ+Gl7uir
         ZI0S1RQQfjJBOX8J6wrLpj7pMdMUSRXbeJreKAGYxXnypG06Q9kUc7FOnl1fUmnFgbHM
         Q4qI+6nZzNv4ONC+4u500mwmgMEMjd0/KBC5ZNvlV7E8ahjI8ZqLA6DMOyUKwLl7upzc
         S5lATT6h/v5ZPxIErgjM9EdJI300DvSQEAZn+XGhRgmaBoUE77Fq6SwksaEB+Jc+IT7w
         ivV/K8en/o5oOo0SOqLfffUCE28MomTut73Qho/aS3l+K40wqBQGHalLcUeb04ylCoJZ
         xeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX1gtVkvFMC9BySHvkSJn3+QjGhM9HsIti5vQ/onN502w4yt/4a0SJowJoZ9/s6MffghY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwZN0qWcuRtIdKGwyLnrHEPCgJYh9Fy48nbE0vBIvNHdaJS1H
	rppnIGuMrCEg6SNS7np1EfIcgHXK4B5BSywqvq+MpYJ1Hr43I/DJSBimsqbaeGHdDR/P3bZ0hjn
	gGSi62g==
X-Received: from pfblh1.prod.google.com ([2002:a05:6a00:7101:b0:827:1713:6de8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc6:b0:81e:f1c3:89df
 with SMTP id d2e1a72fcca58-82d0dbc0dbcmr3213528b3a.50.1775229261269; Fri, 03
 Apr 2026 08:14:21 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:48 -0700
In-Reply-To: <20260210053511.1612505-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210053511.1612505-1-nikunj@amd.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522902748.296244.15262905049735406317.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM)
 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, bp@alien8.de, 
	Nikunj A Dadhania <nikunj@amd.com>
Cc: x86@kernel.org, babu.moger@amd.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, thomas.lendacky@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Feb 2026 05:35:11 +0000, Nikunj A Dadhania wrote:
> Advertise AVX512 Bit Matrix Multiply (BMM) and Bit Reversal instructions to
> userspace via CPUID leaf 0x80000021_EAX[23]. This feature enables bit
> matrix multiply operations and bit reversal.
> 
> While at it, reorder PREFETCHI to match the bit position order in CPUID
> leaf 0x80000021_EAX for better organization.
> 
> [...]

Applied to kvm-x86 misc, back on March 12th.  Thanks!

[1/1] KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace
      https://github.com/kvm-x86/linux/commit/de0bfdc7137d

--
https://github.com/kvm-x86/linux/tree/next
