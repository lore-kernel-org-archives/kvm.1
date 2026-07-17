Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21493E8C55
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329557; cv=none; b=CRZbha8BH38ZvyqDrvbQTCDORp7Ihbe3yJD2at/BNrzGIlryBg/BJ9hjlOk3+hADRelRGSkTgA+kyJzAkEAwv80OyH2HicK3tDnUYejJzjm68pJ3bbXIuuErWp92ywWTbFoVgZH1ar0LeDxT01ry/af+/NVC2BFZR1G7wFubA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329557; c=relaxed/simple;
	bh=Q6s5oWeziQbUdIR9mUG8hB5uGd9x4H1hQjSaBJCG6to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PiuaEqVxdVXxSFrBcBv3l+2fZKL9dqxV59UAX3fpPt3E7wPFI5glidhtehapMQ9j9mzyeEL7I4ndsvRuygcRaNSvY7RKyLWfucCR72/lnbzG/f7XAHsADo6BtNJbM3XmN5UdPhWAR/0iS3azDKx5XeFFGugxhfWXlxNRo0ToxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snYR0hNG; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snYR0hNG"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccbb61893fso175704905ad.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784329555; x=1784934355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/34FkR594BC+at52XqD18M2KRa+CuoEQnzCF2deRFEI=;
        b=snYR0hNG6JC0MfhbretsIJQMb1RrRv9SLqi41mTcxqcRlYjfLQIcFS6tgJVUSU4/+s
         m9S4eT9hMB9fxRz+aJvOsR2eMyWsZOQItpzjfmafQ8qDyIxy5dUe+ddZD2B4tOxv6RPa
         f4wV5P3BBxczXXTjdkMixCRp9z3EGi3IFtabCGG4XrUiZioQHU1hBz2JBt6pHRVTvjRa
         cmWrsUoL5rRtytkfK8wnf2ObD5f+9k8ZxwCGH+I+CTPd1EqboPE7MW9VCK4ENhgs60rW
         6W8sNaOBrYhz4sVbkkh/RJj0KkhWMCw0O/5D9oi9t4XIt41HSLcirt2tzfRxh9GAZHa9
         7Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329555; x=1784934355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/34FkR594BC+at52XqD18M2KRa+CuoEQnzCF2deRFEI=;
        b=RU8MVy6aibpHECslBBRU7BiO6GdYYh+/Y33sVETtPq/gbwhzVqkWetEJAMuZ4u/RVE
         3unmJEtY/gHSLNLqyDEvdgqhIVOQdERZnYpApUAHOnTD+j6TfACdB+StOzM2GOX5jd2I
         ctvQB56Wh5SpnMByPu7JRb5QHQcZLHDvRAaWWxHYAJfnfiU5xY0snGfCNHJED/qYuN9w
         6fr0NhBzf//hAQ6hyMNECEapDEFP0O7fkW1fs+I0D8PpsPwFJJs9Vz9hgx1QLNzhMgfc
         xV0UlLd+GgaH7gjX8MfPIK5A76esJoHMbZkf+DE1nslmGKCspMtWMvPnLrMQgVCsIVw7
         tkhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Av9uHlrHKS49JtlBkDi6bazMe2K7+mdweLHzajNja2KjAbQWtJYogX5NUwz8UkXlSKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5TkWpNhv6OEWm0h5o7MkPmLvjPjL9CcrOYNhEZJW2++K0Gou
	1qr2UU0VSEr4ln4PxOQOSb6PV7/J4guOp2UqLEbmPt4WkKFVVnMdObBnj1YQFuJuOWLWFjL9Ez3
	ZelaC/LJv42abGA==
X-Received: from plrx15.prod.google.com ([2002:a17:902:b40f:b0:2ca:c162:e758])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c6:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2cf3481b70emr52410205ad.3.1784329554700;
 Fri, 17 Jul 2026 16:05:54 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:05:42 -0700
In-Reply-To: <20260717230542.3555587-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717230542.3555587-4-jmattson@google.com>
Subject: [PATCH v2 3/3] KVM: x86: Flush guest TLB on MTRR MSR writes
From: Jim Mattson <jmattson@google.com>
To: jmattson@google.com
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"

Per both the AMD APM and the Intel SDM, writing to an MTRR with WRMSR is an
implicit TLB invalidation that invalidates all TLB entries (including
global entries). [The APM uses the word, "update," which could be construed
to mean "modify," but it is unclear.]

Previously, kvm_mtrr_set_msr() stored the updated MTRR state without
requesting a TLB flush. This broke x86 architectural compliance by leaving
existing TLB entries in hardware. Additionally, on AMD CPUs supporting
ERAPS, omitting the TLB flush request meant VCPU_REG_ERAPS was never
dirtied on MTRR writes, leaving the Return Address Predictor (RAP/RSB)
uncleared.

Issue a KVM_REQ_TLB_FLUSH_GUEST request on every MTRR MSR write to match
x86 architectural semantics.

Fixes: 9ba075a664df ("KVM: MTRR support")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/mtrr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 6f74e2b27c1e..ca5e5c7f7022 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -105,6 +105,7 @@ int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 		return 1;
 
 	*mtrr = data;
+	kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	return 0;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

