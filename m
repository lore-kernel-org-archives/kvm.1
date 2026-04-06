Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6F30EF86;
	Mon,  6 Apr 2026 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449536; cv=none; b=YIOqK/YRr1ojfBrPrfBsR/7NLPlKzxcERxabFcdQ2JXG+lnnD6i3zpS8FSmkl3bF/nqCiPwUlD67YFdwmnoyeDfMxtyZRCt+w8yjle6omR9xkXUe7g/wMPqmojfy4xV/qisio/BYGXeiIfUnSx/BWMWWDgROYicTsEZ5K0cEwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449536; c=relaxed/simple;
	bh=QTIo9VGHz2wxJFdeg6IU5XJtReN5xn5GrLbtzmLjYuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz+6EB8/skHhMAZDl0BApoZgqCfwv+ZLYyQsch6R3B6ESp5gwv+XCNH+pgjWPH3hdewchcge2Guzk7yvliBmKphJW9ImeencEWq7mSx7J+Huo9VsUJJ6EpJR79MXL0N1U1zstgxG2AZmIlziTR26nfgiBAVCYQl6bQwzdB91f7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gfg5nhOG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gfg5nhOG"
Received: from [192.168.0.9] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD30820B710C;
	Sun,  5 Apr 2026 21:18:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD30820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775449110;
	bh=B3diYHHGFQ5W0wbem6CFVCqplPIswsX1zrqcobDFojs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gfg5nhOG3DXzUjyf5Mct9OtDkjEPW9J8TLfEbUwO+vgA/fksEievinNPSuF0jyHy/
	 CHoRd8jJe2hICR2N/VnJAZJzV5IwY1NaKfwX+TmCP534GwZRYiDzSUGN074dKwweei
	 pjpPVxrEzKgZp8NxiqxnrVZ1S506JsY64nJZT0CM=
Message-ID: <3e8a38f3-d309-4bd6-8378-260079aa7024@linux.microsoft.com>
Date: Mon, 6 Apr 2026 09:48:25 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt
 trigger path
To: Alex Williamson <alex@shazbot.org>
Cc: "Gupta, Nipun" <nipun.gupta@amd.com>, nikhil.agarwal@amd.com,
 pieter.jansen-van-vuuren@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
 <e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
 <20260401122254.363d93c2@shazbot.org>
 <12005a02-a1cd-46ca-8782-c727a7d5e5c6@linux.microsoft.com>
 <20260402081632.554fa467@shazbot.org>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260402081632.554fa467@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02-04-2026 19:46, Alex Williamson wrote:
> On Thu, 2 Apr 2026 10:14:24 +0530
> Prasanna Kumar T S M <ptsm@linux.microsoft.com> wrote:
> 
>> On 01-04-2026 23:52, Alex Williamson wrote:
>>> On Wed, 1 Apr 2026 15:11:17 +0530
>>> "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
>>>    
>>>> On 20-03-2026 15:49, Prasanna Kumar T S M wrote:
>>>>> Add validation to ensure MSI is configured before accessing cdx_irqs
>>>>> array in vfio_cdx_set_msi_trigger(). Without this check, userspace
>>>>> can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
>>>>> with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
>>>>> ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.
>>>>>
>>>>> The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
>>>>> sets config_msi to 1 only when called through the EVENTFD path. The
>>>>> trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
>>>>> done, but there was no enforcement of this call ordering.
>>>>>
>>>>> This matches the protection used in the PCI VFIO driver where
>>>>> vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.
>>>>>
>>>>> Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
>>>>
>>>> Acked-by: Nipun Gupta <nipun.gupta@amd.com>
>>>
>>> It's an improvement, but I think it also highlights that interrupt
>>> setup for vfio-cdx devices is racy.  I think it should adopt a mutex on
>>> the vfio_cdx_device that is acquired with a guard in
>>> vfio_cdx_set_irqs_ioctl().  That would make config_msi stable for this
>>> test.  Thanks,
>>>
>>> Alex
>>
>> This patch is fixing a specific problem. User space can make VFIO_*
>> calls in a specific order to trigger NULL pointer access. This will not
>> get fixed with a mutex.
> 
> I'm not saying the fix is wrong, I'm saying it's incomplete.  This
> fixes the specific case where config_msi is not set prior to the ioctl,
> but it doesn't consider concurrency where config_msi may be set when
> tested, but race with a call to vfio_cdx_msi_disable().  I think the fix
> needs both the validation of config_msi and serialization via a mutex
> such that the test remains valid through the whole ioctl path.  Thanks,
> 
> Alex

Thanks for the suggestion. Yes, the concurrency issue exists. It exists 
even before this patch and it has to be fixed.

The CDX folks will be able to do this faster than me as they have deep 
expertise on this.

Thanks,
Prasanna Kumar
