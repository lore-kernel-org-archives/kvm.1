Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4033E022E
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957313; cv=pass; b=nlQXibQoU5FZ4P+w+oCiHMtNiYJKhLDAxGx/EqGLlxqD34N7wAoraY1zr7vWCCnyR0v70/R9x5RLtZRrbEpwJrdYFxdiNqWTpgj6jkj/ksVV3mO7YC0hz/xyzgQMnmr93rLftzfhJCdTAdD+lPddZbHJwMbG7hwbhrIIgQkiJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957313; c=relaxed/simple;
	bh=E00i/s09eU5gl2pPwex8CcCqyUvImg1zAVHPmKsPPzg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRFb8/VgfowuSh40G8LX4R1c/2M7Li46zdudzwiXChoR6LePdWGBbKUXws2d9K98/yuKfHAYBuZTCUv1olO3lXqsdMgXIKlT9qsxXVnS0K0114bcfw+dYDIvhrAsr0snuo1nrD7r/TwO93SMr9UTRETyh5XNiNQPBggQ1cB7CKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPiZPN13; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPiZPN13"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2345440a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 08:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783957311; cv=none;
        d=google.com; s=arc-20260327;
        b=nU0HacA26neRGG5yrqbRtZHHJUaTN6phcV2Bnp4iVLriA/3J4B1Sg6ba2AFWzZS+n3
         on2BGR3XzVRw4XCXA2L3k+04nS9dmjUauq0TpXM+PKMf9am7Y5IGNHY8FPfoI1MErpu+
         1w+5CeO859GeY/Tf+bS4Ujbxpxi0CRbtnilYFBe7S/UdvNhpBu0eztcTKouoP/O+WVyd
         lda/FYFRNrmQfQ+z4SCivi2yTWURz0fchXxxtpIIO0WyY7TUPyEBmSFCEEfpSxBwW7bc
         HEa2OyMWc9nxGNaJcH3gTTkEYbISo74MJR50MMgbKuF69bzo6TTpBnCb2qVSDOC725jr
         og4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=E00i/s09eU5gl2pPwex8CcCqyUvImg1zAVHPmKsPPzg=;
        fh=KpNrqsT7S5VV/057uQApcPPsbfLEBm+eEe9cT5VuofE=;
        b=JH/HRpIdWuNdSHWXR9aI6H0KxWnVht5nGcZIEHEDSXkqfxgIw4Y+aLV3qnVmgmHviO
         GSW5OH6B4ssdJnjCqj8s//tY/dQQfBXu2nNMl60AkUC5UDv61CGcbRXGU6J1jOC55eqk
         ciTDK4ccR87a6pB3stkeOYuDZb3U0/+Ncan2ANS9pzJJSMGfnA/iay0Z5w7SFxmaBNRI
         TMp29t5WAEnz6yXcT9U2sjcSOz3ZlGlkuF9eH678ByRTADVgG8dOFaumVck46DcMFvHS
         GLkHNggh805woR1MjtYhJCk+EVTp0GZgafIrkeUxv6Icn3H8uQpdXHLe4l1IZsFPPNR4
         PdTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783957311; x=1784562111; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E00i/s09eU5gl2pPwex8CcCqyUvImg1zAVHPmKsPPzg=;
        b=tPiZPN13/77+3dKCmRpGvEpZh+NfPB8OM9WG/fivPUw2EamGCWoOTvRprSXuBo/LtJ
         x59WQ2kETIgIZWE9Q/dX82uiAKVMpwnhUbK3hZObZISB1rqlAPrwAFW7wWwzXpwwjiWl
         0qi3HH69x0K/lMSCdea5E0LTOH358k1zalPOepA8m8nUJgCJ9Szask7v+n3wTcYmaHgB
         lqbUe+H325kCcCA3EHEQKCQGR8W0sVXV3OMUe4+gFTLq2IszqWjILp5LTmaaNCCyxvmy
         18YVpybQoR51XSFjf84tdQwmU7XXVhqKth3pDEk+2PPW3IQQDVADGxbtfuUUvNsoHFQ/
         9buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957311; x=1784562111;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E00i/s09eU5gl2pPwex8CcCqyUvImg1zAVHPmKsPPzg=;
        b=q8tBJOJh11c0i0nXH7nQA1j3sQhnqYnT4jCNIGaaYfyewxBIJplrs5vb6KC2Ji5GlA
         RqAE78cZt9RpOCrQvhAJL+AN5z7MapuFdYYfNUOXF0MMu07FAs4+46xAwpnaOgImuGuh
         19K+iQ/hBm89XGegWNPgZ3V/Ui9dC0EV8rYs3ZNLr6KK1wqgDv+zL34DhxMi/f23ftcL
         0FqNbm9zV+ctrSBbbCoO6OufL3avjeIj3/vJaxgxdzKl6AUfcsWmXSLXqSRiV9/Rqc/4
         0oszP02suBSqlVHYOXKupmFKeGuUcKuPtA2efotcNAvUfFnMnCHgMGxCUe3r8Rt9MFax
         3K8A==
