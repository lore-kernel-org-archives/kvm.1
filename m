Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3D1E0E14
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000292; cv=none; b=qd3v1+ZiZ419MbkD1FJ1nJ9baQfhFCZfxOU5oz/2oa2NaMqV0IPEHlJIujcmotW3XLHVIeuYp0L1HKOMTEik0u1si+ZATH6zJ+u5R2Z970C7q7jDNvAMmIE+qMg6oTg0/+rglmTRAz5kHazrLyl7tA3cAiSKYaRcbAd2Ix91OS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000292; c=relaxed/simple;
	bh=Rv/fkaKjqZXBKAzecGYXOSHJhPfhRyYr9BpLAp9kdqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JKOH4n+tzXhnS0YkXELeCZ8iKHli0/FpcDKLBHu5KsjIsDhublv5+pNBfpEzeAJr14hWmeHC3aPkt4eavBVEsC/1iaSc1io8X2w+TVFrH5mXICWKjtlgxx/nRnuJxjI1W4V8uON3nFiLNLuel8jlOa9ylOJBh1BzXrJeGKeZ+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEwi3Xg6; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEwi3Xg6"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so93608385ad.3
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789000290; x=1789605090; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvmU+MjUGFaoqjWOY3jG9f7Ny3ODqzWI2t6vRNXu4oc=;
        b=cEwi3Xg6FG8yJkhKVXkXYK/+ySZ4k9D7Q8NCkAGCM7zsfqtEwoVshNNxSOCDPcFuNj
         K69aIQtTnaEZ2ruxFUdmjX1mW8A7lqeOVzh+nhVut50Blgc93JwhdnwyYEF/znyoaxD1
         Pyf8ZpjYX0tgRhR8fus0V81gs559mVnLIet8BSxHBgYaXdNC5RuUoxjpl0kkC0owWiqg
         AkHIG19Y1jSltDxwK8ER8n4J9LuoDLxkq9FuvhoLBxzg0Ek0W78zfsnvm6pOk47Pnzkj
         MwFtDmKfyo+UDB/7Of6LJOXGOhgWbYyKqqW7psIOuzhoWwZvSPMNh5xqrn9phwxbeqwb
         Mi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789000290; x=1789605090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvmU+MjUGFaoqjWOY3jG9f7Ny3ODqzWI2t6vRNXu4oc=;
        b=Qjtk8UlHHJIRS3IEGuKmdzLpHo4UfPGoaaK4ivoxzqwDYvX3r5YO6xfaanjPFa17/Y
         MyS3hlN2WcyP/1iMqa0qW6wNpXHj/tjShHhC4zd2sprZqSa2PdxalfxJFXSCfvCbpyCW
         jsqq10UXFWuxAbVaagiPjOs6Z/RIK1taKbEsQlsmFcvSxJkouh7ExoyfyZmMdAmkPz95
         8FLalTUc208uf1rWlczJDCvWktzmMVyltPM6gZfSQpGqzO8o8NoD6IaTxqTZ1DyCMXHU
         /cD4r6AK4GLzGDKgeDuZwV2+R9K4Mq2SXzQYzMo31QNRZBtBx2uDbujemMg444o2sjFe
         MZSw==
X-Forwarded-Encrypted: i=1; AKwUvBzp7FqYpdCw00UK12fHQQMLGKAY98HwoqdMeH3xAS151yXGbEJPk/K1xmsFdJ+GX6rjgCU=@vger.kernel.org
X-Gm-Message-State: AFuF++nv8C//zNsiV6VxP3eVkrVY7Z9Gbeg46xgMP0WArAZP7hVRR7zR
	CUe4Wb69c1sETbGrSMa90M/45JpEfNKZKq9hn+G67ZGDkOS9FIiYUua1T4gV8Z+njIIwIJz6XGw
	B9f4CEg==
