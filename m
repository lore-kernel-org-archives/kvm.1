Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF153E1233
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459835; cv=none; b=UwjYJV6vny5yiOxNSwMljGAoquL09EiRC6pD3/YV0MFbpbsBCsHbjVRmhIZ2ROpyfssuLJ0damebpBSmSvjdDW1RSvncOJ54WCx/jLZdqgrqJ0ByEn5r7a4yFa+3HVT46Z9z4srHRwWdFJ/9iF8xCVmz4WfQYiQ/jwp8HRt8NL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459835; c=relaxed/simple;
	bh=s0U6052cZS8r73pCwXoBgHD40+SRrB/8u/7DqNhuwIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6rBk7WygYb2AKf5VjujZl6Eyrfi5bOuA7MaZu7/IBdIzVX75KklR6hwpnTbzxS1LU6dQGAUaWREhnIrJ+lD1tbAkrk+O9g6uYhIMfC1v8nCEYWYmo8SZiUAIU8JFJEPtJl9STobChRJETlAW4f7Z7T5jFguP07VzDujr8/zNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJXZvGJU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mMStKE6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJXZvGJU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mMStKE6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782459833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt7ue9HwiPWHFMmu1Qr+INx7bk2xLViK4an0U84LPO8=;
	b=jJXZvGJUlj9UPcSFJp+kIp8mx9SuR3iZcqkVLSsCe+QLgO0zXQ9WDLFFzmYtM67688/lta
	b8cyEpxBKHybvZF/b9MnV/la4vVOA2hly/26WBupGYG6tebXshzDghzbtjjBM5DU3JvAkY
	n+B04Ln8GzptE8wg/CCxS0CGwdE7VGs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Gu6VU17rMRWBL2qt1A03gA-1; Fri, 26 Jun 2026 03:43:49 -0400
X-MC-Unique: Gu6VU17rMRWBL2qt1A03gA-1
X-Mimecast-MFC-AGG-ID: Gu6VU17rMRWBL2qt1A03gA_1782459829
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so10615055ad.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782459829; x=1783064629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xt7ue9HwiPWHFMmu1Qr+INx7bk2xLViK4an0U84LPO8=;
        b=mMStKE6fg7oNgxRTKZG7evHqgatHdqc88ndKS9GKr+StddiiLVOZplbKeCVj4gEVRp
         tjV5Nz/2UFEUd6B4aTggFDT8WZeSiyZdSRCzqQprefNk3+/Hrg/d/lYjq+e0K6OzQwID
         1txMd054WMhVV+eaP5LU6eHCZRHsVv1CMutI3meguNKHG98KAPiOXmi06E2vSXGWZa38
         f76elAuL80paZhaulbnX2cfyDF7o4bQGszDUSRKlXPzsn/CjBRs/9r8NEE77AN4ljDvY
         wb2sUWWH09jBQJ0HnI9cKdk2CyrCZvAasddtenUSjdTn7Qhu2GIFU/uerQsBCFQ4ZoNC
         HdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459829; x=1783064629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt7ue9HwiPWHFMmu1Qr+INx7bk2xLViK4an0U84LPO8=;
        b=ffk8m/Msw2ky2xCbVWKS1ZgrvJxxDhVdcH5nmTvLIJIq2BEewh/u0VUDwaLLr5rbJo
         le2/K5e7SFiBkNOs+lW7kVRK3Y1KnrDCLGHLtQ2Ja3Ym5jM8NpSG70cNetT8MqHNqXVB
         wdmBTTwONoy8TXHdok+vFG1qm817X/+J+YD93nZrLAF+jwkATefHOn8wtKLgGyYMZL70
         5uAaQzvnZwoJwg1yLtjnzkUGdYrCIMDwgsteitx5y5Mmrn6csizgMUspxiI1Z6d/3llU
         Rtr/Ojeb4nouS8Ihieu7irXJ6nv4Q+7LhbvCcgEbLX4pu+mZ56RvBTIxNQK2V3awrK23
         ZuCw==
X-Forwarded-Encrypted: i=1; AHgh+Rorc5KPnlzwek68Kyq/WK+OH5X0GZy9ajiK28eXKJBPMlpl7FqrfhjnRD3Sy4hPWhP7muA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pBtTlE0Lrqt22xOl9tYoxW7esDIbCLtMYRksdRBQGJ8JoH2T
	luLV/iPJHQ6FzCulbS4d0jd+2I+IPK1+ItiwNBaPe/3gIlQsabBeoiNZjWY784d1/GxpltsaADq
	aeN8qciuYghaAwJUVkChZ9MYx2q/bMVts/lc5Tox6QCXOWuyWaJ3F9Q==
