Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FC370D7D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369981; cv=pass; b=lAGZGrCurjyL38Xe/tx/ORzlHwPf29YC10/nTdAguhFqBvWoHEXGSTUy++HeE+SIebBF1u4R8YzPWsmiTaGeeXrtqesvsUv2ohaHT+ZtcG4nlwgwrXjDt9Ph69efqDceXg7gXC7LNIohU20kq9pLLfSZaE0U4USmY28tmPjbxJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369981; c=relaxed/simple;
	bh=HaaqCyZJuHFyqaA3jF9mPx4YKb7kG9SBT0R3VHSi6qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfjgGqPAaH5yXvMzt0asOcJZ9euX2BxlsvGSe0xczLvDybnGtAI/lm+XwibaVSA9JVUjeVR9OMa0JavNJAqffA3Vchy7iIHVyf3pxHZm5y7+sU99R4H/+AnytxkGxuy+xaHdWqv1JOBkcZZCv0dcWAzBWYTEMm0lwB+MxKSHaPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDwXD2iS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2+goXGn; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDwXD2iS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2+goXGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaaqCyZJuHFyqaA3jF9mPx4YKb7kG9SBT0R3VHSi6qg=;
	b=TDwXD2iSShiHC3ZtxujZoy1USTRy3vSpjr+GshFuEL+b0Qc/1msK/a2styumghE+u3Buva
	akCEL+rOmvJW/fv3hNamApmXvdFQHS6p4/KPpOPFawLNI5cLGI8U8kxncb0Q68KXdAjDCd
	qJuCu4PQbpgcodWcD4XwKqcN5Xks88w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Osv15mduMqiN8LrKm8SHUg-1; Tue, 24 Mar 2026 12:32:58 -0400
X-MC-Unique: Osv15mduMqiN8LrKm8SHUg-1
X-Mimecast-MFC-AGG-ID: Osv15mduMqiN8LrKm8SHUg_1774369977
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b40c22eaeso5368119f8f.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 09:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369977; cv=none;
        d=google.com; s=arc-20240605;
        b=DYG282JjQoRc/4fFJspa/J+hYI+uSYZwNyZEK5QtsU88ZKox6TxgCEatjbRUbm/P0Q
         8TK+bZPxCrSD2bnGgAljdZEfZrU7VG8Y1e6JPfzwyh+MXyML7+/dbiuG9udcy4hHGJLg
         vziJDmRn96RYYFPnu+bMXrFz3pK4S3+P/UzAw9tK1JSE+uTsVBU9tdrbD5P4nsbbfgdr
         Qat5WcG61NDkgCxQlbFx7ngGWnbxKYYRSn/M+Uj/CVgF0lNf9mB8srbSrahnTFk6cIr4
         Xle67PIpmaP6Z3ERG5uRFUnUF7lN4meWhUxbDNDcWBg0DS+omBax/pXYiU46J3jBB3n5
         b/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HaaqCyZJuHFyqaA3jF9mPx4YKb7kG9SBT0R3VHSi6qg=;
        fh=6fw3GPun81C7IzVhJWZkIi8w4n3SG3/a7XtGt8Aq8hQ=;
        b=ZJ+YqV7C8dpY/npMvN4UGXIxphx9Ryzm2eQvLjvro8DaJzo+tGz0/3gZt7W9DJlEAy
         BHDo8VxZHME1cOzdKjtzuc7qeWOplXmCQSe5gRTB7fOsTZODeKJe1p/eUhESGd334sNP
         eDDqKltrVdHuBATKcKdHodUyqMWoKFAKP0tRUBgvATxOmEJ7jZhotEXk4RmrhEKO7lCu
         fSy4zKtN6EXGgxCWId3bVUSWiTtJKA6pNGgKyybfuO2JPNzl8M8TiJ1CID2kwYRzZyVS
         d0oUyfOXsWMgTMId9u/iWuAVrj4+m2RUZlaYTW3dsuQZLcb84hW4WoOr43XgJ5fKB+gz
         Gt2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774369977; x=1774974777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaaqCyZJuHFyqaA3jF9mPx4YKb7kG9SBT0R3VHSi6qg=;
        b=Q2+goXGnRaDZut08y3Ec0XZmN4JMNujw4YH3izMj0W5833hqRxwd//WJbGPj9irWPo
         lioCP+ubsTFYnUXoS5LBGHFclR5sl5zJ0L8AO7CtJCibY2+8KBplFMtY/88KrV5bJfPh
         Uglqp3pFB1FXOSNnwWGZaVys9YBAFMs2q4TeeFbKT9LrUSIufRz1DiYrFJqmvS5sa9yG
         /FPH2+OCcOJm83sef7ge0i5ukaLxTUOgWThromL2gN8wrsLIx/htjqBPob6BDmWVtv3i
         5l9sGldS4Ye8cDL4SoYd4VQDHyIvYawuVV0gMj0WbGbvbUAruwHSoPlhMIsxeaQ9KYPp
         5utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369977; x=1774974777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HaaqCyZJuHFyqaA3jF9mPx4YKb7kG9SBT0R3VHSi6qg=;
        b=VXrD2ojXcD0EUFFDCGQrG2eh8oqISnCDTBQ1dJedyyJsMPGVWnjzJyQt+ef2z24xrl
         RiqZAatqLbM207JcKrVAq5qnnimiymnCFMDXmIHcfRgTj9PhZH4RTOVkBLy6lRSsa8Zu
         dNsN1PYPG2x2oQzxqxNzpynZIzEC30B6w8iQcdEhb85Z4JuQQGS0+GjvmZSHB4UvCdJU
         mydT2RUlgu8xQl3mxmhIzMpLp2Ke+MLpPU6qQU6DExR0LueKbR81YGmKPHeMNd13/rg2
         IyzxPsZ4VknEdz6v4CdgQMGcgJQANTSumxO7cZEkiDWwDOSpc+CunKun/uMhuQhqXDM2
         dyzw==
