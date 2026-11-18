Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999730;
	b=Kj2oLux6eGEGLqcPZ9myQyy/9lVXAlFiqI6fSpEHub0qU+1PHstAONn/J+aqkH57RI/s
	 l5eBeK69VLZefNlsXVcg61ouOeTJhyUL2RlY5k6KGBjzUtC3beJnTbqjKHsEIJrObPS4x
	 S4weo7+WeR1nvqmISuIqD6EfLe1hNA9qdeeUTvepwk0zDWzM3HjYFheXPqMY6/44825Fi
	 r1c4WMKSF4+bWUuNLdBVaiOEhkmrO0IhN8VkfbwKlJUp/hWujdbs8mXkcN/qNQnL1oe5D
	 UhFrFiu6V3sOLYMvO2frPAoH3Zbnl/nxFlawV5QlrxyT2wcL5BjeBbXcaM2tZ/Z9c8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
	b=xaV9Xv0YaWmN8waTkAj1bKUJ6KhwX6LmYe85AJ1yo9WvGPUuDLm3icTV66A2FB6NzCgP
	 EYnKwsqa/9Y99+zjVPDaPt5JpUt9IG1thh2ad+PX4b9+RzvCBImdkDRd8q7yP27Q8AOoa
	 ueswl1BF6xuZ8GdT4bivv7jiD/Za9Y4dHN4Prv34Mu1QkH8UAt5C5p1Q9+DoTiS0lnKs0
	 MMg1DlLcLpqDe/4rc7Kp8Dp5ZhDtDqHePvdaMWxRMlDHNjZqhvPlvt0fjDfAS2+EuK1Eg
	 IB7ENwIr84RuiBq7EP7q32S++8wx439GH3mjD5bJN7XQmMzB+o1iyZiEQH2a3mFKEFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Db10RAlg;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A6606A333
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 653A6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Db10RAlg
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2148080eec.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 03:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999729; x=1795604529; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
        b=Db10RAlgUJT1LdsOQzJ7fcLavXBei3dJ4+oWUC6WYljUFTqrPbn06u3uDFculCFNEO
         gMZB9AJ2KVvAMasfN9WEl1BFwjq2HiHXcLYt1iyGAplDPAa2xYQWUaR6CW7fANd3Vx5Y
         cFLWYu/2m9suxe3871zBW5tj2fIsN6dBjy2tg7/wKA2iZI/YXpbOEYaF8u6QioeizaLG
         gAjTiIEpJjXG5ZRrySx4OrL8Y02m33m9gF5w+PSUXXs2aluRFgytyfpsJxqVqvc9bXA4
         bMxeRNlvxxZ+UTvIs1mlUj2STK4+VYyXVzxdYCjkgn6iAZiROy900Dnw3oN5emZR2Wna
         6HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999729; x=1795604529;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
        b=WNvd79/PZGv/sIdJjoHjb54RdjuK4I1SDZhMpz02G8V/zGQDqXmTnZmbaArdIuDRuF
         WWt+E54zHsuuk+82arsZrWB1MYGLYe+075GT4S2ff5vyyXti2dQHtouS9enXU7aZumSZ
         ehyEwSA5RtOJOfVbpNJZsmjCGXiJjbaToxi2rN3JGRgrzK8k1Q4zcOB2GOR59ssDfMOY
         8mdtvG5b1PMuq2MyLD+4UEJl4gQpfK5NCRsWRhf3V5REKwHy757O8qI6cplGkwj7h6yV
         2ItJ2FUkyExOJINah2Ub9mz+M708DVkvDB04tAQjBpWjD8SXiyynfSS7ubVzGkJE6GOe
         Z6FQ==
X-Forwarded-Encrypted: i=1; AL+hErGwDKdkxEHjc2LdkvMREeWNfh70dsKWcoVE8nHGr92Be1tTPj8bNfYciwPp+VozCI/2L8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TL1pEBhTFVh8/6icAZGeDT4W/EYu3hJC3VUisMYB+BqdslWEt
	yQf5AJmauPH7qHdf3LO6N4Xx+dPqMaxHp2d9xbJDQHuQjC8I4OxDuqQz
X-Gm-Gg: AZFdTZdmm4iG1nNhrvMYuKsXcG6Lo/i0Vhj2bahtnivaWE0NbC5272O9EN9HxhJ3RS/
	CJ9cFj17ecAtojT3/LwSVuU/qK8OhTe43Mv3FA2hSjen1yTRvp8L6KooWq0bC9kk4oHBncj1C42
	8JdqVZ3XbtRUY+xThyHGH8q6LJV1fvVqph2OC+w7pjH6/VFJGpQnEtgIOG4yD1NucAbTAU3MRmX
	fqU7xN+f2WW6EBAfECq+3KYmnXatPt0QdWnmIbAlH/cty9UOYfH/yaCDCjQ5tydkg3Y2ZdvpsMb
	pJ3xgM1BVwvlQrGKIEsdXgRwbGIy3AEfNFfhz7GoUCjFGbNEGGGPnrWBPl+EdX3Pgosd1KV7h+C
	6wapGIKPPgGOQ24gt6xUIDJHzB4PwJV5KOOok2oJjm8AJUAiqGMHlEYqYUGM3KrdeIYnxFO+jhS
	qgo55PXh31/BNDZeidUo8YzdjU2Omb9IuFW29uUpchby0BvHLJgTLQlZJCLL4Hsl1avFQSM/+HR
	H96voath99gXFmm8MLv9yUwhHDbIhn3GyphKTpfa6TLRpI0LeOveodZZCi0wnYQ72hJX4jjugU1
	Sks6yhiss/kTAZdOLaHNg/Hs+qY=
X-Received: by 2002:a05:693c:62c1:b0:382:1c52:da74 with SMTP id 5a478bee46e88-3828101d214mr2495287eec.25.1794999729242;
        Wed, 18 Nov 2026 03:02:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d8015sm6984944eec.21.2026.11.18.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:07 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Yadav <yadavgaurav386@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
In-Reply-To: <CANo8Ldu_Y=GduFxxukfbNQT-MOQmR8N0V8evYQPpO2+i1L1hSQ@mail.gmail.com>
Date: Wed, 18 Nov 2026 16:31:23 +0530
Message-ID: <pkw2769o.ritesh.list@gmail.com>
References: <20260807084050.25216-1-yadavgaurav386@gmail.com> <a4na92vc.ritesh.list@gmail.com> <CANo8Ldu_Y=GduFxxukfbNQT-MOQmR8N0V8evYQPpO2+i1L1hSQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Gaurav Yadav <yadavgaurav386@gmail.com> writes:

> Thanks, Ritesh.
>
> Adding the tag and sending a v2 shortly.
>

No need. b4 picks up the RB tag on it's own

-ritesh
