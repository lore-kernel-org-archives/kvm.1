Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF623AAF7C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444161; cv=pass; b=OVnW/ECCkB72M0ejF63HbO/R4e8sGAobg8gEYfqg41q4x1laV+b5i8bUGfdWEkbqBmFx9m17J+Hm8pvf1MXcS9xkgk0AXBrW3wl4nN041DhqCqhfpfUn5X4BpCXY/pBMxrFc0GSsU947CuB92Gzh1pOgrkzEYH2d9sR7V8Y5AUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444161; c=relaxed/simple;
	bh=1jiZYsqBtrcmi7eIwfzyaU0PYhHwikLTB018QmEsrns=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rscvkEnAQutu0Wh/cr65K4/VhJ6Fq1+UVrX/cniAeuZKahKOEUytcSBSddUSZaOaxR0yOcQLywXr6KFYjDzML/Za2KQkMRVly341psoMvKijRFKQK7qrXmM/m+CRB2Ecz4chY5LEiAiiH1LBhNE844Br48/iSxxgkHIxvNeC0x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAglTDAX; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAglTDAX"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca7c1176317so201155a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 13:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785444154; cv=none;
        d=google.com; s=arc-20260327;
        b=MVYk4q+7MEfQyTYiUBuP54xYxkO1ebnCeZNCu5QRy7c/iV5iyJjxqcNJ11XGDf3qi4
         mrhOe9VV2jMGqCYon+bs3JiE9+a8GVXeCkEttHAMCoTtku8y7qdt4YitY6RTwHzApUxy
         jKIJKJKw5shuD8aJ561gHMfefapgB+jSRwut/ujwyVxVpx7BR/g5IuGJQ4tQpxbzLG52
         b+mfKNP6U9mtIFHCuEHZh3U2vMX9UngQK9X2zOrNqMJMRQ3dAC1XW7MrurgHM994ghcF
         37haTOSYl+ZfiD+VQ1obFufzb/HsuOpnFAtMS49PR5RiCJblC1zISkiqWvHJqxFHgrNh
         XpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        fh=lfeD6oXUOXUqKKEWq9uCpbJFP4c25yo5X3bpr7EwmIQ=;
        b=AT5IxdIWcFG3qmmPCKniGinHqBNJl3C9OHITiWqUfQlS2Wz6NOSodJ70oypRipmYlR
         ogjWlOXaPnZhJByn7ZthLHL4DUqt8M1tmjiSpsuMgfbTQGXxtC9Gul7sulCD/BV6pG/T
         Y8qwLJfcAfxDn982iVoe+ROCOM9Q4gO0u4z4xHMI/aqzSY05cunouMlv0oRdTt8ngUYF
         Oy7Eta/QCW8XPCGyMXSqKRJyrve2X6tXVM+NGbZlyLYK9gsBaoHbZc3UKrGf9Ah5q6kw
         FDV/PzYMG5V8ewJcIk4VpHhyko0em3OuDR6d588MMDrJiZ03B7qX/V3aurtBrZBZU14y
         OLsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785444154; x=1786048954; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        b=bAglTDAXQTyF1QI2urJYdnQYs8AM7oEMOFaamKRGTXVUqR2kvlhSYLANE+d08MWXvY
         nH3U/5zIqj7sk8JavK1qY4WQyUE4KjKMu75Q7fLdq7yY6w1OJCYfzweSk1qmbMPhKVVZ
         LHeCrmGUtloTLYgTBcXHT8nloWIEDNKayMdM1tsGLGcwG1GPZwqk2ummotj3qcBFilKS
         wN+KGKMX7AoE061dpWKP6L6+2clcbI4cusCuSM8+MtTLGcV/v8ZBH73kROmEwzuuSCOC
         6IA85V8LUtz3zJIhOnqDgluEM/dUgrVv4aKwoABQplbtx6bIy4V3/MK3H8e2FCF9FERc
         YXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444154; x=1786048954;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        b=f42Z4maruqP+LufgBEg059aXhexq0vRbPHHUI5Pr611cIq0oFfQsNp/YZa6IZbLu8M
         WXDotMHqEAtaujQHQ7JA5+VZ8o2Q3GpfJZuKNSmmlCoGvfv+3HQl00yEy6+WQdUYp2c1
         QFIZcs4qufAi+73RupwmWKLJjM1I6Ayq5X+t7da33iKstVKZwTl//DrIktQFa46isGoR
         T3MA0veLtur4TPfUQd9FobpF1kgI87dgcJrJgZAOHCPxKV/u9DZuY+uYvauNb2sDFxAQ
         z0SmAYL3qQMIbq0oiPVvvg03njuK6ckVJvX7HCIY5cGSdH++DCC9JQCRNURyyeG67TFH
         vowg==
