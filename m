Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30008372075
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355400; cv=none; b=cN6eh7AnVzYD7iWX1tfyTqo/CJcJKcj1CwxWjQFxlRko4iZnoTPdRyt75CwLqzqHwwkgPKgsCdMYOzZ+txAwUt9dGT58dePsG25l16r6wmSwF7Td94R0l6NNR9Vd0ThaALLPWXYBl7K7k9RCzWU5nvo+bjLcR614LNvhH05qQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355400; c=relaxed/simple;
	bh=nybri4RROSwAxOUpK+99AbN3TtRTQOVGETcv85iq7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiG21wIu1YbSY/tppHOTkgZnR6rBMgvS5syEejvY93Wf+aI7GqW9+5+CNE0UvKJI5eOTEL2hNSlf9OYBtnSd0XcAF3f91qo9ZXvsVytX8CUYbFU7yCc+Bad3I2jbdEtymkSQAaxd0MXNeXMGLJx53No2J6uTkr85hqBdnMr/yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtrD6P1l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUfu9tgk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtrD6P1l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUfu9tgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779355396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G6Fy7nu6CkeQp6jRl95/lgK1TaMdGznNu2U1ywzhNEg=;
	b=BtrD6P1le5iVXRV3lIraOukDSFf0Y9gRKWm3AiQqbCBSu8flytg6+GPxiv13k9AsH1k4ls
	mVApRHxwtM0NS7H1fXR0AwsMsh77xr00PENOdYvQzDr8HXkqgWLvTblpaYdgIwKNjxrSZg
	+zeW3bNRbuzTme0F/86XUNfxNqvGAW8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-oxnbGV98NOmWWpMr7sPPmA-1; Thu, 21 May 2026 05:23:14 -0400
X-MC-Unique: oxnbGV98NOmWWpMr7sPPmA-1
X-Mimecast-MFC-AGG-ID: oxnbGV98NOmWWpMr7sPPmA_1779355393
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bcfd21f71ddso123019266b.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779355393; x=1779960193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6Fy7nu6CkeQp6jRl95/lgK1TaMdGznNu2U1ywzhNEg=;
        b=fUfu9tgkstLSQDDNqdvWUEqUAUkpuUF6edNmcB9m1lcNOsQSt426doh7U2TC4UIa2f
         vgivHYLM2Kh9O+sgW+SPAxVxPoQzpiPzZYo0ePsULAGQVNNNB4fXUXAqYb149teLWqNK
         Z2NcLsyiYHUQ58Y+qhQ7UxZBKMxpRzb3VvNHcgTaYC5TrfA5F+UkQdzIqTRvvD9PycVC
         kzZmz4+9M9fnkTV+4+iXEfX0RjGjIdXDqAAfs8QjhiaDiA4Ie5wua0gZWW/o0kY3rqyA
         ZYbk9alkzUchY6Iive8B6TeW2KG/GgLtEE3RG+POyjaETjsVszLsdEjqlmdb1JLek1DZ
         0mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355393; x=1779960193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6Fy7nu6CkeQp6jRl95/lgK1TaMdGznNu2U1ywzhNEg=;
        b=A2GFTCUHEzEf3VWELDHljPNzZfXK4978AbVM2bcOLMgn45qgtcClWio6HLL9TEKxiK
         M5GuNGQ753nKB48Q2CpbFdQUMEjXd0uyPCl0n2IBbCoZpQHBSMweLBrsR9900ULs+5Xh
         ywbGLqsO/BX+76+ThT63xjfBlpEJf6CmeshKWSyxVw/dlgbbUFSBnuVDQ7jknHSaeuhj
         S+AQ5Zzp6kqVCqE4wHYBtbLV4PvKeNubTSeeoJg0mjsnFUnxc3X7KnoJ4ee/8Fn87cWM
         b1Q7Tpid+oLQqp88UoTIc7VHKYxNPL2AC3Ev+ic1IYYFsWf7McsGTGCTgv8pvmcF2OW9
         0Fpg==
