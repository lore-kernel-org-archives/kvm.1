Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7A3F1048
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670602; cv=none; b=oz64Mg+gM7OuyMShxIfN//gutF7SeSs4/AfDyfYMlqwiGX5VubrZhsb/qZiYewprtzu3HEXf0P6w4/gPTzu5S7yoy6JF8hC9IlHsIzMjgowbUnAagX/9KL5j0d0ZZDOb51QQ83RxfmJl4PW+RRP9qQDXkhELpsTQAM9BGapeBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670602; c=relaxed/simple;
	bh=8kxH/OayBaB/YISkRgr8hDh2O4L9NhgdZOgWgNcyhkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khlzrIWWakOi1SQ0BjjYOBHZRIyf5UfN30elLFs+yI9j3AR3HZzGK+KpoDBan2BMYDkcr8Ovoo89xiNYQcqpnno61dtUXpu9G/5AE+aJHbfWTTCV0RbJuBoqkU0Jxyh66s7MxuMLwLgy6xMwyeVrP9YYFOKMaChrcL2oBRNL9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDVu1vko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDVu1vko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790670599;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxbsc+NCljbcHcDxhWzgsYHRMDqK6k1gG92IIwNO9h4=;
	b=GDVu1vkoVMDD0cwi3jkGwvi76uIcNpMPpC3Vwf0GgFSYMGR8r2EiLywzwe2vLwCckUeYXo
	2uUBhJcQsz3rmSiX+UyA0ytXaqqBB2Y8fQZg/SuwZFm7kSGfYXW6BqAbRidhcubgJfufng
	XBTmOp9sJEz7KjqXJCjOp0M2eEDMN/Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-fNfSDtvAORy8mlLou8Gapg-1; Tue, 29 Sep 2026 04:29:56 -0400
X-MC-Unique: fNfSDtvAORy8mlLou8Gapg-1
X-Mimecast-MFC-AGG-ID: fNfSDtvAORy8mlLou8Gapg_1790670595
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29959eb71fso400218566b.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670595; x=1791275395;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vxbsc+NCljbcHcDxhWzgsYHRMDqK6k1gG92IIwNO9h4=;
        b=V0wvOQTUJsAUuOgBh5k1Oo0frJe5o05NSE5/NpJ6YwBBgOdnEjsjUiYLtb4N72eFYU
         LA+H/sO16yIFXo1HdZa9IROz2p0dfj4PU1KctyhMv4WBpCOqJTQ+bS3TULMWZTDXJkeH
         Nqp8bPMSZ0X40w9oGCPTOGk9xd2xXv0cs1iyqBUAJVSr+sgl8XHyF6sbuQERPK+xrf0m
         a1yerUnEi80PGeGNyF3WIN6fJH6NKJ2ZWoPTWYsjKvTDqNKHpIFmMiUmUMpb13GEFPXj
         dK939h18mbuhFsO4Rx3QvwEp2VNOq70jvLyUQhAqp2W+BMnMpyGECG3wHB4edGDL96VT
         pDBw==
X-Gm-Message-State: AFuF++kYF+uNLTkavRXdy5H8kV0xs3LhRKPl8K5EhDsc9Y+ji+k79/wI
	Xd2Xh25IU19fZ+cKxsJGWqxjypWyt/Fj6UUHkNzjSToajZ3gvLIAiGHiFOz+c0Yba7rsFIuj0zP
	nJO4aPt4kWI5jh0Ij5oJmFUy71sZSjwwYgLkzLHPI9WnFzaTwt704Iw==
X-Gm-Gg: AYBFou0BG7k5aMbhwL5OtETJBqzCnJES0IRndhjxop/OBwvJALoxd40rNothLEFV9oC
	1/NRObV/jO9ikn1ANuL6jIYgFbn51DAPceEPtLTroi4g3Flft1FfKG+PDB8hZkVOWTDNFMK2KvJ
	lRelnPFGVcCLggGimkVw5CIYvqtFZ8vhVKuzNQhJqI9KERXFlWae0MeQQoT+YGmCFjdSLOn69pp
	ZjBWZMH/MmGFr2DDzQDxQAU7BAlvwMJZ1Xq+YjONgsKVKYfAob3k/Vpcm1Vc0bDeSlinJrWCyjD
	BAtySZIv7AG7goPVSU0cziH2BKQUGHtSp+6S7Kd1OwFfEhGrjiN488n6uRsxgMxWgO++Jc4a/vE
	6j9o1HEACvuS6eRvVUOyZojXVwXph1YxpmGWzasFPs4fi1XBM
X-Received: by 2002:a17:907:c609:10b0:c2a:cf73:63fe with SMTP id a640c23a62f3a-c2acf7369d6mr801066666b.6.1790670595119;
        Tue, 29 Sep 2026 01:29:55 -0700 (PDT)
X-Received: by 2002:a17:907:c609:10b0:c2a:cf73:63fe with SMTP id a640c23a62f3a-c2acf7369d6mr801064266b.6.1790670594668;
        Tue, 29 Sep 2026 01:29:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc57c8dbbsm363629266b.12.2026.09.29.01.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:29:54 -0700 (PDT)
Message-ID: <de7adc58-cb00-4ffd-8b2a-29728114c655@redhat.com>
Date: Tue, 29 Sep 2026 10:29:52 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 4/7] vfio/platform: keep logical vm_pgoff in MMIO region
 mmap
Content-Language: en-US
To: Alex Williamson <alex@shazbot.org>, Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, smostafa@google.com,
 praan@google.com, ioana.ciornei@nxp.com, nipun.gupta@amd.com,
 nikhil.agarwal@amd.com
References: <20260921122334.2099-1-suruurism@gmail.com>
 <20260921122334.2099-5-suruurism@gmail.com>
 <20260928170019.2b46ee5a@shazbot.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260928170019.2b46ee5a@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/26 1:00 AM, Alex Williamson wrote:
> On Mon, 21 Sep 2026 15:23:31 +0300
> Abdifatah Suruur <suruurism@gmail.com> wrote:
>
>> vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
>> frame number of the MMIO region and passes it to remap_pfn_range().
>> The VMA is inserted into the device file's mapping->i_mmap interval
>> tree keyed by vm_pgoff, which VFIO expects to be the logical file
>> offset: the core links every device mmap to the device inode's
>> i_mapping precisely so that unmap_mapping_range() can revoke all
>> mappings associated with a device (see vfio_device_cdev_open()).
>>
>> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
>> coordinate space and unmap_mapping_range() cannot find the VMA,
>> leaving stale MMIO mappings behind any revocation attempt.  Keep
>> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
>> the physical PFN to remap_pfn_range() explicitly.
>>
>> This is defensive hygiene: none of vfio-platform, vfio/fsl-mc and
>> vfio/cdx call unmap_mapping_range() today, so no reachable
>> stale-mapping issue exists.  Keeping vm_pgoff logical preserves the
>> VFIO core contract for any future revocation path.
>>
>> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
>> ---
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -561,6 +561,5 @@
>>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> -	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
>> -
>> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>> +	return remap_pfn_range(vma, vma->vm_start,
>> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>>  			       req_len, vma->vm_page_prot);
>>  }
> Eric had provided a Reviewed-by in [1], I think the only difference is
> the commit log, including dropping the Fixes: tag since it's not
> currently reachable.  I'd keep the R-b for that, or he can re-add it on
> the next spin.  Thanks,
I do agree. Feel free to keep the R-b

Eric
>
> Alex
>
> [1]https://lore.kernel.org/all/21fda51a-6974-487d-874a-387dd73e2346@redhat.com/
>

