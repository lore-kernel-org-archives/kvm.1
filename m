Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B43393DE2
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865521; cv=none; b=bbLMuFuTnsYTzT7ZbZwnfq1f7vbeGKQ5NrVq+MJPTRGMamITAkA0Lc4v6DiLDlUvdvcjSME+al80mKVhluw5IMDhKBGP8uuIKYhUkWVZCWq4bznr5W2HEaTiG5VEKa4dLqwNuW6vkd/C+yw1XLrE3nAbb2p9D9OHM3hw6lyM65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865521; c=relaxed/simple;
	bh=uY9zZUznnpCT1fFMb7XxacYLUVV044qQ0PFKR4leZbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIP3dPyhdFf5fEeT5zTmRMhAxZSzKrwzbFd8WOrUQxISYe7suNGHMRpDXPXN2G3D1bvpQzBsAJymxaHC69zu7fc82shtXNOeZmLe01YE1wYh1z6Xlrl8LImP9SkbFOhOHcKpuGQoagDHG85Ikc53yej+HOEIQKzfoPz+slVbGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4lfqk7H; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4lfqk7H"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so1785798b3a.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865520; x=1776470320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gI6TizbRGd2pQEKrEQ11DocEPLJClJG7W0jqoClJX14=;
        b=S4lfqk7Hj7d8DihKsPnt8tbNUIoW1fk+h8/Qj33NGFpYgx7MNnBRyHqcNr8/QcgPmF
         rj35XQLh6J48WU7B9eB5iJqIENbywkawNVNazwbgjS+OXidGdeNreu4BXU79m20p6OD7
         HKgzGqycC4z5Z5h/qBN7N5aqeV0CtJQOjXiy0nJuRRBvSWAan2nIbKQ4oawP0c/D1Wdn
         f3WjKQQUNFWhZ73o3W4gAscii4tiBqQsj098bzZhwJuTEEJifreb9C9E5PeAY5T47Cui
         x8wyub/gYlxN2K2YekZMRfXvgb1jMkRMtzv3Ye6rquxDB1Xox7AQYTFhWDROXUJQPZ7i
         yhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865520; x=1776470320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gI6TizbRGd2pQEKrEQ11DocEPLJClJG7W0jqoClJX14=;
        b=X6P243XF5jgOimwCpP1NBFL/3SyTeQsfwIOhMChVQ3Z9+GeYh3cazuyo45pK/GeRIF
         1/g5T+eHpGF42H8HlQJNeefq/YTi/R3Pm8FjCwqzY9DMxyxllMWa067Zl/8L0hK38ZeV
         3qTOZuee/JD5DmW7xxlOt0NuiCRssRQKaKb6SHupqJUeQmIjVdpfYpQoVPWPbH/mATZb
         YjlKWe1LFGpyd9KhW5aocZZOPBg8s1a+PkMPLK+HmgEPTwQEKpRD6eHx61S4XVQRXRJv
         KbE0wJnpCyuALeGElmm7dG42DqC+vRlpAoOnZS+BqrY48pLZCUXp4SmTHELAMi7ImUK8
         uBqA==
X-Gm-Message-State: AOJu0YzNit8wPaxOiz+VaHU/x0bh1nQkmYtzHSXNdIddlTojETSxx0zv
	GEbQ0WCRVdj1eB81QYRKTzaGygRIM0Ilz4a4alyORjYutR1lTnDS14wQO8jl++682cOw3iuLWk/
	f2o143g==
X-Received: from pfbli5.prod.google.com ([2002:a05:6a00:7185:b0:821:82a1:fe7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8686:b0:82f:2226:5aeb
 with SMTP id d2e1a72fcca58-82f22266238mr225702b3a.20.1775865519456; Fri, 10
 Apr 2026 16:58:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:21 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-3-seanjc@google.com>
Subject: [GIT PULL] KVM: guest_memfd change for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A single gmem change to not set FGP_ACCESSED, in preparation for in-place
conversion.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-gmem-7.1

for you to fetch changes up to 6dad5447c7bfca26b5d72604b5378dca6dc58bbc:

  KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios (2026-03-02 14:51:10 -0800)

----------------------------------------------------------------
KVM guest_memfd changes for 7.1

Don't mark guest_memfd folios as accessed, as guest_memfd doesn't support
reclaim, the memory is unevictable, and there is no storage to write back to.

----------------------------------------------------------------
Ackerley Tng (1):
      KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios

 virt/kvm/guest_memfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
