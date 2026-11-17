Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950955;
	b=MZ+w6ECxrSHPZClvRG38OHC6OzKInnVHxytfK3XQ+NUHiNN7Osn2slv76McQnLPi3glK
	 94pRi4BmgPHsk1ITWSeYLLFBKKDgdGH8aT3tkm3NDWZwfyCZRyS9uY2A6QhJiqpr6HxXC
	 QsPqltr6e5h/nqM1VJhqys7YyvJD3D7j9JCyNQh7DfTUDc2rGjMk7nveMnIbvyTWJrt3R
	 tTV/t1TbqQrojS9sdDhGv+xNWUAjIT0S91w4iS69tmuiWlABTMU/9g+yNUw1hZxogK+LS
	 IOF4DABdhFYWILRWdnbWCI7CAehOXwR1R2EwWP5UUJd0Fdx3vHNZ4ebcaAYFTczQnCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LFhpg0qvm91vRWAPbsrCWKOjN9lF3/fXY1K7WMC+vR4=;
	b=gh8Ig217HF7r6hHjif4Xrf9bdamOu1QKQB6JzkVBAijiyAf8EjLfCoI1gYsMectyYyG4
	 bcaYNC+o8KV4f9p3I010buFC93IT3inaSwtgpgC3Hsu+dK8GjOKrvbDKMNXwKX6gK+Kwn
	 iQLCmUEDFbjoWRPQmlKYxycK0sH9FwM1QZjrbYyyOHv35YcnAhe0VGgD6Uee+S/Vgosab
	 JqFf97L4fO3G8Grtdowo4nkCw36mB2abt+QgWV9G5fdSULB8zigxvtEqMYYczT89VuKRf
	 Ule9xEXer/0XI4vPoevCB7d0KMb/rWSN99v7cpAlbk2UmjqRGRTZTwFCoAVmbAjk7Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJb3H3Yu;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493F606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E493F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJb3H3Yu
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed05b3eaecso1466165ad.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950954; x=1795555754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFhpg0qvm91vRWAPbsrCWKOjN9lF3/fXY1K7WMC+vR4=;
        b=pJb3H3YuyM/lsnXgiBiMxseOt4u9ax5PN2z0aKuqKAQEJAvEN1MEcj2KbSGRVQ/tGc
         SEVkIeF1JmPv1QXDC5ofkKGh97yeZJfco4OxKDLbvr80Gk3o52ua/F+Lq7AL1ufG1/+8
         CQlMRE0UFT+J35SWj2KH0962HFHBRV/CNBVL9w7Bhppyur1NweLaPZLHBVA4E6pOut+R
         rmXvYtm+zznu0fOjoS4S4yT3Ur5nJ/qJ7SgMWbSLutk7jkaGRpzF9CxNLdzb43UlFWmk
         8KCbazENhSrGImE8gX2Mg7cLLo2eDsq06JRY1DrBZunHdY6isNIhzAuY7Kt70QMErX3h
         suPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950954; x=1795555754;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFhpg0qvm91vRWAPbsrCWKOjN9lF3/fXY1K7WMC+vR4=;
        b=GDC6SMQDIDbR0UQz2psUVd8rDmMps0cI6Qn1KVgRlq50PYbkDbut1F6rYbtvatNgiK
         uVbidYUQMhiYXFrOkWVqlFinFY3yxrcqYcJE80D2LgM4bpyOz7k+8yL6smj4IuD7U4YT
         UNwljnfOSoHF8VEby90ppNtMzzA4LCBNf4V2QIocqlYKByUcjJoJI6Tw8TRs4Za8uz+L
         cUWFTQAjSgazY++awq+btGu02ROnu4cOiXuvN8y4DbWLPHQ+30Lz/qNPKOl4n5d+zmH/
         xqpoBuEzVkAl1ocA6xXG9iG0iGPvQACgntZVUK0tOS6vmqTGY4WRrFcJFSJM8UaW88Ic
         Z1Qw==
X-Forwarded-Encrypted: i=1; AL+hErHkklAfI3WtGnZtyJGfGlm7aduiPA/bFn06A1vT3f2mmXttI9dorAkfZQPZZFSs/m4RLVU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Qz+bEtS36AgyCUfanZN+bLq6am1BbjamNUF5UoJyY9vdzMfTd
	0DurDvJ9b1o98KIyGG8Mjw0r0riDtn/h5hfx6ZZ8rMVAdDExZ/kNULMiICHs7b/aDtq4xobUp2x
	OyRO4D3SPmramNIXp0YjC6Q==
X-Received: from plgk9.prod.google.com ([2002:a17:902:ce09:b0:2ef:de59:1afb])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d586:b0:2ef:ed25:5150 with SMTP id d9443c01a7336-2eff7402b30mr5584535ad.26.1794950954093;
 Tue, 17 Nov 2026 13:29:14 -0800 (PST)
Date: Tue, 17 Nov 2026 21:29:09 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117212913.3634487-1-jthoughton@google.com>
Subject: [PATCH 0/4] KVM: Don't let dirty ring resets pass dirty_index
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Fix a userspace-triggerable WARN in kvm_dirty_ring_push() reported by
syzbot [1], and tidy up the memory ordering and annotations around the
dirty ring indices while in the area.

Patch 1 is the fix. The dirty ring is mapped writable into userspace, so
userspace can set KVM_DIRTY_GFN_F_RESET on entries that KVM never pushed.
KVM_RESET_DIRTY_RINGS then advances reset_index past dirty_index, the u32
math in kvm_dirty_ring_used() underflows, and the next push hits
WARN_ON_ONCE(kvm_dirty_ring_full(ring)). Stop resetting entries once
reset_index catches up to dirty_index, and bump dirty_index before
publishing the DIRTY flag, so that a VMM that reaps the ring while the
vCPU is running never has a legitimately harvested entry skipped.

Patch 2 converts the DIRTY side of the flags handshake with userspace to
smp_store_release(), to match the acquire/release semantics already used
for the RESET side. No functional change intended.

Patch 3 is optional. It marks the remaining concurrent accesses to the
ring indices: WRITE_ONCE() for reset_index, which the vCPU reads with
READ_ONCE(), and READ_ONCE() for the reads of the other task's index in
the kvm_dirty_ring_push and kvm_dirty_ring_reset tracepoints. I'm not
aware of any KCSAN reports or miscompiles, so this mostly documents the
concurrency and ensures the compiler can't tear the accesses. Feel free
to drop it if that is appropriate.

Patch 4 adds a regression test for patch 1 to dirty_log_test. It fails
without patch 1 (KVM resets two entries it never pushed), and passes with
the series applied, including with a minimally sized ring so that the
vCPU repeatedly exits with KVM_EXIT_DIRTY_RING_FULL while the ring is
being reaped.

[1] https://lore.kernel.org/all/6afbad4d.f3cfa7c9.844a4.0002.GAE@google.com

James Houghton (4):
  KVM: Don't reset dirty ring entries that KVM hasn't pushed
  KVM: Use smp_store_release() to mark dirty ring entries as dirtied
  KVM: Annotate concurrent accesses to dirty ring indices
  KVM: selftests: Verify KVM doesn't reset unused dirty ring entries

 include/trace/events/kvm.h                   |  4 ++--
 tools/testing/selftests/kvm/dirty_log_test.c | 18 +++++++++++++++
 virt/kvm/dirty_ring.c                        | 23 +++++++++++++++-----
 3 files changed, 37 insertions(+), 8 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.56.1.708.g77570a6a1d-goog

