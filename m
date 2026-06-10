Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE183A9002
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107809; cv=none; b=IVptMqysVY8toJc/KiAOirCcXg+J+y68D4MhylE593rXVHrQPv4nFa4o6eqYg/1moRZLSAinDGYvrUdbpFZGBCQ54crr1jGvO04s9Wif8Tji0VpSVNsi2NLoYrTryXg6KE4cPSBM/n81S6k3h4uUz8dS4Cso7udw0J7NgMDCwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107809; c=relaxed/simple;
	bh=QLJVtIXslM8Vym65F8mkb33975dLsxKF+90zXBMtylk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XlO+wMxYhHLqaLHipFR8KpJVPEFWRWz+r9nSjKGwfrRdstzpTHHaAvl5EUuzmqDcyzE8C0GitADpB6X/ZN5lozkof8J1fAgUK0oKnudEt7UxuadoBxnGLW/vHk4Jx8+YD9MGJUooSPVb2+du/gjmqmBAHUBbyqsRzIKFjB6BAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq/8g9TX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq/8g9TX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so59217725ad.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107807; x=1781712607; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvSxukOaST3b70rKizF+QnL0BR7efntMvFYlvZOuTc4=;
        b=dq/8g9TX/UCD5ba5jj9LJtHKOi0iuLrrvfM1m4ImY/reuOfFi/5wA+d3rHt+Vk1ywC
         Q/t2crOY/JoVhU7dHDwTf6abkqKHQhDtmo5d3ftpiXmVOHrg/CUlcEwFTMfUbMXFj8aA
         MgDJyz6n6LmOwNfmCGKTQ6pqKb9EvbP9Jltt/EsgnbTAuXrtopt5DV4iqcRrm1hi68h2
         fG66oyY4UVAEzPGFqLvDURDHIQhImrlcJSYC9Y988mdqV5aRsUjugTaRiTRD+0QG4rrY
         ZUGtnNyj57N7dbYPnlulEveLFUANGgdzbBMOcx3dh9fnm3ZU68U7IYcKlbCnZIkedP0+
         LGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107807; x=1781712607;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvSxukOaST3b70rKizF+QnL0BR7efntMvFYlvZOuTc4=;
        b=LCM5BnSGe1/5UElr+UI1IMiVc8ZBA1s3ARAwiO9jrwpQ13d/laeMiuShMnPSJq03FM
         cgYfcKlNqOOkpE6MzdnVdJMj5kWaqNJiowiWLC0RWXXxVYZStQ3xxG2rDCXfq69BMXeQ
         soXvzTzNVAIrHOKfarPLKtUzyisCPfcjGc0LTHrLkCWPhf3GP6zZq6VfCoc9s5xclEOr
         XGYbIemwENhkYjA6b0PZjFZlGTGJWx/Pac/DLJTl8Z2jYITHd+GNvc6r3evUdW6md6dG
         JQJJoCNOpXXGJfWWxO4Yd3BiKIhILUZYCiaADYAtcKak6D73HV3p5LvGT6fMiSiH3ho+
         siyg==
X-Gm-Message-State: AOJu0Yzk/NjEJB3ACMb5LGY9VDdBTc5A9WzPUmoyVzvsSrx3bgQ+n0CA
	FnkTQg+DYX0UCjdS3OLkKkgcL9s2ZXzuOdUjKk46UHTtRLoeclVq6DaC
X-Gm-Gg: Acq92OEBkoqT4PAtQr+xUuP2iT8lRLhPIoNxY0+MnmeqLd0HmF+WzF82YnMOVthBtcY
	41P+VrxDxiFfgTZvea5LrkNj1V2OA18xaby1FjwPHMiFxRUwzGw0X2Uxz6xJq7RkFiwjNNT2r76
	D5DsRnqoU5pe1kgJOtj6wHsi4RcxO8W1DsK2o1IxXlgYg8Sgkm4KWUmD5tvAeJFLfjhYUos3x92
	N//3IKUBc6xZn1+WP/q7tPSG+P4mTRsGO46cAeryjqx0UalE/q1YjUWHD+uoZqZ7tsSTK+5k+Mf
	8Dcs57w+Op2jAjkeVFW45hD1x+DyvDCrbNMVHrOu0Zzz/kNdMvVIgUrwEBarrjgSdECiZfREFy3
	XnVIecrD8WS8J9YWjLptRK0L2E39kpG8JibIkPt+9HAn53dtDFrVEkkxQAJ4Fd0WBUTjL3x5gOR
	LwvmUS8DKj4PPuWaXVodo661kGchMpuXcSBQTVGAODMbgCrFZKMbiLVQ==
X-Received: by 2002:a17:902:e5d2:b0:2c0:c625:4019 with SMTP id d9443c01a7336-2c1e810bd13mr311368435ad.25.1781107807224;
        Wed, 10 Jun 2026 09:10:07 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8bc5asm263260545ad.27.2026.06.10.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:10:06 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:10:03 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, michael.roth@amd.com
Cc: kvm@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
Message-ID: <aimMWzAf5b3luM0b@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sev_gmem_invalidate() is called when guest_memfd frees a gmem page.
For each PFN that is still assigned to the guest in the RMP table, it
transitions the page back to hypervisor-owned via rmp_make_shared()
before the page is returned to the host.

A guest-assigned page can reach this path while still private,
because the free path does not transition it beforehand and
sev_gmem_invalidate() is the only place that does. A gmem page used
as a vCPU's VMSA after SEV-SNP AP creation is one such case. When
rmp_make_shared() fails, the RMP entry remains guest-owned and the
host cannot use the page because of RMP protection, so it must not be
returned to the host. The existing code only issues WARN_ONCE() and
continues to the next PFN, returning the page to the host allocator.

Leak the page instead of freeing it, as kvm_rmp_make_shared(),
snp_page_reclaim() and sev_free_vcpu() already do when a transition
back to shared fails. snp_leak_pages() does not take a reference of
its own, and on this path the page is freed right after the hook
returns, so take a reference with folio_get() first to keep the page
from being freed.

Fixes: 8eb01900b018 ("KVM: SEV: Implement gmem hook for invalidating private pages")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..8fee6ec529f9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 
 		rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
 		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
-			      pfn, rc))
+			      pfn, rc)) {
+			/* Still assigned to the guest; pin and leak rather than freeing. */
+			folio_get(page_folio(pfn_to_page(pfn)));
+			snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
 			goto next_pfn;
+		}
 
 		/*
 		 * SEV-ES avoids host/guest cache coherency issues through
-- 
2.43.0

