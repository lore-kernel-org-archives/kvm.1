Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F126B760
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051790; cv=none; b=VsxcNJBdTUKvpptH4NhEUor5qpjVDFVHZSPSDXe1NGday6XiQECrdQroSGIDUl9wdhdePNv1oucW2lJ/V39XxNTl4ifA4bGjwYCr/Rn8a+TbQr7dodHM3Y1JGQxM4jMF62O4+IATtPzv2GEe90Kiv3xepD0NtGSUltgdQs7DuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051790; c=relaxed/simple;
	bh=OJBsyJfTqth9OfgUA01Qnwq1JO04burdCzePl3InDIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDSzui0jegJ/si/mnZ8rD3O/auhdjW33FDTUx86c4EqlC/ItA2VRNPrxmexruTIG08NyWHl+mPbfFlYPdVvvYJgM8+UGDiA6n+3v2210Iy2yEUL26HE9RBeOF4tlMsiuivBEvSgtD/wgqDdCUNXefBcoVIc8KeWdvaL/cPCTMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMVQS0I3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=So4scJkA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMVQS0I3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="So4scJkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXO9T9Z8K77B5X3+NmDVkDSP2SW3BrCQveRA3iJEcWI=;
	b=gMVQS0I3xL6TSqU0WhKyx6iADMMKHJNKNXwkvl5ITDCLYZ5IqzRer3NxO/vcMD+3PURssf
	5TmiSd6uNwc5sOrnP2754sbSwyw1cXg2tyhYBJpcvw5IKUDeTCVPUhfD2N8f6gN+B2ewqf
	QhbBYm/53HHJHAYLp3Um1BaoVoTDrgs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618--L9V_fnVNTibqzXGmjEc2g-1; Fri, 20 Mar 2026 20:09:47 -0400
X-MC-Unique: -L9V_fnVNTibqzXGmjEc2g-1
X-Mimecast-MFC-AGG-ID: -L9V_fnVNTibqzXGmjEc2g_1774051786
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so24013645e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051786; x=1774656586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXO9T9Z8K77B5X3+NmDVkDSP2SW3BrCQveRA3iJEcWI=;
        b=So4scJkAxN3XmcQRDIymFGd6QDRyc/WkYENICafZL+Z59m/hxsqMfY+8As8kC70tIE
         dfg8MaW5HRNIca6X5GQI+NF2qoWOUkbT8MWdc2VYTkWG4Zwvai+oGaDh4k7EEFUkBBGm
         sWYapbEYmVLgiqyF8rvwCnKnNIAnZEIifAujSDI+8UCOdbVnUJmPTJKP5Bps912DtL3I
         c4xgZRsMnOpOvC1JZt3x8Ranhb56EqXpYp0T/wrDhfWTD0Sl3A0v83s4bnb/f8iAqx0B
         LNH9wvwB3LadPyceMjz2cQGw0o3J0tqUCVNk7ykYQlrtjHgkNy/7/AyK2yjkyzVYaCtC
         SQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051786; x=1774656586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXO9T9Z8K77B5X3+NmDVkDSP2SW3BrCQveRA3iJEcWI=;
        b=jiYBQZ8YFgAviy04QzP0K3wd0bKmZDfeDIVDVTGGh/fT1xtPWQ6/WRcOh/6io51BHC
         aAWAjVT37ABD9iVU8SjoQrqtGIo0Vl2h6xM7DdWkoJjKaysz1mDTrMKsqI/WVCitWbbl
         hnAnXS7CMNiZFilt5oXn4Wu+Vec84+08A3bpniYhjwIYCWPrwbtn0OIIM9CiNBsmj/er
         llVwk0uFeB9s0iaU5cgXUeGg5ESOUJfrOuLjLSHyepM0ifOEg3RMgofZAOMV8DZJqZ7J
         Tv3b/GLs/cfFN+MlxaWBh+0kDIp9M7WNe6CZJyhSyzQat+OwHvjw4m7t5iVcGolLNBPo
         HeYg==
X-Forwarded-Encrypted: i=1; AJvYcCXmG+auNMo0hx759l9qDlbZNeq92zjPOxg7diCWgUmZwQa95IoribYb8EPrmBuSaFi87Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHq8csVqnnCM2A6avd0YAVqE26Jj19moX0/Apf0Kl1NY5yVE4
	6GRNlaaG/Tt2mXVoam3QrrbSHHfsNUKvH/kQAlamirWA3lYs8oRuwpbfGOio7OGHlg6WVDpikfK
	VS4fMUGBwe6cjAxDYOS+VXdt/z1zYISdqPdyLVDhPLumbkk3ENMgf9Q==
X-Gm-Gg: ATEYQzy29ToreMpQeWsKy4sTjl0VmHSU6ltcif0dJX03w7ZbkvbB9r0r0yhQkY/C3e5
	2ZLa/KOwECDh0fOmNM6D2IsPH0AzbZ0Yoqivf8ahmIDfbE6hOV45XHfGgoSei7QTXS/16B9ITyo
	KAz8AKN4YhZ6iEBvFOlk1OJMFFRzTShJzNgpaoyyn8nkjbubY0YGWa4TmixH7/RVHf85tCUgMYi
	7iaTF5nQTW0GTHZ6+sPdgylX6XcWrlLDsk2WOrezjfndy4I3jZG7f2XQd3MsfctfnhHB3TFmcug
	eE/eAmZ9SqB8O9ba/1Jl52BCPy7cDwULoQRS9UoGGx/k3PcTc2v+Qq0QyEQl94G8K3DSmFsP0vQ
	4yxW4xpXZLaXOHVubyH8Q3z+ThIgIweExM5fyD8PcqzEUcporWJrE2QX9ZXpQPFqRZf0X8U8hAq
	7mEs6OOe+9fVJp+dIUpcPQsSaV
X-Received: by 2002:a05:600c:3e8d:b0:486:fe45:483 with SMTP id 5b1f17b1804b1-486fee25f82mr63400785e9.22.1774051785830;
        Fri, 20 Mar 2026 17:09:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8d:b0:486:fe45:483 with SMTP id 5b1f17b1804b1-486fee25f82mr63400545e9.22.1774051785417;
        Fri, 20 Mar 2026 17:09:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1cb178sm26349555e9.29.2026.03.20.17.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 05/22] KVM: x86/mmu: remove SPTE_EPT_*
Date: Sat, 21 Mar 2026 01:09:14 +0100
Message-ID: <20260321000931.1947084-6-pbonzini@redhat.com>
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

spte.h is already including vmx.h, use the constants it defines.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7223a61b1260..3d77755b6b10 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -57,10 +57,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define ACC_USER_MASK    PT_USER_MASK
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
 
-/* The mask for the R/X bits in EPT PTEs */
-#define SPTE_EPT_READABLE_MASK			0x1ull
-#define SPTE_EPT_EXECUTABLE_MASK		0x4ull
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
@@ -73,8 +69,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * restored only when a write is attempted to the page.  This mask obviously
  * must not overlap the A/D type mask.
  */
-#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
-					  SPTE_EPT_EXECUTABLE_MASK)
+#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
+					  VMX_EPT_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
-- 
2.52.0

