Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF8351C2E
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265299; cv=none; b=mhXaaDGxvQUGdqP2lYKwWZ8eMzHw4rBDH8OQX7KwVtsNb0aI+YzGm6dxAgrNu1ueksNgdyn1U4MyNQJSqTdq0Q+pu3FgMI1i/cr/swade4CH3EgkOgkRBW6B2oIxxpq+HbVbdp8m6GAjWqiycBCu5V11kGvCDxXm0ZXZxcS9wNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265299; c=relaxed/simple;
	bh=tFKv0vkMLf6t3Ni8qeN2X/uZan0G4lZvIYXhllGF/9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4Qid9Jsd+NWbvUs8edU056fLgzly3lr7sh/WDOrMF2fpTY1p0Uu7lZGTpswBsCkbsPsAqIF4V08Ju3YZuBINHdt21T/QytDFN1JIlqP2j8OUmg643o0uWAnRhyBOjvX0cmfJjkcQq7bE9L6F/z/g4OG2pDgOq3op6nQuwwiO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq93kBnH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lIgsJtr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq93kBnH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lIgsJtr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779265297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xc/dl8E/8KiicJnSrOoTI0FD6ccjdRxJKSRSKYY+tgg=;
	b=Vq93kBnHW35OpQPRSTdlrpVVMKjG3akaMbUj9i8QJ9U+AEo8CZA8+myCx/DPncricdeRio
	NlEWJelP2emj66kHKZ86AcxDBrkgghkzTmKpPQ91FbXsWYr6TN5y0/dXYwma2bAooDYt+3
	SqYpM3APdGr38f6KztziIxgsA8cvPtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-IagyGYiEPNyW470MKv6j_Q-1; Wed, 20 May 2026 04:21:35 -0400
X-MC-Unique: IagyGYiEPNyW470MKv6j_Q-1
X-Mimecast-MFC-AGG-ID: IagyGYiEPNyW470MKv6j_Q_1779265294
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso33954475e9.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779265294; x=1779870094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc/dl8E/8KiicJnSrOoTI0FD6ccjdRxJKSRSKYY+tgg=;
        b=lIgsJtr6BuLsPzHusd80uIxswpvnjoB7jDxGDVn7+JfZGV7ng2lnSWI/qY08MR4Jgs
         8sf0fyHz8u0d8eJWY3uFG38P+tgmvneebGWsmSKzgAkPefHYY2dCs49CS/wVbVruy7vZ
         0YyoPGt2w7DrD8pKu1mMYrqWIKXSPkQxN6//aukBNceeigy4QUQxPsVZysFMI0wKgY+b
         k7Tyt7YcLWdkthnKdI5QnY9mOD5TPp+Pkcu5cd2eufwbWCP4N4NcFLWALBOsFbwj7oh+
         vy0xQb7HTb2ixKmw4elwKpju29A9h1B5LOisQGMVvrZkH6H865Qiq2lSMx6oIXmq1lLp
         TPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779265294; x=1779870094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc/dl8E/8KiicJnSrOoTI0FD6ccjdRxJKSRSKYY+tgg=;
        b=TzuNjgJl2ghTvRoDh5chspnM9ZBcqx1BGPxXkccDyuqzgOyFWjJC1jBuGasFwRsssX
         JRSEqApQljQHk/j69oKyhAaK1v0e87DPPywD2qc4/Pw/tYsCj8R5Brv/20kqhwX8CFhI
         vGsF9d+vO39YcpTXFUsghTexv0sFfn56DZKUGg8P631Pdk4CV+l6/GB2MCOxJpAGB/7w
         LR5O+mPdtYp1n2BZUzw2cy1tESoWUIVu9GTZEGGBSjbpFsQTJSwyqltIyW29AIGP+o6S
         tQmESfxU1g+BUk7JtIQ4c1q+XUdocJWNblKRyX409amYmM+20KcvInKvQdWDza/JN7a5
         +hzg==
