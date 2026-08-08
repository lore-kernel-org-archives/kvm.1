Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCC3A3E68
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176675; cv=none; b=ZN1XRX2b5BhhjdpwN/o/R4FNFKCA1391aj5hpO/1zBvqisjfRy+p6yWl1F80sGFKaBeook3Kgovs1OSC2GPfcgTrPKBaSZJne+bA5gYFILxAYcc4wfTjZNt0r+cggQg7ysl6j2GZFte2TvsEX4jeoaSot1tZvfKTCUdC8bOqL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176675; c=relaxed/simple;
	bh=lrC44I8iM/31bF4d4aI5ZoY4vfzbALhpHlYJjauf8dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdOHzt4DfS6ReDY2UyWUSajxy5n1pUXsSqPFgl/cLvJ7tNWlWRee1IbJ6je+PbmzkQGYJ01nbmGtUUGRdrqOam5SdRFZY9orKiSZ0GFu1bCNI7r0MXhRiiHViGBAxUHuZRLpgtvVuAbPAc88D+GtUbEogpqlsHYw/Yr9l36wpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTBw2R30; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTBw2R30"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb85186d43so107089a12.3
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176673; x=1786781473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wux81zj1Lg+H9qFJc6k3PJIeFmxAFwN6X2fCIKjgs3Q=;
        b=BTBw2R30csVw3GOoGpvRoEGzCEaaKUwTfG3930kwuMxABiZg0TxbiJnM6qTe9IJ2al
         Dog/pOsMhbJL+13DEHCgTfIIbMcKshUSeYUCDWQi0aWRGEAAYTRgAMPwuPhkOXvQJO2A
         cJlJukzY+/+gMhAl7H06JuVpzwwveRLJIwJKo44ZfjmF3PSadApJzqFffgu/RqrQhZdg
         pVzfQC/V22Yl9ztdPwKZ1i1D4Tq5uKE9B6xkSGBd6HJgTdWQgrOffYjBBqBzdewKqlzr
         BQymPEufd4r7BbQ23Ee/5u915IDZOFxz5XJoCB2ax8x5Vc0ArZ62Gtck+a8nfieRHXoB
         x9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176673; x=1786781473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wux81zj1Lg+H9qFJc6k3PJIeFmxAFwN6X2fCIKjgs3Q=;
        b=oGXKJTdvF/twZCPw2CmjNJLddJRXZBRJrU3AJ4VvoyMhQDsftpfpcDFZLGKYq/vMjd
         O8PiYJJR4TVAWGDCzoPFcz2UMtkOf8GM66ZBaWaj5JL1rFgxkswrTiVu6oG2q1069Ju4
         DcANgsG5wVmgg0Zti7RsxCLy8NEXrBb61CfmmX9txK7ifFC6bbyBU5cJrxpK15cAgwTx
         UBphqq+D/BlAyMi6uBl/7xOeIih7U/ZtyI7oqFlBFVbKWu26VEMdu8TIx89RXwKNSVex
         v3rFvDzyUCh9Ex+17AsXPdx8LN5ks9A/5KdZgUl+nyC60IFo1lwziyRkNjmf5IsKiupC
         lX0w==
X-Forwarded-Encrypted: i=1; AHgh+RqYaT7jjsHiHLZkZYw2V0sl8YLh4a7DVDK/6q7mv0M3hMfUzhcH9fxb9GQJwva0MZN6RVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzILdIMpAOWT2WIbjp9ISYc3/US4/gxdnx7UG/uxU8N4QMxnn0
	dXbviqbhHOF6uqGD705cL7IxCEG2GD/V3Y9R8CXpJJ0mRMpKh3Gumltt
X-Gm-Gg: AR+sD107hoSvtBIDzmOSQsu1+x6kGdZtU50K21ejyHIst8ulWgMWe42iZmzUmx3dHu1
	14HTyLevvEFqSqu90Hlt2pN6XCTc6V8kToU2fltGsPl42ZyqYQQqkt9JoN6gGvYloc3zMw7F4TW
	qH62XOUp2osCsySkeuPAQ2w2bLhdAjQk/5EuDASamiLXt/yLRU3ffHWxbp5OY0BVvABKV1YCnxH
	9trVlj6DB5Eu05GySzCnSVd/AdQNzolFF9clX/kw+U8vMggLKxurX6sT9vYhQu7J9pXzV2SHAE/
	UUjvHUY/3TDMoVaoysImYw509wAcI7PIUAiyQATzuq8HtkeS+6oOOTeqFIPEIjZUMN6i1eJp+6i
	sYN2nFB+gkPzVhd3+xRNLHG1SYyR9e7hfFEpRzvx7jNyWPuMFk4w+ulyslSeVqdJngunVYHZ2+a
	yeEuho0AGpiDoTw75GhicnDwshcP4G0pYnIgQO116B36lgoQgJAhWDBpXXqGAzOOTkEDxEAQF5M
	Q==
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3cbce8d4439mr6418307637.17.1786176673027;
        Sat, 08 Aug 2026 01:11:13 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a754dsm15208279eec.11.2026.08.08.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:11:12 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: selftests: Fix two VMs leaked on early returns
Date: Sat,  8 Aug 2026 13:40:48 +0530
Message-ID: <20260808081050.408657-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two x86 selftests create a VM and then take an early return that skips the
kvm_vm_free() at the end of the function.

Patch 1 is the plain-SEV path of sev_smoke_test(), which returns straight
out of the UCALL_DONE case instead of leaving the loop.  The SEV-ES path
next to it breaks out and frees correctly.

Patch 2 is nx_huge_pages_test, which returns as soon as it has confirmed
that disabling NX huge pages is denied without CAP_SYS_BOOT.  This one is
not an unusual error path: nx_huge_pages_test.sh runs the test without
CAP_SYS_BOOT for any non-root user, so a normal run always takes it.

Neither leak causes a failure today, since the process exits shortly
afterwards.  They do mean those paths never exercise VM teardown.

The two patches are independent and either can be applied on its own.

Found by auditing every function under tools/testing/selftests/kvm/ that
creates a VM and later calls kvm_vm_free(), looking for returns in
between.  Seven other hits were false positives, mostly returns after
REPORT_GUEST_ASSERT() or TEST_FAIL(), which abort the process and make
the return unreachable.  Two more that do look real, in get-reg-list.c
and arm64/external_aborts.c, are left out here because they belong to
different maintainers.

Compile-tested only.  This host has neither SEV (kvm_amd sev=N) nor
hugetlb configured, so both tests SKIP rather than run.

Note patch 1 touches sev_smoke_test.c, which an unrelated patch I sent
earlier also touches [1].  They modify different functions, do not
conflict, and neither depends on the other.

[1] https://lore.kernel.org/all/20260807071026.195503-1-gokul02k@gmail.com/

Gokul K (2):
  KVM: selftests: Free the VM when the SEV smoke test's guest completes
  KVM: selftests: Free the VM when NX hugepage disabling is denied

 tools/testing/selftests/kvm/x86/nx_huge_pages_test.c | 1 +
 tools/testing/selftests/kvm/x86/sev_smoke_test.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.54.0


