Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356E33B6C4
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259088; cv=none; b=SjPvFDJ03x24XHsz/QNnQnHosM5nebgslzIIKXXNMoGSillu1FA91zlRf3J0OM16WHPUl2ODUmPxWTOL0XJLt3HIn8R8JHA7gG5SOKR4K9QPlDrvPJkxbRhKY83m4GmEiFWcumlGau5Hvta43r2+KpxvxIy4s3VzhI83EQL5Vdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259088; c=relaxed/simple;
	bh=5GLTI1YVUYZtvCouXNstUvvIgfVEYql2VP7c7YxpZ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3HFAadgqwoVgWu57depeaLS2/LAJHYKAk7s0x2hcaO0EQyqXqAeBOxJ+1QqtaGEJ36TRVejK+xCEGLfcsr/DhD7FOKBfFbehiw+WBepKQQWFn40BvoDPFcc7ANqcXoyjhjSoLyXXu45WsTbLJqtvT5h0VChwNgLQLWHGtV+8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed8DKmZ3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed8DKmZ3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so1934468b3a.2
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259083; x=1779863883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnvXF0CuyRLBiBRr+abB3DNPyLuJCLabLpPlP+A6Pmg=;
        b=ed8DKmZ3r9WOro4XDKkerEw5fiVIjEM/pzKKweYKQCy7JdKNkr2wtR219w7Dv+YdVy
         bMsTVJ5BUfnBTfxj2eRb7eVMyW2TGMyWUMj92cmiRaqc/e2Z7CIbjkPM+AeWJUPiS3V3
         uZSiySe+1dT9fUSb1z3Hq5lEUnTfcWFHnRk09HTVeq8s7gPZmOSy+FGwUq2613Ym1nkj
         Wc10+pV7kht/bG8BAmycZv9GMICTfIGZWigMS/jnI1bH4x0MmraQ56WOnF47ZKvHR9Xy
         Zlz728zIDS2pP9ZmenkHNF73YtpPbwIZgnP2HIQf24NVnkd3f/6ixOn8NLgl9ncnkrVL
         2ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259083; x=1779863883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnvXF0CuyRLBiBRr+abB3DNPyLuJCLabLpPlP+A6Pmg=;
        b=FOVIXDKkqP9hxtihdrdGlAZOBtAe6PVdP5CmOnPqJaLex+qHeA6klOLs80W06FazXm
         InEWp/KYXO+Kb50ldL8GKVAvZIeR8Y9rI92Q/VoL1FbrKF2yRZP3y4xDBB/UbDSqT7z4
         qupsY51URyfmJkiJyu/NFntgmv5SMzWR42NTh0/a8ln3ynNURsYjWOImq1ocyFW9v3SP
         KAeRaNilddztTyXI+a7h7hxRCzEGS63BiZ4LvopnCJvjgV84s6f9M4HhiyTlyJQ7NGRK
         cAz7zBo5IJhit+8eaSVqYyO8gYe1ns66idStzTZx/aKC9LRDUmaf1i1qCyQ1HzlkrlVl
         uzmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5ec+jDYvNlP0CWujzLnUsMk4/BSPwG0OIMRr8Huy9fXrimnbMh3e0D1Kg9qUL43Y9adA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ljjclEjuIJ82OqGjXs2Hp3zwy7UGcxgyXNDqnceRbOYFxB18
	p6lkzUmGsaUSLVQpunMLcT+/ASSKpd8k3kop50QUs2tLGEpJsQ4T1d1y
X-Gm-Gg: Acq92OFp6gyKcY+j54fv4mB3qbKh33GFE6I6vNlADdGkv+iDYONH/lIlpUB1bZR0c4p
	tYQiPXWigzGsQog0DgZARhF9DCDII323dWPB4HpDEPnPAzgNXY6LyjiF7OLDWgtRVCT+XHcDh6G
	6F3tNHQ7dknA31ioqTzmIF3tHajY8t/xZ7/359fI9S3bHmufWKTxPYB1Hl9+uPIRKs34D6B8t47
	1oPLdEroeA2OabXw4yAAsv/DIxDIILwNju5ed9Rx0B32+OyFDzyRQaTZnSb3AkRh6r2lJaMEUFs
	97rXmx7rjnbP6+OfQ3iHjJM3yoqC9qJvYB3VQHvETBpNOGGNP58eq930YNlm463b6i2+zm1Go/s
	GHgGiUheVeuMl4VXkFw5z2xpA9efKteNHTQ2ltXXJfDcmSutXW/NqoTj1ChXsecnBgzw6ehOhmm
	voi0DxTZKb0dKq4szmBV2e9+dbYqB9+4IE+9gitjhL7H6BYMgb
