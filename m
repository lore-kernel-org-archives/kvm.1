Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36138B7C4
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138521; cv=none; b=LGJCNMNEOHNvvDdR3oDbA6uNIohoyIqvMxMXWNm8NGj5jdexjiA0gUbJb5+F3frHHC0SJfeEIoT2CiAGpg/CEchRaZ892rRaKXg1Xonb+A1fpDf4/f8GNecmO/JV5CWqRkZAbmxgASp+WeOJQckbJxwFglAJqeYpWVdZZNk/w8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138521; c=relaxed/simple;
	bh=IiE60e9vdrmCyYWX8889NVXeDci31uazUYfodpzvx5I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oMGXrQjNhST41jMZOkHwBmaCsWOxWxyxzkUjVaLyfXM5rr9kjuFjwFNAVrL98mP1blfLZRVybEbsTy/CLspBbsxhVL6aR9aIrG6glqBTOsoBJ/6gcwVnQmRRJC09b948+yJ/TYPUXJk9w6swXDlTEgXpE/Fni34T2lPbitZNoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYb9abvx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYb9abvx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so3644078b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779138520; x=1779743320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iszeIEk56X9WmmZH0mA1l344M/n3raZvFHt7R6ZXzb8=;
        b=eYb9abvxvVp6TnT2mAkXdQfU1QZZJu7+2BEaWp+jMRViRw52fVqJM6zulM4A7TIRe/
         KVPhfLyIB2kzEaKiBK4JoEX4yO6UpfY35WuSgCs7ULPjLzr9bL0BWVEIG5l8KVsbgjp0
         h96EHzOkqT1I2MgXpdOiyE3aKeKtJ5Hl5aI4O59M06l9xntVdhvSZJ5jZi1PMvrN5i0J
         guX4z/5ua/8ywbhqjyRTmL//I7jr1jYkoT1SMRpsvZHhGeOa232yPRrqstSLVu047hCv
         U5IheHBT8fTo7mxy26nXBS5UtSsPM1uZDp6e+R23YyGWnhe/uUo5lJOHOzswEsUMpf1L
         oWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138520; x=1779743320;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iszeIEk56X9WmmZH0mA1l344M/n3raZvFHt7R6ZXzb8=;
        b=rsjU/iVL38Lq97VzWVunWPOcZRWyz3xMF+VomIXPr+SYMI6QMiSz8AvbWoPRQIPRpf
         VMRh3v9LVfPDOqzd1p/YiUuDAmZR7ZZXgX42XdGDTPut9A6UW1Iak6UUoaKtMxyi2gai
         33J7dMuaZPGFJxSL2isDM+dnSEe9wHfd8u/OIALuzDDlc1IzG+GDc3XfKWeABaqpLRG5
         1+/Nnm4S6SE0NDIJtlLd20IzdlWOKwdTKVGkGKRSeujJwBY6w2cYZI3h0SXQPNHsjkpB
         jjbkfksSQeMM/JV4adrCdVLk5bbyvcgtg/P3nlMcUTH35sY7UtbpGEhXrNzePIvUwlAf
         lx+Q==
X-Gm-Message-State: AOJu0YyuyPkq+n7r5WNO2KZtYeqDqaFcYWaqLOdE7FWdf1HJBeUg5Fbm
	NieFtb88lU0bHOhnjPHB3N+gwd76GGe8b6EVc8ZFX8AnZ1DBAOfbNGBUMMJyi/gHX2QziEwQ3D6
	hhMvPiA==
X-Received: from pfbjw10.prod.google.com ([2002:a05:6a00:928a:b0:82f:86c3:55ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430f:b0:82f:3017:6157
 with SMTP id d2e1a72fcca58-83f18d5bf57mr17467871b3a.7.1779138519795; Mon, 18
 May 2026 14:08:39 -0700 (PDT)
Date: Mon, 18 May 2026 14:08:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <agt_1yfdx3YmjYei@google.com>
Subject: sashiko-bot@kernel.org's Cc list on reviews
From: Sean Christopherson <seanjc@google.com>
To: Roman Gushchin <kfree@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Hey Roman!

Sashiko's choice of Cc is... odd.  The original mail has a whole pile of folks
in both the To: and Cc:, but sashiko-bot is only replying to myself and (very
bizarrely) linux-hyperv@vger.kernel.org.

Oooh, is it perhaps because linux-hyperv@vger.kernel.org is the only mailing
list on the original Cc that has opted-in to getting emails?  If that's the case,
we might want to change that, even though it could result in people getting grumpy
about unwanted bot mail, because IMO the alternative is worse.  I've been responding
to some (mostly very good!) good sashiko-bot feedback, but only just now noticed
that the vast majority of folks on the To/Cc of the original patch won't see the
reviews.  That's bound to cause confusion, e.g. if someone reports the same issues
and/or manually looks at sashiko.dev.

----- Forwarded message from sashiko-bot@kernel.org -----

Date: Fri, 15 May 2026 19:55:51 +0000
From: sashiko-bot@kernel.org
To: Sean Christopherson <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency from PV CPUID Timing Info

...

----- End forwarded message -----
