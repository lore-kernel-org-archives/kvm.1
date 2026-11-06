Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924540;
	b=GfylNRmi/sLEqly2emj/jZT4ZNqUcEILMvZzZROFmQtWQIe8ASYqP+hi1AMCyVKFTli1
	 DsmA3i8HsDaONDe4OlV42aa1kETSEaZ2oslf7JrpDf+/R23irmPy+GKreIgAFpzg52vDf
	 hkNZ6T3H/1/GgEfwuXbojmDTCb8BVzc+nPJgz+dboa6mh4meGwU+wC/BJq5w/Nm7xPrdz
	 0pLnMeYNVyOA28RXV2oh4IyDsOoIEghxgO52kA0HrSCO+zmcvYn5a/rzJFeH63q/s6oBx
	 kPlFMoG47uJNSX3zeM4DURKX/X8EJEIy52CL9WOg6VGVaPB5XuGRCrvB8dX9qJ48GWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JfNHbrnn32jFAe3Oz75ROYK+aCQk7wj/Jc6nPtqsyuM=;
	b=clxIfF8Ckn+htiEV50o7/Yl7g1KpPDvIYHQLEiwr5HYpyUpNFB/A0v2H+5aUbLqL9JbG
	 rQgLwvD0wtxkw/sKWtNfiJSSdGIESdmM8qM4fOBJzJtn4Aj6vW4vQ8yjPbgp+scYf1oje
	 27vY28Bxsx4kxK9UY/I5zETXutsky12qfD9txZ7eZhRR/p7NCwBfLXC5pFqBOOyr8encT
	 oTANAGkhLZTRtaIwxguiuJGc27CTLtB2y1uMU/BTIwj4fLU2h54YqHvgx9qb+uuggR0u7
	 d7tpb00v+HG97q4KHK4tDKEXC6+UxVVF0P6I367H0xucQxgxUXqG6Zsx4pPT1MuA+ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B7ZAEf1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE0606A330
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EE0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B7ZAEf1w
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso203a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:22:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924538; cv=none;
        d=google.com; s=arc-20260327;
        b=P5Zc3jkBSgjYseY3+LVzqw92uD9FIki7eesFafEz2fG/+hnuU3Xs1Hm7cxfAwVqEda
         GjZLSURVYFYGAE7KRh6Qlr6LpQ8uNCu08D/fqZNWL3fvm5+afjQce1AbN6hyrka5u2SR
         YgOidfna5M7l5jTDs6iIHXHF7MumyND0InaNcgR1x0set4OqI1b30R9yX0ss9H05c1ZI
         A7qQoN7UwEk/7TmiP6A696wR2d0sUH2aZ1yalFBTdm3VEUBK+ShvkFmsJpxmo8TKoQLX
         5+lDwcuEdoOZKsH+8HLmqN5IAmMUox4B+wG0pAPFRYHa9RmQDFukC8hQatrJO5OJJxDw
         VbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JfNHbrnn32jFAe3Oz75ROYK+aCQk7wj/Jc6nPtqsyuM=;
        fh=0uxZSRU0B7GJatt4ylGdvIy5t/HZPk4tykCbpfffgIs=;
        b=MZKNTXyXcnJlawfTIamsDZ5PlsQzjqFEt0cNrEfAQWt3Diy3Nx+QW032A6pgSSyrcl
         mUYmv8HJ8BuhPpnY7aVwfkSSxqsmKk2lPu72T56PR4PNUuLG99C+iwkQbmO7Rj5hwD5G
         a4G60TyOacOKIrxqkJs9tLARtCfbGrvGXnlPAFKhWNHIDbKoh+Pjh1P8Avp31kSLRflh
         PEpLmmzgF0u6Z7Zn25fVc3wZi7QqtE+j4j+CgnomNeZ7JeEmmDkHn/WCANSwgzXUpmgi
         FFWZ/7DCKj2IXK8SHBlwvdDbEm01bmpnEd0JFfQmcD2rYc1nZFElFCp0dddRuYHtZrVB
         vNvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924538; x=1794529338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JfNHbrnn32jFAe3Oz75ROYK+aCQk7wj/Jc6nPtqsyuM=;
        b=B7ZAEf1wMN3v+L3N2LfPkVfzzdhAA0lwNtmod1/0GV84MDTB4T9DCNMzsZDZSr4i9l
         /Ks8p3gjfqox+Mfa0L9Zcv+t64JPQ6RVF7UhShUFRe34X/cg6+mpWU4vZER/U05lRCdQ
         WfiHL8ANzx+0/Vk7jFEFg+RaMmzxGTYvMGb45GPoJqbCWfg7CFhGTQ8k84qNG5+2s9A3
         3LvxDHlLw9hMzRYIqm3frUP0Jw6oaASAkHwk1CMz0jpmY65UZQ8KljCQ/oFpMH3J444e
         FrwTtGmVo+K5vsQ7QLJ6hGwSXBjA/55CG29Ea6l9uYX7lGmgLn1JLK6oCON3ZRRxk/Mq
         52Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924538; x=1794529338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfNHbrnn32jFAe3Oz75ROYK+aCQk7wj/Jc6nPtqsyuM=;
        b=YQv7v5fXrsZHRgdQpt/cSuqOAQ6pz5n5yeVNaPj1s89c1tZ7NNUKUyfTTwQFjj0l4u
         EAaVxrLEtLPhmc/wSH0WMlOWNJHwdhKXx382mLx2led1M3JM1vss2iUu/KTBSZs6XYYz
         7BME6yPOINx5VPAsGB3QJm/vl11UEx6a/7nbqIwqKbbbgpwIdX76ym7Bg5UvStOWexaz
         FFSJuJ1h1/fUBQ5zBk+MCYU27nCrTR7B9UrMOoF69NcKsvkonUDc98SIYD73o4l17X9B
         plaY2e5Ezl8ICsIEG8RbmmMZB7ITlXxbR2MEZ/jporOC+f2/GZqB3PqmF4BHXv6yXBdL
         3bXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/rKTRgeauegd+wwXshRA3CkbVjSx8LvqkYsfm+wmDs27H8jsrGZeUL/9C12B03MDsXos=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EzEvxHzI+hDdTMWhKhb7GEAfX83nbzCs8mQp+bO1BFECYXVyp
	kZAVh3D8t7D8T6WgAfg7ws0b/81TJ+WD3UR555d7mHy/ikO+oAxQrPq423P60wXRHPvHqYb9Y5F
	karDyKNzisnht16UZH0GC0qtUm0Z1eEaS539p/ZrZ
