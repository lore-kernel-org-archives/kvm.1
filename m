Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA336B933;
	Wed, 30 Sep 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761934; cv=none; b=BoQ/xv66cbTtOq3yWpoexe7cgDn9MjM9xV5YfhHOepvFYYLvTVK98GeC2hcpM2M/J5e8tRK8hLuQvth5zqQsZ/UOajNwncQuYUy5akb20Zi5h5oXFmp/mjIqXCwqDeZI8ouQcBpooDM1SetEeEvQb/plEb2VJOYN8nTVJPEKk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761934; c=relaxed/simple;
	bh=Hh/kEdyKxDItZL2czsn11te4PfKPTHpLWgBl2v8d60M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftwchboFpZXCtrKaXxxZI2jcqYfh+KwDZUOH6MCeKUkAkG5fcjm/c4FhE6V6uYEMASHD7KXnOjO7KznYWC2mY5/1xlCLVjjB65appK5peN+iHovEVHyGQELwesKOxtQ74dz45HHn9LJHOy1CAnoTdqfrgcVEjHkyohyXCI7KjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cwcKnvvq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cwcKnvvq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A999497;
	Wed, 30 Sep 2026 02:52:04 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35523F86F;
	Wed, 30 Sep 2026 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790761927; bh=Hh/kEdyKxDItZL2czsn11te4PfKPTHpLWgBl2v8d60M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwcKnvvqIEmedSeZQQhoIZ9dMjD4/8L9sRmwwDRYpF5LBg5tSZ3uGXpFfSzpOWsAE
	 5QIsULyPjCo/L2kedtkgNo68EQY4Kvo3Bsy16uGAYj2vLK1PKkBxuRmJLMY8KQf31B
	 vE6J/QkCbSMwI/cvCYa8EsEhr/Y4u7g6ZdL/mC4g=
Date: Wed, 30 Sep 2026 10:51:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
	will@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
	joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
	sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
Subject: Re: [PATCH v20 1/9] firmware: arm_rmm: Add SMC definitions for
 calling the RMM
Message-ID: <arzbue4Sdjt61lTu@arm.com>
References: <20260929221623.1342076-1-suzuki.poulose@arm.com>
 <20260929221623.1342076-2-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929221623.1342076-2-suzuki.poulose@arm.com>

On Tue, Sep 29, 2026 at 11:16:15PM +0100, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by SMC calls from the host.
> 
> The SMC definitions are based on DEN0137[1] version 2.0-bet3
> 
> [1] https://developer.arm.com/documentation/den0137/2-0bet3/
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
