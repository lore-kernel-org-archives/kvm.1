Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620B531625
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178682; cv=none; b=BdhtD3T2xje3mTbAgnNSoMtzsyaLr9cFRz83vA+kCDhPzjeX1moJ7iZYtW6r2WhxFHwPL5C93voEc57cW8xkl7/jx1fBb6vly7tIr5IdFjVus0B+lzWyfefwKR/TImKhwMeoynjyaQaV1ppvix0tmeCLbnBo/PBCUbcsckFlKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178682; c=relaxed/simple;
	bh=rO6mF9C1/9+cpGzYv8g9ZVAJGUoWGKMEqjgarRG1Aa0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sLb/D9un2aBSb/Wpc4rBd5e/6ry2IoCdNuUFDUxdZo/zyEtWOsNyDhrzg4bztHep2Z8wh5CwG0t2mFTjE9Ut0gCCjwvX41k33lyrSrvqIfAQbssPZ2xEouSei0mKr0SEijHM+qDd4JZe6wNgQdqPf54YDHfqhHmfLm3x6xRN7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WB7+PcEP; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WB7+PcEP"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1171230a12.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790178670; x=1790783470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3luqRKcCingagn8NYFaqWEw14KPOvu6+rw5gV+maomE=;
        b=WB7+PcEPjHKHDiLuIpjswpcvYCHKjun1YdQYx80GulmnGkPqBjptUEKvN3uLnEv3K5
         AYv+yuG7gFD1jyQZ7Wx8cCGCsyoPtmEp2eyfhZ5X1tLdA/Ie53FhwFVab7d6ZGPWB2+y
         a7BU481W0YLry8s8sLF3Bw8qJNCDBSJ7ulv5Dj+4x5a13sgD7a4GcOtZevnqxJcl5RG2
         Am56AoaNGuEcWhT2FF54+C0XOTGXFEa4fytnX0+umbe5lsj6tEnsevbRtovjpDB4mz2H
         2bKLPOVpZIyCh17HnjoVKBs9+Zvnn5adYKiYHF+2OIr6A+EocEbXILFLUpYkZWEmTo88
         yQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178670; x=1790783470;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3luqRKcCingagn8NYFaqWEw14KPOvu6+rw5gV+maomE=;
        b=1qQQUYjBr1T/wKIhCz4GQNuYfsS3Y0l1k5OI1ZMoQQnU3ItOd2ceQoqEhxpIrxnd+o
         eRe1ecKZpxavFA7GDE94hxXNpD14xiAANhnniQOU0XJ3RBY9fKAb7vXiDoHq6hZISgxR
         Zug3eY2XZKlpU6xt2EFA2bU1JLeU3VykZoaN9oP5C2CvYcYxPBEgaJyYKvIP6+rxx4xC
         I7GMZK081JlifJligsxERA6ABmvRM4DjQf1FKwbR/ClzYMWiqGRYuPV1ugN9+uUyGgX9
         vux/5WsfIunsEFVrNNkOXJYw3jgaJrLssUC2Cl+LQdstSaDJ5OSpQMruvbBCXNvbI1+f
         aktg==
X-Gm-Message-State: AFuF++kXeJLmhZ3TT0SVNpFtRmPFgbYATZJdseQP/nH5kh7CmCZMZs6L
	fquel1wMa+3aab9Lwq3/98zFc6fVczGcrMsdHjbggjP1oVnANWPcsZzOC+x6yXR/dXTg4fq21Ak
	aemjz/w==
X-Received: from pgdf25.prod.google.com ([2002:a05:6a02:5159:b0:cc7:5367:5720])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1d:b0:3da:755f:a031
 with SMTP id adf61e73a8af0-3ddf7cfbfdbmr2722797637.12.1790178670395; Wed, 23
 Sep 2026 08:51:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 08:51:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923155108.1550622-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: SVM: Fix AVIC Physical ID table UAF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="UTF-8"

Naveen's fix to clear AVIC Physical ID table entries if vCPU creation fails,
to ensure the CPU doesn't access the freed virtual  APIC state.

v2: Add prep patches to consolidate the table bounds checks.

v1: https://lore.kernel.org/all/20260903062856.2090499-1-naveen@kernel.org

Naveen N Rao (1):
  KVM: SVM: Clear AVIC Physical ID table entry if vCPU creation fails

Sean Christopherson (2):
  KVM: SVM: Add paranoid helper for checking if vCPU is AVIC-addressable
  KVM: SVM: Use "is AVIC-addressable" helper to sanity check
    load()/put()

 arch/x86/kvm/svm/avic.c | 22 ++++++++++++++++------
 arch/x86/kvm/svm/svm.c  |  6 +++++-
 arch/x86/kvm/svm/svm.h  |  1 +
 3 files changed, 22 insertions(+), 7 deletions(-)


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.55.0.1082.g2b9226bbc0-goog

