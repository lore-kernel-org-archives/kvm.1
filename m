Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924441;
	b=XgCyNZ8Z+mkWxN32fsxTVgdFkmIE0SmXf/P9hxjfWWZRFCv/ZUMhIWzP0OETPJ4/U//X
	 EJv4S9lvpAazdErmC6n2OSMtlNiLFyyiSUft3nv+0wgPMVbtAVwuSko6vl9SoCnAsym6T
	 5I156OTzcTf5A6/OyXnFdWJmsm9aWXmc5WHU2A7WNvy6mVSatTkuEng5SiKvt94Tuhi6E
	 dwQzzUsVNd/O3xQdqmuCR726QDFVT9c3aUkdMG1NG4jdTUbz7fvxngbBvO0xgME2WVw2p
	 OK2Q3krbf+zgpjmkW8X4IbldDw7X63QmMNY2AWWSs9Gw5mULkbx7hTwgSDVLwnDqnPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2Cmw+hgGrca0cV0vkwktD7z3ZurD9kF18J0raLZDmHI=;
	b=Mdk09315QTGhvkfP5wcUPofKwxFm775drYD6h4BEHN3FlVEQ7ZtqpxLk/80jZGZHyam4
	 9UxN8+RskWUBePoiVW2DNi5dJu0eNEHxk3AUY6CzymCquOoAUbDJPCcvQ16dWC4buXhUi
	 LTBaGHitcS9vnXDQ7kNVdt11lvi6Uf5V5a6wxnWb8HahmijcYOtRlqtBLzgGA6GsQKx4j
	 w+1o/SlO3gv7uiOgoTDF4RitaHe5h7rkJJoqS4ESWk6cVBGW4V1iTD/8owoVNb+hmvZo6
	 a/Xuoaf5K4I7oHgGOmZQZAxknTs2dMTYRnXj1reU1uGcsQcukqLkdJhxSrrnJoy+9eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gZQQ8f3U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A575606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A575606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gZQQ8f3U
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso256a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:20:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924439; cv=none;
        d=google.com; s=arc-20260327;
        b=hlDYCW7BGaLz6ueq/UVCL78ltRdsj7Nos9nWh3szz5GzYoc66ZIiuCaDqUjlwl1F87
         2SOL7iBDObfk6iYYkJues4wGZC6ji7mZqArs4CUxe6anjOazoXmBFA9mUgCcO4Zt9j6j
         G8xE/AD+PERywBOkjRbZUn9Fql4MwEY6UisMXhW1K5XvpyCOqQpCJnMzbOlY4Ns9hyQO
         GXaC+53zdkhfNKaOOUpE+sK6eYl+XE1d1dh6ir0WkgkQnoF5nAUTbKn7S+9s86un/4cY
         KrVkrM0rFjM+4gQrfpbsYWC4qJ39GUU/NG4rLEM7cLqGYpbpvs7d7kBmag6/CBPEsDIj
         TnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Cmw+hgGrca0cV0vkwktD7z3ZurD9kF18J0raLZDmHI=;
        fh=FrDdNEYEBgTfv+kjEPq7ECWtLEgdGnKkbbFphdoM6dI=;
        b=ahviyGWe6bpSwyQT3iPgka0kBG7Q3mr7fQu+fIjL10xNeN3+pU40tAQRSXa1AXuxyG
         dPMYtsflX5IVTO0S2OULfSUg+MSNKKXwzXmAChzsfbeTlmXGrVy53DYeViSGjzpFmKAC
         AM20BJ5ZJRE8ON79f5zj/Mj22i8pQcD1Hnbb/mRz0iWteTuJAGYOodGzyqqNHUtpgtXt
         t/YsCa5OP7q+sOxbcrtchsznzaIJWQSgxRX4G5Xwz+tPqrmlqIS6qITsrL1bsqtOSYfY
         9mi1TVll96O9LS9RFwEv2+Oi+WltzGO1H9xiHNjMZypRSolPaWdMkEU9nbIlmmx1ML8g
         TVdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924439; x=1794529239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Cmw+hgGrca0cV0vkwktD7z3ZurD9kF18J0raLZDmHI=;
        b=gZQQ8f3UoEOTbsqL5u/9Hg9xW/ubMvWv5kzw6sfnOfzxolq+K203h0ZFCiimIt33oN
         lTcIIJuqilnyDXNXzJ/kZPnBhxF/zOAkrgrZKLIsVBsUYJIDrIuysd2iQTpBdbnBdcW/
         hjp7uINzg+yMC6ho/EnYOCIHr9WscR2Ywva7USeb7Mj99B2pmlKuBJV+ycl8QoxOOCo0
         /oN/gNpMwmehGCCVFQk7dXfGWM4GxA62snYs/iQFszKrk66Dqq1fTZaVV+D52nOq83MC
         tjoo3wpP5WW0DW1XUnV3SdJT7kaGjzw4N2x3nFq99YwoaEngxvdzeIRtB0hgUhLgDh6u
         MM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924439; x=1794529239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Cmw+hgGrca0cV0vkwktD7z3ZurD9kF18J0raLZDmHI=;
        b=HruhjN/VVVHChBM4bxnArtx9rRsB232sOsVhmfZwZqOEc39joug4EOTEQQo5KSqw4I
         7iVJidlr20oy9EQce0EsmBpw1G3d1HrXDqiyLDsLLtELMkL06BciOevyXVj8PvVeQKJr
         hGDLf9lCDUgiE6TmwNmTquDh+/FMAjvWQdHvZnZHy92sy5VE+t2G6y6jWMvMMCE7CXck
         +p0VuVO3tYJXpm9aWO2g5dcRBheen05XYYVJDloU9yVsQYwjdlHKwwpPMlq479CgEiHB
         LoIY9q2IaPM6UW6S5DqlDlkCx/VEFEZ4KJ4Ot8BLFEuH7OcZqPk1unkYUAFP5DSb7Wdx
         zaiw==
