Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84492609C5
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368946; cv=none; b=k3Xk+6RH6RRyU6fpnB8+mumOJ4x5rUSWSnDjug4i2BbshhV+vS46rXVj4e409lyJOqZn7ZvbW6Q7S8U/QH2ynWdVlSQL1HOBhaUyR9znYJihszXLuETbFq/o8HgFzuRrRIGEvaBB40CsMWulWRcM7KciHQ8cptRniWhuEqbE0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368946; c=relaxed/simple;
	bh=ERsyZ9sZLzOVP7R6tAaCm5UQsdEmR1MNZhZ8JlYPlxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lA5LM/h0lCaeRoOef92xYVfsOE1iQkr8DPnhKZgIpIRvbHqw8+aSMYfD25jz7czT/x2QwADU6Wi+3mJ1G+Bj/AtBgzanF6mWF2++rNO3CU78+z9y6sltTqChin7rzL05DLRddZyPIZ8leNupDXzh7zax52fNvviH/xSr5UVvnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heMKCL9C; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heMKCL9C"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a3514f912so3449053b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786368943; x=1786973743; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HXpwDS64ztWP/hp11+tNqbM2bLIJJ6CzSe5TtwpRSOg=;
        b=heMKCL9CaN4a/LIE+gyetMn8s7TE8A27xQDevQF4ZR54E4RCkrkjGsf3KZ3RQWDq/2
         /zFEZ2CYYs4Vde5+nF4mUhJmXuOn93jjgsGHIlM4+Cjy3vMk0Akq8v8ge0IONeO71RoH
         DSbF6BAX9eH297jFGt+MguqRbLJ5pD5vGJ0u+CUs/c2di5FUu4ZOVMMweh7jPQcHInLC
         vyoI57oa0QU1v7WH5paC1bYQ8zFfn8g9TDaCqqUfMUYK0jKOTuJRZvC/e4RtBPEY/YWF
         q72O4Y4y9SLx0LaYspsJ2HHDOcEju6y+/k+q9eRd2Sjg6+tLFMJ2kN5WbOvxR9/NEf5A
         FyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368943; x=1786973743;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXpwDS64ztWP/hp11+tNqbM2bLIJJ6CzSe5TtwpRSOg=;
        b=cNEcHbgADhHyNE9/4sea2UXV7ZmwMdf1Rj6mmBn0swUZ0a6KlhyHE6iAgMYngcbuNB
         BZPg1lkbvwrJGkIiJkyjewC4mDnOnFHeWp5zJLUFacwaDjSIavqIxYQFWhCHuDFQe69Y
         UGFD+haZYrFQpfeMBkLwyRWwkoZto9myJksP6RILS5CGdTP5y26frkHoxfihKzUXnQhP
         JVLIa8JCi97VE2FMzJxvkGGQQow1/U0z62wNCuSam9IZ3AtQLB2lzLKmPS84yIhz3dHs
         eVFtC8e0Tr1mg8KszYtkVophAKL8mUQzXEFbwBMu8cKTzKiJ2qAdSQ4kxYX8aMz05R+h
         yrng==
X-Forwarded-Encrypted: i=1; AHgh+Rp898sxL3w9GyCCEVRn6n+HBkA/ko4pnUdd4IsK2zgM0fgrq5BkovXOzPGUft/5JBoDgmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBxHxu7oa274J1lbJpmFjXgphhoUDCpSS8ZvQ+RqK/8FAWHzN
	/fPZR810kzkEP1mCTV9X1QW7/IOK0AkOYr4ydihUz0QAkbP1k2oKgJdkMpia18KXNIhDXYlCpPc
	k+oB78A==
X-Received: from pgmk1.prod.google.com ([2002:a63:5a41:0:b0:c8b:2706:11a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178a:b0:845:e97d:447e
 with SMTP id d2e1a72fcca58-84f2e040170mr45969220b3a.26.1786368943178; Mon, 10
 Aug 2026 06:35:43 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:35:40 -0700
In-Reply-To: <20260808081050.408657-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808081050.408657-1-gokul02k@gmail.com>
Message-ID: <annTrPQhUpbbX7ib@google.com>
Subject: Re: [PATCH 0/2] KVM: selftests: Fix two VMs leaked on early returns
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, Gokul K wrote:
> Two x86 selftests create a VM and then take an early return that skips the
> kvm_vm_free() at the end of the function.
> 
> Patch 1 is the plain-SEV path of sev_smoke_test(), which returns straight
> out of the UCALL_DONE case instead of leaving the loop.  The SEV-ES path
> next to it breaks out and frees correctly.
> 
> Patch 2 is nx_huge_pages_test, which returns as soon as it has confirmed
> that disabling NX huge pages is denied without CAP_SYS_BOOT.  This one is
> not an unusual error path: nx_huge_pages_test.sh runs the test without
> CAP_SYS_BOOT for any non-root user, so a normal run always takes it.
> 
> Neither leak causes a failure today, since the process exits shortly
> afterwards.  They do mean those paths never exercise VM teardown.

Eh, not really, they just exercise VM teardown at a different point in the
processes' lifecycle. 
