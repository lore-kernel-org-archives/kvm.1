Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007242C0260
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786167805; cv=pass; b=p/Vx0nLEKDZgvP9evG2cVsA9AlQJ/bukf1bcYEg/wJsvyWA1ZEqI9oZzkiwMM7vCeuP7t3BJvIrhg2Gg0j7yTMo7ACEw/5UjO9LiFYjhC4D7qxYwPZwhhizyCoDUJmyL5kLlt5x6dwlS7IIklJ3ym8wQxx+nQdQ3SJxnGNsh8Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786167805; c=relaxed/simple;
	bh=kSphj3xXK5vtTcfgPTuPqxQQOCV6JIOvJY9QlXkhihQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6chccMWIVCfl29OZZ7IXC5dKxm9Iw1ktzKtbPlT6Q6ZHZ/nRWcINduuCldZOrXew+DxmfuvYn6TlXjfQqt9l+HUZUeB54qHEriGVW6jFpU++vUdyW8VfdRqt2W/wWKNDXEO6joGUAa8mUV2U1e+L0DZPvaqFIZLkGMqzPi4OyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMm4FSjQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYeoGIR3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMm4FSjQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYeoGIR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786167802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38PXI4hXALTAIClil/EEInj9sv9PovGczy9U4Yj+wRg=;
	b=aMm4FSjQ4Qp3S3XldgCQjSi9IdPeKGeqBPCECGajgYmEcmc8nULRAyxaSFQgtI+O8TJJsx
	SPAeTUzGJWrB52bWNSdL4t+Mpx55NMSUIkzHwKrElph8xPmVJirtj0RfLo0u+oUQwZqhDj
	PPlmTCqvImhUqtDQmeYa+KfqRkljV7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-zpooYDHyNQO2gBax2f6JkQ-1; Sat, 08 Aug 2026 01:43:16 -0400
X-MC-Unique: zpooYDHyNQO2gBax2f6JkQ-1
X-Mimecast-MFC-AGG-ID: zpooYDHyNQO2gBax2f6JkQ_1786167795
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47faa02f707so201648f8f.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 22:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786167795; cv=none;
        d=google.com; s=arc-20260327;
        b=El6I5sqGQND6CjlAnPYYdCRyl7M90WLTxrACEUJhqYnszHS1T0tVF4CN/DCqXtRERD
         dI9Z+NSZlA/UyUhm1rCqFyHbcUAfDmtUPqm+IVbiznUw3u8fHNGxMpG6njtYNSetB1Cs
         o7XrEb7oArcB6aq0XYalSYna0afXLBNbswcIdOXN90wN+6ZvPJlQrcFKCaHyxfA5iL+U
         X27JST2ZVKJUPcRUEQYKQQG/9tdf8qSaEMhkztJz9kGmpMQ0S3A37rYfp1G2KjS8HXVt
         /uwAuT7SDoZNMJ0OIYgZjoZnaE3VUNFhLwrmWGkqT2pCsO7hau6+Nh4v5U6oslexR8LL
         iqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=38PXI4hXALTAIClil/EEInj9sv9PovGczy9U4Yj+wRg=;
        fh=GW3y32ggJ7/+QerDhr6H1QvX5nNXzwsIqqGMexLIfEc=;
        b=CG4yBCnBUivPL95w/zjLQtwUBonFMClPPGHagOFQR2E0EDMBGBxbJB1KHE2U5ghTSI
         dTStZ/mbN4Kt+2aLuxZopHiFF0aDfY2x3Otlfp3hV3dAvyc/VlUr/uuyXoHdbbH1/Mcj
         I6Ptj5247KUdTZXW/Oqu+H3Vgd3FFEPf3i4s7whrWNGkn0JOaMV0MFIcjuz936HJ7KQg
         pkGZYz8wCpaFWb3KQ1ASvhjXLjPPh46+QCX6fSDWkfgPidPUew7eqPPoI+CIcBZSxaOm
         37YyHKfWqTR+egAsjN4WgdFGnvsESPVhd/1m1jAie2Cpjc0d7dny5r1glDx3OcoEQzjC
         UU9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786167795; x=1786772595; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38PXI4hXALTAIClil/EEInj9sv9PovGczy9U4Yj+wRg=;
        b=XYeoGIR3hq2ERVU7+0AQW0a3m3pEySuGBFWVuyXgei5FelX7fGNeFLhJSEdfQCr20s
         fMsVsI7dHlIt/vob/wEjCXTTvUuLPn6xaH0b23n8rkNarBPtjht/II0qDsBFu9HhwSyd
         5NTjD/e7tZHt64ycimfTJtmLsEegyIPeJrF+BXKwzdjuRz6hsgSfTEu9xUnyLPuGv4C2
         NP6oARZokE//tqmGK4BdJXT8L/tI73fH4iuY7HcGXnehCBF2ABj4o10FvggcYQPnWuq7
         UIti/53Sa7ARI6NkIWOmdmRZeUxnVAQ4pyX+JomWFKVsN3WUtlPIUgZz4j7zfoX/JXD0
         QSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786167795; x=1786772595;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=38PXI4hXALTAIClil/EEInj9sv9PovGczy9U4Yj+wRg=;
        b=bm4K2IZb70K6oTV7RJiiz993nDvoL6sX6VO0jWFxLMfDEtIX8hk1nSPOugzgx0nhHP
         gdKnk/VfPogK0uyrQQHiom5to+koFNkwPCaNZ3/H2P74Y2QNdimxokvMb/LFl8lBFmvr
         gKX/m7h0t5h2wBuXCrqWvJ5XOj/nBS6nPlmMikGNmQ4Ox4IWr4Izv9rxH8ippmhZMM3Y
         f734mB31xCtEdLMxbZFsLbzajnwQghR0RFN1IaBG78B0/iT+KlswIa0CBZOKoF1HM9a4
         QKoX+jtS2zODBfcPGf+CbgmrPJbCgXB5EWoaqUlGH4RzSUUxwPV+qhJ3Xey4TExVoz7X
         FYlA==
