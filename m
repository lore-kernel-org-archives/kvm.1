Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53D202F9F
	for <kvm@vger.kernel.org>; Thu, 14 Aug 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187667; cv=none; b=nisEnYH+qIVK5bg/nWKCNvlpO5o6T7bnHwazlRJQReCcn8pYuKf+AR5d+fCdNxMIv2h0+qRzqMzS5Jh5kHU9Ug12cL/1omr1+hdZPxvLMg4EQf4PWKWWN/EkHJ922xacB1hktpkbH1jV3oDhPqzX5ziTW2778Kxx5FWZL/sCWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187667; c=relaxed/simple;
	bh=R+fIibzS6ymkKz5is3AzY4nlSPzmDJ9+nVTH1DsOfOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwcBmmsodg8VbrmTiGPrEZ+WtCeG0md405z2E9aGVOoYhP5zBUJTJ5xoInsIIQZwvYATQyBRfCN8cZXBg4OvVg//jc0p9b12SsJBKe8WgV7AIO6A2XgUKTe5iasiCsMJ0VL/IqmIeKf4VOfKv6v45YDUjlq7gE7ognsB07/j87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B460A1691;
	Thu, 14 Aug 2025 09:07:36 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032063F738;
	Thu, 14 Aug 2025 09:07:43 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:07:35 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kvm@vger.kernel.org, Cristian Marussi <cristian.marussi@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH kvmtool] virtio/pci: explicit zero unknown devices
 features
Message-ID: <aJ4Jx784CjBgY1pz@pluto>
References: <ed62443b8fd3fef87bd313a54f821cf363f647a5.1755185758.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed62443b8fd3fef87bd313a54f821cf363f647a5.1755185758.git.pabeni@redhat.com>

On Thu, Aug 14, 2025 at 05:37:02PM +0200, Paolo Abeni wrote:
> The linux kernel implementation for the virtio_net driver recently
> gained support for virtio features above the 64th bit.
> 

Hi,

> It relies on the hypervisor to clear the features data for unknown /
> unsupported features range.
> 
> The current pci-modern implementation, in such scenario, leaves the
> data memory untouched, which causes the guest kernel assuming "random"
> features are supported (and possibly leaks host memory contents).
> 
> Explicitly clear the features data for unsupported range.
> 

This patch definitely solves for me the virtio networking issue reported at:

https://lore.kernel.org/virtualization/c25f924f-a66b-47cc-819d-5ed241a4bac6@redhat.com/T/#t

Tested on an arm64 Host (v6.14.8) with a v6.17-rc1 Guest.

Thanks !

Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
