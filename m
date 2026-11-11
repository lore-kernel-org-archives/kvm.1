Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417439;
	b=PUrXoQjHlq6A4RO6X/S4DeLFsIvu3ib7S5hcAoV1fYZR81vO6BAXrh5cGCSC7HsBHzzO
	 Cc8Mjsd+RTLahWgFEVA1bUxAa1jzBaXtmesq6/WPLcez+IhaoAeprujH42/j4YGqHEeuo
	 WA+HqrYUxasDGj/KjnzQGQzoBBM/y11x9I0hG2n0clFBzqT88mM3R/0KW3AHKd/HsLWSl
	 DsIWtzZuHtm+GFYyk0J8cI8RmoSwBbhc4hEgA2ZwnU6Dd3S7wTygxtVaMC8DXv1csGH/c
	 aAW2RJBQZwGBiUFdDWPoJq5qjuoCC8huEHTqeXpGb2viS/ULcAcOQBCvQK8JsEwuavQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=CHXsNJZUxPCo5A6HmwAJQBYdpTzsqa07OU0Prn+ncRc=;
	b=GZmbM7jdyZdO+uXj1P/mAtUxQMeJDCC6i82muSpyccaZVrmmpPLri3fr2uk9maGRkYnB
	 TQJ6kqnV63mtxc0K2M9Db7kBqZGxYxrICbfJuSWqXxorJGc0f33V4lUE7dO/lpwam3i+V
	 b6hl1I6MJBB9N9ZWJP3ECfjRQ5jgi1Dqpy09TDCnb4J6361bHZbXyYVqTstJIYYe+p45d
	 PbIvOWieUReU86p390QlHc57U4GC2GJ+wtKcNKg8diUKTlHnFRFc2RqB+Kg5bTrm2AxIz
	 WkLmv5S+DlwsabTzcD+KrnmzLAFJB8nsHC71N4idI0ItZyd15XkdUIok2Ow9JB6Yfig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eqUpM2YF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D26606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 17:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eqUpM2YF
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso39803296d6.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 09:17:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417438; cv=none;
        d=google.com; s=arc-20260327;
        b=QJkkwHeUFwyaMGhi2bLZuHRYHd2N9CDaL7EGP4ixsjcvIJK5oNC5dQo7TJub5LRoj2
         lRWA5oKUaN2d0yL6nM9qlJKXJCWTymCN0aBbsEPYzA85bnx3ZULoIp1fhMdyHMm2ktvL
         fPEQLDLno9E3rucCzCIeY3npRBzFZ9XqABa7jJDl9T0Efb49SjENHePHnLcQs5LjLO0a
         KFAKVsLXVn3MgiBk6WXcohIwN1+81H1Wa7uadgYvkDMyWiiE0emOa4KF1NS0ar1PmUjM
         8ggpXPcsIKQzZfWKJ4KEg2kRvHJ5MShMjvgZ7dQacwmXyEUxG4e33QECNcTNZ0f+zVCm
         DvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=CHXsNJZUxPCo5A6HmwAJQBYdpTzsqa07OU0Prn+ncRc=;
        fh=Aj0pL8RtLo7MsMKYZEO3fQ6V1H9u1bfqqbAQWr3x88o=;
        b=BDBDdIN8x56Q3ps661/7KfQHr39nCCW8KiHejdgoe1xeQg+mmN/bWLcBTItMq4HjMO
         3Q+7FHhDu7qDuXqDVK9PhvsF3ChFrI+yFlVNPuX9lbujzidmt7hv8b4zpSNRz8QmD1Ql
         vmnMuUaXHl/VAhpVzYyzhLQ1GwBQyHpDsHvCi1DhIJLlx0lT8wteb1KgWnPP1r7E9HOi
         0C/pgGtkimVCD79dAO3dCChNSQmBYlMHhsfz9eaBZ7uX5mlkCBWNSzo5s2iwZUfKgNta
         s2bteW8kVoOQ4gUjnDEPUIAkJtSvhIVxL/2lotHTYDCUmHhOp776EfzKVTNsIXV5/nvM
         n9zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794417438; x=1795022238; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CHXsNJZUxPCo5A6HmwAJQBYdpTzsqa07OU0Prn+ncRc=;
        b=eqUpM2YFsCXZzfzYizullBwO6IilSvht/WTVHD5VSbbGqAmYBlMyMa8Za4+AFeaR9d
         qzEaK5WPrQZc75i0L7xEM3Tu8dSvEiyEtnBULNlGmYKYe+E0s9RXYCvY/lAJbHD6M6bL
         gmCJNXslHif+rUuPpCTd342aLhiqbizFKcTFuOk5nN4WfQoCYCC0Dk4AeJdsSbpPzqgj
         XlVTjBuHY2w6ZrAlXJR+PuBFEY4JTSKMCdxiwDBVDFmgVs4vfX1fEr8ORZGp0jXQsHWF
         K1HoyehadsZRn2l9aPoq6/594dEZ7umma8VnEZ2M5ySKEfAMeZvx3l52jClW1eMcaWmD
         JmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417438; x=1795022238;
        h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHXsNJZUxPCo5A6HmwAJQBYdpTzsqa07OU0Prn+ncRc=;
        b=b4nPqU3Fw5Nuo8P4D6hyPvsSQN7t66tvbT+tYZUPYgAQENQyrPEdJySPBXXk6meCKj
         F6I58+jDYSCvYmOq333tBpEC/qQrBNK2VGnPhc6AxMCFPNMOvSSUm+JCwiHZRukJXPAw
         O+471WHvHbc/c6/kgPVtKgFiSH33mNKWcZdOOdIntVJIM5HEEFoN58KVXVjM8o7QGfEt
         M8YucwVdunambYnzcbOZT+9f0uU/2IuKQzd9vEyT4/jJSKBj3NpezXjGNVpL3iuRtQI0
         1KnqMdZldlAxYnuJlcknWPpiwUKvinfKzsjhV6SkUMVJ39KWCh/pWyAcJUZLwJXZWzGe
         929w==
