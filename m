Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE4243964
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151380; cv=none; b=DGifoo57Smdp+cLOAFZxqiSBnn+nmM7JIXXNz69a0tDCM0mdhP8Eg7tPN8sxGnmzIXerTsl86LzvkPnk3rfaPlkw4xMXlRq7LXuUHc1nSjk+TmhbixagTqDewHlUQ2zCHhB9haD5ykeiZNerUC7RCIiE1odjmBKQTBsJR1nMe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151380; c=relaxed/simple;
	bh=GOnZpg2Ve+LnGd1ZuqKLeept8XOwpaeDfNR7WaGzezs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SApk4IjAfQ5hqxa9e5GVRaU7ZMYK0KjtYbzg2/bqFjSI1zjAka9KQeY6eyEtrRpDaJWNhjKzCp8+Rpz1xaw0CgGkPY6yDDKQdb6zvOxdqdKUIA3gQ3GW5ed9Tfe0NGaKKNYIEa5aWARmfaR0/zkb5IsDgGxOKzln4Bv6v/gQHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVV4V7aV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVV4V7aV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c823549b1fcso5479810a12.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151377; x=1779756177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyDg0kt60snDXIsPnGtvFvd0qdKPkJBz1r/8vmB/ah8=;
        b=cVV4V7aV6iJ3XbelKLgBoEenJVxiJsKnjMCo6RAwSlUXq/K/+1xZEpIFkAavx6qq0k
         G1OZO1qsANWro0fIgr5fgsqywO3QViPjzESKytQ1pTB6fOhCvQJdjK/KiJKB0CPnlTDu
         pobp715urzHUnLvSntBlV/m1ZuLBaNlVzdEDMieFZMk6TigzjXJd0mRE1pzo+FPbKnb8
         9KRekcaRRx8nv05FullroDti98zGEq9/WHxB3s6O374ylYtN5N04i4SIMNDhWXgL84bx
         x7MIjP8tQAcxeb6PC/HhjQrPsGeiC+WdI8FXpI7nR44gqLxqI/BejmKTCk7QaWCs1z9o
         5sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151377; x=1779756177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyDg0kt60snDXIsPnGtvFvd0qdKPkJBz1r/8vmB/ah8=;
        b=MEiP7uIvMyxy2a16PrLi57UdYtnzW0PTxXaOibOEJ469byLCYU43c262UYnMvOH9fm
         cUCYjJeoPjIuStDQt0R71/M5J3OIkA5v4QIqiPc5F6xMYO4vpX46Y+axuGYVie2BajqL
         AZ51/+6YjjpOL8+VthFKUOfk6ot3SQN2KaNihcVkxSU35Cx27oWZm1boWFzxU1F45MU+
         hz2yPsxf395E+XfRrYmV0Zxsn8hxomshel9fzSEu7/1W0w6rcLMnwxlNm/mGOz/+3BDk
         ZfOJop4+k9FnzrVMwhubMS/J7u2tP4XUhjoLNxQSPT8hsabluEU/iOj0jQypTuKe5NmU
         yMzg==
X-Gm-Message-State: AOJu0YwwWw/qaCYP4cuae03aPY6pLpEunSuaTH81j4Db4ebXI5FZoBi4
	sUf9mP+tH2LIIgAIHHApVzh5BVgfp76PUJL5Gv5Ry5WJ2jfjmWKkXAIUTibokyNbqB50A2u9JXN
	T1DYWtg==
X-Received: from pgbbj25.prod.google.com ([2002:a05:6a02:199:b0:c79:89d2:43e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:eec6:20b0:39f:66e8:670f
 with SMTP id adf61e73a8af0-3b22ed291d7mr12544161637.39.1779151376752; Mon, 18
 May 2026 17:42:56 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:50 -0700
In-Reply-To: <20251126191736.907963-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126191736.907963-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915043498.2224273.14600969716548286021.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/debug: Fix macro definitions for DR7
 local/global enable bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Nov 2025 11:17:36 -0800, Sean Christopherson wrote:
> Fix the shifts for the DR7 local/global enable bits.  As called out by the
> comment, the local/global enable bits have a stride of 2, i.e. use every
> other bit.
> 
> Use DR2 instead of DR0 in the debug test to create a data breakpoint to
> demonstrate that using something other than DR0 actually works.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/debug: Fix macro definitions for DR7 local/global enable bits
      https://github.com/kvm-x86/kvm-unit-tests/commit/e1a0812dc2b5

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
