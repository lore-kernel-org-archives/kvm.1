Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792246;
	b=RNbDwhRpFjHhKBUmbm+QTb/Okm3yjzB2v9xLAmfFXAfpyN6UrplA8BS35sx1Y1CVm30G
	 ApN2/FbmxadWyRxtLXIxeYm1UPzHrfrZE+t5TmtWMWQLd2bTcxwYOwtiO6SWV/4ZXR2nm
	 FcTWEWOi3M3E1QfbG2Cmv2N3lHQMjsG7de65xxkYTraOBPnYIu8rqxcvszhPUnN6kHeLL
	 rp73d/T+APdx0uBfh2ESK1MSPig8iX0+wKidEyN6O2S9AItRMb/hqTvHLqjx+MvzbyFy7
	 sFcgVjocaTkI86ANFl0uvmET+iMjPf+whdvnlFp1kdudYPrCxc0BvHq6hD02oYeIMyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792246;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=ozSGf2zyuVYYLVzmKkiurYsLvvrqYzVSGZ8tHSkd2EU=;
	b=aMoAFidk2BQf5VfIisztmvThY9ED353Pi5afG7fKpir67yIwRXTJQga7A4Bg8IK3jKMR
	 3SvgPaK69KpCbA1wvFLq35/9Q108El86VyJv9kbxWzsy7kq3WebjaqeeSdzhoNcGjqMC7
	 LOd2xu7nOb5KNVpaIZ15TCJ1JHHJBWiMxmTseqdAts1aKQ727qGawGCZeeZDwuTenU4Yc
	 d61Y+72E5wHPKQntAEfW/VotUbWnbxi7XbkpINeQT6Py3unqPdQGM5FDBAIhxsRRoVzB4
	 JlQC9Cdr9JiepG0yFbQspPW1LscMsDbY6MdzPX0TkthX9c/C4kn2iLX38LrwRNT5dGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQG4LveK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e+BJ19sX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB87606EEB7
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 11:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB87606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQG4LveK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e+BJ19sX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793792245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozSGf2zyuVYYLVzmKkiurYsLvvrqYzVSGZ8tHSkd2EU=;
	b=HQG4LveKxNj62rvCfebZQu6lRTq9xQXx4iiSEDMr2Wh8usoSVbw9YL3Z/UAiAGYw7O3uBL
	XnlGjfPIkmimebgrmUjg2myy3Y5//T8HB3VX6qRuktb+vef7pULZ8XJzMbJImYUjjRpgMr
	so4R8gycs90u2j94Me4Jasv09EmZqEg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-gowQLBn7Oe6AIswaJu7YiA-1; Wed, 04 Nov 2026 06:37:22 -0500
X-MC-Unique: gowQLBn7Oe6AIswaJu7YiA-1
X-Mimecast-MFC-AGG-ID: gowQLBn7Oe6AIswaJu7YiA_1793792241
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b02d63407so566789f8f.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793792241; x=1794397041; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozSGf2zyuVYYLVzmKkiurYsLvvrqYzVSGZ8tHSkd2EU=;
        b=e+BJ19sXHDIDQjJBttZD1l6dXkUHVjAVK2T0XmUuCboYncRhk6ePDwuI1Le2S0r+h1
         HH39dH9YuLl5WU9+YAx9kglkF4CcWHnLqnLCiprDMCtj6eMDzQSqy84qcszXflg8X8yO
         rol2ivdA+/hk2CTosF3o3SBTyXOBqmSpd2nHSwNM6wOGnG3JBcjss+XD234R1GLsD9uO
         dwMq9QtK4oaFuC+EB2OFdi9WKTZ8fRiJSbOcocfT2qkv50Y+IgKwNOqyT4lQ/IzX+xhJ
         hVd1AwCvfDdWqdd8aRmGRlzZp9WrHvtKZung5IFO7kxhex2j6A4urhYsuLMxo321t/Jz
         42Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792241; x=1794397041;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozSGf2zyuVYYLVzmKkiurYsLvvrqYzVSGZ8tHSkd2EU=;
        b=1pYHrIXwXynPZq/2G9H+sBMe9CmyNsfgk/jj2yD21gCntFrb2GLZRVbu4EIbTyCawC
         xcIjzr9xPdfuDr5AaTO6sMV8JYV/Q7qEO9cfQf4c4MktxdJvtS8hR9MNAtpNx9Nqia53
         6CjfB36sNFALN8Nj3cO68xTdmzo3vPP6uR9BuNg1NbXHy5C4uwQMbi/0N0B6CWLe3TdI
         sW9HwfCz7wEf0+ZKYMkyygUOF2WXUffL9wiOP0k9aYCpE80kd/6zfruM5vDPoie67hEy
         iiCDaLeZ7qjmVsRUROmANYHZvAVP4RugSteY2BLwfmsZbcQvK43fZ4kXh6W/h+hCjCb+
         vYHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXoJ0kbnC79+EsqZmN/dnbvgMNCE+eHm45FShyzJHyLocPobNBgq5zPY6a4rcDyQK0v3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8va2BZ67Tl6TG3cMVALQVwxjYo98gVa/BgRsxUwUEcSFR2TLtM
	TqqXPaIWKy4W1WCMHbVGyzpIT0WbEn04CVTzUUe4uVe9Xhir3YQ3zl+B/8S6MbLdZRv3IrqgTaV
	IE6ElZISufruJwc7bCWTYOZvW4A2w50OKshVaod0GaTiSMbmGqS9OUg==
