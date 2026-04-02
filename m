Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282D363091
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171981; cv=none; b=N28yT/V9JqUhA7vDxLITWRWSs/LRFrUpETNi89SOjNKIrxA5l3R9FUkOCQVMvFeJi3O/DxegqZRV2cimJaJ+zpPKD98NyzrHaoPGPzq18aeT8/y3yXXrj502boINj+tliDn+UJiFLz/cu4Jh40kCj8L+DKJ0MuO08ZwhU6r8P5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171981; c=relaxed/simple;
	bh=64WF9D/zEKwq1YYpyTovrgO/rjWkytAHL1xAfHFCask=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwlhWoV+eGPkaxC5+MFiGSZBTUiPmGDuEqA11pYzNUJL7WCYRCEGBkIYdFf7yLO4gJz1NL8baQH3pkVsK1wMdH4SIUpzadEx83IR6uHHz8EbX4I8sxZFmvv5SGrQQi28eiEtOcjCwnC1BPmAhnjW9/+JWwuVejmy6bP6A3naAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdFNrV7F; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdFNrV7F"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so950016b3a.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775171980; x=1775776780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t66izQLCHQ6s6AfRMkWgUrhQjqz/ggbzYq1LBRn2XE=;
        b=GdFNrV7FKPRifjEZTwoXZ/aLoGKmwK3FF6/CA6sTTbARDEjkSPmyM7zvCmkfgwoDek
         W0Hum3yuYRWItK+9DJYU62/MjYQn/LhjBliZITElsyT6bPJs8aF2sCsXmJSXl4VsL3N0
         TIsvoB1U7u/Vx2+yyoz7PtCykH/3/2WS8geOiC2hRJo+WkzBdygr9rOb/Tfzkc1BhuSp
         P60oFEIYLnZjDWYXq/hLZP1kcniCxcOheU3//aBKJTkS+Ds+v3lm6eD5k56phdmo3EBM
         H1Nc/smCGyvPlDG8V433RFy7dFbbP/KakF6JFrF+yY6jN64e5dBVTR8yEdmZge3lzUKe
         9e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775171980; x=1775776780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/t66izQLCHQ6s6AfRMkWgUrhQjqz/ggbzYq1LBRn2XE=;
        b=O0vociKhWIDNxsFobUzFenV0extgSkpHPosjoaMVMeSAWuVzyNVEVDh6PzcXddYpqU
         9P60UnISkDPg1VCZIvS6C8KhH8a9qf1CLepKIGDhATnw11WyEKQjwbFguiTXo2Uq/Ft7
         sDQ1HkcXm5Ak358PK91kKdYihh4YMvx1sTnBTxr8xHwUdXiFtMvLVK4gZwWivDPue4cz
         pxGeeBG8yXX1r0+0j2O1WuReX5huzsSQ2gk+KLxmBd5+ts70lV3SVYkOBzaE9UvBm8kU
         pG0lKtaqFL8nVzTCNXyF5aPEIJNqYEzCmFtZxAx282IAW9p9lpZVQSkXQNGfp0BKzgCJ
         8FaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVG87NtThdc98OR8RaLSFW2t9Tb8aadusUdriNYWjNaIM3oDzEh7eBgYZTD2ARSWfl0ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3+P2ITzpajNJf7zUWDCr5Bi74cjpKgyJr0D/E4bWEdLmV3ot
	yeAccHR7qb11t6n8mm3C0evFUh8zWP0ESY8GqRSYupUCvVFDt2erggWiq5dFdye4lfjBJpud3Sa
	1nBZxOg==
X-Received: from pfbih23.prod.google.com ([2002:a05:6a00:8c17:b0:82c:e9cd:a73f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3318:b0:829:9fa3:5c8b
 with SMTP id d2e1a72fcca58-82d0dbd53f8mr822637b3a.55.1775171979306; Thu, 02
 Apr 2026 16:19:39 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:19:38 -0700
In-Reply-To: <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
Message-ID: <ac75iuf9gHIhvm9u@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Paolo Bonzini wrote:
> On 3/11/26 01:33, Sean Christopherson wrote:
> > Clean up KVM's register tracking and storage in preparation for landing APX,
> > which expands the maximum number of GPRs from 16 to 32.
> > 
> > This is kinda sorta an RFC, as there are some very opinionated changes.  I.e.
> > if you dislike something, please speak up.
> > 
> > My thought is to treat R16-R31 as much like other GPRs as possible (though
> > maybe we don't need to expand regs[] as sketched out in the last patch?).
> 
> The cleanups in patches 1-4 are nice.
> 
> For APX specifically, in abstract it's nice to treat R16-R31 as much as
> possible as regular GPRs.  On the other hand, the extra 16 regs[] entries
> would be more or less unused, the ugly switch statements wouldn't go away.

Hmm, yeah, but only if XSAVE is the source of truth for guest R16-R31.

Do we know what the compiler and/or kernel rules for using R16-R31 will be?
E.g. if C code is allowed to use R16-R31 at will, then KVM will either need to
swap R16-R31 in assembly, or annotate a pile of functions as "no_egpr" or
whatever.
 
At that point, my vote would be to use regs[] to track R16-R31 for KVM's purposes.
IIUC, we could largely ignore XSAVE state at runtime and just ensure R16-R31 are
copied to/from userspace as needed, same as we do for PKRU.

If R16-R31 aren't generally available for C code, then how exactly is APX going
to be used?

Understanding the usage rules for R16-R31 seems fundamental to figuring what to
do in KVM...
