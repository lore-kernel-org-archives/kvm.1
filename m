Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1B2116F4
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620743; cv=pass; b=iZYIdg828XgU1beHIjH8Hxi9WdO590+5DB90eUmoc1u6ZQlNeG7tGwwe+PI1EZ0IPq/39v3lx95syLLZL+1UysHPzoEBmsaeKggr/wZCffMDdOCo2h9xqpirt0vqpwg6XuQpZIx1TNaUfnwsZ2GHYG6GfLMXVzgAWxOR8vvBhhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620743; c=relaxed/simple;
	bh=DOW40O1Ae6RU/l3dq/+pi92OpB+GXMe0mhjoM4pRCi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXG3m0yhYZuQ5EDHJ+st2Vl0tP+/Ig2YDs8k+xXfQkbuxB8GlglFAKgeYqYYTCGwHtbzeJSTo45tFBY9QfDmcGxJDm4y2VR1PZnFNPi0bhap5w34acK+CAxOaS4G7oZ8lcV7HHiSruSbZmBliv7h7NLLMGWuZRSKdP8ci4zR5zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCh7EPZ0; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCh7EPZ0"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649278a69c5so1974091d50.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620741; cv=none;
        d=google.com; s=arc-20240605;
        b=AhOdm0gLA7U51Ki6o414U8JmUeSApJljiXF7rc10EJbTpdQEpHBAuGmFAo2uTLFOLQ
         f3I3n8RAWI4PS/KSv6W6F7neWo1mDwArsctzxPpfF3qO6qtdTwLNwEB/lI+LWqEQxQyH
         9Dv0XxdAoK1VWZR5MQuaFmqMAriQdgl5jE7FDlbnQ6sFi8ntEFh66lNGa8QkUg/s8055
         ZfQlwOecfjAv+NqgCOZLzVnUebyA3uz3AlzMeyIgc+shcH6ecQO2RXzdag8v2bSoMTWB
         NZnIgkcCj8uocui+NYJyoat5c7eJ22Ofzy/sfRIvlEQgmeIkMFg5KQOCvt54qLKjaLkf
         9Q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
        fh=TlHJl1KsbiWxOOnH+LXUiIAZea9CnaU7hjAUTeVLlPY=;
        b=Dz62+GF4I7JRjV6eFijavSLIFx2IP+GPnWjKepMxE898YEA4dmhUq/UUPXz3Rp2z2/
         E68fIF5GvALYwbHI+QBw+km33yUawUjbIYzkvg0GeeoI0GXr6m6AFW1YK+zVyFPLuS/L
         K+ClYzBOkUL1XaQjc2sXdgB1HGiOeCgwFj1C52Uxk9Cg0/472QqB7FbaL3S1fnHpgDYi
         tz/RHgndLGjNmcu0pY/LQvBmeBrpc7AL0lcdyUYo5xqjcIB4U9pRhYXZ7J8utsFMVsGZ
         5iermj8edUKNPDBnfn+Z/Lqksp8JrIlOTQ+tTZuHIRDpx+GfpcHFA31HtrMBGKtA+rFi
         BsyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620741; x=1775225541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
        b=CCh7EPZ05eQUU7P7z5sa0R9XoWoTo8E6esGtOVZlzHTL+982IZRwcaQJRsPtQ0FDEG
         56bWf36Iya8NUFea/wumDIciiiznxtJta4Sf2/SPaT4VumFtzN0/uozfDoyh+Dqktfcg
         221iChmAHNNn1xAygtJXut5SD+KYB+byXJoUXg2qcQUzX9+uDNGrjT7/xpbFFeTIDhC5
         ohspqy0AoJQ9Is6LlLYNZCFUDOBqcqKKOz/jMgdNIkOBAk5k4Udax3UFX2G/FL5NMKgt
         4LCSvIZG5Xy8iGZMdYJi8/vqIPzHM4sG/djYY3iONn23hngyrUNxhxEM0qI+CIsSQtmh
         MXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620741; x=1775225541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
        b=l8H6qDN5WMJpjO4oomRWRU1y/jVUY5TJQCKKCInAv1bswcOQOdh0OtTjEkrsM6FGd4
         dFu/1PSzam46fP2AKf4e5ZmG+9UD2iyEP783hPVrsnjcPwBQbyJkSnK27njxrHMOv3Dk
         QXKbcu9JqPebD/KLKmcQBBPdNjIBsDENZ8vNR87xElJTnIKav6ehbvOlxCgmF43dyBxo
         oNZpsUBVGfMqa67PH3Ae3aE8IUFGYemGhr7pyfbwmgWmVGbyjS5PA9iMVjlkQ5HvgPaa
         n1h/E8jl73gQ+9EMRlSVA6MrrnUusb8YThHv/qHZuKQ951yEwwUcox29a79aN5AgoMU5
         82JA==
X-Forwarded-Encrypted: i=1; AJvYcCVyBNfOdWthGhsICWwAE8aGWWV9Z6vzkFJdinyejIhtzEgBofskQ8/Wad93ArRELZDRfXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N0LHwB471h+TTqBjbTC/alf5HJTHgVoYY4xwEqfhrHFHePSk
	2s60+/BBfUca08XPHWe0iBeAI99UUaeSx7kUcCmsKEE/HtKJygkDxu7NKpfNhoCwXiWDkKyJcTF
	YImM3N5Wxvbl2Vxp20CUMQUFTOIqyxckGBwQ94+VBmw==
X-Gm-Gg: ATEYQzxsKHIvFP4dqe5MRknXwm2DMUeBEWO0FLak58nc0Jt3jqeLq5Tl8NUVSnI8glC
	PwrI+jS5vIAsGD2KZ07/orpWs3dIv+7wwDRCP6/qltoIhA7IlRv24MElR21f/1HPPZar/53aQ0B
	ty1JCejUmYkJBFdw07RghO+/OgpPGMAM248PhZ6tuzjW8hHrWrbcmi0Nh0nEEyfKyguvfa4hgFY
	Q2iTY0SlsnAF25ZmzijrjWZQ/KvddSyus4OSEKn8jdffo3tRMHj+qtY6lL3bNt3U6U/VHXtq8m/
	sV6Ppw3ebxfbzYRAiWVb6DQulb2p1vqe+NkJjYMCWeDK+RSVhYwZHfC9kxmISDx8r/4=
X-Received: by 2002:a53:d005:0:b0:64f:fd17:806d with SMTP id
 956f58d0204a3-64ffd17b4cbmr1492710d50.64.1774620741030; Fri, 27 Mar 2026
 07:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-5-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-5-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:12:09 +0000
X-Gm-Features: AQROBzC0Po7v_TD4hj1ivk19f6IZ_jZkws9bNEFEW5yubspfFBco_Aru46Dv7U4
Message-ID: <CAFEAcA-7mgMk8oqoL2teS8Phd6Eif0d7HX65VAXXCOZTWndO6w@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] io: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison data in HTTP header and it should be a plain
>      ASCII one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