X-Forwarded-Encrypted: i=1; AL+hErG2EZsUZmPMT5HN4uvNC3vNvTW3hzljb9TRE+QL83SHPNAf1c0tuNJAE68poWJZBM1CERw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IDX8XlGOg+Mp8LYN9X9FHIpF28PfIh0xDtUYl4cYWUv/7A9LJ
	IYnRFB2jnCqlE4N+idNP52BD1vhriG2Bzoo7aJOlvekNxGP5WbNZx68FLjn7x+gA2M347unN4zR
	ygCyciwQb0YYrO9LI/HNw6zn+4TOuXOUb4oPSlS1g
X-Gm-Gg: AYBFou0X3afCOdQC8bOTK4qxs9lANRAjz9UfYQ2PMnpQfM9MTgV5DlnbvifF/hWcDjH
	0myDzMW1OrXIYIArvRk43p4mA8ZuKeVvoKO2Tcmm9cnUVFAW4CRgbWkjP/ErhzcA89T4lRDDxSf
	vd4pMAUY55Q5RGvpu6xgI7hWdGxsREH80ufbUoPOZvY65zaY31WYsulBgIUSFJc+Nd/kh3Uf9zp
	FZ0xH9nFBeuWY5qVeBmQM0ojKhdEdzYxCo8E7YSk4o7WGrDf8iCpbep7RoAHnt2RVtA6C2PY3y+
	EK9SKvVxeSl2ylMf3cLhrtkoyOxeyjQyvl6hhajkO8/rJB4tjar6r1lHQox4v4e1wnT/HT2S8Dn
	p2Ytfl8nmK4MeFz7fNxewIVfwcnCjAKKXVq5EvqTypMdrGVitMjlGAK32KiP1Fh7j6iAKIoCOZE
	cDtTFaoUd+FP9I4fmHKn+KA5KjPkd2zxOQc3+AtKM+v72FeEUB
X-Received: by 2002:a05:6214:2c10:b0:91e:eeeb:5ab9 with SMTP id
 6a1803df08f44-91f03f95987mr55271816d6.16.1794417436892; Wed, 11 Nov 2026
 09:17:16 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 09:17:16 -0800
From: Ackerley Tng <ackerleytng@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 09:17:16 -0800
X-Gm-Features: AclHuK-JW-dz-s3WPckdlk--4-Q2gCEfYsudv4IbzOOLXO2CTOfiTXaBjvjq8wg
Message-ID: <CAEvNRgHLXryXj57HttDu+ZD6ogS3oRo0A360F0Bt9V1Fu=Rt0Q@mail.gmail.com>
Subject: [Cancelled] bi-weekly guest_memfd upstream call on 2026-11-12
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Tomorrow's guest_memfd upstream call will be cancelled in favor of KVM
Forum :) See y'all at KVM forum or in 2 weeks!

---

The meeting notes can still be found at [1], where we also link
recordings and collect current guest_memfd upstream proposals. If you
want an google calendar invitation that also covers all future meetings,
just write Ackerley or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

Thanks,

Ackerley