X-Received: by 2002:aa7:8882:0:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-83f33f0fddcmr23172920b3a.47.1779259082820;
        Tue, 19 May 2026 23:38:02 -0700 (PDT)
Received: from [10.4.95.45] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5c045sm24753265b3a.37.2026.05.19.23.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 23:38:02 -0700 (PDT)
Message-ID: <1e4abc39-c359-4b9a-81fe-0e6b855241bb@gmail.com>
Date: Wed, 20 May 2026 14:37:57 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: irqchip: KVM: Reduce allocation overhead in
 kvm_set_irq_routing()
To: Sean Christopherson <seanjc@google.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, pbonzini@redhat.com,
 kvm@vger.kernel.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com, isyanfei.xu@gmail.com
References: <20251226062741.4014391-1-yanfei.xu@bytedance.com>
 <agdrZMRR7oDKZNDK@google.com>
 <ccae4c1b-719c-4bbd-9f2c-251364fa4fb3@gmail.com>
 <agsowFVyWElj7zMM@google.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <agsowFVyWElj7zMM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026/5/18 22:57, Sean Christopherson wrote:
> On Mon, May 18, 2026, Yanfei Xu wrote:
>> On 2026/5/16 02:52, Sean Christopherson wrote:
>>> On Fri, Dec 26, 2025, Yanfei Xu wrote:
>>> And if we're going to allocate one massive array, then we definitely should get
>>> rid of:
>>>
>>> 	/*
>>> 	 * Array indexed by gsi. Each entry contains list of irq chips
>>> 	 * the gsi is connected to.
>>> 	 */
>>> 	struct hlist_head map[];
>>>
>>> and kvm_kernel_irq_routing_entry.list.  It'd be easier and faster to have
>>> setup_routing_entry() simply iterate over the array.
>> if we get rid of these, we need to add a new field to record the offset of
>> entries belonging to the same GSI. Compared to the hlist-based lookup, I am
>> not sure this would yield a clear gain. Seems hlist feels more
>> straightforward?
> Gah, right, I was thinking the array was indexed by GSI, but it's indexed by the
> arbitrary order provided by userspace.  And even ignoring the case where a GSI
> has multiple routes, indexing by GSI would massively over-allocate if the routing
> table is sparsely populated.
>
>>> Something we should look at (on top of this), is caching the previous routing
>>> table.  I.e. instead of freeing the old table, keep it around, and try to reuse
>>> the old table on the next update.  That would allow eliding the alloc+free
>>> entirely when userspace is changing routing, but not adding or removing entries.
>> In our live-upgrade scenario, userspace incrementally adds entries via a
>> large number of KVM_SET_GSI_ROUTING ioctls, so the cost is dominated by the
>> cumulative overhead across tens of thousands of alloc/free pairs.
> Yes, but your live-upgrade scenario isn't the only thing KVM supports :-)
>
>> Per my observation, the per-call alloc/free overhead is fine; it's the
>> cumulative cost that hurts.
> That might change with vmalloc'd memory, where tearing down the mappings requires
> TLB shutdowns.  And as above, even if it's not a problem for _your_ scenario, the
> overhead might be meaningful for other setups.  If we can cheaply/easily provide
> meaningful performance benefits for such setups, then why not...

True... TLB shutdowns or buddy slowpath alloction hurts the 
performation. How about
the implementation like below? I think round up the size of cache to 
kmalloc bucket
size could significantly improve cache hit rate, especially when falling 
back to vmalloc

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a8d74b25c5cf..54d9641e2b52 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -694,6 +694,7 @@ struct kvm_irq_routing_table {
         int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
         u32 nr_rt_entries;
         struct kvm_kernel_irq_routing_entry *entries;
+       size_t entries_size;
         /*
          * Array indexed by gsi. Each entry contains list of irq chips
          * the gsi is connected to.
@@ -845,6 +846,11 @@ struct kvm {
          * Update side is protected by irq_lock.
          */
         struct kvm_irq_routing_table __rcu *irq_routing;
+       /*
+        * Cache for the entries[] allocation of a freed IRQ routing table.
+        */
+       struct kvm_kernel_irq_routing_entry *irq_routing_entries_cache;
+       size_t irq_routing_entries_cache_size;

         struct hlist_head irq_ack_notifier_list;
  #endif
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index b78f113af4ea..4b6c2e1a23ff 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -96,12 +96,57 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, 
u32 irq, int level,
         return ret;
  }

