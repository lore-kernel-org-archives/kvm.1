Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20C4DD3D1;
	Wed, 30 Sep 2026 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783635; cv=none; b=dT4DAIBalDxZiZwjKUZvBUtk/DeeNVs6RtCmn74dkqOdyi9nqjpJPe+JzFRnHimvXugLdUDkUJBJijd3LqVY8eHhq1/l/3PMvqozbNXjn3XE+Mpbkn2mqGY/dr+2pTIx1TTNSbsQAaCSU+jrABJqeeCD82VxS8sLMWZfWFCM0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783635; c=relaxed/simple;
	bh=GeZT3eDs8g2P03kaTo/dM1gVfvnN9UUrvbID96/B/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEA3vMtME0OerEJ6jaKLS3WkHHXgNaa/0pSz2+GeZ6rJ8BIj4LXmHTq/AiW3bciNx6G3sUbIoDUEeqg8SN69pEayYICIrtHUcC3Vl+9b0hUTbSLH40r92t7OwXh6LE8HwQRKaNlcwxrY2NwRITEd4sqSIP92egJUy4P85x0v/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R8pMXVb0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R8pMXVb0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B8D497;
	Wed, 30 Sep 2026 08:53:45 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322A23F86F;
	Wed, 30 Sep 2026 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790783629; bh=GeZT3eDs8g2P03kaTo/dM1gVfvnN9UUrvbID96/B/Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8pMXVb03CZpqC51umSjYoF0JRCkg7SOK9oalIrlA119QlD+2d4wVuJONjxlgRJaJ
	 n4vv+XKAMK1X4GFrq4+WvDkgb4sk3WIsVq+Bh2Vg5L3yPhifAaQZWmBWE5/sLwFw8b
	 Pa5vscKHSQFYjFFgjJEMkkchUHxoLe82JXko2qOY=
Date: Wed, 30 Sep 2026 16:53:36 +0100
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
	sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v20 9/9] firmware: arm_rmm: hotplug: Skip memory added to
 ZONE_MOVABLE
Message-ID: <ar0wYuWxO6Ow4n6n@arm.com>
References: <20260929221623.1342076-1-suzuki.poulose@arm.com>
 <20260929221623.1342076-10-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929221623.1342076-10-suzuki.poulose@arm.com>

On Tue, Sep 29, 2026 at 11:16:23PM +0100, Suzuki K Poulose wrote:
> If the hotadded memory is in ZONE_MOVABLE, we could allow that to proceed
> without the RMM having fine grained tracking, as we won't allocate pages
> from there for guest-memfd or kernel allocation
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

With David's suggestion:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
