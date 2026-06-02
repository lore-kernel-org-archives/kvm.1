Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DD3B3BF4
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437369; cv=none; b=Vhhl0RSdPaf6PUmqZUZbffGRW4kSeS/ygCoi8a29MHtZOsCQJZIXby9Yn7yOvElPZ8GruZT92/qeDVMk94wf70jD1ohPVi9SXvYpj+gj71TWHxCi9DluRKQ9kfO5Jhd8tt3T3Z1APbk0ZiZhVHMkmjXVDiXAvTLt58zUdysXb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437369; c=relaxed/simple;
	bh=lKnN7DFJZ1CI7P/ecQkLCNO048bsr9CmYWTgdYN3YTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o0bpa8/PuMUogIuUKwT9hwemqkCNn3JG4QAbR4V56dhSKQG2vbU85hqECKqR1k9d3vh6PC5aNs8IT7Sp5ul4rgS1+GiC7/SBeQ3T5+nDzfEdes9HaY9q2AmGiIooMSZefE8JVDB8tWgLEd5KrjH84xgG7oNagVtv+iJJ0FmdXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvVWIgnx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvVWIgnx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2f19558so2038751a12.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437368; x=1781042168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZN9q1aHIL9jEfZ2MGsblaqq1tdWrGmvs3WWbS54Ns4=;
        b=DvVWIgnxsyNuzketKi/SgKDhpxcBt2BnRyiG4P836sdHvzEPQSRdOqE2rOur+ij+wP
         ENoNtMivk8tmSIe7hUMc/M0gk7zCve1merDV9vd74wWwTOxN/SBe5NeMblrJGnYVL/gv
         yCcBx2Y6S77F9oDqOCxAl8vMVnDXlzTFrNIEhA85bBj5KR6yYrY3VEgAdW1COaEwHyED
         cE5a+BeoCbrzLda10q2g3pWQ8+ndCE2d/EtRwc3RRTbJZxeIYO65pTx28WNiyBZlZAOA
         HRRm3Wlv3WZIh2RSK12IhkphJZfr3d6cGEugcXeAGxhrO4/Gr3W9TegBGBOSBVe7ME22
         CvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437368; x=1781042168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZN9q1aHIL9jEfZ2MGsblaqq1tdWrGmvs3WWbS54Ns4=;
        b=SwXYglkK081W8r7aapjZuhjEJo6rqlePpYgW6qC7yLVJBI9hHp7qPKVVM+8PBolHyp
         6NRxGp5qLrIK+VGueCPypPf8brq2Vqt672zWQCh/0JBVogjxjKg3TRHw2DjZkQVwW7Sk
         3uxF+Gr3FTZLEqG0LIjrevvs/beOJpj3rcbanpPE4ub5OU2uFBT1klBpaFGAJyI/lukQ
         O8JZrrTVg+/Z3mRP1h8IjzI89nRQcTIs7rSVdp5ei5j6uUbYV8Ftw0j6OLnLlV+gQpop
         U6H+RXSfji1QKxmIzybGs7cjhjRbTpS5JjU5Xs5CYbTTTH3BjHGYK7R5JW/H+Lj5Ty+l
         A7Ag==
X-Forwarded-Encrypted: i=1; AFNElJ+ff5CuXty2VikH6cQBPlnQBySkEAMQ4P6SUfafJw11YSspzshitW+/INSoXRqfu9FIf9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZuUeGYOWSNOUPdhjR/LMkhF6YRuL21HZ5OgPe0Xgn31hlW51
	4HYPYy2KSCWA3NGgAkZn4NNgvVm3QsYqGr+i5NfoGr9tXkyOW/Ct3GNnq5trVXlqMTRTu3jwCwE
	Vw/Sz5g==
X-Received: from pgip16.prod.google.com ([2002:a63:c150:0:b0:c85:735b:ca4a])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:86:b0:3b3:241f:66c6
 with SMTP id adf61e73a8af0-3b49798aa66mr679970637.26.1780437367409; Tue, 02
 Jun 2026 14:56:07 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:43 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=1598;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=lKnN7DFJZ1CI7P/ecQkLCNO048bsr9CmYWTgdYN3YTE=; b=rBFtlvQ/7oSruMlAmmH25URviunGUIx5ao2QShrhRD8hR/bXLQAXAsiiyW2j5GrH1cgJI/Yfg
 qeemVXBKeqQAGqv0RcyXpSDAWZQbBi9Qjq/DWMSLzr8eBsxskS4WHVg
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-3-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
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

To align with the definition of MF_DELAYED, update
shmem_error_remove_folio() to return MF_DELAYED.

shmem handles memory failures but defers the actual file truncation. The
function's return value should therefore be MF_DELAYED to accurately
reflect the state.

Currently, this logical error does not cause a bug, because:

- For shmem folios, folio->private is not set.
- As a result, filemap_release_folio() is a no-op and returns true.
- This, in turn, causes truncate_error_folio() to incorrectly return
  MF_RECOVERED.
- The caller then treats MF_RECOVERED as a success condition, masking the
  issue.

The previous patch relays MF_DELAYED to the caller of
truncate_error_folio() before any logging, so returning MF_DELAYED from
shmem_error_remove_folio() will retain the original behavior of not
adding any logs.

The return value of truncate_error_folio() is consumed in action_result(),
which treats MF_DELAYED the same way as MF_RECOVERED, hence action_result()
also returns the same thing after this change.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..fd8f90540361 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5207,7 +5207,7 @@ static void __init shmem_destroy_inodecache(void)
 static int shmem_error_remove_folio(struct address_space *mapping,
 				   struct folio *folio)
 {
-	return 0;
+	return MF_DELAYED;
 }
 
 static const struct address_space_operations shmem_aops = {

-- 
2.54.0.1013.g208068f2d8-goog

