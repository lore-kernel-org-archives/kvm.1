Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20B21E087
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051788; cv=none; b=r9gzYADCl+Xzc8TBvf0mPjBA5QWNlOZu7bWM51vVB0bngN/ytYb1rFkcg9DpRmiCT5V5loJxvVs7FaRWyIKzCU8CdEIEFsvj1Q2ZGUmJcrt9TvUCe7HnNXxGb/9UbDflYjrtloqC0PHpnY+R6dEPuSfa9s0KfAz3qw4Is8jZk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051788; c=relaxed/simple;
	bh=iVcE9RrZcl26REv9KZcwEG1itIHBEVAGnJ7liWzs2n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9wijvv5tgnAySBUhHlyXVZW3+5f0qf6YQPnv5+WVRF+oHiGQy1ZCLm27ht522L7vbuR9fJf4R/o7BzkA4+kPyl+rxm2sj72a0qCJ4b/wTDittceYj8Kg28gFj1n7o+UcmdTbRMKnYMfHR0VxISLqFtMJrWYbyTuSqV2CrU0cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVG38zvG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmfU2ocm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVG38zvG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmfU2ocm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwAnQNfaCoyR40gaeMt6QITdHXPQjNKk5ABGyzLqLus=;
	b=aVG38zvGxwRdJbFVNu7MKCdmutLYsHoHsd2Gsct7es9lIr03PVRwmVP1pYWUn/aG9hm3tJ
	DzPyLgFIJKkSisgEfgGWV7TIvwVe33muJOckxjbICXBVUVAs6WgzmHNIvTXfQjcsjvypfM
	GYzZExWFh79RYeDBSv+rjleLm/zhhv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-glPTD-nrNISHdxMl63nFOA-1; Fri, 20 Mar 2026 20:09:45 -0400
X-MC-Unique: glPTD-nrNISHdxMl63nFOA-1
X-Mimecast-MFC-AGG-ID: glPTD-nrNISHdxMl63nFOA_1774051784
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so7821065e9.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051784; x=1774656584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwAnQNfaCoyR40gaeMt6QITdHXPQjNKk5ABGyzLqLus=;
        b=KmfU2ocmu1pAowzJA7gFf7lk8WmyVOsNdJDdA3fRnupCk0HkkfKTC5KSkxRiUZZwU5
         VgFt1JPUFHRptqjUR3J4MBaflu64Lhwf3SQBnUZrneIYKsS8eLs3MvEA6oxVvLLVF9DG
         ZiL/dPaU0eYHtpa7sKp0yx+THWayfLICE8fe607FG650+Covx5IgpHsMyGNa6PE2LHn3
         zRMB85cQ0F9bnDavqrBuhIBPVfiiZxezUN4YBqBKF1tcSqcGz8X/YnIOILqMAxz2zR9Z
         Bp5qElmCpMthEBeKN6DbjWPNp/b24bLKwrWJKHz8yMrNWthnpN8Np4NtsPWOUt1Htq8Q
         u6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051784; x=1774656584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwAnQNfaCoyR40gaeMt6QITdHXPQjNKk5ABGyzLqLus=;
        b=f7uoCQoKgkm6ORIKB/x+wk6qUVC51cfWr+oyZdMdldkPseoZL8+2o6Gwtt5UGXrB+H
         LT9i7D6ss5w6D7cYUrt5uuTdWIZZUxuAGfhrhO3oWFk8dIN5W5472mbHnckdE5tAT10Q
         ZBBAjX1XBVWpA05RKRe2SnZPqeJUBLvDIAGD7xuxP21qZiVRUG2FD8G6RHTncYSoHFbD
         xfbJXYUu6XYoznVasFwEgwlqUKiY++AzgxJCgZhnH3QDVEmTI/h1jp2DgOWd6EjCIhX+
         uqn6aa26c0n7UKX4N1GhWEMw6A/+SmmSC32aGosZTmHZSsgoiTXoC9kWPph4xvpzYAJQ
         zxVA==
X-Forwarded-Encrypted: i=1; AJvYcCV66KkFrZhI2SO5nHRb9VUWrBuBAKk+PXvWH+5ORlYDmj4E9b1f52HY6vFKJdg8zDRjFqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKHn1y/vzsGQ7m58Rb9YjEE+lDBSjO/a8AR9qp4v7e1VAFfft
	AIc/X92aIEXH5OoGts9vDFuaMWN98vd7iKAHVZgRB5xcdx2wqy501FlLUKJeLth5dwPXOBbKGYo
	LdUH6XzMAFHSDaFKsfHDAjvfRhHnALinul6AIMTDAVTfdckgNqr2XDQ==
