Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F73D34BD
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028665; cv=pass; b=XfVsDiExQyGz/RnayykNrKKemdvjAht1agwFGzVPlSAJasm8yYzSyrFL+HeLQL/tw715jf+790EnR3IBGu039xwRF8uJJx8vfxTFAqs8dkL1QhvdH5J/jYQlN5//FcTLFx1p/GKwdDTKpMx2y6Kjtn3OZBmeJUF05Koh2vj9R34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028665; c=relaxed/simple;
	bh=4aVwgVCNXTCuRGImU93RODTQQdSZ5JBkI1KVTbDzd2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXGM6rmsPU4b6mEx5soJ8rWRkdKLoc/fDMgKx6NabfbZ6CBmnFeIa8n5wNP3QwhnAcpBe+E7zMSaeZU9A9jJtW4Q3xm/tGGdNY321RfCH0EpgsLIzXSylvqN1Sd3YDGq6714cuEulTFE3K92b9p1ab8/yUa2WbHkxAzCnbJRgug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZHIkbsy; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZHIkbsy"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so14187191fa.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 10:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028663; cv=none;
        d=google.com; s=arc-20240605;
        b=hvIp4h4JtaoYoD9LXyY6Ngf6D7PDcRghuPBaoFEw0VM2Vqq6xfxOJ1UGvdXX2gTn6o
         svLajhjZS+4NcnUEAJ8MUSk31qZty8opa2Er/6y3QOzC0fPvCvYYd9ljxXE3fP0h9XGp
         mj08xO0vrZ8fYFzAgiZUnFGC8a6iKT6PLNSXaZs8jHR1I7uI17DPRIki/x6sbutLH+oR
         p/K331hApSzf9uyln46Uof6gfyOvQHgSe6nwi2rEFgyxxKoWyxxuicJv4rV2LYT++hxZ
         vsX3rc69d0ZfeL8rKC3BNJqYdqA2tImMp+cA2ZmpgbDh8+vN9C0Ocd+1v6XK05ajk2q8
         98Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fEawU7hhiPlaWvDkkT1b3BQA0KPPuetCfnOfC5jcang=;
        fh=9VMFm/nIFBwg7X4v7EjCXzsRqERA0jHgAjhX0DDuzI4=;
        b=aHM9ZzRAgR8COsHaPqlCrFn0tGI4feCGysOu0YtE8T6Xns4fND7LBMjfuz4YzuwBqw
         SyGNeNGkuAbdVI7JUWv/zpVksGeyVIRERIMJMhM7q6YVGcHhsri+MCZL/1tMNYbm69rf
         S8FwjdzOvGPOO82ptWlCGkCdoS0C6HIeVexMZSTPzmCYWEEqCt7ntuRjt00XP3FWMtPX
         D0oWC/cqFzQUA/HnVoozGIMiXfOJwOdWIuJdPvqZOFqvoYf+GMirE3+MIyk4OhLMZ1Xx
         dXDkjR8wkgqzsM/yM2zPnf4dXjb8CzL11EMCkpLinxc1M4geE2PcYJ0fOuP21k0u/L3k
         gQsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774028663; x=1774633463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEawU7hhiPlaWvDkkT1b3BQA0KPPuetCfnOfC5jcang=;
        b=tZHIkbsyOEj4WYk0TRnB+mHDvoul3/eRjgOmSTHOdifeHVM6SLHekc5aX5rzf9NO/j
         p+8wnYZrhChwoOgvOHAl8mgENT0dMNR84bhJnBl+1wkDUPvgIrGkaDqL63IHqKqcveZA
         gW+a4ZKp4A7q7aDmn4kf+wJX3lNpzcX8fxEAe3mcHvb6LzuXbxKWoAix/bgAKapy6AWr
         qnvyiT3zteSu0d94xpGxD4Jcs+n5Eq/CZAlK/n59W292AOAjOxDoaTiocwducWImxaIy
         egr7JBl26UpVpz9oiLYGivf9cC+wXHujDoS/OAPLKmGRrl/tCcdLGhqFlX1oyEP4smz/
         Dq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028663; x=1774633463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fEawU7hhiPlaWvDkkT1b3BQA0KPPuetCfnOfC5jcang=;
        b=N1Hhs4eKReXeS2ZWNX1Ndmac+6anvwsJCUfJeXjqdmQNNWjsEiDrZc7BMRfT+FLAqp
         /7PGJ/Sa2H3ryR0+k2uBF4NHb6JTR49Duzt9YCS7/THI6yXsl42hd6JzOVb+Zx+Flnbl
         YFjC7NUKWtOELdM+M0unIEDmzBJ89bVQ5eTlyxzgn7cX4gb2fpjpmc/OG2d6MMQ6soHx
         a4mPACdb4+ZELvtNTW0WMqty0wKlinHAv/crzMnHW8o5q8vxj+AQeDvrJ+Au2TI2QX82
         og6kf9nANNh5xI5iLjIJ5W52sDvirXkPlxJb3knJecZBCXNk4kPT609SJw+DO29sR3Uh
         7OFw==
