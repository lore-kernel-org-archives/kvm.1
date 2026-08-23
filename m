Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A53AFAE4
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514077; cv=none; b=Ywf22Z0bnGW7LvEx/1vlXwrmlTyd1LiQHj0eL5tbQZ+JmPGw8e/FLu/0LFCY+WU/mlO8t8W44blDF6wWuzydMz25WF19Ku/QV35Df2jC8pbsOu7p5G41P0OZBRIR8HEEZYFeSIe2BtarNBVFMVWQPsp3jHZmRQAV6KHV0w+Pl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514077; c=relaxed/simple;
	bh=DG04WuEmB+N8qtRetaF/4g/eNDjDsfwar1GsdNmj7GI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C3eOyzDoUWAdNwpUwR9+dPhuJcQH/CVZSkCCn/bokn2qsjjj6tM4EH57LKUpGvHV9lqCs6XP+4/OiOB0XphawBqhQZmAaVZcBVfKfwvlT1o5ujGbnBtHKdY6fKRilDhPTCqyPB4ac1FdM4UiFvERVT4j1Zn1cXRghUJG+WsCX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNXzCD3v; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNXzCD3v"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cd01a14e81so35622585ad.1
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514075; x=1788118875; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+OpOp2FYZHZK1eqhH9cUqizMST4EcGgJtULK4xaToU=;
        b=RNXzCD3vOko/nKExKIT86PSSNFlHNaSbGua1nV8lmeiK/azmP26k+liu4LINOC/bzJ
         nBKPV/ZUUhbzKeD6GhknYD1d2vHGOD+ITyEjhPGscpVz2J6YXIH7J1Z12fjyg1LdGTOV
         33X0vKZ2EqmkngQCWkP3w+EuP8ZawtSzfJcFJaV8I4zB1x66jrV9lHwaWQkw89nJ5SQe
         bizAEqJZzl70vpGWBMIa+Ees2+f4mP4ZU35luPcXZvpWOm3ix5Ux0CNjzN65dbBYUkZd
         LMUX4QjCnHYqlHP4n26D9F2I1UtelLuTgLu5UTUgv4e25Iv7XCfi0QUnxLWr0WRBrvAF
         5aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514075; x=1788118875;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+OpOp2FYZHZK1eqhH9cUqizMST4EcGgJtULK4xaToU=;
        b=nmkFMPCxW/51UuJmwPndXSDF6kEnNiFS2x3ZgJZc/r4O3rUf0pkrE7BMNbINnTIa01
         cS9EnBjwFrZ/mZo1BgpQxRodPjs0knA/r919Ih/JliH5O06gQojXqSzYVZ2rc55G2HXF
         bYKyHhRB7jTEHWfq2u/jXfwtnLFb8+1p4Z1UXaVgwuBwI3+lfuyCGY/tKsAsZN716Lmh
         Qv2ylXHOItRjaNwcjiJzagxW6l4tyuvkJd/svix4Enlxj/gOe5E1DluKRLkMgIZkQu2H
         pj/xB/+qTxiVdcuMnqi0k12t3M2HR+3Gq0iEmlOVyWCMeNidGHaSZ1E41AlAtfq5/FjS
         OPzw==
X-Forwarded-Encrypted: i=1; AHgh+RrkYo1veQLGkLxosmIWsznhKMmhgwATg5zBbzKlzXxEasagsiXVLteul93O59f9Ovn4Cqw=@vger.kernel.org
X-Gm-Message-State: AFuF++kHxtuRxgtc/hTzlDzgN0mWQX5zST3Se9d26SCcs50mxVB5gd6+
	AaXzReASAqX5tngQl0bYTHafptPaeXChKAP3C3i1Q3TbSSPUYTOYjpSRNpQBb5DklRtOT1F7Toc
	XR004ew==
X-Received: from plml14.prod.google.com ([2002:a17:903:184e:b0:2d3:7166:b1a6])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3904:b0:2c7:ebfb:618f
 with SMTP id d9443c01a7336-2d670d299bdmr242569585ad.14.1787514075026; Sun, 23
 Aug 2026 12:41:15 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:55 +0000
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=2009;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=DG04WuEmB+N8qtRetaF/4g/eNDjDsfwar1GsdNmj7GI=; b=l3Mv9NFzVojO4X30lik/YxnXTp8odsky55GCF49Ybs0TwqNB3EpJZR4IWtMFjUh+RZrz/DSlr
 kyCzx6aZvHqDNzH3hGWJjzxiWsVRAHFhzpzByW10l57CWxucdyf1HjT
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-2-d97a5703e45a@google.com>
Subject: [PATCH v5 2/5] mm: memory_failure: Allow truncate_error_folio to
 return MF_DELAYED
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
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

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in the VM v7")
Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e698d0e9711d..37ea23489b75 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -939,10 +939,12 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
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
2.55.0.766.g2966f0265a-goog

