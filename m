Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE53CB8F5
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847693; cv=pass; b=mauJrvup88keLzbCRHxM7t4ilQNFK4OO+ZS4Ve8lFnTGHXEwpp/kQ3I0r1AZJ36si1ok+OPoj+enr3omgMRT12csgP4hfcHCFwxgX+WzWoQA5vI1eQTIJhjaAlFtrtArOyjbuBiTSVnN3iOcykG1xmfnKk/MR3TBpoYuXGdhvn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847693; c=relaxed/simple;
	bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoQv9KPa6GeyZO2cAOeaO4BRqCby2C9d48nSaGLoa0LQulbaZJQa+BI0nYduyfc+P8KB0C7RTmM49DjbSfbEe8kbVgYZ6xxpjQzIj93/sANqyxLuR7UhB/tHKPmQ2nvcyqN5FdJmjkLU7rXtKO+Vq5lGp2Jx57v4SZthbEXpuZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izQ+ZVmw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfIWq7Xu; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izQ+ZVmw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfIWq7Xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785847690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
	b=izQ+ZVmwE6sqTW+UIBgGxYb6Zz+z5lo79YWfQlkHCRRJeqp2ZuQX5SuXxi8qRb3juzjrh9
	PZ5CmDdd8ExtrD0bRtLIEe9yIYYh5gVX4uvO49NolwZcxeZpLG8/rqMiPJOO3dyONxLsNL
	ILwlyBcHIIvRgDv/xuZZQMqMpGlWdYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-JfWsG19WPmannDJPkviWZA-1; Tue, 04 Aug 2026 08:48:04 -0400
X-MC-Unique: JfWsG19WPmannDJPkviWZA-1
X-Mimecast-MFC-AGG-ID: JfWsG19WPmannDJPkviWZA_1785847683
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f810c8aebso2786511f8f.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 05:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785847683; cv=none;
        d=google.com; s=arc-20260327;
        b=WYMolvDpSOWkUdNhRI1j3aEHTTpJgKxum0hmY4pnIOju983V9NzEfjdNHnrtFon/Va
         Urh1wot/P5wSIfLVYQxw/mjnIsGdklcFpM+PJjvewMb9k7CkNFGwM4nxdHnHCii3JhEm
         4N2a4O6aExsyTFRZ9U1LioW8XBhngs2yfx12WExtjrtHo+nMjKbHFeY+35scwHRAJ8EF
         Sl/amxURPtwGkwnuMg2I4+lMPaL/jQpjPr4iRYtE+AuxXg6ik7kdSznXoNEIbvMWPJ4/
         sQFU8m6ayOWYxXs4efgrlN+3lD4VEnD/Mkzve+cV5njSqfnw2gVAbEoJf5Vj1QVizpzg
         ovGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        fh=YrBxPD4Ny6XOwTG+SsVbsX6rtag391mwr45rmsT0JhE=;
        b=BOx2dc0VFtuHd5Nx1r2WoDz5QvhAEUaWXyUNAcv6XmuHLbKzbPSk8Rd9+khcIra3r/
         tZqS2zqqIZ2Qj0uoBNxk02FElS/CB5KnC8MBxlXd4NfX7u838NFm6l81ICpU0LUeuk4+
         b65rmlQ2W3JQODqU3LSg1TniUVuzBtb5lmueb2aJqBdT7WjYH+RblAuEFCkIaggfnNiX
         zGJcwKDe+powNz2usYXgRDR7GYH84Eo80M1eY5tZ0j3hLv1Ku6lUTIJXW4b5dzbbIDHg
         DVcEO+GIRyckFMEBVBTZzBxHVPOqEC7mTVuOXmKKmMFYSwMSAlaIbUnIDtPR3y6ZGAgC
         Uh6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785847683; x=1786452483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        b=tfIWq7XuVfo3Z+PpXyCPMzqZW52bZxDVQqzC6SvXen6tv2vLpPDs/J1TmU68MCMGUU
         FJZu7QNfqbv2L4TwdIJBpXfLf9tSpfiUNiuZ1pX57NCabFIxlKMW67zKDMBv3yQdMnZq
         46sza90hZuh14teC7t9FuVASWB/V8KnR+slCSPtSxDEXJ4sozgmgAhZ5844OtOJXtiGG
         gKJ3Xu/AWuhpfkNSMMKpr0oKKbgfx0f99xiCEcTVOz3e8CwgeHVguOmNQO9eqqYyBZNV
         eDIGj2imlVOaSpsqJ2Z+DJptaDaor3xIEZZcXAFuHs2KrJRUm7JSDfMV+8oaDlRHlieO
         Qmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847683; x=1786452483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        b=Y9J4luDrQKtgOmHMGpK5NjzomGJs/DCJcIVTAktBrwOSoLpMnWIAgiXERQEL9VfKmV
         lJ0X7AG6JAuG+ZDcYfXzxU3VVQEOSNIfDIv+07uGQRR7Ft7TLxWSBuiG5Zem+BPzCR5B
         6wTRBRHptpWpc8JBWbmMF14a7Mif2NqeUGml9gh9UiWbpr6euJQeOo3h3EC8+0bAikGQ
         HXtsg/SBZD4X9SoqNUQgxJL3SlcvfpZ+dv5TFD8q5113IOamiVvE6Suie0V6FPeew1fH
         awlhpXgCwPFn2PLkQlxxF3ZstgdGzlCPbarCSVfghnQoET71LK4N7opZOV5BSWbCPnCU
         gFvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/QGvFEYDHQ0KaDtzknewF+DPNLwsiS+bI7RkB55ChBlFVphl9DyGmXO2qWC0uz6dDSGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSCbNjqG9wwWyIB42dqiMgduwym2XIeWGHIUOgqg5bXVGPO/K
	9aegU4rtN8DYWbHevLE722+FncgX99mVhsVqBndDuU6KBhqSGalS7WJYENNee17TKeYA8g1hgdT
	b25F5drvy94g2jo6rgCEL41FSvPVZlj3P3OWeC/hKaFH/WHOJ41XZz9xD9sPcI4OBANSHMVnYou
	YtF1YzpFv06r4CkmBPllU2qJk3qrzz
