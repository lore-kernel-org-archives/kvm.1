Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5547DF8B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350580; cv=none; b=HZqnzuFC0ZGPfmcyaOoGEenXAm/X2Oh6lRkBUm01QrV+bn4hpAMHpVeqUCZGGESU9zjSj7D47oIMxPZo9TLIm652zKmNOjdz+pFybPZX46plMteYLOEtxsTeGl+Upq/A80hvTgcV+kY/PNhsyi5CVZIwPWVnW/ZusPf7PHp/shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350580; c=relaxed/simple;
	bh=m0JjFRX4svUQp6KRJp+je69oUc0P9aiIdfo5Oe4XjWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2YRbgAUa6ZEJeu76PuwWY+FXzFP8IALu/Is9j2GFvSDwimXj10j0Yoq5UhgYfkFAg5a2gi3aF2FQxYjUbOh+m6MmyQRM6bb0V+ZW2VsJ0qqA2dMCq/fUVHuGvNswekRKPG+7qKJ5z6Z941lEZY/Ty93uVC9PDG0lJuLmup49GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlfLTDO6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlfLTDO6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf452def93so20481555ad.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788350561; x=1788955361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6Md0+LJRDnI+rQO3Uvm4S5xh/BVG8Mf7Z6azFky85k=;
        b=QlfLTDO67GnAgA09KgHd6vVHj7fliwjQQUyglyoEwayG/r08elxySkq1ekNgPwn104
         WnThyK3v1QSVmvvxQncA2DWyIl+u0II8cQQtJzuwu9VY1Utz4DUQcI7MbDqdoO4S3sQO
         Uw2FH0WJ/NKQn0wnYIY0ltAtrZluB9lPkb+4R6pFhCO8zTrgUu8+5yFjN4Qp1ZeOOLuX
         zdY6YLyG9uk6BMBfXs0+EkjbFzUXum/KcHZWbwuqf8ETW0itqwZPm2nbXX9B5Ymq91dH
         nJLSfeuctDorDS3nZ5a9NlWFtSxltVlq2JYlZvGd3+FmgygTIxOGTnmA4NAnMNn5BOSf
         LB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350561; x=1788955361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6Md0+LJRDnI+rQO3Uvm4S5xh/BVG8Mf7Z6azFky85k=;
        b=iODjcA+6VFvHcWszMUpJ64Zek2Ui+PO6Xi/gALye3YkHZ2LxsRe5vLGNH8Pg1m0Ffv
         Ep1aUIEFuDfvI8uIsVPpADnz9ikHWE0akLkeoTfcF9+EqWG0ZacQQy2Vv4v8rPVAFHwh
         8BipXikfiESimzw/o2SutIJJozyqPsNOEKy5xUrFpgB9Ox5lhPDOHxLw0riPKG/Ge5v2
         BkirI8Bkw+wtBaYQOWlAmcCoOmPIdzewRS6/hMt0hvPbKpxMLo3KCOBwwGHOu79Cz1KV
         KwddCruymDR6mnP/IQBPCIa0JKDivxQfbZv7vEIJ8V8ilfyd1DgEzp6sSlCRg65fJI0d
         z6GQ==
X-Gm-Message-State: AFuF++nQhWKLZQYwvjOefSlhVKCHsggzx1Z7WCdf2WE5lOg74DBAZg/f
	ampJJ/6H2NTGwSmQ0KMh6wmyouO91PX7j2G+TqvwYtxLHOyt4oQdrZw3
X-Gm-Gg: AYBFou0PNCPKc8UHKmvjvTwGBE/l0hkM8ymLp16Y7q8qQsUZ634JECtFRX9lbHMcjC2
	5g3ocvXbpUJPKaacVJn16B3s+lBgRiVVw967jN5yirRoL5l47tVk3/xv5WZ+och6SkKuebJCRZW
	/mhHthoEIrWXZErO0d29WYe75+w3WgjSVFWWbqoXxiTNR9INfI74gunikz5dwoR5E7FaCF/99EQ
	QYgkVFkGj+fCKoRvj3vYdCsr3TbKvoiQmmLojGEnQhq6ZrfSsMl8Gp6IFAHzeabvKGEvleEjZ/I
	I7ZXmg6z8kqqZJdSXax096T+C9DdXp68bNk+IKl4tWwdkfGIuGKWeu3G8+RyYis1yRv+RRrTaIo
	zdFwj5nqbQHlIQlWtGJGsaCtxUnTeglHf0MQ0iJ4fSmlgzZJfSO6qUaAp5xdWhn22j+Ltj8fuMj
	1a4lTlGRICSMf8kIboQc0eQdIiOT0rWLaYedpbovSnzSW8gdUrSPWS8jiF+vuQJbkwVvn++8c1/
	EyAzB029WY=
X-Received: by 2002:a17:90b:3c09:b0:398:c0a2:8f8e with SMTP id 98e67ed59e1d1-39af64f9205mr2885148a91.26.1788350560968;
        Wed, 02 Sep 2026 05:02:40 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c33e9sm6897044eec.4.2026.09.02.05.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:02:40 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: selftests: Verify sregs and events in sync_regs_test
Date: Wed,  2 Sep 2026 17:32:33 +0530
Message-ID: <20260902120235.18486-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sync_regs_test has never actually checked the sregs and events halves of
the kvm_run sync region.  compare_sregs() and compare_vcpu_events() have
had empty bodies since the test was written, so the checks run after
every KVM_RUN only ever compared the general purpose registers, and the
events half was never written to at all, hence the standing TODO in
set_and_verify_various().

Patch 1 fills in both comparison helpers.  Patch 2 exercises the events
half by masking NMIs through the sync region and verifying KVM applies
it.

To confirm the new checks catch something rather than merely passing,
the same faults were injected before and after the series on an AMD
host:

  fault injected                      before    after
  sregs.cr4 mismatch                  ignored   caught
  sregs.cs.dpl mismatch               ignored   caught
  events.interrupt.shadow mismatch    ignored   caught
  KVM_SYNC_X86_EVENTS left clean      n/a       caught

Every corruption goes unnoticed before the series and is reported after
it, e.g.

  x86/sync_regs_test.c:128: left->cr4 == right->cr4
  Register cr4 values did not match: 0x41221, 0x41220

Unmodified, the test passes 20/20 consecutive runs with the series
applied, each patch builds and passes on its own, and the remaining x86
selftests are unchanged either way (61 passed, 24 skipped, with
set_sregs_test failing identically before and after for unrelated
reasons).

Hemanth Selam (2):
  KVM: selftests: Actually compare sregs and events in sync_regs_test
  KVM: selftests: Verify the events half of the sync regs region

 .../selftests/kvm/x86/sync_regs_test.c        | 100 +++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

-- 
2.43.7

