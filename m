Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511D364042
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122515; cv=none; b=EENgL1n7o4hG2y3HTa1Y3fMrRTcE6I5hs/ORt00v5KuBjkVOacsZkHGTzEg6SQAtcwca/azYy0R1yKIOgtdNg2yFVtPw3LteITWKaMNRdaQheVGSZrF/jEHosCkpHKkK7JCplNc5jfiQOG7UW0JQiiT4K9PIaH08Eo198HEwRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122515; c=relaxed/simple;
	bh=hncVUkOBSjCSge9NF4UibQdahRu3NGfGamSBeSw65MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aegi8SkW9Fs9xq4tpSMLmqrAxy3SZFP9rqSrj7UrcUNRfRo5+MNP+Wa/AOyB5P/Y9itD/cGIclJO13QqYGsfYFOAp7N8vqsGhgXFWqC9EdNhz5Give4bmk6KPeWEAlsb6C7jDREYDwK7pnmvA4Q5OpqRJAMFKhKbwLe2lJiLnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5/I5Cpk; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5/I5Cpk"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-46067399d5dso2130930f8f.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122510; x=1782727310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAXfb8BCSbPGPrK7X9VVeT4nqNdHAMMoqJF1QOMo6js=;
        b=S5/I5CpkLRg5FHT6nRr98JsfLlttCfKhvk4+sGvLBo8cDoGMPAuKYnP43atRdYTutC
         57yjiMS1Cr+pWy52ni4mQNqP1goFYm7FDhP7cOAEs4D/+xIfw7Z2zOJ7BjR909OvC/Ne
         AkwnS2+PzgyylT0e/p6BhBcdt1+heuqQ+YXSn5ROlcEjifDGK6aXiCGxcLLtP16P1miQ
         DCk244RL/oUwjpaN8mSix1OencF0vxrn156wXbwZzeCLNoX9yRH4bDi1qwh8Q2KanrsH
         hZXacszJUPAce7suZLi9VWzlm0sL/QwLQz0NOR9yL2oXl+ekP8KjxtF+2JoEY3qEjGP4
         DrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122510; x=1782727310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAXfb8BCSbPGPrK7X9VVeT4nqNdHAMMoqJF1QOMo6js=;
        b=dIJUGd/dN1a0sKD78IToaMAmXTaehAyamb5p89ZdtfE2M00ISm5XM1kUg1ZAKO7YkO
         MnKPV3LQDW7xe/5Z64PLJgv0v/zotfvgsu9M4S0Of6XxOdV5X/InD5TOFgflQb+yrI3U
         ULu/R1TIJWdA1xRsDi8x5cXODAEBz8oMWREVCuWkiPs4NXMH2FJqcGdtOUu6fiu5FEUj
         YOYKJ5vaTJ2qTfAUjR7aviiJ9wOxfZNtkWgfuEAIcG8xNKkVUHAG8OxnPtCBQL1AVCrA
         0FLIGpdvjs7ZxzyDm4KHBwALSGhHEx+H1/uHaERKkRB4GO5iU3Ref/j1S67XfpTufEPV
         AENQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X61t7Ho681WCyAkK4TI06fs0EDAbDkuFVDoVyEuHx0F8w0qmPA/T12vGMjzU8afrLH68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVhWPAjBvedvmjnyBztmfbZTX8uGp4SoZXfAm9k5My0Ktk4i/
	GIiMVoNL7jwP0l5C+QBFJhqy5gUUQWj68dLa8ASyBamvlErrO7gTVndBda/01eNOwgngw15jEid
	DEdVu9yGbL3rIFQ==
X-Received: from wmhj19.prod.google.com ([2002:a05:600c:3013:b0:492:463f:2524])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8653:20b0:492:488c:f627 with SMTP id 5b1f17b1804b1-492488cf6c8mr100943345e9.11.1782122509368;
 Mon, 22 Jun 2026 03:01:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:33 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
Subject: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Assisted-by: Gemini:unknown-version
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428e..23ba400b30eec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2994,7 +2994,7 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	struct page *pages;
 	struct vmcs *vmcs;
 
-	pages = __alloc_pages_node(node, flags, 0);
+	pages = alloc_pages_node(node, flags, 0);
 	if (!pages)
 		return NULL;
 	vmcs = page_address(pages);

-- 
2.54.0

