Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795256726;
	b=C18ygPBy+kFvO+tVQWVKjLW2Et7KtjZs9zUK0mTWCnDoM3p8B6HV4CifnbyDJ93JiJCZ
	 lp3N6ip6wp6b1xDEzckO7TOklrOhQaNv6xMXDB096IQepz757KU5y8QKhkETlRIRGmIs9
	 uFhvMozVpbzOFOeoLdrNe8pbE84q2IK8xZLfROIH6lOxbRELaIJSuCMvRYOSEcSQE0vzl
	 /xQUONrs8hIAspqGXEqm35wKWwuYaOp3ysKa9vasMxLf5fHe9rDmT9ASZ0/TYF4fDkSNZ
	 hnK6wpV5Q9cA5i2OFK+Rm90KLeGd7oIvBOQr6I2wWkIiDwm8MG8F0Rh2KEY/DV9u/WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256726;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=5Oc8iipyzyYfaL6h0ci9uEtthlQNUz4zL4K4Mf4Joz8=;
	b=5EuRazc6ydT1SrpeWpoV3ez5YG4iaYh7au+h40uQEgZu5KC9dFpkMp4krM7gAVvKW+Km
	 eVc9E5trDk+TyhfCSjLsYiP4fxAFbkuGr6p+Xp6OsB9+/RWrMykix6xAOnrM596Ejwb9c
	 O4Oti+jC7suCvXoPETbwT/CjRlyrDIXjyCtSRhGeNDX0u/IGyEiM3iSkieZLnfKo3QZ0y
	 gyBPEnIe5M4OBysEt2QBYzoeTNoQI3RO82E/5hyXrwSnF1xPc0eS0l74e8zSl1Zrp+V6X
	 LXQtZznYTZvOWqAVnhIHPCI412oc1Ogy+ebkyJA3QZg2MdloaUUDg49MegmZDvkTa8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqhQiF7M;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="m3g5DP2/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD6606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FD6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqhQiF7M;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=m3g5DP2/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795256724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oc8iipyzyYfaL6h0ci9uEtthlQNUz4zL4K4Mf4Joz8=;
	b=UqhQiF7M2RRuMEoYYT9g5avk/nPLd3cj5QX1uGHKhqeCf99Jf7nFJmFFvKzDEKacVAt8Ie
	35AiqO3TGB1eArV7JhTSfbxh0qVa8CSNmSK+5SzD7Z/eEzAVwIYgCGQX3h+sSCj25e7Gfu
	uYmOUOYlEDVVLLZqcTZyGpayzPGtzAU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-CaM5P7-HMw2GBjOsmoopKA-1; Sat, 21 Nov 2026 10:25:22 +0000
X-MC-Unique: CaM5P7-HMw2GBjOsmoopKA-1
X-Mimecast-MFC-AGG-ID: CaM5P7-HMw2GBjOsmoopKA_1795256721
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so1820468a91.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 02:25:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795256721; cv=none;
        d=google.com; s=arc-20260327;
        b=OsPGzJEjIkU3KTmqPJrGhmpARG5/wKAxw0L1zKfQirtHZw0lTBq4yKZ/HCN8MR1Knb
         T4KhIgKUrPoQ+HwLFdIRVCAV3X4X6YrEEIGpKr1Bym0MXNeO2sMn/u54YfFyM3th9ws0
         C6MSI1sC7Do3Uejis6YxiHHnv8otw+t5HNkC7E466nMS2HfgQZJo/iqPPIlyuulCG2kG
         Kw/sPYP/WGQVtmuMVQwn0f6MwstpPNzy23Y9LrNHCl2UQ9QcyroalpHYUnvHbkTkUBJg
         EkUOtcEguvDp5rZ/04h6s4QC95e8a6uWKj/n05NUKOKZTi+LfvfKuLgrjcDRYSXpnrst
         J69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Oc8iipyzyYfaL6h0ci9uEtthlQNUz4zL4K4Mf4Joz8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=CPgTs/lF1ZSRv7ZAeiSLgr8NSBezeVwCWtT3eweHEX3eQiH6mnbRSgPf6lkR87osAm
         yZJAXO748RhYJygUYoCyTLH4a8Noa2Un+fYyIQPmT5LRTn1dhFbZTuAp2TL3ze40GRcr
         BIAJolnA2+c4o41yMDLXfr1yyRJk+ZueMrks42dbpID0s2fGxpo7ysAs0TsXSp7Pyr54
         3RmWKJZFb3hJ34Zv9U3F18DVms6nfJI9/+PalyjDbhx/ziIn/amqRNm28ziz63ZNfUH6
         6vjM5bcJACddJBkrv6seWf0JFgDu8EYz0EKMhDf2/bkISSw7wtHfJFMrz+3qU1ImCANc
         wmVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795256721; x=1795861521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Oc8iipyzyYfaL6h0ci9uEtthlQNUz4zL4K4Mf4Joz8=;
        b=m3g5DP2/bgL+FdKaPzoLCciu2BjJrPAHR61qwzlIGsaNsGbXrG8hAMYdwMWL/NrhIo
         4kSmxwM3/TtxmIx14793IXFc9sUWka8mEndYJnZY0mIikDMAqMpVDQHgDyRCxUfS7vb+
         lrP15dtGoHe3h7px2n99k9DzZQBuYEghmT/YtEFsS3H2gw4mrSJDuLg7hN4SuuMbypWr
         YSfWSgo/w6TNSVeF+HFiixCdxX88cP5bjDqL77WKpt35WrBj/jtUgTCfHZatTLo/fylM
         9PNoGZY2RhZ18BXLrl9yjZW605WxblBSRlYbhiYFRXFUfRAgMwFzrX+N6BOGEvE/Kcy3
         8bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256721; x=1795861521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Oc8iipyzyYfaL6h0ci9uEtthlQNUz4zL4K4Mf4Joz8=;
        b=adIdd0462fLqEPWiQIooVngwKewiVeJ4pz6SODQ5AgfdoPpaw7wdWL4pkQfATVJRsn
         dYcLsQwXOpnkYONW082jy+PhrfsNfl/qyp9Gq0YQMZUOIFfOEObzKie356UBIsz/leyT
         u4NgRkN2be/rKrBLkF19ZiS5BEkgxT/KFJxUHN/mMZOnG5X2fDId9u5vHuUwN/JzAnt4
         3AxyXkwBVH13CRJdets/X6U+smq6rFwRAdG1/+RG7ZV2FChoIWub5lnS8Xl0I3IKKBpP
         Kw6IkHs+lpjOiA1VWCZOWWkQmyG/w4F7Bc+O8HX4wNeCROsCJBdLRNevEeCgbgUTuu22
         veYQ==
