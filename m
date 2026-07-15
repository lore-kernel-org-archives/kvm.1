Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBC43A80F
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110530; cv=pass; b=oiX7ZH/QYImvz+hg35pBTLipVG7eIJTgx1KxJIWfq00pkcN7DxX8iOd2KUXKZCWzqkfXGRyWDWUmS2dvi3uwRb9pRGlWZk2axtmXvGZKMMgmfnCd9bEvI7GIFgGJIhWTNjYiV7NEkmxQq6IsZl0odTFdqcuT+T7dDaNqp8lBRJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110530; c=relaxed/simple;
	bh=cQpl7LYp+UTwsZRMmNYXdN0HEXYHQDd3DrjgpzrVU5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFbp9C7nIjU2d66N8/8o6qGUbDp226fP58q1m+RCa7vcGTECZnCoPlVEolXPzHssPYVddNBunT5H9e1d8NrpHTSCAsaTWIso+xv4u8GTFRO9kM4753nIFgv176JfQ1baCKGiVE8e3OVsefcFAPL6ZiFbdsJKkEimx0M2kh7DlBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBK5tH5I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ooE4a9Lq; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBK5tH5I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ooE4a9Lq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv4lRovdcCuM6Tpi+X6YoVUVfiavJYkL9gFkIsPmXb8=;
	b=SBK5tH5I2KnlD5YLMflTmr3GHqHNgLtXj36eEcr8Fv21Aip95fmTTTWNHiHWubPRgER6Wl
	AjjdhUJH8zc2GApfpaepv0x3/+xskQlFrggvj6bHPWh6U3jwc42JjzilQi4CzP6xz8yvLJ
	HWlkcfnPQgcSi3VXr9oQJyqMuA/66qQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-bo5twy8FPJ6ft9hY6_cK2Q-1; Wed, 15 Jul 2026 06:15:26 -0400
X-MC-Unique: bo5twy8FPJ6ft9hY6_cK2Q-1
X-Mimecast-MFC-AGG-ID: bo5twy8FPJ6ft9hY6_cK2Q_1784110525
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472bdd6f529so3251232f8f.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 03:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110525; cv=none;
        d=google.com; s=arc-20260327;
        b=Bv+g28XLaouO8HjXKw4zP5Ze6Z4IQqJQqcVTSzgMsTzse4CsKjabFohidc2QdgeMCy
         /G9PYs5r8t00PM/mHmtMfdz8AhZf47E91iWk+ipzXK2Ax9iXq2UDKHXUij0MXkNnnyy4
         opuyUzGjCCUBMjKHLplSBjXiRCKqgx9lPp85uLT1uKDr4WQdxE9tG58JYcZL+VWNGYrY
         d2V/vzKboIsfln64gXqZKs30jBJjNRWNl6Oall+3nHHmUpa1REjtf+saR0SFuA/fn0qJ
         HJpmSPWBoAXWaeytkSNKJbXYz7qM/om3zqyASu5FzHekiYU0oJ3IDsxk9qGmMGJCDaaU
         cn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wv4lRovdcCuM6Tpi+X6YoVUVfiavJYkL9gFkIsPmXb8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=LeEDSmSd7QjPGzxGjhvAaPntNAY0nYIpzmCb0u6GQnjEJeWMS/b134xFh+C5Rbi7hS
         loVWUXGTVFIKFxDhpky+GJ75iAMfA9RCaC4ei+PfUhO+/FJxt3MQrkxlfTZ5ExAm+yd9
         ym+2FTNMigNXfT5qUrROKEE3VSdVjbyCqwkGGhUKAVOx+RLTbezmc9MmdgOWpDzWY/ps
         H3X5whPUbTJp3GR5bbUVU3yRkMfe4vd8WR6K2gWzjZmu71LDL+7gMLeiWG6XNKf4WwgO
         nvUY4k85I32jv0Sj+XnvnVXyOb1vkiYK59lQTiUKuMqlY8TDnbgpVbaU+pznHZjWCCuf
         nkVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784110525; x=1784715325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wv4lRovdcCuM6Tpi+X6YoVUVfiavJYkL9gFkIsPmXb8=;
        b=ooE4a9LqjOuM6WtV1gNLVILtFYt2Rr/O36wKRAK2cRITbfaMMwMfF+cFFk5KbX7ECc
         T6NIsqYNoYBB36rxAzDd+mGT7pcr1oVaVd3vr6rJwWuqX2HocSYe/lqB1Yzx8yugQv8y
         xKyUgp3eI60zIA+EeYlD5EKWYX+JFzfo49FlwF+IW6ON018QgSxu09q6Qjm4GzxoG+pr
         aAZ1HdN+D7hnki1h3tnBpNwxOfquRIgc7AARyO5/aXy9QewyeILIoMGKbgjV1HAJr++u
         LgpmdPSoWZjsqTaSJoS/MwJZVArlRAIDcOmupEaU0VBYb40DfuPCx2wpLyxF77ecbugK
         X7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110525; x=1784715325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wv4lRovdcCuM6Tpi+X6YoVUVfiavJYkL9gFkIsPmXb8=;
        b=qp3hBU5ZWH4Y0tnDrWNt4XMGT8fJyukR2QqyEtoxbhX4X2adzWmD8pRPJU47qyWva9
         EsDW4B2DQpk3ZsFoNhJfaIAy96JM29xi0jOBn8CcNfdPqn4ZMB09WRMQytzjF0MiZ/As
         ZAn7fCTDU30aseClhZxjFDV5GW3319joPOB9mCsuD29/lY3AuURnwZ8C+VS5eZRlo7sP
         0QMIwK0a/jGJZpgT8Fz1YZAYQfcfqu5KwyLN22eS6yNBVATdayorBPhTueCY1GTWV5fh
         Xj6RcoNoEVG0/V/uENoQD+db/XBxaDA1GojzsCST5My15yKAsdPn/aBnivlVliHpXb50
         YC1w==
