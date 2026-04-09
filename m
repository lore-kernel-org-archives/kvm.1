Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A7324B2D
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761146; cv=none; b=JboVtTk4e2I/x6pI6ZmR9NxcvJ9AO1YXqY+SNE4t+3AEfFveMIZbP2aB0F4mkJD2yDPyqp2tF8b+00Pji3XE6gV+PaRSIq1r8ZTcqVW/ipZPPOza/Q7IyDer0jHW4Rl4O00in7mUI9VcD7KwifuB0CP1Yu8IHBLEoAnIwc43+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761146; c=relaxed/simple;
	bh=Je4V7ImYq7JNaw03SfyH154cG7h7/aM8JKXAye/D9f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X9fM8Km7JFNwto20hcAvIQkvQNYZH6m49BiK4LHd4f/Q2FtyiwQU8ClnSE1UqPaUmKpnn8eo6yoTUGH0R/68eQJEnWLitVxSoVo+5szoDAVL489/jQd6taWFnlDGVWEzeGs9RgAQ2hKWtNJBgtldYB1kjMFzaCm/MroY/9wnLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkW7p2aO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkW7p2aO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso1602339a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775761143; x=1776365943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3v85viBMNWszU0I9wMrSM7OT3Etx6X4T4nLIBfF7qYQ=;
        b=ZkW7p2aOKpLnmf9fA/OP+/nZz4rDsxrK3PXCsYruMYfum9GL6fxdDs34WOVulPqlmB
         5d6n+h1jjHUgBqYGKjijyxjxKyI+8LdLDRopxlk5umRDWUxm+zjKFwCgMLx/9cavc2A8
         TmhraKgcbIu97K0WyeS6v2x8lAQov0mHjbWVR7RrX+Am8R/pN91hNaHQlYnQ4rATPySz
         esu9MMVmcObqWkHKYHbX/x0S7T6NaYiUsWg/brtdmYKlsHwKbAtaDFzHUiQkzT1U0R7d
         GnR7sSk50u3awRn+XxF5ANdvng6PR39zLGqnU8cWXDfPAKY7tb5INVJND6LF4hvKqIct
         nmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761143; x=1776365943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v85viBMNWszU0I9wMrSM7OT3Etx6X4T4nLIBfF7qYQ=;
        b=ZHcSCjcZ/tVdXGAxvnvo7YhcSO9bnBr8WIxFM0I3pCt/K/ueEmuOyF2x7cKVz4XCic
         GfyE/xfMgNSX2R1X8p8og+/uBpR9DJy5OkpzcexvOVqVnvL5YMHoFEXRWPs3mKD0aboT
         PiBQ08cmrgKRZ19r8TjTCiOA1us12Tzr2ibZauANBM0xd2vP/Yt0JQ+pyfvKnLwPscpx
         aW2hI19Ah8/+emqxlCxgxnov+wKFlLXE0ujfmoOPkyBHrpxUUVV/jsGq9DB/buTysebR
         GgmjFubZMJNWzxlPAQPdfHeRo7ufMIFnlceWDArQ4g74stxX/bwjIuV/1hfLJcIuH34s
         BCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUl91omHzxZS649uGF7SLnLOw/65ekOrF8NgyCaj5r74nRLiw0hLnME7M3I82MxYG2ga18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Q7A1intoUGMr0bjfb8p2X1HBamaYsDjYzlzTwzVZCbN/qds2
	N/fIe6VtE3oUkk0nLDm29yXZ3iCcsZFIUAMt5tPKLa4+OIkoBVTm6r/pXgZ33KtWjGOgGI77Hi1
	LqprsJg==
X-Received: from pfib21.prod.google.com ([2002:aa7:8115:0:b0:82c:da3b:301])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e6:b0:824:93df:6d86
 with SMTP id d2e1a72fcca58-82f0c2f0ee0mr338661b3a.50.1775761142760; Thu, 09
 Apr 2026 11:59:02 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:59:01 -0700
In-Reply-To: <20260407180107.1603697-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
Message-ID: <adf29Rn7q9Db0hxc@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Paolo Bonzini wrote:
> VFIO is implicitly taking a reference to the KVM module between
> vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> symbol_get and symbol_put.
> 
> In preparation for removing symbol_get and symbol_put themselves
> from VFIO, actually store a pointer to the KVM module and use
> module_get()/module_put() to keep KVM alive.

NAK?  :-)

I really don't think we should do this.  We're reinventing the wheel, and probably
doing so poorly.  As Jason suggested, the proper way to handle this is to pass
a "struct file" so that e.g. fops_get() pins kvm.ko for us.

https://lore.kernel.org/all/20231203140756.GI1489931@ziepe.ca


