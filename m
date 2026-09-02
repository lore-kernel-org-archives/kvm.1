Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D48274B4A
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320345; cv=none; b=iGXZDwj42vWZ3sLotYHuyx+0OD02iGntOLCXkecJIPxldqwRKQwo19vnjYtUnhzFP1vuRTt9hhxyKk/wui7wcFcQhC5xxtHktadQ9oaRcycWC+cugUUCdZdbWLUAHGdsyIodMn/hopLulkVbRJZevLdsGeDIo0URpSa34jKeopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320345; c=relaxed/simple;
	bh=+uFjL4M2eOGrovPZjv+gLuSNpHM2F/R0aa1CcnaxvG8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=CCC6AWg6uf3dkxxfhrdWyyNchN7eJwGJQl5caZy0cpNVCf+oy+9TL96JDvyLNeMoxvX8mQahCPJ5WRd17vU7TDqRhn8FyrU//4SCokF3wE0w3+HzgkDeiMacmNmRuaUu0cEZfnldhcCG0Ix1NvWJNeDBHJRpwHcZcDvD5KcEl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uiK7moSE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiK7moSE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66e64e6e3fbso646023d50.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788320343; x=1788925143; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8fojBHcWDAxPoaYVGsHqqGZ8A1ENNs4lsc009HVd5s=;
        b=uiK7moSEVYuRQYnHj/S2q6bCVimRCVMDzjtmU0t/bxHLJ26Xqqapzd1zW6WpkNOQR6
         qxqQl/r/rE4FNNNEcgyvBfzZ88/NjsTawQuMeP134ifZShv0XhdcOLXuEtFQ6nn3ZmvF
         2msLwRQqooLsTic3eNpMxGcKzQyWS3wfbruX/WOA35ulVWVcuexheeGu+Qsq5P6KGD+z
         PtnAgI2UerC/Id6cDyCbvNWoK/Q0WQ27HoeGzMUN6WmdoTe8a5p8dcs+9UY8W2c4ASnG
         lCD3cyFhfas0Key5FfRQGeym3kexkHmHNuWOuEimBQIWe5mQeq8xSAjmMKry3OTbtyL1
         LBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788320343; x=1788925143;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V8fojBHcWDAxPoaYVGsHqqGZ8A1ENNs4lsc009HVd5s=;
        b=CAVZcMBW2xwMbPLjQw14rxlzcNNiwRPp24X8ukUKJ2ooFIKeI/zTmeEa+Chpg8dC0F
         otlQS/kUDriurlJ3MCAB6w8KN+j/F9a6bM54PWeTpkRFw9zWLhtnt0NSyrVIIomszftH
         WuGUR//acHT+TwY7sKv+EfJ6Oou12ozy/FRJTmSQiejlBxCFjLCYzaF3Gi/asbZgPoX6
         uqJwm3LMUhOP9PXH2yzqyhwAjm6/XpCaEB0QvyvNauPQI3CACMrxLQ9TvuJla3+ibC6e
         oB1WIv24Af9zfpohf14lDyBK2+jxkTfzlUdLDhVDWOTj5G7UbJrT0btCcSMXd3kYGuiT
         K8VQ==
X-Forwarded-Encrypted: i=1; AKwUvByBdJ6sjqd91gpnc9J4WL8KiPEavKriJz2orOD01NDVCUqPEVbzzbEgo2MB/AhOq5lF47g=@vger.kernel.org
X-Gm-Message-State: AFuF++lwRrsywB+8TZBAgqj7TaKVivRufdnblKvSEj3QmLzeBjXrQR9k
	nsxWDItZqE/W7Is7ahyTHY2Hu4lZzwfqnXPnwLClBmyRt+Vi1QxYgHE6mgmbjCokpg==
X-Gm-Gg: AYBFou0lSGbHGvUchTYrZBWFY4WtE6RhH8ui38Fto82DUCQGx9VIWZkN14fBbNpRJ+O
	Aw/Lra00palJww2ArvC2vnC+V6haLOcI6l3ZQMvs2fWVTXp5w9G1m3EEIZRsyh9qHoyjWOP9ZXx
	m7gXWAXEz//oJ02YsnZ5D/IUPwDgQqL8zwUVBTWR7E+PJc9LdCsS0oNvassXd7HZSdWBDXvuMpk
	UW4JfucCAXGbRIwh1iudoPBwL/iHBU/T032FLYy7T1gG0AOaxAZezQzsRUDF3JAvxs0ia78o4iy
	FDs7Y3T9+EUXVMkVa4z+LeXk6WWnE0egaU36y7fcjs48g8+6zyWv/Zpy+uHMxvedQRPdmy45I8I
	9LYDDm8z3VadEa4z664VQsCJTJE7C3YnUbqBYCGgy5cYaKcwvXxt5o761TU5N04MBJn5haXswz/
	HM5AeyErqJwhlekR0vwH90Ju/5RP/OXHKq5/itZMNPRHnspbHXFTFzoTFhE2Gwfvo7hXF9N6gnC
	e43cwvS47W35HaeMBiUfaUdjZUfUhJKqF8hT97CaUq98Q+p
X-Received: by 2002:a53:d017:0:b0:66c:4163:c4e6 with SMTP id 956f58d0204a3-66f9bd4a3e5mr528831d50.26.1788320337604;
        Tue, 01 Sep 2026 20:38:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66f9850c9f9sm1031960d50.4.2026.09.01.20.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:38:57 -0700 (PDT)
Date: Tue, 1 Sep 2026 20:38:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Binbin Wu <binbin.wu@linux.intel.com>, 
    David Hildenbrand <david@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
    Matthew Wilcox <willy@infradead.org>, 
    Sean Christopherson <seanjc@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, Hugh Dickins <hughd@google.com>, 
    kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/folio: EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio)
Message-ID: <02876cea-5727-2ca4-bead-73659ea6fec4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Ackerley Tng <ackerleytng@google.com>

To simplify independent development in the KVM and MM subsystems, now
export to KVM the lru_cache_drain_for_folio() which MM added in 7.3-rc1.

Link: https://lore.kernel.org/lkml/bd6c9c74-e374-a9d3-ba1f-8b6f430894fc@google.com/T/#u
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Suggested-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Hoping for 7.3-rc2, which would make my life easier: thanks!

 mm/folio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/folio.c b/mm/folio.c
index c02dcea9c03c..50a6dbe55998 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -33,6 +33,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/kvm_types.h>
 
 #include "internal.h"
 #include "page_alloc.h"
@@ -926,6 +927,7 @@ void lru_cache_drain_for_folio(const struct folio *folio,
 			*drained = LRU_CACHE_DRAINED_ALL;
 	}
 }
+EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio);
 
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
-- 
base-commiti: cee9395acd8043be0644b25c34bfa86623f2b935
