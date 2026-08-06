Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D7385D8E
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035966; cv=none; b=j7G5EeUSF9JRT3LT0dAExWYtLoWubzRBT2L3/Z3wlWvipI0WJt7mC5SbFoTKykKWnrXM+qjB67e4ywkKcR4G/Z9t8+aqucNOo7brC64EMJI8CglzUW+lN/5weDovzu7j2/w/SRWqzKgkYV041e9LU3HBGbUcOcgFnqBJLRBOc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035966; c=relaxed/simple;
	bh=7hC2BmI9wwlaYj0orRNJAkywV+VFEWJZ6Zow/Tak82E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QbGxiNyDVkfkxsh7YTTXWvLW+IS4Pvl5sEfXm5Qs+SdjLbGPQDRbeLol5msoDVSygL0sZBjXZy8dV+mhDGa4+8a1acNQShGfpyRU3gM1kwYm9HpvSbKF7ihNR4z7HFHfQC45UzHLPxJDpuK0pdwf8aiPADXIdIgY3dhiAWUqVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B48ZNrR9; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B48ZNrR9"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484f26852dso2791704b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786035965; x=1786640765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jb4ZuFXYXCOb6UVyWGOFPQpZO16jEZntljGCX+SwX4=;
        b=B48ZNrR9yYSIbWk0T4BPXKsNBQcHwBaejZmvv7/0a522UxqmiuLmSGf4nYeJpzq3Tu
         tSVA4kDheuETyWH9R3Ydf+iHDrRQ7LEO25dwawS1crWlsJV++/Ot2gcUsTGbuQSHcLAw
         FDfyKmIeYRx0VlalEZbFFAvCd2f3ZsiYrbYrh3HBvLCOcQYJnD+MZ50AISF2mkz31naz
         GJDM5Bmb6gjAomQ94IDe27KXgAkMWzB385uupqCpCi5td5MuFHEL4feKzt5kup8kDUmh
         jkvF4DO/4Gi57Oe0gjbtutyQo5F13zIwAuSqR0h6kePJtNJ76yGppr9zT1U0jUX7rxgd
         DccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035965; x=1786640765;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jb4ZuFXYXCOb6UVyWGOFPQpZO16jEZntljGCX+SwX4=;
        b=CjDqJGxD3iZ/SCaPpZcFBG72JFVTcGjiQGYWqcpS4OMY1D20YS9PYSRf8GEwbCg87c
         UU1vcz9tEh3/hDeuFKdftZUL5VMHgo6LdH2GSwa9tTKsNeLSYIV/ll+GGuo9ZIVqce04
         DlJIjHGy4E4H33U5PPrYHN1NN8AJxfLCvkIESHBGj5jc/7NzHa2tuzNAMnSc1ZUv5V6W
         VFqibHjw3HGvNgCwg4E7RxroV8r1OK3A+XfW1Jn71dkfBZGhcmAahSwudXg0K5bKsd/1
         RJeKe58wV0UnKSq5Fu0KH5/WrLKlowiHmZkdm3BD5CD5OZZ2zS3Y4zli1wwAbOVou6MK
         LctA==
X-Gm-Message-State: AOJu0YxgVlpan6FDkwZqAvld03i2hT0yl8hplu7y/pYSP4PXcSA1fHE/
	5lLk4zwUnvbyFcUUWIlnRd8tBlAJR2PIVthFS/WH0A4HW3VOyS3obAuAeGxeqQBAfFGKD9FvC/6
	czXiADA==
X-Received: from pfbdc5.prod.google.com ([2002:a05:6a00:35c5:b0:845:e386:e036])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8018:b0:845:45b5:9825
 with SMTP id d2e1a72fcca58-84f4fee2e43mr3502894b3a.37.1786035964578; Thu, 06
 Aug 2026 10:06:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 10:06:00 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806170602.4112602-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: TDX: INIT_MEM_REGION fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I completely lost track of this, meant to post these patches weeks ago.
Compile tested only.

v2:
 - Fix an off-by-one bug.
 - Use gpa_t instead of raw u64.
 - Tweak the order of checks to bundle similar checks together, and to perform
   the super basic checks (alignment, size, etc.) first.

v1: https://lore.kernel.org/all/ak0skG064rhKUC8d@google.com

Haotian Jiang (1):
  KVM: TDX: Reject INIT_MEM_REGION if number of bytes would overflow a
    u64

Sean Christopherson (1):
  KVM: TDX: Fix a benign off-by-one bug on the end GPA for
    INIT_MEM_REGION

 arch/x86/kvm/vmx/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
-- 
2.55.0.679.g6767b8d81c-goog

