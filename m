Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792314;
	b=YF/pgWCme7VI7HskiBNigTICxMp6aQpb2PdmPDs0IXqaSjq5nuC2uuYbWVOsa5VCJ3H9
	 UY69VhkTXVmrSGqX1BjhQ76hGRheg1nCTOTNlU5ga1BkNZ7/qy9phzDnG54WPXAPGRZKi
	 zgMhBQdk5/HcCBn2UHyqQX6GYUc8Bw8PCkpj122BeUoacGaXIvrWVJQxFMpzgCP9VJg9Q
	 VW1JPk/l3U28nCWIGMWaSvJCbZE8WIAjSbxeNHRCCV3cN2sfeA2THGXqWmk3O24UalPps
	 zZxGSBK5DH9rfwrlCQGLGVCM/8WaAg6lH7UNou328atdvZQ6Lt+vkHeZ8+5zfPB6Bnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=37bgzHVD8y8sAVNI32vtF0/e4Mt+8V5lKNPa4buINEw=;
	b=0PjAWmqqB3aJ8gBBkj2uwiYE0WBWvKWhjpxXLn1jxOGM5+b9sHm/qF4uInwKi994M49K
	 GnvU1s75wwa7qSGc+j8PR0uXQYQkT6LAcFWXv8C2MpiG9RAhc0mE5yRC4jMgwLUzAPW/D
	 fUrq1UZ8vIDHQnMcotOAZukqKU73gDfKM2KFxZC6QHQcIT5cP4QHQk+5IlEAUg1wrpXn2
	 6Gqcr1ehEkZ8JCEJPm6FQ4vijVXGDO3D2CxVbnrjThDCp+3bEhXwjZ+5WqcGkoMokiVZ6
	 JxFQdu40glp2fCSg8YILoE7jt6ObpPkb7xBdQ9pa6Mot7Mf1/3hS0hrnMNgixrSuq5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hTQFFix8;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C3606A323
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 21:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0C3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hTQFFix8
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b1eeef39a0so1577348a12.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792792313; x=1793397113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=37bgzHVD8y8sAVNI32vtF0/e4Mt+8V5lKNPa4buINEw=;
        b=hTQFFix8pn/Y3t4fncvPWkx+/E4dv1R+1G8m+PO1oOcB3UHZqMZlQsxwljO6bIWzBK
         ppASh7LU3KTalFg/FChHtssFZEKiew4d081cMUVJVpJ+paXaJUT5+XzAlutxkXjf0J8t
         Nly/LrQX47bht/9wdr/lSjgbzWtKvEDrZ7jujFjhT0L4t5DgH62d6ZeHQZdQczteFTSh
         6LuwZ1uaBAAmjqeTmNy4ZAQwqzbnVIEGY6gYUyTFt/akgtqEYq/S7JyrJlSJeiQa9WHQ
         u6WAL02GRPtB5i1ATfv/EhHpS64FKP40MtYzKrtbprMfusiahYeHhLCxcwR0nIxAmp6G
         Ss+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792313; x=1793397113;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37bgzHVD8y8sAVNI32vtF0/e4Mt+8V5lKNPa4buINEw=;
        b=wN/mi9m+athsJ4sjXLtRooMA+vSF6L07Ug87jcP3V3eODpuMsyV5FOT8Vq9XC9Gjn0
         vl6nIXbCn/QTkxh6xXwLFBOyygfZRApxD6TC3D5HBpUzIGhNIdXQiJwNb/bgYZ/a8jA3
         NTFVERd06OxiDlbT1PxUsF4OvKkOQkgaacHk2gBromf+XGVsi6kSfFmiCnXlXvvPc4Tz
         gtL5vj9yXNP2/eYQuoENLoeH2JUdrKDvb4NxH5ch0GovOorJguVptKoX/ao38i/wqFLR
         BQu2FLggRVRgJMxsRbxQ6Ag92vQr4NYzTFE8/kCUjvUGd9iiV5g6YNAM7LondwRpwVLm
         Wfyg==
