Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FE21CC59
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051784; cv=none; b=AY13CFsqHJlFdQZZSmhlsRB62FWj//cEM4OtjjoN5eG2Ndr5AfYelR7/R0eKPQwf8H228fKoZbmAZQh4S5KsGE+v1u0lc+Eh01w0nwnOwDBdwatjg7uUlJOrN7TL64pBCV2e6DwudmnSniRstHioqt1GxPk4L3cRGg9OcHvSXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051784; c=relaxed/simple;
	bh=w6YAb8ugu86VHmga44IWfL0zX03LYLcB7U/JmbkGjao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0UjvZdOQs5l8vcni5vDmp3PXzTsh9QG2hhBJMjWZ0PreOJVtS7ZgSTrg4UhMWDS1/RFP9RJ7K1NxxIW+Z4WuXGnWzwmNUsxmPIFnBW0GRGD8ve69LzxVdRC2ca4GoB6d7puyUv3eXWhsrLhQFeDh7odDtbJpX2YjjArQp7vTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5CViHRB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHs6iEw3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5CViHRB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHs6iEw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0aglvj+2VO9ti6n01MQ2ehRFqW/1tKmIWd/HfHoWyw=;
	b=M5CViHRBLMMp0OP5bv8cl3AsAJqQ9SoGn+O/L/qoWWP+PuBhPPzHYcKPwzTpzUgzJ63vKj
	hyt5oNIPIIRkMuuUIHoRSDxofjkfto87GMIGQhcO84ByG0nRRStQnd+qk4IvI6ABJmogss
	NgR5i8LatXWD0stjjzGXlb3kvpM+s1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-0F7lq5BpMEiHiGOtNUDT2A-1; Fri, 20 Mar 2026 20:09:40 -0400
X-MC-Unique: 0F7lq5BpMEiHiGOtNUDT2A-1
X-Mimecast-MFC-AGG-ID: 0F7lq5BpMEiHiGOtNUDT2A_1774051779
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so7683925e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051779; x=1774656579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0aglvj+2VO9ti6n01MQ2ehRFqW/1tKmIWd/HfHoWyw=;
        b=PHs6iEw311p0XbitC+F1bRoDA8lPA92j132Wm+jskAgKbVGA8Gq6cRdqiC/r9NvxMj
         m5KOsIcoWYFVRloQc6n/m444IbHjOj551ATbocTaLMNihr1qZiO1PzpsqMCpxX8Lqlmx
         JVrMt+1wf5CYAAbLgYFj4dXuKY9OypjQ7LptBrQjc0K8w1lgaU0qv8wHTLLI3DtCv6EA
         LPmKlrmt6x/pA4Fg+Fdv5AiAK2oDJhqtPGTTNXdDZE03UHd8kQPhvWAUJOqcvGavVS80
         byxEEsGGdJbFkOOjzatSZltjbwOK84v6ZU7nKjeRM2bXvkQughSnaiIPEGT0HB5B1k4/
         metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051779; x=1774656579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0aglvj+2VO9ti6n01MQ2ehRFqW/1tKmIWd/HfHoWyw=;
        b=YKBKaxrwkLs347rRTYydjv9Us64CnE5DAEFreoa5i3jAEUY2JW5WJ5/xsagbPQ8Jcv
         Rilq5iJ55qqQQswYOUb1EZu16OtREyTZyhbMF/FW0jWqwuNXplFXsUzsvI4nQuoORt2f
         fTwrTuRb9RnPRavHHxIxUE5F8Ogu3ujnBR7hsgMqEMnkWB/aPaULw3sKtpu2+UngxTBe
         9wdJBqRgZ0zl3Uo32/586WtRDTctCmHvBHrFAziJUfE519eWDt1hn9dxmfSz2moWylxx
         BQoZW7Ms7Xk1kaGGoCWB7/sCiyAbpNuw03YxTIOnwEQlKL85PTXBxBKtxwHUIrymu96V
         umyg==
X-Forwarded-Encrypted: i=1; AJvYcCVhWCXuO+6LFcyxuJ6jeYwL5cQ/JvC3n89zgXWKbfHz5MF3tWvbnMKZ/Sne3UNs8SbGg6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMK2hDLYkkR5G4J/CaxY0DUzNBZmRS7a/eD0hCJLJYCf1pFnm
	pihyRb3N18YF7daH8WEu6lvNw7vwPk57l6CCue7Irt+ReBpjdCuyoFsEpzx7IUfTOcIa6sXeBi4
	Z+x8EzplLWgqrG0BZOs/qy0oFZRRQAzni7hlGivt0ojzK1RHWTJz4N5jeMHT/IA==
X-Gm-Gg: ATEYQzzS+HSiJIlUy/azYrNanLI7tMquRdJP156bHNf3NQXvgdGI79JSNOUqwo+7Esa
	T5dReBfTq9a3Z9galNq3XErs33uv4cq4XLrNtVQpyvp+vUcpbqLtkqvoT2LDEkQINYB/l3OJP9g
	yNibVxrBwx+D67uq2iqnIM6fgEC9NPipIOrN5T3NgfzcWhW8WN4jcQTCdr0P0p86ukymkvYX4zf
	eKfQMW2nr+TbTCv7WXUfHJzbSEofYzgYGAJmNAynYFX3RQ0NmHETYQu91m7x2VrnhBL3sjZYcKp
	GGqv18U4z7mPIrQtIbTMk6l28nmHLyFxySw4pThDh8hcYnI+fz3oAV3Xly6g/xLWXiRN+hnaeEk
	zg4BKspLnFfhmPUj97XQh/mSrd4NcegTyI5YCUuQDrakzk73PQ5rpFTn5IEHEDfsaAJdyJMTJ5o
	YlEQBCqIqhzfNYSlYSfW4tqzd7
X-Received: by 2002:a05:600c:4e8f:b0:483:badb:618b with SMTP id 5b1f17b1804b1-486fee1e062mr68527935e9.24.1774051778936;
        Fri, 20 Mar 2026 17:09:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8f:b0:483:badb:618b with SMTP id 5b1f17b1804b1-486fee1e062mr68527795e9.24.1774051778528;
        Fri, 20 Mar 2026 17:09:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm162958295e9.8.2026.03.20.17.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 02/22] KVM: x86/mmu: remove SPTE_PERM_MASK
Date: Sat, 21 Mar 2026 01:09:11 +0100
Message-ID: <20260321000931.1947084-3-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

SPTE_PERM_MASK is no longer referenced by anything in the kernel.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 3133f066927e..0fc83c9064c5 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -42,9 +42,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
-			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
-
 #define ACC_EXEC_MASK    1
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
 #define ACC_USER_MASK    PT_USER_MASK
-- 
2.52.0

