Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941133;
	b=DnXIvcKmR3QsQokjUhzg7L8rQoJ1SLUj3dRn1fh6O5WjkfcPcdbaAD+2FTerBMFtVEyj
	 +F5mJiG+IeJLBop7soA5rxq2EgO32/E99RObUbtMpY0BapWEhKS5MgUvhvWGRcsNCEmF/
	 iDY+aGE5WoYu+fxQuU5j5/yTTsZwFiiODeyWcwsrSQHqi/hlGVhYNfc1UVl/kqft4opqt
	 Z9fkTCNjIlQdap9jy1m3O1pO1HxhL320gWDBF4Uyzllr5GV7P4SvTei4ypaCUpw3QPagZ
	 vlguTyKnhw9+cLJGlQ9R7A+1SC0NycQSRyFsmrkqQ7ky+1BW0PGZBJTlqZMliV9p3fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cJh2067GU+PES519DOE2C1kaNn0WjHsWOWwAe5deiLY=;
	b=klO6CsNB4ileu4LtwYCuQWh1nGIJEVBSYTfY7x28owZvsi7GsUBrM6BhIMol+GDgh4Gf
	 /daSYbIkckoq8LRT6qYcy36YttFQWdU4lsWrrjwAG2lJ06oGJX9gbtGqemohFXke/Ghif
	 zcEs5gjiXBpqCv6w+FvnMgcZVmgeFKlqBGWA3ltfhR2TyeQvEOVm98uJN3kubVuVbbnM0
	 cRt/e+5K5zwIDEX0M7kl91YMg1XFYpWJZ2kKgu2iU07KlNwerZcagTNI4GAN2H3+cQ1wB
	 2lkrEl0uqrkfv22mIyxKkKPlLXq+EwEYjrP00P7DNTfVnIU3J4P/5A4afn5AigXJvVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBttXsCO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D2606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 04:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 038D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBttXsCO
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so27381cf.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 20:58:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941132; cv=none;
        d=google.com; s=arc-20260327;
        b=MR40ezph+qTi571ZrvIQ5JwDcl0SbJGK7LSebVefYrse4OgnOMJqOUNlFqGhuNdDna
         icN06UYoioey2SvMAR+km2VAnrZ/H5p1xvi6m1eh/q1mcmbWqjRcorcUA3Ic2Mlk6Cqj
         qBnAvNhZrAXTaTiPaKwuXvoyvIDHgiZ076heQOBSbo0mptSNHfJq12SH4J1CKVxrHgwP
         uEUA5xZvVPEkEARJJPESOMKqyBo0tmwBsZKdhsh4ROVrmCRLWAh//ZMHwRcOhSNC+U3j
         25ABpR2u4mdFhytFDfoBA+iZfQXqg78hU8fNnIbqY3AGiZEEWiLTotrRHsUbxlLpGpN+
         FF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJh2067GU+PES519DOE2C1kaNn0WjHsWOWwAe5deiLY=;
        fh=yYu/GP3v897u3AtDbUOmsX63kXWdwj2YjghMNm+vhuI=;
        b=mEycGVE3yKUSuCyYzJTTFqxFvVXA+d+o/E+m33XInL9Ds20rkvgfR/yCv+SdXrABhE
         t+4YYd+0s4lW+UKv/OrqxejfB2yijFgSdKDkfwlToaMAe6YiTUAMCCAwRE/KpPRBZnQW
         Qe6fSKLviXArCqYHiyyPVqihIbooBWSsDby7gMKl2cAXpTd2bhhlLiIB82o0kIymckzN
         /vEqunkA2qw0dwf5e5aY6/zDXYqplnHm7p1EUADX9wVAy9xww3Gqiy+r50lRRjXxJ4cC
         +I+a39WFXDXxXeSuG/OdvUkJzi1aafEpzUVxMi1x/3SR6RWf7UVrd6Hbw/NO3QEeyCwz
         Nauw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941132; x=1794545932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cJh2067GU+PES519DOE2C1kaNn0WjHsWOWwAe5deiLY=;
        b=MBttXsCOEtxisC2qQlbHUffKKbwhpBKuFaboHf/Wlhd0nGRuqg4cYguFdxXuhnZKYn
         NoPET7brfdLbNXY/pfc2WjzTll8kudUhTV1IKGuK6s6w8JY+1EdOZadVRr7O4k0RBZIE
         HXQFr3SBrfIP6EzdQCDkY1r+BgSm4yPz/HZ1ugoQttP4+cBA3MB2QHbA3sh3KQCmy6hV
         lfTsJBE88M5pDIKj3xRc/TfwfT7tNo7/d0DHo7mMKtGFaPqbb3G5Io179wDbD8G0ft26
         Z4AgFv7wG8ECpFE86ks3CxU1HPBXTfGYaZglwW0X/3XuIMXsU2JmOJCDZEsPntkaqVoZ
         dXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941132; x=1794545932;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJh2067GU+PES519DOE2C1kaNn0WjHsWOWwAe5deiLY=;
        b=YzaG4aBItJP55etalAM89iRxtIzztoJpqjwJgPd59Wg9m9ejIZzy1pzf4KMtIr69xu
         5ltpecopvElf+jwulhGQEb+7ByNB90aI3tlLbjjc+p+NEuiFvDscZoMFlXvIBSSDfOfY
         Aqw59Z1gBuJjA+8cnWofwA5zHoZktf4T2/vZjXVMsuXzVvpIXIq6RMS20k42347t8i1G
         NKsD1lgYz2XLp2NvdYRtZ5E4BT2F+8xmgjD4pMYeOjeCgNGFvysPRKtyIcalQEqhYpWe
         MPly7w8hN+UPr32umEDjnd1yxr/ezcfyqTydHVA0+eESJ/96hZQ3XGQ/IUxDDnGo103P
         seVA==
