Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFB3A9DB2
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742233; cv=pass; b=tIw3WXfNKzdmlo1wYtLjLaLIXaXydhUcx0ql5dOLU4dVZ+HGVDFvymrA0k/ZJ2JR91NOGhatFCFiot1bzwp3AwYpNDjF9bRZj+sLV5na6AdmxCK5+1M4Tbx75bTx8hf4dERlL2OYTmD4Av3fHVxOH5PsFI2IwacxrT8eQLUe/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742233; c=relaxed/simple;
	bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll6ouwopyp1LwFwk/zELV5NmPi+tigQvTjFJfUu58mfuFcsPvtVDVETYqCauysZBVhvOrWo0vQ3RDtna4aP9+Zww5lLHqEgkUJypPjdHWRy8xx69MZElltoTwMaNHBkL7qxoFQu1x2bBeADfbsTrPWHVBQCuOkM4bVqZvAHt1Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGJZ0+Xh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+aJvIpz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGJZ0+Xh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+aJvIpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785742227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
	b=AGJZ0+XhbjUJi9/e9lLwBK0D80lF8PMuQRBJ7LeCzlIkdEBJMLkiAREEf0SlOXhQG1XPkF
	Zvifc6j8V+hhvtyLGX0tjhmal/xDsgRxPEa3ZyPW5ApzUP3J1CZ77zk+SL/c9O+1MFX88f
	C9eA7UW4jYSHpndkb4K4uFW7fKsIJvs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-VFTkHkFHNNKYEIE3DoR8-A-1; Mon, 03 Aug 2026 03:30:24 -0400
X-MC-Unique: VFTkHkFHNNKYEIE3DoR8-A-1
X-Mimecast-MFC-AGG-ID: VFTkHkFHNNKYEIE3DoR8-A_1785742223
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso64820066d6.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 00:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785742223; cv=none;
        d=google.com; s=arc-20260327;
        b=d/3LtXTvga/k/OD3jMgUuCRH3wWfFBwt923Ouaj4Y/5Bdi4LIMxMJ+hTGY/rfbleOK
         B1mxYr4Gg0Z40oGblxmFslyPRLHiVx49sW4d9KZ3JPSfKBZ2/CqEFavMcYj7cItMFExB
         JwlJNnze9AOwupn4K56LF0YGecbyGa8ChV5XSRTZYLv5tm1E6pG9SX8St28CZmHOrhMZ
         I9nJZ+e11djEwK4h7gnWY+GXwt+wo5usHC7sUVY514rbSvPFNRr6f9SnXCYbqMhb/Ujk
         GVzJ0qC6uO32LQdA8yrn5HYJWNpB0maoS0WCQtzEN7+eJBo5y4FSZhjuQMsZCXn1ei6m
         iUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
        fh=v0NOrBqnhMdBnq1N6jbriB7id/j1JY5b7acZGJbCV68=;
        b=VEZ+1AbKBXVc2D/GyNXJ7QR8FqzU9JWzIiFjI0NVyzoWBJZOgCVjf9JQIt3/PDh0Ep
         mx+ISrW9M5rV9Hrn82AOIx0QZk7H9gvGTr12D1KC9XUgic0+kMfeMz1/Bu6K5VQ6+Elu
         38fvazN3j20g3+pSaa6LoSKKh/uI0acw0ZulqVQheq08GDPWG9ZwbwRGYUs+LFem8iW2
         UBx+BdlmFKQATyNPETat1KGEckxOx6yB0N8xXyS1tBQwu01Nxqp6PdMjbjlHsMnbYXV3
         SdWZaB4IPsGwKH4qRm0CexzPO7CEQdVnVZWHEEvJh2XZlgyB2P7YHHjLy2KkvxfRk0ol
         QPRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785742223; x=1786347023; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
        b=d+aJvIpzrXyeedt0WE7SIeVNYX9Zij3eWCtd2EN7sggsinVd0Ls1/Bf/HKwSno3nNN
         4VnE+Y3MUkRI7aiYpYGsv5Hw3Jq1ZMrgUEP5ug3vqkXavmnyTCKbiZm6BreRl7FV0zli
         IPAjouGvAgH8XL/GHtn6djS0DmPw48RXmwo5Igo4h7uJGpyYY56/dJCrr/OTM+U2etSn
         gEX85TqxtWGE9kFhc970dx2dhFkGPI47E6sPoLaM8uUcSj1psPeJQdroa62yrjfuB0rW
         0D1v5TOBmS8sw+1IzAJ+ofxxCxXvclMmCeJ7J7A8DTPz3tE7duURFOk87lTrZD0p1Xpw
         fGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742223; x=1786347023;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZHfgjHxp7rmkfsNqOH842ODn9NiNueK5c8Sz1y2gF0=;
        b=HfxZq58vEsydw/t56ZYsY7IVLdD8LLNWFNDNTlXvIuTJGjrNTQIrKLJFo345m218cH
         Ob/K9JDjOA4X6j1XGnniqb/KlxT6ZaPXY8nClLGLPwkmQcPHAL4Hc1gZVZ3YQ2L+WuS7
         VghdrAxG2LfDZEzctDh4bQ3lxrXdwWIhISKwPXhyfMx4C+LmrUGARSEPMmXOnAvI1JHO
         f30RHIg+6F+iJGCyuie6DwsnzDRomb6qZQf0QwGd2qIkrpX9EKL1EORiL0iPSKcLPXfT
         JH4TzyOGF85y3SGtpwQjz4YzQAxipzvwip109CSUqxsoZ354gv/kZG9xBM7Su6x/aCu6
         G2ug==
