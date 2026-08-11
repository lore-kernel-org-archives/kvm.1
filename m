Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1F2E7657
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462183; cv=none; b=TSsrsnBKnTAoQ+AixsjRRQ2zp7EM6Y6/WVJL9BNYOcjtKPQhfVfrYJR0huZGSfXVhZBcn7Fu1cYgZbTG/8v0rC6XjiR/wE83UGGs3OD3eEkxiCsRKh0hrXU50w+ivzBxbS0JZbBRwq54OeEKzLxelPL6+BkZu/mxqn72WVydmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462183; c=relaxed/simple;
	bh=eugBYTWhZSVP4pqWdDooSdV2x5jKt1IrledlzilpJ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDYDziOpvtMIGXXkNo63sISd4KT0oO8VcEjaWc7NZ9vGVmQpEjUOGA2M/qqSDMrTzsADNNF/9fw1NqXla8AUgmK7eEdrPlSNxgKJMSt4QXawtyU+c//W45FJu2t2Q8dcuvgIcx3FQwa/WuVvsgDOGLzafINU5g9pbchHiLHYA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NARlBwmH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NARlBwmH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3893C1516;
	Tue, 11 Aug 2026 08:29:37 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45CA63F632;
	Tue, 11 Aug 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786462181; bh=eugBYTWhZSVP4pqWdDooSdV2x5jKt1IrledlzilpJ+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NARlBwmHC8bueH5Zge2NmE+yjMH7mOGdgBdaoWgeOdAo5CR4nKFoDKxGdPOk2Qxua
	 Qx/kyu3OqfDyzXYF9UUQ9oB2XVhYuq6GnwCCnCa1HFrQrsbJrlwLNRH152fbLD8gkh
	 DuEILYnfb2GpINRjQukRyyNA1g24BQ/uWyMJx7aw=
Date: Tue, 11 Aug 2026 16:29:37 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Zongmin Zhou <min_halo@163.com>
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, kvm@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool v2] arm64: Fix resource leaks in
 find_pmu_cpumask()
Message-ID: <ans_4VcCJblNYplt@raptor>
References: <amzVh6ILi4rd6PwU@google.com>
 <20260806023218.21068-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023218.21068-1-min_halo@163.com>

Hi,

On Thu, Aug 06, 2026 at 10:32:18AM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Close file descriptors on read_file() failure and close the directory
> stream before returning from the function.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
> Changes since v1:
> 
> Save errno before close() so a close() failure doesn't clobber it,
> allowing a single close() for both paths.
> ---
>  arm64/pmu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arm64/pmu.c b/arm64/pmu.c
> index 78c15f1..ef7faca 100644
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
> @@ -107,11 +107,12 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
>  			goto next_dir;
>  
>  		fd_sz = read_file(fd, cpulist, PAGE_SIZE);
> +		ret = errno;
> +		close(fd);
>  		if (fd_sz < 0) {
> -			pmu_id = -errno;
> +			pmu_id = -ret;
>  			goto out_free;
>  		}
> -		close(fd);
>  
>  		ret = cpulist_parse(cpulist, &pmu_cpumask);
>  		if (ret) {
> @@ -140,11 +141,12 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
>  			goto next_dir;
>  
>  		fd_sz = read_file(fd, buf, PMU_ID_MAXLEN - 1);
> +		ret = errno;
> +		close(fd);
>  		if (fd_sz < 0) {
> -			pmu_id = -errno;
> +			pmu_id = -ret;
>  			goto out_free;
>  		}
> -		close(fd);
>  
>  		val = strtoul(buf, NULL, 10);
>  		if (val > INT_MAX) {
> @@ -162,6 +164,8 @@ next_dir:
>  	}
>  
>  out_free:
> +	if (dir)
> +		closedir(dir);
>  	free(path);
>  	free(cpulist);
>  	return pmu_id;

Looks good to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Just one tiny, tiny nitpick: I would have set ret = -errno so we can do
pmu_id = ret in case of error, like we do for cpulist_parse() errors, but that's
totally unimportant.

Thanks,
Alex
