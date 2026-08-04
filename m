Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C03C9ED5
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847497; cv=pass; b=YElBVfTQXIWLgLoc/puT0uaPG0b5UOFsK7O7xfMViUEahKCIOtbGCleJofOBEaKbuypSpAcisOS5KMipxTYyNzPUz8Q4xspfU3WKZGuxNmINyNVdqzFb33CV2PJmaUSPDf9qH5sfJdW/LYUEA88PVDdVkI7GP8u/nrHNYGryF9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847497; c=relaxed/simple;
	bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE2O3hn53PSrv2KKtL7e05INebk1Weko8ABtsh/Soes3FExVS/bhW4Ju/V/Kr7IIBiofgXySCRW1XqkawgQBFkGpKoGpkM8P9B7HhFYsqWw7h5kAMr64WZGsYJSaA16einledw2mXBn5UjpR438bAYbxW1pKVkUt73OdCSFjNTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OgmpqFg0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbiiUNS9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgmpqFg0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbiiUNS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785847494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
	b=OgmpqFg0ylB/24ZG9TYLHrRlqDCrFG6UCfuwDkJAsBvVxZSXYFqDdC81JK9kGF0/E1Q3hn
	LqvsGtbHW/Keru8To7RNZ2gKvNzHEhnr7sZzNUs5SxKJqul/3+9WmhP6vMpqP+/b4yhlmJ
	Lckl3Oqluh443nfnZDTmKLR59dUdi/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-vimv9Pf7Mgukp_l3hoEErw-1; Tue, 04 Aug 2026 08:44:53 -0400
X-MC-Unique: vimv9Pf7Mgukp_l3hoEErw-1
X-Mimecast-MFC-AGG-ID: vimv9Pf7Mgukp_l3hoEErw_1785847492
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472a798fc7cso3824990f8f.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 05:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785847492; cv=none;
        d=google.com; s=arc-20260327;
        b=XRoly9Bqem0EPv6KBJYMfoBAepoxPTIkHbVyGJk9s/OumhbOEzUyFkL75rkiIOjc3Q
         Zmr2Q4w9eWuBGMitWorvU1Dc9dOfh+4mfeGbp6pihh38zGLxruvQGlj9AAfr2u9TuSZn
         AosMymemXeHh0h0ro/XEyUCENNJgq3sQmyo0dbP0wIB4XI115TVNfuvo28tWgp9ervD4
         MF3H2LmaAmYWS6yBVAH+DQ96pW2VsVawIFTlD1rS0ICPzIkxbieMqM9cfVYFceQwziTl
         NqOsr9VXsdBdT7M/j+wNBdNKBOgNcYhg2g4EqUI3baOqSnNLtx2aArMo39TexqWsRIp7
         2Dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        fh=q53JQc2D1d7pRTSyMnzcmfTI1TVslrtpJ8HHLZyCOlc=;
        b=HYCSE59Y1A1fbwFruA+RMb28+IKRf4E6o9A69uQ2Kj/km1JMBbuPJzYB4wzUYVC3y6
         7wPk8bwzZdNsOYpV9y0lhMslBRfnY9p5TL/Bm3ZaN5e326TzdbvDcEA53abPPUoOGg7s
         PGjcFz4y4SQWXSInxXgq5aJh7ZZYx6zQd6Y5PZxbeOYgw4utfFIrztHMhUrm+Rr2KOVf
         cCpvIYBgQr++WhbCtspcw8P//nEigYFfZGPnfQGFkyp+jJ1HfrgDk1ZKCdMK9EiLDXIU
         C041GOclAL9VJshAhZuYX/fo70zdAVNj/UQRDvqduSxIQMpsgLjY1pfwaVNX5qWFPPiz
         f93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785847492; x=1786452292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        b=LbiiUNS9WLDU22basKkI55N9OCI92YtF+oGsC1mZvnztuffOsRPJfTrGs0MJUQewUk
         iUlYCYN1LZbfCi08s6UQjBpAOVHoao2BRoIoO9bsh6TDj0U2hnkuDmQr67N2+EIwiGuf
         +SnWity7L8nXz+dy0ZOGpX7gndjtogzPCTF+iJbdWskRIscDAyxy02miSu4M7EwAIxw9
         poSEHKoXrGJC77/xvgUyt0Nv9U7fJS6S20vvNZ75Ns0HelqsU4IUFIiidaZye79Huh1h
         1n3bRV9WU0/i1Z4RQQEgG8DDc+MEhEMdmlJFQPo86oEEduLsX4C8/fnUNwE8cmxn+DQ0
         dwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847492; x=1786452292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        b=hX8KBMMmoW2l+e1477uIiN0Wk4FlKeGs83+2W1LAF5BCKvMscXPiXErOhv1yhkTPlA
         gT990PvRUUT/rcQUPFk1oXuVoCndFzouzWSoQGFyXObDe1zEpS6qjpBNowWVoMDDAqYV
         W5oFidzTz9UcZ3hJzf3+75nLuPvo5FLK96dvkQrXMgBJ+d35+jT7/33ddICf594Xav4H
         xt6iGpbUClf1zS5yHlDQ5+cwFOiWszVmd9BjcN6fPtGUkmYt6b0L9AQfZgKIh9PSo0Lw
         QLEIGls/+d5nA/UTLXr3E1uiAqAqgqK/CZ5gEJ42nsRNOfdXTjECqcU/4QqXCOS/S6qQ
         Ph6w==
