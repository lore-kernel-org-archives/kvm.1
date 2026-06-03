Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439313D34B2
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473499; cv=none; b=WAWSuIt2mjQiQQWGfkLxbhUO1BN3sDIOKYKUzAhNPzF1zNgHAovkX1bgrkt4trGs49DetTHPNju6MNlJoatW0jiSr5kwkyKtOOg1rw2SGT3pyDRSp9efnVsgnBsaCsnXuRGaur9cyX9eUKb3DiKkQ+jurUUaL94xpW0k6UhlTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473499; c=relaxed/simple;
	bh=GenkSbAAZbmgIYjnjatLIXyTvbIP6W+4AfKps7Ntb/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C83yB+cwaqxbtXsRHfj9LA7TQl1AakJpwse+iSm02B+d6rfdZXvrZs8lgogYPEML/N12DfckxVDuPLHzclqeI8PUfCaVcfxzECznHua8jMoaYMmCs4q7qpsCesBd0egatIfQWvtQXlSdCHIltbXLfQdL6Zg3NKVlifBBkFFXQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zpr434TL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1yo8k9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpr434TL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1yo8k9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780473497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbIaiV+usjyONBGbrHjC3CjCtYSdkcWUYeQVUIDYeQY=;
	b=Zpr434TLrAsxrDrSBvc9TM0F4KkgRZ3dwFlGgPZE/Zs1pF87GhY6WoQnsHudu20bJ7uVii
	Vi9YeK/ioYKdSJVj3qfXaS6kbUqHCwGftuhXfOm+lDCxwlSx9p0XW/fucpXM02ws0Pi+z2
	olbFkWur1MClsOrLa2mma8JX4X55GKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-sRQD1uWlOUGbejYN7mHNzA-1; Wed, 03 Jun 2026 03:58:15 -0400
X-MC-Unique: sRQD1uWlOUGbejYN7mHNzA-1
X-Mimecast-MFC-AGG-ID: sRQD1uWlOUGbejYN7mHNzA_1780473494
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b61243easo5244485e9.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780473494; x=1781078294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qbIaiV+usjyONBGbrHjC3CjCtYSdkcWUYeQVUIDYeQY=;
        b=R1yo8k9whROIrF74QY8b+SLYIECkDFb06QCwxh73vottvBAnNMT0/uJuNI1JnMlj1r
         trvkI1dAkxsodG1PtMZIpX9LEhDwL9koTBBlhvDFFgPjOj8xy+ECBocA07hSmQuLEXV0
         Y33zWYE0MbJ1vJZj1nGLYRsUOKgXPUOGsbvGXiEYTKQ1yxZv4wTrtjDwF+hp0P8vfKcp
         HkuAuO2w2WbtiG7S/vUWXsh0qUh26X1soA0ZSFP/ZJrnRo8PPI1/cVdVkboJS/fPqa22
         WhAvi4gCinb9XrVCHX9pGaipzzF2UaCQa064B4gPMuwNtBkoV1+ZyNipMG9DoUZY4u2f
         lLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473494; x=1781078294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbIaiV+usjyONBGbrHjC3CjCtYSdkcWUYeQVUIDYeQY=;
        b=mqYMoKFgDFm1OCD9y6XuEGksKnXG1te4ZF+sKXg7zwwKA/nL2IG6sfe9NMTWWq3GGP
         oJptFLXuG6qE8g6ZCYGxUf3LNn0RZdDifOmUxEFh/53axdly3na0RfgEd4oqV3OTkuXN
         BlENikOILSEDmJhXJVLKq6VWf7q2KTbfgwQuWLPByYrAJwxjCJVqCqTsAC53i0NK5nr/
         XoetWksUsFwQlq3E1e0y/7H42MhHIyv18uuPJO0Qo/9/pxHvUfufkfnTpaaJhUByEITU
         GHBLAWyHc6wO3kFWJgTDPpFcr/HTRK1w3M6C55H0cQ0e+uakuFvl/dH8/z/ZBCA4S9Uk
         6c7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/PqQ4LvcK0Hy22QkqmyqB7pY2jngnxmDYaPzmPhCxljtkksIZEbnuO87h/n+D/tPi9X8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNN1ZXBcMfGaPGFEaMmWMj6vcCdiRCvXsixQh+PqywSUgAWRP
	kWpNUbDLt/fLs04XDUmMW34grU18UqOe4T02KbaY4TGlHonRDpd3dogTjsVOxA52qUgpbgOwFjR
	hI2bNrL5Siwh3Xw/qtLkshalQfXKIkJiYq6phdbz/W6uK6J9ZDiDL27d/GzqYKA==
X-Gm-Gg: Acq92OGopNDEQaMXn6g4EqaJq9vXipKiWvSu2+uGCCF4z6TvCG8LH0DQsc5jo32vAoq
	6aPSSiN1UuafCwfsJLxKSgfap5bJKGYq4c5AmJM3Nf/b2ZGk3tEtAsE/jceVkwv0VQv1sgEGyx+
	Dgf1vumDCKnL5fRB9TobX/FTqog/9mB61F+6lL1a1ueGEeJ3mzHlisJLsryxAfeIbGg0NdprZli
	TUuVjoGQjZ2hHu5h32y7HL5hR0Z+kFB8fcwHw+82K3yvF0eizmD3dpUgAs3XgBS04wgzf/WZvYa
	YqVMvB9XIoJD/qrUwSjmFsUFg1v0WbU5AB4yZTWil9C2RbNIhkz9RmYCuAGRamFncPzYmNPa7cj
	5C8412VnDVChDSWrHYXRL0KFhez2B2nqDGYqT92Mi5JvFaa2UlYG8mOffk3O4JBcqtMl1nQ==
X-Received: by 2002:a05:600c:4e92:b0:490:59cc:998e with SMTP id 5b1f17b1804b1-490b5e644efmr36416185e9.3.1780473494410;
        Wed, 03 Jun 2026 00:58:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:490:59cc:998e with SMTP id 5b1f17b1804b1-490b5e644efmr36415805e9.3.1780473494030;
        Wed, 03 Jun 2026 00:58:14 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc294sm8627235f8f.7.2026.06.03.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:58:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:58:11 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: coconut-svsm@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [RFT] KVM Planes on Linux 7.1 ready for testing
Message-ID: <ah_c_5bKpmx3nOdA@leonardi-redhat>
References: <ah6w0xGq1jtKNJen@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah6w0xGq1jtKNJen@8bytes.org>

Hi Joerg,

On Tue, Jun 02, 2026 at 12:41:57PM +0200, Jörg Rödel wrote:
>Hi all,
>
>An updated version of the KVM Planes patches is now ready for wider testing.
>The branches are based on Linux v7.1-rc6 and QEMU 11.0.0. Before sending them
>out I'd love to get more people from the COCONUT community test the changes and
>report any problems or regressions agains the 6.11 version.
>
>The Linux branch is here:
>
>	https://github.com/joergroedel/linux/tree/kvm-planes-v7.1
>
>The QEMU branch is here:
>
>	https://github.com/joergroedel/qemu/tree/qemu-planes-linux-v7.1
>

I think commit `ACPI: Rebuild ACPI tables on every read` can be dropped, IIRC
this was necessary when SVSM consumed MADT from fw_cfg.

In `qdev: Add plane property`, in function `device_initfn`, dev->plane
should be set to `qdev_default_plane()`
see https://github.com/coconut-svsm/qemu/pull/31/changes/8fa10020cb97ced3151f67b842ecba57ef76765e

Luigi

