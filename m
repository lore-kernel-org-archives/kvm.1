Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322D4229A6
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170388; cv=pass; b=d5oPYv4d/Z85gFFnFrBvVxbfF42/Sk249v4W3YAGo3zQlABHeJuMIMzvKj6JI9zG+xhTg+lZKFem5R1YCXPgCp6MVoPd8cLJ18ecqQBwxd0nrp0C36Dra7o09Rvd8anD+/n/v1SwDqFnU1eWEjgsvZ5nRFqOg5AcEfKoJl6vIs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170388; c=relaxed/simple;
	bh=LUBbrdfwesGlRHcWDHljUgGTGcVHOswwt3y/veuVbZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5mVvIb+2cZyuWcNvcgT9vl7TPO7CeIH2LUNJX2KZ+Mwk7qFz7XHNRxwOrCoviPVSEsnyZDdcRdMtLQFZRydD0eb++PRUZIRJlK6H9t6OSf4X3wlXdQEnfxa1pKR/t5QFuDXoFPtlyZWxraX2T//8yPXTjDScYcFyKzVLLfmZ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUEDRP0h; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUEDRP0h"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c10e86e52so440141cf.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785170386; cv=none;
        d=google.com; s=arc-20260327;
        b=sMkIImKM1eJPz3pAI1bhZx3eHSHTbwpd9knMaN78TErvy7e9ANYANpTMP3xcyQFPzG
         fwIowhPmBBplXOWT+7KTv5R8PW2+Vm+VD0QvO8Ep/mE/7kKxaqlk6mtCmBJdhgFrSWa4
         4faHcBiiCKff/W2+jTsEL1CbCtpgeWEA1OUGxQ1u2X9ob2VqSjDBdCa8nlZWZJoCGgum
         4OwildGXRTxi8V34D1EZvuQZokxU5XOsP1xcc9y92FSixKmrHKJG3qhVJIULtxSJ46bc
         aPW/Wx1reyw7Smd/R2hMegN7OoiI4xFQrsK2dsuOyi4wAFxw8rfJmvJoNLAaNFz5SK7e
         ETJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LUBbrdfwesGlRHcWDHljUgGTGcVHOswwt3y/veuVbZY=;
        fh=UTdRaCeCHF85lVtg0idv5u7k6Yl/8TFY8zDFkhkmx0A=;
        b=WP1VxFDQmZKYBLcVL9Ser3NwFh7PdOPNrzrcPS95EmSxVNU0/Xtkk0o/coTjg7bxLb
         GyfM3fiC2lydXMNYRZZpohvCJBmj4Jnucf5o766dRdCmCNIGqjLgkiYbrOqtHLP2+Dj9
         oXn2ZnHOfaCQzxnVorivzhsy53Hw/wfj3e3y3lvKGVItQA4boDjxUCD80DHPqzFqfYJv
         7dZBKs2hMX02cKxjpt4ZhVxm2GRvz9mtyuvEwD+GQho2PvAaubmv6vmiE8wx9C8x7KY0
         7FCrZeH4i1F4iLuyhTzpbPpKR+6Ts5DBJ26m7hJkvyLAXxmBFv4cJJlDF/TfJLOGGJDx
         FEOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785170386; x=1785775186; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUBbrdfwesGlRHcWDHljUgGTGcVHOswwt3y/veuVbZY=;
        b=HUEDRP0hZ5YwemlMEfGl899Q+2JGNOKeNMFBDgy52s4atP2iHTMIM7NvSfAtpAizMw
         FvfXtXNmEbk3oUybOF63TofUHUafrjaoiGnlKNXzJyROepXm41tbWgxZBzqBcgPof1dH
         j02YvofFjiBKOYxuAbX6nBN1k/Gjcx33T7Saz0lBWE3hcfoTHkvaCfComv34LcBGBoaJ
         hZp8lSnSkNB4cOHRYwuEUveBoof2CUUjrAEEkt2xfZ+6p9ech/eFzASW1CLhd3eorReY
         7DJbHG+0DW7IfK6NBdC8mQnbdyXGhcw18iqk73PiyEhnTzFq3eP+12BwGElU72FpYUSO
         LPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170386; x=1785775186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LUBbrdfwesGlRHcWDHljUgGTGcVHOswwt3y/veuVbZY=;
        b=D65O55efb9Vm6Cwv2DTJtRWu4C7KKlc8Ez5kP50Efe/JVx6cAxAe6aRoBme1QIFSag
         wN/bJfC0EXW7GHE/EHU95eqC3WMHbe3U3saB6CVZNMFXv03BSFJ3AggndhdKQ9AHJfH2
         /bktTGbUH64B1dAgB8vLu4ed7qWYy4l2Vex9kugWwCELoCPZlwclyK1lzJmLl1FqVWVh
         +v4jXu8xPiYOQwh6U9nJkDYQh7ItI+QTNmMtXSC9H1Mulegsq+leyEMwVUxrbcbUdPpV
         k9g8qCUJsUA//UHt0EGcaCPo9L8ttrGAZ9AK20bBb8kJzsG9O15vamDl/1XZpjaYN91y
         VVUA==
