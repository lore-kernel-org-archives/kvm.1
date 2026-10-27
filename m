Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108300;
	b=m6VjWrgI4V91hvVAjTc1ofY1R0MF2y0850PAVpjnkk8HMHXVmpCeBemDx+tPSb+Mu+hh
	 Lg88lYeYWKkPMsyDZyQL9oiuEbAknVRGx2aglecfkuZpvOpbk9sRDkKe6uau4TbJrJohH
	 v6sg8t7pFAAVwQCC61P+3FX45ZmbZsyzMlfvPr3b448Mxy8nhRo5vpaxTSU/aRa6YbZU5
	 h/ENzmTm2O6nt3jj0ak3P6JabYBKufi94vtuFCc89KUyvhDrGVJndmnpW7E3b6GZkR3a3
	 SZR1nW6K7iatfbFGsXmXgtpdJs9I3mTQLjSR4E3v3MRmnzWPoLs8Q8W6ucmHEneGkJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DwMd1KchjZwzPRTvPjggUQTB5i2EuHCeAYUv5XXUio8=;
	b=Qv7pTKDBaebrjQX2g9N8pW7+EE5qwhrRn5gUgyHWMCL8BJheaImyRNqL5oDczWlD44gl
	 KLAUuvyiEU9RnXrI/+tLkH7yRnQvyd2rNDZqZKmaGKiyWV0AU3mSgGhaBG9BULIWWk/vn
	 58N2PhexnBTv377xkwpnBnnM5lb4cJQcB66PiZrqJxf05jeIPM6z+bZlMN/paEC0aIXpJ
	 AImBJ8ZrZffs9WOVf77VP/5V0Q2UYPFeYmXg1sutlZYGsyYRmhdX48CVXkVV/KtgRaCDP
	 RdD7hRZ4rU73nTufq/RDJ3k7VMB+vQj8fVTX2tDsnM3suaoiIE6BQXnHcxu9vOI/JNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C90606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C90606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c411e139259so332894366b.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793108292; x=1793713092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwMd1KchjZwzPRTvPjggUQTB5i2EuHCeAYUv5XXUio8=;
        b=HOzpV+E0YifEMJUFpo0mhCWAcg58n+ExvoMQREREEgzF4MnpcqEWwp8hHHC1tSxLfN
         z3X8Ruqy1Co8/BXgOHUAisorIRYaNYOP0BIFmJ9FkxKXER/FT29XCq/joiXcw1RrrZnD
         WPIfgfExZU1GuArzgbJx1i6zm4Wklz80ifrn5BCu9c0/0BvapHXhOUM6INm7cVcMfxyY
         gGBwyiQLFZBkXK6EM/miMfhP+hz9jUVjz4UUJsk87acHKsWT8HyWojfL3Sd0WEWzl7tG
         hGF/p8MDxJHcPmLDSVizAgqQGx5/u6SHLZ1cR91s832oZbGbyJaZXRE+Ajp9Dtuyv20b
         eIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108292; x=1793713092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwMd1KchjZwzPRTvPjggUQTB5i2EuHCeAYUv5XXUio8=;
        b=ZOUHbTg860tb7gdvxtrYZ7mnLKXyJDNRQu1aGALJV+/FyNre4Ni4lHWmt+f8zecXHN
         6pYoTTvmFaI3tosh37Jm3ilypP0xTHlPJebtK2JF0fSgx+rNdQ1mJa+r5cCphO0REfPA
         QrQBmggTABA14Vhs6tjmC0dYEMKcB4/yUVN8EuTQ6OE4RsYaMIWz/gWA9hGBvG2/zOdO
         zN5jNpElghVSkCVcDaGbfPem54mo1z6VE66aB2sY5K/FpoxlOPYj1oStfiKllW+Tj0O9
         yhwTr60vIosOzZWG8TRYkmyRUWBDqCuo8lewcZBmfZsY08Uji+Ct+ZYd7glHgIrz9xKL
         Db7w==
X-Forwarded-Encrypted: i=1; AKwUvBy1VJjOO6SgpqJv6FMHQAJ1ZAWjKqjGY4P9D2KgBT19VqIEDfObDhEhOOJedsXwb+qfjrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIQQGuoD2DMmDdbSxWkCvop94kbz6O1u4fYDXb3DGr1/85BkjA
	xEyxNh65iqkTDguzAFPM4I93GW2qZPMq4dMpypmQEf3XZxZeeBy0ZsTGCBbebmZWYoA=
X-Gm-Gg: AYBFou15levakUkeUPkder/AZRv+jdtxgatWkbgfrvI11nLFJWllrTOuh1rBnQKyePT
	ZDiHa4Uov42nxR/cYFkGjzVvasPlt/SG6zJQShyjTIRGt2I354ajJ71xJ6MMtTr8x5B5O9g/lDk
	rPqH4pJyAgn+CXbFxr7GYnHnkd3/CObO5HvDE25b7zsunb+NXKZND3UIcMo0R16QkoGa53NU+Xu
	9vJ58epier77bK2yriTb0mU2wzmJEZjuPyps5WehMuXKN4nqALXngu8JJPaaUtr4K4KdUdiI3Vi
	wrBkS4tua5kj0KaPhnogAL0XBNHRJUI0XHGoxYhKYJh4WVu/xBisvOIMVlKUgVugIH9gKGlLjkn
	a77dQ8zASkjnFlz3ZAk4Uq8BIxaa1Jedusxy7uYwODgiC0WW4n3vU2+rWgxg1znLcCfOaLd3o1q
	CoaYMWZbUxtocMBGDIDqp+BcaKpDjLxqo4+SvPi6BgnND1T0h8EXvSifAi8mU4rUuJwVf+s9E7h
	SMuA5uHv66lqZcD3qiKpbVRC9lCYpLGWBnIptuO8obD0aXXdjJWioCDgh1hh5ZtvrdVPKrfWe9c
	MG6xlCRuWppIP9gv9dDt0WkBiDG7eTSjDNFNAg==
X-Received: by 2002:a17:906:c14f:b0:c2e:8eb7:53e8 with SMTP id a640c23a62f3a-c46bde6b23cmr1029897066b.30.1793108292179;
        Tue, 27 Oct 2026 06:38:12 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd524271sm468626366b.35.2026.10.27.06.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:38:11 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:38:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Message-ID: <auCo3jRQ7p6JjIPF@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
 <179302367452.58760.16195458599265885835.b4-review@b4>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179302367452.58760.16195458599265885835.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> [ ... 125 lines skipped ... ]
>> +struct ctlv_priv_container {
>> +	struct ctlv_priv_container *parent;
>> +	struct ctlv_priv_container *child;
>> +	u8 priv[] __aligned(CTLV_PRIV_ALIGN);
>> +};
>
>This scheme with priv is very clever, but..
>
>The usage in the tdx driver ends up having both the 
>ctlv_priv_parent() and ctlv_priv_child() calls, but there isn't any
>type safety and it just seems worse off than using the normal
>container_of approach.
>
>I think it is a nice thing to have for someday if we get to a place
>that needs more than two things, but for attestation subsystem I think
>it would be clearer to have the normal container_of relationship and
>some reliable way to get the 'struct attestation'

Yeah, will do.


>
>At the very least the parent/priv functions should take in the family
>ID they are trying to seek too, for an assertin, and many cases are
>probably better off with just a simple:
>   ctlv_priv_get(ctx, family);
>That is slower but always gives the right thing..
>
>-- 
>Jason
