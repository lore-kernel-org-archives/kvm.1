Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A2407561
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963059; cv=none; b=TV7JcQ7rEzl7jMOkwJKh/DbJP4kRXmRmk8S2cPzbvEOBA6O1B1oQl4cwTgw+p1J1oejLtY3o4ZPkJhEaYVPnEj1xY3RTdVW5zF3o+LAs7jSkz/FGKHIi+b2+UX8nXsbAVrQ4Is32NwvOcJ2Poe1W5yMMZpTbohmMspa+YkkP2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963059; c=relaxed/simple;
	bh=bEQvMaA9O2hDkO+lF+QBqIJNJg07ecLAkODpS+u5iOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPLzMFAEh2FHphNgpFOYoaIIS5EMUKiZAS5DnUitnKM34D8watssugAny3SKRlUTKk+hyJ9Tl6RorkaRA/wfQ3mdgzS5Rlks0mAGj7vM3Z5aNS/48LVH1aIR1JCJayk8LFkOdBMPS0CYNarzzQtWQnuk2P1aU69IbdM/msTTZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9fjIFLk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9fjIFLk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c74262a2988so412606a12.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963058; x=1774567858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCMt2z1jL5wVFi5HOfim8vFneIc22rcNHAIsqy/Chyw=;
        b=p9fjIFLkzIR9Ae1HaRpzpp9b8NHcI6Vw0wSI/UiXheSo8esH6onJitFdhhKGCvkwzm
         IPi6lIJ7ayVRKIrTBVzrtynjeM0KibXi9SCbUwyoLkIKJE3ETh2JqlALrzt5EjmIgPMI
         vJXOTU0/ZY7Ema0h2mca3IpExQ5EqaE0vtG58v2hKehddIMG9f1QYy3+UymPMsdYI7rR
         tGi7EGv+Ly0RD1IiMNsTOF6EPyXRB6BCP7Ha/0f/roN0dqb1CrY8cUbBEKxf/8bxmT8+
         g2zbnMHJYqDwlRwnNKj26aZHpSfWLHi2Jx3mpv60wZ8viVtC/ATgfsL0ih3DlVbQoVhh
         GRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963058; x=1774567858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCMt2z1jL5wVFi5HOfim8vFneIc22rcNHAIsqy/Chyw=;
        b=b6HQRElvUfx74hV+vz8QrsvIq9XapoDyKZWSzojuwU9LYa085ptyJF69bNXikBVIKX
         Gq3JWr1LfPI+hQ6JxNJ+lCXW6wBZytKkDIzlCAyzDMlbSEbwd5zgj/MD80YYbrla2RL6
         ilHNOj42746P7mhRt8VNHPfE2JRXDwsjnrUxmuTBTNZqM8X/wjHV9E2sWY+3FogKowwm
         c91efzmXQGRbhfGDUJZdexQO2eRk6W1tOpZBtzAjEc3YLNJtptsgybAov+lZSPqwj8ZD
         awTcGZ7bGU3Qw9m+LdSKgh42BmMm342Fa28AMNxmdl3p1fthS0/+d3G0E8ANB7Y1hLUW
         M2nA==
X-Forwarded-Encrypted: i=1; AJvYcCUo/jQVey/8B0D3Vo+nf4HvOcPDD01Hq/CvHVI9XprWf8Dq8Nua28LQL0HcyQTVy2itc/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ip/07P3l+qcGQi7aOo8PEx0Qu4GnqCR1vpQoB0pJwFD7qbzb
	xzPmti7ybZyIxJjdasVnKjLJN3szPKWdX7YKUIP0AivZoW7qW8X+iEpj9sOX19qGc2S3AqZxgWB
	axNxwTg==
X-Received: from pger18.prod.google.com ([2002:a63:a012:0:b0:c75:bd4a:f509])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9e:b0:398:f1ed:7fa3
 with SMTP id adf61e73a8af0-39bcec301e7mr930308637.57.1773963057622; Thu, 19
 Mar 2026 16:30:57 -0700 (PDT)
Date: Thu, 19 Mar 2026 23:30:29 +0000
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773963053; l=1473;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=bEQvMaA9O2hDkO+lF+QBqIJNJg07ecLAkODpS+u5iOg=; b=13DaSlI9UabzaKWe4h2fh2HtJjjXwRHu/w4sC/PfYfQR83rUFlAnEp/P6cSUes8BAsTQjFGZ7
 scwG/rZVGLFDn5Cdb0QuA+zOHJK4OdPK+rIY+aD7esoRAD8+cY0a+dy
X-Mailer: b4 0.14.3
Message-ID: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-2-92c596402a7a@google.com>
Subject: [PATCH RFC v2 2/7] mm: memory_failure: Allow truncate_error_folio to
 return MF_DELAYED
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

The .error_remove_folio a_ops is used by different filesystems to handle
folio truncation upon discovery of a memory failure in the memory
associated with the given folio.

Currently, MF_DELAYED is treated as an error, causing "Failed to punch
page" to be written to the console. MF_DELAYED is then relayed to the
caller of truncate_error_folio() as MF_FAILED. This further causes
memory_failure() to return -EBUSY, which then always causes a SIGBUS.

This is also implies that regardless of whether the thread's memory
corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
memory failure with MF_DELAYED will always cause a SIGBUS.

Update truncate_error_folio() to return MF_DELAYED to the caller if the
.error_remove_folio() callback reports MF_DELAYED.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4f143334d5a1..57f7762e7418 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -941,6 +941,8 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 	if (mapping->a_ops->error_remove_folio) {
 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
+		if (err == MF_DELAYED)
+			return err;
 		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		else if (!filemap_release_folio(folio, GFP_NOIO))

-- 
2.53.0.959.g497ff81fa9-goog

