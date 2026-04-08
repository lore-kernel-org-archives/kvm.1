Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5434DCEB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669175; cv=none; b=cVqviOLt97ojQP6rk36XHx9Fj2e0ID92NAdbFWFSRoig9nNnkOR3W6+78VmhU8CC4XFR3KVJbIv72Oqc3t2yH66ywkqOMZVIgZECb/aNBJjk+JLVS+eldEyvPyinKyNY9BNRr74RcfDiZN6dO9RApwHN2yBztehWIOvtN3csqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669175; c=relaxed/simple;
	bh=ko2N+a8bmW24/l4K/at+f1QHh6ITswHFEAcwikZm7g8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=phiXiHsl3lOC5kZKpV+cQyqYkSm6xZMhxHVLb69JC4rtQ51YMwOooAxTgNjCJDR3hRdkSnhfEqNskFAJyR+JQo2p+49C+A+4FSGgJvy33dQ9zWIpDbA9X1dDIVa8sF3Ys1GDTBylv5hgmDE5+AVDUC0FutADewCdOmEq0FOX7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOqJhO9M; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOqJhO9M"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242062308so2176625ad.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669173; x=1776273973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHYp8i7UG9LnNHrv4AlFKYXMB/HImkpdvlYCa2u69A=;
        b=aOqJhO9MvY2+lVizoNWvmo9CmAb6H0Mf/FePghLYJ5p8VhX55Yc0qmBnedRc6w72Os
         FiifERRatnO5PwBVSS1qr7HHAI5guMT4KhMpuboOGhdA5BF/sbnkl/uaC1imBUC+CjkW
         /cxo0frtMyznTBovnntgJJcsNucKGsVquce7Phq/Fhf6tMZfANNMm8V7Aql1CPjDIR/c
         cV7mgLITMKFOuCPdBGvt1PjChrf1BGojwMiHBgje/hyam4j6z2kDZzE6hh0u601mJH44
         P5iGmQZY84BgGp52QabTYEi5wvWw51emcsx+6b22ClcgPFS6efpCgncx90wMASLtgpF8
         wmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669173; x=1776273973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHYp8i7UG9LnNHrv4AlFKYXMB/HImkpdvlYCa2u69A=;
        b=SGhWYx3RZzXJEc2HEQ6fzQKBoMIXIV/7ob2Ryx6Eg4a+goTbhqqOLzHWsz2SkwrYDQ
         QjwS0hRZtWPvAZ90eyJZYobPB9tdA7CF1M4lXi8+TdI/4yvOdrAU91cM8OEdMxlrxgMU
         tys87uC9nK8ogLUEmKFub4QoPqxpxBwRzsYmw7+u/QltbGWQpmvbC6Kc9IB8S5LVMJD8
         EmZNNoQPn1VjIQeu3nRebX4rKgtF+/NCjK7QViwcC+1Qb5+Et8g5kI4wWOHfJ3eBA+3e
         HPLZUuAfRAbLoSGywqex5Hmq6cRwdAYpUx/j0hJBzmTXC+l7u8IKez0TaD3yvT46Vr1a
         8jVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL5DPcurdHG9mkJLXhhyZJo8G8fqExUwScT/Xhz3CbF1+EA46yR7CJ5JtzsiyTte8s9wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEUxgpCb3uRhBA3owm8dtvEefPlsZmzdhtgm8H6ecN0Y5ytUI
	si/O12C9Gxut0Nd3tT3iMv5oIm9o3WrlTOKlW874av2qHXTaIjtdrhWxDRrK1tpIfwSMghBtzzW
	U4QCICw==
X-Received: from plpa9.prod.google.com ([2002:a17:902:9009:b0:2b2:45d8:c606])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3845:b0:2b0:c451:ae8a
 with SMTP id d9443c01a7336-2b2818521c1mr229989525ad.13.1775669172881; Wed, 08
 Apr 2026 10:26:12 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:43 +0000
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=1569;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ko2N+a8bmW24/l4K/at+f1QHh6ITswHFEAcwikZm7g8=; b=746PglFeH+OYu3l4MYzApNvi5cX7gmzFI+EH+QoQQGSI/WNdWDeTfTggu2aYEOF1AvAm4+CiO
 zbTdbLNvjMSDyUKybAzt3rRp24Zt8lyV82pf0BtA3Q4mEZHunp1EjUN
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-2-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 2/7] mm: memory_failure: Allow truncate_error_folio to
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
 mm/memory-failure.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2e53b3024391..fd9ed2cd761d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -941,7 +941,9 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 	if (mapping->a_ops->error_remove_folio) {
 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
-		if (err != 0)
+		if (err == MF_DELAYED)
+			ret = err;
+		else if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		else if (!filemap_release_folio(folio, GFP_NOIO))
 			pr_info("%#lx: failed to release buffers\n", pfn);

-- 
2.53.0.1213.gd9a14994de-goog