X-Gm-Gg: AfdE7cnh2R/ZWcMK3yQyNtVL2ObRWOOnlGBuZIKUgIt6eXrDlOn1QHGWSFUB9Qv5C2H
	8yppm4rhAslf8ErbZwSv8i0nYcFST7rJZY1W8yG6+njiKR0oTZUKYe3t9bnKksNvH8W9wy/PW2C
	dGGWI/fzyLG/xmQNUG5hibFZ2DgNPxup8n+1laJq+R5lw9KAKdd137PpE+7vCBvvE3KzLn+hKnM
	BTLbAB2OHlC9metV87BirqwY2KxlOy1xXoP5XXyPwMsspIzfBeku5Ds4dDPpee8ZdxTM53jz0yB
	Gz9QTawYfkDs16HGQEYc2KkD1gOgsmpT4Y7XSVB6QMdxWuKZZAChfXiYpyKUYpY9nv0rJVAe6ZO
	BcfQCB/23boVmwPpjNSmJK7bIRGAf5mRnZn+Nl2+mrdX+4UQbclbXew==
X-Received: by 2002:a17:902:d510:b0:2c7:f233:3df8 with SMTP id d9443c01a7336-2c7fc8ab880mr56064605ad.31.1782459828701;
        Fri, 26 Jun 2026 00:43:48 -0700 (PDT)
X-Received: by 2002:a17:902:d510:b0:2c7:f233:3df8 with SMTP id d9443c01a7336-2c7fc8ab880mr56064265ad.31.1782459828076;
        Fri, 26 Jun 2026 00:43:48 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27f4sm34866665ad.53.2026.06.26.00.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 00:43:47 -0700 (PDT)
Message-ID: <8da87878-2a5d-478a-a280-60dbed7ad1b9@redhat.com>
Date: Fri, 26 Jun 2026 17:43:34 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/44] arm64: RMI: Runtime faulting of memory
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-30-steven.price@arm.com>
 <3359f788-07fa-41a1-9ac7-45c58577c1fa@redhat.com>
 <aiJ6u83O0nVUtPyv@lpieralisi>
 <ecef952b-e8c6-4102-933b-c99c46f14431@redhat.com>
 <aiLes2ecZSr17UwZ@lpieralisi>
 <1e39094f-7fa3-4ef1-be54-53d7a8643506@redhat.com>
 <98d2a0f3-b831-466a-8212-5bcf97ad9d8b@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <98d2a0f3-b831-466a-8212-5bcf97ad9d8b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/26 1:58 AM, Suzuki K Poulose wrote:
> On 25/06/2026 14:53, Gavin Shan wrote:
>> On 6/6/26 12:35 AM, Lorenzo Pieralisi wrote:
>>> On Fri, Jun 05, 2026 at 06:11:11PM +1000, Gavin Shan wrote:
>>>> On 6/5/26 5:28 PM, Lorenzo Pieralisi wrote:
>>>>> On Fri, Jun 05, 2026 at 04:23:15PM +1000, Gavin Shan wrote:

[...]

