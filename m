Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA9391E5B
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489272; cv=none; b=EvEnaYBxlHpU8UJJy+gdVHtFdBaG7Ir6uqCAy9yEGMfnxjt3FmX90eMx7OgrBiYItKH3otLnHDx4a04NptmsviX7nhKKe3BEyPO+po8gdHKeVnnG7fZgkUcSgDvvv7GjycSymDB+fY86226n2am/WnQOqyy+5dWznZ0y+BhUgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489272; c=relaxed/simple;
	bh=v+9yhjJZRqsICuTjUNwwtwXQvm3AX3sIPq/EIuG/Is4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TzTFWYpEKDeUcfjpNGDl6bnypOXiF1mk/Wp6mTNsd55sv1K1JjEpRebeCuzms8PToq6oUg2jiWSFLB9CLAUNrHVEOZ/RNFRszrq8U4XZBtEBhw/bE8ydDaAsy2RhgUUoYX710vfgOh51Z6v+md/SmA8wqfU4t0sD/61VdrvwRxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ed9/rwaz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ed9/rwaz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c81086bf930so5419643a12.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489266; x=1780094066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T49eRAgJGORKJjDWz5ACQ4FlYGQKd8GXGnZ1xQz8omc=;
        b=ed9/rwazrlYEqRERrWTJ9uJDRGmcM7uw3NIsqc/fZ3meDPF3SOjgBlldKmCQkIxMMk
         piOlBQFXGRmivIYwDS+3KK+fteClLjF24Jq63WL1pF71X0Z5Mg/bwbO3MLqXJaMRJwn/
         WWmnRKZoh11Z8AJ9N8MNac/wRWubf/DSGqJbI0T5LMt6Q6zG9WQ7PHwnYGEIn/1us+mQ
         UYhsOtdBgPKd5TK/rjLrcLyZxap2oWh0c6VOyrd0vjzf6G13YrosRtIvQT9IPNG5aRTJ
         0WQkcNzUhriNH2D87FTqJlaQf2+2BbjI80frzh48ZPdcLvi3O2EYroKqeiQ4ZJqlLN4X
         MclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489266; x=1780094066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T49eRAgJGORKJjDWz5ACQ4FlYGQKd8GXGnZ1xQz8omc=;
        b=Dh+orvb0cv4ew2IMOXdJ1rJxExGBWAELOkcYELe37g1Hqnar4lLkT1eoN9bmb5nwh3
         SpFXxI8dYYX+xuk/owQ4u2yFtAHNJgnWxHyyWGlV5idYZwZuMQi1kXUIoCm0f6jWGjut
         2hocwXq4SaWIV7ShXaZcnCEJa5B0QKFibwbKe0bKwSdnjTtx687cBAxDoFvMHuVz5quP
         p3rOYyJcGhmgZWontuQuh+/vvcK51gLpoI9PACKkSmZDc/+blC2GGZIloLGai2Y0kzia
         ViGSND2xloREMCvl/d/ioTsSqMQIn+aDsKGzplJrcK+XkIO+yUSYRTPLO/6ta8fkI8QQ
         tXjg==
X-Forwarded-Encrypted: i=1; AFNElJ8o5knEgVrGumF31oiO9TBKnGkwmkGZyiumBB+XUSXJ5KcuQ1T4MEmm344729CebcSScl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15Zu2f467yUnfiR/z8rLTFAhJ0APb7PRI0QKREJkIbxWcwJEb
	4pkHP9vIgY4a1Firuub4uqqYsV3lxLjadNO4oD89TxCsJiRXeNHK/dAEqQQDWKlsERMAKuxJSBc
	XKpfJ9g==
X-Received: from pgau15.prod.google.com ([2002:a05:6a02:2d8f:b0:c80:26d4:20ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:3a8:800:bdf4
 with SMTP id adf61e73a8af0-3b307f8ad4fmr8928343637.33.1779489265676; Fri, 22
 May 2026 15:34:25 -0700 (PDT)
Date: Fri, 22 May 2026 15:34:25 -0700
In-Reply-To: <20260313071033.4153209-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com>
Message-ID: <ahDZ8Qg3QK2a9fgF@google.com>
Subject: Re: [PATCH V3 0/4] KVM: X86: Correctly populate nested page fault
 injection error information
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Kevin Cheng wrote:
> This series fixes how KVM populates error information when injecting
> nested page faults (NPF on SVM, EPT violations on VMX) to L1 during
> instruction emulation, and adds a selftest to exercise these paths.

A variety of comments, but nothing major.  I'll send a v4, I already have the
changes locally.
