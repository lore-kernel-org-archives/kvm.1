Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1332BF24
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160060; cv=pass; b=fw2RzOCoFkNJ3TqvyYNjM1zRfw5GtlUpeHGMCA/YsUS9vhkVbbupxiRCyVy9Q3Z7CCbXuxbbWCa1Q5j/fOEj0kDJF0sJvDt3t/pCufab7tgkwZVH6Nma/HSFvfP8D3KvppdYz+vqJDTWg3uQUoomRDKS+r3x87EbGu4OtBu1pfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160060; c=relaxed/simple;
	bh=qv7Tx1l4FiPi8N8Utpr2ks9OZOajpy67WA57/2tcM/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+gD//XBrKXo9l5Ki40CCTpEtSKOduDpyQG3ueLDudDQcuwWcTzcmIKOqR846B9JCH6OXMdb4u/CBpdIH9C7uv2gvCGYG7GyPhV2jfGwtU68tQzNvlxHpP9jqwrBbysnTHGjjxpMCB3+g703hzi2KBUAlEmdGqy4gjAZ6Hvvn9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qckk6nDn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiJUXj3G; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qckk6nDn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiJUXj3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nMfUu3F/UMphksRRuPuoVfLiv5XQGx2kShpbOoWLK8=;
	b=Qckk6nDnjd/Q7g2P2HZbkceXwTJsLMqwFCliCr3bVp2r+T+GJmDBeHK2pSKVVRHvw/WtUV
	ExncIjy7tqh4AFdueOxrI9RiTfjMrNjd2y3YjEs+k0jlrQSjFzi0DbjrG9JAdVgXzReQF0
	GYTOAh/agNV6/IIO0ySe8lJVK73mrak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-oe1Fxc63MBiCakpmrPsrTQ-1; Sat, 30 May 2026 12:54:14 -0400
X-MC-Unique: oe1Fxc63MBiCakpmrPsrTQ-1
X-Mimecast-MFC-AGG-ID: oe1Fxc63MBiCakpmrPsrTQ_1780160053
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef6ad76bfso640958f8f.0
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780160053; cv=none;
        d=google.com; s=arc-20240605;
        b=b8MM2HPdVpG7Da1XWRs0sYGd+PLkV2jp3zhrE5ymINr0/xhoKYph2ZJATAv/6iov2Q
         4J+M/lX/+tCYGmxcX11JKrhA1sVuiT2MY2c9+K8FZEfObaB9sAkgfKWXiWAmrAlmt7mt
         2+u1OpzJAMLVceNfvUoMDNfBJ5UFugP8U/sh6WvKER3uT6QuhFaVd5yMEwMI+GO4DdZV
         HV1u46jnruJ1Zamb/6zbvlgdO9AvM/sf5TcPTtlW8cWXDu4eGlxGrJX/p3Nq81kuVEO5
         +l5t/BCSgmUlygu1tjUocAgSgKOGkbRmqV0xsVPD/sKkKPQNIZ+uHKff/ixy2jdU3zRt
         MeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nMfUu3F/UMphksRRuPuoVfLiv5XQGx2kShpbOoWLK8=;
        fh=Es6HlFv0kBen53EKAPSls0x1bEKz6geM3Q4s5TPe+/M=;
        b=cUPIAIKdZMS1F2cCZdwOwgX+WxrVCiOVLVPITFaPdb0rj2aMNkYe6McihcfcJK6VpN
         qqHnPb+0GjhKYn8rKAEumDsnmUGnug2g3pNQUZUgLjiJP8CEs7Q8opvKZ//6volQKWmG
         E8X9QHam6J4OAO07q+kWK2OKaogotRUNP2eCh2bmE5WC2MLtiRUA0j6MLUGJKduIDAOR
         mIvYoLIO+63tG21juvNQGkKTXdQanfzisGwejMLHmN6UHwttZTPxUkUsnzPTcQK0wpZc
         MjN01l/3k6FMLiZE627Tsb9Mzx/mPUyvBuJYU6d6dFHI5CJe5POIzyqEHhUXVkaDoWne
         eS1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780160053; x=1780764853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nMfUu3F/UMphksRRuPuoVfLiv5XQGx2kShpbOoWLK8=;
        b=fiJUXj3GDD4+HE+uOMOxOxvPuQVSxP5zCp177xCYeYxh5xn3NkqrH5/JyUP5/llycN
         evcinG4XXphxzBCnA9pVwwRQ3ZXlSgpEM2VNtnVKhJ9VWehgS1tcUskxNAvpMp4rCanr
         3YlD2pX7iAD9Rez0yvTCbHV1MVWOxgDtA2ZR9okB4m1L92bTh4CuzDKirtGaPcNgKM3d
         A1P89QV5bYKdMcTgAzS0FMDqyDA348wxf3IITc9ykUKkuO+lhe3SApfBdKZUm2+kOLmL
         jQTF42vQA4eLQSRf1h+1rGU82IXt3p8+90o0bY5osTumwVl5X3Ka4V0LiBXAAY7W3lh1
         e63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780160053; x=1780764853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nMfUu3F/UMphksRRuPuoVfLiv5XQGx2kShpbOoWLK8=;
        b=tCedYUfiTSUAzXD7jiw+u5DVFcRR45B7FlrTyXQJjY6cTWmiKgMClZFgPxr4A2v8tY
         Q457d+fh1rSUppUXQRytrdRcG/AgLz0UKh4TmowFLExZuWESgkEanpYOzE0W6L0BxWrm
         ruzFFtk+hBkY3qa6wRUzBn15gVWzH5tzFUcYVIvMxV3EF2Y7yGisPH9nPo+3Edh3G31n
         8RIfydnkURIA8Xc5VtUawGBX2BXJp7rWlfetYwv027RP1/5dmN5FyfW5GfuAPRsWD724
         zumlU9j+GdThDvgWR70enhadT607Wu0N8VpLjx8KP/AqBNnXTPSLCZ8kcAr1Jq4unCs3
         6NzA==
