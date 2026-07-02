Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACB4D2EF1
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985802; cv=none; b=CL7Ee4CIM/hcMQoMt3AUUoiQd7iuXWcAJ1Ve8nQwo5htlcle35rZRtKUGcCJCzgq4JsNefoCuDo3awaE5dlHVNFrIuEfaTdVRUnttQ8d8YjD/ZNrKDHRGxSe/wQ4ahXW5oQiDWVfmNPMscPrGjLNYREyiUKPJPBXWMOOJ0vLewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985802; c=relaxed/simple;
	bh=Q3JRniqkyMXg2dBXWW+1anuwJps6VyhynpsJv8q7DjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Php0DD/c6Qu1/j5ux3IOL2gyKGN29bOvsG/WGinihW6dY1mNH6AshBYciXtIi5MMqDZ0BoeI9a6/XNyro+Luxl77DjYY1gv7Q9XBrcAKxI4/u4CUASdIJejhdnLgfQyDkRjercgHoASFx2i2/B2WoOVgW3yF88/rkJKVbWdl/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ghb+4EaG; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ghb+4EaG"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so1441605f8f.1
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985798; x=1783590598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=Ghb+4EaGI3XH/NReZ0EPotZY9bNO6UOXHFjtqXyJykFX/ZUi/M5FghYdt5tgNVT/v1
         hcVEdJHzmBbYqLGssfIE/R5/7K+2wyuwz22D4P/H3tOOAuCLHfdeDBDgNdI1PqCEOFvf
         IM5ZgIYMJOC0PWOX6ghLagYpaB7iiC380u5s6mXftv+EyAdw6isOd47UairzwyJmBbPX
         wFhKBbeA0/go9i8Ps3ymN81LrrPYevmzAYpQO3zadg6nvGqkc6djVxlBemnChovAQDHP
         +ELi7EHSJU3TrpJOnRhum+WCiMzuX//xfH+4fwFrW8ynxfHa61N9v4mmhLwtWIoUiqZj
         9kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985798; x=1783590598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=OYEXKk9HbvPnwLx+onVzDrLUhYeCZYM7VeAYOpAtk3bzsJ3HjTZgBhvMgVN1AOwqog
         StHuRbZkjHfFkjVO28UMT+hFlUzJZPq5TbccH6SA5IIRR7XA8Uz5DNDpuIZ977RE56Vt
         gRHsTJeyC0soosMcPsdBzZyzjenjvuTMAsXn5Mth+YBHiTFXmTwQltuYJqwAaWg1Bnb6
         UMmcDEqxOxA6t9pGTtz7ppFPj7/DZiY4A+0SisQhgEDsoI0xsuhCMCr4GbJKtEMm0N9J
         rXe/Zk4pgdewDBSJtG35DiUtma4xP/wlTwv4QDKq9k25GykrKQqpUc4rh4eAaIt/DAIq
         CxFA==
X-Forwarded-Encrypted: i=1; AHgh+RrHPXYMZ5m55GS/tCrgEzypvjKcWS1Z3TMLnxLa8qZZra+yBm9KM0o/i8EJxzMqH6h5xys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEQ2etomjSyJDbFQrhCLLwo3RTbeaMwgoh+FStWUVC8zRNcNw
	1bYe3e1Gb8RgXtOJKHYX4DB+UNdZOE8K+lCCuYv1H2eP/y8U4yEO0nDT6ADRlXsjTGM61v+aw+t
	ejsfGKYDPuUjIQA==
X-Received: from wrbcg15.prod.google.com ([2002:a5d:5ccf:0:b0:46d:32b0:5fa4])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420e:b0:473:c18:f2cb with SMTP id ffacd0b85a97d-477af4f8f3dmr6971262f8f.18.1782985797975;
 Thu, 02 Jul 2026 02:49:57 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:40 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-9-0af8ff387e80@google.com>
Subject: [PATCH v4 09/18] KVM: VMX: Use higher-level allocator API
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
	Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	derkling@google.com, reijiw@google.com, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Assisted-by: Gemini:unknown-version
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2325be57d3d75..ad6a7fc6a54da 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3028,7 +3028,7 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	struct page *pages;
 	struct vmcs *vmcs;
 
-	pages = __alloc_pages_node(node, flags, 0);
+	pages = alloc_pages_node(node, flags, 0);
 	if (!pages)
 		return NULL;
 	vmcs = page_address(pages);

-- 
2.54.0

