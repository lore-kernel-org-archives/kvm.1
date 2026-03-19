Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B243803C1
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919182; cv=none; b=mnUcghCaWfq/OKuu7ulujinLg1cZwc1T7TZbZAbclh37jaznlSKGaUgF1vxbQv0ScZS/FD1GNybhdDSyncbb29MFx5Cg6jvUgIpDtyUhcIkNf/wMOt+yFBnGLb66XM0LSKRwN5snnGKVtQveD+bpALnafy9J9ZoZ/IO7naXkcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919182; c=relaxed/simple;
	bh=WcogFnT91p/6xHhoOOxrDlEKpVtT0FuCCr59v8WzyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/taimhRY/Kuq7zqssCcbbGjFmL7pXEp/p/d44uvb3WzGuh+WbkSFbgO0VzfjVu1lAn1KLn1qo5wnw3bYyi/PBHA+tJct+ylpNxscKK24fI6J4JSNUn+Kn/Yfr+V8m6s+ME4i0jflYFCjeyE3KWOa1neAwIwe3tYckmDkBS5/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVccFAEK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVccFAEK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so5740585e9.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919179; x=1774523979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsvpi0Nv6unOmAIYlVVsHJQ1gspFFY+qEHNCXl1oUAw=;
        b=RVccFAEK24oDwrBO8kF8FojP3zf7+aePd25DY8PtSEcwai9KfAYHipnnvL4MDnTySf
         aNgqwoHbPLUwUWYMeSgDggUwnDV4OmoDT7CMkyBel7UCoSMvxMjiW2NwNlOfIhLgKOJe
         2vXIZXrD1c3gLvreLCTRopzZPboUDrAlJq6HR5jrr4pZc7a5uoKlAfdJHNKmBqCrRSza
         ucy2/uIq5SQBU1+XZ6g7Bn9xDZHVZX+jYzTs+tAs/qHLurnROTqQzangEttPnOejnyh5
         CuuoEgxCDipUC3Q9+xsNOSZblOTfQX/Qg07dSgmwa8mngtt8g+WjkEUbtQLsZwbqzURZ
         3C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919179; x=1774523979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsvpi0Nv6unOmAIYlVVsHJQ1gspFFY+qEHNCXl1oUAw=;
        b=X02kgLpAjQBMUopk1jxnorPNG7Epg7Ddxxi7XY8aAWMZdnjPeRqC+j7BzsvU5RENZy
         hJSU62K1+WOCihnWwbk+qowkq9mIyqRODQoh0TfaKyuxQ2PC6aNJfPNYnqxS3DlLvlPh
         Kgvb2CSJh7T2GCFEyQ+LB1eVlfpYisf0uUSCBnvvoztDwSESafHWQUwhWcknywNOqCa7
         07VPtjP+opmLIuOGodSlG5d+Iu6siPAIk/jK3iX2cpin7F8+UqlXZQvrhYvG+sP6pZRs
         QFR+afXL9jpbe+Xneu+y6s1gc6l1QoZRWmrEDrUJSVGmP/1zmiEGjTAl8sdAXR091PO1
         ljMg==
X-Forwarded-Encrypted: i=1; AJvYcCWJiSJDbNiDqqavWWb7d98UpNKdm28v5u+7dYoZGarzam6Dp0TJo7tx6e5LyC//QV9FYfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfmtS14Kj8Otamj5ylrjMwFELLmzS6pO0yrJCeujJu+yOAsC4
	8L4PGzT5E6d7fsPv7emqFw8kHpoTjq54W/N028XkCSZIKahkiZYlVNSP0F7zqGXsKVfadf30/1i
	f6yAAjbs=
X-Gm-Gg: ATEYQzxaiuYBnhynifNCE0IOIp7WaNIkwYGvsTatgHdI99W+edG3GfamZ2NTv1bx0RB
	akLr8lrnWgP6yKADy6HwF9WhOtP7wN6/aV3BA5talgCl5nkPO+bfJoOWC5h+hfeUi0rExjLyf1N
	pIjqqHg5o7mCw/aYQZJbr+Q4clBiq87KdggVLvvd1sLi/TPQDNeZnEs3LyYuGcU97s85buVIo/V
	M/u9bbo/Zd/j2H9R/IFjllJgdh2tQSP4Mg93ldpaTVdXPb8pRMQaAfnRi5AIdIkrQdIlQ17aNAG
	+mwyPI0rG792rHhn18ibYqgRqStnGz86Cn0oZCzrKsI1QyoTjkqHppwTMXab8L5wYgzpS4CwAPt
	LqRUVQKdk4sbbQ8ETy6RmLtvQe4hOH5K74ZWF3zD/Kiu2qlzjFeVXDXhL7LqaxOVpK/RhFIH8ap
	oTfbCvaDn9MUHKFW+VLk3pgqX8m4xc1EvkbJiIxQVKwsBxvm4PYlHyEJ8ZcDx2tGsuWLZhKw1q
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-486f442d3d1mr113139975e9.7.1773919178807;
        Thu, 19 Mar 2026 04:19:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fd9845a2sm10632815e9.6.2026.03.19.04.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:19:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
Date: Thu, 19 Mar 2026 12:19:28 +0100
Message-ID: <20260319111936.68041-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace legacy ld/st_phys() by address_space_ld/st()
then lock the target again further legacy API uses.

Philippe Mathieu-Daudé (8):
  hw/ppc/spapr: Un-inline rtas_load/store() helpers
  target/ppc: Factor common ppc_load_epr() helper out
  target/ppc/mmu: Remove unused hash32_store_hpte() helpers
  target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
  target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
  hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
  hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
  configs/targets: Restrict the legacy ldst_phys() API on PPC

 configs/targets/ppc-softmmu.mak |  1 +
 include/hw/ppc/spapr.h          | 18 ++-------
 target/ppc/cpu.h                |  2 +
 target/ppc/mmu-hash32.h         | 32 ----------------
 hw/ppc/pegasos.c                | 67 +++++++++++++++++++--------------
 hw/ppc/spapr_rtas.c             | 15 ++++++++
 target/ppc/cpu.c                |  9 +++++
 target/ppc/excp_helper.c        |  3 +-
 target/ppc/kvm.c                |  2 +-
 target/ppc/mmu-hash32.c         | 24 +++++++++++-
 10 files changed, 93 insertions(+), 80 deletions(-)

-- 
2.53.0

