Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478629C33F
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156047; cv=none; b=dwin3qfx2nIFa7Y6JOqPBVYtOCYUuNwZr2d/Iz9luegEPBSAv1PS09inXmPkau2+L0Ea7alw/qq9IhNtXHameHmvjB03EZQ9YztvcS4gvaWvEPB1pIC5qXrMt7bRTVAM5J8NhRL0cMKsLd2nn26wtI881ZvauvSd3Xxa384MHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156047; c=relaxed/simple;
	bh=yOi7yhY6Fy4JlfxwFK8p7Rf7I8U/HAe9qW+3MGP6hOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqHkCKq6Vdh6JeLk/BpqVKJagmiViYNV2Y6wLRWG9FMfG/ik9SOg5cQV7JUaFb7/JE20YMu5Jv32DufnmvKbYRVlb2p2cJZYxV0v7Uy/aLoh7STSHbYQMZ7zF5eBflQjmkUY0Lea8DARKDL49gH30jBJsUbmQ69CzwDtiTonx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLwY/VJD; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLwY/VJD"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so161197a91.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156045; x=1786760845; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9EeRsRgHcmBuChfylKO96SmshYr8igDm3AdVPfiyOQ4=;
        b=BLwY/VJD7tAT8TDGuoqTa6ve36/Y1WpyOzMxw13jzrO/V1AvDOZneSPHFbwcg20TYd
         V8m2ePTqe1kdoRAIaIR6Uexv4UJnodtKbYOX839zg2JExQJAEmUJcQf3mwmjT2I6Zmq6
         IjVf6yV75DxwV3zZyEDLZBPElLokEvd9kxuwr7lDDP0txL7sbLvYkDdJrUJjNlnjLHee
         SdWLC2UrJuGP/l03dgPjcqNtCQAAJXJSklHjeFBlslBpmo19XPzJsocmUutOTBHyaFpO
         oPvWjfbqCN7+jK7Ows882OwtAi19IWl4/29u3ysgADXMHy/ozlwFyWGgwfwUiQLE5cTq
         /ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156045; x=1786760845;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EeRsRgHcmBuChfylKO96SmshYr8igDm3AdVPfiyOQ4=;
        b=UAutWxBOjOhrFaUQveNW0raxA+4z6oeuEcPThtcQ6wKg5ePvW/YTfczBjfHIdlKb09
         QAUkp9ECNtXvQdXwYAFv6ZA72bPeHqZw0X5W5aDLtuvEEmlAychWCKlFvsyt8M/plcNf
         W8qGL8YdYRBTY69dUT0hwEU/3VgrFHGAdOZmwyTuuoSPl00koOq1evR+tkdMVK/COLhK
         qNp2q9tl2/lXe9nLK0y37WjqGMYl3mo7f7wbf8uygJiqsogn4MMwRNiYqqZ/8iGHHlrY
         lxC8CYLeNvGdZOW0jY2o0xulJfRXPoxqds44rZlzNkVNwM8j9x7DdjRivS1/9j3YR47f
         wnaA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1dwY+TXpD++gb87YlvP3h3BMlSEhEU+Dlg/W/u3Ik4QB0itORwuq3QADctYrqCe8UZX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ41tclQ7I6l1Im7Oy49Rd0g0AyC/RuRPL4z3ZY1zd5poOhQZe
	LtC+B5Pw4SP2+F2aiDx7Jz28UVBFhMKg55MCrVNl5OyzQh7wG/x2+5VJ2ZQS/mp2yKSqfZ9X4Mx
	/TWzGxXnOeqbHnw==
X-Received: from pjbct6.prod.google.com ([2002:a17:90a:f586:b0:383:bb4e:85a5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c45:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-392822b7b78mr3666061a91.8.1786156044907;
 Fri, 07 Aug 2026 19:27:24 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:06 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-2-skhawaja@google.com>
Subject: [PATCH v4 01/18] memfd: export memfd_get_seals()
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

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/memfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index abe13b291ddc..c489b55df3bb 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -6,6 +6,7 @@
  * use by hugetlbfs as well as tmpfs.
  */
 
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/pagemap.h>
@@ -309,12 +310,19 @@ int memfd_add_seals(struct file *file, unsigned int seals)
 	return error;
 }
 
+/**
+ * memfd_get_seals - Gets current seals on a memfd
+ * @file: struct file representing the memfd
+ *
+ * Returns seals if file is a memfd, otherwise returns -EINVAL
+ */
 int memfd_get_seals(struct file *file)
 {
 	unsigned int *seals = memfd_file_seals_ptr(file);
 
 	return seals ? *seals : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(memfd_get_seals);
 
 long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
-- 
2.55.0.679.g6767b8d81c-goog

