Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5B3BE17E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010763; cv=none; b=szaCWPn2MdQ46KoatuK9rML96eKVVIv6IV26h9LBPR0koHfs0VWl1l7qFQO9ZDh8bwnJ+Lq0NjPwt9DHdfHX1ykzkeTVXheq+vZ9G+uM7P1MysZYopkA8p5eta7rl8Sw0jJo6x+mLctPu7tCa+mgRWADE9nKdaH5eLQuDCJ3iRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010763; c=relaxed/simple;
	bh=nJeYpELUiDcRSbIXmLTI6IC3tPIoc48xDRP+R+rbBgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsyCAF6Bv+H50iVs7pluGg0wBI7qUCUOlaH1rCAWTyy561CI7dSWnlFA+AVFCf55a5UqJTi++VbN66xd75Jk9xFO4C0bIZjwxPItkfIZoAApJavpg3rW4yay4kz8GF80ASocPKRmoLY0Mx1Lv060uuhukpwiBc/POzVQut650g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acJg7PGx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rOiMaAb2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acJg7PGx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rOiMaAb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nK8zNlHgmpkXUn4LpCw2HngzRpbAF8Tg67xFKU1xx/A=;
	b=acJg7PGxc/q9RMyNe/RCzjks9hhpomADBKWUfSOV0hwRGHxy0qTc7nngRjUiyBvotP1qBg
	shNzM/RsVKCZDQLtNyW70zjf0XmeivVlV6D4DdG/8DP9pA0KL1tbg0hgwCJdbZs2fHrOeM
	MY2U5kirmkTdk8QwmEjFQs949v9sOOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-a47HxRUfMgyLbY2gw2NzKQ-1; Tue, 05 May 2026 15:52:40 -0400
X-MC-Unique: a47HxRUfMgyLbY2gw2NzKQ-1
X-Mimecast-MFC-AGG-ID: a47HxRUfMgyLbY2gw2NzKQ_1778010759
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d035e8593so17344445e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010759; x=1778615559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK8zNlHgmpkXUn4LpCw2HngzRpbAF8Tg67xFKU1xx/A=;
        b=rOiMaAb2EekyuO7xCdUI/RjGVH4XWK5vp9UVzXc43BO5pCW8PQKOvQ+7WYbCU8jAXm
         6/oLLJ/5eybP8NmWVuCPTJ/bJFIcmX11gdCADrm7IQKq0jeJyoKTo2XMLxtCjWhAlyyg
         ubE9p81IAN7yMv8GCT0thRcQM8dWDRFR1opnqsPS2uR4tEij135w221UhhxDRyIwWDyI
         jBu7kCdp9R1HelXSMsctpbqNl3X1SRkpPL8KNyUia5tAZ4cw9fMJQHhTwdkYKMlgMLKk
         8HGARMUZGqwxUNgDxswSPosPGa3DjSnuXBezE99ryYE6TN/Z4YT1BIgv5003JSQ6D8K7
         mLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010759; x=1778615559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nK8zNlHgmpkXUn4LpCw2HngzRpbAF8Tg67xFKU1xx/A=;
        b=K2s8O2wEyRBeU/8JgmEQkwLjHTsj+dnLwau60v11mkKbyOb7gmHvKgtZsFFo+mfpHG
         FobMytMjj7OJFWrQiAxg+R6Dg/fJudmJgpOXrOhi/PMQH79gMfM3UtxnZBJYZ6EnTjTJ
         TjztBkncAwSHRXANakBDT/au0YUvQrn1X/oj8xbA5A3q6QnDGjWMzjg+GF2i/x8i+w8O
         +pHvSDBiOhhgpt+H/yJRo3XIWwyrRGzKmyZ9aD6Ii2igxHeE1Ee3u12jpqjKg4FnY0tu
         aHfPzVM4/CGZnrTx8d/BroEOBOBXO9TDirVPiCqKfbgjBeRDV6dJ3PS5QCaK5RzKx62Q
         3+pA==
X-Forwarded-Encrypted: i=1; AFNElJ+rIZKgx0RZY+ICZ5R82nYKxvUy6L/cjmOEaHsoGaT0fonlUpClTWDihYd+MFM+Pb3QQ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybePA9NbHf1MAL8i1WtcU/CjGyV2nQnGomaXm2VPh2qbqaaq72
	rIkMVPWl3dfGBrfBK4Jsd25oJJaR0tk6Mh2ZfJYskAO6OIcZ+SytvHB9qLv3+fjFnYImW02LSIt
	JZcfvNRxG4vFI82AVcyEivdxmfLGVqKvxVU5aR5aczZGjJK1grWGAwIthHj648A==
X-Gm-Gg: AeBDietF9k5wcTnI3XM3snQvUqHCaO2xZDTXSrGwQuI0kAGtA0dcqRVS1mD1750i3I+
	xNnXgqKs47BuT0tcJ2r96jIY56LJYexnz4BGs+Dcx9ZduK47ezq9olbcvAB0zpsRz/qSKk8fnW8
	spOsw0/Pm5mzzdLOyfuqEv/450+KKp509/DREHEQmitaiTWiI2Ho3n3bGwF2XXux6bKeJScP15w
	asG2WJc7/yV9UaW+vZgGnWL6eVazXOtGTDXxHqQP+oknMhAprFO6bMfNY9hQw2vviGWYHE2Hr/h
	JWvSuLcd9QvNBkEcHBSfJR49wmaI4Tb8cBEhKMSr22b2CnE0GL2SJnl/OJdQJLrsj6Z9DgWBLOx
	fjC/l4tsHiO/4SPlOErLjRRnxsOyRR8DJc5XDkGx2WEpRcEQr4VVpvnMdD2a8gUZlRCVa9rWGQs
	yahoSk3B2kzL07Q4hSD794zgYHuRt508Bo+8X9aC8=
X-Received: by 2002:a05:600c:1d11:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-48e51f2c7eemr10703965e9.10.1778010758953;
        Tue, 05 May 2026 12:52:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1d11:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-48e51f2c7eemr10703595e9.10.1778010758527;
        Tue, 05 May 2026 12:52:38 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm414102265e9.4.2026.05.05.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 04/28] KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
Date: Tue,  5 May 2026 21:52:02 +0200
Message-ID: <20260505195226.563317-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access tracking will need to save bit 10 when MBEC is enabled.
Right now it is simply shifting the R and X bits into bits 54 and 56,
but bit 10 would not fit with the same scheme.  Reorganize the
high bits so that access tracking will use bits 52, 54 and 62.
As a side effect, the free bits are compacted slightly, with
56-59 still unused.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 4283cea3e66c..317b9cd1537c 100644
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
2.54.0

