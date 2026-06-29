Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EB408611
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738750; cv=none; b=ExIiUZSy4N1TY0Ltshqcye+buPtua4ZWPGo6yhu/mZagnMm019vVkJcLqrJZ00l9pXCIPleNmi53c4bp5/0diJomIwDV/lT3PEINHfjSRkNwaFmbLHgINpoY++F/RQFdzcl4gqzjRfSHJIr9zUF3XZeThxq42W7SCr9y7skN034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738750; c=relaxed/simple;
	bh=hjyh8xXLpdU2ZlkvJiR4R+e+E3s6IerPWwVa/DPBhKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVXBv6GV/hMWtiHWyCxHe1+BzE7NAy/oC3rh3c4ZDNZ+SIakULCgnFYv3SDwKUkD1XgS8Mf/GgU6YdsJc9VshSeOKSCn1e9xvPXPWXplmQp0yHHmz0jjCxMaiAV5IH6LCLHPXTUZkBe0GJIq0voYDENSNB7ej2BDpdctA6KnYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYrIWieh; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYrIWieh"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-69605010d3bso3590078a12.2
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738747; x=1783343547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IRysh5TqTjmsvBmEr1NgaWZsZT3eifgrzLdKx/xP5Q=;
        b=LYrIWieho5HyspfdjzurWe54wnhZf7r/ELCMtoptHaGpcyLRyv334qiNKhkgWs155Z
         ylBoBNmUC0CExgR/uQMWjQGMYxJBTH465wRzW0GYcM9QlO15woGAunEGCfUzdXlL7TdF
         T3aEfnaBHE83vASt4ZP6bc5DGUsjfet464DH6tIW1n2/ogh3ZznNqGKWqKT/xHlpQqDC
         3862RY7+C6dmdQawYvQx/NQcWwAau2VOQm1nu/ZozVKS+0L/7e/MRn6IBDLGXO+DId7T
         OGXJnf5/biU46sA5kOgMNteaPBHEvMrJpn6An2gw1AxA93wmqZ0i+gMvSpk6D+ij+o4+
         19rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738747; x=1783343547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IRysh5TqTjmsvBmEr1NgaWZsZT3eifgrzLdKx/xP5Q=;
        b=ipGkVYlxFdM9m+k6E9eVtbhmYs9gzK7pKZ6Y/HxPMVNwuyEzBlef4uSCJuCaXg0dS5
         ySSf2WS3gu+UzNbg7fb27y+8snWzH1XTxdpF/b3jD5Ww4Wg1EvBCaE+CvJIaJR6WZg8s
         CMjeCaIQXkSsME1R+d/Z8CYxBII9VqTZ02ZwjU8f0pK+cWsKEzdVM/xrM5Iynx7spg6J
         uPixFcaIugWB11I76k//0WWCaFMaWmPBkW09Bvg/ivI83n//JyA8jt8KLE08giH6I3sM
         OTSawYzEbIfidAx7x1GqEA1ihw7X/ALbOVvf+02mT4j7IIK8g2qRYppmqk8Mxx4J0qT0
         1Jvg==
X-Forwarded-Encrypted: i=1; AHgh+RpzKwVrIxXQ/4Dp69m4wQmxbQ9LM6MvF6O7gO+khEbRO2W3Iaclk8bBfFwwqpWZX+/GOqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuyk6yHT+k/fmID7MnJG9B/wCHijKeDjcHC17itLk43AcRILiz
	7igqH9LbLJJiWRlyX9+zQJZyE0/Z0f/YFfhuUjZfYbWP82jXuXTogtAtym18zHGST0ECafcMcT9
	qIq0/1LTyPyIrFw==
X-Received: from edxu16.prod.google.com ([2002:a05:6402:650:b0:697:cdd6:b90d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5511:b0:698:3365:f950 with SMTP id 4fb4d7f45d1cf-69836552666mr4278172a12.21.1782738747073;
 Mon, 29 Jun 2026 06:12:27 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:58 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-9-57bef0eadbc2@google.com>
Subject: [PATCH v3 09/16] KVM: VMX: Use higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Sean Christopherson <seanjc@google.com>, 
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

