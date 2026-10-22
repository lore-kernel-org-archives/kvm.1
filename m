Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635504;
	b=MupejEgZIOxOJ2is8W61G/AwxK5ym/OHbrDii3H6qzZ6qlkPd3nsJkqwKJwGwVpl1HyV
	 +RLC6cOK6im/9WkbfkGPTByFX/9D9fTuYSp5/PNBPD+4Lp1oCTdo1KlIItvdLk6mg3eyf
	 PdU6CA3i0c6u8vvzON7epp2neFHdttUv48BsMEkKgQQCTOiq263c8itqQKWBsy5U3H0q0
	 qGG1daHFqDR0whzKz6cGvBVmz184Ddz84BE0Zehbq8W9BjwlYrRBYAva38PNZzaOWSPgz
	 0LEahCmJCKU8deNbXw/5VkeJ9ATfXBbkgsnhoiKzPkI2ot58evwF6aZiDVLvzVimtFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7c0m7qaS9HqUzHfqjVCvNrAuzThap6chMmtplqP6W0U=;
	b=fM38KXNtMPMkeS/wuMgOFskoB04cTXzGz6RCtVgvYt4UM6P3d2e7aKfeUbNz973L0x2b
	 c68c9h3tCG/nKOjwV4q9Sl74fA/OUZ73r7aRblWUO7TLvKGLPvq+JMhZ9JeBx93MJ6B3Z
	 OUJYLcwHaKTETdjFAxPB/O19UHBykUe+6sVU9UAvq/uhWEHji7HNaYBGswpdpIOh+jru+
	 6zLojiPn7h1yvP5h0Z/sWs4wxox8fwKsAib9oIibHjmhl0p/F9uFVUoslUBY7xmNpubuv
	 Pj+FkcWiYve9a2NqgPM86r3/eU8saKdhyZHiegn+iRj1n5ncI2poQP59VyPn4sfdQzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=n5bSloBD;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50662606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50662606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=n5bSloBD
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so1405081a91.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635502; x=1793240302; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7c0m7qaS9HqUzHfqjVCvNrAuzThap6chMmtplqP6W0U=;
        b=n5bSloBDYiFamzpE7rWfD1B8XYjfsxrZVUMhnzZOqbBCvWpPXBiyYJLYiL1hHLULAF
         bRo1PmjRJdB07UX8aIj1AztpMg/tyfFDC2UtqBo82pdiRNlYiI9GX+dofwhp5wdUCLs7
         WnVBphB/pi5LmtJgqYt9BBlnkWDh3u71bVA6YqHDNlCOlxENdKcj/R2LndzI/4ms6iNO
         1NGs+nTZixZI73F+kbhHWHSH5RE4A8qztzrQVZdOlo6J580KR1xe4qveirG2E7c2/u6W
         0oWsmCB4etvAN0pbbOo14VTq7kdMxwYhkDU3UA68F/tvRyIxRyFwi+JHCwKk64+b/vYy
         vpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635502; x=1793240302;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7c0m7qaS9HqUzHfqjVCvNrAuzThap6chMmtplqP6W0U=;
        b=ReeT63RVQCUU2iIr4be8qd9/kd3rxx94AZbw19QY5PdDKTYm1xe/02W/KgwOhCGIRr
         i4LXoIom/guOt43K7yzL518x1bzW1UVmRokph5HYXesQ5ja8DwASet1Xp2JtFsbXRRlm
         XJj1IJiVL5G/ArTQpUs1LAwoqbV6PsLL1dap2bH1vnugsJtg3AWpOVWRgQwYZ05VHYuE
         /KTkE1wUJcDFu4jrVwUrU3VH/gMzjc430Q2h2a0SLxZsNxaK9i3w1c/4p8hgOV+P6rxH
         cxKr3gkOaFxFONE57f3fLEMiK5Mgwsnl31AHHtchc/u5kVfixul5EEbae+mSJbtGB8IC
         CU8w==
X-Gm-Message-State: AFq9FYLgAGoP2Vm4y9pLZsnwuRSJwENTRt5eD/RW+cYLltUznqLZTFA+
	GYVffAh/YCGxwEVB2zYj4sz9fZeIbKWtK2l2TcGgG3LOJJm+7CtFHOjEY5Z1ll9sjfOWBZnQvTk
	yrbVQ8g==
X-Received: from pgn27.prod.google.com ([2002:a63:d5b:0:b0:ccf:ac26:a979])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:3ac:a7ee:6760
 with SMTP id 98e67ed59e1d1-3ad86ccdc8fmr3153086a91.23.1792635502327; Wed, 21
 Oct 2026 19:18:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:18:18 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022021820.298886-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: nVMX: Fix a (benign) overwrite to a userspace buffer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM writes more bytes for KVM_GET_NESTED_STATE than it reports
in the output size if L1 is active and has a valid shadow VMCS pointer.  The
bug is all but guaranteed to be benign in practice, as all VMMs I could find
that support nested virtualization just preallocate the max buffer size.

Sean Christopherson (2):
  KVM: nVMX: Save shadow VMCS when getting nested state iff L2 is active
  KVM: selftests: Add regression test for KVM writing but not reporting
    vmcs12

 arch/x86/kvm/vmx/nested.c                     |  2 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  6 +++++
 tools/testing/selftests/kvm/x86/state_test.c  | 24 ++++++++++---------
 3 files changed, 20 insertions(+), 12 deletions(-)


base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.218.g1ec904b173-goog