X-Forwarded-Encrypted: i=1; AJvYcCV6MJXAftwNz50yZQM9yfXrSNVJBPvO+VYp22BZy3dyQeu6rKuzdw4ydgNrBIU1tlG9Hqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BqbYVOx6cSJSgSpuTHLmPoQA9Y1v/OZkUKsEBHtCwAJhUekU
	9D6pVCTaGlDZU6zC0c8aw4hsS7KhViWcnIiexQDshCwiqNs9+hAPzd5O3RhDV3Z0rYJJt/lqsiR
	Bak2USm6VRzihmCEeCMg97AWFHjkwoiMlTMHUaZc/WB2lbxofSQXKTsMB4mE=
X-Gm-Gg: ATEYQzyspfimIdEu/OU8+OYC7Guy1pHwbh4tTgn8yQ8oWbHVMWrYcLzrNZIXcepPeq7
	2wqKkjUMC0A1Kjg2kzX6tjkE+jPiq4mcJ2yZcw5uBwreLBvc2CiakzLYKKWwrel6LnAwFxp5iaw
	T0ujVttktvz5ZNeAoz8nhXA7qcsLp/YFwKszxJ1h3WReTxf5jGUI2ObTtJR/fg+7Pcv6vxm8pJ8
	5K2nR3KVOj7vkxI1KZsLtO0vU2lmgahV1QZ2o7rNUvAOLdVxGVd4UaquydOIpOAP/5WH+Ys1h0+
	oZ4LDxoO
X-Received: by 2002:a05:6512:239d:b0:5a1:2fa5:b98f with SMTP id
 2adb3069b0e04-5a285b440d2mr1713791e87.26.1774028662081; Fri, 20 Mar 2026
 10:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320040322.487429-1-yi1.lai@intel.com>
In-Reply-To: <20260320040322.487429-1-yi1.lai@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 20 Mar 2026 10:43:54 -0700
X-Gm-Features: AaiRm53F1tOQ6brRQbfGyAbZmEh9eqOkPoonj4Uhxb1nqTWcmiu1s8LPUZQ3KBQ
Message-ID: <CALzav=c5Sgv-x4LoCbJGdwuuQBr_4DQyZV=0vvnzG_16T3HtzA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfio: selftests: Fix MMIO test failures in iommufd
 compat mode
To: Yi Lai <yi1.lai@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Mastro <amastro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:03=E2=80=AFPM Yi Lai <yi1.lai@intel.com> wrote:
>
> This series fixes two issues in the vfio_dma_mapping_mmio_test selftest w=
hen
> running in iommufd compat mode.
>
> The first patch fixes a segmentation fault caused by an uninitialized lis=
t head
> when __iommu_map() fails (as expected for MMIO regions in iommufd).
>
> The second patch fixes a test assertion failure by aligning the check for=
 the
> __iommu_unmap() return value based on the iommufd mode (native vs. compat=
).

Alex Mastro also sent a fix for these issues here:

  https://lore.kernel.org/kvm/20260303-fix-mmio-test-v1-1-78b4a9e46a4e@fb.c=
om/

Can you take a look and see if it looks ok to you? I think I prefer
Alex's fix. We shouldn't even be calling __iommu_unmap() after
__iommu_map() fails.
