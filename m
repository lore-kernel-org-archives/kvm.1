Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617D3F12E0
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367574; cv=pass; b=IRa56mMHvKy5aGGkvzCcrxTFsXy2Vko55cpmeM8ZUd60r5TViW0d8OGQOggvQFRRhlDyG29nZCtKnvy7tiufCv6mRznGsPjE2KqFS12CQfboOpEXa3xiVUxQM5WDoMqveCA8hU4j4e1eCio+rK4vHYE9iNZjMHeSyCv+Y6zvnMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367574; c=relaxed/simple;
	bh=I/PT7cgF2fSz1wz2yFTWJuVc6/30f7CcO1Dj6lJrglE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p7Zmz4nBHcNlD1hswEL9bzhDhvqJHid78Z3p0kysqmaat+VIT3A6zR5omU8RIzfKrUSDzesE9+9euvYR9SMhl322e7H7CQHSaoW+kLvPgHt9a097aEXQ3RhBV6SjBEV/AVOIkfBHGXjS4CfLcsdz7kBmLZeTc6F8+2daRgExD/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9/BieZq; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9/BieZq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so1645762a12.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785367571; cv=none;
        d=google.com; s=arc-20260327;
        b=opC16hvydnPB9/NtQm+rCcFk9br2M4qBoobNJfOnaohYcCCZVzF8KAhFSIRT8Rhxjl
         YDw7zhSVp2ld8sp3KpIPvgEJVRlVmFx4d+1Iumotm2IK2Mu9gRUfrFvJjh2eQl6aPgzU
         +SGKNKZYeTQEVFE4pDBJGh/s6+NUZEDFCneTtcpy6ouvyE+vmH8csHZfqo7wK7crPEOs
         ScvYA8yysXniL+P+Pgvybre1AqCVs0yaS0okGZjQU3zzS2e2tlWV9ckJhHvuMoYS3QKZ
         GkovunbbRB/w5NLo5hxcMvgo0tI7lu4mF7jGVOGPPGYjOWsXWHtbRqjBNy4ZpnnDambw
         3nDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=9TgX+ohmP77qyi8X+IaMTLUljQHMsrXLdqbLXzrxvXI=;
        fh=IiX07mIZm8Q5pXXrjQ7De1yrYgyygSsoxFLA6inxw14=;
        b=J4QSQEeEh62/0DpRY/vsjjufQhaYYLH2LcNqlHBZfE6WAA2jLM9K4ensShu+x+qI4x
         I2EhaFwcuBTlpcuMF3nSG4je6sK8XQ+Jp+JRXom5ELNPMCaCv/f9JMXK0WuJo/KohNnH
         1WjbK2Hevgs4iF7jIGQl8hnEk+cADcJy7nI/w8rWIZw2eNOqxYsyINfGPSHTFOoR/vVz
         z6i+XHhgAr1AzxC6hlCASJN2F0DXRUZ1TF7RqFEI9xMPqSomkUAImf+Tum2YUSglUxFj
         /6qpM2PxZtcpOBYL5vRl9j+mFr3Qqy/hVk9eafSMHPu57a6RuO7xGkpFS7t6b8yClyGg
         oI4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367571; x=1785972371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TgX+ohmP77qyi8X+IaMTLUljQHMsrXLdqbLXzrxvXI=;
        b=O9/BieZqToaKStJHjDx/OQeWMn5D48X+1tCFiMJT76PBRsb9khsYggVjcJ1dcEtft9
         6XFsIPMKp6nCrk9Afc0nqzx2/RBdHHScts6mFE277aqAwmhIa4uuYshuHwPHhxUJBSTH
         Hjh/RY0KXLa85xcCrhZZGlDsTVCzNDDpfhIce9bNzjdodKWEbzw53jHP7CboegGsMm4A
         NptleAU9VkQMmIoxAPWHQmtczxkmqqXIaX9cXwrDHw1pyVFYqevG31wb4kkVf037G/Lg
         7J0a+wybHUZ8wACp4XwTZsUwMvsbkTqNI0h1dbImx9SI+7J3ErL4+F87bBRP9mFlpkdq
         O8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367571; x=1785972371;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TgX+ohmP77qyi8X+IaMTLUljQHMsrXLdqbLXzrxvXI=;
        b=qoiG8KMqv9CfDX5MAEmVrx/q+SADlazt+3fyf7JfYYBj+alQJFw3yUzyuF+dNQL+8N
         in9FAVUVT/JP/VqiEJvEnbaRORJKs+gi/ocP+v1w1RMxRn+MA/AKeGa4bMnz6NKgRcaL
         drTYu3H3eoJil+d5cR9ShCg76HlLNRl1BlUzYbP8h0fP2D0D7jQJMialQ9de1kzSwI6y
         by8AirOVAMyDCr1f17M6kSooU+uHyXDHT3MA5dxU9ESNm/9RqFfvTWR7wbpHnvBPwcxe
         UoECezxfkMfC5hljf1dqBa5epvsnxYG9LvixVML+RisMP82Ji1FvEH3fUwbAJ2LhHF1/
         jvGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6F2yZx42H0NzxEvUcEXKEhss1Ior8gLn37ubqat5tTQMqqu+r2aSyWQFetXDwDviRMOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTNkpjP7eKVe97zmAYN81Xd6EFPrqS3Y0uDes0+6D3VArPNIL
	OTUtKjuwb1HqpFZJUik5bjFtYyHloOnxRgPyR+a7ULseK9VsG4QD9MUxLVMhRMI2scEA31s6fJV
	0SOAh9gQjQm0UoIC3O5uW4vaXh9j9B9g=
X-Gm-Gg: AR+sD12ktsa94eMEGqjIhP3cDn5FoUuJ+LKdJTvVfEsAQpv1XIiVv1ujqZM8cIEktE9
	0OPyTc5s5i62qtrhl3GLw4vAVzDkEOv6+EGkdyyBEczDeqIBJewsPl8+pyDiZu1OfnUwHvcI0ol
	OZkd4klCoid5JYiYEQmntayJxKFDyKAHN/LzL9By1qAVHHYR2z77ntfrD+YZHf6sIZ00QuBMcR0
	SZLsEq/dtx3wM4v7/VscPE8JT+oYLKpSDb2a1T/3XCsJE0eTy6Pi3IIcLJQ6iPg8jpHVS+5DaBS
	qyIzxy37KX4YOvXwJnOfJJ7GuOjYlOoqObMGqQC2OdLt/fHvRnxN7dHr/SMxZGtcukWbMOb+0Ks
	3Gw==
X-Received: by 2002:a05:6402:2792:b0:69c:769d:6f19 with SMTP id
 4fb4d7f45d1cf-6a07b7fc435mr156832a12.10.1785367571042; Wed, 29 Jul 2026
 16:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Wed, 29 Jul 2026 16:25:59 -0700
X-Gm-Features: AUfX_mwLumpXFwqNyUo2sG79wn2zEhCljcWMZQcou6jl-9qng1COQMQ8ZAqDV-s
Message-ID: <CAKSQd8X56f585VcsoXQbOhMoDfgffwfjXvxSv9Y2sqv6NcJspg@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] KVM: x86: Guard valid XCR0.APX settings
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> In the non-compacted XSAVE format, APX and MPX conflict on the same
> offset. Although MPX is being deprecated in practice, KVM should
> explicitly reject such configurations that set both bits.

The ISA does not preclude an implementation that
supports both MPX and APX simultaneously.

Properly written SW deals with that possibility...  :)

--
C.