X-Forwarded-Encrypted: i=1; AHgh+Rpsesn7a0DfEsrcFgG5L7RUZueYrXShOsyxISZv7EMNdV5oDNLMwWwf4q6xjN3QlLPA1IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz111R4//6YyfPSDpz0ApZEO/uFerCQlRQ9UcaWqmoQAmlp5OJc
	zfftV3zFSYiK9sOqQkKfWWQOCr8cGGhrlazYMaJWfE0VRPIur7u0RutErPD1ha4utQGkcdOAn9D
	ILXUBTXN/oxvi4uRQD1eTTI9Rjy+HNF4ZwIvGBe84
X-Gm-Gg: AfdE7cmc9PsSPn5C3Am9rHT6rT7MnOoeCIsv2/GgiGa6WcIexrdCqDBx3+yXc5u24j3
	U6A+uEgQi9iiSd9S2BVugOaPgpJiyo8w0u/R4KZ6IIxQp17kKM89NNIy2kWjddvHOVmY8saqc2N
	832dr4IGfI4GzVpQl3jGe/QQMM3AWN16QlCTblSQfUmooRSZAWMndOpI5dEQt0YMxIpSPXxpPuf
	q0PDSIEIVZQ7QKS0hNdTv3TPo0LvKKopsPvdmu8pBR9+C9l2+65bAJoUZUt2O3s1Hyt0eBzFy6x
	IWbqBZqZSSb5yovoadGhKw+okcJn2NkUzDljn+wg0lOzu1ddB/jwPA4XuRCfnIet4lEN
X-Received: by 2002:a05:6a21:113:b0:3aa:c93b:625b with SMTP id
 adf61e73a8af0-3c110762fd4mr10225955637.3.1783957310978; Mon, 13 Jul 2026
 08:41:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 08:41:49 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 08:41:49 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 08:41:49 -0700
X-Gm-Features: AVVi8Cdlu73h_odPVr1xWZ78EcVtzZg0XBmzdD3qDpzU7-JRYgNm36lPCMQb_B4
Message-ID: <CAEvNRgFgaDx9OivkKteksk36OvchMNmAk=i8CZj31huxqXB-Pg@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Fuad Tabba <fuad.tabba@linux.dev>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <fuad.tabba@linux.dev> writes:

>
> [...snip...]
>

Thanks for bringing [1] up, I didn't make the link when this change was
being discussed.

pKVM definitely needs a callback when the folio is released from
guest_memfd's ownership.

>
> free_folio is the only to_private=false caller today, but the cover
> letter sketches the other one, a private->shared conversion through
> kvm_gmem_make_shared(inode, start, end). Once that lands both reach
> the hook with to_private=false, and as far as I can tell, the only
> thing separating them is kvm == NULL / INVALID_GPA. That isn't

On the folio teardown path kvm has to be non-NULL so that SNP can find
out which VM to unassign from, so you're right that INVALID_GPA won't be
sufficient to separate conversion to private and teardown, for pKVM,
from the arch perspective.

> documented as a contract, and nothing in-tree reads it on that branch
> (the kvm/gpa check is under if (to_private), and
> sev_gmem_make_shared() doesn't take a kvm at all), so nothing would
> catch it regressing. The sketch is also inode-scoped, so I'm not sure
> the conversion path passes a non-NULL kvm at all; if it doesn't, the
> two aren't distinguishable.
>
>>
>> [...snip...]
>>
>
> The Kconfig now couples them too: an arch can't take teardown without also
> taking conversion. pKVM wants teardown and not conversion, so that's a problem
> for us today, not only once the second caller lands.
>
> This is the same ground as v8 15/46, which ended with the two split under
> separate Kconfigs. Suzuki confirmed CCA disables both; pKVM wants teardown only,
> since our conversions are guest-initiated and EL2 has already done the
> transition by the time the host runs the generic path [1].
>
> I'd rather keep the free path on its own callback. If you want a single hook,
> passing the caller explicitly instead of leaving it implied by kvm would work
> too. Merging the two conversion directions is a genuine cleanup, it's the free
> path I'd like to keep separate.
>

Is it okay if later, we add a .gmem_teardown callback with a new CONFIG
flag that pKVM can use?

If that's okay, this merge (of function names and of the patch series)
can proceed. It's also nicer that the new callback and CONFIG are
explicitly (re?)-introduced with pKVM support so the introduction is
chronologically linked with pKVM support too :)

> Thanks,
> /fuad
>
> [1] https://lore.kernel.org/all/CA+EHjTwLRzrq0vY0-OosENJ2Gkknerux53aVBj0zGRQUkRQP=A@mail.gmail.com/
>
>>
>> [...snip...]
>>
