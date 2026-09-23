Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC05372F3
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188261; cv=none; b=ov1U1QEWtxtRT7H3SbM087qJ4r15DV17nS8jpBAV3EKnMwYh5C5psCokRJiS4vG3CAiaIiSwutMyMzFHN86wuntSSYfjKXqrgkMYt5ac3qGAf1pMsA7brXswMSUA/pftwUNElFC3Xy7GoWPIUY24HPOeEOLwJwlhMH5nd4Tsjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188261; c=relaxed/simple;
	bh=lWag3oM9sYGpdHyGnDE7rA3iXeVqrktsZhX6pT4UGs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVVRke9H7pcAi9YkKFu6+IxpY/pRcY32jIE9zzMWZIafyk+wjvM9vu8uG5TyYWxeJJV5FlvHJrslA4SmlU+/HJuAR5cS3ShsBSpsuMomVgxg3vbmUzvTnwiATiO/fReEOvU/QMU61Tp6C6rT+X2WQl8W6psFK7eju84cOl7syCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wH+pf7ZJ; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wH+pf7ZJ"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8623e5d435cso442315b3a.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790188254; x=1790793054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQbES28pq+4+5SdsOxa0hPCoAfkWzPeIh6+fD64KIF8=;
        b=wH+pf7ZJOq8XzJE5WdC73W3WZbhnDuc/f3aiTHblBQTT0/CnMuM8TdyrjHmeBjCDor
         TRuRy/QiZ+b5BLMJLf9DiUuagUrK9vZDJ6mWMTsK1BtKS8z5J5nt2aUs2Y8lDlCt182J
         aW6uYwg2v2k91qopC288FwvW56Rm3AVpEY7KrRWkrC7sUS3oxsTQySWZjMiU3+Zdor+m
         Rw2PKXGk1NN8BXpEIyvukkeXthyIssQzYsniR7OCIWictoIhqvRGEJHSpSokla1Z2WiU
         lHb1Ipn7w/+jiDdby4qqH+LBCG9fwNaHDLOzqdSiGhTF8aJqoLxiLrueXMF+vkwHOhSv
         lu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188254; x=1790793054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQbES28pq+4+5SdsOxa0hPCoAfkWzPeIh6+fD64KIF8=;
        b=d7WYfIxz0FaaA+UgEYxLeRDDc2Aw9vuSvMk5mnM/FoZ5hbmxEokwf/f+Wlok8vBIG6
         S/IRWWVLpmBcf8hExN+jle0bzIafiSjxuk/qkS9Lq935KqleeIUiNLLtpFIDQfrdKwAT
         9aI2L2aXwmmx6EyoenUlb0+4rVe45hmOFfVOm2yW4Vmc3cY784GYCwo+daknqIkYCzII
         KzoqXpt7w0qrJgNkq8kjpSSEVrvBTCgjnKf+J+dsre0qe/OFecWOgjm36Rwd8VEao6St
         /ithV82DtkjByHITiYLs6nJL2kbAHg4VDJH1XSqdrTSj9kYDnHgaN67jYR1GCq/g/IHu
         NIdA==
X-Forwarded-Encrypted: i=1; AKwUvBxVExMHznd6dink175fDf9GDbF7K9WgaCIKmhQjJ8Sj79DrcQBoCi5KivMwV25uUB3HGW4=@vger.kernel.org
X-Gm-Message-State: AFuF++m4599JxVNhw5vPAk8bNyLbE4uG0dmqoeD2TuRbwG9nYcZbu9Ln
	qPhderSvUgDeC7ledjcGdlmtdDi1+o2biccfWy8PqZGaG0cN88Mk8fSzIZDDuKS4lQ==
X-Gm-Gg: AYBFou3wL5LbgowKHMCBiHcoNqhC30Tk9HOZvjDOFDElRP2x6aSpy8RhT9YRgejZjq2
	3iChmch6ugx3RITXoOI3VRQFuS1WBkLMKh8zA6UiKntml70KKRPI6hBWTNfMTMy/XP1+BT+gv/j
	j9IlWiatbtlLsIFHgZejmzpazaz7aICPapym8UtGLfsODUMwUdcJ75DebCIoZL2CUrOyau5UweG
	GeCbXUTKcsmNsTyrY+Gkg0REGk0Z+VvnhGQdfLhEkbCVzUkbYLJnl7TV0NWQ08EcqB8aQNamzzY
	XxM9oqX3NNSCtu/DtB0KSH9+n60ztA3yD91Fe1QC1piTb9X5IKgWJPYCdk8dixc/flbS2j5ZlYA
	akmP6u6xVdpMIZPTQ05AAsNFluMvim0L+39azdbeBfRTm3VHnLp9CocUuoS0+4Z7TCpw0BlA/8Y
	Im/RqErCr4VZ9C3TPV7nFlnx5laz+L18NNMk42lM+3OBfpoPBZV+xQuK/4q4WeGy4Ey+DMDb7xZ
	FNDegokMiUxT8I59pN7oDiI5KnBxHJJqbl9LebHiV9vqKr2/5g=
X-Received: by 2002:a05:6a20:7290:b0:3db:131b:8d8 with SMTP id adf61e73a8af0-3de0e7300c0mr45910637.14.1790188251251;
        Wed, 23 Sep 2026 11:30:51 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c12besm1736810b3a.29.2026.09.23.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:30:50 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:30:46 +0000
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
Subject: Re: [PATCH v7 00/10] mlx5 support for VFIO self test
Message-ID: <arQa1khEHzKOfkCK@google.com>
References: <0-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>

On 2026-09-21 07:35 PM, Jason Gunthorpe wrote:
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

> v7:
>  - Fix some compilation problems, kvm and the igb

> Jason Gunthorpe (10):
>   net/mlx5: Add IFC structures for CQE and WQE
>   net/mlx5: Move HW constant groups from device.h/cq.h to mlx5_ifc.h
>   net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
>   net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
>   selftests: Add additional kernel functions to tools/include/
>   vfio: selftests: Allow drivers to specify required region size
>   vfio: selftests: Add dev_dbg
>   vfio: selftests: Add mlx5 driver - HW init and command interface
>   vfio: selftests: Add mlx5 driver - data path and memcpy ops
>   vfio: selftests: mlx5 driver - add send_msi support

>  .../selftests/kvm/include/arm64/processor.h   |    4 +-
>  tools/testing/selftests/kvm/irq_test.c        |    2 -

Sean and Marc/Oliver, can you take a look at the changes Jason made to
KVM selftests as part of this series before we merge this into the VFIO
tree?
