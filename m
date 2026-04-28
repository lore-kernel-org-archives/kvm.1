Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B440627F
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396558; cv=none; b=sKetZijA4+Moztf0YtP7AbbDfBs1ApEvfVL8fbkZ7dNXQlfHs0R68EaAR4uvEHSF2nIsSXCYcHBD9mLBs7biC+JojO4ypgSicUdLB9Ug8+0f+dn9lOgXrNgSM1UQD3oCa88c/qPoZG/m1MKCub9QWtds6XsR+KA+X6Oj+MbyG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396558; c=relaxed/simple;
	bh=EFCqKtauG601YKuTm/S8bpgkJL5Jx75lmnLeqHqo0jk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ob2DX20w+2P35Z4i6EUaT88UJsFYQbT+bGZKoPOtAmLcO6AAQXfraWQu5FV0RWhZwRlny5uAiwAIhXlf0LzwAqFEqa7z8EzK1KAMsOW5ki74VmAocftFylI83cmN5oy8/1C2/lBbFZ6XFXaEMu8fGuYQNj3+u7jV7BejFWU9K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSDXqeV+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSDXqeV+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so28696a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396554; x=1778001354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzvFjaGhwJfT2GgJYhg/x5PuJooGY1nNioBCH2IfMW4=;
        b=MSDXqeV+C7V5CDnGxoPtYhYl4PvnZuo5pSW+pCQmGKkCx1ABrtDnhsJiOTkCLK6jLW
         Hy4TVLCB4F1PhlGWwb/C3r0CuHWPyZYcCjNg2JHBu3TTf8RMpnxooN2zYhHG39ZHG97F
         65wuBaF+Bk/NDXtLzwe7bi21JZjJyf3k6hc/4IHnfailPPV+atTPF7STZ5Ba3SrzL4lK
         e7MrvV/BPkD0OEW8dGw52n0MqRScakW7ff7noMklzkVkedpCbH7BwGEYmPL8TnI5snY7
         w7e7if2cgxs6KoveNGlk+t3HLbiciRQtcKnbE4xwUO3DT5PTPg1RCDPhmG45Re+0i2dx
         kOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396554; x=1778001354;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzvFjaGhwJfT2GgJYhg/x5PuJooGY1nNioBCH2IfMW4=;
        b=eg+fv3tTjSehj7R7N72hCLY1TLT6WNsLi6lx371lrGnXfSQ6DGcrOBhP8J7SuKY/l5
         CPxHaHId5hNVEMBxESTe8ONrfEgLf5qzTT1E2i/gJQqKbWdKnquzGugxHJcndeLmd79E
         vEvFGufTK4anVz8nJH41o9NQfAJeLEQKUJ/ZUohrSqEb28GSD523Hlgc2IPxjdsfkQD6
         D7kDipVgtwCOYp0vMCQsyNG5D5bXv24ap0lFxO5TFJR2JHAqWa+4zSWK865ByCYNKCRJ
         IlEWuT8CRds6js5iOV/12V2FR7kyOvgCdI1mUO5ZGFGbV1QsvTGN3Fykk+7ZZNXIUfp8
         qT3w==
X-Forwarded-Encrypted: i=1; AFNElJ+BWj/ev/BCf6EIWpRgOjgSizRUQYIJ+hO4eAXxZSLfH7X60XpFuyIEAj89aP/uT3/1m/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jeLO234ELvPeX32GlBQ6fPirDSxFEVQiOT+/EUsLOGRDMlZQ
	0fOW2dgjGjwQ2mS5Ch0EOM3MgpszZhcp5Al2/d5U3lCr9vlW6x0lYy8R4tZM7t0kDxnrerybIxk
	CDlHrlg==
X-Received: from pfob24.prod.google.com ([2002:aa7:8718:0:b0:82a:6195:3c55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b90b:b0:829:6f7d:3086
 with SMTP id d2e1a72fcca58-834dd390961mr3378367b3a.11.1777396553644; Tue, 28
 Apr 2026 10:15:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:36 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-1-seanjc@google.com>
Subject: [RFC PATCH 0/5] MAINTAINERS: KVM tweaks and additions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

A few tangentially related KVM MAINTAINERS updates.  RFC as I haven't run
these ideas by anyone.  Feedback is very much wanted, especially on the
non-x86 changes (everything except patch 1).

Sean Christopherson (5):
  MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
  KVM: guest_memfd: Move gmem function declarations to dedicated
    guest_memfd.h
  MAINTAINERS: Add an entry for KVM's guest_memfd
  MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
  MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry

 MAINTAINERS            | 14 ++++++++++++++
 virt/kvm/guest_memfd.c |  1 +
 virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    |  1 +
 virt/kvm/kvm_mm.h      | 27 ---------------------------
 5 files changed, 50 insertions(+), 27 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h


base-commit: 39f1c201b93f4ff71631bac72cff6eb155f976a4
-- 
2.54.0.545.g6539524ca2-goog

