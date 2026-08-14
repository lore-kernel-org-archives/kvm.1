Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B1175A8D
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669968; cv=none; b=RGGf1HjwtR2tUGc97jOKSJMUxTHaDfpBcJTNwsAi4dPv9vjm2jCoUpC54Ce2WEtZJsQkjWax3vdq22wK6CiQKPuQ0vzuPL+lREpUplhYHmHUATJP1y0TM1nuo4ZAd1QZhtPhIgDNjWjpvQsLktClTfx5ZE1/ue9p3iaKzb0xgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669968; c=relaxed/simple;
	bh=GlnDYwFGGLDYutOM6HPj1F35OIEL3ElIdqJQ6KJRVTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EepCcx6KJZTMObB2+lt1D74jAzGLaRPYjbZnvRJjsjgenMDZLFh3PGoauT53PHBOCShe7dq30rJ5ma/M2FaHSdF+hdReNjVCQrytLBiezAO2qcgqJMYhztOUnsVBZMFMCHLIKIIWfmhlg3dEyyCdmIt33uth9PQtFFRVlrP3V1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=U077U9Ga; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="U077U9Ga"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1201471a12.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786669966; x=1787274766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GlnDYwFGGLDYutOM6HPj1F35OIEL3ElIdqJQ6KJRVTc=;
        b=U077U9GaT1dCukOcEwadD8LjwuA4U1xeiKcnu0fixGTVD++EcqU09caXQTtHYy20GD
         LQgR06juufTVk0O1M9FEu0ompVoZz28jNuOgj4cKFEDokNXETZHKeNZtk9tTgwnZzKbW
         IE8RI9j837JUZhQXr41K68vHQBFLT2X07dPP3jOX0aFFhZwRUe4tSRE6vyoG2qDh3ew1
         eF3QGq3gfTHp435B4fSJGxtwEEIgR3dY128qhQp+GBlOdDT8sv1xBYmW+2rJs9fEYKvm
         c2zY85RS2FpEvz2scBbc6fJhqOvFXYl5p4QggtdgYwLaGH3mNbMF0uALdf9K64pzfhCB
         ha+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786669966; x=1787274766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GlnDYwFGGLDYutOM6HPj1F35OIEL3ElIdqJQ6KJRVTc=;
        b=iSwDDx70GdX+5nd1ipPtaKZ369wq/m/lPTJvHBkoIONWyLYarMr74PFzaFVGmX0ax9
         41aYOWUE9cRs1gx1FxZ6m0NTaQsFyBgnK3YeD01/fxmd7vrhjHUypldtiW2xs2tudZEp
         eDWG6AMD/OpZfB834+wfSW/AsOl4iZLFD9xUMHlYjtc8YFjuNRemOBdueDfw9mAVTy3z
         DS47yQCTw021qQgnCzElRKZGdWQ7F4PrIng0JnjdAhdr2kdDuqz1wEuEgBISBsxuAU8y
         LkM3UD4g0L0/RENqGvGvfgIUf3BLNxvRFfHg7Dz6ihY/FyiPlitG5/7kUwjXmN/cM2lh
         R1KA==
X-Forwarded-Encrypted: i=1; AHgh+RopZJrp2EJn0Uab1e7Oek/eo5ZdOXpZt5x7EezelICoGaL94j6vgrr9tk4CThOylgefkts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nVW6lGfdN0pG7Oy7l3qs7m1qFTr9RTzr44vI2xYmQtfOcEFP
	2wwhzBLruWW/w+4RkAmHfos592Lt6dRWkNqkwzg/eec9qqaO4RHsIK4oif9+c8uXCb8=
X-Gm-Gg: AR+sD10zwui51Si20xLqt8A6hliGSp87jpsqmt/hca7OHajEXRAlBqKpKzD97l40Zvb
	8HS9LrOTDQVQAaLHoFlrAStCS4F5MHdxdBOOzxJ4xXXESmIQdzz7Lbsch58oyaV9uxUbQ4U1bxu
	bEhZ/cQ3m2xt2X0ZhEZxZOgDpWZcOfyZZKsRqB6vlp3IX5ER5DQU2YWqApD6Kb5Kfdqo+bpw7Ge
	pIQHIb3HI37Skpz8R5Y4NxgEyHU7Pb4sUm4thhbhUyuNixroMRGZAHTJgpJUXR7QsqatLdFG5n4
	+JWppsRZhsE6hvpo6zhoff4CI/icRnC9u2+w91GE7JkDRxfkGB8gI8biJ3AfpmFas07CyYJrVCG
	AzktGM9kri8t/rQIicV1huhlPg9zdumVTg6iwgT4uRfb1/Kx1sxKj8qYsurZ7UG5kMInTE1GL4v
	tCKb/4xzW8QMsZECfxjLh72xgSmgwfSoqONEzXctUqjVJCan8mtqGI1I8I2bUteauzSJCv9HiEZ
	RwPXKAfEUekta+3jko74OB5c36GRYjFC5EQRkEhJAnFSCupc1R58NLcS3c0xw==
X-Received: by 2002:a17:90b:264c:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-3931f47d73bmr6214537a91.6.1786669966275;
        Thu, 13 Aug 2026 18:12:46 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:591a:2e75:81f3:25ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31f15063cd8sm9015120eec.9.2026.08.13.18.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 18:12:45 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Jinu Kim <kimjw04271234@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] KVM: x86/mmu: Write-protect tracked GFNs in all address spaces
Date: Thu, 13 Aug 2026 21:12:27 -0400
Message-ID: <20260814011229.72845-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anOLfLhAGbOXT30p@google.com>
References: <20260804105755.276646-1-kimjw04271234@gmail.com> <anHk2wTLHYxdB0jD@google.com> <CAH+3ta4uD-QYju=6YRqHvd4Vwa-WAa9T9a65soCzdu49wNxV8g@mail.gmail.com> <anOLfLhAGbOXT30p@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 12:14:04PM -0700, Sean Christopherson wrote:
> Actually, irrespective of what we do with SMM, we should harden KVM to
> skip marking upper-level SPs as unsync, because while corrupting guest
> memory is bad, corrupting guest memory *and* crashing/compromising the
> host is worse.

This is correct. There is a working guest-to-host escape via an
upper-level unsync shadow page. It works on Debian oldstable and
likely other shipping distributions. I'd like to see that patch
applied even if the SMM question stays open.

> it wasn't clear to me how marking an upper-level SP as unsync leads to a
> corrupted rmap, and I hadn't thought too hard about it.

There is a bug, unrelated to rmap and still unfixed in the longterm
trees, that turns an unsync upper-level shadow page into a writable
mapping the guest shouldn't have. It can be readily found via AI
assistance.

Either of the two suggested fixes would be fine, but the unsync
behavior is dangerous and should be prevented.
