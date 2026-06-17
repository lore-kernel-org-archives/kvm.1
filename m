Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3A4A3400
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711645; cv=none; b=CwgRtCxnIqikrgpDInpsXtDk4IeS4qDA+401xjO11xVqIsvztPs0bHrDcUP6Q4OhQoIRbPZNVA4vdee+d+lwN8M8tHbqBJaFgSX62S0wczbRwl0SGJ2fuP1PW9XLCiPwYim9809Ok1zJjRs6M6JPQXKjaIHqXrgP7XCMQZwlHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711645; c=relaxed/simple;
	bh=rcKnS1+FpQ1DP/xjgBt1ET+jZRe+bq3qkPKOyCFCXsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUDQuYOgx2NicUQKmV7bRyJ/JZzhvSar1gJsjq1kORkxZt5Nc0jLErS2oER4w0fVYokxGdmAHxUhBx7Dk5wQX/L19yiYshffdCHZYXYO7Yhi0N5QOekSYtMR+JDSjpc6CX1AkWsnbdYKNE83EtIp1ma6+tEfSQcc5opWdzzDqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3WUO52a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3WUO52a"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6b4271491so8889655ad.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781711633; x=1782316433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kD8seTA/8z6Sa9yo2JIU7od6nLQ6AIzJqjCiov5sCNs=;
        b=A3WUO52aUzGMbn5gG5Nqgg3HJHyFaZR9vH1Mf8VY+sZ54i+MxPzmnwXJ5bXj1l3A/c
         bE8eJT4Uob67G/qCMc5rp+uHzM8N6iD7EXnii/03uulm17DHMQOs3tYoLNy6bcdvs+Og
         Dp1PWJcXg2lbz39A0oKyQdaFzIT1PKqCsfzuE5rya0PR1oxVyHL7t7IH20uaqUK3BV+j
         dxbPr9CJ86TkkGjIxTjnkOJ8L6XVOxuQaQNHzCOLIOxbUBwR7kX8tUOQ6AvLKuorESVX
         rGH1EqaOQ0LB4LdLMHfsXJEJbZbI/clY0AaRmQ770sQ76E7ehWK+x5RludTmvyW5Rg0f
         D5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711633; x=1782316433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kD8seTA/8z6Sa9yo2JIU7od6nLQ6AIzJqjCiov5sCNs=;
        b=UJo2OGZBqCONyiZJCCr9iHsYOxotWmOjB4sqxo8Y40EwPeeu7AL+KnrADBTzjfKuXF
         uVtExjrucPG8ly3UjQ1dIczPgxSGMNQBnhkCbxXF5MumCaz7GQh3TrXk95hNpTuI/AmV
         BjNleuHXWQ9Br+SAX7vKgfAPOf4WfpZqYhbcnwYvNgaFL38yj4cfSuaQmT/DSU/plr7o
         JL9fMmM+lebOvZLQXGooSycXdQamghV0sKFvTluTm0lOUEEacKmhkMFCy42ML9GRMLq+
         KE4zydpqLpfMXyiWibEVBdgfPN0j5Y8klzR6Fsr+UAGBxZ1uNrqTUAz6Pkr/2nC6Y0R+
         4QfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9U64ho65SHOttZKgSm4UC6BDhXY9HT1BEBXkopwcdsLQ3fC3UPqtipz+Z13IptF/cvEkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytBSyPD0ZevuTWRsbcsYSY6CpYlyRYb+jKUcl1KIMAIfAtpJnV
	wSOvvLOtoIBcw9WupUWln7ZQy8Nb0ed2jVLcHs4/VtWuodPqIOajuGJLIOC5CW3LhfxMb5u1TUn
	8zDJjVg==
X-Received: from plrf3.prod.google.com ([2002:a17:902:ab83:b0:2ba:39b8:446f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98f:b0:2c6:c6a8:344d
 with SMTP id d9443c01a7336-2c6c6a83717mr26671045ad.26.1781711632465; Wed, 17
 Jun 2026 08:53:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:53:51 -0700
In-Reply-To: <11b87e43-dde8-4fbc-a25e-ee7373c8181d@rotek.at>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <11b87e43-dde8-4fbc-a25e-ee7373c8181d@rotek.at>
Message-ID: <ajLDD6Ck1MF8aD7J@google.com>
Subject: Re: [RFC PATCH 0/2] KVM: x86: Relay a nested Hyper-V root's vmbus
 posts to L0
From: Sean Christopherson <seanjc@google.com>
To: Robert Nowotny <rnowotny@rotek.at>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, jostarks@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 17, 2026, Robert Nowotny wrote:
> This RFC asks for direction on a small KVM/x86 addition before adding a
> selftest and an SVM counterpart. It lets a nested Hyper-V root partition's
> vmbus come up when the L1 hypervisor runs under KVM with a userspace VMM that
> owns the host vmbus endpoint.
> 
> Patch 1 renames nested_evmcs_l2_tlb_flush_enabled() to
> nested_evmcs_l2_direct_hypercall_enabled(), since the predicate is really
> "L1
> granted this L2 the eVMCS direct-hypercall facility" and a second caller now
> shares it. No functional change.
> 
> Patch 2 adds the relay.

I didn't get any patches.  Lore doesn't have them either.
