Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092F3822AF
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348013; cv=none; b=cZALL5wr4lqMn7ayF960qWknfNmF4zDZLehX4rqtVQQJk9j14jRCRfunIxHMH+oEXcfCKjKLc1NJPVcNuRIsgIugKgdvNpb/nKxcDPiuzpD1yh12+YikrbTOg1SPpYdpCzy7c7V72g9ICarKIGviWFGuAbLP/gvQpadcz2A3DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348013; c=relaxed/simple;
	bh=TsuYSz6pEIEctSN8Q4FmKCsZROFr+5acWRANGFQ+RLg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HIHaKwaFz693LBTCXmnfZ+9S342W98q1wkMvoGKlMp6Aj8bYK4XbF7/gBIv3cEn/kIdWOWjHYusskcFCmaC9p+R+e9jNNIXi4Ui92VY+pc2t1gXZPxIckUtJD/OUFiQteKHaiTj3qipRB+ZRPtkl3t1fPjAX2VwDInMaysJU0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npGc9J11; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npGc9J11"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso8509041a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773348011; x=1773952811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DKKEP5sIOR3S89k67T/rXOR5JoDEnckL1GIVHkyjafg=;
        b=npGc9J11RjTg5NBH/ZLcKj+tY8heF0g/7T9k8XYHnkoK0I1213iguJRvdBUKijNiE4
         AQIbZs2h1qNllxOrDBA1ienPm3bOYiHdWbKvbS//mO9IuchLFgzvI7L0UDyl57HGbCyj
         yX8+dzdX1PzfPi3Bflwp3u4lFZWZiFh8EQnvggyRYTzwkShbVEd4Np3AAYUIgts1PzGx
         lQRuRZkbgZPZ7okmf5nC8tNrHLjJg/mpXQxoV+W1s9lUAqy/RCexl3zmPnybrtufh+me
         8z6/sPeNXyqAXBP3V+0S5vEhlxplXZFMIv8uyNHZN3rBsbRGjoh0f26cBkVMfODlOvjJ
         JU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348011; x=1773952811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKKEP5sIOR3S89k67T/rXOR5JoDEnckL1GIVHkyjafg=;
        b=i61rFgNHQzbwbHYQGCeaH3kWBIYrW7Gc+ckyEtza4uQBYYeKfxP+yuM/tvmir/b3Iw
         GxdmN5MC9WhjpeVhYLZR+yFurAc1SS4RxI1lld74nwX5FGc1w3HmueCU8V6y+Z8YT/ir
         rAXvsbazrJHEgFVETIAKeuzaS/p15skdiE70Cgq7P226ivCeT0uFtJmg3BlvYSuO0EnH
         IR/KA/pqhoakjg9Mk/TIDqDd3jMdXRzDhZApmbfwcn/cJrS/WupwtOlNy1caBKG+qcE2
         NuiILSCf+gOG9Xiqcm25UOgSBiibmm4f5jPqiVLw/C80kyVBzfWaq8n4UPub1RAc9Str
         oAJA==
X-Gm-Message-State: AOJu0YzU61aFz+Q219GSCjIFB2ytsqcbp8ukFRBIIHQN/dreafhQjEjD
	UsTJOUkEFNuDsFzMK1eLWyfKMWr7zQDlyeudaqfTVeqlsWkYBFJCVo0AS3nu13UJzrR35FW3hxi
	6hbJGKsNmsNhkJD6Z1CaBrUbR6BSWjDM7FKwLynOZmbZ33z1SSrrKIzapnOvhRXuZ1tSYKP1e6w
	9DZbfnUUwCPLR9r8HoSyHk0bmgAJFd2CugTQo3vqxEj4I=
X-Received: from pjsk2.prod.google.com ([2002:a17:90a:62c2:b0:359:806a:d01d])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4b:b0:359:f22:8879 with SMTP id 98e67ed59e1d1-35a21fdd36fmr717578a91.22.1773348011031;
 Thu, 12 Mar 2026 13:40:11 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:40:07 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312204009.3168871-1-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v4 0/2] x86/svm: Add testing for L1 intercept bug
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

If a feature is not advertised to L1, L1 intercepts for instructions
controlled by this feature should be ignored. Currently, the added test
fails due to a bug in nested vm exit handling where vmcb12 intercepts
are checked before vmcb02 intercepts, causing the #UD exception to never
be injected into L2 if the L1 intercept is set. This is fixed in [0]

The first patch just adds the missing intercepts needed for testing and
restructures the vmcb_control_area struct to make adding the missing
intercepts less ugly. The second patch adds the test which disables all
relevant features that have available instruction intercepts, and checks
that the #UD exception is correctly delivered despite the L1 intercept
being set.

[0] https://lore.kernel.org/all/20251205070630.4013452-1-chengkev@google.com/

v3 -> v4:
  - Fixed incorrect intercept handling introduced by the svm intercept
    refactoring in TEST_BITMAP_ADDR
  - Switched to using vmcb_save_intercepts() in handle_exception_in_l1
  - Fixed incorrect reference to saved_intercept instead of
    saved_intercepts in test_msrpm_iopm_bitmap_addrs

v3: https://lore.kernel.org/all/20251224014324.1307211-1-chengkev@google.com/

v2 -> v3:
  - Added assertions to unsupported instructions test to verify that CPU
    does not support features enabling tested instructions [Yosry Ahmed]
  - Added some comments [Yosry Ahmed]
  - Changed insn_invpcid() into assembly [Yosry Ahmed]
  - Added a check to the unsupported instruction test to ensure that
    L1's vmcb is not modified by KVM [Yosry Ahmed]
  - Redacted reviewed-by tag for 2nd patch in series. I mistakingly
    added that

v2: https://lore.kernel.org/all/20251215210026.2422155-1-chengkev@google.com/

v1 -> v2:
  - Added save/restore helpers for all intercepts as suggested by Yosry
  - Reuse invpcid_safe() for added test as suggested by Yosry
  - Include '-skinit' in unittests.cfg for added test target as pointed
    out by Yosry

v1: https://lore.kernel.org/all/20251205081448.4062096-1-chengkev@google.com/

Kevin Cheng (2):
  x86/svm: Add missing svm intercepts
  x86/svm: Add unsupported instruction intercept test

 lib/x86/processor.h |   1 +
 x86/svm.c           |  18 +++-
 x86/svm.h           |  89 +++++++++++++++--
 x86/svm_tests.c     | 229 +++++++++++++++++++++++++++++++-------------
 x86/unittests.cfg   |  11 ++-
 5 files changed, 266 insertions(+), 82 deletions(-)

--
2.53.0.851.ga537e3e6e9-goog