X-Forwarded-Encrypted: i=1; AHgh+RoHCY8SyL3JY1SxPiIxrUtI0J+wHPzQtn1/KJn8oYxGh+Kkg+m7Ww9DUT51eDIXG6k5WcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRNREuTf6jPZqyI3/VXDx2SN/x8b6z9ptVjwk6Xlwg7eNsBO8
	r9I60tTQlT2qKgJ6GqA/pYq054F+jumr9xA6k53GmefCLAwriP7aNRplc10D0YwabuMZjoLb3ij
	/vV9V2B9xjbyTzDGX4Uzyoz8aHQlnUmGWRp0JWste3pIUXDmQm6mgtrN1X0597AkumzfXVHzJl7
	dQAheaNO1JAtiE2T9Sc3d7oN+JAtgJ
X-Gm-Gg: AR+sD13+9CrIE60o0cOuFzC+zAxsVqcmIg5hO1Gaun4L1MT7U2a7D+fBY2mHwsmW1D/
	RY7/9UoLA5DXOPpfe2cOL4jwT/q7eCX7SLmW2cPUfXm22LmkNB8zZB1F9f0I1+oJG+GqruQoRct
	7Q3oU7uS2Nr14SE7c9dj2tGmYDBhTigzxy/SkH3OJ/A7bT5PlEtl5cdto=
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id 6a1803df08f44-9084a8905acmr175820016d6.25.1785742223387;
        Mon, 03 Aug 2026 00:30:23 -0700 (PDT)
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id
 6a1803df08f44-9084a8905acmr175818926d6.25.1785742222720; Mon, 03 Aug 2026
 00:30:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Aug 2026 02:30:22 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Aug 2026 02:30:22 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Aug 2026 02:30:22 -0500
X-Gm-Features: AUfX_mxqss-rUQV3mA_uJr2b_Y5VtnMHlbVczKQGwfQn5ZXTxPjmLx2yGIYEeRg
Message-ID: <CAAiTLFV-n3hdY3dUGSeEwfmAAgLE+tXBqZH2=eAU7EHiYorD+g@mail.gmail.com>
Subject: Re: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be
 followed by .pfn_mkwrite() for write faults
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Paolo Bonzini <pbonzini@redhat.com> writes:

> Warning - DRM parts (i.e. most of the patches) untested; I have Cc'd
> the reporter to help with testing these patches.

Tested alongside with the mm fix [1], and it fixes the virtio-gpu
mapping issue [2] for both the absent PTE case and the pre-faulted
read-only PTE case.

Tested-by: Sergio Lopez <slp@redhat.com>

Thanks, Paolo.

[1] https://lore.kernel.org/kvm/CABgObfbkqYNsPQnKxK1_4adXF_tSdtScPU5-Xrg-sXyeWfMVfQ@mail.gmail.com/T/#t
[2] https://lore.kernel.org/kvm/299bddc0-fafc-48b3-a9c6-ec171136a46a@redhat.com/T/#t

