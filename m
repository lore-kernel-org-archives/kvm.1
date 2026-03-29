Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2437F8CC
	for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801388; cv=none; b=rKArvMxRk3PUqtcm31NaEgJ4efL3lOdzovCXsSOla3xYTZDPixL9eAtcOb51XsXW0SyAj+7QSIB5GF5q2cz6brJ1alM9+8qN9UMktcfPmcd+VgJk559QeZ1Q70pC0qK7f1NoIeNu0QGAGc604CRQn162aPnBemA00lgvX8+HQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801388; c=relaxed/simple;
	bh=N76Yozl72V4IJoegMuT3rhC4pUQJktWCtGKNdXGSMxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBqnlIP2S8ZGtLZSVe7foufh7q6eDtGk89R4qBWCvvLk7S9Y6JuNn59MFWAjTu9dNZtiNZkEXsx4KyRIEVAxp4NT0s+tV1hyA4QJ205Jx4L5YH0KprDX9SQB9BigZK/GgKrloD4DG5GErdxjdfpcqoz5GV5lhWVKehQ2fpPvh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjZEap/Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/LU+rDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjZEap/Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/LU+rDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774801386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
	b=fjZEap/YiF2hxgPXypOYiA5nL8sYbwqLk/tWpHrZemgdr+4tsFjZzNqmU734Sqjp6dFPLF
	yHt2z+ZHDkJH+Vee2plqU5wYlo7I/4uuEUS6M0qn/A37lAYQCOVTRXpcO40zMksD3lC89K
	KK0f6O4yo/1gGDMoHYVfoXms3N/3T4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Y-JOqu__PUuO-Z4NT7BV4w-1; Sun, 29 Mar 2026 12:23:04 -0400
X-MC-Unique: Y-JOqu__PUuO-Z4NT7BV4w-1
X-Mimecast-MFC-AGG-ID: Y-JOqu__PUuO-Z4NT7BV4w_1774801383
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so23195525e9.1
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774801383; x=1775406183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
        b=P/LU+rDnLPFMnx5Nc3IEsWmR/71wJXJdt3Q2dNuNnGz+r2slnWbdnDLlj/pj2zU88Z
         +SBNcjsmb9SVuVT1noIM6h4HtFwuvThqNaubAOGSLERkEnzkxxCk7PSnBpFKG0LRfcgs
         fWBVcuQW1QC5O/z515vyYoA8G/bS3lodCzE32cVv3yk3g4vg532r3ZuEC9C6eoKuYdBy
         WDj1xSmpvqmEzt9qSvUfAYXiF+oAtjjVuelQcRHVNcgmIiXIfEmT6TAV2BDXEDjTBs8d
         6BGl2TwG3Kq33IbAnpzyvD9JQa34DlvHsExACBZ4nuvNT//mkWhkDriSiQPs9i2suSwc
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801383; x=1775406183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3gvOI5QoEtskbIIavChNH8cgoYnb8U7P/1W7Nu+WAE=;
        b=EBjmW0u+col1Efn3pNK9QtTyynL84APymifz2VRkn7x5lMzgp0JF+Lv3q2oE83HMkg
         4bpE6YZZTmt8EsxjP53qxnFMQ6F80I7v180h6QSY6aeXvAflKezcr5j820aOUKnSpMMI
         TXp9UnlpwboA0qMrgwV5nyAWnA9/h6douorlqd/URkQzaRvL2aLbqIIyGKKcWY+qa8Oh
         +EvIR9io8a++pXIAziUgZubWqXKy2pYvKfub5kqUsRCboNQ0/5wa0hlFUPZF6xF7nKkh
         F5UT/tJoGo4+h+68pGCE1k7NUBdIr2YERxpz6KKcU6RVD8yrJEFerFN8SNYliLxVvMBv
         NKaw==
