Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9C1F7575
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424441; cv=none; b=EdOM8BqomJLwQ+/hiGsdCq2xAhySWQBh7RkiCX58I1soZtt2Ofp/x997dsZgJixb6zdYL7X7VJ4AicbX3HR7oL3ehYFHwnePccnq815lGK2wntm5V56PWIUwKwMntEOKfcw9O7jvAO4wrYjaAT0ksFkmJnYcerRkK86cLksR4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424441; c=relaxed/simple;
	bh=96uq6DR7meULD6e0vhzPQPh15pvpeq+zRFpv9E5X/6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHLDXVn4W2Yk6e7yP0Ed1R6bjZQcZ22TwucIuosgyYp9OErH47mUZ0+L7BTEfXLVwgK65+kXB0wcEOp8rLQheklqc+Rq+W6lNyAet/3DHrIt0ekyZlZniClqirZfpz/Vk79JKT2tZN49tROx8SFLViIppUvaq/yikO3qqArHudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYHzDPko; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYHzDPko"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce98cb8165so6502135ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424439; x=1787029239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBt9KUApkZajktq9wAzF4z4ZyRD+OJ573CFHiv7VWA0=;
        b=iYHzDPkoHjgPlLHZDfmYvwom/bPp6Cn9Omlpl5zozv6+d7k1ftI/naWS+sMJnJ+VP0
         p/VFswwjVZxl5mGCZ7efIdvdrknGyC04MbXnRVFxribHxXTh1DAw668piiDPsYPfGzli
         sWSPfEmQdTZE0THikrA+sQ8+0bCUaCjzmJ0XkH3tOj2eaDekijprW33piUYKKr+JXCND
         VUTgayFwzkQRCN1ocvnJAo2StqPOytDqOGko6LWvoaJPFbAevjDYUEUkaxeCa2HWOHFL
         VbpdNdkiggQjK+PeHy+/Y7EuVvN+E+NSaRurB/lM7w6iA5kGoxKwr3PbUvy+1Ajcj2Nt
         9ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424439; x=1787029239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBt9KUApkZajktq9wAzF4z4ZyRD+OJ573CFHiv7VWA0=;
        b=kI2y6nIVEfoBj2kXfExb2ETci8pzjRaUtNrFr9wsYHIUT8U9IAPbqdmzE+rEbIIrei
         hZ1vvFx9H06Yp1JcELxrZObraMkS7ew2yEBdu2Uw3/ACiGSEQXe7Bfe2wGtQQuJl5zPP
         tJuuqqtbd6pBaY7rBFzIINKhV5g7bpta33HvDE8BW+sXEPpVwXeL6Ybgho3dKPq89XKw
         yo7qf2WImHwxcSplpuMdyDKCq7bmTnEXD+QuNqW3ZHwrTUyARzKXO8lJzozIrXkduJHM
         FWkLntx8d0CyB874skVkNeWSDFclCjkd5C3ANmKbJMwPgWiB1Ms+FYHoKH7QJo2b4cEF
         QYPA==
X-Forwarded-Encrypted: i=1; AHgh+RpfFubHU6ZQ+yX5i67syizcTjna3Eah2ltVD+NpNkApaS6PnqmESzRptL7OQWqgDlrnpEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLF971rI4qg1QTNIjOBuxAzOZXq99hHpEq3Q4PqOrrIfVL9qM
	ybEkhJ0M9mG+xS5a8770V932Fq82t6gdLzUNifBcAFI972jXyiLdLp16Z93sMNbn
X-Gm-Gg: AR+sD13f9993fSWsDGmPXxlEwy3FwPgfsMyp1VMfZ2NJGnJphbc87ZFth+Sa+K/3icL
	crHYL1hL+IJ0qDPzdg1UYs67QX+tVxu0IzIoeaCi7rDj4lf6xT+iZtX03Ua582WsiNWqUju4HA8
	V0kg9PvoiOvcdPh+MUMpRGYeZvKRTOovt7IGZunzONNrXhwhB+BlaH5hr++BCLI8/YIDUg363gz
	1pVenCRnQ/2pQPgCkf/NI92p0dz7m9+dLzbsyb3NorDFCgi5gDvF4VzEzeSY4ViF8SvJouERGWN
	KIRfiPQEm6NmAzxxTHic0OaTqDMWWB/JYNz5LMmjBs8lNBS+0byysqwL3oZYBe6hAxw85hI90WB
	QQssKXb+9WQ2XV4qLaOAdbFFYlpwCI78u53tk0kl4tQjby2AG3kLf4JM35mFWuEKfUTtqsgVg/7
	/V8a9AiFbEx2PG9ZKAm6/K/XPHKtKbceQXS3oWKJ0EuJ/rKH/m6CKt82Kzkb//ZYhz/y93rbZuH
	bQ=
X-Received: by 2002:a17:902:f64c:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d3187e903bmr5964185ad.7.1786424438583;
        Mon, 10 Aug 2026 22:00:38 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c64e10011sm535444eec.28.2026.08.10.22.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:00:37 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: selftests: Fix two VMs leaked on early returns
Date: Tue, 11 Aug 2026 10:30:27 +0530
Message-ID: <20260811050029.530698-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two x86 selftests create a VM and then take an early return that skips the
kvm_vm_free() at the end of the function.  Both now jump to that existing
cleanup instead.

Patch 1 is the plain-SEV path of sev_smoke_test(), which returns straight
out of the UCALL_DONE case instead of leaving the loop.  The SEV-ES path
next to it breaks out and frees correctly.

Patch 2 is nx_huge_pages_test, which returns as soon as it has confirmed
that disabling NX huge pages is denied without CAP_SYS_BOOT.

The two patches are independent and either can be applied on its own.

Found by auditing every function under tools/testing/selftests/kvm/ that
creates a VM and later calls kvm_vm_free(), looking for returns in
between.  Seven other hits were false positives, mostly returns after
REPORT_GUEST_ASSERT() or TEST_FAIL(), which abort the process and make the
return unreachable.  Two more that do look real, in get-reg-list.c and
arm64/external_aborts.c, are left out because they belong to different
maintainers.

Compile-tested only.  This host has neither SEV (kvm_amd sev=N) nor hugetlb
configured, so both tests SKIP rather than run.

Note patch 1 touches sev_smoke_test.c, which an unrelated patch I sent
earlier also touches [1].  They modify different functions and do not
conflict in either order.

v2:
 - nx_huge_pages_test: goto the existing cleanup instead of open-coding
   kvm_vm_free() before the return, matching patch 1 (Sean)
 - Drop the claims that these paths never exercise VM teardown, and that
   the nx_huge_pages path is not obscure.  Neither justification holds
   up: teardown still happens, just at process exit, and how often a
   leaking path runs does not change whether it should be fixed (Sean)
 - Rebase onto current kvm-x86/next

[1] https://lore.kernel.org/all/20260807071026.195503-1-gokul02k@gmail.com/
v1: https://lore.kernel.org/all/20260808081050.408657-1-gokul02k@gmail.com/

Gokul K (2):
  KVM: selftests: Free the VM when the SEV smoke test's guest completes
  KVM: selftests: Free the VM when NX hugepage disabling is denied

 tools/testing/selftests/kvm/x86/nx_huge_pages_test.c | 3 ++-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.54.0


