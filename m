Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18093914E1
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552880; cv=pass; b=LZCd2CkHFoK8QVflXM+yP1YCDaiVsDchExzI26P2k1bjuTgo+v40I2qxKrk2QAd25rwGLw/AgsRY7ETmyiidbT5FsnaEF6yK3mlB3iGNuCVaTounOCNd8AgYrA0zJu5mkZUhOY4QIMXiRu4aEzaReqJ2NM1/YbN9LjfaRSJpD+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552880; c=relaxed/simple;
	bh=Si58MwwR0R4nPH3wEqDN3oC8Ft08dj098I58rvvbsZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adv/o+5SRX9xcyydFpzNOWnB5SemblZzJX+PH18PwJUhdjTzxL94A8kiyCAl6s+Btk/VNFuddHquZy5MGOhXC8yD2oox+ehDKavLYV3OQi0adp/+yZmymBuhgR6Csc7nm/Tv3MWUoSk6oWeaGOaMmR0w3GgxnME6I9JuShh5HsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVsBrZ4+; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVsBrZ4+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-846970f0acaso304532b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783552878; cv=none;
        d=google.com; s=arc-20260327;
        b=DKBhDreRRdRhhJ31JxKeZfl+CNa2K3N4wbYJZYpOFW2zRSY+h3CQD+NUeWHwIYUJ/d
         noji/cVzqRxdcSxTNO2zinNlyGY9EYNwaiegb/0mobuae5HwmYN+996gF7jdlaUX5Oa4
         A7DfimlZTj9A3w4dcf1IGIwin44CbHI05JKPZr8zT3PUmLjyCV7AcW+Z6t2aeb78jSTl
         SzEkoo5ZAozOmLKndGjINqEC9iDjmVaISpDavTkftLRkgNXJ598pPN6nsl7a9XvtAuw/
         zb/L/Jlwxnpak1+Q+cNRQMUkMpq7RpXaCzP9a9nZDOy/WfobyAx8CuCsu+EBF+JCemt8
         fAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Si58MwwR0R4nPH3wEqDN3oC8Ft08dj098I58rvvbsZk=;
        fh=5b/dlB+1EWP7Ez6Eb5p8R7Dkr6Y1CCiaCjaNEXbJ5+g=;
        b=dqFYwtB3mYxP3p0I5eP9Gg/O6XonYSISKkpYCWcIXtun5r0um+CznuB7Hq10+rvKct
         dtyPJEyknrbOdhjta3a8Cd3qL8DJaOYKPW760RAPBEuMdVvzDdYHE7AiAYf+Yzs0cpPP
         uuFkoeXB3x9Jea3nrmIJkru2g2DikFxKwh6J5BwMki1Pj4XP/gBWlfDCmW5C8/G9d40k
         c4sFR/nAx6V+yC+3D8cr68DXpTKeg0qkgsavstQZzsJMJly+vgD9gsvAd6KakSWAL6yx
         tmmnVcNWKoylt+yynGX8n+86JISCXg83oeSrmmUsQhoG3Kbj485/g1INb5FuF1KiApEg
         ml8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783552878; x=1784157678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Si58MwwR0R4nPH3wEqDN3oC8Ft08dj098I58rvvbsZk=;
        b=PVsBrZ4+JFgSUFVDXZTfvx5+k91snFFf118B8J8KcRHFYnZ9Q1qXkwL2dcRIyRi5FQ
         J5BFBzBBrHNdP5b81M+Cto4Wizx0ffjYLj7ie2OTjeoEXBlO5Xk9UcBtmOixl9iflEFn
         NrvMiZG95DrkiwXBDiNC/GayJoKQnPQMplMzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552878; x=1784157678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Si58MwwR0R4nPH3wEqDN3oC8Ft08dj098I58rvvbsZk=;
        b=flt6cqSf0wHStoqlciderDXtGctlA+dxGo6FqeKXWmr/c4+xIp6aLhrH6PVMEShIpd
         W3CBHjVfTUiyk/iN9ff74FaWE5YMW79E2bjilHikoGd09AOu6Vpxd7LdDgvQTZNSoRDD
         i4R6zLUt9+oT7RG/pOVvflCdjwUHabXU82ow29Aq/c4MJyKcRPXHdvSS3g1/9iUfJ5X2
         NtTwG88Z+gYTmp0ze0N9M3oze6s6n2WvThbqGVp86g3+VgHnOxqwSwXUfcJoxKepYdlE
         sRrOqLSV3T9HnwSO17drveD+fBCpyQAsLKxlvSiem4GVCH2jzFKUxhlGtcHpeUjGC73Z
         eFuA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr/Gk9Habuw+LDOgnYDg7mleBcCcJHc+qxqFAzZhztMHbFhbpCxgcbOlCq/0DVjzrUt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+oFVfRqjI/u4//kNdDy+IA/hXwAYE1oqnoKTsek2mputPPKi
	HVKtWh86PDeDnEPDJseLP+JAgU2ZE3VV/Ss99JsHMfR1Upq2DjxUUH38/d6IO6o1dKmCMgF5Pyr
	OYd9jIoUOWCoO0O8F8GI2TBfmpZDLqwiT2eHUp5+J
X-Gm-Gg: AfdE7cn3+1EikUAkBA/qm+dAV7wFc3gLGaS8e7tVBNPUPE5Ca2muxxQB6LlXFad2ezv
	61Oxsq+T6r7P4EyQoKLWirVsyT5ppsTytPgHAws4wFOYZ7fKlhPp7sNOXxYGwhZ58B1AgZIu2M2
	J0woEt802woy7rTO8UIbmJbrQi+VRp2pa9iqk//Crgtcita+PNINNxqe36mIUwUbnm9GTe5dxfh
	lJckNqm/5oYBAfNkop+cN8Q0HPKDHCHOgxm3BVVds5qZJgfFMaGFTQM9LBaZ/N9gYci3Csk7tEP
	x10zs097zho2FF3h6fqGe+gVn8xV
X-Received: by 2002:a05:6a00:4c1a:b0:847:82db:9046 with SMTP id
 d2e1a72fcca58-84842f00dbdmr4365684b3a.26.1783552878209; Wed, 08 Jul 2026
 16:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
In-Reply-To: <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
From: Venkatesh Srinivas <venkateshs@chromium.org>
Date: Wed, 8 Jul 2026 16:21:05 -0700
X-Gm-Features: AVVi8CeP1VoVeqewdtp57_vO2BAV6unD_oVl0VPPp1k1i64pkIKTMSgUeWMHSGA
Message-ID: <CAA0tLEpxE-YAigp-j6jC4pyQTv9vOPbs030Fs3kVFkczC9Etkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Jim Mattson <jmattson@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 6:34=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> > I will take another look for the next version and try to handle the
> > remaining pieces properly, while also making sure we don't expose stale
> > or incorrectly synthesized decode-assist state for emulated exits.
>
> Naples erratum 1096 seems to imply that the instruction bytes stored
> in the VMCB are not necessarily the same instruction bytes that were
> fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> emulation, it might be sufficient to read the instruction bytes quite
> late in nested_svm_vmexit(). That would certainly simplify the
> plumbing.

Would not passing through this feature when erratum 1096 is present
simplify this?

-- vs;
