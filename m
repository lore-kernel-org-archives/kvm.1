Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0694D2EFE
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860556; cv=none; b=QB8G0XIvewmyRU0qH063EIKmNa9ShwZvbE00GB5qtZ5JH2qCBiGAYv6rCtuT+Y2+4fEHD3tRoHNAG9LCUVCyiDyxq2Mxgd4mF72ujVk+BhzjuKsf6LjnutHqRse9bkwDwMx0AyOol9b4SHuBzO03Ktf5sS1Ojsg5oI2aG0stwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860556; c=relaxed/simple;
	bh=K1zoawtIHXn0RBbF60I1H1C9ybSRR5Nw0HEbVljdmi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukkCm1L6cXceNF5XUW+KluEXxnI/g2MpcBROTAUdKD6E9Yjyf4TDfuTQE02OHbrLd19uXR/0ymZa0A5k7QZ6smidlTFAxCJyVfCwoUOxNW99eZyHdEPw2NNn31weKY1ltpA1/o0FwcFu9GfkDaDQqCUc3wrnrPKLOnYXHo3pzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1xHDOyW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1xHDOyW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2531f453eeso610995166b.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788860553; x=1789465353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pjj4FGVfbpefB5YMY5bf6wxg1EBuFtqC/RFD5ZXsYfI=;
        b=T1xHDOyWWYuYSUrvscdDqOu4fngP3CziUuehVN2rclbRfCYnTQHLMY9s6g6vI6iSpA
         RzUUXOTvN7NnvBWiNVBufHjoE5hCd56gJ08bLCm9NwmcbstDqS4KePRb7bhwskdnI+sO
         KG3wPsxqtGaJoSwpN1IU5tYdIciwmy58Vx8DJqVh9cF1FfuWSSAxpx33XgKHA2Jok01J
         Eahv/aSoaQjvuWmTzaD6MCnq9+UnAG13WpMqAKLgAkIQYrvxcDrAvVx+BdFXZ4kZdIcw
         7EdkdYywHF8SlyYUoggeD1mTuKXCjvdYw27agBU6jCWrMXlHBg6gcYrKw6nSfKY19W0R
         iODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860553; x=1789465353;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjj4FGVfbpefB5YMY5bf6wxg1EBuFtqC/RFD5ZXsYfI=;
        b=ckJMX50fQIDIclTq8K53+crhhSo9tr6z9fj52Vl5g1XOCld92r39JH6kjVrmm5lKJY
         /kUWC8X7xqpxwgHDMPl5CrFlrhsA1wpQbl6s6Mx6zLk2wu69K7JRtckMClHrNgf+v66j
         OYFvmq9Lj5gWNFB8bQA1s+a6WvbFxWA6D/6aXhvSfgXsp0pRJG2Cqm7AaQ9AKht1mWRm
         OxjSCcHPfJEvSyvqIcH+oZIAFt4YdSuUAhsgEXIlLpfAN1BEvqkc2WzM5zWfcZOE6Rqy
         vKNkOJ6BKOEjwXEle95tw0Eu6b74l+vkGgbYvWpgYwEWDKZzgoNUFbyXaWJ0aH+X9cbH
         n6ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQPNGa5IRudGr9Al/c/awrVOga5MvjTMrbmU387Mz1p0fe+1x+Ag/Dy6RR494OXRjQqtw=@vger.kernel.org
X-Gm-Message-State: AFuF++mDbEdVHvwVssYq+oQ3UBCLUnE2ibEGdaiCZGK6gQHQl2MxujO2
	ogxuEPr/OMEArrnIALFCU7wy1QA2FuJxcRFqvgNEtDVfLLD5ztpiH/Z+
X-Gm-Gg: AYBFou3xCbJ7+PuHsjC9KthipiPbjlndgdFvXuE1FLx8i93MKjtDgKpxzvt+gfjeIvD
	9Ro02GV3MkVoqEjULXG3yQxzpE6x35V/pYiDM6TORgHBlLjlzYOdbaGfaIk/PBhCEp2orzh855d
	scZo2a6tNb8BaXyPHKjgox9NrPQd5TUeUsTRQSZborssSVCSA57l9FfKKMfG8bFDHO/iKGbMlP6
	qCFaa22Zf6D/y+oprX7XgWYcqzGy77aYHTrBjkSsNCPn/hlprpllRZ090vGUd8FGPxcaSSb4rtc
	t/fjtFnfwxao//ntGLMpo+iyNVlglqXNHPhlozqPH7Snre3GnMMlfar175r37vNdZciXkvwUaXZ
	udXSDbuDmXy2q8Fd/3J0Gn1amWx55WZcbrlno/tn2JsvinLpq8wRZuQAZf1piXX7mX5BTPrkhq+
	2X3+3LxWuXeCTCHek1n05m0lPlaiWeF3b9jQG2ADJdfonpMj5NfJ2vl9iaRMo5+g==
X-Received: by 2002:a17:907:c81a:b0:c25:c67d:53cc with SMTP id a640c23a62f3a-c260c8d5829mr1740810066b.8.1788860552436;
        Tue, 08 Sep 2026 02:42:32 -0700 (PDT)
Received: from [10.245.244.96] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5768c2sm574816666b.39.2026.09.08.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:42:31 -0700 (PDT)
Message-ID: <1f1877f904d0521100d2ca656fc9f0542c46a68b.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org, 
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Date: Tue, 08 Sep 2026 12:42:28 +0300
In-Reply-To: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Binbin,

On Thu, 2026-08-27 at 11:18 +0800, Binbin Wu wrote:
>=20
> Specifically, this series builds a KVM-side allowlist of supported TDX
> directly configurable CPUID bits to:
>  - Filter KVM_TDX_CAPABILITIES
>    Replace the hardcoded denylist to only report configurable bits that
>    KVM explicitly supports.
>  - Validate KVM_TDX_INIT_VM
>    Reject any configurable bit that the TDX module allows but KVM does
>    not support, as well as CPUID entries with an unexpected subleaf.

Today's denylist only rejects TSX and WAITPKG. Everything else is allowed.

Obviously, the TDX module allows directly setting virtual CPUID values
only for a subset of CPUID leaves, not all of them. So "everything else"
above is that subset minus TSX and WAITPKG.

My question is: is there a feature in that "everything else" that
causes host state clobbering today?

In other words, does this patch only build the infrastructure for
addressing future clobbering issues, or does it also fix a specific
bug?

Thanks!
