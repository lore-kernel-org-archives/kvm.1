Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421B3E92AF
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706118; cv=none; b=D9I8EHY6cfq7WPfs3ivCANIQwbDOzQhLV4I4lWe7AltZGMhE8/qR+oNqqMaaBTKskwUAOrREY7o35zrNXOCSUnqdRoUdW7eX6Aas2lPEwdq29QapBczqr7Cqplmeqa4q6hrJrA/0k2GD5JCK3xPfg1CPldF8IJ5VSEcSQH63Z0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706118; c=relaxed/simple;
	bh=tITp3vI8QCODQTdN3D7k1C5vtWMYgUCUyDY+YluPXsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixOi8xqr7eqpMPNJ8aunIlCKtVwyyFfZf2x7NWAPSggEYoCHGe+TO0oYgHj5XJ3wLsguZJUMs9g0KAHJR46FxQf/+B3GTQIPZuhK2eMbNf4UqHthu5Hy/GlMSIksBnRTaW82Ep5tks3PIHUr27Qg5byhHZdwj9LSdhiHq1hc2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gF1vomzo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmrUOBOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF1vomzo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmrUOBOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781706116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
	b=gF1vomzo3NEgC2uOMFwN04LakJT6Hjvy/UcV5isWLLhjtfDkuRlkfxGb/QzSbg1nNjUMpY
	67Z5a1FdQPOfB3S0eJAGwdt8tfWLvkEVRlLkAUAnpNNXwdnfNuTF57G2kLAMOPlEtLojTM
	rolxM9eN4ZuU8n13TCgkGIlpo4JNHtM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-o_5cu7NEPjSB5zK4uJtM0g-1; Wed, 17 Jun 2026 10:21:54 -0400
X-MC-Unique: o_5cu7NEPjSB5zK4uJtM0g-1
X-Mimecast-MFC-AGG-ID: o_5cu7NEPjSB5zK4uJtM0g_1781706114
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8db0206979cso22767756d6.3
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781706114; x=1782310914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
        b=EmrUOBOdJNUkveNN8EZH7XwTz+W694tGph2Ev0FA0QMPvZlgggV+uyWhWHgV64pUsQ
         fdsU50lfVCE+itx+J05vOagCZ7r4XLRC4iWo3Dfeb4z9AUTT/Evb+fuJrFTGdIJHJC0s
         8L++gdkWTZjiS8V01OEGGlF2KTWABvsVh/ISIMFJ8MeKlyY2NcCU/n++ujOV2d/cb1ha
         R5Kz0cpNSM91DqS3CDK4UN2bSAZcoUoGwza/kM9jth6uHOIZV9iH+kMYYb05En1tArvH
         VCXCzIKSOOsmQxY0b0Ix3fQb0vXChJvmjFa9qx0s9TkcbGCqYin7aqH+ebYkNunPxH0v
         E3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706114; x=1782310914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
        b=Bfed9j56ljr8+TVln3Buu71gI6NgoSuTcunsIz/9WnJyeQ/HnHLzDMs1t0UtjXkuKV
         rfnrIeR/hnus7O4Z9Hpxyci38USutSVuJBd8HMt6VSXnbeDSM1mII3A/lAI2m2XbD97n
         5Klf3wYVrgWwZSmGIqseq9PNy9EvDnVa6wrQG3xo+UEflptZjRf2MBmLPxsXuwFN6EGL
         XTA5cvMmBa+z/xSwZzckYs6cw6vT3uCEZ0p99b35lhExEGLHoX/bnZ0fCH5iZKnMToik
         MzUHnh2yKIR7iV9+625fUeiLXJSBMu26KoX1pQLYm/HMzHK1pci4EBIGv7qBiZI6zOe8
         bq3w==
X-Forwarded-Encrypted: i=1; AFNElJ/RqdFnkkyRG0p2vAkjOCZn7KBhugH8lVCXUsebcueKGyBC/N+Sd++zvJTuQ+8WpdbiP8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6uvEnlllWtUcIMZVNgqhPnbQ0TjyrATXQVRIS8Z1/5YFdAUv
	Jbk7Ya52GOZ7Ykk1DUTR9/D/t6h0AvwqxCw9S65SYI7v1yVa0FaRIf6hkNV/qOjsX1VLv3QXt0A
	wbNIU2bHDM1gbEMNF0vivuOHFZYhB9ERx+tEfGQiQm5k75NYL7jvXcw==