X-Gm-Gg: AR+sD10QAeuYQJo7dbb5EX7ZMsUTomo3bDvBdBtTrHmfYReqfgcldPgobINMsFm7Yx2
	Q7Ndq7vQ3chLAzH7F9974Sk/ERGhTQf+blMoEKI4l/5uvwq/Xj27aor8F0+k8BBddL5jItEsDjZ
	3DeWnjgfhvDDyHSLLfJ5TWhI7K+B+3ZuDnnaIM5vr/PDewvpy74M9vUaD512sydSllzLhcLpp1Q
	veoPinXLzDen/HX8GBpjlGXL6Fmt8L1k5UTWS+ytB+b/M3bRvsgH85iJX0=
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-47fd72ba981mr33399477f8f.8.1785847683348;
        Tue, 04 Aug 2026 05:48:03 -0700 (PDT)
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-47fd72ba981mr33399406f8f.8.1785847682947; Tue, 04 Aug 2026
 05:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-4-pbonzini@redhat.com>
 <20260804122128.838941F000E9@smtp.kernel.org>
In-Reply-To: <20260804122128.838941F000E9@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:47:49 +0200
X-Gm-Features: AUfX_mzc1UECOTjr13bdYLDwoSBcmazBIfNKBtso7fBXqj8NWhSnjvnTNjTJWfA
Message-ID: <CABgObfb9-cEUykbZD5C5LMz8Otk8hJk-OCzgRq=HvU3-s9NSVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:21=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Missing dirty page tracking in vmw_bo_vm_fault() when prefaultin=
g fails, leading to silent data loss.
>
> Pre-existing issues:
> - [High] Inverted error handling logic in ttm_bo_vm_fault_reserved() hide=
s primary fault errors and propagates prefault errors.

Fixing the preexisting bug avoids the other issue - I sent a patch
separately at https://lists.freedesktop.org/archives/dri-devel/2026-August/=
586696.html.

Paolo

