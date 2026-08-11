Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B003939DA
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483377; cv=none; b=qL/mYt270jjZa3/bRKoyUgCPENmOticQdCFMZY/R7mOVLnb9xkxsqZDRCDbuG+Byl/FtpwLyISnx5wxOcv2TyzyWWLxqmHansSY7V/CpAZGhyNuH/y7qlZxDNKPqrVJAGWj8Zn+J6OT9A0OlBJ6jtlxzjmr6bS7kBQUKPOorRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483377; c=relaxed/simple;
	bh=XN/rifqNvJQDtxhcJX1CkOjTxm/idHUoaQKoCIcr3J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMEhdf7EhfOxiRpyY3YpeYXKsXDxDXxAV965HI7ivlx9CAw2Sy12xEFQ9bV+sdkitxyz1iQOdMDbE3Txa6ggA8B571XjB12g3nhnxG3IwehW8kQDacDi0yfVrGtyCJwGMoy9Yeq5DcqcmnANDVblI6qYTaIMtgmLIJTuutEwgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHLshkuD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHLshkuD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so4950905ad.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483376; x=1787088176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duzXNp2G2UESyfsX/Nv+I5To/x8QlNagRZc9TfujvZ8=;
        b=iHLshkuD8hBFuauu4Di391vGvcjQPTjaGzzEbn5A5oegjFPuo2toVazuiHN6PYmxAb
         /HpeaZ7L7FPd2yTnQjuluPzw2qiaz26lrtn3pQu1kZ4cVTxgo5BKjGilTiLxUTwV4eT6
         em6hDsWoiS+ZCtPV54S7Wg1VaWBad7TAFpQWvmLxaNR9V1eBftl8BqCFF6hraUieoE84
         BM/SD5uATWeSfQY/znDz3wI7Go4cW22PGFkMHMFP3eDnMDiuxegNYylALhxUhHMkIcHZ
         Bf7aMENNcRKgAG7GIoc3J9AIIgV16iuBudza6Y2fGq5QIb8b0/ewFob6ACmvz/5WZYnS
         QJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483376; x=1787088176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duzXNp2G2UESyfsX/Nv+I5To/x8QlNagRZc9TfujvZ8=;
        b=jq0xbW4DGWeTewQQ4AkbAeyEVx5J6WhD5wuyhRrqJ9MlUFLvG7K8ByvMB7I0CvJWCH
         B/Mo1z0DYp3QzrnBHCHFVTgOK/zZtN/VPOaf5bVxi0pFZ42FkrKCx1QdxVtPcUBNai1+
         ZGehDSdL1Qpr8KLDadrgaowbeWRqtfK5AvCukrsvyHeJOUAzvVLFjqeY+Kk5oKRbnmL+
         mje28DDojUDMABj1QMnQHD9UgR9ByYyosZYgAYK8Ck71mhta1kpbaLfTROuO7TCXMLsz
         SsMbTMKqRYkVIZq818Lr9I3Tq4DZtexXIrVglaMqB7btKdV4ZU33e6TmmU01eGpn/N2G
         fqtg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9nMtxQqqlZWk0bZGBxdIHjOh1uawjf2kvncYMkBbQiGs1KD0U2foUu26Wqwws2+UmBXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvtXHEqutSoqIrK31ymdfOCoZsuGP4fa8sGmzwV72pnNrshW4
	QjAVICPshBSJk7c0sH/+iFgme5Y3hlzbW/w4uCEA2TpNNAdUE98wgsyjFwaRAJvpaLh5fqzZqnL
	e2gEyVA==
X-Gm-Gg: AR+sD10jJbLIs0cbYq0tZmBElKElXukjfL+D3tMhOPi9C4etYbC25/CokOeaz+SJ8mh
	OO/NVyLSc4A25To1iP3J1VfRINhSqllrDmOUUueEcGnP29hG2PfobfMb4psEJn1SekctkasKzBt
	z9z/uXhlfX9oMyfOzEEtt6YIFGQQVXHIlS08wLppZFYFL3fxcCwcHF5Hsk1FjIxgRksPxWIwJbX
	LWNOL8lEo5TuCI2MqU9YrMyZP+s9fqQDv5v0XrMvSki1nIyyUHVhmW8fIOwnj76ttVBk0sbNrSa
	0xBktIpC81+Jj6kOV0V/5qY4Jvq4+Y7sZWrIL9nAcczWREZmal2oWT+Fy1pOszQ2NbYEQXcUsWG
	AjWRn2P1TTd1v+yJUqKuRszlEWPwlcQZHx6ssqIDaVFLP4gZK/vfD8giM1VuAHS3zyY0hTC40Ua
	XyTtrckD1vh1uqA+J09icGh0GuFmgCnLWe6X/Upgkqp3He+WrrniKr4CgQ1VtysjdvXaAv0wwgA
	SdgK/6zsEn9+0vZTi4poLvyjzVoZQ==
X-Received: by 2002:a05:6a20:a105:b0:3c3:a168:edc3 with SMTP id adf61e73a8af0-3cc2bcbf252mr7676629637.38.1786483374995;
        Tue, 11 Aug 2026 14:22:54 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8bdaeb5sm1461553a12.11.2026.08.11.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:22:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:22:50 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 11/11] vfio: selftests: mlx5 driver - add send_msi
 support
Message-ID: <anuSqnU7WPy-9enn@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <11-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Wire an MSI-X vector to a dedicated EQ so the mlx5 driver supports
> send_msi().
> 
> Each EQ can be linked to an MSI-X vector, and the CQ can be set up
> to deliver an event to the EQ. Thus, when everything is armed, an
> RDMA WRITE posted to the QP generates a CQE, which generates an
> EQE, which generates an MSI-X.
> 
> To keep things simple this just re-uses all the existing QPs and
> CQs, so they generate single MSIs during memcpy.
> 
> send_msi() drains any accumulated MSI EQ events from prior memcpy
> completions, posts a small signaled RDMA Write, then polls the CQ to
> consume the resulting CQE (avoiding stale completions on subsequent
> test cycles).
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
