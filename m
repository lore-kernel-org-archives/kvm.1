Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9073BE178
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731323; cv=none; b=hJEztyaznEQSMI+5i/I2EOgt3V32U0NaL69y/EJT1arVxmBOOVH/Yd1kjjADzr0O3mAi07DVXWwmy1SK8acP/kkD4zHRLn0Pqun7jC+9fEI6fMxqxOIMbmfBONFFUk8WhzMEUdMQuz7wmbydTnn+1zNcDV3GFaIvSpOdYfSXtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731323; c=relaxed/simple;
	bh=MGYaW/kGXMvXvkG3YNsp5PL2xIZorPYpsNyujv+1Wxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ea0AORZKHVNLQoO8TSaSSmhfUjtdQv8ddt0atq9HvdZv32v1J6gCsU2Z0ikZ0AnIe3P6yVYyKK709qKgQn/heCcLZVvOfVIogAx4MgtyxRNi2ZwyCD60kOrWKH6vXq9V2ElV7M1RFwVWpRceyVfJ5y7MJS7/2fMfMRFkD+NoKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTOHbIJF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTOHbIJF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso2246195ad.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781731322; x=1782336122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6AeAWlBOIBCo1eUsPzrvFR0RxSzMS/bNs/bO5JhUb8=;
        b=fTOHbIJFU8TyGbP8WD+zB1Ktn5OW6oCF/zPXakpfVBa0GfU9T5Cwnw66T9nUmkCsNp
         SEI9DpC+6sShdihn9CBt7STG4BkFbkfHTnPSYJVjjdiKDJ9HEUfUbNiI4sZOOFYaoveF
         k2jTijpOI50XPgtFG2S9IptWIwVddoitQ8DqRIxVVKK5ASKQeNW9BxtpxcZ4Y79539jp
         W3+Hl9rsw6+jyHxbJElnTz6X1wdQ8hJUpDISHViR5wCTfTOptabZ39kFyyWeW02ODtJG
         Pjg4IOREcFs2cBeWCUhGKK9P8yMaqkPsSwiA9L1pEiDqBwNGQAIQioanqBbLFeS1SrGf
         km8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781731322; x=1782336122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6AeAWlBOIBCo1eUsPzrvFR0RxSzMS/bNs/bO5JhUb8=;
        b=nnRnmwNb1OWSKiaDgSPVMTJdL3RWZDBERuJe9KjuX6dbkuptoafQ08rui2bnNQ0/Zp
         zhVGQJlY+9vJUqLfoXeILzqnSoksmGn6L9eQIfoq+X9K/eV31xraMmpVFYMz+tKWqesl
         YXm/7HxdUBqO1b5Xwz89WdrSJz/ze6H4TmFvb3fSi6ayvJl5dA4TngsXfvdL3pXBdHFo
         ZjDti0cKgUUtBQ6h8nyqb4btF0djRR9jMbbcew9hhMOiyoPpP/qjqB7iSPdFJPQGztfa
         4Q+maeqbJAw1CtVWd00Wz2yRWwJ+PgbMOnhaJvTHjzaf6jMRJsYliA49z5M5RE9ONV1U
         Mqng==
X-Forwarded-Encrypted: i=1; AFNElJ+1S/S5ya86sKUH1oMR5FNvsy4W+vuNl20hz3Tw4VERR702LBzwlhkysLAHeI0GsWM4EQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjyrW4kLd7zDAQarXwL4bMtSgliHC3uuhjWpHlI2LQtcot+LC
	BAxG+FH0v1Ath429j5m4yA237kCcBgxrmH64E5Q+nY6noxopjY5sf01UFlkzT8GH+7NvOavITk8
	3ZRZ8oQ==
X-Received: from plnw11.prod.google.com ([2002:a17:902:da4b:b0:2c0:b770:dcd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1590:b0:2bd:606d:b342
 with SMTP id d9443c01a7336-2c6e529338amr6910895ad.26.1781731322053; Wed, 17
 Jun 2026 14:22:02 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:22:01 -0700
In-Reply-To: <ajKcDRqT5m069PXK@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615155244.183044-1-alexandru.elisei@arm.com>
 <20260615160901.9A1A61F000E9@smtp.kernel.org> <ajA6ogaNiI3KDv5i@google.com> <ajKcDRqT5m069PXK@raptor>
Message-ID: <ajMP-cUia1I-sVAE@google.com>
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 17, 2026, Alexandru Elisei wrote:
> Hi Sean,
> 
> Thanks for the reply. Just to make sure, once the bugs have been iron out,
> you're ok with this idea?

Yes, I'm more than ok with this idea.  The only reason I didn't push to do this
right away is that I completely missed it :-)
