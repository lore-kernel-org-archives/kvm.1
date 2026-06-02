Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46C3B1ECD
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437369; cv=none; b=cE1df1X4dR8SYbdLDASSwgtL1ltT5+83fIuTG4ysXYiR8lyh/4BGz1Cdhyj8NiQ6Ra3N3lCUYB6jNeO4yt93JM5MU3NbuJjILNddu/P31uTrDJr8/EDBHo8DCQKtuO/YuDnHLVao4mR8qWdUaWSn04k5c7MIpaM1f8RJJbuDTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437369; c=relaxed/simple;
	bh=5N67K9Z/FRb4/h9EDb/dnLOi0/eD6cgQqD0Ji0Ch9S8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/MSY6bWXtIb1ubVx6pOjF90DYkVBarE6mzeVIw45rW0oSxfJr3ECd0bgv03sMbgiClCrwcimdC4XBqAq6JO87MOq1KwOi8auzhngkjmf7uuc2icIXdvN0IQ51pVr0QOfXL9iiskP1d5QgedJT5VCQZi0HioKbmEap7Mdhuj0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sl/0/0KH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sl/0/0KH"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422382178bso2571200b3a.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437367; x=1781042167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr6YOv97JYHN5mxeGTDHXogTsZjg8n737cnMXei3iU4=;
        b=Sl/0/0KHt79BK4GkQ6Nv+ICqS3qDOXkVhLG1erz6ahCVp3VKMc6Yj4SSWMA3GHojfF
         hsNIeYRSzMY0O6vIvWwcNRVTQvU8lSHnReO8hnW2m3scC8Gh9S39mpckDMVkeUhDG0eA
         dSBed0mIA9C7R0uwNTUZiIioG4w/BhuhJfhl2q5UHdJQd3Drul1Q6Yg2FZLiAPr+9wqG
         QqI1lPOcw9t8sMnIMwnY9mX5TJ/+rFnb1o90MfEFvVpP3u3kpzb+LhCBUVmK+aN7vIM5
         bkKkv+oZT38qUcA7rYDzkKRctm2J5Lxpg4zCUNZMpBFrT5Atva4edhCbdP0pmEoKOkFu
         B5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437367; x=1781042167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fr6YOv97JYHN5mxeGTDHXogTsZjg8n737cnMXei3iU4=;
        b=GhRpmQelNwEv1XCE3b4FpHOWpPm9kXyGrxEn49oEfsz9k5U1tBPrbFP2YT9UFHan+O
         2uZGmSpZsmTYTQdwM7Rzcbs2qjpU7WfPFQ43Fkrv8sW2p8usGGz5HwM2ZfdmxfCJyHl7
         +jOqNDssYGlODIgd0GokVuqFCVDxPYZxOc7jn5n1caPTo1BiY36c4typkmXUrw/dU+4z
         gvrd3LvdvYyEoKW7ENpw5c2PYB8iMfT4O7uih/NugizwojMmRydRxBrJqG5QDQtt3YpP
         x3ElYKP3D1ui/vmXeq4GqNwdpCvrI/8mcqpTPjf6YWvtiMYuABIIxkQxJrbljGDm72gc
         BmEA==
X-Forwarded-Encrypted: i=1; AFNElJ/7i5nAwgycE8Lhulj0m+kZdVce9hZjckRJUNFm+cFAmoW3S9eZ0mrD+408/nQOp+A6uiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSB7IyP2Uyh9BqTYuN3b8WSYtBNoKuoHNkuZSuQrCcCoZY8yb
	XbO7yEjrwnyLqMa2AN4SPwCyLPTLez1Od+3JmL+GOM/VL5jrP7OyU3o0dWJhmTmE7ibyDw7FlDC
	D3tyGMg==
X-Received: from pfblc6.prod.google.com ([2002:a05:6a00:4f46:b0:835:4c30:5576])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2303:b0:835:4291:6978
 with SMTP id d2e1a72fcca58-84284eed054mr629183b3a.41.1780437366524; Tue, 02
 Jun 2026 14:56:06 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:42 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=1676;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=5N67K9Z/FRb4/h9EDb/dnLOi0/eD6cgQqD0Ji0Ch9S8=; b=L2txlDOSMZsr95mUVivDSrgEhoDq/mzN2uDs+L0Ji+lu2zWe5JuwFpcRNcm4/kttQfOvt/J4k
 N1cIM99c8fBCfTGaJcARyRhDonF5fnRnZi7h6lhqe8lIMDM6tkfeAqm
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-2-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 2/7] mm: memory_failure: Allow truncate_error_folio to
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
 mm/memory-failure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2e53b3024391..3aff0c981fcd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -941,10 +941,12 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 	if (mapping->a_ops->error_remove_folio) {
 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
-		if (err != 0)
+		if (err == MF_DELAYED)
+			ret = err;
+		else if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		else if (!filemap_release_folio(folio, GFP_NOIO))
-			pr_info("%#lx: failed to release buffers\n", pfn);
+			pr_info("%#lx: Failed to release buffers\n", pfn);
 		else
 			ret = MF_RECOVERED;
 	} else {

-- 
2.54.0.1013.g208068f2d8-goog

