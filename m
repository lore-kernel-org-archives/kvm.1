Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBD3CF21A
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080548; cv=none; b=DMRpw61oJvuwVERsdxFPzAZTs/TJXiEya640MqbtXTurm8YmDsZXCGjp5cAYCXaspmLokdnMEdS6rnBflRDlZaHjixSVJN3xUf/kr/qj+6rbW92LT6GT6BA6u/huus1lA9NlsSxOCB2sfs6ODBE8XbfLCbr22NN1NNI2fPat0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080548; c=relaxed/simple;
	bh=IQlQ853O8PjNP2nglxYqFleUQ57sSIwybxTciQw5g10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoUsoGA4G3QJv6z/IyuSmOZFDdU+RgePt+CNUiCCzLe6lakA7lvLsOjxS6BKfi5KDpybHtV/MYi9lWRsH8k2ccKtfNOb6ICsecSz6uo0LfXiwWQ0DNIraEZIVzsJUgGC95yr3zyE2B+Hm36uA6Jkc8DAv+uFnFbkR2dUe6VGebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/k9eWwP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l2nvHqlw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/k9eWwP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l2nvHqlw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783080546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q5IcB3IKIPWhgDhh6PrvtGDpcnohukrg0XTP7TxrRmg=;
	b=N/k9eWwPzpn1OJu52M/Et5NSWcdpylidnlgvlmMu8XZFkBAIcHVFOAclxrO3PnB/meaYf2
	JbSGmF9f7W+o0iSwmNVNRG57Y784koWEUWVTOVjwifEMga6xVP9Upoq8BwRkMCJO7W/3TB
	kVZ8TF9K3dZh7xQz3wQouZcGk2d+zZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-dnc6mzXGNGCDhEMqmg4DQA-1; Fri, 03 Jul 2026 08:09:05 -0400
X-MC-Unique: dnc6mzXGNGCDhEMqmg4DQA-1
X-Mimecast-MFC-AGG-ID: dnc6mzXGNGCDhEMqmg4DQA_1783080544
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so3533545e9.1
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783080544; x=1783685344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5IcB3IKIPWhgDhh6PrvtGDpcnohukrg0XTP7TxrRmg=;
        b=l2nvHqlw9WgMLmuRZkiNUKxO61njQZHCUdcXj9UuXqD79an+Li2+3ZoSk1wW3HcfjQ
         S+5yECGybDHO+XThuE3NHQba/Jw/x2GlHN9QmSJDJY428iWo9ljcoFNrs83m1itbITti
         6nRSMCwsfOSSeJjiewK3VdFKOF0YLlhnAbM2et/pyh6hFZosLCweHrMqPqUwR6iE4j5q
         t007CG3K6haYGrd/ygA1VmKc2DvwPZn+WWX9D1ObfQejA5lhBceJjB6X14DUPmU+cPMh
         TIeL/oLABGo9WQyJeWWLMdyWE3pRFTzFHnk4t3SyN/5m8COeLbf83rrBYmVx1gqOLxNo
         vadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080544; x=1783685344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5IcB3IKIPWhgDhh6PrvtGDpcnohukrg0XTP7TxrRmg=;
        b=fUy+pJVw5iPlnH1JyNOEfw5nwr/LAnVaXB1y8/IiMyMWysPsVozejGk7hGM2ZiuVfi
         bSQlo8ES79TBI5njRcQsw0J2/4J7zosUT3DsPZxpn4ANUEIhak4oD84GtUFJDU+m5Qss
         FzPP7nokYuf20oymRwtKo7Wj3IffgT3e7brp1PaDEIa3PCB6cqAQP0KBfwv4B+iWDuWm
         +jYXrGxoiP1d1l5DwP9KLBUeiOJ1fogZkkxeKEOO1g+WwHx1yFhMAoK7PdpyYtSYsROo
         ErlX2yGlsdsGNIrPc07fl46BP0p1hnB/MktrZWpCfe92OfIpDT29W6KlcD+TkeJ7aD2Q
         uKaw==
X-Forwarded-Encrypted: i=1; AFNElJ+Xpn6jELRqseqATu4oZqLPvoASPBMNmut2M3W/ZqcFmZfUn8QQ2No7uV4JsH3b3TAfifQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEAkHFlEW4MUZ4wL6r1qkWUNz+5eHenQccJu/WLpWosi3DyKX
	MVCzxcilVQ9YyUqxiC0HpNJfzzI2ef+Cq24BURKDgF5Gizc9e5cY0l4RYLYu//eaFJTH2V0Jyg9
	ezvuf4PpFm+44LNr3Z5OYa2800ievW8m1RihixeWLCyNKsAfstQesGw==
X-Gm-Gg: AfdE7ck5jLj8+SE6cM9AjpW1s33EJtpKpD7CAmyS5js/NEkBzZVNAxazXruQ+tWv22/
	GhPI6LCUIMwJGps/Pn6yFYks13CB/oIWAxGM1YEpJ8DTKWJnoSEtvUhtDJ41Ph46ZrCg+3AQ0u7
	/Nm4AFO03TIWl93FHfvpoiSTIquGIcoKOnwv/MXhDc1wGxHPBB7mYVh9D7GEGwhLhG6YexiUuOI
	mGknEv4RXIzwGDnFQAs9Eoiiyy317e4qV/8eBSujS4vo4HcU+tsHZmDxt1n9cwWekTANXUETcgU
	k0BnU2rcaRNMsreUXgGBRqrP0Znobk+N+ksP/zvCnfuw4Oy54eWfZ9M/WUlNqebX2gc/YryZAj7
	zLDlNuQVrlKAaaf168W7r6/45tknVPEU4RhTPDtR8VAtPW06NUw==
X-Received: by 2002:a05:600c:3484:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-493c3cfafd0mr127404525e9.28.1783080543877;
        Fri, 03 Jul 2026 05:09:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-493c3cfafd0mr127403855e9.28.1783080543437;
        Fri, 03 Jul 2026 05:09:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63b6f8csm115805355e9.11.2026.07.03.05.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 05:09:03 -0700 (PDT)
Message-ID: <7d5bc446-9581-454c-a678-73c075af7fb1@redhat.com>
Date: Fri, 3 Jul 2026 14:09:01 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 8/8] MAINTAINERS: Add self as maintainer for
 PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-9-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260703085955.2318600-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/26 10:59, Aditya Gupta wrote:
> Add myself as maintainer for PowerNV machine, and remove the
> reviewer entry
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97dcc78ded61..537b5cd895a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1663,7 +1663,7 @@ F: tests/functional/ppc64/test_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Aditya Gupta <adityag@linux.ibm.com>
> +M: Aditya Gupta <adityag@linux.ibm.com>
>   R: Glenn Miles <milesg@linux.ibm.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