X-Forwarded-Encrypted: i=1; AKwUvBwpb/Y4PFJN6V+yxRH7O+EbrD9UsH0zPDLJpzUyKq9cJDwQ4FxQH9toUd9wFzVIkeu2n7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yURbptiHzXxL1p/lk/CXmHXKByfO6mvSPJSPt8g+WvYlwB6l9
	IAk4WgKwQaJrum8omXTKlgWecXr8nUfJz1dK286npB1505vdxs/G1Y/OkfrQJME02hy6QcRNZaw
	33BL7sJTI7idr1LlXpCnrfwaj4Jq65p+mbnUs1HHL4pBkyIPLm1vT+bkwXXw=
X-Gm-Gg: AYBFou1HD9KodJg3We8biBlTHmCvkCbrznF0QWYqjRIplazqYRhjDBSW7TMiSRwJDwo
	eje49s31h44zfRmdguy2T3ZjWdXugY0TnbAMuXKfReHjPg0az3BLUP8njXPWey5Qko3cQqav2Z0
	Zan4tViQirHvcgpBCg9/kuVSbGNV04IuE2/qmzWO3wiZ49+ROJcPhWD0PTZu8NCYRscBinodeBI
	p+V/fLzKX+EHw8kqw7/Wb6wwgSEiPv1IjQzV1uam1qr1MxG//T/04IeU6ZIQfxLgMj6IiDGfIIM
	xSmX8g1kv8tW+uMgJb/4leB4pjzQxXUPlBvz0iMlkoIDy8D0J1sRbnqsDdeIJUHxewgOG9G7/8U
	lXt/cMS9ZSEA9TnTx9cgE52ovKKx3JgSdB0RvUmECnBaNVSrhZMxOmnLUcOBXAaNM6QJwhfRE9N
	eOEn6m6gHU70Sz4atT34Eh8Kgm
X-Received: by 2002:aa7:d416:0:b0:6ac:bdfe:116 with SMTP id
 4fb4d7f45d1cf-6b5d53ee497mr21203a12.16.1793924438243; Thu, 05 Nov 2026
 16:20:38 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-7-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-7-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:20:25 -0800
X-Gm-Features: AclHuK945wLS55Bs9k563D284TV68MEFpy9i9Pbs07hOBpNnLv-1kEGKVrDeD28
Message-ID: <CALMp9eSo7amBdqve_wUrE=23MmvoNGnYLbu987vv7DgHm5tpyw@mail.gmail.com>
Subject: Re: [PATCH v8 06/20] KVM: VMX: Remove unused control-register access defines
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:39=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> CONTROL_REG_ACCESS_REG becomes misleading with EGPRs. Rather than leave
> stale, unused definitions behind, remove them all.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
