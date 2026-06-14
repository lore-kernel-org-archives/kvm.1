Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36723264CC
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480252; cv=none; b=EtGLfPD4VNoJInezmr9UJUolZV2aaIKhiu/V+rwGW/9nasZe9IQ8hT/uFmfXsSZMe3Sn+X6iqtJbz0s0gnpJErJNSreRgEygKVMonQ/3pGhhamZm/ThRjJFxi9Yz2+uMx/kOvvl54nUtXSyIfocdc8MIHwxBncAqh2D59Qtrds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480252; c=relaxed/simple;
	bh=rijJshmhRkUuGJX/PuLbP58lfGONTYgSuFkgzyR8VOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J90iqlNelPYUkTtxXhXCJzav+w4bbMR/rPfbMkCyIjVGaWCLukj6gKiisn6lpml3GmvCl5Ll777UIjKP3MMeLs2P7mlMLxcsAMRj7CRrMfVijOG0W8gS9yN13N+YB1rvdzqu73Ol7pdoHDowiCum8OdPrKNIlyVvEVUFtLCdnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vinxiGQb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vinxiGQb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422382178bso1707617b3a.2
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480250; x=1782085050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RkuCI/+eMWHNcnY4Dw129KdkmM25H7NmHu46vX7x6U=;
        b=vinxiGQbdgkqnMhbenbHeHO/u56MjAv8xiD5qBHYYSWNK6JsN/AzNOOCaYBzm2vCGU
         U3jWra2M46ojchsdSPaC9ZNFdDTXUTJ2K3BtjYEONwmJFpk8iju8gu26u/FmfXls7HKV
         uKHYqxI8aa8xvRMK1i0r2RvPw08T61XsVOwAUN2GiqT54ngWPIQxHc3+lg+bjEzAaWrD
         dLMCQd3ho7knbDjkxNNr+GuZwtYYpi8l6jXtBNSPOjPk7oIdAphYEaApcZttgWCF6jUL
         t+qveoL2dzlYyhEctDFUjJ2ZLuxNKDheCmwUx/7yOP6r4jrenxXBGfH8S6DQWzEC9Zco
         TGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480250; x=1782085050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RkuCI/+eMWHNcnY4Dw129KdkmM25H7NmHu46vX7x6U=;
        b=l7bFQ3oZYdIMKGCiwOCZPP7jVVo18eOQ0x14D+7ob3YqvvFygIIhEat/TCOAfrPh5+
         nMizRkdY7pKnT9fFZKb1N4lZ15wBqH88vnOGM8iw5ibud++8MSbIJqMUaq2JswylQACf
         4M/6aaR86XkvAO9p7z4aeuMYQIPrZuVypY9Hc0FvFWCxX9Iz2xvAvA4ImSGK1nhxutq+
         vQE0TV8OJxTbnn1CSyJ+Kpe2nX9FJBNs4gdTksxsKmMnf83tacFLiHqvubjvRPS5atWP
         8pFlhNSr3HWHVxFamHpgPdOPXA9oxdWtbqWe74mTcHKwK6GR0CLKMb1/HjDHO8j65ujf
         10Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9QQznScLSlc2vfjfrEf1SHKhBWk08yXlEDokRWiR9VwG+gMKBue4oThyd0NhbDnP/zXX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmR+dW3vGL57Noopud0DIqxREHNq0YYl/cvdOqnQcry3IA6mDg
	YT8L/uuIVcJfUqBi03ixJ8dj8q8VGlPdSQW/pYvCdMXpXpBHj/n4PznpznJySnTJDjhoNldwRT6
	Y9rJa+72CumndgQ==
X-Received: from pgmk4.prod.google.com ([2002:a63:5a44:0:b0:c85:117a:2b31])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f86:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3b783fb321dmr15268629637.35.1781480249981;
 Sun, 14 Jun 2026 16:37:29 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:11 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-2-skhawaja@google.com>
Subject: [PATCH v3 01/18] memfd: export memfd_get_seals()
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

memfd_get_seals() is used by iommufd during preservation to make sure
that he preserved memfd was sealed when it was mapped into iommufd.
Since iommufd can be built as a module, export memfd_get_seals() to
avoid linker error.

Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index fb425f4e315f..1f45fa6d4e9c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,6 +315,7 @@ int memfd_get_seals(struct file *file)
 
 	return seals ? *seals : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(memfd_get_seals);
 
 long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

