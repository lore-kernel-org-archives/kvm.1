Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C03BE635
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894755; cv=none; b=p5UhTJ1NyrosgQhAigq1QkFzac9j74QTKK1U3b5VURVMNwA+mWbBFRz3n6lqX2s6Ezrg2BBmDL7lzkADQOil5VMSHzHdaYocXoDYdTDCRMnSNKtBOoaPpksea3s7XD1wLNrqK4t9qG3jaqgp+AhfH4W/wvmVuj0kc+xUJI+unkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894755; c=relaxed/simple;
	bh=912snAcCTNqOWUD6SpdL0K01Hil6+eYbKui0bgbt/go=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=koe4UyCirV/Jq3TGRLWwrs8p0jS6DaGi+/ysluNu4U1aUg/k7MKnRcKMEEXc+gs3ZuB71G9gOQE5nQgAMTws7fe9LLgCKFychdM5SAKJLGDXVN6DS3ux/9wAtOPRunOsEzyo+IVIff3vlb1wH/R50GwiSIfz2VE1poMBi+GtU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+O0gznk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+O0gznk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f85179263so13427967b3a.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894754; x=1780499554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loqmIAZkS6j01OGafW7CG6LP/Z/yHpRC0pSxjAWH8I4=;
        b=a+O0gznkDs24eC3G6XyJOBHQCmWN3UwyJ6HTcQrfebhcjUmT95zpHe9vEXktaag4hS
         IyBGKMEaEeY5wPp7Fu9uAQzufGAQQcB0nEtUzu27W4b71Nn/nl3rCwpGMIFXFxH4/get
         xx5A4eRqq3WJ/8QeexedpAiDae2VY7YgYR6PwoIuovzgI05zetdbNW6TXBD1/D+8WZgd
         xJd5v0PX9dqphuf3uUm0B2osltmW9fUmSQUPNaM9h7xEzcZDSFWkWChRwPgpDZfsAK6O
         3gtrD/yZj5ZURXkhq/QEzePb+qOlgF+zmGaD+GtARUDnnyfVyiOX2VZaOK0WFdqZf6pB
         Lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894754; x=1780499554;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loqmIAZkS6j01OGafW7CG6LP/Z/yHpRC0pSxjAWH8I4=;
        b=AtoP5pNPJrgFoiN0dWUUK/WvVwl66ZJO5s4nuNuZAaso9Cl4OXvHS//bRCJXUyGQjO
         Wb0ZBBm9cWaNVzUim1NKijcVbLQyn5C4HFMnnctd+68CRGbtLfwkWa07uu8Z0KCL1c+q
         AdxDZEuk0ULaWksgMKFtYEhwmVuDVTjdDmYIe4XLmVpEkJaBHU/laE29Fcmkp0rThch6
         4/0LD3h7tXT3LQDqv7/wM09p3m+TICo0xTcfipjvceWJ4VatdVqdBHCWqFudf9m4ATwC
         bBA0t40snL6CHH8nH90LkS+URuFXPBkbP3JUkUyT4sD/k5FombNb8bhC7nus/Lj9Exnc
         02KA==
X-Gm-Message-State: AOJu0YzhvvOnUJDqSNK0ccNdTPAVEOlZXDBA2Fnbd+z3vduinhF+7OHm
	05jWUyKDCFsFjVFzlFZe5OeKbcTVkAdNlMjwn4I5KrC7AxFg+fQza4C/pQN5R7qF32rTw6QLx9e
	LuUt/bw==
X-Received: from pfblb9.prod.google.com ([2002:a05:6a00:4f09:b0:837:7965:c70c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:39a6:b0:82c:e83d:a9b0
 with SMTP id d2e1a72fcca58-8415f552ce6mr22328525b3a.21.1779894753673; Wed, 27
 May 2026 08:12:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 08:12:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527151232.4058615-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 0/2]  nVMX: Improve DEBUGCTL test coverage
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Current nested debugctls test focuses on DR7 value and fakes the result of
IA32_DEBUGCTLMSR in comment. Although the test can pass because DR7 is the
only criterion to determine the result, there are some error messages
appearing in dmesg due to accessing to BTF | LBR bits in IA32_DEBUGCTLMSR
with report_ignored_msrs KVM parameter enabled.

Clean up the old test so that it focuses on DR7, then add a separate test for
DEBUGCTLMSR bits that are actually supported and can be validated during VMX
transitions.

v3:
 - Massage changelog in patch 1.  [Xiaoyao]
 - Combine all DEBUGCTL tests into one testcase. [Sean]
 - Validate all supported combinations. [Sean]
 - Independently validate LOAD/SAVE controls. [Sean]
 - Drop unnecessary configuration entry. [Sean]

v2:
 - Modify the commit message in patch 1 (Xiaoyao)
 - Add dedicated tests (for BUS_LOCK_DETECT and LBR) covering the DEBUGCTL
   reads and writes during VMX transitions (Sean)
 - Add one additional test for RTM_DEBUG bit that was not mentioned in v1.

v1: https://lore.kernel.org/kvm/20250811063035.12626-1-chenyi.qiang@intel.com


Chenyi Qiang (2):
  nVMX: Remove the IA32_DEBUGCTLMSR access in debugctls test
  x86/vmx: (Re)Add a nVMX test to validate load/save of DEBUGCTL

 lib/x86/msr.h   |   2 +
 x86/vmx_tests.c | 196 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 166 insertions(+), 32 deletions(-)


base-commit: 05b7715ffd4ae4ef8f0a5dea869f1543d89f936d
-- 
2.54.0.823.g6e5bcc1fc9-goog