>>>>
>>>> I tried to rebase Jean's latest QEMU series [1] to upstream QEMU, and found
>>>> that memory slots backed by THP are broken. With THP disabled on the host and
>>>> other fixes (mentioned in my prevous replies) applied on the top of this (v14)
>>>> series, I'm able to boot a realm guest with rebased QEMU series [2], plus more
>>>> fxies on the top.
>>>>
>>>> [1] https://git.codelinaro.org/linaro/dcap/qemu.git  (branch: cca/ latest)
>>>> [2] https://git.qemu.org/git/qemu.git                (branch: cca/gavin)
>>>>
>>>> Lorenzo, You may be saying there is someone making QEMU to support ARM/CCA?
>>>
>>> Mathieu and I are working on that yes and with Steven/Suzuki to fix the THP
>>> issues you pointed out above.
>>>
>>>> If so, I'm not sure if there is a QEMU repository for me to try?
>>>
>>> We should be able to submit patches by end of June - we shall let you know
>>> whether we can make something available earlier.
>>>
>>
>> Not sure if there are other known issues in this series. It seems the stage2
>> page fault handling on the shared space isn't working well. In my test, the
>> vring (struct vring_desc) of virtio-net-pci is updated by the guest, and the
>> data isn't seen by QEMU, I'm suspecting if the host-page-frame-number is properly
>> resolved in the s2 page fault handler for shared (unprotected) space.
>>
>> - I rebased Jean's latest qemu branch to the upstream qemu;
>>
>> - On the host, which is emulated by qemu/tcg, the THP (transparent huge page) is
>>    disabled.
>>
>> - On the guest, I can see the virtio vring (struct vring_desc) is updated. The
>>    S1 page-table entry looks correct because the corresponding physical address
>>    0x10046880000 is a sane shared (unprotected) space address.
>>
>>    [   52.094143] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
>>    [   52.289746] virtqueue_add_desc_split: desc[0]@0xffff000006880000, [00000100b983f000  00000640  0002  0001]
>>    [   52.432150] PTE 0x00e8010046880707 at address 0xffff000006880000
>>
>> - On the host, the s2 page-table-entry is unmapped due to attribute transition (private -> shared).
>>    A subsequent S2 page fault is raised against the adress and the s2 page-table-entry is built.
>>
>>    [  109.259077] ====> realm_unmap_shared_range: tracked_unprot_addr=0x10046880000
>>    [  109.260249] realm_unmap_shared_range: unmapped shared range at 0x10046880000
>>    [  109.317786] realm_unmap_shared_range: unmapped shared range at 0x10046880000
>>    [  109.629939] ====> kvm_handle_guest_abort: fault_ipa=0x10046880000, esr=0x92000007
>>    [  109.630245] realm_map_non_secure: ipa=0x10046880000, pfn=0xb8b59, size=0x1000, prot=0xf
>>    [  109.630331] realm_map_non_secure: ipa=0x10046880000, ipa_top=0x10046881000, flags=0x1e0001, range_desc=0xb8b59004
> 
> Are you able to correlate the order of the transitions and the Guest
> access with RMM log ? We haven't seen this from our end. We are aware
> of permission fault issues with Unprotected IPA when backing the memslot
> with MAP_PRIVATE areas. But this looks different.
> 
> Lorenzo, have you run into this ?
> 

It's hard to correlate the order since the logs are collected from two separate
consoles. For the write permission, I add code to the host where the permission
is always added for all s2 page faults in the shared space. Otherwise, qemu can
be killed by -EFAULT or similar error.

There are more findings after more experiments: this virtio-net-pci device has 3
queues or vrings (Rx/Tx/Ctrl). The Rx/Tx/Ctrl queue are populated in order one after
one. In the guest kernel, I intentionally write fixed data (0x0123456789abcdef) to
the first 8 bytes of the queue when it gets populated, and stop the guest at random
points to see if the data is gone. I found that the data written to Rx/Tx queue are
lost after Ctrl queue is allocated.

The data written to Rx/Tx queue is lost if the guest stops (B). The data written to
Rx/Tx queue isn't lost if the guest stops at (A). I can see the pattern (0x0123...cdef)
by dumping the physcial memory through 'pmemsave' command in qemu.

DMA allocation
==============
dma_alloc_coherent
   dma_alloc_attrs
     dma_direct_alloc
       __dma_direct_alloc_pages
       dma_set_decrypted                    // (A) No data lost if being stopped here for the Ctrl queue
       memset(ret, 0, size)                 // (B) Data lost after being stopped after memset() for the Ctrl queue

The memset() on the Ctrl queue should trigger a stage2 page fault. It seems the page
fault enforces the shared pages for Rx/Tx queue to be dropped? I need to add more
debugging code and track it down.

> Suzuki
> 
> 
>>
>> - On QEMU, the updated vring (struct vring_desc) at GPA 0x46880000 isn't seen. All the
>>    data in that adress are zeros.
>>
>>    ====> virtqueue_split_pop: vdev=<virtio-net>, sz=0x38, queue_index=0x0, vq->vring.num=0x100
>>    virtqueue_split_pop: last_avail_idx=0x0, head=0x0
>>    address_space_read_cached_slow: cache@0xffff1c036440, addr=0x0, buf=0xffffeee34880, len=0x10
>>    address_space_read_cached_slow: cache: ptr=0x0, xlat=0x10046880000, len=0x1000, mrs=<realm-dma-region>, is_write=no
>>    address_space_read_cached_slow: translated to mr=<mach-virt.ram>, mr_addr=0x6880000, l=0x10
>>    flatview_read_continue_step: mr=<mach-virt.ram>, host=0xffff23e00000, mr_addr=0x6880000, ram_ptr=0xffff2a680000
>>    virtqueue_split_pop: desc: 0000000000000000 - 00000000 - 00000000 - 00000000
>>    qemu-system-aarch64: virtio: zero sized buffers are not allowed
>>
>>
Thanks,
Gavin

