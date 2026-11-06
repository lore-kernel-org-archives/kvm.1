Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924389;
	b=AgiDtcyMx7WISFMZ35Iu0zQnguH6RhLQv0RX3CdM5FWFY0NURbLq9yRJa6SFiRK9XwBC
	 8mr/V2R7DmTNDDREcH0HTYpbIgalb9d0ma4iZ7vXvccZ/sbQkAqFf4C/2rWr7BlQZ+Fzo
	 JjX7sLJ0EOr5acfMs/FF8qEsFcajOYy0k6kEepp4uDgyyDqGKPaWSfv8JsuhZWgoeezZS
	 S0m1tZX6pZCX8tfgjH65ytzotEhVVvd/vDNZNZjjNI3h7pUsgDAxDmGEbyyAJzPzJd0y+
	 WgKyPNMDSiqqEFdcvucp2Dl8r1jeqd6eUULRikjCoUA+zCx3rO+ZUsdnmrVx8/Ag4FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hoJUQ8GjqLVbnxmC3dWK5K1hjFBXYini5ZOHDxXk4FA=;
	b=mKSVT5TyNYtv2QsM6OkokqWDNxkIWshWh8yFrQe7NuIp1j4Kg5Lyr+W3W5kNpEa/OCli
	 4wBx6lnvQTOnFVzhhd1AEqhrp15VSFac7F0bqgMkLchpK2DpWTM/ZqNiGfxYEdc+Md0RB
	 LqG7hKufNzF38PnKrBvJn+RworquwR8LsIkr2agZ1rSEwwKD7R3pV5xoQIxaX7mcQgErI
	 cAbZbD5Gq4AkSc5+pxR8H4l9XuyEySmWMF5JioGxibnYPPWU09qRzaXCTagbYJJ4FS1iE
	 UzcTolYBzzTv67++Hu6foiKU4+Q6ao2dlAQlmzm65d9i8frGpTsAGBJmcmWbNAnNbSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fvf7lQbN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A9606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fvf7lQbN
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so151a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924387; cv=none;
        d=google.com; s=arc-20260327;
        b=WzbglcZ36HRlIsYzbryMAk3o22yekYXhnHrWHVtNaBzFBFU7sTwa0W3geERYdI2ZmO
         ESd576al4qeK7ncJGKIXs+Siuq9HqGeh0oW87xRV0w1wfnhoHKeBeANl8AHtrhHod5SQ
         nW/cJ2mh3uTBuqPbH4tLT4wvxYAWfblAK78e8GmpRLmFFPCTJHZBYWp3eAfakOG0dPWt
         TZEceaCsnKaMKdNrMo1qQNi6gRzCIkvzy8hk8Phr79IkqWgwQULldpZwm8UE+mbCCKzb
         fKf/yMVknIh0J2hNn9NRjsEYP9sPRorzNvikNi/n2TjgrgzoSXcH/nKP0WUHvy4lR2ka
         5ayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoJUQ8GjqLVbnxmC3dWK5K1hjFBXYini5ZOHDxXk4FA=;
        fh=6HubcCyHvdU3fitTJ3y4Slyz+DrLSIpRutUg70dEE7M=;
        b=IUWBTlR2srvJjV4BNGKTvzeW3EszlLG/H+B4tA5iYxFuyTsjN00s6jAEOZh9FRAGt1
         +nXT3an/Sy8tSQ+AYLE2Q3aV+3t3F9HcasCi58DRYhuDLM4QUhbwGPqcJBM5E5cSTWcB
         vP8jTxhPAr9nW9aunZsxNnena8RHNdmvDe2j3ApBpoAwwTeKKg0/ePnAey0NkQ6PGw/B
         U5o75CXoAHZ+NI9YgFAUqrdzclmdH1gEQKjw4yJc1S+jRHw/i1lVt8lg/JmOjZIRSupX
         iC/b3weUVpb6r0hGh1CwtZT0fv8Fd0w8yJTNOnhRb31I/snTCsEQopu7luXpkCLcNYZd
         X+mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924387; x=1794529187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoJUQ8GjqLVbnxmC3dWK5K1hjFBXYini5ZOHDxXk4FA=;
        b=fvf7lQbNGae5TuiF5ApfciBrEay/Zui4CmeuAAApvDRICkwr5uhcpSu4TWHMqb5hkl
         BxZ5121RpoHWTNuY71Fxtm9k8ab/PtbOzlt5i0cLSwFijHWCRIk9m1S11V1I0yDpEBIr
         VbTGjoWPRqXcoWZ84Xy3pyn8SQAHDNdrajAw2ehErCV05uuLmxD7LmLxrZ8PlvFQSNPn
         SOUDEYNxDwlQgYIBjRXbWmVSwHyFvbOysnuwKYA+0Qb0Y91qqhdAEwxmVkHNSlF1v8qe
         znPNKdwagMIbn1gZLAsnL36FLDd6LOlRRv0bjYbjWnDcy3CAAeYGiZFWkmu6L8cXSlKx
         S9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924387; x=1794529187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoJUQ8GjqLVbnxmC3dWK5K1hjFBXYini5ZOHDxXk4FA=;
        b=K+ElJ81yBwR46/nnQG+dJP8wDLrrqqh55AFC1cQlWaZ0k3Jf9GiX5UeS6cHdXgnyNL
         2XFXRJHCyXCUFYTmhMj2WzUJSRzCj+Gt+QUI42AIikUZOyNBIlenYAMjdXyiRxZ6b22u
         ZlK2f5omRnMnTeEJzR4vYtbLFMDCdA8nrKTWXC4xiAEHN2TFJc9VBLFeRpvRiHP9qnbh
         zXQMhSvu8lCRriAh69Q4DAU1nkieB7pSYxwHKOJbUCC8NRo77AsLRyot78JNtS/Q4+fz
         w4ZtrJ65gS/5i8EML3clEn3LCO7ZI3wyjwjD0Yj0mYI44/peUAd/vF/vJHMbHd5fvnLs
         oTNQ==