-static void free_irq_routing_table(struct kvm_irq_routing_table *rt)
+static struct kvm_kernel_irq_routing_entry *
+kvm_get_irq_routing_entries_cache(struct kvm *kvm, size_t alloc_size)
  {
+       struct kvm_kernel_irq_routing_entry *entries = NULL;
+       struct kvm_kernel_irq_routing_entry *cache = NULL;
+
+       /*
+        * Reuse cached entries[] only for an exact allocation-size match.
+        */
+       mutex_lock(&kvm->irq_lock);
+       if (kvm->irq_routing_entries_cache_size == alloc_size &&
+           kvm->irq_routing_entries_cache) {
+               entries = kvm->irq_routing_entries_cache;
+               kvm->irq_routing_entries_cache = NULL;
+               kvm->irq_routing_entries_cache_size = 0;
+       } else if (kvm->irq_routing_entries_cache) {
+               cache = kvm->irq_routing_entries_cache;
+               kvm->irq_routing_entries_cache = NULL;
+               kvm->irq_routing_entries_cache_size = 0;
+       }
+       mutex_unlock(&kvm->irq_lock);
+
+       kvfree(cache);
+       if (entries)
+               memset(entries, 0, alloc_size);
+
+       return entries;
+}
+
+static void free_irq_routing_table(struct kvm *kvm,
+                                  struct kvm_irq_routing_table *rt)
+{
+       struct kvm_kernel_irq_routing_entry *entries;
+
         if (!rt)
                 return;

-       kvfree(rt->entries);
+       entries = rt->entries;
+       if (kvm && !ZERO_OR_NULL_PTR(entries)) {
+               mutex_lock(&kvm->irq_lock);
+               if (!kvm->irq_routing_entries_cache) {
+                       kvm->irq_routing_entries_cache = entries;
+                       kvm->irq_routing_entries_cache_size = 
rt->entries_size;
+                       entries = NULL;
+               }
+               mutex_unlock(&kvm->irq_lock);
+
+               kvfree(entries);
+       } else {
+               kvfree(entries);
+       }
         kfree(rt);
  }

@@ -110,7 +155,10 @@ void kvm_free_irq_routing(struct kvm *kvm)
         /* Called only during vm destruction. Nobody can use the pointer
            at this stage */
         struct kvm_irq_routing_table *rt = 
rcu_access_pointer(kvm->irq_routing);
-       free_irq_routing_table(rt);
+       free_irq_routing_table(NULL, rt);
+       kvfree(kvm->irq_routing_entries_cache);
+       kvm->irq_routing_entries_cache = NULL;
+       kvm->irq_routing_entries_cache_size = 0;
  }

  static int setup_routing_entry(struct kvm *kvm,
@@ -161,6 +209,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
  {
         struct kvm_irq_routing_table *new, *old;
         struct kvm_kernel_irq_routing_entry *e;
+       size_t alloc_size;
         u32 i, j, nr_rt_entries = 0;
         int r;

@@ -176,12 +225,16 @@ int kvm_set_irq_routing(struct kvm *kvm,
         if (!new)
                 return -ENOMEM;

-       e = kvzalloc_objs(*e, nr, GFP_KERNEL_ACCOUNT);
+       alloc_size = kmalloc_size_roundup(size_mul(sizeof(*e), nr));
+       e = kvm_get_irq_routing_entries_cache(kvm, alloc_size);
+       if (!e)
+               e = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
         if (!e) {
                 r = -ENOMEM;
                 goto out;
         }
         new->entries = e;
+       new->entries_size = alloc_size;

         new->nr_rt_entries = nr_rt_entries;
         for (i = 0; i < KVM_NR_IRQCHIPS; i++)
@@ -218,7 +271,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
         new = old;
         r = 0;
  out:
-       free_irq_routing_table(new);
+       free_irq_routing_table(kvm, new);

         return r;
  }

