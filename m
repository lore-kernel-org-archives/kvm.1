Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7194E77F0
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610409; cv=none; b=NbEhLDGDxqh/kPHgSYkhCrCGwHMuh8RuTY/MHzBhrvsg2v5ujM/lWikQIeMR561FaESz3jUi201alO94AcPd13hDg8I/2Y9ZQgieMEQV1P1xR0yfibGCmbiwa86yy9W0BtlO0TZWEriKLV8W3nBZRxzyuZLqBYn3VN+zfBj8xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610409; c=relaxed/simple;
	bh=zUSOTKG7jh36LtiLzwadFBmLGJH1sO8KyInZAeeVpg0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uHTezWXCztFYWgQG8V0a8MSwvD9gcSxQRctTrG590xP9FFAy73SrtxVgqsmkE/A8ZjB4LiwKbEVjtEhAhilQzfpCuR78zNdsTf6jaI3ray8pQigy5x+2Mm3qR7sqZcM0OhvCAurt5D4voj2s2JMOq0nnKGSSs6R5itV1QNCoxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7BKdUWh; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7BKdUWh"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc44d708055so3917623a12.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790610407; x=1791215207; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zB9SPDkNv+eeFxSmYp4t86BYZ0eykAy0n5tZdc0Mzfc=;
        b=t7BKdUWhT0EKmrGhiODxIs35cvaGQDvi3N2AqpQsr8l4RO/yfdE0Z8pzQGr0+7nw+w
         CdwrIFJY7g/ZuZ3FWbUVYD8Yo+l/7xr/mF4LEDcxfbJCVwPbOVNRMyqjnd5dZAJXcL3W
         wuv9Kl2BGNQ4XA78wOtYfumaE0z8lqvEIBmG1YK6veobhT+vBY5JrNtJ8SrHluWXSdAD
         UxB6H9V0Gez77hhHZ7gjh70E+daWWW/S+Ke8zOb09Oygq8cveaaHxHZBHyZvXQRGamp7
         QGutWvqJTWp0NFiwBk6b7jbI138sKV+tQrl6LjL4em6RVUGp6fL/CzG09k7+F75UuqlO
         b0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610407; x=1791215207;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zB9SPDkNv+eeFxSmYp4t86BYZ0eykAy0n5tZdc0Mzfc=;
        b=vBRiD9RdHSKyW56IYpPu5P0fvGoox2ngfgKWX2ZkberumqIfoqlzT5hQSLVI+woxiE
         l7cBVA5kO8K8v1FZLIWzIaEJiW35UEmfohzl+eb7ARO8J+q110I7t4xAxExJ5Zrud7+7
         hBB2Xrc6nqLzGnWFHpWZigbbM3ucqCnOodlkkQ30A7QnAFaSDgUsC8pMDnvPAmJc4KCQ
         dZr/IY7sOh9vvTIEwfmLwzf1YDo4xO95ee15MMg33G7Vus8Vbd/GAOdNW0A/1ZweO5uI
         mdNs37X6LXfB2iNSxCjbXfzd6zyWRF4f4c15iV5tRu2NkxkiehREaLgFIbb1g7d8AADe
         WC9Q==
X-Gm-Message-State: AFuF++nQMS8s6p/f93JZn0MdI97oE4i5kjg0FJ2Xuc7P3yKXeAoKOt0X
	wlfiN2KChzTuo4BwkuAGB2S6spfWLnMXoR8h0P9tiRP5K9VtFbl4io4GiIEFbC3bqIN9B6y3GQb
	2VgzjJA==
X-Received: from pgdf20.prod.google.com ([2002:a05:6a02:5154:b0:cc7:9a39:8bde])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b78a:b0:3d3:afeb:880
 with SMTP id adf61e73a8af0-3de0e75e915mr13052663637.28.1790610406739; Mon, 28
 Sep 2026 08:46:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 28 Sep 2026 08:46:42 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928154644.2559454-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: SEV: Fixups for the cache maintenance fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Two fixes, two bugs.  I'm batting a 1.000.  Fix a double-free and a race
pointed out by Sashiko.

Regarding fixing the double free, I initially said I'd just move the allocation
to avoid having to deal with CPUMASK_OFFSTACK=n[*], but that felt too much like
I was leaving trap for someone else.  So instead I elected to nullify the
pointer with memset(), which has a fairly desirable side effect of clearing the
mask when CPUMASK_OFFSTACK=n.

[*] https://lore.kernel.org/all/arQMARDUTSjbWpMX@google.com

Sean Christopherson (2):
  KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
  KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV
    state

 arch/x86/kvm/svm/sev.c | 46 ++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 17 deletions(-)


base-commit: a4bab1c12fd528ccaafee00360e07463873404a9
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

