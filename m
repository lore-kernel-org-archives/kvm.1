Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9C2E36F8
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075090; cv=none; b=tDrD51p+8hsjNrF2v4BgRNNAOad+RKIzADhLZIkhdPEmAHvaxgUd0TrNt6IfO5ZjjTeGYY+n50/BN21gmcYPlh3xWZJS3JkorGINclixLSMkbxMLxCpXzfyss0EzUrjpHTfCWIUB7HAHTPqaKwlYfFW99q1fQhaUtSNaYMBdi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075090; c=relaxed/simple;
	bh=RWl+Rxvf+TvpBEvxkMZmBA2y88jcEKbSe4jDvQUzFKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXudqqsEdNkZVE00l5H3MGadexPeZCUcMOpWUl94jNT+Sv9uIogWnNLSEdE7y/MLgedn/T0Dx4wOgRPD0A/lpvy7fe98cz0yphjvlMY5D49prNmeGGYd0RYuYSIONCu+Z4qEIoQpbXBFIiyjrBJCtFE9IoAFXStlvtD7Ls/GI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRXnYHfq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRXnYHfq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce0c07d0cso92447b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775075088; x=1775679888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8P6dO8WzFmgfzpkhdyRgKg8hVmQp+LP2jH8nT0qBOA=;
        b=YRXnYHfqLPx0zX6RsieBSx7Hbjm/oPT9X3HzwxGzcqSAlPSzecio5JHs+ZXQPyEq7h
         4VCZH8ruzT7I+nw6JSPzU9fzM9fmsO82tODDpiIG3RXnUngywVfd/YAla7SgIRxvspVH
         6MJso6YcahXQ1A9tql72xK5GT+UsLvKRg2fFzJtDhwAsWUPbvdC6n9w/gOkmC9TeVkCY
         JdjrSeJkAwBJIMkyR6GaQ1XzWgXZvpNuDTlOaLNNq5qi4fgWsRdGqNB3qFKsS+q2fiwj
         sYlRGx48crXUamP8TDZqLBU70eNLEZRw89d4na1WaNn7N2JqBAI5tBmqb2B5CsOjtvUw
         Plqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775075088; x=1775679888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8P6dO8WzFmgfzpkhdyRgKg8hVmQp+LP2jH8nT0qBOA=;
        b=FApJDZfVVuFRxlND40DFZAitMTGg3lWgVFOcznPkINgovfuyM6iIQ8nb15YMBLGZgt
         I8MlB0iDhowEzKZq3RxKxHChheilyNo1gOW+6vEBlJs/zYG6XyHZ5RL+5l1l0YQ+NY/O
         KrJvGRN8FC1g/D7c5cjj5d+O5qf5+AQ/QMxl6oNDidWLml/WXWvLl2Wf2GGsjIdI3z7r
         /wIy4XkEEFnvX8nx0qgY9dNuRtouXafrAuwKwX7sg/nSVtLDGplMdNwAiiEkhur+DgGd
         NlrMngmm0CZN8glLiGK+WSb5Xb25IvvctkFnLFf+8I9YKJyeQwSJGIfYaVpEkZQFoqEN
         i5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUxGxhwmT0RlmYUqF66wTnj/eTLTZgVEIlJCXqPclxCms5sxvR994iIzG0uDscpeIjgkZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XMk2u5Ie/SlQZxXkWrf27ndUPRgXBrzzW73xfOz5j0/mzgEk
	vtWhSEc6WXinciq+OO7esuWwHUecLw871QpDk0AEXZQ69q+pD1ek7cxIeFEIdYaqsAW6QKKnal4
	utdvBhA==
X-Received: from pfog24.prod.google.com ([2002:aa7:8758:0:b0:821:8233:7400])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a9:b0:82c:e5d0:5249
 with SMTP id d2e1a72fcca58-82ce88d5539mr4353967b3a.8.1775075088241; Wed, 01
 Apr 2026 13:24:48 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:24:46 -0700
In-Reply-To: <20260331194033.3890309-8-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-8-jrhilke@google.com>
Message-ID: <ac1_Du0JMV4g5W2Z@google.com>
Subject: Re: [PATCH v2 07/14] KVM: selftests: Add support for physical device
 MSI triggers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-d' flag to vfio_pci_irq_test to trigger interrupts using the
> physical device hardware instead of emulating them via eventfd writes.
> This leverages the VFIO library's driver support to provide a more
> realistic validation of the hardware-to-guest interrupt path.

I don't think this should be optional, I think the test should unconditionally
validate both path.  The "signal eventfd directly" is effectively a smoke test
of the full functionality; if that doesn't work, validating that sending via the
device itself is pointless.

To keep the runtime reasonable, maybe do only 10% of the iterations for the eventfd
version, capped at a lowish hardcoded value?