X-Forwarded-Encrypted: i=1; AKwUvBxk9+jCtEJ7DgEk6BFTC9DLiR6jzswCq9tm5+4wNj8W3lEV34VFbMzVzhFr1FPyGNVifAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zwma+Tzuv00ubZJEbIMEnkeqWn3lFWo7CdBqRKbYEkCpGMwQ2
	KNzZ+sTZokeanmz/DD6j40eQ4Bp5dz+4f2wp4iFyj/nskK55GLXizKyGFebpGesBLk49b5XhrOP
	TAJXnRC4Eelu9z+w7UsmXBXciDtW7/jO/yoj5v86Y
X-Gm-Gg: AYBFou3sfU4b4bUlowen49S6r58O+nmJesmaTNzDPWv1cblzvhCvZxTB75Szpytnk5k
	iDonWb6OErzb5xb2BMeY4E6KMBRvZBPa+e0kF0qLq9B2J7v/RIpyUyN1FWB9NP5FYa8R4YqOSGD
	AmLuxHaKkrUlwD2khTlmatZ+ISb+Yhmufipa/MUwOeKFrhlMEGJarFJ8e/RJSgU5dCP6+tBmHVn
	kWdXKM0jiXEfOArJKj8roVGUmpzt8LnOUsowJ/M+ItamSLGWKQHPkP9CiPbjc8DKw2t2yWx0Ruf
	5h7iXln4heFPC2oQ1shq2gPaPeap0RtuHXRV3z6FGxXXP0qDkzUFheQqZ2BU2lnWLQd56JvesoS
	KNsA2+YApgh5lkK2qJwM7dJbWt9dA6r1n3Ej6xFCb2ZmenT4DdBaGix8Bx705KZrxBiVy4EyG2a
	M4VgnkqyPde6QYSQYFNv8PlbuN
X-Received: by 2002:a05:622a:5446:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-54eb70626camr534391cf.14.1793941131278; Thu, 05 Nov 2026
 20:58:51 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-15-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-15-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 20:58:37 -0800
X-Gm-Features: AclHuK9p3qGntOSkbKq5HU-aqOPybKSHJ98RZnbTvr07pU8gaf6XjJ7z8GWEmgE
Message-ID: <CALMp9eQiZ4A_Dj7K-b-3jK84pDf180t0RrNocJ5UT86xLd7D8w@mail.gmail.com>
Subject: Re: [PATCH v8 14/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:38=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init() as "const u64"
> values so that KVM's initialization code can further manipulate the set
> of supported XCR0/XSS features without ugly #ifdeffery and without
> risking other code treating KVM_SUPPORTED_{XCR0,XSS} as 100%
> authoritative.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/ahmtyMNsj2BCoEEo@google.com
Reviewed-by: Jim Mattson <jmattson@google.com>
