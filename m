Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494752459C9
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448678; cv=none; b=banpq/XcaI/s5S4KTPyYyHvfU4uFDICjcNGxVHcsdzkzRDDIi7hGt3cLn0SNhqeZvkmcB8WDOXqN9tzDjXeaXsu/IGWBpuigPLOr1MTmju2py4JmcicoZuhBjEmQK32D3O/sgt6HB+RX6/MOe79yK1/PqAYBwhXTZG2lxekjqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448678; c=relaxed/simple;
	bh=bxkQafv7M/Z3FWrCoGff76UTkoS3aCYV2mU5O/VO4e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7n2dDeknoKrUfdH8X2Mrx7L4sIaQ0YUubPLZ2t2xKpbnTX4rqEBg3zsnDTaSCt4jkoqg7JKE6tTG9+a3CS88c/A7DFsP8/gXLRhGJn6WgsQ/0x/iTtEpTNIexV3uuhLw5cE+VBHYWUmAxxKmGNdb02Me8eVkqFvUiHr6vDpNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=itg3IJdF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="itg3IJdF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4621F02;
	Wed, 25 Mar 2026 07:24:30 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB40E3F836;
	Wed, 25 Mar 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774448676; bh=bxkQafv7M/Z3FWrCoGff76UTkoS3aCYV2mU5O/VO4e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=itg3IJdFuJT+fEd3XaWo5Fj5YCxkwfV2dx8hV6JThcSu4By3rmLbZu2lNotTDmvDr
	 DquGrEfDnUw/SZrV9+1L3MSlp8F3TWI7+2+iHeVsqLNyeLXheWT4bId5E8PzpCvTGS
	 fhZHTooV9u9ksWvsr7+E99IjCt185YG7jt1cMU9s=
Message-ID: <cdc9df07-5da4-41f0-b386-56fb1ae37e56@arm.com>
Date: Wed, 25 Mar 2026 14:24:34 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 2/2] arm64: Add GDB stub and step-debug support
To: vince <liuwf0302@gmail.com>, kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com
References: <20260318154156.2064989-1-liuwf0302@gmail.com>
 <20260318154156.2064989-3-liuwf0302@gmail.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260318154156.2064989-3-liuwf0302@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vince,

I haven't given this a detailed review but I have a question on the insertion
of software breakpoints.

On 3/18/26 15:41, vince wrote:
> Add the arm64 architecture backend for the built-in GDB stub, including
> register mapping, software/hardware breakpoint handling, and step-debug
> resume behavior suitable for kernel debugging paths.
> 
> The generic protocol layer remains shared with x86, while arm64-specific
> state transitions and debug controls are implemented in arm/aarch64 code.
> 
> Link: https://lore.kernel.org/kvm/
> Signed-off-by: vince <liuwf0302@gmail.com>
> ---
[...]
> diff --git a/arm/aarch64/gdb.c b/arm/aarch64/gdb.c
> new file mode 100644
> index 0000000..6fe04db
> --- /dev/null
> +++ b/arm/aarch64/gdb.c
[...]
> @@ -704,21 +974,20 @@ static int sw_bp_insert(u64 addr, int len)
>  		if (gdb.sw_bp[i].refs > 0)
>  			continue;
>  
> -		u8 orig;
> -		if (!gdb_read_guest_mem(addr, &orig, 1)) {
> +		if (!gdb_read_guest_mem(addr, gdb.sw_bp[i].orig_bytes,
> +					GDB_SW_BP_INSN_LEN)) {
>  			pr_warning("GDB: sw_bp_insert read failed at GVA 0x%llx",
>  				   (unsigned long long)addr);
>  			return -1;
>  		}
> -		u8 brk = GDB_SW_BP_INSN;
> -		if (!gdb_write_guest_mem(addr, &brk, 1)) {
> +		if (!gdb_write_guest_mem(addr, GDB_SW_BP_INSN,
> +					 GDB_SW_BP_INSN_LEN)) {

How do we make sure the guest instruction fetch sees the software breakpoint?
Do we need a dsb and cache maintenance operations to flush to the point of coherence and invalidate the icache?

Thanks,

Ben


>  			pr_warning("GDB: sw_bp_insert write failed at GVA 0x%llx",
>  				   (unsigned long long)addr);
>  			return -1;
>  		}
>  
>  		gdb.sw_bp[i].addr   = addr;
> -		gdb.sw_bp[i].orig_byte = orig;
>  		gdb.sw_bp[i].refs   = 1;
>  		gdb.sw_bp[i].active = true;
>  		return 0;


