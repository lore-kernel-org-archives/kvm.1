Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056330CD9E
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955814; cv=none; b=S3+XPWIa1ErVVdS+3erYbLJXOIuXAxFhUP6Gl/ymkA3Ms/0IVSADPy/S6p+L1wgL8USEBtkwXUacokUZrazjwJQJRsD8K8ASQpt4PsDfy9HLFB0eUu5mWs1BJ0CCz+RZZFTkkbNSRzGK/+l+Lg9PtvPwhhL2YI+ZmhCg+Q5ksVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955814; c=relaxed/simple;
	bh=Mc9Ivz4Vqi3k0d4nNCkfaFzAMJGthygwguiunClkBVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTiZN2rXOafNcocHfPFOapwAo+SEkwQeVsCl1t5hYMLlKt+JSczEO946Gwa8fa2bSAHkd+lYcBYH5+oJufpiWDLSixkLl95BWJK/MPkh3HRnITtMqTjHYqJfTySLg2v7d770LC+sJ+OjjyJ9sVmsZtYznkPXr8lQPgu8PZUfJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayoH2EWC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=caFb9AfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayoH2EWC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="caFb9AfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776955812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9FCzHmWnVVCccSekWVzHWb5njrn6p7+7lqlQWHM0xY=;
	b=ayoH2EWCiJ7GHnml7fm1G7nxCx/5aQDjpCTZEd0eUaaLKuLEN9T9Rx90sgQ6LmNNnALmai
	IRUJF0sTr34s5p/qpwgvFc7UqJx0qosLeht4vnIVXvpsrUM6IY616agnH1SNBWMMojKE2F
	HFwWLCboQ3BOEJvF7rP3p06FlvVr0so=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-EJUhTmLRP5uJtmLOGnK-xA-1; Thu, 23 Apr 2026 10:50:10 -0400
X-MC-Unique: EJUhTmLRP5uJtmLOGnK-xA-1
X-Mimecast-MFC-AGG-ID: EJUhTmLRP5uJtmLOGnK-xA_1776955810
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ee9a11aa75so591771085a.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776955810; x=1777560610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9FCzHmWnVVCccSekWVzHWb5njrn6p7+7lqlQWHM0xY=;
        b=caFb9AfVP2PMzQ44LcvEB+VhqljJBvIJsPqIfqLqlhgzT22qYQT2Kyh1N+lyfefTSS
         glXyUKbmwVzY3WHh1VEHj4r652BaCmCveqJMaT65wCj5sztdk8YUlCBcneqsPvudUn5+
         20WyJyHkhy+RhrHrjM02rrikt98A1Jbl+4Zv9bAeKBLl9FCpJUZ/QiKa0L2gY/kVH8b4
         pGdnx3oxfzvtcv7CA9pfKFecJV5YAQTXStRNeLmVY262C75kbqg/RJGoeV7/NxvRtqKT
         cbaP1KEQxd/x5F7NkzwvUOwOPUZ4Ar2MTE45+F4r3/3GCT9c6zCCDMk2WQhwuzAngkZ/
         xL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776955810; x=1777560610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9FCzHmWnVVCccSekWVzHWb5njrn6p7+7lqlQWHM0xY=;
        b=XgiskUV2rHFleo467UXOy8zqI14PETL6vgwLgUEavJliDpuwM6Vy54Wr9gka1MBohz
         UwoXmNPFJvlaFnQH0bGn3GMyG85W/MFo2tn3DIa+hunzlyH5vHP/N8tIAODSeZ/doS7S
         bQvmAQiPk3GSn4UCf/Iq2PK1HuskoAi9+ShwlEkAWH4ujWBsI10LjaEQJP0ezbaQDsNQ
         u0ICQkMxKDLBRXxqDshn8ZZuaG9uIa4FwYdik13s3vGvMr97Azout1+udkWX4X1bzSSW
         eX1phbaboYHTKJb2MuojWH/3HorSZs7LQeQFcwscBGiAtIFZhC4zDal6TzJFN9mWnTYc
         tRXg==
X-Forwarded-Encrypted: i=1; AFNElJ+T+l/imaYQSDAQIFivebpWdvvrMBpZdZwSA3V0zw/sB/u3vCgNaO0kHTpI9QI602J5Tug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhh5gY9XhjxUCrUJojgo7rVmFY3xFcrrCTrbk5f8d7Wl/q9ZB
	LBCe3QQM7/7+G0mZApuRf4hv/WI0erT+vK+bVTjnDlGoln+hteS0/hC8aWPmyhTZyiNJSD/Vgun
	40TioYkvmb2rzhIXzJg/LC79Hzq/mHc4/RSjuvuVped3c/KzPU/pBmQ==
X-Gm-Gg: AeBDietUrpg2BNCmZvujIpqi+CwGJv5ZD/Cj44QuVsK1zCa2xrcXUlmQ/ON8kDKLxrB
	0W+ADvl9a+WSRTpQlbJl/v94pLGLJFCfjPWAX/dt49CfINJgVhe9Llt9yJjMP7Ee3t4oKly7eX6
	DuJMyVFnUG4dstMisVIesoxudxMuJiPokOdgrOlQqiPfUtREHeZIBxSTaP3gjR9d1ugnzqeGaYF
	LM3SDS8Z890yTwQZ/SjwMoZwi/dIpqnAoYDPd3lRq4joWWbOOrkMGsyMoB2wf13F0gJ91AVTrmh
	5DbGJ5pWnQ9aqvZ+jQaXR4JtT7H/TrKmZir+ll1toloT3ZlvcXXBgErRFyUk7AcDw4fSYanPRVE
	XSFla4hmurjdHppydozwLWk+dOIV9Rk1QeiEEvnzs70TMLpUvc8pKkUYCHA==
X-Received: by 2002:a05:620a:4084:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8e78fa1dd25mr4108116385a.5.1776955809710;
        Thu, 23 Apr 2026 07:50:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4084:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8e78fa1dd25mr4108105885a.5.1776955809008;
        Thu, 23 Apr 2026 07:50:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d98c15a9sm1850297485a.43.2026.04.23.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:50:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:50:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aeoxnuGKO3uqS2kG@x1.local>
References: <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeorZMvKwu8zKX5i@thinkstation>

Hello, Kiryl,

On Thu, Apr 23, 2026 at 03:27:11PM +0100, Kiryl Shutsemau wrote:
> The patchet is pretty good shape in my eyes and will probably drop RFC
> tag.

I still have some high level questions not yet got answered.  Do you want
to answer them?

https://lore.kernel.org/all/ad59TxAHNwFWH7Cc@x1.local/

In summary, it's about:

- Whether we have explored other approaches on page hotness tracking

- Whether read protection is required for an userspace swap system
  (e.g. did you get time to have a look at umap?)

Thanks,

-- 
Peter Xu

