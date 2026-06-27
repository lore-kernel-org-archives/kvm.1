Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57D175A9F
	for <kvm@vger.kernel.org>; Sat, 27 Jun 2026 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591042; cv=none; b=DWFusQPRVm6YOUgzxZIxfaPsKveA/8nVoBnXAKCfl7u0gPz/iyjew9HQ+U01oN2skqc0vY5HRdmLP1yzWuoZFNeKD0KhtxxRVt5tgHRcg9wYgm494Ob0BWAa2aBBxP3Qz52q9BDR6vr/WwnCK1qrWseehk0qLJUWRfkO6hQ2Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591042; c=relaxed/simple;
	bh=0JOeA8LOCbCXrqdw/g6764SNFGLfziVV+Sss4t829Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWpMdQzY75MJZDu9LrqN9j94oxnd1+JZRACQcktrXtLGz2c1G4P5/csR6E8zssZIHsaKljG7lHIgtFScKnDM1Ynojtp0tkcs3Fpj7RtX3Xn74rZ7k8KY5Dggez4k16ea28TGZNvXaTci73ybrj2GVxAwAduYWWh73mdgraqJpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=WruSZorR; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="WruSZorR"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30eac9abd79so314432eec.1
        for <kvm@vger.kernel.org>; Sat, 27 Jun 2026 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782591041; x=1783195841; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JOeA8LOCbCXrqdw/g6764SNFGLfziVV+Sss4t829Yw=;
        b=WruSZorRCo+TpxEcpY6ESDt5vk/c+rODvJX14N2x1Lxeep0RwEHfNGLxbIy3Oo0nLq
         f4MI8U/HqZz/QbPjgjvIORn7Zz2QfH17MxokOcCwyc2L/uIWCxo0QOIXcdOX1oY+Kptd
         HGnIOMIxZUvUojB+d5PKSvHYAqj0my3bZRnZ13pyJeMR36Y6eerADs3htlnlt5SS3X19
         hqYM1mwnnfFGWqWN6K14rZO1jOlSmji3l0c9Ggvj5lku5t8gLIYgPOTOfX8PQIn/+W/N
         FU7hZ+vgBKhjS7xPv3nSA5XfDnRyL4mI+Mo1DSXEbbjIB4YnBCmsIasooiJdHxWvAaza
         sR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782591041; x=1783195841;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JOeA8LOCbCXrqdw/g6764SNFGLfziVV+Sss4t829Yw=;
        b=dXdZQsdVuxmzVX6w7KepYhbVRNOBBgmJxMpBFVErnQr66eEBJ2rPf9YilCVZqjs3Ho
         kRfQbQszRmsGZisox2NS9htvVnp+m7+HzdIAXPhHSnd0cMjyfi/2KDQbXSPKP9SKh2BR
         OV2+AkQwKGIgSnDlhBxUS5KLvv3JFJRFGQX3YnvPA7VPkXk6RK2fV7PKsmOxsY9C9gfm
         +vgcx12+SlB/XeYJAqQusmo/eIfbD6bqqIhfmwbKeLSvDbAkX+3INaNttk2REJGUhdm3
         stp2CqUCLRJlKgQrlsDybU60eWhr7BMQWVaovZ73AmRMhi81HC0/kTjXDvzXgWFX97FB
         xNlw==
X-Gm-Message-State: AOJu0YxKkh7Ho3/SM+Q2yHqXLJFQy8mrsqSp/2bG7e3jHQRX+BI1SkI2
	0QbqHjWSOAHGBtuJH5/haE9b73Kfl/lOQGt8muWY97mQ53g0qL3SYAi8Svf5fXpGiNexD2DR0ML
	Bk+QRrgxgzSs=
X-Gm-Gg: AfdE7cknhYd/Bo/S8FI6FJGBoBsLriw489SlKhcQ1pwS0bbeBe+YezaTsz1+UCAj5px
	u/jR2CLxUxTr4C53r1qvUr2tJocEvWrqvYYHwByE3mgf/dd+JxHUyK/gAMC4JXjqzS32aXRO8F9
	zf4UmoQTjykS/740j09pvE6gBBhGcKQ5AMzc0XD+RpWI3p85PYCCGevHtK42HwU/yMuBJU9M1W8
	6NQKfM3PTXLLscvqBf8fT6D1OmlKuF5E+Bqm7fnMPpkfN5LZWjn3Y9RqWGl4Ow+7Ny7UqMpVUCa
	mHgOQ9WUn2bkIJuWsnWQ8anQRWuWbYUzbq1HbnJS3h+9uz6M7gD4bklWl7cbQHanVP0fEamgi5i
	mISiuWVhGaAuhGd/uGQz5ZKpIyQEPygNy5rpoDquBudLkRo47C+15Eeuo58Fqja4bRogxBKh7bg
	p2jVu1SAcc84tjd1cquLfM0wuZfnUdgHMimpgkLvXTsBPNSAUToNP0gRbKA2CmD32ck5fA5OKGc
	aUKAPBeiMBDpLyvsJY9FS9kxadlj7lV9Du2OYFYn55z2AQ7qzobvSfpDXQTHghZiPGza8F3FRRM
	mXhj11kXCmar5GL677kMuDV+Cg5k
X-Received: by 2002:a05:693c:87dc:20b0:30c:ab97:d7b1 with SMTP id 5a478bee46e88-30cab97dc52mr3266233eec.43.1782591040535;
        Sat, 27 Jun 2026 13:10:40 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2401:4900:93b6:729:c2d:6bcf:85a8:4bd8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c570b7bsm29769744eec.12.2026.06.27.13.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:10:40 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: gmap: protect entire guest top-level table
 when shadowing
Date: Sun, 28 Jun 2026 01:40:35 +0530
Message-ID: <178259103536.76347.6343126655830846709@digiscrypt.com>
In-Reply-To: <69ed9c5d-e57c-4c04-87b6-611f7547e63a@linux.ibm.com>
References: <69ed9c5d-e57c-4c04-87b6-611f7547e63a@linux.ibm.com>
X-CodeOps-Marker: a756be51d6494a6e88d5342c1ea753c9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> there is a patch already in the making for quite some time
> https://lore.kernel.org/kvm/20260623153331.233784-5-imbrenda@linux.ibm.com/

Thanks for the pointer. That first one - Claudio's "Fix code typo in
gmap_protect_asce_top_level()" - is the identical asce.dt -> asce.tl
change and is already in the tree, so my patch is redundant. Please
drop it; I should have checked the list for in-flight work in this area
first.

> This code area is currently under heavy work [...] there is probably
> no point in doing LLM review in this code area at the moment.

Understood, I'll steer clear of it. Sorry for the noise.

Thanks,
Naveed
