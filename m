Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7925DB0D
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727703; cv=none; b=mtoteetvGnGNn3NpSQwhMqKHvcY6ANPxLiiaG9TWTlgZCD3dVYRbZD4l9hUTVeLIe/mJ97KQTKtLUJd1EivCW9WH+xHLU2wo1eFfqC1XPi6zO4MayoDPWFrFqAk3wnC90ZEmS3gWU3JU22eheIm7JPz48E9ERyibmsRxR/WKNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727703; c=relaxed/simple;
	bh=OagveM/W6LfZWuRscEmjyJr+E18dnGlC36iBiLWROL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P3Lriz8v2dsfHS1gnKVJQWJiVQn28mzIh0oD2enuxVIoiDnc8INFUJTES2fWoEtfuOcgCNXtE11PyacNEuw2UDDrpasBDc6tKHbn3qr+Eoz/UnItqkdmyzDAPGSYV11ZrOEOaKhMU5mD5UVe/T3IwoVcJklgE9JvtzcM5fE1DIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihvigAmt; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihvigAmt"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d55d8cd938so74241545ad.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727702; x=1791332502; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwL/o5XM+JpBzX0u1GI0Q4//KknXm6NLO9rIpXPH8Zg=;
        b=ihvigAmtTVNnn3XUsZ0Oc/43v21tAAsHcDHOh4DRNNY36EBO4XX72doW4Mk99KXFgG
         Hwpih+WC95eRxvrbhJszlhgP+U/Su7GNpYR0EBZmoVqqOrC0u7ipzsHgOCds+Ljb1aI4
         rip2Hf11SonN7UPbIe9VmTmskloSeNNMWmpuatZWgQgE/dVUNeY/SfIoP9ZRAjRfeB1O
         DTgj41CMufysDw+XAVcaF2aXWjT2Sh9uTGKFRqjooEUMn7vvqcqBWVBX57IXgojoEwP5
         sYjB4n4mDH2Py9GEmX/3hSKQzuU6j9Gg00Z/nBB3DftWaoZ3YsH/gVb8dnwKLHsn6DKS
         1CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727702; x=1791332502;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AwL/o5XM+JpBzX0u1GI0Q4//KknXm6NLO9rIpXPH8Zg=;
        b=o0baTNoKf5xS6bAAdyv6lMpEdnL6oYeJMbHa+KE9LvQbq86JPf6bzY443encJseNsk
         k6/mSigz83/23K7txKc8JheHOB9SclqPHIauyu0HPcnzhRqe8IHIEmcQMO5zDuVc8fNp
         pYcJkuaN/cQF+hLanocU/8B/Pv4Wcy9Bybp916iCoUwUViBXdPjFGMIaeh/CBkPPLIDT
         Ns6XRGuYfOp1WDirwwFqsbnEUUJBttefOf9XKP/EyPo3PxoZtjeG9BWHQ9dDP01Wc98i
         yeJr/JbGe0TfEmVCe+/3e8Pf1pRuiY2NqEhzxBd6uHRBIXZFFqD0nP5A0czfW9r5OHsx
         Ph5Q==
X-Gm-Message-State: AFq9FYK/5Fq1xE0EArSv2G9aAoZxWKe8kGD9w0nBJQl8RhNxcmMXves2
	O5jbOBqNvKy93md4P1PYPNmqwezu33vfOEoAD1eZbO900tnDzmQyZJ+p5Vhtm0JqOZ69ez3HQVA
	mmdFFww==
X-Received: from plbjj8.prod.google.com ([2002:a17:903:488:b0:2dd:b898:adf9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db07:b0:2df:b488:ce8a
 with SMTP id d9443c01a7336-2e2de4ffaebmr5685505ad.11.1790727701776; Tue, 29
 Sep 2026 17:21:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:21:35 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930002140.3174449-1-seanjc@google.com>
Subject: [PATCH v3 0/5] KVM: x86: Honor EFER_LMSLE_MBZ
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Jim's series to try to clean up the EFER.LMSLE_MBZ mess (and what a mess it is).
I didn't touch the KVM patches, and barely touched the selftests, i.e. Jim's
testing from v2 should still hold.

v3: Slot in a patch to add kvm_is_nested_virtualization_enabled() instead of
    open coding the check and relying on the X86_FEATURE_SVM cheak to make
    sure it's kvm_amd.ko under the hood (the patch is constructed so that it
    will trigger a noisy conflict with the in-flight 
    host_cpu_is_intel_compatible).

v2: https://lore.kernel.org/all/cover.1790208413.git.jmattson@google.com

v1: https://lore.kernel.org/all/20260918154530.4129698-1-jmattson@google.com


Jim Mattson (4):
  KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
  KVM: x86: Honor the guest's EFER_LMSLE_MBZ
  KVM: selftests: Rename svm_nested_clear_efer_svme to
    svm_nested_efer_test
  KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature

Sean Christopherson (1):
  KVM: selftests: Add module param API to check if nested virtualization
    is enabled

 Documentation/virt/kvm/api.rst                |  25 ++
 arch/x86/kvm/cpuid.c                          |  20 ++
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/svm/svm.c                        |  21 +-
 arch/x86/kvm/vmx/vmx.c                        |   7 +
 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 .../selftests/kvm/include/x86/processor.h     |  32 ++-
 .../kvm/x86/svm_nested_clear_efer_svme.c      |  50 ----
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 266 ++++++++++++++++++
 10 files changed, 386 insertions(+), 58 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_efer_test.c


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