X-Gm-Gg: AYBFou3CqWgmexyhu/puOpvRG9JxfuN0ziyoy4mwsb42wxvkUjVO4DUrH1TQJkn5Hvs
	49DOu83KFZ4GnLX2Y9TWUWEHJwacLndNLHj4QqwawUHfvAD+wfL81vZOPqKUUbxYTnRIEZB/9fi
	Nk1X2vEgD461zizFSWk3g01YcmQi8X9Xaff0snqJQZf2vR2JEt9MjsifZKvslXReeINu3kcEk/x
	qkO7NMHtQfelEAKqqq8c7snQve8hgpWpP3uFiaHTbex4T84Wh19ooRvxwGPpqrJG2A4NmTSS80Y
	2cPGEGwjIl/jXAP9eviVbUN1ESw+68EkGpDvfjdf+ryRl4olmb7fzrh1sjfwt+3r6zX9EoyHWO3
	SBdYYziIIuViqSwH/tiFGlFmGwhv11xoSPZNXaWE7f0U6IhB0iOBL7aDR8W9OTHVOL9XNdfi2vZ
	iBZdgwxWRFrN80+JF0FXzWwFNF
X-Received: by 2002:aa7:d390:0:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b5d53a0241mr21825a12.8.1793924537343; Thu, 05 Nov 2026
 16:22:17 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-8-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-8-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:22:05 -0800
X-Gm-Features: AclHuK9pYvtR473jSzvnw10DoDYkrQg9rQfkhGrTphbASWY3EEcXQLh_NL0D90w
Message-ID: <CALMp9eTtNO0vGayWE1tVw2fKZB+oDGJqbQ6VM2OOkkGbnt6waw@mail.gmail.com>
Subject: Re: [PATCH v8 07/20] KVM: VMX: Refactor register index retrieval from
 exit qualification
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:36=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Introduce a helper to extract the register index from the VMX exit
> qualification field.
>
> In addition to the VMX instruction information field, exit qualification
> also encodes a register index. This field will expand into the previously
> reserved bit for extended register IDs. This refactoring will simplify
> the extended register handling without code duplication.
>
> No functional change intended.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
