Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A895277C81
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922942; cv=none; b=CcOSzHHUR1jVv4epD4WMfxqve9VzO85efV04XaTydf3jSFE7HQsLIgeESng08cDNZtYfA9an2GaOPoje2/OD1E8mSW3WnCw9EMzKGy0e3wZ/1FlOVkIqzzba/dzkMHFWPVsXhKqeIXpRXAvHodDRAhMfo4wlzooKx1zQ+6P6/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922942; c=relaxed/simple;
	bh=S1qZmtftVLAF1cyDOhOGZT02C/tfoJu8CkLtSfH5UyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiy3YyBOj20VCa8YOK9SKKdm53VhW9mTM1IvP/Xzm+pfr9xkOSe2nUHtYFujTz1O1qFvN27QCKGOF3vuhUEgmdt10yZ8AMyxnOgYrS30uMaM+37CS920lT4ZhhAdyqv7Q0J06Beirbg3prDn2poxjRUkzUSSDoio3QM2w1DNxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0tjozC1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pPMxDzyW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0tjozC1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pPMxDzyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
	b=M0tjozC15PaOOHr71Zp0PwN/isI/DqE511GLQSv5r8WWANVZv/bAfmCI1871Gf5qUn0Hf3
	O7IAtCRz5Y6EUhYsALb2QzE74r40TboRTda3DKIPfwAVc3VZm+tFsfltLlqg+CPB3Ozmuv
	4LENgltqzDJWQs8OZQhTtBSJSNog7/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-L8gL5qEBNLqXGiKXLmSDPg-1; Mon, 08 Jun 2026 08:48:59 -0400
X-MC-Unique: L8gL5qEBNLqXGiKXLmSDPg-1
X-Mimecast-MFC-AGG-ID: L8gL5qEBNLqXGiKXLmSDPg_1780922938
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef63d1214so2811914f8f.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780922938; x=1781527738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
        b=pPMxDzyW4CbftxDh65WFqp4yu8EGG/eK55GsaP6y+0CswPEEEnpaeQDNwpxz0QTGZe
         6FXfMFwPeIy8JIhx9dTSWDO4oiMOpqw19G9lFaNav6VnYDGRTVeVQBn4ik0/U3N1C7qz
         EOz0qfL5p6Or33aF9qq16gxTrYXhkXyPjbtHDvgcgUsVCLDOu3rgKo1jWSerBFwcC5Ke
         VckogEb6d/Kcr7iJmS08WUWcRt8a75JezIsa2Y1NsjFLGzzyjZrxKcx2uN4KK5lF81k/
         fGDcfLbAtsjIF8aJHPa1IqaPMBgywRddvj2kxX/guJ3O3hvJTEIV4H4EteerT5nuorXR
         ijDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922938; x=1781527738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N12o8wJNxfvgAwguu0stKJ3LYzNmqODr7O6RIf4oEw=;
        b=GjsgLb/xuY8NqbqHFHzYzIDoB9bjARpvuv/wre5CyrqFSl+GkWYQbb2iaCsHW9lt/M
         e+3XfqsevEzDRVqJH3RSaDd3j21+JB7rUpsHqXswHIJ0OIMJ00c5vvzMsRMlzCySRSAK
         8x5ILCRnIHbz5tI+/e0Px/w3bucNu8Bfj/zsWpCBYeoL6/CJT2afa8cpsVV25cKMBj/E
         dy+1aaVvSnzoFKbmOZjDda11kV87gpd/A0L64ZJ0U/0MVHfvScw2pHQ5sqj30jBgM604
         lkfuarXIIY+NoF4S86/+0gX3FsxDxyRhZC1RhgQoH+beuni+cIezJgUiOuPh4eCK0FV2
         DLmg==
X-Forwarded-Encrypted: i=1; AFNElJ/14BzhllDmEp3M2sB+tLMKAPDBA3RzxRT1OB94TruuzTPQ9napu7AKGTw2//YTMFGUFl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfCb+/0mpT5LtxFJt9yquMhmHJYWg9Z4lO3w0aAx+TqdGskel
	mRVzk3DMNlRdGmTiWTyax7Ld3JIeq/a/5lbTms65KzxcZp5XNxqb1HdoAR0tuuotAgGaXoJxDFX
	wr3ifqvN0vS81qNO806A3X1bIbLVTFJi1j/zJ80tRY3vpWIse4a55To3o13lqsQ==
X-Gm-Gg: Acq92OGQcPKQzkKK5sLAGy+Sdqz0W+JYYnYcULEAxHoPLX3TC2FYkp98ygycXNFU+V4
	VdXGQ3JLtFJOsGvoGojiufi3YDRsMmXBmTPkQ9PJwM8tUpNicEdj59X33bcvNhNYcE4rVE1Skgo
	R/5XcTHLmF8cFm5wjyS4GYGrmy0kJtDKUTAuQMWED4OEPu8osU3CSLoK+g/xAxi8AYMazt0CUks
	T7/hXU7Dgk6CBhBA3vJsGn3gL5ns6h0On+PVO5JYRI0pEdpTGm69HvBOy7Zyf8pc4apHItCUjgc
	Dd7/rvP0iA0nijKW2+59DlpS5zEEE4o4bmrJtMLZ6A0z5Az5Ntrn/hOizCUSlQ2m6yXHEsd1vw0
	VbXD5vzVii/pIvtCNAOVMfRx0ZomA+w==
X-Received: by 2002:a5d:458d:0:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46030631c25mr19295182f8f.21.1780922937974;
        Mon, 08 Jun 2026 05:48:57 -0700 (PDT)
X-Received: by 2002:a5d:458d:0:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46030631c25mr19295150f8f.21.1780922937604;
        Mon, 08 Jun 2026 05:48:57 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm54213965f8f.1.2026.06.08.05.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:48:56 -0700 (PDT)
Message-ID: <e375b2ec-3f60-4403-8b0d-aeb1d6943f65@redhat.com>
Date: Mon, 8 Jun 2026 14:48:55 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 4/6] powerpc: gitlab CI update
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-5-rathc@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260602064806.3101025-5-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Change to using a gitlab-ci test group instead of specifying all
> tests in .gitlab-ci.yml, and adds a few additional tests (smp, atomics)
> that are known to work in CI.
> 
> To control overhead, ppc64be is used to test 64k page size, ppc64le is
> used to test 4k page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   .gitlab-ci.yml        | 53 ++++++++-----------------------------------
>   powerpc/unittests.cfg | 36 ++++++++++++++++++++++-------
>   2 files changed, 37 insertions(+), 52 deletions(-)

I don't like the idea of handling this differently for powerpc compared to 
the other architectures ... so please either also provide (separate) patches 
for the other architectures, too, or drop this patch.

  Thanks
   Thomas

