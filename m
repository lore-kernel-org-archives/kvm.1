Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AA3AE1BF
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549077; cv=none; b=YssC8aOO6BkLNN5tAoc2hd85SZ46nMTYFapNS1fzbWKwSf/q62ntRsSCkiJ4xddk3OTRXYxBaSUkQiZfPkuRvrv0v2dumfZrcKB1fpsIo+yKyW0aygxTDBwG/pCGywaHoq5/iu7Y1mIRvO+J99W18m4EuDjqUrQko2dvv6XdZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549077; c=relaxed/simple;
	bh=vTy9O5IsDlG6v8B6glBVPqw3VYt2VMRG16l4ZUpy0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVnRqM2/fP0X+Q9FniqVdlmv5tTZtWEs5dHIXCx/8r7J9nVjYn0YP9gzVw+r/nY4N+fQynd2Cmj/whQfXkfPQJaZwdj05g1s++ymxz51BJdncY3TgsB4L1tEIMKeVmAP/7t1C9G5iq9nsPTiOcwxnkaWhyYX+LExSxyNHUX/UvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsrwoVuo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mG6eZKcy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsrwoVuo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mG6eZKcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcMqJJGPCLK+VRPcw/NPeynhXQGvPO9SUzIgJSMzXxQ=;
	b=bsrwoVuoyn4/ZHOnmOrS05emEVE+RX6X8N0/r5fAvy4K6Fflp4F4PrCQpo+ourKP7wmohL
	7wMUBy1TIteRyic4oe81lM0KGPmZXx/7SyrLDG1ecCt4/tWC2ZKw/huQHA9nDEwrviG/hK
	O74oTBXjMMnxZRiLaVzZhQUhZjxyvLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-dmxgeYkNPCalmOEAzJVORg-1; Thu, 26 Mar 2026 14:17:51 -0400
X-MC-Unique: dmxgeYkNPCalmOEAzJVORg-1
X-Mimecast-MFC-AGG-ID: dmxgeYkNPCalmOEAzJVORg_1774549070
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b8f23bdc7so94080f8f.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549070; x=1775153870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcMqJJGPCLK+VRPcw/NPeynhXQGvPO9SUzIgJSMzXxQ=;
        b=mG6eZKcyzthQv+cEEXcHKzy48vo2Os9/l16Lj1agQOaD5NUCKQpJu/z+f1RlGKJmQA
         FAM2j5JDWAcYefN+LQdZ+KXkX6pVZASuLyr3WpT/F5B8MXDnP1i/ed+/CWg1E69MI/9p
         +vHL+WTTYLVYsnRmIBaV9/qO0zsFRd5tHeDpnRyWyHM1+FZEg0dspm67Fs3UHCi1BjKk
         nUXy+UQipNsurKc+9kpRMs02L71hOhQNL5H+08YOMds8Ueq/fXmfdXsnpXlHViaHI9d/
         dV+U2EKmQ+8gMVx5qOaIoqtQGBGvfGerBO4NGASyjL8Uhcp3mr9M/W+TwB8DTv0LgeDb
         Elhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549070; x=1775153870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcMqJJGPCLK+VRPcw/NPeynhXQGvPO9SUzIgJSMzXxQ=;
        b=cEk2M9R7iAWvbkKFhpf8CU2CktzowqY/iTQ/94ZJ7fF+idQOq559UQ4bM1rF2o3tik
         oL3U712+4EtAzKP+yAvQrD59wlruNJzAiRNuzXykGZfiET/J/T18w9s2fkw2dJdL1Ddj
         n2cGjKVDYq9p1RH9DdNaaShUblFo02cdUM1/WSPTDllxY4s34WwPWg76gv32wSkpYyGU
         3SVimnsKBTuPQJy7dPq72ieY8Al7hdJXhwjMaWuphwf+nhMCxhGrT+lo6qtPMLZlSZjg
         8DsoLF4dQHbzx1AnkzWQ1ML4D/h0h5u9pB8Zdiwo6GEQbHvhBvl7khIuhUJO9U22H1Nr
         rD4A==
X-Forwarded-Encrypted: i=1; AJvYcCXJZDMAHY3nsiOBznIxvV9sucYuFgY+jB/JjJpP3hpVNafoYBFLQDuTjlbyNqK/F6rE71Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMflad6S+2hWzpqiLUMb8qw+sXvDN5ZKeXxwwelP387d1W3Jv
	dcgoL/vUyPin+VpqiZMUm3gxPExJRqtPUOz01ih0h/JzvreXTbJ/tXlxsTGud6yki5UcOGS6VMW
	5z0IR/wi7AbYwgJ/LN5C1HFBnnXbsI8l7PgqLniZhCOtwuIg3IzyqNw==
X-Gm-Gg: ATEYQzwPu9ML5SLTsb2DW6yf0EkWtCH9zTOyQns1QZFfzoxkrYcImS8/x909msW9sj+
	X3qDOOIduWzTyYqBQMOwE8UI86xM5Y9X3kPf6xiNgN57pwPmxsmTem3WO0D74KPZl8Xq9OR7RJ/
	GwfvZmjoqszTUKQ6IInkEGRS/Cor8C7q8lnwZJtrMw9VbEbfwfLtsvdd9m7jtvA2YIrZXDekPCQ
	AhBPdUhKNN1ulWVx1n+FsR5kY/2RT+2Yfcav5rhYPwCDIfrn46rRvkbsNtXh7rDiwr4gI6DOFVJ
	cQmDcvl4Nn6EpqG33vcNqqLlKsJLuwbnRjQDrDEjon1b+XO5VB0AT0uaGqEZ07szGDZeImQXMyQ
	UodJSbPwmuac9UcCPbOqf3HjGw1GbCODV5B/em5ltp4MXfZ6kIaSSgils8lR8CDQhPG5QQEXskU
	ZU0V3jCPLokGXr1VisL16Z6KnB
X-Received: by 2002:a05:6000:60f:b0:43b:3c06:c30a with SMTP id ffacd0b85a97d-43b889b2542mr13985142f8f.18.1774549069700;
        Thu, 26 Mar 2026 11:17:49 -0700 (PDT)
X-Received: by 2002:a05:6000:60f:b0:43b:3c06:c30a with SMTP id ffacd0b85a97d-43b889b2542mr13985075f8f.18.1774549069217;
        Thu, 26 Mar 2026 11:17:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91942f24sm10449273f8f.11.2026.03.26.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 09/24] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Thu, 26 Mar 2026 19:17:07 +0100
Message-ID: <20260326181723.218115-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that EPT is not abusing anymore ACC_USER_MASK, move its
handling entirely in the !ept branch.  Merge smepf and ff
into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5f578435b5ad..dd5419a1f891 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5553,7 +5553,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
@@ -5586,21 +5585,24 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		/* Faults from writes to non-writable pages */
 		u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u16 uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
-		/* Faults from fetches of non-executable pages*/
-		u16 ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
-		/* Faults from kernel mode fetches of user pages */
-		u16 smepf = 0;
+		u16 uf = 0;
+		/* Faults from fetches of non-executable pages */
+		u16 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
 		u16 smapf = 0;
 
-		if (!ept) {
+		if (ept) {
+			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+		} else {
+			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
+
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			/* Not really needed: !nx will cause pte.nx to fault */
-			if (!efer_nx)
-				ff = 0;
+			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+
+			if (efer_nx)
+				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
@@ -5608,7 +5610,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5629,7 +5631,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.53.0

