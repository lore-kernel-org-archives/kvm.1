Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A4408639
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539610; cv=none; b=hNAvBSMEYLOyiRwzF6s7jyRDaLGEAQCY84zN/pnk8OeX3C9a36Gw+51F+zYXh66CrmlVLQQErJl9Ic8+bOtsvo26OiYIrSAOglW+XJbTnXcxPqo1hAqz/uIKaZvs5dT4ZRfnuVM8ekuMrd9H1cS9MLcoBHOKwWRZ66U9w/MMLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539610; c=relaxed/simple;
	bh=p/XZWxijB9NCmJznx7LpYLfqDRKyZhEaBCW8G18vOyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yut6rHYyBRL5Ls3j5VbLUjLwEETQSUXBxLt9IRLu8WS2JuBXAF7qSIjl28dO8lYPmPZcFfpuwmHiZON1DpdJSDNwsR3XieXHmLZ/y7BZjw1QJFXoDLIjkQQiL8CQs3HnjB2mACPIAapwtIa4Q9XllCaj+X+vaOPQ8aAqNfhnnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5Lth6wM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5Lth6wM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36db995d083so2581866a91.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781539609; x=1782144409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zXuyEODVob2lw0QmrgaikfQkgS6MKvHcsm46Nk5Ubs=;
        b=Z5Lth6wMlSmSmNpR8Ag+0pbk/HmEBtoydFdtcdBPyYGkAzN5RzNA6wrpZWDWJGSwe0
         kQLX1L3gsrXfRTvRfiFFEt5gtr2nP8W1drCKkkTcxNufL+EfsSLCjOkAQiAxr3TGA5eQ
         mp11kzT24zsSweu3i1yQzSItT1zCdixhSlaas96m4wTDUsgSYpdr7orfrz51mOTMGEAA
         hu5ifPcD2vL97CBjGB3pBrtB6DmUnL9xmVRXtK+ADt7G60MZJ3qDKdH9HO6jde23PzTb
         xMfzKFDrw4PliyR4OuYyGWEI53sFVU2sbL4rhXOLOh9ZnYhtMOotg1X8tplk2W2/4UVo
         CUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781539609; x=1782144409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zXuyEODVob2lw0QmrgaikfQkgS6MKvHcsm46Nk5Ubs=;
        b=KTtEYjYrJTtLPfRLLJBSFzlBfy7kJa+D8Mz7g4bubyTDP4ucPhAx1LyVPd7dYyOoAE
         WPvL764chOoIXipHI8TMd6xYtBGNunAhX9entdysj+FH4IwFwtH5s/hkDjAm6oSnREd8
         3KluR+cL58PSV3+PkuzJ+jvzUI0hQc+5KW78ZFpGQRi733/ifAFiYf1F4bX1fkjPf0IS
         zRMXTWDR5F1B7otCZTrHLSSYbmzJQHX26ZdWQOPPPYmVyox5Q94dHagwj/vHrXg4K6vW
         oaacB8/3VswZfgugXqC+FYftGx2MMFYukw80UTvIwXOfMkKal2NxSf77tIPPBvYxQZaq
         ihJA==
X-Forwarded-Encrypted: i=1; AFNElJ+75oC5aW1UE3QWuhPOhqtFcU7KXZqR08jH1zCT+x8B8YlspS8lAlMiM2L1OOlw+ae1jhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60MrV+NtKamGIVvyrIvkRvXgFmnEzw2rU2vwQp29qgzhSZfwj
	KtRPol0ICiFSct2Bshf75o5ckbkkg4BJXZ12HZS9eP3OoM/yDmrZvEc3bkrkrhYGI3+4z/T7xIi
	siTEqEg==
X-Received: from pjes23.prod.google.com ([2002:a17:90a:757:b0:36b:9f59:6c78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b46:b0:36b:218c:719e
 with SMTP id 98e67ed59e1d1-37a044944b9mr14827517a91.21.1781539608466; Mon, 15
 Jun 2026 09:06:48 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:06:47 -0700
In-Reply-To: <5bcd4834-7b4d-4543-828a-1e6a6c523a41@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-6-seanjc@google.com>
 <5bcd4834-7b4d-4543-828a-1e6a6c523a41@linux.intel.com>
Message-ID: <ajAjFz56jdcXhBZR@google.com>
Subject: Re: [PATCH v4 05/30] KVM: x86: Move local APIC specific helpers out
 of asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Binbin Wu wrote:
> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> > Move single-use local APIC IRQ helpers out of asm/kvm_host.h so that they
> 
> Nit:
> Not sure if it's accurate to say kvm_lapic_irq_dest_mode() is a single-use
> helper.

Yeah, I'll rephrase the changelog.  No idea what happened, maybe I wrote the
changelog without looking ioapic.c code?
