Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380807080C
	for <kvm@vger.kernel.org>; Fri, 30 May 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623193; cv=none; b=OxpYlK93C1vk7zX7pzrl3U0qQliyiQIsRBX76l/FbJRooki7Ou/0VNYgOv44UDtFhHK99QrkheecDrU0QrRexMUYUSI9YQXlfAHgN3ATSql6kX9rFecZ/NV5useurtgp0xAEV2gE1v5cX/WxHTBEwYlB+TV5iZsQ/CE7/CE3rBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623193; c=relaxed/simple;
	bh=z3hPZi3N1DTOwIoncmrDyWZZH+E/MgDHlyYMzOv+/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfZ2z/Ry9AAIYYo7k/zVw9lYtWw4o1bcZEwEEaOVeZVvESxt7gq88q5fDAW+U+M9IgyI0w9xcFp4xV/kd6MJB7O5IjT+yjwP/jkpiR3HAz3IM4S2ao3pKLz7kI5nOpI2B0aUpsICyuLCsvcHvHTVvZ2+Oim9JIZEv+iOvR5T/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfl1qtty; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfl1qtty"
Date: Fri, 30 May 2025 18:39:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748623183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgIxipEXWbgU+HN+yj2I/XOYpk/trnybihtvfZOvTeM=;
	b=vfl1qtty+SpCQsgvOvl4Z+h/IvpfEyw+eE1zyepn3ZcYAdHKaaKPTtWUHU6UKKNaY5dNkj
	6oDBocR7WhvfJJGzO6DrrFno+pfHCeBDqU+k7ZoAAO7SfGMHiiQ9WOheA2XEa93qoLGbsx
	VnZV1taGh09n44YpmiyoxwXtVoKty6Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] travis.yml: Remove the aarch64 job
Message-ID: <20250530-61a88b355b5b9621a26f7e1f@orel>
References: <20250530115214.187348-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530115214.187348-1-thuth@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 30, 2025 at 01:52:14PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> According to:
> 
>  https://docs.travis-ci.com/user/billing-overview/#partner-queue-solution
> 
> only s390x and ppc64le are still part of the free OSS tier in Travis.
> aarch64 has been removed sometime during the last year. Thus remove
> the aarch64 job from our .travis.yml file now to avoid that someone
> burns non-OSS CI credits with this job by accident now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 99d55c5f..799a186b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -8,16 +8,6 @@ git:
>  jobs:
>    include:
>  
> -    - arch: arm64
> -      addons:
> -        apt_packages: qemu-system-aarch64
> -      env:
> -      - CONFIG="--arch=arm64 --cc=clang"
> -      - TESTS="cache gicv2-active gicv2-ipi gicv3-active gicv3-ipi
> -          pci-test pmu-cycle-counter pmu-event-counter-config pmu-sw-incr
> -          selftest-setup selftest-smp selftest-vectors-kernel
> -          selftest-vectors-user timer"
> -
>      - arch: ppc64le
>        addons:
>          apt_packages: clang qemu-system-ppc
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

With gitlab-ci, I'm not even sure who still looks at Travis, so maybe
nobody will notice that arm64 is getting dropped...

Thanks,
drew
