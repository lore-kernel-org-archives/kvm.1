Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92A3B2FC8
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585134; cv=none; b=YZqrHKDQDoy76f6cjLGsai9z9y6EYHq/spFeUeSR4yhakiGkrgiCapw1FeJyVKloFZV8WG++YMTxhX6iJMQPElTDyDsoNZ+Zq7r5oeRa53c5TT9De42cWB1zO11RCf8j5lu2Bgy3QyLhgjUCqx26KC/0+LL2sVgwdlfT5e26en4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585134; c=relaxed/simple;
	bh=tefwaCQ5q3pGWgDYvLmp+LlLU3rMcWHxA8B3DUhVorE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FO35yeeX/+0xMSkBNn0hcYU8lVVEn2pXJTfXP0WMqmPulls8BLQ74ypa9sBt9l0vFbhvAj1KTMNRMVTkixiu0DujdfkUgZVzwq5yYFelAYPmsVeygMEgauSmBZ9yi5mT1T8+geKJsVvGgwRcyq3dEwDtO6FAwA+wSWOTPcjaeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsg4f+3Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsg4f+3Z"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7948640854so762692a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777585132; x=1778189932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/er/TgwRJ3h+QCSGB/W4CiMuxbaK6Ut95yraJEZwYH4=;
        b=vsg4f+3ZCuu2OIUGbGYjybLNbcR8kT+cKJ3xaS6WOGK8JUGjME3a0mQHIvzxoa77lA
         rCEH955Y00fJayh/Bvf54V+I8RZ6KiKynmzrNQtcdXIvJKyvFzKZGiQFVtJ4V+uaoMsU
         TSQdG2nb6wR40BTMbblYiOgDdu8y6YR7Hy9fvQgNpvp5/+cqefkT8TFRfQ3yqdh1xUwa
         r7BFhs+9Np+cICGLc5x3NfpKxaQIm6Dq1ZA6z58BIJSWnDZctXN29d2ICMRjpDXL8l1r
         H3YqWpNv1zYNcrRSDTThpHKmjEBJM104yDlIVV7ZqSqkgjE2/mBIb9F8ffO+uONv0Gww
         3ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585132; x=1778189932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/er/TgwRJ3h+QCSGB/W4CiMuxbaK6Ut95yraJEZwYH4=;
        b=nnGf3hzAiviW21wBBGz9rrurNqOIClxBsC8XgxQDo1Ho49MmKupY2Ms41xhITT8RW7
         s26w9erEjuJHUqNyUIh4spdB+YlSqW0YiXleI5JjehCCdfoa3TIYO4NVHxpmJ6+ws0VV
         jFIJN9Gv9R7n8NnpgzHnFfrpnKdBmoqSRHZnGkfndEF9zdfD3w4cSl/hzPp2ce0Q1JNJ
         xf4U4pX3OFcDoV4IchE3ys5Z6BYLXjemx0nmtvuYzNRHcLBs2fh1Rin7RrRsrciIGDmT
         +ug84O99M/OMsebfSBqsvZO5J2KS95rlStPt+aKw02H9DHFnewdTt7PbEvthuzIVEvoG
         6/CQ==
X-Forwarded-Encrypted: i=1; AFNElJ80AVODkIkgy5cGQ+bXwqGDJNXriQduqInyDyFQW6lGE8vm/pTOc7HDgWPwXJ6cJA6kvSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+L1vBaMZJo8jquOlKeKM0kmZwdDSYR3jjx6bbmlQKuMUcN35
	AJoanjL2jBQ69GYZXGZ59D8+fhKH8KyKgXKOBgIz3WL/jE+UJuiMRvNxo36EX6Gf5IknZAS4Rs2
	nbQiOsw==
X-Received: from pfbfj21.prod.google.com ([2002:a05:6a00:3a15:b0:82f:10f6:86d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9f:b0:82f:21ee:270e
 with SMTP id d2e1a72fcca58-834fdcf00b9mr5148834b3a.42.1777585132038; Thu, 30
 Apr 2026 14:38:52 -0700 (PDT)
Date: Thu, 30 Apr 2026 14:38:50 -0700
In-Reply-To: <CAEvNRgHqLcdO5j1X-nXXSjewOmnCDJmHtmPh=1jtQ3Tkf7+HMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com> <20260428171541.1342335-3-seanjc@google.com>
 <CAEvNRgHqLcdO5j1X-nXXSjewOmnCDJmHtmPh=1jtQ3Tkf7+HMw@mail.gmail.com>
Message-ID: <afPL6uCXVAPb_t_Y@google.com>
Subject: Re: [RFC PATCH 2/5] KVM: guest_memfd: Move gmem function declarations
 to dedicated guest_memfd.h
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Extract the gmem function declarations out of kvm_mm.h and into a dedicated
> > header, guest_memfd.h.  This will allow creating a MAINTAINERS entry for
> > guest_memfd without having to rely on content pattern matching.
> >
> 
> This also trims kvm_mm.h, which makes it easier to look stuff
> up. Thanks!
> 
> Shall we do something similar for include/linux/kvm_host.h?

LOL, we can try.  :-)

Not for linux/kvm_host.h, but I've tried to carve up x86's asm/kvm_host.h on
multiple occassions, and have failed miserably every time.

But linux/kvm_host.h is probably less intertwined?  Though I think we should
split out headers if and only if there's substantial .c content as well.  E.g.
if we add kvm_memslots.h, then I would also want kvm_memslots.c, because having
a dedicated headers while leaving the vast majority of memslots code in the
common kvm_main.c would be kludgy.