X-Forwarded-Encrypted: i=1; AKwUvBytFQLOYaUVJOB+5+BdxIqPqW3rszZluYuccLynZJar9iTyqWRZN0ckZ7Z9/gQWis//pg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jd3ibLw4vpYUikauBC1dVtUQlZeXI0/8u41bWk7zNXH/w5dzH
	SDhpAzgD5F4NYkOdcdYkYCqzQMU0zJhr/EOTvHCdcuKFslp54Q9wLjw5A1qLW4DpkJ1pHuOCdYw
	0vGWbuLjZ3SwWmWhRfoM3XlrjNt36F27UsK2I2Cx4
X-Gm-Gg: AYBFou2P7SR2MonK2qP1dyHkUfngz3mTcGN4YB3w/7joGAE486cCcgeKViCBCy88Wok
	xonDm17nmfbNHAD5OmWO+iBvYj1kfzvRGTKCNHtYHHHflgb1wCbshfZrbJFgXmdKqSDM6BWd8Vv
	JYazO2+2oqUngihJFe8R8Wu19lAyVs3A2xaWbekmaEMTYLBiuwBXTA9rbpEZeEWL4YILJoWT12v
	57mkfpXnqyE3vYzl0rwRWAwheSScW2HlcnCTPjRimdAaHKrBiaUnF1bQMP0967fOMbq/molhrfn
	vGex/+zOURCAa39zt25BRRufHqK3CIup0wONRzB7+XC+r+CRp19F937cKXyvDZkyXzVkXM8pk3v
	uIM6YCnxTGAWVnAnHnzXIGXHe0kdq2CD/5dsEAeWF/K4SoeURS/3buCOCC/AcPZQ5kw+93Jtrs7
	mkt6PmlFAh+dmTqNtBzYEM8K9K
X-Received: by 2002:aa7:d29a:0:b0:6b3:b648:314d with SMTP id
 4fb4d7f45d1cf-6b597a39693mr35639a12.6.1793924386913; Thu, 05 Nov 2026
 16:19:46 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-6-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-6-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:19:19 -0800
X-Gm-Features: AclHuK_-B7OPovU5fqCuQASHd-0_rKGNFA7sFqiBsSRfFtZx4xW3q4qeIS-CpIE
Message-ID: <CALMp9eSKm042gwYLCT1yxNPViMZcff2c=qR_wc5WKpAYKSpfHg@mail.gmail.com>
Subject: Re: [PATCH v8 05/20] KVM: VMX: Refactor instruction information decoding
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:44=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> KVM currently decodes the VMX instruction information field using a mix
> of open-coded bit manipulations and ad hoc helpers. Convert all decoding
> to use helpers to centralize the decoding logic for the transition to a
> wider instruction information.
>
> No functional change intended.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