X-Forwarded-Encrypted: i=1; AHgh+RpUj4LPZ6/LKbCB8wY2HpXBSjAH7DkQ+tWFdKdF9h2O1nMq14TxdMPIrJMGzI61RYR/l50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17rymEzrRjtgWd+iFIwY4/qTr2lcSlvwhC8PMYedJesULCHIy
	kIFZWzYzY7bssfEkEJbSjcKYUbPa6ExoNoQIxeXxKLVXTViwnOKt6GstmRr21pDiSSLD2XMprhU
	9eZYKzzBL217yHOh0PtZsfI42CrfxmMDdfVqIsqrijBtG2pXEOQRPUNn+Mpn8cIYxXZLKPpXQT5
	4vbc7is5/5x7nnkTVKWhq5xOcUz/gW
X-Gm-Gg: AR+sD11IsF1FklYBWjBU7SxfzBCaqEyHosPZrDGfeBWEgWRf8OImdSv3mW/YsVc6r4L
	uRP8ru9IAhwEkX3sJzZNkefTLHwQ9AvOb/j6Q2FSLNXSlJUloUv7m17hZwlJSAvHMWgxbWmu+V3
	aCfb6MCY8JIWKG2YJgGtQZLMznOEszXJV3MXM6r2Jt4MJ/Y1eVrWMvIOO7nFYtDxMLbbn6ZH15N
	/2GsEAE1Upcxlus5HcJFWSt6g+ET0TZ3168Y97mz20VQa/1g90S95kNIM0=
X-Received: by 2002:a05:6000:4a0d:b0:47f:e746:dcab with SMTP id ffacd0b85a97d-4813195b1b1mr4731139f8f.10.1786167794802;
        Fri, 07 Aug 2026 22:43:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0d:b0:47f:e746:dcab with SMTP id
 ffacd0b85a97d-4813195b1b1mr4731101f8f.10.1786167794431; Fri, 07 Aug 2026
 22:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com> <anYQsMnpS2kpYoqA@google.com>
 <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com> <anZehP6yD66SRsNj@google.com>
In-Reply-To: <anZehP6yD66SRsNj@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 8 Aug 2026 07:43:02 +0200
X-Gm-Features: AUfX_mzCvXa6nKHnzEoP-mNSxokGwRZOv2Ks7dbLHdG3Tld1Frb4uKun7a0tmm0
Message-ID: <CABgObfYqWf8WXNTZtz+W=CSK8yrGJhDruObp42LXkywhyK6=0Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il sab 8 ago 2026, 00:39 Sean Christopherson <seanjc@google.com> ha scritto:
> On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > I consider two weeks of wait, on a review that so far had been
> > exclusively about taste, to *be* an honest attempt to gather the next
> > round of feedback (which never came).
>
> Heh, and I was waiting for a response to Yosry's thread:
> https://lore.kernel.org/all/CAO9r8zODKgCcjTBK=P6BuXBBZRoOAFMeRJU8BmkWL-BCX2LoBw@mail.gmail.com

Heh^2, "Pick your poison, I guess" was not really inviting a response.
Overall the sense of my reply to you (that is: there are two callers
so let's not overthink wrappers) applied just as much to his message;
and checking AMD vs. Intel in common code is a total no-no so I kept
the reply in one place.

> I also didn't prioritize responding (or even digging deeper) because I wasn't
> expecting the patch to get fast-tracked to 7.2.  It's not tagged for stable

IIRC it doesn't apply anyway, but I am sure that the Debian/Proxmox
folks appreciate having it in stable, so I was planning to do the
backport by hand next week. I will wait of course now.

> In other words, it's the lack of communication that's frustrating.  Even a simple
>
> "Hey, I'm applying this unless someone screams" would have sufficed.

Fair enough.

> > If you had proposed the above small patch, for example, it would have
> > been a completely different thing.
>
> Heh, if only past me had realized we could have done that.  I guess the desire to
> prove someone "wrong" on the internet is the mother of all invention? :-D

Of course. :) Anyhow, I'll just post the revert+smaller patch in time
for the merge window.

Paolo

