Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75259407575
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767888; cv=none; b=rk1g8NF9S/WvH8REEGWYVtfwAERx5sJtJKFi6/chNe/MYHdFCIel8/7zjcoumoNbOPKVf0c5BOZzPIFKv/0gL/Gm8uiCWquIekSwrRbT+OSm/VmNyEuANRGH/1gcByOwPW1BZ5P5FCN1zGhAp3YiUzkf/FvUaHFEUv3USgbpF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767888; c=relaxed/simple;
	bh=fA9a5p52fbpZZnjOtknYqWlMEppQvEzUSovaz1CMl8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfu9dT9quXuQ6H1/cKE9xynOUDzJLyIza7vLmmY+wbAx2KpOB+/lSQaeRwOfdFaOAfycq6vt5sO/ONrujBH/49/ByXidF8zeXEuPyzYIDgIMNiA4oaruylV0yDRBVrIhGQpbHoTnFqasWOvPs/vH+OF/6il03kOU53xyOraSl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdqoYWnK; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jdqoYWnK"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fA9a5p52fbpZZnjOtknYqWlMEppQvEzUSovaz1CMl8I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790767880; v=1; x=1791372680;
 b=jdqoYWnKqA0dbdOMVzMqwt4hwMI7bl5fydvYkorHtvWg6ZVXdIsZFCsoNToQ7t0ng0NFI3rl
 H08/8HPr6gG2W41QCq8xrP3lob9YAARbib/2GC5nAAQb5mbhoOou5lGPEFCEYy597IDMzbkXfw7
 VPLixWQTkOnCkiI/8WZ/2EHQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f841383894dd621f;
	Wed, 30 Sep 2026 11:31:20 +0000
X-Mizu-Trace-ID: f841383894dd621f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 13:31:15 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	opensbi@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH 1/2] riscv: sbi: dbtr: fix enable trigger
 return code check
Message-ID: <45hjpd7vkuxfz56lybc6umu5gtm6tjxcafmnxgivbreagy3ddz@k53zzk324hog>
References: <20260313050831.4016944-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313050831.4016944-1-npiggin@gmail.com>

On Fri, Mar 13, 2026 at 03:08:30PM +1000, Nicholas Piggin wrote:
> Enabling triggers that are not mapped to a HW debug trigger
> should return SBI_ERR_INVALID_PARAM.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  riscv/sbi-dbtr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
> index 129f79b8..489242b0 100644
> --- a/riscv/sbi-dbtr.c
> +++ b/riscv/sbi-dbtr.c
> @@ -744,7 +744,7 @@ static void dbtr_test_uninstall_enable(struct sbi_dbtr_shmem_entry *shmem, enum
>  	dbtr_uninstall_trigger();
>  
>  	ret = sbi_debug_enable_triggers(0, 1);
> -	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_enable_triggers");
> +	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_enable_triggers");
>  
>  	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
>  
> -- 
> 2.51.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
