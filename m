Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAF19ABD8
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100794; cv=pass; b=Dw8u48i5QkmN0ws7+jfr943XtFfNozOZ1WRPsarKvlDLCbDeehsf59tcWcw5cvndqBA9WVFldS5Ue/tf+CaelTGZaREBMpBRXU75RkHO64pYC5dgPyUyYlUi23AZDKuHkU5y9qelVdCPXCQUwauKZM0Jpobdrgoigr6W4ZYYcqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100794; c=relaxed/simple;
	bh=MAGGGFIuDnkFh7k9k5P8dIqCTpSBhddTjqyfYaFpsD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euxheIkPVrKOLD23dSAKYPT8h/e6+iUnLqV+k2m2qzOC98mMOITU4ennHTstxWqDPg7U9F7BcnaIPwf4lI854FNuays7zAmRZodByihPfWdurELWHWsbU8TN9HOVwwCclCTUrlrmZcaprQTyPGzHOwk368sMRRjsjkXzsH06rj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmghB0Sv; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmghB0Sv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516d1ddcdf4so201cf.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780100792; cv=none;
        d=google.com; s=arc-20240605;
        b=lv7jQ8wAxNmuehBqs2Z4pzCvEFZuZZRaMW4ktvLHhr5fa5OgzqBMBlZ4b/+3diu7lu
         CEtuY44PFKlCe6yVGg9L9OkJvPpwQWQyx00qwXYeV/RuRWNTPXYsO8qBwCxhXrL+tGXz
         QKE+hSlW5ST3bp4+SaZ8Rz128W8obI57sIBjnzl+hm+GG3idGqMv72/hKhNk0gYKNgjH
         f3Qv0c7evwdRgs88UvyAM7ZuPg2adTH5+J6jiQP2EurXc8bs8N89B9g5VVYCbHlv7290
         TtEYqpkwi9uY270AEOVX+qojnBQ2ndct45lUVrMs6dr8IZADzkGfDJtBKwIs3iRAdl7V
         Vk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ZF8xHASj1ZuudEsWaY+2Cjy6TFnQ4oh0myO74PN9uE=;
        fh=NY4Bg1ZnqEMIwkPqeBmpEN0OQl3JUrfdBFtd749aGe8=;
        b=Q3hQWzoC4k+7aPnNFVuVhpDJmgawi6CikzAg+84VAXRae4k5ZZaVGQwcNOHh29Cleq
         FI/t6I7Sk03ZdIAjc46umceygy8Igvx/hO6P/WLxOUFLcCp4bqWiOLtaQI0MpiaSAUSk
         vooYquWxm3PYDy69Ik4prhkFsvm74EjXN1rS6+uv5gjPQUpTnRCeloQj99WZjIRmALEK
         uPhaQZSKrUvjNpZ8/Cv6fV9S3sMWnQR/P7mhNXsZ3nRH87oMKZWhPWwuZJdPa7B4dvYP
         CLrb60u1TWE120ZcDgYmYF83tZPhozrjH4cGx89CPOFKfIajjScADeMctjYYBwBcepfM
         p7YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100792; x=1780705592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZF8xHASj1ZuudEsWaY+2Cjy6TFnQ4oh0myO74PN9uE=;
        b=TmghB0Sv53zr5bG5SzvyXvb3mlF+j0o8r+jYWL8KHedRkjuHuX+95wUTN1ObrVOEp1
         QyIA0NVAXeM6iMOZiCtzi1h/tUzRVVkq8JjDCu3ZOwBKp0daYl2Usmos+v/flAa/6Gvz
         M7syncY7PRD23Ri5D6dlu5FQ8kWYlaP4fX7zGDepYZCse2LeqDD0NLApBJtjaROkqAgr
         x1W0Htmpzk3MC1ElLN9eoJZBQUPFefpfUgPDala/abX0kEIjDinpiRs8dwZ868jV6hh8
         DQ/nCupeYufYHoCsDVdncvEFuyAn9qA7MTqFJd/j+rduP8qXhQyv5HuY9W9HQ9VWcga+
         28Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100792; x=1780705592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZF8xHASj1ZuudEsWaY+2Cjy6TFnQ4oh0myO74PN9uE=;
        b=qtz8tN0sBMP0wKGdxzwscqZG9TD/xj6lBIugZUYPmhp217lg6B6/kfEh8ifPLcTq1u
         pdIl/6YoD5UQYmEHjoE7Cxm0COyGH/Qy0PDrAIPBW/OtSrC/Nv9OXNLkKXs7gqNJ5ZtJ
         CWvZBymCeFvSd8ouDzHHA2JPojqssYV2bAolpY2ks/5s/7T0p8gOcB0mxbx59UkgCqCY
         n6+cS3zIq3tKUJGUKZsVkztFv2i08nzHSjCjqn05IbwQt2PxphJaUASgiwhoE1oi6P+D
         IOMWCLo3AiztRaeszj+sv7QNhxZh1WzjZyDziQTgt0aP+SygD1CKyn+eczy/qNm7vNzz
         +HQw==
X-Gm-Message-State: AOJu0YyBQuWzacZWhT3NpGD4q3ZBAxuT56HiQh7Kact5tI2GcbNblsqm
	uXC8cxSTWmQA6YRMu9K3i6FOsV97l15AFxfHJzBo2PidLI97K/LfcMa4QXMlAnYqmbZoLpGzlAs
	YzmR8/gPMip28WeicfGkS3+xPqIxybTWq4i740Cs=
X-Gm-Gg: Acq92OF8jHsf3sPd6LC9mrXY9O73T8qNEcyhoH/+vCWOGOmNU8AHramkvh32wL2foPD
	drJtdDCGyKt4xLskWkkLe9xlwaS5KkR/H0mivKs3bLEpYPhovpdWh/XoqkdGrJCKCUx6Qu+MtrX
	AP2NI4XaU/n/l4loHjVjcved0YLrFcrvekBnA42Z0HQnTfPJKQKkwGqltfKANGoaT9XyjMLgmrY
	pkQpl+7s4uknjE5WidDNI+SsPCJLbHVLidm8LLaY3kDmKGzvZDeWAdUb21tWP2a1a84SmaPZDKB
	G6vjMzHiob5swPGp3YeYYaCcFXmyhf7gfFJphpl6MZ9cFGo=
X-Received: by 2002:ac8:59c6:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-5173c76bcb4mr2896901cf.3.1780100791678; Fri, 29 May 2026
 17:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Fri, 29 May 2026 17:26:20 -0700
X-Gm-Features: AVHnY4IduYrmTLIS_wnoG76B5wWc3JkYNclq_cKRmHmkEAEjpdBF08mWNIz96-8
Message-ID: <CAAdrzjuj9deA7VSgHmO51DYKh-iPSx9XqvO9Z21VnyY31fteHw@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] KVM: selftests: Link with VFIO selftests lib
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:22=E2=80=AFPM Josh Hilke <jrhilke@google.com> wro=
te:
> ---
> Changelog
>
> v3 -> v4
> - Add context to short logs specifying if the change relates
>   specifically to the IRQ test (Sean)
> - Format code correctly (Sean)
> - Fix compilation errors for gettid() wrapper (Sean)
> - Add macros for GUEST_RECEIVED_NMI and GUEST_RECEIVED_IRQ (Sean)
> - Split helper functions into separate patches (Sean)

link to v3: https://lore.kernel.org/kvm/20260421231557.1254270-1-jrhilke@go=
ogle.com/