X-Forwarded-Encrypted: i=1; AFNElJ/1SYpxgydFLepIZkdrkQak9ZNBi1iVADjFFILVQqfz+h4WhxXLshvOvPf2uEoDmbx1tQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+AkZYhha+Jfah+XOe5Q8HKAHrRuXMOmXyOY1SmLaq/ydEZnv
	2UPDkzdRNB36KEO5Uu7p4cUmaJjI2VMD+qfQg0RUnNFShPDhaEvlBCzlcqBefU2isocfzIu+ptd
	TxNcCwkZ4Bzmy8S/UM4TRHUeIGQxJe5LhYY44p09HLaBAKeumHC4aWjs05J5lkD3AgAK6zHjqYn
	XUxd7cvAw8RhbKUNQQZtpGNG4Ny9bA
X-Gm-Gg: Acq92OEH99FsFeSyyswFCE6irbI9iPwD+TEDxF2HTHYBKQFif1rifd74PLmAwPhWEv1
	QpJxJBkKBFNfjsH4pEsKyNYNzyT31CO5ltw5oRJFAa8m2poVzsJp9xp5huVKccSrUkzPxZH5wTJ
	52R5E41q2FIuCvhM2bLHZB7TdjL6/3Pqqxk8fepehFwmFpkyWQn+jeolSkCWPC8RZE5bbN9x7mP
	vPS3VJRwnb42qd2U9E3aHK0/fkLvg4QEhJxFjXVGSfCgf3S3uNVlq4gKod5BAgHc6i/HRs0ScBm
	i+QVN3oVtH5Tentqig==
X-Received: by 2002:a5d:6f12:0:b0:45d:41e0:467b with SMTP id ffacd0b85a97d-45ef6ae9644mr8659918f8f.3.1780160053434;
        Sat, 30 May 2026 09:54:13 -0700 (PDT)
X-Received: by 2002:a5d:6f12:0:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45ef6ae9644mr8659897f8f.3.1780160053091; Sat, 30 May 2026
 09:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527120600.20696-1-pbonzini@redhat.com> <20260527120600.20696-4-pbonzini@redhat.com>
 <aheD8XjfMrL9wGFa@google.com> <bfc136b4-106b-41dc-a161-b39ca8d63161@redhat.com>
 <CALMp9eQrvHjO4RtWYdqDtzWiXvBgfZA93FxM9nB3KVF8syeZjg@mail.gmail.com>
In-Reply-To: <CALMp9eQrvHjO4RtWYdqDtzWiXvBgfZA93FxM9nB3KVF8syeZjg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 May 2026 18:54:00 +0200
X-Gm-Features: AVHnY4K_lAgdawYxhFcC3NS9-KmTpADOd2XTRqlVCAIB6SVKqONYwHPLSQnAcF4
Message-ID: <CABgObfZzdDgjmQ_XEeZ2g-8ewqEmsoc2Zqtj7Qbw+2QfRoNxBA@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:33=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
> > First, the PDPTRs are cached processor state but not a field of the
> > VMCB; changing the VMCB should have no effect on them.  For SVM, change=
s
> > to their cache state are purely a result of writes to CR3 or CR4.PAE.
>
> Huh?
>
> The SDM says, "The behavior of PAE mode in a nested-paging guest
> differs slightly from the behavior of (host-only) legacy PAE mode, in
> that the guest=E2=80=99s four PDPEs are not loaded into the processor at =
the
> time CR3 is written. Instead, the PDPEs are accessed on demand as part
> of a table walk. This has the side-effect that illegal bit
> combinations in the PDPEs are not signaled at the time that CR3 is
> written, but instead when the faulty PDPE is accessed as part of a
> table walk.
>
> So, they are only cached as part of a partial walk, just like the
> entries at any other level. And, unlike Intel, changes to the PDPTRs
> in memory *may* be visible in a future page walk without changing CR3.

Yes, this is not in conflict with what I said because I was referring
to invalidation of cached PDPTRs.

On AMD, the PDPTRs are just cached partial walk. How and whether they
are invalidated depends on how KVM's nested vmentry handles the writes
to CR3 or CR4.PAE.  The APM says that, architecturally, writes to the
paging-related control registers do not have to flush the TLB, similar
to Intel with VPID. Hence, in principle, a walk associated to a given
L1 ASID could survive across multiple L2 vmentries.

Instead, on Intel the PDPTR values are not associated to a VPID, they
are just there. Just the fact that you're changing the VMCS has an
effect on PDPTRs because their values now come from the new VMCS.

So while vmx_switch_vmcs() needs to mark the PDPTRs as not dirty/not
available, svm_switch_vmcb() does not have to do it, and it can be
done when setting up the MMU for the new values of the control
registers.

Paolo

