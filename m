Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADC2FE05C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369661; cv=none; b=nOwRMEL/Jbutz4VV3S8kgapGIMV704i+KmQ80OEAuUmBTm04RCMGnQNpf0X5oqGQGmMNlOLDDoIk7KtDRGDNayMlHsRv4cRqoDeTvdkNblKQGi1hi1l86pbZFaMT0xDQo0HtpW27fVCJ1gtTW2nDQppqRDoTasl9z9kJQSjxqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369661; c=relaxed/simple;
	bh=4lBXdS0DMR0YWwCA/SBG4es8RBlmNhsJHItOEukqLAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sozL0ww631h9vwOQZSMMMGJmbx4r+0qIZUdPED7Z6YKYg+Nli11njK5QtB1VMApbiSK5koVIyu6DvfBY9IDcPubL3mlkKTU1a0RYQWKN5YCDCrwcQNO3vOyU7bb9LIMIJC+ktno0AnQrtxXpzTNWZ+JpKr92nbktJnJAzIHdSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxRwWPAj; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxRwWPAj"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1857519a91.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785369658; x=1785974458; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eR/xGQAZeugJZrdO5qx2sNHVhiF2YISzZIi0PEeUu6E=;
        b=gxRwWPAj0aoCenGmgAr8Itm84E+q6AKzFIjL3IVfQ852c+bwCP4lHkPoQRcN9QE53Q
         UMIld25ygom4iWyzXR7ggChuPTLjHQ2kJdWABRVVCtczUBEelesxg3ONHgW4Aa3suF4a
         5NoC9sf2nUGTUDA/Ctp4nBQGT1B2NntG1J4ZoC/m2HGUB+nU4WYEEyFQc4hQTnawdpuf
         kksLClfl75tRhhlZ81sFy25UvTFTECkCsR76ihngHUG4t/F/NjZJij79Hjnf3w8xX0US
         FVBrQCuJ1VegHkNCG5AInALmYG/d7cHLnXaffYnjMngY/bjIAMUYeUuXJ/DgDVJeaTUj
         B/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785369658; x=1785974458;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR/xGQAZeugJZrdO5qx2sNHVhiF2YISzZIi0PEeUu6E=;
        b=J/wS18P8Kl9rT0WPDnH6kK2as90tH3+oZn1/DXP6a6aL2gH6uwZrXSdJ9k4WYruen6
         EVsWpp3m3s5f5Bkw73ykDfme7yDMK//UrGk2acH7C30bJ7V9azjOlM9gtmXJplg94Iu3
         SwSfPotmPOmoJpMkCnsL3anoo7/pVf3VEsgPYYLp0PpFimJiRh7DnzDX8fV4tmsUjHGb
         VJMFlrP04gw3jICevK4/u6Umo8UXQZoe6pQeEWcImTohxBuORNMnNLPsBTA5husjJ5u4
         NUHGIfkxcjU1Z7ol/LcavAb/qC3wyluCjXwpQoRLWSEVWvhuOsrhyJwXpbwyQeoRv+Ct
         9GdA==
X-Forwarded-Encrypted: i=1; AHgh+RpONjxl3It/ZuBUxwckwzKeTXlav9h8kU+pzpp25dsuY3ZIJlz6tYuigvvmae5BCxWkgl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGosnO+L3LVGAUCqxED76EC1VhvxRaIEgsMtiEP9bh8L8YcMoZ
	sjmJ20Vs1y+4U81Qqn0g5pY/N+8JYW811IKBtS0ktoV8nVO+EAMpzlhY8whgASLkTlnhSQCYIl2
	rKSRzjA==
X-Received: from pjzv12.prod.google.com ([2002:a17:90b:40c:b0:38e:bf7e:bfd6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2552:b0:387:e0db:3d8f
 with SMTP id 98e67ed59e1d1-38f9c076c92mr286091a91.42.1785369656868; Wed, 29
 Jul 2026 17:00:56 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:00:56 -0700
In-Reply-To: <CAKSQd8X56f585VcsoXQbOhMoDfgffwfjXvxSv9Y2sqv6NcJspg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKSQd8X56f585VcsoXQbOhMoDfgffwfjXvxSv9Y2sqv6NcJspg@mail.gmail.com>
Message-ID: <amqUOP4MuvjQoncm@google.com>
Subject: Re: [PATCH v6 15/20] KVM: x86: Guard valid XCR0.APX settings
From: Sean Christopherson <seanjc@google.com>
To: Christian Ludloff <ludloff@gmail.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 29, 2026, Christian Ludloff wrote:
> > In the non-compacted XSAVE format, APX and MPX conflict on the same
> > offset. Although MPX is being deprecated in practice, KVM should
> > explicitly reject such configurations that set both bits.
> 
> The ISA does not preclude an implementation that
> supports both MPX and APX simultaneously.
> 
> Properly written SW deals with that possibility...  :)

Off-topic, can you fix your mail client/configuration to use In-Reply-To?  I assume
that's what breaks threading for myself and lore.

Thanks!
