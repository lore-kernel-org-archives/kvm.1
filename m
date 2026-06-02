Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FC37A4AB
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437534; cv=none; b=cTS/a6TvjHDXAzpXftoTtRvijcUuyphYZs42kOgWvEZYocAJcfvXhq7ek14v919mPHAoThhvZGVAL+G0DhxEsk5s2HTyoNIBRRcwWNYDULXeqoDS9NTE6daWFtmEY4rxroZHliDXglLAD2EaFphFYblFMPLOZzPAvLhbMtcVLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437534; c=relaxed/simple;
	bh=RBZUgb63t5P8qKXlNGcGwz87NI64X8PI0EJfAhtXEQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8Iu9OMlQTp/IrHJtg4Pcnox7GwmMaPIBtYCrJcA/HqRXfF7jE9U0XkUw5zNDPs5ff3ohDNHcrd0rfB9tVEfc6UxUSXzwnHYQwpGaGCiu5lxdm+HoaR7KIEwLMCYfcRx9JMsnJzEWNFK9YWMKNiRc0y0ffnUMTkTDvnyxrLyAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pw0JdRSv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pw0JdRSv"
Message-ID: <947f8b24-b5de-4e40-8d27-0f85d1fd6547@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780437531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WG/pFlpqjtidmPWmvsZ/O2ImctXvqcM8DPS3bnhtjfw=;
	b=Pw0JdRSv+Zv+WhTmFBkzZRoiteMVy9ycBQvaRFmSs/YmCi+6NFKL7NrUR5+qvYzjj2Mdu4
	1jW0Gswo3nFQ7qnj+k88c6CGeKDvAn1FVPiOqZmQTY92BMNvLKDsN6VJyOkU7zasmLTSTM
	U0/dFtR1Wkt6l0QcjWzWDZJBExT5WgY=
Date: Tue, 2 Jun 2026 14:58:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260601-sev_snp_fixes-v2-3-611891b28a86@meta.com>
 <20260601234159.0961C1F00898@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260601234159.0961C1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/1/26 4:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Failure in snp_prep_cmd_buf permanently leaks the command buffer active state in __sev_do_cmd_locked, deadlocking the SEV interface.