X-Forwarded-Encrypted: i=1; AJvYcCWgK5gfe0S+qdOOa1DSbeY7HxYAoViHma7278xrtHDcFue566EPrB8/+D+Y1wILt1xgSp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjK/ggNh4bWxC08tCo/1/Z9wthKrbXfvGotQunShMDtOlEHGu
	lYmqO3t6597swwnKxe0aEI7+lx45fK8HcTPKGlYHZ0WmRjimJOiSzHN21nwx/VesKaYkOraNri2
	5TAKtcCZTOYVI75Mu+h4J/5xFbWYmUdawrBn1S0vCU/MBpJf1YbdCcV2k5kaVHK242QiKZYWSzM
	xDuK3iD3I9pX5O8gMnK/n/89i9TDv8
X-Gm-Gg: ATEYQzxrny3AXBHpt5+57Ye+3QSXHyyg0cwEjl9PS6CsXc6kGT+kvogvCSSrd3VqnsZ
	W9hBmM2PYajr6RzNglOqQ8DUBXkJGwRO9CUUnlUiQ7WkDDx4SE6nb2gxb5HznEcuTN5ItuifOYb
	V3kBPSardCZ33pys0VbqPHzFj8mQq9cIWcocmFr9bkHHhEdYGzACAMBAB2No36dUwssLovMCvXs
	WVB14Zcshc5KlMTWg6pWbvG9rII8jYwpFCiKjJBBLg7SGYCpHsliw2zAfjE9OO4IWJmsXAxycFa
	qRbT
X-Received: by 2002:a05:6000:2003:b0:439:c040:cc8a with SMTP id ffacd0b85a97d-43b88a0fb2amr191783f8f.32.1774369976871;
        Tue, 24 Mar 2026 09:32:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:439:c040:cc8a with SMTP id
 ffacd0b85a97d-43b88a0fb2amr191746f8f.32.1774369976441; Tue, 24 Mar 2026
 09:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320094151.2541661-1-maz@kernel.org>
In-Reply-To: <20260320094151.2541661-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Mar 2026 17:32:43 +0100
X-Gm-Features: AQROBzBSOb2DrC9P9JRJKnQIuo8-0o7xFzXZcGC7UdoeyqQYcpLh-BRplqsjmsU
Message-ID: <CABgObfb=e4eeD7Dx7o_3rSNvs+dGmoE-n3Zp9N6A_QTzGtjVBg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.0, take #4
To: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <zenghui.yu@linux.dev>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Paolo,
>
> Another week, another set of fixes. This time, another two fixes,
> mostly observable with nested virt. The first one results in a vcpu
> coming out of reset potentially skipping the first instruction at its
> initial PC. The second one is a classic example of pointer arithmetic
> going wrong in our address translation emulation, setting the access
> bit in semi-random places. Both are stable candidates.

Pulled, thanks.

Paolo

