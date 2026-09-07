Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D742D7D47
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788757237; cv=none; b=izfnXdUKx9upBbkGi7P4wmjxqX1xeZuuxeYcR4s0btqcVzziBO/eniLaes79Bwp4EPrIGNFryiSnDrmx1+ZZzxx758LfByYdvOwWM9xnFy9ovuYOLzGaWkrnCutzyokLmnZFrtID0iPAYgs7ASV/XgVsnx/96TZ+99EWN2KItho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788757237; c=relaxed/simple;
	bh=m13jlM0aP6j5oj0lANfhDui+uOQDFRS9ehEgA/kE9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTtKLLdU0Og5oewvHbu10c1glhqBvP3GVuLuIngTbldS9Wnghv+MgKby/qImZYbrGsMXnvvIJ8TwF+A5Lj8NOZ5+0uM7N7MGVNdl2+wjm8phdXb48tKY6++neDXhtFkOnUQfo0RyOv9oym5mqXx8ok6fRfacapM5TNM0VlGhlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWpothJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWpothJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788757234;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI/jzANrOARGDIXcKheERMiLJwfLYURx+CbsUCp04Qg=;
	b=eWpothJtVklW0MtvDvTvu6wH23snr/IH9J7aYYCAuP+solyS7b3MtBkpmX/OZnIWLtxKAG
	Z956Ys/yzRV0lpVRF+NWXhqcALhILnJSSFH6eX8egipT8rUKf5B5PseCTcmbxMuK71qTUU
	gMijdHVfqg8e34UBHwX2SKEFltpOKGM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-zhD1WlSSMDq5dcHRCseXcg-1; Mon, 07 Sep 2026 01:00:32 -0400
X-MC-Unique: zhD1WlSSMDq5dcHRCseXcg-1
X-Mimecast-MFC-AGG-ID: zhD1WlSSMDq5dcHRCseXcg_1788757232
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4859233a9a4so970835f8f.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 22:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788757231; x=1789362031;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BI/jzANrOARGDIXcKheERMiLJwfLYURx+CbsUCp04Qg=;
        b=dFuzBZb0YoOxDBqCuMS16xGg5dkbvN1tOlwc6rZTCXu+JdMTPiFeqbeiJTQxgae/zf
         n5w+4uogpu14+qVHAShiKFHU5fOz82B9+8JBaNU6gCj3q1AYOjiVeoTDrGE6Az6iDXTW
         fvoPxGS2mA7QnhVEQuwGZouAn+cdCjq8rVAPm1Uh+mf+CcFoBuI/JfzMzKbbiH4871bw
         TBPo0Aovksdx6sb7+Mv4NOBqW1eDHshXfdUn+AeQE4aCB0f/ZIQX7dY1PQEGhnbDHhxa
         waEjXALIy5L1R/RKH6XmYsfFQaq2b5+qzS0Yr07b3yxIw1qVlk/QqbDeTHhORsqx3tO0
         wzHg==
X-Gm-Message-State: AFuF++maONKf6+HRWiDb42EQNgSswWCbAx4e20pHm9M96CLBAj/7BYPu
	mayzyhMb0jaz86qs6mfillMzbT6eKrhSscmX/o+4YX6nui8SVwbXRc7qMTnx9/1FTMf9cWtenfW
	fBmJ0B+gb+TNba2whNndUdbvTEAcHnx/MPbvDH08JVIv4z/JcTkHCwhh2GODwiA==
X-Gm-Gg: AYBFou19JXCxkLIyQqtC9irO9IFuwB5nOVH7DtIFBSm9cjW/nNEX29X07skr5T6O6Sq
	+1fumX2LNu0BzS67bGj722qkLgEmcshQGWqKnCCGIVwqG8PM538k8vs/XPjM1bDKIWXWFwAKMPu
	uUtqhZsrO1RmJrj5HMDszRtn3irKUZwOjd3lqk9k5iN2JoYRdu4nREvFXNlh3KzBRUUvJxaZDuZ
	h16UxW9Hcain03qTr7QghZfeM5H6kp8uBMi8yFnP8xf2AuyTYHLtlsenZ6xr0l9HFEY04rdhBzd
	wj/1YNUcJBWJwRJZzGKa4Pa2JXSU0jBk0ZDcAZe3k+1v70FkjQKGy831bHnBINPs5f8tbN2+0Xy
	OM0Nlzrt5dHRjgol7kEgTK0LHR1KIJWlTp9qihpel6YCx7MO/
X-Received: by 2002:a5d:64c2:0:b0:482:e968:86f9 with SMTP id ffacd0b85a97d-4858708cae2mr45418239f8f.14.1788757231721;
        Sun, 06 Sep 2026 22:00:31 -0700 (PDT)
X-Received: by 2002:a5d:64c2:0:b0:482:e968:86f9 with SMTP id ffacd0b85a97d-4858708cae2mr45418161f8f.14.1788757231410;
        Sun, 06 Sep 2026 22:00:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm20432872f8f.9.2026.09.06.22.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 22:00:30 -0700 (PDT)
Message-ID: <3a1256fe-3ea1-495e-8f61-3628613c43ae@redhat.com>
Date: Mon, 7 Sep 2026 07:00:29 +0200
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
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903092927.502-1-suruurism@gmail.com>
 <882503c8-6993-452a-98e5-2eb72faff58b@redhat.com>
 <6a9d5da2.c9eda3e9.76660.4544@mx.google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6a9d5da2.c9eda3e9.76660.4544@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/26 2:33 PM, Abdifatah Suruur wrote:
> On 9/4/26 16:52, Eric Auger wrote:
>> While at it, don't you want to fix the same pattern in cdx/main.c,
>> fsl-mc/vfio_fsl_mc.c?
> Yes - sent as separate patches for both drivers:
>
> - [PATCH] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
>   <20260903092922.470-1-suruurism@gmail.com>
> - [PATCH] vfio/cdx: keep logical vm_pgoff in MMIO region mmap
>   <20260903092932.526-1-suruurism@gmail.com>
>
> And a follow-up for the cdx mmap path: MAP_PRIVATE mappings go through
> the COW special case in get_remap_pgoff(), which overwrites vm_pgoff
> with the raw PFN regardless of the mmap_mmio change, so vfio_cdx_mmap()
> needs the VM_SHARED guard the other drivers already have:
>
> - [PATCH] vfio/cdx: reject non-shared MMIO mmaps
>   <20260906123245.10884-1-suruurism@gmail.com>

OK thanks!

Eric
>
> Thanks for the reviews.
>
> Abdifatah
>