X-Forwarded-Encrypted: i=1; AJvYcCXM1ojv8r8L9834MoEdJBEg53DD7tkPS/ZCqOjMctTswHL4qFf0fkCnmMo3zj8NrDoDLMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCC+BqGHTjWUBebWZIvezKgYrTHlPaxp17WsTpoXP/NMeZkf7
	5tmQqDL/AUg/QhFRH/QKGpbO8t/EyWwRq5ZJvOKmaq2TOdK4iN53CeOkGKkLlxm1Wjf0FZil3LI
	Uwa0Zu9ZRp+DaqMglsID55fEmpZu6gDbUbTsbbxdi+JzwUdZS4aHFTw==
X-Gm-Gg: ATEYQzw1zj46DV2GmyR+hX2FRQhy7h3Jtsbgf9pJK4AcYMchJCX9YNaONRIEHMpnyAx
	DJdi5VPua0frRijCD0XEI0EX5SrS/fG4wo+WNgZJS7vAzf27qUD0vOsmQiIqfDOvFqB8c8RdLwa
	XbTUnYBHD9NQKJTiotAvovT180d4HeBtvtVuWUWkAD5Zbn1SeV3bbIKwb0UpFXNY8liYsO7qKbU
	wGSRZEm7qvhGa352YRrW2BJR2XS+WQQHe5nLftdbVbxABGQmRyK59ZqiqvZjVTGib9tNVBGxmuO
	n/FqhQrXBKXIg7lIS/A2MvWpwzBolcsClE3l9wLXD78FAhc0+wxsYUAhSQabPFBeYY7f6uM9TqJ
	D72uAzQ9QPX9zVXuLxNY7CkZvp1VgU9/qC7qhNCahcFEmI0fUF7OxneVuuXyeyMJClnq2719P4k
	hiRLxNVC4oqCsOmxid3yJTxbLigSnXm3Kkh5y+iEOd18GyCVf8sjxtMByo
X-Received: by 2002:a05:600c:41d1:b0:485:364e:934e with SMTP id 5b1f17b1804b1-48727eda4a4mr95959475e9.21.1774801383267;
        Sun, 29 Mar 2026 09:23:03 -0700 (PDT)
X-Received: by 2002:a05:600c:41d1:b0:485:364e:934e with SMTP id 5b1f17b1804b1-48727eda4a4mr95959255e9.21.1774801382780;
        Sun, 29 Mar 2026 09:23:02 -0700 (PDT)
Received: from [10.242.181.123] (93-44-53-42.ip95.fastwebnet.it. [93.44.53.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270ea64esm77961935e9.5.2026.03.29.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:23:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE
Date: Sun, 29 Mar 2026 18:22:57 +0200
Message-ID: <20260329162258.106549-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Adjust KVM's sanity check against overwriting a shadow-present SPTE with a
another SPTE with a different target PFN to only apply to direct MMUs,
i.e. only to MMUs without shadowed gPTEs.  While it's impossible for KVM
to overwrite a shadow-present SPTE in response to a guest write, writes
from outside the scope of KVM, e.g. from host userspace, aren't detected
by KVM's write tracking and so can break KVM's shadow paging rules.

  ------------[ cut here ]------------
  pfn != spte_to_pfn(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:3069 at mmu_set_spte+0x1e4/0x440 [kvm], CPU#0: vmx_ept_stale_r/872
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 872 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mmu_set_spte+0x1e4/0x440 [kvm]
  Call Trace:
   <TASK>
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 11d45175111d ("KVM: x86/mmu: Warn if PFN changes on shadow-present SPTE in shadow MMU")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 98406d6aa2d6..dd06453d5b72 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3060,7 +3060,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			child = spte_to_child_sp(pte);
 			drop_parent_pte(vcpu->kvm, child, sptep);
 			flush = true;
-		} else if (WARN_ON_ONCE(pfn != spte_to_pfn(*sptep))) {
+		} else if (pfn != spte_to_pfn(*sptep)) {
+			WARN_ON_ONCE(vcpu->arch.mmu->root_role.direct);
 			drop_spte(vcpu->kvm, sptep);
 			flush = true;
 		} else
-- 
2.53.0

