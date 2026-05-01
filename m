Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F52367DF
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667743; cv=none; b=BPomISxeSONxjyzFBXXP5WZb3oB9UPQxU73he9vWh7g8CQTt/sUNcIR2Fe3+IJaBrdPKFjVC/gt79MwMiDlnANMzunRci3COAOrIi+agiL7Q0T8IOtTg1v+r2X+sg2sJiRUZt0mMyMAjwOCMfNgHcrdppnctPPmxcL23YOa5Tgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667743; c=relaxed/simple;
	bh=ShDrWoz7mOaJbO/fe9YryxY5OnKnA1570r4jAcpBljY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hih8b7lBJ4w1WSbqC2jiJn8+OQubc1eZmlgBwb8psuRA04z5gdEFQygAu9KYd6yvial/LoJNit7fec08BTO6F16AKqUjvdBcASITc/pZqh9guCwh48Yx0MaqdAFB+aQsvE5tBD96tIghWQx7vZZyZ1pGT1TCpi2ApNQ/KZVoiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GT97b7HE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GT97b7HE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so2960627b3a.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667741; x=1778272541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9uZznzsA8koMaIsMZF8pjffelkGGnvGQ9vat9X1p7Y=;
        b=GT97b7HEfPV5qJqpPoZ4Z72AewhnLpwOGeyEJJNl4zhcdl26YAgxUge/pSogTzxzC8
         y1Yvx/G7EQPoJ1V1RFfWp+DOHEV2EfQNXZZZ7MU7njW47KjsQemcDOIo0B2j2ZcPFzhU
         b8Gx/4A0zp4I2DSN1yZN5s8LHkudxXihQH6EfBphnde4LGOVoXr5fR903vg3TE1h+IJL
         dz+Vp0cFOhgyfujkVy4LOeZ+ZRUfaSzRyK/0UvatENaoEHEKmxLn+iw6ZmhKcj9099AU
         uZ7FFbY1uZQIZxGcDY5bdF+YMhUoQ3VqpW/Nz1jfJoPx3/DdUh4KcokiVxh6rfQH3OnI
         8HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667741; x=1778272541;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9uZznzsA8koMaIsMZF8pjffelkGGnvGQ9vat9X1p7Y=;
        b=QUt/ze1Xdr2FkiOr144C5p3LG0sV6KQNazKTiHn7A/86Tsz3ZZBbbB8Gu5uKhPva2Y
         Mba09qMDIm+gvWLZBundTWm75MF1DwchauDDMjuA8ob+afNtweqNUd/8K4hQhiJe12gO
         gdiEIe8cjZgxtfzODoDUdvgJirCc1PRFVT9iODw3Gf66gWi8C+L7BXjvZM9YsMGQ6qvp
         op+90tYJjpl6+MiSLPFA1TIjULPxSrG+G7ckcUkcpj1P/TXDviurK1FzJ1xK8BqmCX43
         0F/OoiSLDna56kIE+31zblHRiEEsQK6TJXJ22F4RPx3Bav58rFK8q0HKIkshSktRdOL5
         Mpqg==
X-Gm-Message-State: AOJu0YzMTeWrAeW+9g3rUrWqwRDbckOLvBy9G5gb1nDdV1pdi5Qb7H0G
	II4R5kxpIrIzPUdFKCqj1aGAxQn5ru9ALq5nyGe33ouRC+rmyD0vAGLy5JshlaBRgXKu2AuAbpO
	Blb8yOw==
X-Received: from pfmu6.prod.google.com ([2002:aa7:8386:0:b0:82f:96ee:b9ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1405:b0:82c:20ba:1570
 with SMTP id d2e1a72fcca58-8352d28c184mr636547b3a.29.1777667741078; Fri, 01
 May 2026 13:35:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:31 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: SEV: sev_dbg_crypt() fix and overhaul
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Disclaimer: I could have sworn I sent this last week, but obviously did not,
and I can't remember _why_ I didn't send it.  So don't be too surprised if
there's some glaring flaw or boneheaded mistake.

Ashutosh's fix for a heap OOB/UAF bug in the debug {de,en}crypt code, now
with a selftest to detect the bug (and confirm the fix), and to validate the
functionality.

The rest of the patches completely rewrite the code.  When creating the
selftest, I did the silly thing of testing arbitrary offsets+sizes, and
couldn't trigger the true badness because the test failed long before it got
to the larger sizes.

Specifically (or, at least) the current code fails to handle cases where an
address and the size aren't naturally aligned.  E.g. when encrypting 9 bytes
at offset 8, KVM needs to _decrypt_ destination[31:0] into a temporary buffer,
buffer[31:0], then copy 9 bytes from source[8:0] to buffer[16:8], then encrypt
buffer[31:0] back into destination[31:0].  The current code only ever copies
16 bytes, and bizarrely uses a temporary buffer for the source as well.

A wholesale rewrite in a single patch isn't my first choice, but the existing
code obviously hasn't been tested, and it's so bizarre and unnecessarily
complex that I've zero confidence that an iterative cleanup would be a net
positive, especially given how many hours it would take.

The initial fix is 7.1 material, the rest (including the selftest, because it
won't pass), can wait for 7.2.

v1: https://lore.kernel.org/all/20260410050854.2463447-1-ashutoshdesai993@gmail.com

Ashutosh Desai (1):
  KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Sean Christopherson (5):
  KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
  KVM: SEV: Explicitly validate the dst buffer for debug operations
  KVM: SEV: Add helper function to pin/unpin a single page
  KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
  KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers

 arch/x86/kvm/svm/sev.c                        | 423 +++++++++---------
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/sev.h |  24 +
 .../testing/selftests/kvm/x86/sev_dbg_test.c  | 118 +++++
 4 files changed, 347 insertions(+), 219 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c


base-commit: 39f1c201b93f4ff71631bac72cff6eb155f976a4
-- 
2.54.0.545.g6539524ca2-goog