X-Gm-Message-State: AOJu0YxjOgCOrBU90I66dZNeZU2AMDGU3nuhwWZqC6hO9S7rnfa5dUTY
	GDqwZquNrDhj3kQCL39sYgGP5mtmHf8B/qxK9o4tWa8MaXpzbSmmBG1IS4pFygsj+JmHbh6PtUD
	qu3Yr++CmumVncpMipw4xAn0nyTaOM4TjPafB5l+177T2+LAH+RcM/GDySEXyWYCFh+gQiRBTtB
	S4myqfmQzpk+p+QGbIBr2R+DgWUqY5f5Nb22ZCU7jR
X-Gm-Gg: Acq92OFDxRI/iJqCWtXnbDLqPhhkycfxae+xSgUOUrspA10qUaPsdf40BmiYjS1esT9
	Eh7zs+DQau+pwL6aSPO+YR59dxl+D46corxph+W6+0jZDYICjyak8UYVHHtMh0RCeNgvUKn5ol5
	H7psKhLk6okcO5v5RsGc+QoUi5GDoifhVLOWxfhcM7lRRibv+32pKH55oTECUHNnAFjKCBD2r3H
	VsGuGMEreNCgtDT6ntiPH3/lDO1rcT9zWrDSUD/GRa7BQEbOdJqUu5WETp+CPmbeZ492bA51AuD
	fHP4py7wlhtHYYxizGtXQutI93A3NyIk5/gYTrtaxhQVhaTDaQKjyA5D9rbZVhxMQQ1jHXdcZAJ
	x+tXifp9tTLqEO6P0veLd38bi3tq7pw72Kapyl/AQSRyHJRCfiS95/QNTu51xQZBETr7yMuy6Af
	gifTWeuWzi9RVGdw82AZUsLVtLhSxBeOVzVK2i
X-Received: by 2002:a17:907:26cc:b0:bd4:f3c5:3590 with SMTP id a640c23a62f3a-bdc135708fcmr106209066b.3.1779355392949;
        Thu, 21 May 2026 02:23:12 -0700 (PDT)
X-Received: by 2002:a17:907:26cc:b0:bd4:f3c5:3590 with SMTP id a640c23a62f3a-bdc135708fcmr106206966b.3.1779355392481;
        Thu, 21 May 2026 02:23:12 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc878912f4sm21791266b.5.2026.05.21.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:23:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	minipli@grsecurity.net
Subject: [PATCH kvm-unit-tests] svm: fix rflags and rax offsets
Date: Thu, 21 May 2026 11:23:11 +0200
Message-ID: <20260521092311.86030-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need to include the offset from the VMCB base to the VMSA, which
is 0x400.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/x86/svm.h b/x86/svm.h
index 7603ea0f..f926cbd6 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -437,16 +437,16 @@ static inline void clgi(void)
 
 #define ASM_PRE_VMRUN_CMD                       \
                 "mov " GUEST_REG(rflags) ", %%r15\n\t" \
-                "mov %%r15, 0x170(%%rax)\n\t"   \
+                "mov %%r15, 0x570(%%rax)\n\t"   \
                 "mov " GUEST_REG(rax) ", %%r15\n\t" \
-                "mov %%r15, 0x1f8(%%rax)\n\t"   \
+                "mov %%r15, 0x5f8(%%rax)\n\t"   \
                 __SWAP_GPRS                     \
 
 #define ASM_POST_VMRUN_CMD                      \
                 __SWAP_GPRS                     \
-                "mov 0x170(%%rax), %%r15\n\t"   \
+                "mov 0x570(%%rax), %%r15\n\t"   \
                 "mov %%r15, " GUEST_REG(rflags) "\n\t" \
-                "mov 0x1f8(%%rax), %%r15\n\t"   \
+                "mov 0x5f8(%%rax), %%r15\n\t"   \
                 "mov %%r15, " GUEST_REG(rax)"\n\t" \
 
 #define SVM_BARE_VMRUN \
-- 
2.54.0

