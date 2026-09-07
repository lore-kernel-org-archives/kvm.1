Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BC4756BB
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790257; cv=none; b=r21mRlBW4r1tSPJwKPBMFj2RsN2qBxUvFeLPOSdM8Q5qMui1FUP+u3xE73coYQPlBv0XKPPteeNe3SXyv5kfuyBlA4g6LNCro0KezBN3eJ6kuZiOYnivFyUGsMq03V+lWRlPDS6t+53wOI+Yk9NVfwDAmGdCQrRsIhp8oo4LLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790257; c=relaxed/simple;
	bh=0vgyKgm7Ju4DhvTSNHaMWk44o631ldKHVMXJr8tSp4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTCwxgepKcpcS8twsADej2N/y+qpm4jjCGnOUFbAwA2uKEJHtSBEWIG0sJwfrXBV9XTz0/Yj1EhoUPY/FzT7jJBMdMpsEEB+J8c29+m5MBp0/V3vqrzlx/G4g7+E8Q2hQcxk0v/vxQ51AzHUnrjqSk/VXmmWsFMCBhmOmHxdSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2P2A5pv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2P2A5pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788790254;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGAbXgift4P8mLmChfWdJgoXpNqo/L2DoPwMTNYzRVg=;
	b=Q2P2A5pvLeWlWsx0pZneLo47RvPnhjTmSPwk2PxgyZKVfQwnqbfDkGYBNmHDA57nZ6Dvu2
	JwjrmmF+qHwt0PKYv6gwOyqEDhr8/A4dpYDVkbB0+Gsdkhlc3gYcsgk7eLry+rXa9cGBZp
	XuzfXxOSK9QftADgLWyNy14rjhgwfB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-BvbsGL9ZMBm9yM-J3aV8UQ-1; Mon, 07 Sep 2026 10:10:51 -0400
X-MC-Unique: BvbsGL9ZMBm9yM-J3aV8UQ-1
X-Mimecast-MFC-AGG-ID: BvbsGL9ZMBm9yM-J3aV8UQ_1788790250
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso27373485e9.3
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 07:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790250; x=1789395050;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGAbXgift4P8mLmChfWdJgoXpNqo/L2DoPwMTNYzRVg=;
        b=UOahv95QnpKboxw7h5+NseTYqu/ZoKc0VHuPmIPG4lBdX3NE4qkRdSQnnSzcvpvNDv
         g1JKid2+xpwIXuc0O4byqM/sy3BpDaW8WvSMiznWue+xK89itHLR0S5aVB87WbNItrpH
         18cTulbETRg6ZVzO9OHGHxz9lxxZmYqnGXGR+LbO2tfYdBFNQC4sKppAfCFnHQ6VTSs4
         UzyaMAIs73p0jIStReB6dRMZZyAtaYeSkorme/O5pMY/CGRHGW09iusMtqfYuYNRNBXI
         +whxOCp3H0F1gTteUcyyhuMFcTFewkOaLiO2stn3c+d8FurmhMT420QFsQfeUGs5MajS
         NweQ==
X-Forwarded-Encrypted: i=1; AKwUvBzK85UuwX/hXCgES6wH1Z9vCBB4tpYWyoB3I9+vTO1vtnY6er9ovETK8kn7VjCLpDBrWqo=@vger.kernel.org
X-Gm-Message-State: AFuF++l9crW9PDHzH633NqO0eVssiiMj/JKIcRtWf23la7HIZgpNlipw
	WJwMX601X7LliRN8GqKnV0hWeSK19dANgIIAoT5pYH4w+9961dQK6Wep/d99UOwGVVO7hXsc2NT
	hHk266A98/pGCozTtR+iBX/Q75lu0rrVJxSXCueO/AUxcb6wUM7HQxg==
X-Gm-Gg: AYBFou39+vQYFoIEwQyLHR/mbB1XQgO9JUwknmUSkrSIdDO1UgmhmCO6CKrhjBMc279
	UxHbuVc0WFNNbU6bNL9VNPVt2Ci8V8Fzs0JLkFkBnzJF6UzJx82hqkfFKI7VcdvjC2JzCyOkn3H
	7Cr8UDbDkr5t2Qx5KdbjscWE98HeTcIyzsX6yCHb8XT5fVxOb8NtBYoZgi4tr7RLxFzYUt2U7Zv
	UTMAzk99vSAzEiu2H7STYCHleuP2PgwSHRJ2bZG7jH55TKM432UXVK0YiBJonhoO/p9gbJ0xbVM
	B2/8oDEqCqnZK1lxRValkarzRwo0x8AumERlKdcHrdhxJS4/I2mZbWkyVRyN7SuUnLRTbTc8V0k
	dgCdGPA+QthoIkcAoKZkQ5eD26N0Bpd9OgA==
X-Received: by 2002:a05:600d:8445:10b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49cf825d77amr167663335e9.11.1788790250065;
        Mon, 07 Sep 2026 07:10:50 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:10b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49cf825d77amr167662955e9.11.1788790249583;
        Mon, 07 Sep 2026 07:10:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm839353095e9.0.2026.09.07.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 07:10:48 -0700 (PDT)
Message-ID: <21fda51a-6974-487d-874a-387dd73e2346@redhat.com>
Date: Mon, 7 Sep 2026 16:10:46 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio/platform: keep logical vm_pgoff in MMIO region mmap
Content-Language: en-US
To: Abdifatah Suruur <suruurism@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
 Pranjal Shrivastava <praan@google.com>, Alex Williamson <alex@shazbot.org>
References: <20260903092927.502-1-suruurism@gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260903092927.502-1-suruurism@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 11:29 AM, Abdifatah Suruur wrote:
> vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
> frame number of the MMIO region and passes it to remap_pfn_range().
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).
>
> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
> coordinate space and unmap_mapping_range() cannot find the VMA,
> leaving stale MMIO mappings behind any revocation attempt.  Keep
> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
> the physical PFN to remap_pfn_range() explicitly.
>
> Fixes: fad4d5b1f042a ("vfio/platform: support MMAP of MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
>
> ---
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -559,6 +559,5 @@
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> -
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>  			       req_len, vma->vm_page_prot);
>  }
>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

