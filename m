Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519572;
	b=RBdxSMPshk4C3jccdoWvEQ7Md5oiwmnYvA46gKaKwbmNQCVlD/37z1dsxfBT8pY+g0y0
	 3FTPU7GelKCBbjmfzBwbiaMdi8ML0bNAUlrOapsNlO+YGlEYgj/k/7UCL3R62d0s/OjOM
	 8vsYEUGwFNJnTMCUlX2jDOb0q4/JHrdwhhRGY0JT4sbiiEqgcnPeIU9yqSEaF8orOj5Go
	 XjNGO3U8kayJVIQoO3n91lg1KBZEjEOJ2MYRQEg1eTbmbSDoUCgKxO+qle3mboaOtEB1u
	 cmW/Z26M6h+42/8lnC16Yw/7hCZRXjvXXBW6XVIh5MMeC4JKkS+2wZL2J5QsBotQpeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=SUXOvln9jJr0+TvxVQvaMyXCCf9tllQG8YkDmLu0oVI=;
	b=hlwdwRpdBl0rnTFYcYDex77fAGxf1uUhS1reHQEYfIle3Baozr4DOzDYYR23S3WCGEDv
	 zmgiZqhwXHpmlaHrDNy73W0N91e2Ypt3gBHtoZ45zQi2W+j78PJ+LYOtyPmJXzYlDzCQ7
	 Qt1RHiIZ1HksCxAbDRnJoUDd7eKaiGYDp7IRldOhkg2GIEk9K2eTKgzYYdinTCHSKnKRG
	 Jv3iYiCDMw420pm2em10viW89MjghVZkHry9clPQJKCfRyvWIAosQyxW2U6sVWoRvPa9a
	 ZFlQR6385rtNryXDW8S1R3ommLVO4y93lOWcc+OWPKe8bPfwfg96Vq09IOYOyVFetbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x5V1fFho;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 11:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x5V1fFho
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2290846a91.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519571; x=1796124371; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUXOvln9jJr0+TvxVQvaMyXCCf9tllQG8YkDmLu0oVI=;
        b=x5V1fFhoCeha6M8sAU6GyYlxYQ9ql1akqwbJaUNj7qx0OY4U4Wpr6zsR7LrxiA5N1h
         dVDzsKtpCS5NsiAfpJe2ElWWPXlho5fReb9CT2vwQMcNZD9R147kL4AYVCblSuMND1SN
         Uo1O1OK3BT3fLCUG9IoV1XxCUPlMaEs9CUFWPZiTy3r6MYtabPQlXDj4cI2A4RsP5Adp
         mVLJTWp1wqgvQIdUBkBbFTDExere2zyxQhW0TdTazkZcwfmvO2JAVpAxYOiixBvJLehm
         Ofx0kOcCb8g3/Sp3JTb7Xt5GinN1CFqsv1Aid2aQufELaKPw8n2JcSesWCg/4873g0Pm
         LA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519571; x=1796124371;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUXOvln9jJr0+TvxVQvaMyXCCf9tllQG8YkDmLu0oVI=;
        b=sNPBtH/JxcoxVlxoexjAQbtgkYgWHpKTeh9W3Xpbz5rNtGSYNT0OLOpE9cuF8ZlsNa
         2tMHytNulIS9flDuju25Vc/rpt9tGQQ+u9jcS5os2K8CYjJmuCKQ8dJfW4UPaOAiS36F
         Q6kT6K4W4eye/KjLbXQ4nkzvnTvLUXL8tX07rtMUXauP4YfuNA5Ng6NSDK4l+C8pHEX7
         0xyab7ofO+lCYkzKC6VsUrbf0ZP4HmvMZurV9ZxFr/7c2hh3VS3EVpPRkzTSVT6pPje8
         YoSKPVCKTqs+oxF3IM2jkMLKxpvGNvBZOIp5T5caTQVVGLDDMIdiu5vVOHj84jbxHytc
         HZMw==
X-Forwarded-Encrypted: i=1; AL+hErGtiZaqhlKqnk5yD14/UlcW3UYWPRIMIBL5SBzzmW5tNOcd5z7LtKgCLIQj0xFreUUwOMI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r/+Q3mCpFtqJmBqgtL7+FR/17AnmkJP13UvL6nJUOsL9dqpHn
	Gk2bq7fhdtyG4yT+lAzhiMyrfNOxsTYxI6unphYbbFXxjfi5jh4p42DU
X-Gm-Gg: AZFdTZdWRwqQPHFyYAqlWyJALsRQn2+H6utrxF8Bd+sha44gJVhUZPD3sEFT4YN5O5v
	Bhj2P4u1ySVgYEMqxeivIdUKCmu+Qg9Sfz0RmBkYMhvFm3iqrhhpkqus5EAMPSbTuWGMhHHFSbC
	eSmoWzislVVjamm6h02S3fr3qAv1ehrYVb8GXBF0DFaFaZwBMeOwJi377fJxPbFJ6hmaBUgXymS
	xKbK4qhh/h68VreKo3yY6+KoVA7IhtAfxJBogj9V+bW7/MqmULs4oc9niRZZVZYkaUCqaJHgXQR
	2lCpqds6LkhxGMB0FXwawhFnQbxvS9JxAR6womkjOvce8Bsmt2YKWNbBP6a4SVKJ6BHFZ+W9sgA
	c292JVIT20pZaFTSHs+B4WGRwkehmqR/CccsMb6xSMeDqiRX6b5U7yKuecvOuS9ilnkvUFk5RqM
	7Oa2W9kVMxrUTRUWbEFhkoCMCBAbGG9HaFWNH1VaywQ8L9+OBzEbTX9V+hDJQjcRVtdxLrlxYJS
	HwLvnze9VKHJGTRszmHPuby30QdWpm2KtCDE0gOplCUQdntb6sBWMn/uf4olgUvTcK5syyhGLMi
	vu0XwKidlJ9I7nIGuh+xgEyOPHhvUsSDsolLQkcHkIYnOcHXqUMa9cns9xUZHEzHydzZ3FATZ2H
	u6e8EkmCJD0KH3TtTISyz38qYusWaU28RdE5ASLuYw7saROH7XRLdP4ECPA==
X-Received: by 2002:a17:90b:2688:b0:3b3:b71e:b2e7 with SMTP id 98e67ed59e1d1-3b41c92a209mr12093589a91.36.1795519571042;
        Tue, 24 Nov 2026 03:26:11 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm6204225a91.5.2026.11.24.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:26:10 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: yishaih@nvidia.com
Cc: alex@shazbot.org, jgg@ziepe.ca, skolothumtho@nvidia.com,
 kevin.tian@intel.com, kvm@vger.kernel.org
Subject:
 Re: [PATCH v2] vfio/mlx5: read migration buffers and f_pos under migf->lock
Date: Tue, 24 Nov 2026 19:26:07 +0800
Message-ID: <179551956747.71156.12583250816371186618@gmail.com>
In-Reply-To: <3cac8cb0-d598-49af-be35-0ead813af486@nvidia.com>
References: <179550684160.38664.16653575201489890045@gmail.com>
 <3cac8cb0-d598-49af-be35-0ead813af486@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Yishai,

Thanks for the review. You are right on both counts - I have sent v3
with the Fixes: tag corrected to 34e2f27143d1 ("vfio/mlx5: Introduce
multiple loads") and the commit message reworked per your suggestion.
The code change itself is unchanged.

Thanks,
Qican Ma