X-Received: from pjbce15.prod.google.com ([2002:a17:90a:ff0f:b0:395:1a86:4fe8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5246:b0:39a:e983:d4bd
 with SMTP id 98e67ed59e1d1-39b262a3cf7mr61444800a91.24.1789000290319; Wed, 09
 Sep 2026 17:31:30 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:31:29 -0700
In-Reply-To: <20260908120133.2381-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908120133.2381-1-lirongqing@baidu.com>
Message-ID: <aqH6YcHWk_GmJlqF@google.com>
Subject: Re: [PATCH] KVM: irqchip: allocate routing entries in chunks
From: Sean Christopherson <seanjc@google.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="us-ascii"

+Yanfei

On Tue, Sep 08, 2026, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> kvm_set_irq_routing() allocates each routing entry separately, so
> a routing table with thousands of GSIs needs thousands of small
> allocations and frees, adding significant allocator overhead.
> 
> Allocate the entries in chunks instead: each chunk holds up to
> PAGE_SIZE / sizeof(struct kvm_kernel_irq_routing_entry) entries, and
> the chunk pointers are kept in the routing table so that all entries
> are freed together when the table is released.
> 
> Each chunk is capped at PAGE_SIZE instead of allocating one array for
> the whole table: with nr up to KVM_MAX_IRQ_ROUTES (4096), a single array
> would be a multi-page contiguous request, which is what tends to fail
> once memory is fragmented. Page-sized chunks stay on the normal kmalloc
> path, and a failed allocation only costs one chunk. The chunk pointer
> array uses kvzalloc_objs() and can fall back to vmalloc.
> 
> The last chunk is sized to the number of entries actually left, so a
> table smaller than one chunk - the common case - allocates only what it
> needs.

Please look at Yanfei's series and help come to an agreement on how best to fix
this.  I am trying to get to Yanfei's series, and normally would take a close
look at both, but I am extremely short on cycles at the moment.

https://lore.kernel.org/all/20260525035242.107264-1-yanfei.xu@bytedance.com

> 
> Measured with an eBPF probe on kvm_set_irq_routing() on an Intel EMR CPU:
> when a VM has a 2000+ entry routing table, the time spent in the function
> drops from about 700us to about 300us.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/kvm_host.h |  2 ++
>  virt/kvm/irqchip.c       | 62 +++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92..83848d7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -693,6 +693,8 @@ struct kvm_kernel_irq_routing_entry {
>  struct kvm_irq_routing_table {
>  	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
>  	u32 nr_rt_entries;
> +	u32 nr_entry_chunks;
> +	struct kvm_kernel_irq_routing_entry **entry_chunks;
>  	/*
>  	 * Array indexed by gsi. Each entry contains list of irq chips
>  	 * the gsi is connected to.
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 462c706..044b831 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -18,6 +18,9 @@
>  #include <linux/export.h>
>  #include <trace/events/kvm.h>
>  
> +#define KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK	\
> +	(PAGE_SIZE / sizeof(struct kvm_kernel_irq_routing_entry))
> +
>  int kvm_irq_map_gsi(struct kvm *kvm,
>  		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
>  {
> @@ -107,12 +110,14 @@ static void free_irq_routing_table(struct kvm_irq_routing_table *rt)
>  		struct kvm_kernel_irq_routing_entry *e;
>  		struct hlist_node *n;
>  
> -		hlist_for_each_entry_safe(e, n, &rt->map[i], link) {
> +		hlist_for_each_entry_safe(e, n, &rt->map[i], link)
>  			hlist_del(&e->link);
> -			kfree(e);
> -		}
>  	}
>  
> +	for (i = 0; i < rt->nr_entry_chunks; ++i)
> +		kfree(rt->entry_chunks[i]);
> +	kvfree(rt->entry_chunks);
> +
>  	kfree(rt);
>  }
>  
> @@ -170,9 +175,11 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  			unsigned nr,
>  			unsigned flags)
>  {
> +	struct kvm_kernel_irq_routing_entry **chunks = NULL;
>  	struct kvm_irq_routing_table *new, *old;
>  	struct kvm_kernel_irq_routing_entry *e;
>  	u32 i, j, nr_rt_entries = 0;
> +	u32 nr_chunks;
>  	int r;
>  
>  	for (i = 0; i < nr; ++i) {
> @@ -183,6 +190,13 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  
>  	nr_rt_entries += 1;
>  
> +	/*
> +	 * The chunks hold the routing entries, so they are sized by the number
> +	 * of entries passed in by the caller, not by nr_rt_entries, which is
> +	 * the size of the GSI map.
> +	 */
> +	nr_chunks = DIV_ROUND_UP(nr, KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK);
> +
>  	new = kzalloc_flex(*new, map, nr_rt_entries, GFP_KERNEL_ACCOUNT);
>  	if (!new)
>  		return -ENOMEM;
> @@ -192,26 +206,54 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  		for (j = 0; j < KVM_IRQCHIP_NUM_PINS; j++)
>  			new->chip[i][j] = -1;
>  
> +	r = -ENOMEM;
> +	if (nr_chunks) {
> +		chunks = kvzalloc_objs(*chunks, nr_chunks, GFP_KERNEL_ACCOUNT);
> +		if (!chunks)
> +			goto out;
> +
> +		new->entry_chunks = chunks;
> +		new->nr_entry_chunks = nr_chunks;
> +	}
> +
>  	for (i = 0; i < nr; ++i) {
> +		u32 idx = i / KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK;
> +		u32 off = i % KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK;
> +
>  		r = -ENOMEM;
> -		e = kzalloc_obj(*e, GFP_KERNEL_ACCOUNT);
> -		if (!e)
> -			goto out;
> +		if (!chunks[idx]) {
> +			struct kvm_kernel_irq_routing_entry *chunk;
> +			/*
> +			 * A chunk is only entered at its first entry, so nr - i
> +			 * is the number of entries left for this chunk; the last
> +			 * chunk is short.
> +			 */
> +			u32 cnt = min_t(u32, nr - i,
> +					KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK);
> +
> +			chunk = kzalloc_objs(*chunk, cnt, GFP_KERNEL_ACCOUNT);
> +			if (!chunk)
> +				goto out;
> +
> +			chunks[idx] = chunk;
> +		}
> +
> +		e = chunks[idx] + off;
>  
>  		r = -EINVAL;
>  		switch (ue->type) {
>  		case KVM_IRQ_ROUTING_MSI:
>  			if (ue->flags & ~KVM_MSI_VALID_DEVID)
> -				goto free_entry;
> +				goto out;
>  			break;
>  		default:
>  			if (ue->flags)
> -				goto free_entry;
> +				goto out;
>  			break;
>  		}
>  		r = setup_routing_entry(kvm, new, e, ue);
>  		if (r)
> -			goto free_entry;
> +			goto out;
>  		++ue;
>  	}
>  
> @@ -228,8 +270,6 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  	r = 0;
>  	goto out;
>  
> -free_entry:
> -	kfree(e);
>  out:
>  	free_irq_routing_table(new);
>  
> -- 
> 2.9.4
> 
