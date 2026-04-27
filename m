Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00E2E0412
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315058; cv=none; b=FIPuPL8iEFOEMocXxOwz6Z9qvoMSyHnDprSoxKrWWv27SO42ZcFIvtndL0M2UlAVAZkotNTZa8zWz2qlMEZb35+3dCAycTQ9g6XOR9pBVRbfrjdllqqbIagf+YhSsUqx6b5Qct+eqMSJdnMuch6ErDKdncz4a+8h7U1XxtE3nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315058; c=relaxed/simple;
	bh=m4T08v0n5rer/Aid8hTieHs817vXp7AqH3Xfx4disSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e03PRU23bi9iOp+RUdWvpZQL9HIS8CKIMJftVsARg0fQ3A3DMcEJXOd5MF+w/AT7Faj5mm8Rh174yHPyypINLK1PWJEBCN22O1zKry6PJr76Zw2mPatpmrgEFRX4t3mLzJ15ZMwDmRnH7zBsAoc7L84xkDv1l/6HVi+ie+Fc/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvcX0Usr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvcX0Usr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so12687458b3a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777315057; x=1777919857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8V0U2CiNzZ5dcx3AMXIw7uJIsqfRpaxOOQdxJ3Zu/s=;
        b=ZvcX0UsrWCBd0MC9tyUXzk7gDtSJk68TUVwDCiq0/cHWKZDzkZ4LG9yCvRIQagqYBh
         q8+45Zk5NdEfJJW1/zktk1+sduu5FQhlOuF+bHY+EzJNA/Rqu14qXVwp/7X49QP2LzMK
         E6AGwFyQOWH4hdGqxINttgzrWW37eNgEMdwfkw82rbU+fuWOfeSN8KWgif4lNdQoNY59
         uE5UPR1wC1UTcI+G9zAs9C8xPI89H79oESlRyvaDkuZKOXwDQBh2QXikHaI8wAbRIAA0
         WBQfujnJQsGHJB7O79RwrPH3WjjO7hq0tA5Dm584Hv7nDUUkTS0qKwJL+fdLJ7UQmArq
         BVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315057; x=1777919857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8V0U2CiNzZ5dcx3AMXIw7uJIsqfRpaxOOQdxJ3Zu/s=;
        b=Nh/soyCCigeXlssDpe88R89hNzkK8zazZed5Zk6C342Ka3jTxjpY8t4mUcywAkLyv6
         8v5L+E99j18nn3hscf5ncTKP/WUDsbecq4rp5ZnJIt4+NrDeHeu+jlvm+TQtcX+ml1KP
         vX2QAW3Yo9eeJYIk30KNauUJPiZy9XIQV5AWF/eO3PWXRRonJDpeLIyXFgVDPIT5NPu7
         Tnz7AQ1+mhHnoE8GfqkLmu8Hlv1Q9+MT8U+8yDBTCZAH8ZZ/ops2NHW8n6E/mWbWVRxE
         lNvUXAZljd3RtRj7CgYesqLDY4t4u4HKskwB7i0YbnDL9xDbTj/4hHqCYHoRsml7FT+Z
         VSGw==
X-Forwarded-Encrypted: i=1; AFNElJ8UFZInqd4oQFKDnYqyLiFPh4m6i6E9jQBKThFQ48FlTVaeRwNHYzjf/loCMKHG2pFUy5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gLyFn/UrUG2lPL+j+coOUhFrOdIyqNBfzPqDEiFBqE0wcSt5
	Mbbs6F0+dx7IGLxBFxMo0zmmGRt1Ew3X1nFiue0JjoyJb7LH93lqisEpbKxgNzIDnLIqorDBIFb
	c5TGHkQ==
X-Received: from pfbfc25.prod.google.com ([2002:a05:6a00:2e19:b0:82f:98cb:c2a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3407:b0:82f:6e39:d90f
 with SMTP id d2e1a72fcca58-834dc283f7cmr149172b3a.39.1777315056743; Mon, 27
 Apr 2026 11:37:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:37:35 -0700
In-Reply-To: <tencent_DB120129B359660BBBD7CCC9681F507C0105@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_DB120129B359660BBBD7CCC9681F507C0105@qq.com>
Message-ID: <ae-s7x-46gnuc07M@google.com>
Subject: Re: [PATCH] KVM: x86: enrich kvm_fast_mmio trace event fields
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 24, 2026, zhanghao wrote:
> kvm_fast_mmio currently logs only the GPA, which makes fast-MMIO traces
> less useful when diagnosing access patterns.

What's the overall use case / motivation?  Fast MMIO doesn't consume the value,
length, or type.  Why trace something that KVM ignores by design?
