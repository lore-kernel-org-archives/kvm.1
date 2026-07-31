Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B2453486
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517452; cv=none; b=U2GV2yJ052LTz2nWJEpuZvYJLae4iUCbqkpcjQXcCgqwNdkeJzstp5ske7Ooims7a34wIVMxLviHECmVbD2yWMkdSRCgxMoQTqtRs4XK/LFIBj4vtR9jtRfUIpk8lJSCjs+7wT861aVcqZuCzfulJioC18whpUXDXiQ/Zvb4uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517452; c=relaxed/simple;
	bh=KcDmR316smTsNHX44m1uETPgyflsnKebFKFRJG/TLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNL9/BDDrI6m4vJrfevsZiP2jC6ZfNvmkxMt9oDu0ayD8cRWNmnrfL9RDde/8vs2Eh7KXn281F9JBBbpbrcGDsOlnuv0Tt/dnpVbxSnU8wmIMEdOyHI2jgWG/tsvBMqNxnDnHO12/iLpRfRSMpQPQnj2idRvrpVkbWDUrdB0L58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKd+uNeO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKd+uNeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D371F00ACA;
	Fri, 31 Jul 2026 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517451;
	bh=z/Nn2UArsFdN/HN+cLIqWCMYc2vRH93RF8hf0i2lMUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FKd+uNeO9qvXd9OAdMfAHsM2Bpn3hm6a+XShoBYk8i1LogEqHsxBWrxm2oQLecj7J
	 b7QUsvaCL/dS3eKVx+OCnpRVtCX5eRIJ9u4m4l7KFNsYOah5mElx601BjS+9IJZ2xb
	 rpg8CJoPV+HEXcm9McSn1y7G331Ciiq6L7I4AQa9NGZxZQAQWe8mThvObca3AQRDoW
	 ydpiz12pg/oyfDrWKLaiL8TvkiNAPwuGiVRl9G8CulAd8c5rhFlo0zCWSbXxR9Bl2A
	 hjh5XvWR7u1nixwdfc7op2HFnAE8HhitTdUsmro4Xi3jT8lUI6utlwpWGm/bI2LtSO
	 BGH4TvZqANURw==
Date: Fri, 31 Jul 2026 18:04:07 +0100
From: Will Deacon <will@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: kvm@vger.kernel.org, julien.thierry.kdev@gmail.com,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] arm64: Fix resource leaks in find_pmu_cpumask()
Message-ID: <amzVh6ILi4rd6PwU@google.com>
References: <20260723090413.52218-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723090413.52218-1-min_halo@163.com>

On Thu, Jul 23, 2026 at 05:04:13PM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Close file descriptors on read_file() failure and close the directory
> stream before returning from the function.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>  arm64/pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arm64/pmu.c b/arm64/pmu.c
> index 78c15f1..b4d7605 100644
> --- a/arm64/pmu.c
> +++ b/arm64/pmu.c
> @@ -75,7 +75,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
>  	unsigned long val;
>  	ssize_t fd_sz;
>  	int fd, ret;
> -	DIR *dir;
> +	DIR *dir = NULL;
>  
>  	memset(buf, 0, sizeof(buf));
>  
> @@ -109,6 +109,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
>  		fd_sz = read_file(fd, cpulist, PAGE_SIZE);
>  		if (fd_sz < 0) {
>  			pmu_id = -errno;
> +			close(fd);
>  			goto out_free;
>  		}
>  		close(fd);

Seems a bit grotty to have identical calls to close() on the success and
failure paths.

> @@ -142,6 +143,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
>  		fd_sz = read_file(fd, buf, PMU_ID_MAXLEN - 1);
>  		if (fd_sz < 0) {
>  			pmu_id = -errno;
> +			close(fd);
>  			goto out_free;
>  		}
>  		close(fd);

Same here...

Will
