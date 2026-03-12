Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215522C032C
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345793; cv=none; b=N+1VXta6sqaQOygbGYtCMhRejo4xtaEwF2Yv7ZYyZevc9h2fph/Xlst7JzzIEqB5SFdo7xkk6BP2UlpJ5ATwi7KiKwCypBSvoUcFxtoJuKHVneKbAyNApm74N/IicDTfnl0r57ntTl3YG3LK/K8aaZWw7VkjM+QZMPDwjvU0ZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345793; c=relaxed/simple;
	bh=2OpDC+mXdkpbCDsMDsM5rwxej15IxzuqIchzwPpBeF8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ttL81NKP6fNKsY9U2u8ZqEKBMoMfu8vOKE8aET1YEB4nTCxbMIUtIIWKgjhKz8E7H/dyPJwbZhfEYmzJVNYHGsOF+CYNw0FCWal5ziRUGGTsK0nkm2Qvi4t1AIPj6rQ/qPFb+4s7euKAafr0mr3EYht/+fgcAJWiWo9AxC9hRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKuTvflY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKuTvflY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1048080a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345791; x=1773950591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f2tpqh8W4AgI1qCRbOlsij+2dustqzP+K9sIaoFo4co=;
        b=vKuTvflYefB94vzp0kT9HQ0ZSb+2OAHw0a4Eb4S9LPA0w8/fp+kqt5w0ELgQTmxW5C
         Ng2/3TQqJ+IBwFAr2d8pWVgSE81M4hvOnuYb9Me3sfwX/Rrk/sPRFEWEyZhILNo3GRNe
         31dbTuN0v6AuLT157fIkvIqyM4Ba4lYUI0HM9FkPnkwdcqyP1NW7w208mrTkaFrFWu1s
         /FBaT7QCS5FPzLdjMupyvNguY9E3VEDD/lALkm6qBbNovczqQvzMaonXUQ4masNctIt4
         UZx4XRqz7KdgU/wPv79MZtVDvW50zf8Tu6xU/lr9/pJt0fzuLWJFjg6a94E45QN8/CxA
         GxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345791; x=1773950591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2tpqh8W4AgI1qCRbOlsij+2dustqzP+K9sIaoFo4co=;
        b=gKbKOzp6NM71ISdv/hd1sz2/i05k1ckecAxGCAfw/WGGf0016Hsd1GS+JpKWqkPSpa
         LJ0OBJuL+M0CI/1gMQTztrQOPixguwzukvx2w9d9ndCku2CjRB3COgME/U++VESo5M2L
         /xOT0p2qJ9+QYwlGiOAW9JijolxvPrYC74V0OezVJ+cWmFRO2TxQMlWdwq7KgAYzVS3j
         YiOovWelqsT9HyaaOlO5ixHaymmxSVsDhU4HhFzni0Y1rsKb7d8IFhX/ShDdPHZvMVGm
         dUkl5PkoNmDgohFzVuAt94LGCyfrBhhr5O10q++TTRq98qXeh2MxXfFcIaeQFHmDQjgu
         U5iw==
X-Gm-Message-State: AOJu0Ywp8Usl+sWAhEH+W2U4bj7Z0Qyi8t/A3pXBzaWyxnHjCgry2QUL
	uygTAldfkwxsSXSAl3RRaJVdRe7aWJGF8yoPxQ31ifMlUXfHJFZALfqqodoQkER9u2DhPMI6GtF
	O7sJTsg6aC5orZnYRMhpHURNgUxFD8ruH70iRlmB/xMdDVpn5/Bf2tj6FFPTQg3caVzbxW6KEg+
	B02Fdoc7MW9s1Wii8okGui7pImLQaJmO/y13Jxzlbd5hk=
X-Received: from pfef11.prod.google.com ([2002:a05:6a00:228b:b0:829:92aa:a656])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8896:0:b0:827:2b00:4b21 with SMTP id d2e1a72fcca58-82a19928c63mr486458b3a.66.1773345791050;
 Thu, 12 Mar 2026 13:03:11 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:02:58 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-1-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 00/10] Improve test parity between SVM and VMX
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces numerous tests for features that VMX testing
covers but current SVM testing lacks.

I went through all VMX tests and identified which ones could have an
equivalent test written for SVM.

This series also includes some canonicalization and consistency check
tests as defined by the AMD APM.

v2 -> v3:
  - Open code assembly instructions in svm_ud_test as per Sean.
  - Removed unnecessary separate config for svm_ud_test as per Sean.

v2: https://lore.kernel.org/all/20260113003153.3344500-1-chengkev@google.com/

v1 -> v2:
  - Renamed check_npt_ad_pte() to found_bad_npt_ad().
  - Renamed test_event_injection() to svm_event_injection() and removed
    the test from the svm suite to run separately.
  - For the svm_event_injection test, injecting the CP vector now relies
    on shadow stack capabilities as suggested by Yosry.
  - Added a new test for verifying that certain instructions generate a
    #UD when EFER.SVME=0. This is a regression test in response to a fix
    that is currently under review [1]

[1] https://lore.kernel.org/all/20260112174535.3132800-5-chengkev@google.com/

v1: https://lore.kernel.org/all/20251219225908.334766-1-chengkev@google.com/

Kevin Cheng (10):
  x86/svm: Fix virq_inject SVM test failure
  x86/nSVM: Add test for NPT A/D bits
  x86/svm: Add tests for APIC passthrough
  x86/nSVM: Add tests for instruction interrupts
  x86/svm: Add tests for PF exception testing
  x86/svm: Extend NPT test coverage for different page table levels
  x86/svm: Add NPT ignored bits test
  x86/svm: Add testing for NPT permissions on guest page tables
  x86/svm: Add event injection check tests
  x86/svm: Add test for #UD when EFER.SVME=0

 lib/x86/processor.h |  11 +
 lib/x86/vm.c        |   2 +-
 lib/x86/vm.h        |   2 +
 x86/Makefile.common |   2 +
 x86/access.c        |   7 -
 x86/access.h        |  11 +
 x86/svm.c           |  16 +-
 x86/svm.h           |   9 +
 x86/svm_npt.c       | 801 ++++++++++++++++++++++++++++++++++++++++----
 x86/svm_tests.c     | 664 ++++++++++++++++++++++++++++++++----
 x86/unittests.cfg   |  54 ++-
 x86/vmx_tests.c     |   5 -
 12 files changed, 1440 insertions(+), 144 deletions(-)

--
2.53.0.851.ga537e3e6e9-goog