X-Gm-Gg: AYBFou05MomkwIsWJ3oYsVQVEYoMtoeiQ87a0mJUXGJ8TrAR1X8DTf8dzWDiLMcqWNq
	PlcCchrLaRhva/3UlqiiR5dNmOeeUJUqO7sP49wZbZHDj+PkVXyf75tV5lw29mP4Ec9bFHfa02C
	zvNpSVqKnmOjLMtRGC+sDofLwtuSVhdSM3kYBkcQCq77IXHRujkv2QaK+IJd6r2HVCtEBCvMzaS
	FuS29dHBv5ULkET3sVcmVvLPAp2nJQ3JhjX3vJfK/63xVDm3VB9MfetY4VwX+674LheEw0Z9ujD
	gQ5+SWFWVJIlwgEcctnxNa/DnNkNHAyUFPjabUH/ByUUTOeEI498yOS0lqlrOnblFEaZpbOetGI
	awnzyfVDTMvUTQLu+wE5x+huI3J7SoD/cGfyahLddL4M1uSUJyWnQbi3fg17Q02L4/ciRXEx1qh
	fQPExc11Kc0ZFJ7Ftq2oyoH3TLHiePbZb38aPRGg==
X-Received: by 2002:a05:6000:260b:b0:48c:4553:790b with SMTP id ffacd0b85a97d-48e6e50075cmr31750648f8f.48.1793792240852;
        Wed, 04 Nov 2026 03:37:20 -0800 (PST)
X-Received: by 2002:a05:6000:260b:b0:48c:4553:790b with SMTP id ffacd0b85a97d-48e6e50075cmr31750621f8f.48.1793792240514;
        Wed, 04 Nov 2026 03:37:20 -0800 (PST)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de. [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm3430641f8f.24.2026.11.04.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:37:20 -0800 (PST)
Date: Wed, 4 Nov 2026 12:37:19 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Mark Brown <broonie@kernel.org>
cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
    Oliver Upton <oupton@kernel.org>, Ben Horgan <ben.horgan@arm.com>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH v9 0/3] KVM: selftests: arm64: Improve diagnostics from
 set_id_regs
In-Reply-To: <20261103-kvm-arm64-set-id-regs-aarch64-v9-0-ab32bc79fa9c@kernel.org>
Message-ID: <7db30970-dc9c-702a-2f1a-f52c2e253494@redhat.com>
References: <20261103-kvm-arm64-set-id-regs-aarch64-v9-0-ab32bc79fa9c@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 3 Nov 2026, Mark Brown wrote:
> While debugging issues related to aarch64 only systems I ran into
> speedbumps due to the lack of detail in the results reported when the
> guest register read and reset value preservation tests were run, they
> generated an immediately fatal assert without indicating which register
> was being tested. Update these tests to non-fatally report a standard
> kselftest result per register, making it much easier to see what the
> problem being reported is.
>
> A similar issue exists with the validation of the individual bitfields
> in registers due to the use of immediately fatal asserts. Update those
> asserts to be standard kselftest reports.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

For the series:
Reviewed-by: Sebastian Ott <sebott@redhat.com>

