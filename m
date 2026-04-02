Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788235AC3D
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100236; cv=none; b=Ahy05N95cVl8EBonZdkhqmvBMLgifLUC7AqkhrFQ7Fubz6sYWm8ojWAStRAoTWVnTZXSYmseGygyni2YpFrgXapy1/KFbJsuyVOosodc2MuZusCyxmqAUtKqA9T5maow7cAYfOXQ49PSsxJ7WXlYzBrl3l93dgKwbU7pp1awMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100236; c=relaxed/simple;
	bh=wFEV17vVfa76CsA90nmAYfTFDtEq/4N4gmtI/2tIe44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxBcNPGmNVY7eauJvYLXvYGDSikl24xzJU8k7Avid8RyOLhcjfSpkPPHazCE5okBFo1rTx+cn5OnXRvDj+Hk/kejsptPae9et27SeqAu8jnVP5MX+W4eftP8mhf+UQwz6RrL1s39N4sO1dc2gf2DLMeP0jE4AF4ciaBP0Z61YaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBIkSG+s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBIkSG+s"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2591757fbso61475ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775100234; x=1775705034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGAV7c5XMV3aDL8nK9n4zmairzWoU33cKjELFgWkkp4=;
        b=gBIkSG+sf5DE8ChTGt5koXauObuoCLFCek2+2A3DxDLWNSDFGcrJ/lu9dDP3WgeNCT
         O0YoBBsRUkhp/Sb2zw25AC9zI+cuCfK0iJrHybIN/mVa0zyEjCrj57hlWqHlwJUa7e4e
         JGtmcA8iw8oQPu1eK14hSgXo5BWNGSMDa3GlwU0QXQcrh3OVWOgRCcN3CP4ejvIG6QSB
         G7uaGcU9XzMHqysPsZ7A/7h9hfSmfRWjnvt0nKTcP5ADK8tPnOLz0lWE4LQ+ijZTxaUR
         40eKtW4Z2Z6FV8n7kP2GEMRcGEVQBw0DlkzvyW0s7qdO2KjnhEhZWPKroNurSjweNXW5
         bB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100234; x=1775705034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGAV7c5XMV3aDL8nK9n4zmairzWoU33cKjELFgWkkp4=;
        b=OMGUU03DxfuW1+2JC/SCZqvNLEaRRjhkSXeG/jSlW6jCJUFNKpawp4qxYNm5R6O+V5
         dIvp9LcFbSaweuoT7z2TngAGSyVzxDWyeBEBwzcAck1nuqse2gOPi5ra7dV43wTYiNe0
         H63Ngya0GcXMO//n5rhnMsDMRu8tip796r6CeV2YWoU49WYBJpGn2G1jpg2LNdKje25G
         syYjBQVJMepIReZIEw+1NgdwkorbfdHPa0wmrsRTExqLsbSRgNHCQVh2tJzQP1Qe7D/X
         iqhQ8UR7Qn5yW/jkN8oBR1GtpV3QGfjVl508RLDZSjGsY+/xXj3Z9q7koZlusU3ioqXs
         t/sg==
X-Forwarded-Encrypted: i=1; AJvYcCVLj1W8us8PwbGTYRCndfNYYjD7r1hgEEDW4+dJu1hmaCoL90mIHXVJMcn6rk5+zewZp2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiFmep3/6Nb8lYjWOpOaDJBznWI0pDoo5KhUBfUEa4fS15P97
	boCY/Yd3hQFkHUOtiILUJszW/i+jVOYyXViSLY1r7KYdUO+72IXJhLWQWALdyMn+
X-Gm-Gg: ATEYQzzIWih1mU6Ycg5yUY9Q7gMVbmZD4xQWrV/nYy794gKomTK9ea5yBLnutbvDeOS
	AIHVsEpsWFAFqPeUW6WrWVi71nJ/S4qp4rGtCTVpemouFjRa7sglLxHRkopTUhPKO+zIBytyrJG
	cf0pDxFEnLiHS2q8Dl6WKeFy9HWpWQErOT2gycNIhWlR1s3d2tUpjvtq+Kdwt9YiEXAhKnJi53/
	Bj/LTS0xgEdI1nM3WUxTGWgjhQAe5RBvj2JYawV/LrkvIPXiiIv0quoVG3uCBMxtw+R0cCAMJ5x
	IVbBKi7QsvyhiMk/yJfLcztadzVeWNwjyby+AeF88GLbC05jLKigjnTdJWjJVywuWISws0zSP4U
	3/CVDl74xQB6EmEE3vQ93BgS93pNerHkCHNUbFxKd7OxGQLRSAOyjPpRsQdYcaLX0g6kx1GyITz
	UByAXjTKfyUHNJwsjz1tc1xWDzEuLG3NOlvKBmpOwDGG2W0966jUPpamR5auEHlw==
X-Received: by 2002:a17:903:22c9:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2b27849c29bmr744365ad.8.1775100233878;
        Wed, 01 Apr 2026 20:23:53 -0700 (PDT)
Received: from google.com (128.161.199.35.bc.googleusercontent.com. [35.199.161.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm14428665ad.11.2026.04.01.20.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:23:53 -0700 (PDT)
Date: Thu, 2 Apr 2026 03:23:47 +0000
From: Josh Hilke <jrhilke@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 07/14] KVM: selftests: Add support for physical device
 MSI triggers
Message-ID: <ac3hQ9-PzaelG0NF@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <20260331194033.3890309-8-jrhilke@google.com>
 <ac1_Du0JMV4g5W2Z@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1_Du0JMV4g5W2Z@google.com>

On Wed, Apr 01, 2026 at 01:24:46PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > From: David Matlack <dmatlack@google.com>
> > 
> > Add the '-d' flag to vfio_pci_irq_test to trigger interrupts using the
> > physical device hardware instead of emulating them via eventfd writes.
> > This leverages the VFIO library's driver support to provide a more
> > realistic validation of the hardware-to-guest interrupt path.
> 
> I don't think this should be optional, I think the test should unconditionally
> validate both path.  The "signal eventfd directly" is effectively a smoke test
> of the full functionality; if that doesn't work, validating that sending via the
> device itself is pointless.
> 
> To keep the runtime reasonable, maybe do only 10% of the iterations for the eventfd
> version, capped at a lowish hardcoded value?

We can only use physical device interrupts if there is a VFIO selftest
driver for the device. I can update the test in v3 to validate both
paths if there's a driver, and fall back to using just eventfds
otherwise.
