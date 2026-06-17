Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A690399369
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738984; cv=none; b=jESoBXraBSInC6bnxj2qnbzfv1g+jY4pkGKSqNwLPD1uJySsfjV4fdtT51bop+fBDUvI8Niz4ujAT6U/0SBlSdIx3KU8QVK+G+0mkjrdJIQttsv06+HSkPVI9Lc1xQh8kUtZomPzu4xMg5Z8xr5rVWYH8GaqEe2r6cJ9GGiWgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738984; c=relaxed/simple;
	bh=KGe0fIgA6CrmevH7QXGfRivDLCr312l+T3VAyfrPlx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SxFeR5A2dBp4MT7Nz0TBSTGBMj99iqc4XPFy/yt4EtwME+s9i6DGpIeztkEtA3D/5whoW9yrjXc8HopLzOQISW7UDQmrHuUqeG7YA+bWryNmiNlPJGA/8asl8kJOaw0BEEzurpEblQU3iALF+K/8fXkgbV4elwYbyg57sfUnPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nP1qkWFO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nP1qkWFO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0d0516ad7so3409485ad.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781738982; x=1782343782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8rCE0umJmUsRzaCo/yqnCV3dJpJvx3j3FQHgxRCskI=;
        b=nP1qkWFOPmZh9bCq74bGnM0af+kJueXnvOJvc+z0EctfLMT3ltTGjVs+/Jcx9vMpxb
         HGGr/TsSwItH3QedEUt53Q3O+9CNHUbeSansahValqcw8Nun3blRhGGN/vbxFHsR4lwY
         ELigH9AAKub3zouw6D71gjl2T7hr5jUNTd/rut5QYtzpAH7en7St9YT24Mx+NWbcgWQF
         m7muCPbefvQHA9DV74b1twdMaKgB2wNFaRYpViINeJ+F0Ke0UZ27bp86JAfUu1lJ5swB
         iZz2YulDuZDVbkQ9yzmJNdr1zfsr17TAK2346r83hMQsMhZHXVFb9HO/9hc3oQHjbDn8
         WLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781738982; x=1782343782;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8rCE0umJmUsRzaCo/yqnCV3dJpJvx3j3FQHgxRCskI=;
        b=ZwQ1xIGF7H9P2AWoT3V9twocojTN6sT+WJ8v31f3NpU06lqKlSJ3Oaxj88I34xqM3t
         OqQCr+W3VDTrcde1sPnST2A0ipb7YViri0+DgpuDkUXC6SmgnE9E8TFJWjEjT8tOu5eD
         x1EXOBfeZHBYsn4VdkU4NqXkcbyER/RSOhiQk5Dk9ljb3jcCfKzIrJzBBduDWJwihDwS
         5vxctGskWELc2QSMLPmaHrDd3jKEDVbq7/pgcSCI6Op+vYSDWl4iWM5GqZwZE7YJ9imf
         GbBWUAF1WwXH03fhbVe7A7VPlky4heNfR87Kw5vIpy5VhhrpGqHz9zPQn7CBicbG+fpX
         87sw==
X-Gm-Message-State: AOJu0YxJ7V40Sqy1tklETi5vOtpv4qSM7HKoCcYC1s9qyeq8AJpFOKRC
	47k67IGikGLobIc/d0Tq8ffQ1B5iq7jxqEiP8Ku5UKnHsArPwkNrUOo238T67CWuUkWGEi/61ir
	cMSuOOw==
X-Received: from plbmj15.prod.google.com ([2002:a17:903:2b8f:b0:2bc:bdd2:af75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60c:b0:2c6:d70a:92af
 with SMTP id d9443c01a7336-2c6e52ebf6amr10173245ad.37.1781738982244; Wed, 17
 Jun 2026 16:29:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 17 Jun 2026 16:29:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617232939.1672228-1-seanjc@google.com>
Subject: [ANNOUNCE / CFP] KVM Microconference at LPC 2026
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

LPC 2023: Game on!
LPC 2024: Game on!
LPC 2025: Car!
LPC 2026: Game on!

After a one year hiatus, KVM is back at Linux Plumbers Conference!

Proposals/abstracts can be submitted (link below) under the "KVM MC" track.  As
we've done before, we'll tailor the exact timing/format based on the accepted
topics.  In practice, we'll probably end up with a large chunk of guest_memfd,
and then short (~20 minutes) and long (~40) slots for other topics.  Feel free
to note your preferred slot duration in the submission, though as before, we
reserve the right to ignore your hint.  :-)

Note #1, the KVM MC will focus on KVM itself, as well as KVM's touchpoints with
other kernel subsystems.  The purpose of the KVM MC is to supplement KVM Forum
by providing developers with a dedicated vehicle for discussing kernel
internals.  Topics that are primarily aimed at something other than KVM are
firmly out of scope and will be rejected.  Please consider the Confidential
Computing MC, the VFIO/IOMMU/PCI MC, the Live Update MC, and/or KVM Forum 2026
for virtualization topics that aren't directly related to KVM internals.

Note #2!  There is an early pre-registraton period this year for anyone that
submits a topic.  Pre-registration will tentatively open on July 10th.

As with all MCs this year, the CFP window closes August 7th.

Thanks!

Logistics: https://lpc.events/event/20
KVM MC:    https://lpc.events/event/20/contributions/2325/
Abstracts: https://lpc.events/event/20/abstracts
Pre-reg:   https://lpc.events/blog/current/index.php/2026/04/06/changes-to-registration-availability-for-2026
