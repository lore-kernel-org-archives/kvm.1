Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F613D539
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579621; cv=none; b=sKnQT9ER1WpKl24asQzRFhS6lJ171xloWl91bxpFC3SSLLNYLeawqI+zZfr7cAb9zciZe+cAfI/PsNiiv6ITpwY2l6Ogo/DMFjWaU/IlvywwgPqiikIq6BbWAz7H8KFe6moNq9zd4UrSZzpF/gKrW1QcRqWNfNMxtTlqa8jYPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579621; c=relaxed/simple;
	bh=4DFC9XcdQa+gXjY/jBLIEv888QmZKCWfftMFEJzsr2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5gnaR/dtCY2KgBaRQd5uR8b4vI/+qaQnlugMTxLs9O2nUuBqD8I9TdkmUUsxgzF0J+aAT3cIgKKGE8Spl+JC3diPyZ2iXT00I45J/fJm9Gc1BsdY9GdYPHVRZj3lt57WJXsxYVB6soISDAJXfI75d71LOdRapESQQ6sNoMOwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IExdQP54; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IExdQP54"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso2476576b3a.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786579619; x=1787184419; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKU+B6jA9oay19SIBewfSSwib4hWwrU7BKuj6eQWkeY=;
        b=IExdQP54zSVBiDxxxReRcqKvXfD4a3hZX8m4UTTWzr1mJWM5RwhkRbu5MHr9KNhH2g
         NwmOnbAhMksKxV+gYUIK4Znix1fStYZATUJiT3EVqjhxa2yMAhh13V3OHIin1X3xPenF
         kkqrU/hR3zq2sGC7oxwCi6EVmtKYqS7I2VQ3ah7R+oAFGK7+rwlfy7K1L/OStXxzjKlV
         MST2t+HctgG4sXnyRfefEAcs3QD4kRoYFmX9vkjssSyJKAHtOtuGl8j9AisUXFaigxAo
         +XZqSf7X4Zp4sQRejrnH4xLT2obGGxCTkQULD356yKcnybxmrRfM7PLA5Vu+/qKoJAeG
         dKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579619; x=1787184419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKU+B6jA9oay19SIBewfSSwib4hWwrU7BKuj6eQWkeY=;
        b=mNEwCnZcikiYrQSx7isgm+Bf9C6w54Pkz1Tub+pWN1QpQKBZK2qhRaixq1gik0h0dv
         KncelY+iNsjgJQty0WUT4oQc1/6In4DSBgYUK0tju4a/nvl432LPdQ8ru06cdHPrpWZK
         /radXlDUORT2KnzSi1FvUjX7q89NU9EJX+mS1hRsQSzKoQJivi6akTjVT9vD77p7evO6
         sVCLge1dfw8lYnBJKzdexZubIEY+otAlqY5Y01etNyRtsgNdYB3PURBVrnp9KbtIT/JN
         3S5zzbtb6BdLvO+Mf8ousNp2TTxkC5Xi/Fx4xZRLaO+3MxCgKMyug5YNEQarp3VU9rLu
         ZUHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTRCGVLlnXNXrNInUO5komZsLry042aRlC/PX03w+tmqQx6qxCiuD0GPWPLmSGOVwTC1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5iAOejE9MFv8WCou0PqXIfHsQ7bjEWSDPfiXjZo9ARfWBxFmH
	71seCUzrSEupX3zXg1qMaj2uGQW3KVwpKw4Nl498JATFXhmyOzOHU4RylgHxqviD93VsNqkOY86
	JQQlwXg==
X-Received: from pgbcn3.prod.google.com ([2002:a05:6a02:a83:b0:c8f:d0d0:d863])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4103:b0:848:5540:2377
 with SMTP id d2e1a72fcca58-84fc6d3f4b3mr1871965b3a.17.1786579618762; Wed, 12
 Aug 2026 17:06:58 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:06:58 -0700
In-Reply-To: <b66874a9-3f3f-4b65-90b1-b08c4aab6649@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com> <20260812082029.118791F000E9@smtp.kernel.org>
 <b66874a9-3f3f-4b65-90b1-b08c4aab6649@intel.com>
Message-ID: <an0KokdtSXE2GmM1@google.com>
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 12, 2026, Xiaoyao Li wrote:
> On 8/12/2026 4:20 PM, sashiko-bot@kernel.org wrote:
> > Pre-existing issues:
> > - [High] The preexisting VMX handler vmx_handle_exit() silently drops negative error codes when a bus lock is detected.
> 
> As replied in the v2: VMX fix was sent already
> 
> https://lore.kernel.org/all/20260806111923.1990562-2-xiaoyao.li@intel.com/
> 
> BTW, Sean,
> 
> Will you pick the VMX fix separately from the series, if it looks OK to you?
> So the next version of that series can focus on the general x86 CAP changes.

Given how close we are to the merge window, it probably makes sense to include
it in this series.  It's not urgent enough to squeeze into 7.3-rc1, let alone 7.2,
so the very earliest I would grab it is 2.5 weeks from now.