X-Gm-Gg: Acq92OFeJRxhihttmqX6kja+8PX+ijw1oxtK5B6UZQa/x9XeCRxudLoKuV1VpOe+45d
	K6G0qXDrSCOeRLAqHaYtzUQh3r5GF9RxkdQbNKwQlxEL0FnYsVS3pvIhOLfR8WuxEHyE3wZX/AH
	QAMACOh22kzciMNcnez9vP4y58hoDz2EyMXsHc42CA1/Qym/5Nk4iyLcp4aRGJKEaYyANC+ghgB
	rAx4ErBgKfgY3bl/vfgRULR9b5mz7t5srHw1HgO1oPggik8FckO3DJJiLukQSl3jvEv6W3kNnUq
	CZrMPCDQs1ZA2AqLcXFzU1ZXwgrfq5d6JE+6/YyzA3xGmMKDYksRAD6DZOAUts5Za60zW5wSWY9
	4oxQ=
X-Received: by 2002:a05:620a:29ce:b0:915:c365:ffb1 with SMTP id af79cd13be357-91d8bfb0904mr635622485a.57.1781706113718;
        Wed, 17 Jun 2026 07:21:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29ce:b0:915:c365:ffb1 with SMTP id af79cd13be357-91d8bfb0904mr635618885a.57.1781706113132;
        Wed, 17 Jun 2026 07:21:53 -0700 (PDT)
Received: from x1.local ([174.91.116.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm1869207585a.27.2026.06.17.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:21:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:21:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Anthony Pighin <anthony.pighin@nokia.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajKtdCN0AlbmBnAj@x1.local>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616163054.77fdb61a@shazbot.org>

On Tue, Jun 16, 2026 at 04:30:54PM -0600, Alex Williamson wrote:
> On Tue, 16 Jun 2026 14:01:29 -0400
> Anthony Pighin <anthony.pighin@nokia.com> wrote:
> 
> > VFIO PCI devices support PMD-sized page table entries for BAR mappings
> > via their huge_fault handler (vfio_pci_mmap_huge_fault).  However, the
> > VFIO device file_operations never provided a get_unmapped_area callback
> > to request PMD-aligned virtual address placement from the mmap address
> > allocator.
> > 
> > Before commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > get_unmapped_area"), this was masked by a bug introduced in commit
> > ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") which
> > inadvertently applied THP alignment to all file-backed mappings,
> > regardless of whether they provided a get_unmapped_area callback.
> > 
> > When commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > get_unmapped_area") correctly restricted THP alignment to anonymous
> > mappings and files that explicitly opt in via get_unmapped_area, VFIO BAR
> > mappings lost their PMD-aligned placement.  Since the huge_fault handler
> > requires both the VMA start address and the physical PFN to be
> > PMD-aligned, unaligned VMAs force a fallback to 4KB page faults.
> > 
> > For example, a 2GiB BAR results in 524,288 individual page faults
> > instead of 1,024 PMD-sized faults, increasing the VFIO_IOMMU_MAP_DMA
> > pinning time by orders of magnitude -- a regression directly visible to
> > KVM guests during PCI device initialization.
> > 
> > Fix this by providing a get_unmapped_area callback in vfio_device_fops,
> > following the same pattern used by ext4, xfs, btrfs, fuse, and other
> > subsystems that benefit from THP-aligned placement.
> 
> The trouble is that PMD alignment isn't right either, your 1024 PMD
> faults on a 2GiB BAR would be 2 faults on x86_64 with PUD mappings.
> QEMU has forced the alignment to make it optimal for some time[1], so
> there are userspace VMM options.  Seems like you were previously
> getting lucky.
> 
> Peter Xu was working on a more comprehensive solution[2] late last
> year, but it seems there was an objection to the
> file_operations.get_mapping_order() proposal before Plumbers and the
> thread hasn't rekindled.
> 
> Gentle bump to Peter and Willy that maybe we could resurrect that
> effort.  Thanks,

Yes, since QEMU doesn't need it, it was low priority on my list (also due
to much more downstream works recently, and a lot of things happened).

I can definitely try again.

I'll wait for another 1-2 weeks in case Matthew would like to provide a
better suggestion, otherwise I can send a new version based on what we
have, and we can start from there.

Thanks,

-- 
Peter Xu

