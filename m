Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E282F16
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951722; cv=none; b=H5vx4cvL7GjhWKvcpQhaqLBDDw29LAhmf71GpKTkrpBqlJjHaUwXaIlYi/MCnJ1ZfGgmXq27u7AsTbt8xyfJyaNGB9FJL3fGfannOixCUcWhJ7w+5Bem3s2tlL5T3DHPQ/4QJY2T4KACfgsNaflN2J+YWEfGVLxtDyyUhxHvlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951722; c=relaxed/simple;
	bh=smolpSPLyRzt3C+D1JHi3AqucD1pUoZl1tQGGaZ45JA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XUITyT1dITCJwGnhfDGpsrwb1+FlYY3GvufCvyQI+Lvogtmf12kd5Deo9yfwMKJgu5+cn30GlTauqlA3vkkycWPahi5JVSTkIZZMzXPnSa1oMvCwGp3fJabPmWeafAwf0SSh+0heijYsR0sn+k8fsuz3RAcg1spLN1IKAWw9s34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDAMdGij; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDAMdGij"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9336581a2so45129605ad.3
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951720; x=1790556520; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rIYSaUxr2dmbQ4fWz0MikFLRE1YKdMT0WLnLm0z0eI=;
        b=SDAMdGijtguYAtnSMOHATZqLSgU6Pc72BPWLuWQVRa0bW1T5dFdDo2iB4ZikDOFm/O
         6O1aSdIZjjM4VMNwn2aCNJhHMwQ5ZoJ3eOJfjuXrhvrtgw1FQ3uSUfLF7Tw8oE14T/3x
         JzYx81cxXbHqd27Q+Lwc4rHrPipxAx2LuRd77RvVbcdJU89MS33s8aGYB2+j8vTVMeK5
         H73js2scbKmCoybbipl1ffOjejiMUKYYNx91mS0fI/S5/jxzQB9rOmFjI3fupwaDAWBw
         id5RSE4Ml0niI0KWLWGzN7pY28g3gnrmKnatG7xbLC7aDw3d5MuOg2kjWI3mJPCwYV36
         JzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951720; x=1790556520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rIYSaUxr2dmbQ4fWz0MikFLRE1YKdMT0WLnLm0z0eI=;
        b=EtRG0Eg7kNNh8+6tvhC9otnYn7E8ILyucpQPua/J6o8uV7nTs8mlO7mYVGfEIFkVqZ
         6gjBO3cR9+2IdqBGcczpQUdYEPW3M/v5XblfPn7BAbHU2X0bNAGQWLB1qrmOOaOYYaiv
         UEBEoVhul0qGw6z/4BghKvn6RdoiGmBVTkXGLogSWliQZK+EMXvKROnv7ueuFEg6Dexy
         5TqW1UGaFbOb+ArmyUGPXyN0f3BPAPDjNY5ODLqdDe1kxWzEG/Co8Tgq8viQFv5OjWmE
         eyFsxqPqs22S0oaVgIYzBoauxvq9UeKKi8YqmUGxng49xENoXH7bPBKZ8NGcjbnQg82Z
         RHmg==
X-Forwarded-Encrypted: i=1; AKwUvByh+ktJv0Zchzd8yMd0CAAtcw5yP9tnikka74brQv1ZM8lxg1ehxwYrKUKqnEROW0ZgsYM=@vger.kernel.org
X-Gm-Message-State: AFuF++n9ana6MsFobAWz+g/PDpSMSETWeOFMQJuF1VkpRLDvgFiMwLGX
	ApQR0XSTJDH7QLPTJuom3QPwDFlKXEqmjV/pM98rsjKp3Oqa8/UscGEtEhh4HQk1s54dqqihb5S
	Kph4EdilhF+kOTg==
X-Received: from plld8.prod.google.com ([2002:a17:902:7288:b0:2dd:1e7c:bcec])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c6b:b0:2dd:c100:9433 with SMTP id d9443c01a7336-2ddc1009c3cmr88814875ad.49.1789951719834;
 Sun, 20 Sep 2026 17:48:39 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:17 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-2-skhawaja@google.com>
Subject: [PATCH v5 01/18] memfd: export memfd_get_seals()
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, "Pratyush Yadav (Google)" <pratyush@kernel.org>, Ankit Soni <Ankit.Soni@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
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
index c708d92533f4..888ccf3778c7 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -6,6 +6,7 @@
  * use by hugetlbfs as well as tmpfs.
  */
 
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/pagemap.h>
@@ -310,12 +311,19 @@ int memfd_add_seals(struct file *file, unsigned int seals)
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
2.55.0.1082.g2b9226bbc0-goog