X-Forwarded-Encrypted: i=1; AHgh+RrOe8Vn5cDBqg1EsZAr98pDPlzwev80cKHxa7k6E1VX0KN2nlncbP7fcfjxK6I37Tx6aLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtG6PEmd6By78x/99CJ+iMUKIAh4Y/5ml88PW1XLazd/QRTP0
	OOtBnYqWkiAm3V/8B3HAZVahFFnt5fSc51j+OrAF7ppbX0eU0M8gRZGRegW1hCNVPB8IOBhGrwD
	A7WPWJLWCr1x/azrs299EdlCgPVOJI4e9STYq+2O3
X-Gm-Gg: AR+sD11yKfN9n/cSgKSnHo/rpVf/Zl6Ff+V4BwIk1QOAeIP40rw01JWEe6P4/iK1Gyu
	U2zzt2LyWgplfa4rixsij4pMII2hUWoqbkAluxnFnTnSRh7b84SI/nCuaIOghHKjjczP4gNncwU
	2zzyuJawj+9yoHXn0weUHTNxH4mxMxMEAYY5UojvFNiW0papQkfB4j81p3O1XWttBZ5TC8doDJ2
	hwKUp8/LZd6TE16Go8iucwdlTYfXJlheLxNs4oa7fDuSFAN75B/qWvuip9nVHh4CwoT3YwJ
X-Received: by 2002:a05:622a:901c:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-529a76e10b3mr34531831cf.11.1785170385186; Mon, 27 Jul 2026
 09:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104819.1296803-1-sascha.bischoff@arm.com>
 <20260724104819.1296803-11-sascha.bischoff@arm.com> <20260724112240.4FD981F000E9@smtp.kernel.org>
In-Reply-To: <20260724112240.4FD981F000E9@smtp.kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 27 Jul 2026 17:39:08 +0100
X-Gm-Features: AUfX_mzw5Yr2AUqO8uAEYXPzPNlrBJYH8jNQa3p7XPPYeAO9kSA3O-KglVf42h8
Message-ID: <CA+EHjTz0byw1LJDnqJGsPgOYz-pwyyY_u5S_44CbKGAfKnQkgQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/48] KVM: arm64: gic-v5: Introduce guest IST alloc
 and management
To: sashiko-reviews@lists.linux.dev
Cc: Sascha Bischoff <Sascha.Bischoff@arm.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jul 2026 at 12:29, <sashiko-bot@kernel.org> wrote:
...
> - [High] Missing `GICV5_VMTEL2E_IST_VALID` bit leaves IST configurations invalid.

Replying to this one because I was reading about this today, and
thought it was tricky. This is a false positive (will teach
Sashiko/review-prompts about the GICv5 once this series goes in).

I do not think this one holds, and I would not apply it.

The IRS writes that bit itself. `vgic_v5_vmte_assign_ist()` populates
the IST section and then issues `SPI_VIST_MAKE_VALID` /
`LPI_VIST_MAKE_VALID`, which is the `IRS_VMAP_VISTR` write, and the
IRS sets the section's valid bit in response to it (from the spec).
Software setting that bit itself in an L2 entry belonging to a valid
VM is UNPREDICTABLE.

KVM makes the VM valid before it ever assigns an IST, in
`vgic_v5_init()`, so it is always on that path. There is a separate
case where software does write the bit, when the L2 entry is populated
before the VM becomes valid, but that is not the sequence here.

Same reasoning applies to the level 1 VM table entry, where the IRS
sets `L1_VMTE.VALID` in response to `IRS_VMAP_L2_VMTR`.

Cheers,
/fuad
