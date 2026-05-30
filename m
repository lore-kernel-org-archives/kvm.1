Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDC2D12EE
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102405; cv=none; b=rKGtKt8XxRoWF8MKcfqnMvK1MZRb/kn+TmlgDeGXn3tZdfLZ5kNiYcQpaU5BRskVAvy6XbO8gO+wYWZIEG+4Mm41n7oOguQxjEHBKXnxE4P4lJcebEuBt80oc5zlVKO55gqaFzCPfc7M5n5j43JdKa4PkhL8fkA8x5LYIt7qBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102405; c=relaxed/simple;
	bh=qpde8EHjaLv/rrT6XwfIhis8MXFJjrUJIfhEEQqpxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im1V+3K1RoA+dRhv+EvP+9rkCVHRYFse4GgOCwnMmcavN9WgCDMe/Yboj0eWPtXPdfaQWSYMs3SAEIiiuVw8BhmWZrpZdPBt2YZrhZU7YuOr9TMhh/G8uYjsaDtKPvfkZHllB56TKsL6q791kJ9pEvP6f/IriFT/ChM3f5yvFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vlg8FAcS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vlg8FAcS"
Message-ID: <1dd5c998-ad2a-47dd-9875-c8fd5db6d374@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780102400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IR+x4vwXkJmNdcGjyBRl1DqKrigG6hgOWj1BEdMSvw=;
	b=vlg8FAcScy8s5VPPdDW7TS5sfsORpUMlmY2PIWrTRFSMvqUaWqNk6AVSyDpy7ZN3OLn89c
	WVhpD8Nqsyy+hXdgNd1bSc2y+t9J2ET7r7eozK+NBsn6s+mMFDZ1YHTM4lN9gyW+JJdRTK
	HUCUBFsAWYaLNyVIhhot30n8kEOdsuA=
Date: Fri, 29 May 2026 17:53:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] crypto: ccp: Fix possible deadlock in SEV init
 failure path
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260528-sev_snp_fixes-v1-2-d67a08151779@meta.com>
 <20260529005119.8CFF11F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260529005119.8CFF11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/28/26 5:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Host kernel panics due to RMP violation when reading `sev_init_ex_buffer` in `sev_write_init_ex_file()`.
> - [High] Memory allocated for `sev_init_ex_buffer` is leaked and leaves the device in a broken state if initialization fails in `__sev_platform_init_handle_init_ex_path()`.
> - [High] Uninitialized kernel memory is allocated and provided to the SEV firmware and disk if the NV initialization file does not exist.
> --
>
> commit 405e31473bcf0fe9d84a37db761b7cf915973108
> Author: Atish Patra <atishp@meta.com>
>
> crypto: ccp: Fix possible deadlock in SEV init failure path
>
> This commit modifies __sev_platform_init_handle_init_ex_path() to pass
> locked=true to rmp_mark_pages_firmware(). This prevents a potential
> deadlock on the sev_cmd_mutex when an rmpupdate fails and attempts to
> reclaim pages during cleanup.
>
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index d1e9e0ac63b60..3d4793e8e34b2 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -1557,7 +1557,7 @@ static int __sev_platform_init_handle_init_ex_path(struct sev_device *sev)
>>   		unsigned long npages;
>>   
>>   		npages = 1UL << get_order(NV_LENGTH);
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a risk of leaking
> uninitialized kernel memory to the SEV firmware and disk?
>
> Earlier in this function, the NV buffer is allocated without zeroing the
> memory:
>
> 	page = alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));
> 	...
> 	sev_init_ex_buffer = page_address(page);
> 	rc = sev_read_init_ex_file();
>
> If the NV initialization file does not exist, sev_read_init_ex_file()
> handles the -ENOENT error and returns 0 without reading any data, leaving
> the 32KB buffer filled with uninitialized kernel memory. This buffer is
> then provided to the SEV firmware.
>
> Later, when state changes occur, sev_write_init_ex_file() writes this memory
> back to the host filesystem.
>
> Should alloc_pages() be called with __GFP_ZERO to prevent this?

Valid findings. The sev_init_ex_buffer should be set to NULL and pages 
should be freed in case of failure in sev_read_init_ex_file.


>> -		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
>> +		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
>>   			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n");
>>   			return -ENOMEM;
> [Severity: High]
> This is a pre-existing issue, but is it possible this error path leaves the
> device in a broken state?
>
> If the page state transition fails, the function returns an error without
> freeing the buffer or resetting sev_init_ex_buffer to NULL. Because it is a
> static global, subsequent initialization attempts will return 0 immediately:
>
> 	if (sev_init_ex_buffer)
> 		return 0;
>
> This bypasses the file reading and the required firmware page state
> transition, passing an improperly initialized, host-owned buffer to the
> firmware during the INIT_EX command.
>
> Could this permanently break SEV initialization until the system reboots?

I will add the fix as well for this along with the above one.


> [Severity: Critical]
> This is also a pre-existing issue, but will reading from sev_init_ex_buffer
> trigger a host kernel panic?
>
> Once the sev_init_ex_buffer pages are transitioned to a firmware-owned state
> (RMP private) by rmp_mark_pages_firmware(), they are no longer accessible to
> the host.
>
> Later, sev_write_init_ex_file() is called to save the NV memory back to disk
> and invokes kernel_write() using sev_init_ex_buffer as the buffer.
>
> Since there is no code to reclaim the pages back to a host-accessible state
> before this VFS write operation, won't the host CPU's attempt to read from
> sev_init_ex_buffer trigger a Page Fault with the RMP bit set?

As per my understanding that is not correct. A host cpu write to 
firmware-owner state would result in RMP #PF but read would not raise a 
fault. I confirmed that with loading ccp with init_ex_path and kvm_amd 
as well.

>>   		}
