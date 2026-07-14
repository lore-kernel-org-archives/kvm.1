Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B5432E84
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073419; cv=none; b=PGgiArns7JNCZ9hF46NmYBiQQcT+uG3xb/vsuzEBKLVn5Hyls57AePRZPAzDHJMn/TCE4hpQYQ/ZRQs5yc59rUt5yWJdZ7Zf/KcyfXs/EOe0dA63AbJuDyt/gGm39W6pPNltoVmR0v0iK27gcurRUuAUd/Woxc/Zz9GciEZCZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073419; c=relaxed/simple;
	bh=dGBZVspwzFI5l4pbtU1w5Mq4eYNTTQlm132+z5enHtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOZUzGR8Z2eWXm/vuksHSSMRalRopBu3GdwpvQqiNvHG7oNvM/EBcD6pbH2jlFyirDwLhIJ51BJ4mykvEQDAkNmrk5AyadQt5FGbTmY6nJu7bLIIsL3NOjTBCb28h6lGE6z05IGHCuDvJzeb1lzJGWEgypRFbgfG5urJuDSaYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uI+z2cJ8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uI+z2cJ8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84a3514f912so5041934b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784073417; x=1784678217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbJLIL9gmItiz88QD6tsHYBCJRJFmibBVJcjTpkBGpU=;
        b=uI+z2cJ8+b2VThhbuEwrFyhYrABCacRjAI4FlvSJfY4+LSS/39Sz+rR685JiMEjQQv
         oonMK5tQe5kSxtMJ/oatVl+p3Q4I5EDH0RCsugVSB1AUfRV20H2j/eh3EFGfH5U0XwM1
         h5u0+611zDLhKB3GafJUYxm3Vwln+H75u++pg9875L8sfOqxBUnmZ6dPKSzNDvx+l4Tv
         I5pbUbBrO3HZgm9O7PJT15fLyT32+DmgKX7nFuVnKhVXK5PFrwqOoeJ8zZw9/p9uT09x
         THVzSIuUMacn/TywFfxdTELSWFRMrp025FJwBz5DWH5CGqVNU5TKMKzgMgKYBK78yq4y
         BMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073417; x=1784678217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbJLIL9gmItiz88QD6tsHYBCJRJFmibBVJcjTpkBGpU=;
        b=XsQAb7WBvuyU28FA9V3AMOdPF7Gq5psfHteN7wW7abJ5XCdwntWBXwLO7iQUwrVk2A
         9vqjikC0IZDf+Fla7Kw+h5cEYyK5AnDaosMskD2sVMtlcO2Y+CJBKMaOWzeCWjF2SYV4
         KYSMljweVez2oWYlbgwYwtjZJBHUaYDeb7fPo0kwIToyIyGhIYt5sLYwL3/SCiOET5Dx
         /UTnHd9YMima68ovTUD5y4G4bb47HFfVmpMZOGLESXDt1ysVRXRGXc75ZOF1FniV2SqO
         R7ONqOl92weJGFD44tSk9/uvQsfcuiL+wLK/Y5wMbBx/QnHmi9TuLFrzMcAtZH1QPb+9
         iClQ==
X-Forwarded-Encrypted: i=1; AHgh+RriafZf5ZxqvbbRB9H1Re+I7WAM9ahQ3SBsfErjLED/bvtxQgwvvtl+0liOy4T4qutwEZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3uFE7O+MZnixkPcqPH4V2dDOO9IHFRYLDqM7o2YMtWmjXpl8
	uwhtCrlbubZ8BdMu04XYDefwqyaVnSO4osvqUjUpr7+iWPEAdhw1HUW7IggLWDL+auYqmkVc8Or
	+KeeQGw==
X-Received: from pfbim8.prod.google.com ([2002:a05:6a00:8d88:b0:847:93d8:2813])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e27:b0:848:87f0:ffab
 with SMTP id d2e1a72fcca58-84a5167760fmr5156585b3a.78.1784073416921; Tue, 14
 Jul 2026 16:56:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:56:56 -0700
In-Reply-To: <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com> <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Message-ID: <albMyH4scTHvEM0C@google.com>
Subject: Re: [PATCH v5 09/18] KVM: VMX: Use higher-level allocator API
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
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
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com, 
	Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 03, 2026, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
> 
> The former is going away and the latter works fine here so switch over.
> 
> No functional change intended.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Feel free to take this through mm/, I can't imagine this will conflict with
anything going through the KVM tree.  Or, holler at me if you want me to take
this through KVM x86.