X-Forwarded-Encrypted: i=1; AHgh+RpkSYb6zub+eXIn65HOQAt+g50WakY37bkihfPZw+DqhHcQOL2YWpT5Pvq7m364RTma+6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qUSkY4KipWrn2MFl8LrmS0sypZIPmC8+Bb9n5pHbQ7Kco/rD
	0LnIKgBGR2xc0CaX9K421kPyVWiREXmECZPsbDAJb1IFpsQnq/ms9gS8V2rsykKQZL2Kq3UtN54
	7AZ5DKAnXv3sDaWvMk/+J2mRKwlSpGF1EfkPMd9yrs3H8Zwbbbxaz2RPuX6zpiAIPDvOfq46H+a
	dDIdR2djUSVXmrv2fozJ/z3H3auqly
X-Gm-Gg: AR+sD12h+/g110FvFc8M22mTSXglh3GJs+c2m+Wyhu7VUR4cmUKwSGHgoB9wJS7ROPc
	RSzWO+ul4Mo2VpJIzieTcDrQBVpFQvF1c3qGiUpccmXRTP6LHPnsx9UxqOje1YVdP1fT/rZxEbR
	xG0jDPRJfXv9WvsvPyi87ECf5zK57rgB6fAgsZSfu14N70fBLFszX/itPXhxlZIcL2wpGgZA4Jp
	gXcbZfWT/pgprgXJzSENwuI2ztDHM5ptEvnyDG9+/FoKwLI+wfaHQ8VL+c=
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id ffacd0b85a97d-47fd72d9daamr44077306f8f.23.1785847492505;
        Tue, 04 Aug 2026 05:44:52 -0700 (PDT)
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id
 ffacd0b85a97d-47fd72d9daamr44077224f8f.23.1785847492081; Tue, 04 Aug 2026
 05:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-5-pbonzini@redhat.com>
 <20260804122348.AC6E51F00A3D@smtp.kernel.org>
In-Reply-To: <20260804122348.AC6E51F00A3D@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:44:40 +0200
X-Gm-Features: AUfX_mzeBd9D7i9RK65m6Y6i1uzG2a-w4C9IIV172eXDDgUNWsdPG5F7opYXrlc
Message-ID: <CABgObfbd63O_UkmCcik1z0J847Sr6a5rnFgwttBjBb0am=+2PQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Write faults on write-only `VM_IO | VM_PFNMAP` VMAs are incorrec=
tly rejected, breaking guest writes to write-only device memory.
>
> If a guest performs a memory write to a guest physical address backed by =
a
> write-only host VMA (e.g. VM_IO or VM_PFNMAP mapped with PROT_WRITE but
> without PROT_READ), get_user_pages() will fail and fall back to this look=
up.
>
> Since the write-only VMA lacks VM_READ, this check will evaluate to true =
and
> return KVM_PFN_ERR_FAULT, skipping the VM_IO | VM_PFNMAP handler. Could t=
his
> prevent guests from writing to legitimate write-only device memory, such =
as
> command ring buffers or write-only PCI BARs?

This is theoretical only but actually a bugfix, because KVM does not
support write-only mappings and therefore it would not be possible to
enforce !PROT_READ/PROT_WRITE.

Paolo