X-Forwarded-Encrypted: i=1; AFNElJ/VLe+qxaBBmau7xyKCpZrD/wDyylHdtxqC6JZEBM/DwcHcffVrAvKUP4K0IJzIbruodd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycAebEVV3jg4aEwChjYQxgaon7/bWSH7X83i3B8vXrMxSv085B
	1dQwjIe6tljRTRWYV0UYfTdNDoAaVB4Fzk5YvXnzrjdRyoxMvgGBd7+U0E3Y0Q5YW2/LFny9Eyb
	HB/ZKUcptXKY4h0ktmF3XNlFT153VZXveZDgiDWgg+oXFPQmWpt8lBg==
X-Gm-Gg: Acq92OEV/jGZUWKKFgG9hWm+8jY/EfNGKO1K0q1Vgb3VeAHiK1mb0cnyn9gZmqYV3Ey
	cODpZRC1jH0F4H7V6AuIAIEZJO0s3i4nQjWt5F4PvdbztLsAxXcfuINTrvFZAy5bvj7t8F3KhOO
	+MQDNtG2SJv0SqHO8kNIsP5v/GJAR0scoTwUei8dBJ9xqRqVvBjoBCm6Rn3rpazZwF+2R8SHeS7
	TNXOsddUfGDw9Zgq/cuu9ulLoNLQIclb4p7HxyUuIgfMXo1YmjWlBfmt6xgR7Lv2l6dK2bKrVwd
	Cbrm67d5Sq59TtlM2myvWv9Pi+EhPcxFojT3yghKDKfRq6mZXqIeiziWWhuG3iB41scBzvvK7q1
	1PFoIXZSLo33a0kaIGEU=
X-Received: by 2002:a05:600c:6098:b0:48f:d1b8:9ab1 with SMTP id 5b1f17b1804b1-48fe60ecc51mr396929675e9.9.1779265294482;
        Wed, 20 May 2026 01:21:34 -0700 (PDT)
X-Received: by 2002:a05:600c:6098:b0:48f:d1b8:9ab1 with SMTP id 5b1f17b1804b1-48fe60ecc51mr396929345e9.9.1779265294120;
        Wed, 20 May 2026 01:21:34 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm52004421f8f.37.2026.05.20.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:21:33 -0700 (PDT)
Message-ID: <b1782e77-0d89-4a73-a54a-07ed3c4f1bde@redhat.com>
Date: Wed, 20 May 2026 10:21:31 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests 3/9] svm: add basic GMET tests
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Amit Shah <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
 <20260326145035.119519-4-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260326145035.119519-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 15.50, Paolo Bonzini wrote:
> These cover three basic scenarios of running successfully,
> failing due to NX=1 and failing due to U/S=1.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile            |  2 +-
>   lib/x86/processor.h |  1 +
>   x86/svm.c           | 17 ++++++++++
>   x86/svm.h           |  1 +
>   x86/svm_npt.c       | 83 +++++++++++++++++++++++++++++++++++++++++++--
>   5 files changed, 101 insertions(+), 3 deletions(-)
...
> @@ -390,6 +463,12 @@ static struct svm_test npt_tests[] = {
>   	NPT_V1_TEST(npt_nx, npt_nx_prepare, null_test, npt_nx_check),
>   	NPT_V1_TEST(npt_np, npt_np_prepare, npt_np_test, npt_np_check),
>   	NPT_V1_TEST(npt_us, npt_us_prepare, npt_us_test, npt_us_check),
> +	NPT_V1_TEST(npt_gmet_null, npt_gmet_null_prepare, null_test, npt_gmet_null_check,
> +		.supported = npt_gmet_supported),
> +	NPT_V1_TEST(npt_gmet_nx, npt_gmet_nx_prepare, null_test, npt_gmet_nx_check,
> +		.supported = npt_gmet_supported),
> +	NPT_V1_TEST(npt_gmet_us, npt_gmet_us_prepare, null_test, npt_gmet_us_check,
> +		.supported = npt_gmet_supported),
>   	NPT_V1_TEST(npt_rw, npt_rw_prepare, npt_rw_test, npt_rw_check),
>   	NPT_V1_TEST(npt_rw_pfwalk, npt_rw_pfwalk_prepare, null_test, npt_rw_pfwalk_check),
>   	NPT_V1_TEST(npt_l1mmio, npt_l1mmio_prepare, npt_l1mmio_test, npt_l1mmio_check),

  Hi!

This seems to break compilation with Clang:

https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14327138344#L1671

Could you please have a look?

  Thanks,
   Thomas