X-Gm-Message-State: AOJu0YxZkQo/YayFUT3EhUFHpvzxhIGKXT7jgQE6aySaG9Svp+UOhXr8
	YqiQ9p6SwaCFkecp4AUIOmWudWmfo6ma3M3BCk8LVRJM0cJUybFwA31kOk0LRDi9cIW87dQgjfY
	t8X0akLX3ahjS+4KWBUFEQhJhtqGeZ8HqhpmKfcDS
X-Gm-Gg: AR+sD138rRcIt+LbGndp/x2zpKJ7dtV9OigxETvZ4/NQd14g20RWa8S244bKiDYwW/s
	4HhGYRuc+990tsEXXuEySmz1CiQJGHpu1t+lUpnUMUyLXWE3sx7ZOVHWDlj6ilMIidXC6EYSXv3
	aP2yl0lHfN2JE6GTIkXYZF023E6JeHQE3EgCqKIBSyAVSgtlH6WEvSvX7UWai1APAmOchC84mGh
	y8iM6RMV5IdKmSuBNUaxLwDjOYj+KFyCjJCaopmIeWIYkaGymLOJ3aNna8jCPiw69PlugU3wT9U
	KP9phIWKm/9gnO83JqnyUETLVEsDbb/az7Zi5RHqcyurPqAzE039S0IoD9cfuqUZS0BUggkiFXg
	ERYGQ0tTG5t+g1mpB7Kz8C4LhNXXZt6g++T8=
X-Received: by 2002:a17:90a:d88d:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38f9bd790e8mr3699903a91.10.1785444153113; Thu, 30 Jul 2026
 13:42:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:42:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:42:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com> <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:42:32 -0700
X-Gm-Features: AUfX_mz2wy3LvLLQqF5XvT23FybAB1M_PJOCVj4Bbwu3P1vsWolBi1Qny-gSolY
Message-ID: <CAEvNRgF0SxmoMtqq69tUih54A9K7j_wcMFRrq=r9w6TnAGAUQQ@mail.gmail.com>
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 33c9830190e2e..89cf922232920 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -893,6 +893,27 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>>
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>> +static bool kvm_range_is_private(struct file *file, pgoff_t index,
>> +				 size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	pgoff_t last = index + nr_pages - 1;
>> +	struct maple_tree *mt;
>> +	void *entry;
>> +
>> +	if (!gmem_in_place_conversion)
>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +
>> +	mt = &GMEM_I(inode)->attributes;
>> +	mt_for_each(mt, entry, index, last) {
>> +		if (kvm_gmem_interpret_entry(inode, entry) !=
>> +		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
>> +			return false;
>> +	}
>> +	return true;
>> +}
>>
>>   static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   				struct file *file, gfn_t gfn, struct page *src_page,
>> @@ -913,9 +934,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>
>>   	folio_unlock(folio);
>>
>> -	if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>> +	if (!kvm_range_is_private(file, index, 1, kvm, gfn)) {
>
> It's checking if a single gfn is private.
>

But with huge page support we'd need to check a range of gfns... I guess
there's the argument of not keeping complexity for the future, but in
this case it's undoing functionality for this series and probably adding
it back later.

> We can just use kvm_mem_is_private()? And it seems can be a separate patch.
>

Do you mean that this refactoring could be a separate patch? I could
refactor out kvm_range_is_private() in a separate patch, then put in the
mt_for_each() check in this patch together as part of all the rest of
the "wiring".

I considered that but it seemed like the refactoring was too small to
separate out into another patch when the mt_for_each() part is going to
be in this patch anyway.

Or, I could add an earlier patch to first replace the call to
kvm_range_has_vm_memory_attributes() with a call to check just 1 gfn,
then this wiring patch would be simpler.

Let me know what y'all think is best. Thanks!

>>   		ret = -EINVAL;
>>   		goto out_put_folio;
>>   	}
