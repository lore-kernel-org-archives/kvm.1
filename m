Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284E39F17D
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674659; cv=none; b=TdHTO2XJmkP8LGu7plmFp7nsNkD2Ypf6bBc+AT+iEnNHHXLTRPIA/PI0RD78tsj+AYAuGquukPTFbF1ES/dQtOkrzkiV7JKb/LnQgmhb3vVH+rYEE7zBFOys5eIII0l6eAIRUWMP80++WFQasd5XukKyUychIzH6s50kNb8vAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674659; c=relaxed/simple;
	bh=5SDjYRCcXLR507NfpYXyyyDZrat/ioX5x3rjWZGnpe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTMgv3eewF5fCjghY14NxQ95K9rC8sjMJ0F4MQ0X+xipfvbhf90T8SvUnfvWxoqMIGIn4nOPARtRF3ic7TRgE6lktUAE6iMj9SwYo5otfTQvwJpnNAIYvC4mDz5hY3Ylxa8aNmGQ4MVd8PAppqMe/SLLyZWGMrO4ONjzby+C5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwQ+SwLy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwQ+SwLy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b49819938so905f8f.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674656; x=1774279456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itDjDNSUH/60tzVJAFo+yyruw+YSC3+dRFoatVaVIZg=;
        b=SwQ+SwLyL2y3ihj2LT1ez2hHX2eeH87lj59HfnJdPc3RSg1rY/E5hBZPQc9KqcEkB9
         mXUPp6cD1R6MtOOSNuC5A3avkJLs6v4v8tFzIPrOYlbA0uWvNQob3SiQ+0z+Wsq9p4Uh
         5zMYGBfHsKR67gV487cwM3BaJAy/mStU8V3GV8CJgj0QL+ydLVofgx+P34GCArq3XPtf
         5/2mkQ8SNGct15pHrf9uEdBbg+lY/JQVv+kvEv/dEhA8jhmfCj2i96fnVhugE16w++zK
         8J9ZFCTQDpZXX9Nv/XHvkETGjKLpc3/lVKtYeMd2l9QOQmE6fgY9+gdSAcum6PhMzA/G
         iK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674657; x=1774279457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itDjDNSUH/60tzVJAFo+yyruw+YSC3+dRFoatVaVIZg=;
        b=gqDcZUK3Ntzl7Xl6+0BpLdqb8gVb2RMp3Wjt3+oic6jMsAKqCTPjZkwsBGo09/4urD
         OIrdJOFVxWguOQMVLwN53wdgj62reUJ8yUGdtApmKluRxX1G7iQ6tRKNovGaVo8XXOhg
         khbMsHPitsRvR8sR8S4ia2aUxUuTnCLxPVI1NJifhx8zKN1U2z9IyUH5irEgpHyGHF8+
         X/H7RDy+V5U5SN9lwGzaaXelxJ5H+/gIy+axIMp8YoAsDuU2vbjCvHFj+JH0dVcvT3xr
         BZUkb/K0xnkjMkuFt5Xrnbhhb5XANBvB/E+QYrvVEIl9jcGqMSXiC4WlSnrbaVnnqqAO
         q2kw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Tu5aSNnMFRORTSYXUQOI+iAEv1WYhTqZRTYB6YHQhurBfvxnDJOpUdlvJhJfEf14U+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t7HHzYB8Lq2x60cJmrQEgmePWAMyz7rDWo8qn+ud6nfum65a
	oOVYgTdlwuioOgIywBvk0fVelHaMZCE8Mt+D8gWjnKhp+qvyDz4sPqw1
X-Gm-Gg: ATEYQzyIhmiLz5pRTGioIAYLW6nzJWQVZJb8l3F3fg1Zx+y3lwN2xmw74aqLDBzqF8L
	ei+oBwNxCvG9+kfC2g4EUOhRfEh55IgmphVxve7I6EozHXoS0pHvLOvD0J8DbBVK/pJwT0UjZod
	gcdCnXDZ18nLBnSEIA4DR1teOHNGTYIKvR0IqAGizAzDKhOuaLHnrysHOXYpkHrIqKgrTTXjpJ/
	AoTPTk5pidNCszxEUX7JWwUp0T3pEElN+wvra9ay39ATrMtbZPU7RV/1X6RqmduKKBSJ9OiONu+
	bzyrpE7QHrAcEhC4N8VTGOXQHfHR832XNfOTCSshgob39+Wp+hqzccPeopGSAHitr3QthQUZCQJ
	Zxpt1A5u6CkkPiORdCdO2qqpyyw1GGdRPXFJRSZpedz2ZoJqc+gtwIozOetJauFmECWTHwJLDbI
	vxdKuuBdfRNz5E3MLXbhc1jwC8bt6/Sa9kxp2LNO2p39tBib61VDLD
X-Received: by 2002:a05:6000:310a:b0:439:de1d:74ae with SMTP id ffacd0b85a97d-43a04d868c3mr24898503f8f.22.1773674656451;
        Mon, 16 Mar 2026 08:24:16 -0700 (PDT)
Received: from osama ([41.44.7.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm42651753f8f.21.2026.03.16.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:24:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:24:12 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: kvm: fix vector context allocation leak
Message-ID: <abggnCAb9Py60PBT@osama>
References: <20260314223144.154349-1-osama.abdelkader@gmail.com>
 <19cdcafd-adab-469d-9729-f01e8bcaf543@web.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19cdcafd-adab-469d-9729-f01e8bcaf543@web.de>

On Mon, Mar 16, 2026 at 10:23:27AM +0100, Markus Elfring wrote:
> > When the second kzalloc (host_context.vector.datap) fails in
> > kvm_riscv_vcpu_alloc_vector_context, the first allocation
> > (guest_context.vector.datap) is leaked. Free it before returning.
> 
> Were any source code analysis tools involved here?
> 

No, there were found during manual review.

> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc4#n145
>

Done, I just sent v2, thank you.
 
> Regards,
> Markus

Best regards,
Osama