X-Forwarded-Encrypted: i=1; AKwUvBxUvPUAxVj/csAFVuFnQXfLt11I1BatJ8cBnmPPzSTPRYo1glzhHZvvVPoAv12Cs2CqNZo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfQSMmVKKfIocKmdIR9MxuzqpLoxFF2P/Xu+MqmEIXyUOHJhpo
	s7bgbvTyLerxHNbCjWqazg9Ceh3IRTcXtVBKE97zeJ8fzMoGVGn0mWtT66hjE/3aWSFMsX2eGU/
	EocB2/yTzuXHLC1lmYQ==
X-Received: from edve18.prod.google.com ([2002:a05:6402:1492:b0:6b3:c422:923c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5191:b0:6b1:b97b:744 with SMTP id 4fb4d7f45d1cf-6b442ff3810mr590380a12.32.1792792312470;
 Fri, 23 Oct 2026 14:51:52 -0700 (PDT)
Date: Fri, 23 Oct 2026 21:51:51 +0000
In-Reply-To: <atsQQcUiVhb9KXWZ@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-2-tarunsahu@google.com>
 <CA+CK2bC_wc4LxvHe0TREbBP7esYW3pcMNtkGK-kqvf6MyvOh2g@mail.gmail.com>
 <9huzik2u6hs5.fsf@tarunix.c.googlers.com> <CA+CK2bDyk=F7W3J=q3pKCjsr2wy_PLdgqgu+ywp0F5HL=VoMpA@mail.gmail.com>
 <9huzld7q4zjz.fsf@tarunix.c.googlers.com> <atsQQcUiVhb9KXWZ@kernel.org>
Message-ID: <9huz33twf5l4.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 1/4] liveupdate: Rename handler compatible to name
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Mike Rapoport <rppt@kernel.org> writes:

> On Wed, Oct 21, 2026 at 07:35:28PM +0000, tarunsahu@google.com wrote:
>> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>> > On Wed, Oct 21, 2026 at 2:16=E2=80=AFPM <tarunsahu@google.com> wrote:
>> >> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>> >>
>> >> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@goog=
le.com> wrote:
>> >> >>
>> >> >> --- a/include/linux/kho/abi/luo.h
>> >> >> @@ -84,18 +84,16 @@ struct luo_ser {
>> >> >>         u64 flbs_pa;
>> >> >>  } __packed;
>> >> >>
>> >> >> -#define LIVEUPDATE_HNDL_COMPAT_LENGTH  48
>> >> >> -
>> >> >>  /**
>> >> >>   * struct luo_file_ser - Represents the serialized preserves file=
s.
>> >> >> - * @compatible:  File handler compatible string.
>> >> >> + * @name:        File handler name string.
>> >> >
>> >> > We are renaming from cpmaptible to name; I am not sure that is
>> >> > necessary. We can still use compatible for the same purpose as name=
.
>> >> > Unless it really bothers people, but for me 'compatible' works just
>> >> > the same.
>> >>
>> >> Yes it is necessary, For example if we have two handler for a single
>> >> subsystem. We should refer it by handle this or handler that, not lik=
e
>> >> handler with compatible string this and handler with compatible strin=
g
>> >> that.
>> >
>> > I still feel like compatability makes more sense to me. Take an exampl=
e:
>> >
>> > We have two file handlers for memfd (i.e., FH_OLD and FH_NEW): one has
>> > compatibility =3D "memfd", and the other has compatibility =3D
>> > "memfd_next_generation". The user chooses one of them to preserve the
>> > memfd data, and the compatibility string is saved alongside the FD.
>> > When the next kernel scans through the registered file handlers, it
>> > must find exactly one that is compatible with the preserved data.
>>=20
>> I will open this for vote.
>
> I'd rather won't ;-)
>
> "compatible" does not contradict more fine grained bitfields, and still h=
as meaning.
> Just like in FDT world from where we inherited it, it means "these ops ar=
e
> somewhat compatible with that serialized format, will check the details a=
nd
> will know for sure".
>
> And IMO we should keep it.
> =20
> And please, trim your responses. I had to scroll 463 lines to see there's
> nothing there.

Okay.

I will send the v3 soon with feature flags only. Also I will drop this
and its next patch, as It will be part of other compatiblity series with
exporting the schema to userspace so that userspace can make better
decision in selecting the handler (As per the response from the other threa=
d).

~Tarun

>
> --=20
> Sincerely yours,
> Mike.
