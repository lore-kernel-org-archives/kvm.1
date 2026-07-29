Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67E26461F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367541; cv=none; b=Lf+DvR0UwVKXPkLAb0PiAk3Sz2MaFkkFqOQJukvDR9vrPaB9QVNvO//5yZ4X+ixSzrDzGv5wYOXtmFBsf3e9xbhJ0Q2HeIJQspjtoSWpByJXWdxwm6jxyisUXWyITj3yB+g6tnzb7uKJu5aeu8ejts2RuKoMpKkcRUwv7ZOvUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367541; c=relaxed/simple;
	bh=7DX2gBUzCNs6EGCIoWHrpEfISSCt8nH3WloI3CogZBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmzvvrU9jQHQPQpBACsLv5UKmLgExtzleh4Ub+5SahwasiK0JEO0VMRF45hjHsV98v5HPi+bFIa9d/Ne10cbD4PYV4aAwfeaFDCtSXMd8zX8NomZ3dTHoRxsdU3V2AeJbNdl802GN/YSLiUPg63W9dkFPiCn9mYDvjYso3XBlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY2ScpOI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY2ScpOI"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2262318b3a.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367539; x=1785972339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=agAohdyMJ39twgA5Lt/CMvRouMD+rLJEs3qNM/Tk904=;
        b=dY2ScpOIRLmfctWZFYcCa1+O4DHQ5uETAhMcyEAoj2RbVjDRTCcAnWC2TX0KcUA0ng
         ergODUHBvoJfIswoOuEESw358lb8xshBXkYEKbsfMcYHNWWxj0Fy/xrJJjwzjuMfGsZ8
         xJYY18ysbgPBgHRWPy5RKYv+s0ZAgGlPnTC0v0Vf9YUn4lRsFPIFizmhkBUXTjq1U0Bu
         JaY/N4f2ttAKjeedtYA33r3+YG6FJ1JeyZ7H3OouF/XtSaEvz28LU2sCJwoojVudTkXY
         MvllswgC47ujR8cT93nGEeT1HNpT4EPji7wPGsgpaEWr6FbTHUykyHf9vTB6aSqJIX53
         Xmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367539; x=1785972339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agAohdyMJ39twgA5Lt/CMvRouMD+rLJEs3qNM/Tk904=;
        b=qzgfeVddyp0BJa8CFhxQHTrspe4gV5grcFQ6LquhWyVuwYmjeJVq1UVR2WOtiIcyJb
         PU1O8BlwO4MFv+MhRbGof9YfmI8Gi+jvImdSlxnVZHtVdXnpGmzoihBpI4n8jE1DrxaM
         czGuGvrJDQ5CW+Ho0/iyHdl8Kow+BviP3b9DdVrc6J40P9uyz2SPAKYtKF3jw6oSuoEx
         +TWJKPBJL/4uMnmQaGlN/kKRRfExNbixVRQ7hxRSb0cmnEqo5qNKRVpxWngco5oHJyqz
         8br0boqls6E8NR5DMCy2lYbf+RoYbXZdM0vYKCEjDrE3gaIuFUOBYHSfDFXUQrCsz/Xc
         5Dag==
X-Forwarded-Encrypted: i=1; AHgh+RqchyhjScozmAWIChigONStBYebKFHaOXp3s5lUyFSsxMQSs2YeA9Z6anFwdYLAITGzBO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/AzHa8RJb5BUbO/1VqhhOcRtEIIj3Xck6iyDCz3bO3sGRAnB
	0FKtUG1LyaGpljZ9UUh0daAGz1Ri7LSzdKE1xt0C9D2HdNM8pFg+phhS
X-Gm-Gg: AR+sD11fELPlRTjlyNV189arMHJNfbYmBv4jECO31FcBSQi1utdozwR8iBKj2SOcObE
	xh3vp9bhmhhn3N5FLz3Z+sfODJ3bNiouyz5x1RdxTN6g3TZXPBqUhbP4MWO5hkiWSvR6k8TULNa
	cAAePuacl0w+lDYP4SJUojZlnlNfe1ciNldie5imTMIj4RHJ4FzOkR/ZuEJiDJ8cXHJ5srd2+Xq
	XfLImPUkn51xlj98MkMcpTMoXZ+BzLxwPf8XebHzGdHvFY9U1IBAor7bqZGF8YujiB6z91XWWo9
	cvpaDEGHxC5h458bozvvLPdcgD0UhmHurzkfGgZi6YJFKyzVqhpp0OC0IDyBjrKTHPp3OedIzvc
	hjh9Fpg4RvUBS/N+5JZB4bY/3cUGFYeWdlovkvP1YMB7v9eb3FuXylfTIBvN/qqpjCWbp0i1fyB
	KTkkO5wyEtMTV6niC7Rhn4c9ruHxO40Xhz8Xg3hm101j/68c2zCQwAUlNCEsw=
X-Received: by 2002:a05:6a00:4b15:b0:845:e08c:a4eb with SMTP id d2e1a72fcca58-84ebc466aa7mr336322b3a.58.1785367539615;
        Wed, 29 Jul 2026 16:25:39 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03ccc92sm2028551b3a.58.2026.07.29.16.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:25:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/4] RISC-V: KVM: Cleanup SBI extension status when disable
Date: Thu, 30 Jul 2026 07:25:21 +0800
Message-ID: <20260729232527.139183-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM SBI FWFT extension has multiple internal state can be programmed
by the userspace. However, when the FWFT feature or the FWFT extension
is disabled, the internal state will be kept as it is, which may cause
some side effect for the vCPU, cleanup these state when a SBI extension
or FWFT feature is disabled.

Change from v2:
- https://lore.kernel.org/kvm/20260706021154.210289-1-inochiama@gmail.com
patch 1, 2:
1. Apply Anup's tag.
patch 3:
1. Remove the csr_dirty set.
patch 4:
1. Add a new patch that sets the csr_dirty for FWFT extension.

Change from v1:
- https://lore.kernel.org/kvm/20260701094731.1022163-1-inochiama@gmail.com
patch 2:
1. Check support callback existed before using it.

Inochi Amaoto (4):
  RISC-V: KVM: Add SBI extension validate callback
  RISC-V: KVM: Add SBI FWFT validation support
  RISC-V: KVM: Reset the SBI extension when disable it
  RISC-V: KVM: Mark the reset callback of FWFT extension always dirties
    CSR

 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
 arch/riscv/kvm/vcpu_config.c          |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 30 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_fwft.c        | 27 ++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

--
2.55.0

