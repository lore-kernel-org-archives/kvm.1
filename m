Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDC5275B8
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187976; cv=none; b=cuYyUNCBr8NYJ8JA0BkE545Oqg0CFYQ6Qmhb2cGLW2Bs3/10UYB1/6u4ltoHJj91jC3bTEQN84FAARdqQVDwr//ycDBC7TNj8rH9RKttXaRKEGUqdQVZmODAfGfNdPtJuNh87ddStQboxX6yBzh8e7/gxg0Hjk3hIHfEo3faJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187976; c=relaxed/simple;
	bh=LhiPso6phLQM0wA+k6tjmIhIVqDrjbY4C0VTVIyFW7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrW44SD2W/Ees9hqM87HBmg/jtWnu0a33UjFrGhHh8Y97qjcy+EVMMhqYgCqycg3hnO3hFOfuiqvHruTAZNzPnhlwnOChvbXTiljJYiV/DdOKCgMU7Bi8YdBtRG3PKedpT/eJsn66cEKxJBvxC74OOxtKQji3xgQ+9bf6u2g0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cb3d6YzW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cb3d6YzW"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so7678975ad.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187972; x=1790792772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LNon7FG4gNvQZ8cTIn7dGZggjcYoEo+V3D2k9W/8Sxo=;
        b=cb3d6YzW6nrGuRRS6oSU6xIv3mfNSvAfD4J+NhlQOOwGhtfYHTTWnAIK8qaVqc1gkc
         r0EMkPHPvvuRU99MGAgbwLazKtATFcwxTWwuJdRVO4+8BXBh8alzfX+EQfop05AIYzub
         06zcGdrRIZeWntKW7Z/GsG8cDvxIw95aqKmtrB4GUybxBPseaSwjRFdzyNfnsxZG72WS
         i5rhwkf9o7Wlgs9oHqgmGnk8IXv+DAZEyXpVj2V0OHPL8M1QD/gqAlmwtAmJhqAp/zhs
         SElDmw4UvXWAAA0OKEDvJioloFPEYLJAT8X61OdhF18NghTfdBl6cuVTC59eTKPNsS4b
         LLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187972; x=1790792772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNon7FG4gNvQZ8cTIn7dGZggjcYoEo+V3D2k9W/8Sxo=;
        b=Nqbv+7pXKNgScb7nae+tbjrpHkcqZV3OEMQ676T9/NI/B0okHOtVXL5ydDUFtPkH6y
         iHFrr7uaIZhMmYkOKiYX4Bl/xrPFdx3HiazFxH7CeAqIBEQQVAUXbMbOG/Lj/VEj5oY0
         nTdqeJd1RWfyAdezPp7zx4b1zYMQs7EBio+B9qUIp79+QJxaBFQ7p5w8DDhDtuh9mXFw
         79NCEg8jZirTwSsqiN4u1S7EZ8RaitkZ4x23CnKXK9X+0SU9jOUte/wVAyRNwDI0W0UP
         4vgGMQNaiukozYVc0C6UA2N0CgTGTmTfliH3r65BeFGjJVkMDjhPsiTH/jmyxHnlmOWO
         R07Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZO3E0LOF9QTG6i8tF/5ym18Ru2YbBL3CqbjW/FiFjIk2M4XCrMEMuiqe2mutt2byOgi8=@vger.kernel.org
X-Gm-Message-State: AFuF++nyjB1j2jp3HjhGBpeRauMCmeKqHbdkARh7MS448ueZVP4+BJw+
	JqDucC0HqBKJBNSHFRR7VHkcZwFag4nwU1dMIifkz7skXbQy3sot1yF7YiGPcZB2fQ==
X-Gm-Gg: AYBFou2lWCumSElmCpgpO/cBGolQleixoxYrWpEHUsl3j3B62g71p0YSYPKTO++LCU0
	oNfNSaMJxJ1ejoR+Qo1PjXmzx11pa5+Y8W45ykvp/QOdr5cwge13M5Y+NnGLNC5O7wfq/Jdl+lJ
	UwpWkYkcWGwbFgiV1IHW6NmlCabGItD5xlLxciinQNmhv2UsObav3fkTEp5dwlitPBV4BIrbGWE
	IbK6MwpXepYSLqiMjctXRy4b9TSJ9DybO7zyv09TUC+kMGew3nkAJXioMV4glAm+TgbFnge4DY9
	XzkGBeQK0PBMaaskVCr5LwP3U9/A+cIgWn5MsYh/jDjamGnyNWf7Erm5sHIzix+9qFiWTwaENEq
	y36QLW24hEBoZEOWB4jP/3f+jPSubTDNAFNA7skuVj1sM0CSSi962ApjS7BSsmGcyX4+COKNTWp
	zlmHO/iMkQjH2CQESspYWBXuBT9KKj5g28bWQVJIo0/G4BRhQKD/2OT+MQTfymUahdq7lwoPIoK
	TZiAsDaX+UEmaWYJv+qiRRWP3ynfZtZay36rYD7fJyDYI9ZXV0=
X-Received: by 2002:a17:902:ef52:b0:2df:3b09:664 with SMTP id d9443c01a7336-2df69dcdbf3mr30657015ad.32.1790187971787;
        Wed, 23 Sep 2026 11:26:11 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm15475075ad.64.2026.09.23.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:26:10 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:26:06 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Christopherson <seanjc@google.com>,
	Steffen Eiden <seiden@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tariq Toukan <tariqt@nvidia.com>, Zenghui Yu <yuzenghui@huawei.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 06/10] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <arQZvkNtgq-NlUkh@google.com>
References: <0-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>
 <6-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>

On 2026-09-21 07:35 PM, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will need
> ~18MB for firmware pages. Existing drivers pass in the sizeof their state
> struct. Since drivers all use only their declared state we can use the
> value directly and remove the SZ_2M hard coding.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
