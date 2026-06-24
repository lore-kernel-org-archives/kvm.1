Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE22D0C62
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301960; cv=none; b=SEhY5vuvtKHdkNAuBLstpfPwDY0uhI2WN3GYsw72V+bXAu+ipDb3/PdhnTE9cdCX0SWBLODSxWmZTRn2b2OXy0uAsA8vSh8FuiMv4Ip5pm4UHxkCzkKRarEKdhcGKEGzzvTEzVW1nSuFIRxIFOnH7PA9XF/OL3S7RZSWHbCM5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301960; c=relaxed/simple;
	bh=AryCxgBSf/UR69m6JnBiMpkcrv3aMbc0TncTT2zIMmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMx1dRQsMWfpGYa68rMgygNvk6c/1r0/ipJ+YkhD7BlQOzINckpctuzXpTJIEQGlkBY5MfqvYitiGDUXSFKWg2IzWlsTXhUO3fEa9I4p3pMKgsXgECe+CxfI97ldDuYK76V2cGg9blZ2Bthff1cClbgkLT3kVhH+0dNuPZ3DDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOzNIdYQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiloGapH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOzNIdYQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiloGapH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782301958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
	b=UOzNIdYQMlJ3Lq6sgsxKfSKbfNtVfhAt8bndcWzcv74GShD7Qz0xbD1mHF5inJ4euSVrtM
	RDxQ1fGrb0GZFGwqM8C+ZloOLERu3Su7H0qj9E06kFKPK8I9S+ANZdaHUsSAPx8sDW4ZpR
	KUkudxYsQf0+9eqh9ZrXouqlCZatmf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138--BBD8jcmPpqDu8pli4h9Ng-1; Wed, 24 Jun 2026 07:52:37 -0400
X-MC-Unique: -BBD8jcmPpqDu8pli4h9Ng-1
X-Mimecast-MFC-AGG-ID: -BBD8jcmPpqDu8pli4h9Ng_1782301956
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46c90c8fd42so316278f8f.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782301956; x=1782906756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
        b=WiloGapHIFaFyxNp1pd3BxRqNoj+MkUcXZrCIclRrBm44oSzxw8XSdUFDXyD3qNfE3
         nD+LChlFpP4aDRu8HGGpxV64Y6UgAgcpMYrMW49TE2hCUnztRZPC6zyAyX/LoeaTG5wq
         khNG7vg7SgpxlygMtXcEnAVTumEJCw6zVET5qN/L0W9+bs5X9yZDZksHoycgZFHcH9/N
         y7ZJq5PqbF4VHuqpxgnjqVw12QE04A655EdbIJdv6uyXXvThZ4katdCTgBexpd+/gsrA
         MiPlOt1Zfy/O8sntfCFyyfmoUkB58Jhs4YgmtcTvlrZAzoADX99QvGDtqxyzNtjVfWLn
         O8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782301956; x=1782906756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h4Xdi44Ng4EJRiUfDjYU6MeDGPjtcioVAHRbWOPb2o=;
        b=spii1p5MOALE+GrcF/gjf/OP+7VAJRBjOM/3OyEiXTuyVO8Q9ZsfUtcAW2c5bX1zBP
         FczYlXGDwa9QaF+kmG1f+OmHowZ4ywuMF7wjPquFr1IyaEnsnfnpjhzi2exN4cF+9wfk
         GKt8yYH6H1rNbVDT8PaOQ2gZ6X3cjo0UTf9iMkhaNDcxaj/iyXZsFyL809OCFe9zn4WK
         tnNWHYaiV8ylmEkXB+ENOBn4iRyv3L67pNQCEggad1O4LOFbOIs21gVNHINozHst7ZqR
         xs9zvAgOFZ+pmnUGBzsHYZebchb4qo00/BMBONldBlHpg80pV9NyFwirVr5ImrNTWGmT
         y8hA==
X-Forwarded-Encrypted: i=1; AFNElJ/0DSHsS8KL/QdSesrwESd+QUB8oN7bKZLDBvn0MykaYP+BFccE2keWzztbwL2LDQPXbrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tSdyblI/9JP14ZdFm0KApu2Q0DbWjCgvMxTqSWV06DllhrzA
	ecjjZyb6hb/cSXwHsqo2FR/1xMsvPVko4SAXRXLgyIObJ7Fa7HZ/K98bY8rzblsoRBpVfRWNPA7
	9iSkXaB3BIu7RtR1YRl5YXvJJWDvbB1ABC99PcwkJqnibAEa374BQMQ==
X-Gm-Gg: AfdE7cnfHLmgiaMT6vOabqSDunNRZbyPli1Jz4QLDrc1hlQTj3Y3158TbnNBAhqFhRS
	ZAO86S+KFgh75Sik6vESpvZdGY9tEezYhtiR7wA6oJKWs0KcX7BEeVPQ3m0AlbEwFqHplLqHIpf
	vE5BGQ9cdxDkWnGiaUuU9gcwkJbfIijxwF0m03+QlsNqgqM6iHSk7m60tl9Q5CFapjb/XGUh1fR
	a0AfbrcA8LXMex1jAQiwHDKt4p04+d4/ztPMlyBJxlyet6NSgw3upMph85oHBCfFuWzajCBwO6i
	+DoBfp3rSq5g6Ax/VJi+py9SSlLBl2YrL52nV6+Gl+cN1ywT0suRpTknXEqubsiS4s+RwGVgyx/
	luBmCBaAd+dXDgXTrQwXQZYkrU69JXfTB5/u/wxrRK2teD+Cm8Coxv14=
X-Received: by 2002:a05:600c:630f:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-492608785a1mr44617985e9.26.1782301955852;
        Wed, 24 Jun 2026 04:52:35 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-492608785a1mr44617225e9.26.1782301955317;
        Wed, 24 Jun 2026 04:52:35 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6? ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm482795255e9.14.2026.06.24.04.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 04:52:34 -0700 (PDT)
Message-ID: <8bc75e1c-8f4a-472d-9265-c9cda0681a09@redhat.com>
Date: Wed, 24 Jun 2026 13:52:33 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-9-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623141933.577981-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Nick,

Are you still active on the qemu-ppc subsystem ?

Thanks,

C.


On 6/23/26 16:19, Aditya Gupta wrote:
> Add myself as maintainer for PowerNV machine, and remove the
> reviewer entry
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f63..67f65bff3913 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Aditya Gupta <adityag@linux.ibm.com>
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +G: @adi-g15-ibm
>   R: Glenn Miles <milesg@linux.ibm.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org

