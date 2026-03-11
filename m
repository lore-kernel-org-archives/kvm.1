Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32C3502AA
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262653; cv=none; b=OS6xpKf3V//E8o7qE4nh07pH0jeX9y1zTp8N2PghEELebRVjFCVmi27iFXiyfy9VNnz6HYlKGjY/E+Q7YlNGuVis4g6hP3p3STqVkpbeYFR8Aj3xdw9QzmjWFd0Sb6zEp1rL2McmoB0oefgJayAz19GcMSSQJDtZxMuYDNysokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262653; c=relaxed/simple;
	bh=9n7THgO8BeAYRFo2UTVmcYjFqZ24ZdyK04pasRsp8uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDqlw3AzsiJBPHWBAqWwBekC356loxs45MxiPXdqkLc2M1GSr4OhYWaSa7vLUahW/HRLoDYG42IrKWAHc+g7BVeplUwF+ZvjHk35qaL9xoDU9lzRg/Jfr+bbqitqVmCQrIZexAEm1rrPcPy1taG/oq2umvMpYt1iUPWdXYIjw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siPQSX9o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siPQSX9o"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3595485abbbso239045a91.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773262652; x=1773867452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4TfVhVbyP/UFwW/kmzaSUHr2Zq16cL7z//AyGEftuU=;
        b=siPQSX9omkUL4jihoYCoaFnqZH80A5bAy+eNxm4yXtgkpNE4JnnyPZEtJZN9kbEKFD
         DYgebKQYwHy7CU4MqfhSCS41pF3bWm3KI0tzWNPyYFHsnseWX9F1jIWel5OqpAML9vtz
         ks79IhIJZpmN0Klf6NzkeRZlA4as2pJkX/hsI67B3w0ozy9Ew+FRiZ1vQj6NYLEs3ubi
         Qn7hIWdKGn4XMZZwCvZk4pNYpAAOqeCnmJoJeP7S7+1UmrAhYf55xBXzef6aZ6Ct3eO3
         +/gYJufqibF3u/9OQgxQn6u83x6QXiotyqIQ0326inkYJ0r6Pqn7nuceItKw3zdrdjs1
         JqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262652; x=1773867452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4TfVhVbyP/UFwW/kmzaSUHr2Zq16cL7z//AyGEftuU=;
        b=G7hFNVgpdon7EmqLGHpPcPR3CQ1YjNhGgmJi3mfu0dC7bOEFujOLlvPr+jAqnyHBR6
         /nDbq+2dtocmPL3KE4ae+aRoJRfi8DabhPEn29NbK9DVLxuWEO+0MEegOliWvRTrJ9y5
         wYsQ+Z1o0UGd2e4BCSU9a/raEPQ4ThWaxU1j4UzTC8PlMHx+B/1pfoLCTBcybbVb2mMY
         ZcBxX4lPEq+XXPxpx4v/Hkd5H9ByAdxzO8GWvjMY14J601QA0FwVBcabSFPpn0GPCWB1
         Y6kzJP90Qe6gIQ6l67kgZVMFHSNwR8ph1K+pGPgDiF2AGOxK37Ax9Lr0GA9QOYVGMLub
         81Uw==
X-Gm-Message-State: AOJu0Yxwmqyu/z2DgKzlJwNyjBHc274IKDKAT3G9iNeCKydc6M+2KV0X
	jt4d4E0hPdgM/QRQ94GrtCHSsQKlNWTfuDAO7AAZ7PbYNUE5tTchZNx5Tc41Z7H8/7J0gd+c8pp
	FeBAa0w==
X-Received: from pjbhi2.prod.google.com ([2002:a17:90b:30c2:b0:359:f499:6e04])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e8d:b0:32e:3829:a71c
 with SMTP id 98e67ed59e1d1-35a0138149bmr3746700a91.16.1773262651493; Wed, 11
 Mar 2026 13:57:31 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:57:30 -0700
In-Reply-To: <20260310064403.22218-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310063647.15665-1-itazur@amazon.com> <20260310064403.22218-1-itazur@amazon.com>
Message-ID: <abHXOvAaK3X2FIkt@google.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: Rename mn_* invalidate-related fields to
 generic ones
From: Sean Christopherson <seanjc@google.com>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Takahiro Itazuri wrote:
> The addition of guest_memfd support to pfncaches introduces additional
> sources of pfncache invalidation beyond the MMU notifier path.  The
> existing mn_* naming implies that they are only relevant to MMU
> notifiers, which is no longer true.

I very strongly disagree.  Except for kvm_swap_active_memslots() and
kvm_create_vm(), literally every function here has mmu_notifier in its name.

They no longer are used only the for the _kernel's_ MMU-notifier implementation,
but they're still very much scoped explicitly to KVM's overarching MMU notification
system.

If we want to come up with a "better" name, then it needs to capture that somewhere
in the prefix.  Because e.g. invalidate_lock is way, way too generic.  I read that
and my very first question is "ivalidate what, exactly?".  Ditto for
memslots_update_rcuwait and pretty much every other field.
