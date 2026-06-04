Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6A3BC68E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604526; cv=none; b=kgUwpteVPnKd4QD/FE4mQeM11s6c/HEYSRvE1UQ2nCFDuoXY5JnRq6ep7tcHvgWEz4R9VRQh7lJBQS4N5T6NzC7vOGqseclE5shMaTK+LS9L6G5kqh14JAhnQfoKf89MtCHrSp26Yqg5gY+p4UPkZCQJMPf2WTFgNZRMm90g4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604526; c=relaxed/simple;
	bh=vYEGEkk9TaYWUD17TDu0s93roszc7sna6I+XDHAqvm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YwknQ1SxZxpP4lCjGxOERy6cyn1diYRw9mFsmVitMG4WVZPqdPK8Y4h+KczJRJwAlC+TceMtNy2ilCKqtjM//B7Hj7WGsGIvPMSHbMcKxiV0suFzXZucBGqEG7ZsCBWReyYW001Cy6gC1LqWp2aDanHEw6wsjZuV2PiEHbUHdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMze/6WM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMze/6WM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so332078a91.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780604524; x=1781209324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1H1TUlVlaeiimSfYrkWk3J3ECNUmlu7I7tzKEcGk+v4=;
        b=bMze/6WMH/JyftPLpUIEhkURBBYwd0Zu1rdydZwFJx8xbKgOKbHCF/CYIvEAgGAPl8
         GtRUPVWpQLu+Xs6XBke28KXX3FHnhfeYcDldDPz8OdTBFSfaYz+fqPCTTxuig/SKiKqK
         3tUzwe6DO156dY8EcJ1XgLDLa5FuarkPsz7InG1KFLyzPkjPBEhAWGE6wxHW0C6sCa7F
         WN9P4hVmhhkImlJxQ5Ddyf1ypPZihiIH+F+Z8vZlljS2AgvTluraqvh+cfRDeiB5kUHW
         yPG+F284tJ+G3VjeWQpJWtVnURR2f2ovSBVJ9c7OYWzKBbSDiyY2dbBSqeb07WJCTq6i
         4UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604524; x=1781209324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1H1TUlVlaeiimSfYrkWk3J3ECNUmlu7I7tzKEcGk+v4=;
        b=onpidze3gEg59lPJcpLjNWZEK+akLyehNBzlDYdf6ZcMP3ZrGMSVEoiG/XK7a7hpYA
         sIXremltcJxCVl7cjyYLPV2MbcM8j0oDc9nwezPlzphdupzvQXS6sA8uY/rhg8twPNgA
         WP87G38CHNY0UMxp8X1HeZ8/qD5bIt9OMHdgViRz6DXyK1JtG9Uf92pc1p+g5S6c5uWc
         cMsHnog1sKqE3nbCg0z5ouMcz1YlExakjMPqxh/a3HAVsXRKiO5cpY6XP677N+PIvxOJ
         I9V3Vr5CW3PJEs4AeLFuI3wvOWa8vgcK3GkNqWLuJh3APTupXgb/hKttXYce5mqRQpWM
         0+Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+MoEgo7SNI6BKJQpHBGJ393/dVA5itPRiltvXKukctXylPd5zKimCXntlZ7WLVBALVDXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWU6usBBLDAWqlS8C06KU9KyUprsnDlf3L+tJX+DWiP/zsZVOB
	PvkgGlvsRyjVWTIxycOKUOmFjh6pNa4WLoJMgIaqRYvahsiBOvLis+es6tXD23ScfrlRS+Wd371
	zdqkZ0Q==
X-Received: from plae3.prod.google.com ([2002:a17:902:e0c3:b0:2b0:46bd:4fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a50:b0:368:af5c:5925
 with SMTP id 98e67ed59e1d1-370f133ab62mr442064a91.23.1780604524152; Thu, 04
 Jun 2026 13:22:04 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:22:03 -0700
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
Message-ID: <aiHea0e1ntOKfdbO@google.com>
Subject: Re: [PATCH v5 00/21] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> This is v5 of a series which introduces tools/testing/selftests/kvm/irq_test.c
> in KVM selftests. This test exercises the delivery of interrupts (both
> emulated via eventfd and real from a VFIO device) to guest vCPUs. Beyond basic
> injection, the series adds coverage for several complex scenarios, including:
> - Dynamic updates to KVM's GSI routing table while interrupts are active.
> - Waking up halted vCPUs via interrupts.
> - Stressing interrupt delivery during random host IRQ affinity changes.
> - Stressing interrupt delivery during random vCPU thread migration across
>   physical CPUs.
> - Testing non-postable interrupt remapping (using NMIs to force transitions).
> - Supporting both xAPIC and x2APIC modes in the guest.
> 
> The series also links the VFIO selftests library into KVM selftests to enable
> testing of VFIO-KVM interactions.

Lots of comments and changes.  I'll send a v6 (maybe later today, but probably
tomorrow).  I have all the changes made locally, and the test is passing for me.
