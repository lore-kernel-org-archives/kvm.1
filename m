Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C34F5E0
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789140; cv=none; b=P6RHZ3Ll4kJXKc2WAynBQmkkx2+vPq8LutBWUW2lCHdolalP595M06ei2HlmJwSAxlGg2q5NeFiBckd7RnxZDOcIo1eKc81JdMyP7pH9vzSkz2/CybH0u/3e80YP/ncnsLskxqGA5s5sbtYb93eSwX5PYlt8L5dMGJSjCzrjV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789140; c=relaxed/simple;
	bh=nSTMLjn5w/ExAOZAGYmBjdMdpVmX5syObkz4gAW+SX4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tIVBEF2l7x+AFG1cRZ/qdncLPhvCi8ZiuD2XH7Giqzt+YI3mtPwuy+CIF4MZymMPWVX8zzaz5ouQHpL7wQfbJ8rESACgqxkZ2VJY7Re928L7wXbZBE9pPDl+3Ru6GLwDJQwt+1FmHY0ShLKDfTdT4ie4uKNqTHUfgryX4wQrXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhcMnRdw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhcMnRdw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso89951245ad.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778789138; x=1779393938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnOWOPmMOcExgSuzG8g04K7x7BdipDqPDZEIZqoSB90=;
        b=FhcMnRdwXhzQycSK7hP0HXKR+JPZA5U9P1G+SlaN+IXkvtuxTnbyZ4P1Eiu/Q9lOXX
         wKOB9guQkVdnEnkSOeYMz5T7ftpYF7n9k3KmiRjv0tm3BsjA0xI7/o2fr8PnI/cCgp47
         +GA80m+tLGYcEYI5PajZ1mojNRSMIDyWYSQRoiiN8xLBqiTkT2lyFUMKS9uRbxH3gaKF
         DONArTidgIZsExTcFzk6X19O6oxlX5R7+DK2EjX04GY5LLM8z8PAb5iMXGwJeqkRmip4
         1SIF2TknVH0lkB4qQiZGoq/y44pNeMQKt2/WqpuSXXBjjLRsrRNmqzLb7axTA6XJftpw
         xJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789138; x=1779393938;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnOWOPmMOcExgSuzG8g04K7x7BdipDqPDZEIZqoSB90=;
        b=e+l2Mzd5aO8SNUx35XJM3VKX7tfVLYtGYlqtBxBUrA78wq6PEZZMJG7Vs5CxQykBBl
         eZMY2GIrU/Wi9ZsH9g3MJ16Aw7zriIid8xqWrc4hUwSebLzl/BqnhQFcViRFIshaliFS
         RlQ7bMVGeHQ02T+WfU6PSrs3wuPaGEYvR/6nArYZrVyOoYwDBA7rHYGWA15UzBHbuufy
         h7FoGgxG7obOZ356OEoOVZzaepax3uch5a8zTUfikEmrsa7mzeAjJaOC9o1pkIIUdDWK
         pfZ/fZF7lVZQAJT8gxh4mABrWQBBPr4l7STe9WmfczPSqfUqsucY7rd7oSgIZNYJVBXQ
         dDMQ==
X-Gm-Message-State: AOJu0Yz1DySw+epWXeHFS1OxwgoBayc9yoELMT1T0uaKPXxoi2ESUhoU
	EmLqrANK7q4rWJer3VGZ3T2MItLDsOo98Ohaxvlm7b5cfhJdfDVApkv1mfwL6OXe4vVkLLuBTV/
	C7UGbmQ==
X-Received: from plpj8.prod.google.com ([2002:a17:903:3d88:b0:2bc:db01:db42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:13c8:b0:2bd:8395:feca
 with SMTP id d9443c01a7336-2bd839605e4mr2203475ad.23.1778789138174; Thu, 14
 May 2026 13:05:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 13:05:36 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514200536.1603737-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Run the vmx_pf_{vpid/no_vpid/invvpid}_test VMX tests with -pku, i.e. with
Protection Keys disabled in the (v)CPU model, to reduce the number of
testcases by an order of magnitude, which in turn reduces the runtime by
roughly the same factor.  As is, even the 240 seconds timeout is
insufficient, e.g. each test can take upwards of 300 seconds when run on
Skylake-era hardware with a debug kernel.

Simply disable PKU in the config as the purpose of the VMX #PF tests is
primarily to validate #PF routing (to L1 vs. L0), and secondarily to
validate alternative TLB flushing mechanisms, e.g. INVVPID.  The only
novelty provided by PKU with respect to those goals is an additional
flag in the #PF error code, and the odds of KVM botching _only the PKU
flag when routing #PFs is very low.

Disable PKU in the config, e.g. instead of passing a param from the test,
so that the test can be run with PKU enabled simply by tweaking the QEMU
command line, e.g. without recompiling.

Reported-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/unittests.cfg | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 48835eba..f1ae3caa 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -426,7 +426,11 @@ groups = vmx nested_exception
 [vmx_pf_exception_test_fep]
 file = vmx.flat
 test_args = "vmx_pf_exception_forced_emulation_test"
-qemu_params = -cpu max,+vmx
+# Disable Protection Keys for the VMX #PF tests that require KVM to emulate one
+# or more instructions per testcase, as PKU increases the number of testcases
+# by an order of magnitude, and testing PKU for these specific tests isn't all
+# that interesting.
+qemu_params = -cpu max,+vmx,-pku
 arch = x86_64
 groups = vmx nested_exception nodefault
 timeout = 240
@@ -434,7 +438,7 @@ timeout = 240
 [vmx_pf_vpid_test]
 file = vmx.flat
 test_args = "vmx_pf_vpid_test"
-qemu_params = -cpu max,+vmx
+qemu_params = -cpu max,+vmx,-pku
 arch = x86_64
 groups = vmx nested_exception nodefault
 timeout = 240
@@ -442,7 +446,7 @@ timeout = 240
 [vmx_pf_invvpid_test]
 file = vmx.flat
 test_args = "vmx_pf_invvpid_test"
-qemu_params = -cpu max,+vmx
+qemu_params = -cpu max,+vmx,-pku
 arch = x86_64
 groups = vmx nested_exception nodefault
 timeout = 240
@@ -450,7 +454,7 @@ timeout = 240
 [vmx_pf_no_vpid_test]
 file = vmx.flat
 test_args = "vmx_pf_no_vpid_test"
-qemu_params = -cpu max,+vmx
+qemu_params = -cpu max,+vmx,-pku
 arch = x86_64
 groups = vmx nested_exception nodefault
 timeout = 240

base-commit: 4d60e2429d63dc0c24990114a8afc89e86c187cc
-- 
2.54.0.563.g4f69b47b94-goog