X-Gm-Message-State: APuU4Z+v5flDaQ7BTifwS3AEsR7QUk7imCBonBSgfHT01WhTv4k4CR2f
	s48QGqwieJJbCIGuDc9W/yljtfNyrWrMU7qKnOAK5XX85wU4Fpq1+O//3CVktCG3IRY1VEoNMUn
	thJzf3hZ2fjJWgiShdo0GMoyDdjeJ0CpRhJY2OaNqsx77SQBlGn/rCmqGmLycEBooonM4n8SNCx
	/tfev/eMBs4kkCgFQCvcH0o8eFfiNyv3Ow5S30Gtg=
X-Gm-Gg: AZFdTZfBUYaCwQSqHRNw7cBtluffMlLZhvXSCWIFVUFMGtULUtQGFjkM5aNSOzKaRJL
	8SvpqcrYrNbpHQ+sFQGK7XmJiLgqnRQhCt/4cLRQiYPBQLy6cg/qWS1SkUQ9cJ4AuhpBuGz7vJC
	6jdVGkArZV5cEh3TcG+ZqjT0aq52RsM9L38oG/EeyyqkJzhi1bYTTtRNWH2BtuPZBS5RP3eHVEA
	M106sUB9F8dzjoms/VcakmZ8q6tHuXc2m22KSCSrP3i2zs6LPrzsSiA+cfd+Zp19KUiOlFaUBhV
	UaScCoEN+mXJ8YApnZne
X-Received: by 2002:a17:90b:554e:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3b41c981a67mr3806653a91.41.1795256721037;
        Sat, 21 Nov 2026 02:25:21 -0800 (PST)
X-Received: by 2002:a17:90b:554e:b0:3ac:860e:1af9 with SMTP id
 98e67ed59e1d1-3b41c981a67mr3806645a91.41.1795256720577; Sat, 21 Nov 2026
 02:25:20 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119201813.15320-1-seanjc@google.com> <CABgObfY_iw6-Yp+hJB3pbV4spTMJfLc2M0jMs8_tu9xumM2wHQ@mail.gmail.com>
In-Reply-To: <CABgObfY_iw6-Yp+hJB3pbV4spTMJfLc2M0jMs8_tu9xumM2wHQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 21 Nov 2026 11:25:09 +0100
X-Gm-Features: Aa3M54rshjkaEHMpm4QU8cPI31BaZQceJxcxyffUa5GXdcMvaY5QBELRR1-AHuo
Message-ID: <CABgObfax4jM8M+SSd5YXKfcCMxtD-9hBye0R9jx32zWpyux=BA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Fixes for 7.4-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 10:26=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >       KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()

This is missing an implementation for book3s-pr and booke. I sent one
at https://lore.kernel.org/kvm/20261120133623.479601-1-pbonzini@redhat.com/=
T/#u.

Paolo

