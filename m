Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD139FCCC
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165102; cv=none; b=kDY16wDPF5ob1GD4h+K+LolIPEtdN9Qwm28kr3sq8a42nY33+yiSVoaB/DbT5yhpGkWhX0+xz9GQ17DiqN6D6qsyh1g0X5dFBaLbWivBlRB8fiiQQHxL44YdgjwiTjfw/Dl75x1wKqCr1sRms+jJqsXwM7N+A44sR1Mk3BbfkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165102; c=relaxed/simple;
	bh=FLjNJEoeoU4fvZfz74waCSo94sY/i25YW/rp8G4tTP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MEr38QjoqCNFjsfkvgw6Il+tQvXYOBl12ZO/NrhAzsSm8nM8++xtreVWuXORscL8nhJJePHrZ9x9r9mCPrWE7AH8sPCBOrXbTD3VD30sfvAQ6if4Gf4dxKN3kos7zeyeEb5/Dot8F+jYIVW5u4cIWVylV9e2wtbUnRLrUMVbf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrTYLAAu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrTYLAAu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7ada7b25f0so480772a12.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778165100; x=1778769900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIy8TrMQVudhzjHq7M52g6/Y/wVrAjjuZwlBnsKQlo8=;
        b=XrTYLAAu2BvEYo/KP9blybcrwgm+iBLQWpwyMrKQlkKyT22WwKUsWXCod8VeCH8/pu
         igZmFkWw2ypnff+SeDUXCVZ2MoUcd2H086qYjmr02IVZK0Zz/35PduDw1dJRngp5FgMA
         NS3tQdIc8IkOvdxbsDYaRYBt16YJB/ciOE8I5lLhF0mweMM8KyLd3POMAfTzFDnisbjN
         O22r+UY94+EAxgrqv1yJPWyQlsitODtpz3YvlW2ho1vcoJkUyxsX5HonB2yw91hnA7rb
         vOWX8iuMLx4htbmZkTvHep7+SKPE8gbt7fwzlIGHpgTI101U6m6IQ9Zj7m4i2N1jTjJw
         jUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165100; x=1778769900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIy8TrMQVudhzjHq7M52g6/Y/wVrAjjuZwlBnsKQlo8=;
        b=sDAcwX6SGNf7c8kysBeB7dOno/fbRnZUQOPM/L3OtvBBWV60ebWs9XQ4QttdUlq0PK
         6+VMaj+KUF+racymL0M+q/0uf0v4TXvBVRohAEgX94m05uOKu13PapXZ4iIs5REO4Bnn
         gtKWJu7WU+V3AeG19bwlgruPU8a9vi1xy9+s8SRwBZptbe3YPKQsYvv7hwsAxOm2g/02
         g1V+sIYpaZLttPKsufE6/swqGPNFN+u2FuO6Wou3kciVxD6Z9AnG8Qnf2xBmi7UbGQCb
         W/tw0RP+m98ploHbVhRUZJBiu5WK/9UcPOWoq3f+J2GC1pvXd0HWYCA1m8MrFRN3DeD7
         +tvw==
X-Forwarded-Encrypted: i=1; AFNElJ99Oe/BdbnuqOfR6d5kMldJkWKxn7l9nERW5jqC46yW8fPuhcO/ckhBW3yQqKBA+UCU/0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEpVgUfijFGFgxHQRZTU1ItmHGiuzl4B7r5H9PBCTOBO77z1E
	pHfoq95o0BTCPq1e7E2h69Z8BqATwnj8h/tOv3LYuSOG8md90Bo2ASvUeUkjXCoWwoctEZudZK+
	NPd4yEA==
X-Received: from pglu15.prod.google.com ([2002:a63:140f:0:b0:c79:8d3a:7901])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9c:b0:3a2:7ef4:81e0
 with SMTP id adf61e73a8af0-3aa5ab10a3amr8677387637.55.1778165100272; Thu, 07
 May 2026 07:45:00 -0700 (PDT)
Date: Thu, 7 May 2026 07:44:59 -0700
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com>
Message-ID: <afyla1t8eYsWw2Zc@google.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, Paolo Bonzini wrote:
> This version can also be found in the "queue" branch of kvm.git.
> Since it should be final I'm including again for reference the full
> description.

I still have two nits, but on my end the most important thing is to stabilize the
hashes sooner than later, so I can use the resulting merge into kvm/next as the
basis for 7.2 topic branches.  I.e. feel free to ignore the nits for now if that
makes life easier for you, I can always send patches to apply on top.

> v5->v6:
> - rename make_spte_executable to change_spte_executable
> - rename byte index in update_permission_bitmask to index
> - use (u8) casts before "KVM: x86/mmu: introduce ACC_READ_MASK"
> - make commit message for "KVM: x86/mmu: split XS/XU bits for EPT" more accurate
> - add XU to shadow_acc_track_mask already in "KVM: x86/mmu: split XS/XU bits for EPT"
> - fix compilation error
> - use alternative code for __vmx_handle_ept_violation suggested by Sean
