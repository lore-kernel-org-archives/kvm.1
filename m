Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943390;
	b=LE7yJualT2Rn2CHK3sQUDuV6K+Gkn7ws1pSVMqKw6uLc3PSOCcsAevCInmMA+Hi5atQB
	 kdOkBHIXskHn+lrm8T5wcqBzTbs7BrlqSej4zyy5ZhG/ZhH9JH8dQAdgCWj/X20ZhL1vu
	 4DQjrOlId/pgwE9stDknJkMD/oPabtOa5iy1P05xQei4rFhPEoV+LAQRzQI+GKw5sQnbp
	 jjhx31fO4OCvUgTHBamKuiidfP/SkUogBU2SozFSbfDSuCHYfQnhOo8GdIq7/HbvvLrmY
	 addS9Cww1DR/hco4juQvUxp12l9K17NMvAKTcv933XTWjMnmbfDRbT09FZAGWQSMHcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B2Xl0qwQ+HJfglChvJoCcSDLAUODoscudE1S8AAqSn4=;
	b=0c0GsyjW/fuFKS8VVdLFtzvfgc3c2UjCv0sUNik7UFq0phTN5xpQTkDMY5Xo8cvN1Edc
	 INvE4Mv5F/yTKSvg4RxDl/ojeWnlUA//frEo+GtbZb1lpJfdkiTqYxvGK8zMJ0HoXcnnq
	 fKpkoERD2Pz0QIZVw9qDy2fb7SJMjlHjvOa+k6QavQxu0F1oH/wT3zHbynzu8Wui96ZCC
	 ASLXQpOj/NYFxJegnVpce1ObQdStvDy7z7J0m/oSBH6ZZ+1U8hz3iKVC5PNJa7aDx3RM8
	 oYRlLa6G9T8IjO//TgyPV6L+Mw0WD6CJFaSz0d4ofbB76GR/fepk/CLQXkXylSaSu/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kqvc0MGF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421C606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8421C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kqvc0MGF
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so1051a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793943388; cv=none;
        d=google.com; s=arc-20260327;
        b=RCQtj0Lb4oyOIL500olOR4AXy8TU3Yjnf/6NmxLpZV28x44UQllUG+VWIKZa6JY27C
         WYpwOpKpoiqudqRdr+roJlrgn6MbQQ5gRLSXJt4TjD5E1DrnuUwpa5pnBdT7V/oRfMHh
         HaBlK7aRbwccG4c+YS5ScCj57v1VOWBL81Z8XswUQBl/k27P2188vaDKSNurjEY6j+pO
         UsoNnCIt7mcUtoUa+UVfO13RrRyglsNNw+bkQ6mGzA433LevEBykHGe4s2z2AO6r3+8Z
         aOg1+KpehmsCMQoOjk6GqNxCoBpj17ePBaGOiXbunfMw8qYNe65PvzYStHBriSBhAiFy
         7tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B2Xl0qwQ+HJfglChvJoCcSDLAUODoscudE1S8AAqSn4=;
        fh=4yAfmKyw6A2+ZaMaANdgSxcmWmNrkVEV3eyCnKOqZBs=;
        b=P4bih0+vloHOL3GljRUl8eI7P6/u/nbbPCG4QkVkUfX26rBVyY3s4xQHeS0InGYJ/9
         46HGq1USO4lO6jOIZuYl85Hk6CRIoPbASUAY40ri4+nMZvtOizSWZn9gcU32WlzLBhgl
         sGwC1p/RA0Ouw8608ozoRU26bfnsp7JMwOrlxTCA5yrZXTJE5OgN5N3aYDfzmxFMEgAt
         ya4+doat4QJBIwG+Yx4a10UlVl6BvdEH2HD2Wss/kG19AvaQYi6brW2Alv/e9YeUCOIt
         DfU/j2TTOLavhr5S5lcNxwU5+dyrhegOYwd/dtk/DRudD0TqIQ+G8Ut3MYz7Xq58CB7p
         5ihg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793943388; x=1794548188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2Xl0qwQ+HJfglChvJoCcSDLAUODoscudE1S8AAqSn4=;
        b=kqvc0MGFoFpVAj+E54Nk2wxEX1xKRGFhtJ1kqE+iQUCRYFBJVPbEPQcH5i37IpUoDo
         vvwRCgA5RBv0wj2ya2+54CI3AefoA6N5RDa2AZNfcnmqQ8az51q9O8gaTKERYn/2hqLG
         psPa6nPXukpRZ+1XnHiMy1/sx5BCC9C6zuOH2VLutLh/hChcXyAnfUZoJa/moBp/H35d
         kpQW9srpcGo/qRx+l3+6aLN9FMznGb2xvKDS8jla9OLhGT8L728EY/QRu3dsNXNiWlT+
         R0Zh67aamAJQVXhIIOA8+n/H8TWWbmhNn1y9JuifWBbgEencJM0SUs5wnFbixJ5Gae9W
         WESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793943388; x=1794548188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2Xl0qwQ+HJfglChvJoCcSDLAUODoscudE1S8AAqSn4=;
        b=BbQ+87qETBl5aiRmBSmbbU+BS6+ZmGGPm40Dmh0gauaNIoS+Vins1BJMOa512IE/8S
         /xTnGfd6fb12l38CWpXFOcI8i8Y9UcVlc4FSLX+pvt8PPmksQyPrYUcir/X3OuJsy4p0
         EGZNuLbDtUAjxMBTdF0Sv47O3GJC5CHk+mq3akPCS8WxFKQnHv9HS5WbLRkqKS2rCZfF
         R6qMjR9wQVbXRa7EymH4JDYLXUiOuVrvr5E7xPt++fSmpQA9KzW4JeOtMlTPTrqZtQCB
         /71+0ucxeSbCC3wEH+wA+KNvSXMu4fJCUMiXFTxqYFgrskfSyju692BRWzWGsL0s+aWm
         oLbg==