X-Gm-Message-State: AOJu0Yz6nRAYsvZCpdThtbaoh4oxkKptzJb9yeFqT/JP2sGrO5LVuQS9
	xcINx/VHniYv6Ut20b8LjqnslWvEAsHtp3MVOeXQvg0hEXlspNU5F9C7/HwRoteKJZNnwkyO/+K
	KvkxD4O2fDiJuedsJ67R5lfx0xziX2g0jFXaGVsVUihUeJHG/YI3mMShFZgnCcYujvyzwthKFmw
	pCwIHgAzECNf5xmKIs8KDOn35zuZva
X-Gm-Gg: AfdE7cnFKpnbrT5IT5tnucb/i3BQA1DGZFk02Les1+JVktIQOk+uEsJYcsY3wqgDfnB
	L4PWIYgzdmmOuqMjgk/CIBWZ8Qd05F5/INjBjO2QoRXN/JS6WNdAp9QFZCujds51SXch8ZgWiPA
	tMtHkgIP6Me/ZRnUcNWG0gXY1GKQCRQdXsQq/Z2u8XY5t9hfyKDV2fwJF/pbFIYDcb/Y8fhNAay
	ffzPc/EMT9HPPSjfPTne1QDn0O4c8RPNzNzEqEMaykgcngdjbIKK6Cb+MIbZPay+ocEXw==
X-Received: by 2002:a05:6000:41fd:b0:46d:9871:1a44 with SMTP id ffacd0b85a97d-47f488b250cmr7413650f8f.32.1784110525369;
        Wed, 15 Jul 2026 03:15:25 -0700 (PDT)
X-Received: by 2002:a05:6000:41fd:b0:46d:9871:1a44 with SMTP id
 ffacd0b85a97d-47f488b250cmr7413619f8f.32.1784110525016; Wed, 15 Jul 2026
 03:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714180302.3105706-1-seanjc@google.com>
In-Reply-To: <20260714180302.3105706-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Jul 2026 12:15:12 +0200
X-Gm-Features: AUfX_mx7XmtLR7fHfiwrO2RgUyVpIFzZ1fuR5buMmku7z4UD4yPutX0ZtSzv0js
Message-ID: <CABgObfZZu_gyZ2XJ7RQfaeRnYhVCevrY5++6VtuzE5un=88Ovg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 7.2-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull x86 fixes for 7.2.  Nothing in here is super urgent, but all =
of
> these are fixes for high-impact bugs (though the ept=3Dn bugs are agruabl=
y not
> impactful in practice).

... but the similar PDPTR issue might be, I'll figure out that one out.

Pulled, thanks.

Paolo

