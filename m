Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E563D4137
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081958; cv=none; b=TNy3hjas5lTxOvbmB85xUDpX36ZTeNb+ticfoD+1WvdSOgD8xXhSfaMjWysqTy7WHRYP25V16ldsaUOKNjV9bPZ3k/eWsbtNhwm2z1J21mZjFUyGXArrhMDTG933Bl5LE2/JLZm2IATls7n8E0FFMrhdtEeA/Pa8nTKUX96Sa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081958; c=relaxed/simple;
	bh=Q3JRniqkyMXg2dBXWW+1anuwJps6VyhynpsJv8q7DjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHY0vGS0Ajcz/Bo1mZ1rIQzvOoXR5NPAioTR8PPW5dwD2QRtWxunoCFafX+HpzEGp62OK7w34H3PqermOxqesYEkI/OGnfHzqiKklBG8PTKhCC9vYdpMAjcWrzwgU+DPZTV6yRPqZfMhX4PMFnDO4aqGYL6aWh5PjQozCLFVQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc2ZlDHl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc2ZlDHl"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-492714d002cso4043475e9.0
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081951; x=1783686751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=jc2ZlDHl1DoTzA5NWs+cZjgqs6rZ9FttM6+fE3Coj/w05AiROyouQm9uOVWN/to51W
         jZetxFNchJnMxF7SFQul3+7SMP4pENWZw2uhiyC8N4VksAvlEC0iNXi1cjlezBf++d5f
         weIoFQhGfgL5J/zg/H+Gi0HhNLlvGZxwrAui8QzR/S/ECBgXKlp+3HUXgq5jmj9fZKnn
         1QneWE+SLSEzEGr+1cdpTiHGTZh4uIrCDj188DHWS+95MUFeTUL9MxXd0W25i9zll28u
         22PAs8zws/XQBnftMJ31JbIgvuS5UryJ86/s+f0r8auu0pnJ12ghNRG66eou9KhCsb/P
         IF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081951; x=1783686751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=F9CkNTbHkO3ln65FS5phf1ZxB64iqccCfm2H74wqt1iVU8fbbFjFO4vWj0avJa8wdY
         RpgGmZnA5GjJC0WtsrD16Gep82PlqiH3kdYRPSV1QVJPL67R8JFbWWn+3+2ue88E7kMS
         WeyWAM4PDRoXesZ8D1chDB70ZbkBvpAp6240EDuRgEFY8wqAsogFaK0rjZjwQrBqYlYq
         fWl8oMxgITFsTmdudOa75fcZLlcrrO8e117q7tMGCTQhaeoDTBtcf+QpFjGU31Nyqbpr
         kJd0dyX/kZhpqgFAy2Jrugiu3jx3vUeW/FjHt2jkP9en51Zr6hgocfDsHIcp2q1Y+dpa
         294w==
X-Forwarded-Encrypted: i=1; AFNElJ/M1vPPAPgjNMwZkiy1eMWUQ6hNPT+XIxGg+Dv8iY/7Uz9lR8lBLU8Y9tcKMjmH2JR3jNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCVGadKw2IYVYhQbaPyMsVdMTiN2fZxbRSyeL+1PUFGa0eRYo
	c+HO4AIc9/J3sm09c6YmM31VZrywFgIGvHvGgp+h7pk8fCq3WfR0/M7TMgJTZ1Oeb9G8gESfthH
	USbiuyc0DgVcrAg==
X-Received: from wmdp17.prod.google.com ([2002:a05:600c:5d1:b0:490:b2b0:c4aa])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1991:b0:493:bba7:e9f4 with SMTP id 5b1f17b1804b1-493c3cf2d58mr138687005e9.18.1783081950438;
 Fri, 03 Jul 2026 05:32:30 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:49 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Subject: [PATCH v5 09/18] KVM: VMX: Use higher-level allocator API
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