X-Forwarded-Encrypted: i=1; AKwUvByydoyi95b7Awyyh0eMZyV7PhsfH9woKsJzhG2LQIt9N2cwbQO7lfYy7v24m6V8ydbEtJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wjJVpRxRuimmdftDhL8YS/dngKI2g6GXzlXKx86rDLFpSF6tO
	kFhOvs53g7h0r5PTVo1xMmTE+zjybsXp52DOhpJuH8+P5vR3J50NBDUIrkGdzHtL/UsRsi6Vllq
	tVYcsanbRUv4MrDKWKwg7FbRNCoLDw3BfTOXFi7+p
X-Gm-Gg: AYBFou2yg5wzIZ5TOhE5KRT/vACsmpuaJMnIjWpz5wW2YYVnFSJ3qOVgiB09n/vyIFZ
	jVgzReN9Cda+ouZ4sfdmhqL68kSk06yUC1YYSn7YGYnZw2Ckpp/72RXCT9H0yiTjYQhpm9wyrEg
	3QwK1qvjvOm8yxG9eIOG3ZL9ui9HIBjJ09Zl+ngClhWvxfsnDzfwA03lHFZiBkgEtHHtScsIEON
	sgCacZg0vTweR/UKcEN8xO6zmlvtOdo1AjjFp/TwFsih+M+vlsX68R3rzxpQ08Yt6NYV9zP2L+0
	cyx1PpdOINwnN+4EL5dGzJhNQIBrzWUePpvwagI/yhF/gDWtvfkRGY5tSbpufLak2IhmW/yKaAT
	HrIXEhgHLqicnbXU0SOsh2apzuJNtFKciPeWfEf8fGpolK+PHDx2xQg0meYCHJgdIq6NIxfLfVu
	KYUg3hrrzqPCdCcELg2cuoWS0j
X-Received: by 2002:a05:6402:1009:b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b6e69f57c5mr9919a12.5.1793943387501; Thu, 05 Nov 2026 21:36:27
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-21-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-21-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:36:14 -0800
X-Gm-Features: AclHuK_U_9mpuiaWVuz8w3auJHuo9V9ud-NFm1xYXZaSVUoexqCjtHTFbrrgiRQ
Message-ID: <CALMp9eRT-R18RT2iJLitYNYrqLn=qVFDdt1DYWHQbu20ks2Daw@mail.gmail.com>
Subject: Re: [PATCH v8 20/20] KVM: x86: selftests: Add APX state handling and
 XCR0 sanity checks
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:40=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Now that KVM exposes the APX feature to guests, extend some existing
> selftests to validate XCR0 configuration and state management.
>
> Since APX repurposes the XSAVE area previously used by MPX in the
> non-compacted format, add a check to ensure that MPX state is not set
> when APX is enabled.
>
> Also, load non-init APX state data in the guest so that XSTATE_BV[APX] is
> set, allowing validation of APX state testing.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
>  tools/testing/selftests/kvm/x86/state_test.c  |  3 +++
>  .../selftests/kvm/x86/xcr0_cpuid_test.c       | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing=
/selftests/kvm/x86/state_test.c
> index 4a1056a6cb8d..9727dbb2b981 100644
> --- a/tools/testing/selftests/kvm/x86/state_test.c
> +++ b/tools/testing/selftests/kvm/x86/state_test.c
> @@ -164,6 +164,9 @@ static void __attribute__((__flatten__)) guest_code(v=
oid *arg)
>                         asm volatile ("vmovupd %0, %%zmm16" :: "m" (buffe=
r));
>                 }
>
> +               if (supported_xcr0 & XFEATURE_MASK_APX)
> +                       write_egpr(16, 0xcccccccc);
> +

Nit: to match MPX and PKU below:

        if (this_cpu_has(X86_FEATURE_APX)) {
            GUEST_ASSERT(supported_xcr0 & XFEATURE_MASK_APX);
            write_egpr(16, 0xcccccccc);
        }

[ ... ]

> +#define ASSERT_XFEATURE_CONFLICT(supported_xcr0, xfeatures, conflicts)  =
               \
> +do {                                                                    =
               \
> +       uint64_t __supported =3D (supported_xcr0) & ((xfeatures) | (confl=
icts));          \

Nit: u64

Reviewed-by: Jim Mattson <jmattson@google.com>
