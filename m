Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A13A1681
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549057; cv=none; b=BQ50mpms4RLRx6M3ABJe+wF5zDh7N7JylPi29/5Dj+RunlAwtWBYwDeLlKIeXvfkVXDVQck7e5XZileP02Rh4hYCSVoC7tcKLQa/b5SDljulOIO9PbuUsdIkV2XUWdalPMvZjtdXufzMIxEPL1o2/uvvCfqBTX7ss2uP5suVFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549057; c=relaxed/simple;
	bh=+XRLjOpS4v+IUj8Epgk8vsqlWWWhFf+iPFdKVLl6SyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5zqQAF6xbGwddUFfCr9SGrYaI38lOluPg53v8w4s4qGMXiqzajDF0zJOpLO4sQ0GljRRudZUeDTHwAMZmiKV8Qd8qiWN4YeTP1AI3tRg5GG1a72YXYKmimFpn+pKYg+Od6r0dPKgc1DG7LmefnXr51rf2LjX4QKmpFNAdL/Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0EKKGDk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ppq93EGH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0EKKGDk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ppq93EGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZNDRdV67MUP45bmnySAtmpJD5gxz3701J4cRjhnqB0=;
	b=R0EKKGDkPy+zAB1bDDg4F12CcFyv5+brnUiB7y2qb5GvzvqdwurAnVbDKCOjj8bkxk9ii5
	H4WFgwm/tJSYhcR5mFqwojfOp7UOsYg3rsKu00NgM2YWEq+dxUXqA/4q2/M4Z7AYpH//3Z
	GjlIGosEW4/LGhTh/JjTXT9HXWBjvgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-DQTU6ORfOraxW9ILqy7aww-1; Thu, 26 Mar 2026 14:17:33 -0400
X-MC-Unique: DQTU6ORfOraxW9ILqy7aww-1
X-Mimecast-MFC-AGG-ID: DQTU6ORfOraxW9ILqy7aww_1774549052
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fb142205so17973555e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549052; x=1775153852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZNDRdV67MUP45bmnySAtmpJD5gxz3701J4cRjhnqB0=;
        b=Ppq93EGHnaFYB0wuR6HlipR53JmjRrUyUU31fXBE7zWLUZO+ZDV2Ln1K68B9ZeDrDY
         2CbNWubRZfhtWdiU3LeNfcNO/hFI8okWDIEC6DcW9eGuu+LLyX8kLi5GsFuLQKp8PrZ9
         hQ9L+HsMWaet+4YB7Ye3Z9e4vDD3dMFD5p91XsHmai6YsCd2yUazDH5HGMHHLWT8d2GJ
         tgamg8WYsIB6GLcwFwu1Xnojyuhtiui6Vu+OuDpzzD6FB9x0T2sjatz9CihZ+UkJrU0q
         j82TMnnT9a08MW4k6rfZYHQH5uwR+n4PZ6SJDtjB0PZEg6Eh/bC/gKjWid9ugYD9AbPd
         pN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549052; x=1775153852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZNDRdV67MUP45bmnySAtmpJD5gxz3701J4cRjhnqB0=;
        b=I3bXcsmpqVUpGnwawWnA8oazzPwrJf6BSgpsWn+Cp1FeYfouMOrSfF2qwOrCIv0yh0
         u/hTM+SLYoUULWak5Ut5mipYuQ4g2Vv0wNAqCJqGNyoE5dgqY5HtidK+HBGds4j/qZrB
         bExHEu7YP1DR986dtkCc11PAGRGuD7lokjB9GDS01C2VP52JChtoTCgCbie0UUfU5Yoi
         As4Ht09Uj+R20yEZTfFB+j0g4a+WKnet1b0ycAlaGzoBypwqseYfDzAwYoWMaIbMkaUQ
         LjdmfEuiTrcTkxunVGgUicCE+rGIjMd4igmzKNAnF7AmuZYuZWeNRIOJnJNB+FBsao1H
         xEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXtPqR3rY1gKTSyIzD7aRdwIf096tequcd725r1EEX54T3OMudZxe5OkZV3j+QMxGrlTmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbgYmypFd44EsEgmnVu8WsZfbXmHM3at3FGcKjLlGR2VzRVia
	97U+9w8+lt/jzfVHh7a9DXk4lbaTrBHD2AL2c4XS2s6E0DwZcmbQlhtCP219SoWLFOlDcgt1dzN
	tefpT17m6TVp9Kjg9jRykdOOjUvSuhfhOju1F0isZObmJySL7zqY+AA==
X-Gm-Gg: ATEYQzxJluBjoKPA9a+FgQmrh/SYcx9bm8dQzk1sd1z2qx/0OHqbVPAvZgxC0i21GDf
	Ne2qXlRKNABKSqoGkBTWDYwjSn5Or6LKXus2eNbTbMpvoW+goVcNs5zgq/0yDHHKICi1VWnYgzZ
	FFl/EC9uHXse69UcOds0D3HN884rNDexRa6N2DPMp8t+0B6J0qmMNS36cAZTYTgdBPSkAtZc0TX
	rdpS0poM2OjTnRYOZ0r6P6xBUcRZUwHqUWeJEq7bJOYALA7CPKa6lQy0JQyoLqvLUbPcpg7LrNv
	DKhFP/UQfwwmNvBa5aWPje9zd7W0OoJ1Qdknicz92IAcWsd23WJ55IjQATOiB8vJEB0z1JHBau3
	LH6+Hajo6AZ614H1AjcjHW2w4NBH265fcPkKGxrvHqcNZ9t6YGA2ZWSkpr6d0mpIwp+foJ9zsY9
	5d/d8KdraHKhiXmQtnqDPBr2U/
X-Received: by 2002:a05:600c:8b53:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-48716071d0bmr131990715e9.25.1774549051751;
        Thu, 26 Mar 2026 11:17:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b53:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-48716071d0bmr131990135e9.25.1774549051290;
        Thu, 26 Mar 2026 11:17:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm97827235e9.9.2026.03.26.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 02/24] KVM: x86/mmu: remove SPTE_PERM_MASK
Date: Thu, 26 Mar 2026 19:17:00 +0100
Message-ID: <20260326181723.218115-3-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

SPTE_PERM_MASK is no longer referenced by anything in the kernel.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 91ce29fd6f1b..28086fa86fe0 100644
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
2.53.0