X-Gm-Gg: ATEYQzxhAAJVk8jiZvFuxd/2vwnDYcYiTCFXP0hwe707YX+uaLxnCrW0f4dF/+qHLoI
	cpJ3V2aglZ97L1leKPBftK6B3ISS5apXOnga6I7C4iExanbB1iiu3RQxpp7h3i/9czdQAwQ/Ndm
	AuAcI7LUqzvJfRwThicvUfX1Jqt97mRzfWlw9uJaFl5rq2EGmw+x6CRF+suEybci2wr/Nf/tzDv
	w8+wyO2kus7MHS6dRzeOlYc+rItC4Ro5OYCDNDb35Ev0F2SpAgB5YZ7FdrTQhbK1QXneDWh6sXf
	3qHQLxHlxBm2wIvrvHbfnSTJMwJRTvcKBB/onM+u8l2NTY1QedQDA997KCfSAX+ie+7rrAKgTEP
	VadhDxire1SVW9Ez3PHSDCxgvzEentXobe9ehcUGD6iNWHrP0hpt0LL88jk9fS8JJ2W0hA4ZsZm
	lutxK6f9fvvZYLKtJRMtZsOJ7U
X-Received: by 2002:a05:600c:45c5:b0:485:3b34:2f51 with SMTP id 5b1f17b1804b1-486febbc66bmr74063055e9.4.1774051783698;
        Fri, 20 Mar 2026 17:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:485:3b34:2f51 with SMTP id 5b1f17b1804b1-486febbc66bmr74062885e9.4.1774051783287;
        Fri, 20 Mar 2026 17:09:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487004e7bc4sm34110035e9.2.2026.03.20.17.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 04/22] KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
Date: Sat, 21 Mar 2026 01:09:13 +0100
Message-ID: <20260321000931.1947084-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Access tracking will need to save bit 10 when MBEC is enabled.
Right now it is simply shifting the R and X bits into bits 54 and 56,
but bit 10 would not fit with the same scheme.  Reorganize the
high bits so that access tracking will use bits 52, 54 and 62.
As a side effect, the free bits are compacted slightly, with
56-59 still unused.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index b60666778f61..7223a61b1260 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -17,10 +17,20 @@
  */
 #define SPTE_MMU_PRESENT_MASK		BIT_ULL(11)
 
+/*
+ * The ignored high bits are allocated as follows:
+ * - bits 52, 54: saved X-R bits for access tracking when EPT does not have A/D
+ * - bits 53 (EPT only): host writable
+ * - bits 55 (EPT only): MMU-writable
+ * - bits 56-59: unused
+ * - bits 60-61: type of A/D tracking
+ * - bits 62: unused
+ */
+
 /*
  * TDP SPTES (more specifically, EPT SPTEs) may not have A/D bits, and may also
  * be restricted to using write-protection (for L2 when CPU dirty logging, i.e.
- * PML, is enabled).  Use bits 52 and 53 to hold the type of A/D tracking that
+ * PML, is enabled).  Use bits 60 and 61 to hold the type of A/D tracking that
  * is must be employed for a given TDP SPTE.
  *
  * Note, the "enabled" mask must be '0', as bits 62:52 are _reserved_ for PAE
@@ -29,7 +39,7 @@
  * TDP with CPU dirty logging (PML).  If NPT ever gains PML-like support, it
  * must be restricted to 64-bit KVM.
  */
-#define SPTE_TDP_AD_SHIFT		52
+#define SPTE_TDP_AD_SHIFT		60
 #define SPTE_TDP_AD_MASK		(3ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_ENABLED		(0ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_DISABLED		(1ULL << SPTE_TDP_AD_SHIFT)
@@ -65,7 +75,7 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  */
 #define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
 					  SPTE_EPT_EXECUTABLE_MASK)
-#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 54
+#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
 static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
@@ -84,8 +94,8 @@ static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
  * to not overlap the A/D type mask or the saved access bits of access-tracked
  * SPTEs when A/D bits are disabled.
  */
-#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(57)
-#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(58)
+#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(53)
+#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(55)
 
 static_assert(!(EPT_SPTE_HOST_WRITABLE & SPTE_TDP_AD_MASK));
 static_assert(!(EPT_SPTE_MMU_WRITABLE & SPTE_TDP_AD_MASK));
-- 
2.52.0