> - [High] sev_init_ex_buffer is allocated without zeroing, leaking uninitialized kernel memory to the host filesystem.
> - [High] Unhandled allocation failure for dev_data->output in spdm_ctrl_alloc leads to passing a null physical address to the PSP firmware.
> - [High] Retrying SEV-TIO commands after buffer expansion uses stale, freed physical addresses, leading to RMP violations.
> - [High] Bounce buffer memory is permanently leaked when firmware page transitions fail during legacy SEV command preparation.
> --
>
> commit 1396d09c5ba264e4a091f5fa101bb062c384525c
> Author: Atish Patra <atishp@meta.com>
>
> crypto: ccp: Fix possible deadlock in SEV init failure path
>
> __sev_platform_init_handle_init_ex_path() called
> rmp_mark_pages_firmware() with locked=false but while the parent
> function of init_ex_path already acquired the sev_cmd_mutex.
> In case of a rmpupdate failure for any page after the first, the cleanup
> path would invoke reclaim pages which would result in a deadlock in
> sev_do_cmd.
>
> Pass locked=true to honor the lock status of the parent function.
>
> Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")
> Reported-by: Chris Mason <clm@meta.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Atish Patra <atishp@meta.com>
>
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index d1e9e0ac63b60..3d4793e8e34b2 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -1557,7 +1557,7 @@ static int __sev_platform_init_handle_init_ex_path(struct sev_device *sev)
>>   		unsigned long npages;
>>   
>>   		npages = 1UL << get_order(NV_LENGTH);
>> -		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
>> +		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
>>   			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n");
>>   			return -ENOMEM;
>>   		}
> [Severity: High]
> This is a pre-existing issue, but does this allocation leak uninitialized
> memory?
>
> Looking at __sev_platform_init_handle_init_ex_path() in the same file:
>
> drivers/crypto/ccp/sev-dev.c:__sev_platform_init_handle_init_ex_path() {
>      ...
>      page = alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));
>      ...
> }
>
> If the NV file does not exist, sev_read_init_ex_file() returns 0 without
> writing any data. This leaves the 32KB buffer filled with uninitialized
> kernel memory before transitioning to firmware state. When
> sev_write_init_ex_file() later writes this buffer to the host filesystem,
> could this persist kernel heap contents to disk if the firmware did not
> fully overwrite it?
fixed in PATCH 4.
> [Severity: High]
> This is a pre-existing issue, but can this error path leave the command
> buffer permanently active?
>
> drivers/crypto/ccp/sev-dev.c:__sev_do_cmd_locked() {
>      ...
>      ret = snp_prep_cmd_buf(cmd, cmd_buf, desc_list);
>      if (ret) {
>          dev_err(sev->dev, "SEV: failed to prepare buffer...");
>          return ret;
>      }
>      ...
> }
>
> Since sev->cmd_buf_active or sev->cmd_buf_backup_active were set to true
> before this call, returning directly here bypasses resetting those flags.
> Would this cause subsequent commands to fail with -EBUSY and lock up the
> interface?
>
> [Severity: High]
> This is a pre-existing issue, but does this error path leak the mapped
> bounce buffers?
>
> drivers/crypto/ccp/sev-dev.c:snp_prep_cmd_buf() {
>      ...
>      if (sev_cmd_buf_writable(cmd)) {
>          if (rmp_mark_pages_firmware(__pa(cmd_buf), 1, true))
>              return -EFAULT;
>      }
>      ...
> }
>
> If this fails, it returns -EFAULT without calling
> snp_unmap_cmd_buf_desc_list(), which appears to leave the mapped command
> descriptors unmapped.
>
> Similarly, in snp_map_cmd_buf_desc():
>
> drivers/crypto/ccp/sev-dev.c:snp_map_cmd_buf_desc() {
>      ...
>      if (rmp_mark_pages_firmware(*desc->paddr_ptr, npages, true)) {
>          pr_warn("Error moving pages to firmware-owned state...");
>          return -EFAULT;
>      }
>      ...
> }
>
> If the firmware transition fails for an individual bounce buffer, the newly
> allocated page isn't freed before returning -EFAULT. Could both of these
> paths result in permanent memory leaks?
>
> [Severity: High]
> This is a pre-existing issue, but does this validation correctly check the
> output buffer?
>
> drivers/crypto/ccp/sev-dev-tio.c:spdm_ctrl_alloc() {
>      ...
>      dev_data->output = sla_alloc(dev_data->output_len, true);
>
>      if (IS_SLA_NULL(dev_data->req) || IS_SLA_NULL(dev_data->resp) ||
>          IS_SLA_NULL(dev_data->scratch) || IS_SLA_NULL(dev_data->dev_ctx)) {
>      ...
> }
>
> The check examines dev_ctx instead of the newly allocated output. If the
> output allocation fails, dev_data->output will be SLA_NULL (physical frame
> number 0). Will returning success here cause the PSP firmware to use
> physical page 0 as an output buffer and trigger an RMP violation?
>
> [Severity: High]
> This is a pre-existing issue, but does retrying the command use stale
> physical addresses?
>
> drivers/crypto/ccp/sev-dev-tio.c:sev_tio_do_cmd() {
>      ...
>      rc1 = sla_expand(&dev_data->output, &dev_data->output_len);
>      ...
>      rc = sev_do_cmd(cmd, data, psp_ret);
>      ...
> }
>
> When sla_expand() allocates a new buffer and frees the old one, dev_data
> pointers are updated. However, the data pointer passed to sev_do_cmd()
> comes from the caller and contains a by-value copy of the old spdm_ctrl
> fields. Will retrying the command pass the old, freed physical addresses
> to the PSP firmware?
>
Above issues require a bit detailed investigation to see if it is a 
false positive.
These are completely unrelated to this patch as well.
Does these needs to be addressed before merging ?


