Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D8384CE5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763884; cv=none; b=MDxLEa8+eKGRUo4A7ixm32DbrwOJ5aI8KFkxE/lf9464OBz9xNKULk7GzcZ1ejlm2FYvw/OSZ7eoAR7aGM7cV94tGsULjrr/GeAufQKBMpjUXxG7sMgo+1ur9+DCLimPIAP062K5Fa3FgG2xE1ygHsHcmt5j/aOIWmGiuRHChDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763884; c=relaxed/simple;
	bh=dA/QzLZGwZkE4CjgTHgVqZUnnA/WDNyS+RSiYCdTHtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut6eDOnnHLBkLb0j++Yn1OvlJDoefhksVDitoAKmxsch+gucZa/0i3ka7eLlPuNpmfteW30L0Vt6EL7PfzXaZ4qTeDiOPfKnnZqDxYJJ45NayR+3HJH7dG12eI74CWlkRZGhVPH0gU9B9W/RibfM7D3EUhJrys9g0L+lrLgjCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5ggMvtD; arc=none smtp.client-ip=95.215.58.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5ggMvtD"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dA/QzLZGwZkE4CjgTHgVqZUnnA/WDNyS+RSiYCdTHtc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790763879; v=1; x=1791368679;
 b=T5ggMvtDY6yoIceTrJuUiuL/+EHCwhzlvJC5K+vC6LnZZn7D4iojX0zLu7ORY1bT0VCfe9yB
 iHcu2ae4GvTTMYwByy6mGpeoT98YdSLAo5espSTEaEqhVKLoWglAt2tfR5RZyAJksDHE4gg5X4a
 62aPSrVMrVDWM/xIHcRG++gA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d1a8dff05957b187;
	Wed, 30 Sep 2026 10:24:39 +0000
X-Mizu-Trace-ID: d1a8dff05957b187
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 12:24:38 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 5/7] riscv: Decouple SBI console from UART
 init
Message-ID: <jshzzt3o7jdh6dum2ynv2ondsbncpumdj3ixd2riuugcldcw62@kmo6x3sf4pru>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-6-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-6-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:43AM +0800, Xiang W wrote:
> CONFIG_SBI_CONSOLE already routes puts() through SBI DBCN, but console
> setup still went through the UART init path. uart0_init_fdt() could skip
> a missing UART, while uart0_init_acpi() aborted, so EFI/ACPI guests
> with no described UART could not print.
> 
> Split the SBI console out of the UART driver. When CONFIG_SBI_CONSOLE is
> set, io_init() is a no-op and puts() issues SBI_EXT_DBCN_CONSOLE_WRITE
> directly. The UART probe and MMIO path are compiled only when SBI
> console is disabled, so ACPI and DT boots no longer depend on an MMIO
> UART for output.

It seems like we should have an SBI console fallback to a UART, since
the purpose of these tests are currently mainly to test SBI. Note, at
least ACPI systems that conform to the server platform spec must have
a UART.

> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/riscv/io.c | 50 +++++++++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> index b1163404..6656cd32 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -14,6 +14,26 @@
>  #include <asm/setup.h>
>  #include <asm/spinlock.h>
>  
> +static struct spinlock uart_lock;

In any case, we should probably rename this to console_lock.

Thanks,
drew
