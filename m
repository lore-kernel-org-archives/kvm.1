Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6153EDE7A
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615800; cv=none; b=FdDfxg4VyUknzjXggt3gYT7wN5VKR1UQDF1Tgx/VosJHpKlrq6jA5xUvxIaqlPpVClPG3tZtbtaMQ0AAmrGfzX1vXk7ynjpHu2PD+Lv1oqD8PbDak3j1Xyo28+O/z0SVIIQeRsjtOQe5s0aNVBnWamMyFRup2G4au++1/EN0FE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615800; c=relaxed/simple;
	bh=Dcl9PCq3v1ERTOnae+7qBcx117ozcso4898iFkqn/8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfVexWK6/V5DpuljSTzFvvpywNiwVztv/g8+eFeBiI9WnFLIyEvYFCnUSjhrxOrpkM1zMTDO2rLXu898nTYHyrUznYkn/Tz3nG9IXiQAY19YZcwUuRo3A/ptB781IQU1iYFPNIL+4C75XwUUOrZ52DnHODnYUEbpO6b1cu0xKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaQmJve6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaQmJve6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778615797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GLXvpew/7TsHkGC/+zoA41UVWapYMV3jPdq+BtwKfFM=;
	b=iaQmJve6r00d+YJ0q3IQ7O3/whuZqpI1HqCQjWnItY29LRH9NyqDoMKxJF9WqFRnx0qqJE
	v62tAB6peD4eyf+fYj153URUO0D5OJyqdMOeJ5+YNfXF23z52bLDNGNt2HfXkBNwBCzW5i
	ZeChgxjzC+usDNhQ1v4/pH3Q9iqbIfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-1Y81hpgTO56dxVUAMLD9HA-1; Tue,
 12 May 2026 15:56:33 -0400
X-MC-Unique: 1Y81hpgTO56dxVUAMLD9HA-1
X-Mimecast-MFC-AGG-ID: 1Y81hpgTO56dxVUAMLD9HA_1778615792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20789180056E;
	Tue, 12 May 2026 19:56:32 +0000 (UTC)
Received: from [10.44.48.5] (unknown [10.44.48.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C86630001BB;
	Tue, 12 May 2026 19:56:29 +0000 (UTC)
Message-ID: <caaa408c-d255-4431-876e-e6f0581c688d@redhat.com>
Date: Tue, 12 May 2026 21:56:27 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Reject wrapped offset in kvm_reset_dirty_gfn()
To: Aaron Sacks <contact@xchglabs.com>, Willy Tarreau <w@1wt.eu>
Cc: security@kernel.org, kvm@vger.kernel.org
References: <agFyH8UoHO5Q3Fta@1wt.eu>
 <20260512060742.1628959-1-contact@xchglabs.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260512060742.1628959-1-contact@xchglabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/12/26 08:07, Aaron Sacks wrote:
> kvm_reset_dirty_gfn() guards the gfn range with
> 
> 	if (!memslot || (offset + __fls(mask)) >= memslot->npages)
> 		return;
> 
> but offset is u64 and the addition is unchecked.  The check can be
> silently bypassed by a u64 wrap.
> 
> The dirty ring backing those entries is MAP_SHARED at
> KVM_DIRTY_LOG_PAGE_OFFSET of the vcpu fd, so the VMM can rewrite the
> slot and offset fields of any entry between when the kernel pushes
> them and when KVM_RESET_DIRTY_RINGS consumes them.  On reset,
> kvm_dirty_ring_reset() re-reads the values via READ_ONCE() and feeds
> them straight back into this check; only the flags handshake is
> treated as the handover, the slot/offset payload is taken on trust.
> 
> Crafting two entries
> 
> 	entry[i].offset   = 0xffffffffffffffc1
> 	entry[i+1].offset = 0
> 
> makes the coalescing loop in kvm_dirty_ring_reset() compute
> 
> 	delta = (s64)(0 - 0xffffffffffffffc1) = 63
> 
> which falls in [0, BITS_PER_LONG), so it folds entry[i+1] into the
> existing mask by setting bit 63.  The trailing kvm_reset_dirty_gfn()
> call then sees offset = 0xffffffffffffffc1 and __fls(mask) = 63;
> the sum is 0 in u64 and the bounds check passes.
> 
> That offset propagates into kvm_arch_mmu_enable_log_dirty_pt_masked()
> unchanged.  On the legacy MMU path -- kvm_memslots_have_rmaps() ==
> true, i.e. shadow paging, any VM that has allocated shadow roots, or
> a write-tracked slot -- it reaches gfn_to_rmap(), which indexes
> slot->arch.rmap[0][] with a near-U64_MAX gfn.  That is an
> out-of-bounds load of a kvm_rmap_head, followed by a conditional
> clear of PT_WRITABLE_MASK in whatever the loaded pointer points at.
> The path is reachable from any process holding /dev/kvm.
> 
> Range-check offset on its own first, so the addition cannot wrap.
> memslot->npages is bounded well below U64_MAX, so once offset <
> npages holds, offset + __fls(mask) (with __fls(mask) < BITS_PER_LONG)
> stays in range.
> 
> Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Sacks <contact@xchglabs.com>
> ---
> Hi Willy,
> 
> Thanks for the review.  Re-sending this one as a proper patch and
> addressing your points below.  I will reply separately to the
> other three reports per your guidance there.
> 
>> Please could you check on an up-to-date kernel? 6.13.7 is long
>> dead (1 year) and thousands of fixes were merged since.
> 
> Re-verified on v7.0.6 (current stable). The buggy bounds check
> in virt/kvm/dirty_ring.c is unchanged:
> 
>      if (!memslot || (offset + __fls(mask)) >= memslot->npages)
>          return;
> 
> Same PoC still produces the oops:
> 
>      Comm: poc Not tainted 7.0.6 #1
>      BUG: unable to handle page fault for address: ffffa9bbc002ce08
>      RIP: 0010:rmap_write_protect+0x6/0xf0
>      RAX: ffffffffffffffc1   RBX: 8000000000000001
>      Call Trace:
>       kvm_arch_mmu_enable_log_dirty_pt_masked+0x145/0x210
>       kvm_reset_dirty_gfn+0xcd/0x100
>       kvm_dirty_ring_reset+0x12c/0x1f0
>       kvm_vm_ioctl+0xb41/0x10b0
>      Kernel panic - not syncing: Fatal exception
> 
> RAX is the crafted wrapped offset; RBX is the coalesced mask with
> bit 63 set (__fls == 63).  Both match the values planted in the
> ring entries from userspace, so the wrapped sum still passes the
> existing bounds check on v7.0.6.
> 
>> Please also wrap long lines
> 
> Done -- this reply and the patch are at <=72 cols.
> 
>> Was all of this generated by an LLM?
> 
> The reports were generated by an LLM yes. But the analysis, PoC
> and patch suggestions are mine. Happy to provide the PoC source,
> kernel .config, or additional artifacts.
> 
>> Could you please turn this one into a real patch
> 
> Patch follows. Applies clean on v7.0.6; with it applied, the
> same trigger no longer oopses (offset is rejected by the added
> offset >= npages check before the addition can wrap).

Applied, thanks.

Paolo

