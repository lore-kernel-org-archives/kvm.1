Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A454654;
	Tue,  9 Jun 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047599; cv=none; b=lfPcT2YELU69HXQvEhApfB0nAhGltS51lsx/BEhUt3L9N34Kp/wcDhmaYd36eOWByz7STpTa/n+KkpW5BPQ4DRjpGFsn6lgdUNMe0fBe3IV7+b6jpPVDLG5l7dAgfSaUx9ao5r+G+nu/tq2seiLRGWt6EkXYJ3dmyJrvcfcfUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047599; c=relaxed/simple;
	bh=jXoX8kHsxTkpkszOVa2HH4vyPwIOsZj8uMNa5sttN1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rz5OPlxuWOX/q3wG2Uvje0yM1/maje6EKt0zPtpF/V3NU5CyLsTRj92lhaRf7MmMP+bXA/QHcZ8Owc7OIrOxs80nHAc3/AN3n+F5d2v+DeNzAgh7kpG2R4SeMqwlwKWfHCS8mXcrYBfVLWEgHYl86pxTdS1/ucPH0RwPjQNrIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fa2g7uA4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fa2g7uA4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=b7kXFBbKNObo56DfTljiu9Pfh/bAzB9MuzypdnWNDDA=; b=Fa2g7uA4IubffrruqBpJWMWO/Q
	mm/mJk0tcZMrqtK6rTOMfEGmzbBoWN0daRp/hU60H+WHxWaSHa2CRDPf3s8fLgHoH4XWE/HVRBBac
	u6iXnmSyvENs9JPGoaNmR4nJmynQQs0Osqk49ze85V/Nu+TslfCYnBVcxxshPC/q6cYeJ2bGMgFhD
	FYbA1nvsi/idpPSld72QM73tuFgMGuwrbvNDlJlHXYuE4WRWLn9bgOWL8kPvoL86fdFslRBCuzjB3
	88JLQn3g1XItGqHvcBNQdJmTRGcRXvWEAPd5LJIrAV39G1nAIyCNRS4VwM8CY1ny2Efuq0qvBx1ia
	eteSIV6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX5ps-00000006VZd-2m5z;
	Tue, 09 Jun 2026 23:26:20 +0000
Message-ID: <339b6b8f-ac3d-4b49-acf1-9d846fc1db4a@infradead.org>
Date: Tue, 9 Jun 2026 16:26:19 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/34] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Juergen Gross <jgross@suse.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Sascha Bischoff <Sascha.Bischoff@arm.com>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kselftest@vger.kernel.org
References: <20260608145455.89187-1-dwmw2@infradead.org>
 <20260608145455.89187-9-dwmw2@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260608145455.89187-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/8/26 7:47 AM, David Woodhouse wrote:
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index 5e3805820010..167aa4140d30 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -243,7 +243,10 @@ Returns:
>  Specifies the guest's TSC offset relative to the host's TSC. The guest's
>  TSC is then derived by the following equation:
>  
> -  guest_tsc = host_tsc + KVM_VCPU_TSC_OFFSET
> +  guest_tsc = ((host_tsc * tsc_scale_ratio) >> tsc_scale_bits) + KVM_VCPU_TSC_OFFSET
> +
> +The values of tsc_scale_ratio and tsc_scale_bits can be obtained using
> +the KVM_VCPU_TSC_SCALE attribute.
>  
>  This attribute is useful to adjust the guest's TSC on live migration,
>  so that the TSC counts the time during which the VM was paused. The
> @@ -251,44 +254,100 @@ following describes a possible algorithm to use for this purpose.
>  
>  From the source VMM process:
>  
> -1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (tsc_src),
> +1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_src),
>     kvmclock nanoseconds (guest_src), and host CLOCK_REALTIME nanoseconds
> -   (host_src).
> +   (time_src) at a given moment (Tsrc).
> +
> +2. For each vCPU[i]:
> +
> +   a. Read the KVM_VCPU_TSC_OFFSET attribute to record the guest TSC offset
> +      (ofs_src[i]).
>  
> -2. Read the KVM_VCPU_TSC_OFFSET attribute for every vCPU to record the
> -   guest TSC offset (ofs_src[i]).
> +   b. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scaling
> +      ratio (ratio_src[i], frac_bits_src[i]).
>  
> -3. Invoke the KVM_GET_TSC_KHZ ioctl to record the frequency of the
> -   guest's TSC (freq).
> +   c. Use host_tsc_src and the scaling/offset factors to calculate this
> +      vCPU's TSC at time Tsrc:
> +
> +      tsc_src[i] = ((host_tsc_src * ratio_src[i]) >> frac_bits_src[i]) + ofs_src[i]
> +
> +3. Invoke the KVM_GET_CLOCK_GUEST ioctl on the boot vCPU to return the KVM
> +   clock as a function of the guest TSC (pvti_src). (This ioctl may not
> +   succeed if the host and guest TSCs are not consistent and well-behaved.)
>  
>  From the destination VMM process:
>  
> -4. Invoke the KVM_SET_CLOCK ioctl, providing the source nanoseconds from
> -   kvmclock (guest_src) and CLOCK_REALTIME (host_src) in their respective
> -   fields.  Ensure that the KVM_CLOCK_REALTIME flag is set in the provided
> -   structure.
> +4. Before creating the vCPUs, invoke the KVM_SET_TSC_KHZ ioctl on the VM, to
> +   set the scaled frequency of the guest's TSC (freq).
> +
> +5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_dst) and
> +   host CLOCK_REALTIME nanoseconds (time_dst) at a given moment (Tdst).
> +
> +6. Calculate the number of nanoseconds elapsed between Tsrc and Tdst:
> +
> +   ΔT = time_dst - time_src
> +
> +7. As each vCPU[i] is created:
> +
> +   a. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scaling
> +      ratio (ratio_dst[i], frac_bits_dst[i]).
> +
> +   b. Calculate the intended guest TSC value at time Tdst:
> +
> +      tsc_dst[i] = tsc_src[i] + (ΔT * freq[i])
>  
> -   KVM will advance the VM's kvmclock to account for elapsed time since
> -   recording the clock values.  Note that this will cause problems in
> -   the guest (e.g., timeouts) unless CLOCK_REALTIME is synchronized
> -   between the source and destination, and a reasonably short time passes
> -   between the source pausing the VMs and the destination executing
> -   steps 4-7.
> +   c. Use host_tsc_dst and the scaling factors to calculate this vCPU's
> +      raw scaled TSC at time Tdst without offsetting:
> +
> +      raw_dst[i] = ((host_tsc_dst * ratio_dst[i]) >> frac_bits_dst[i])
> +
> +   d. Calculate ofs_dst[i] = tsc_dst[i] - raw_dst[i] and set the resulting
> +      offset using the KVM_VCPU_TSC_OFFSET attribute.
> +
> +8. If pvti_src was provided, invoke the KVM_SET_CLOCK_GUEST ioctl on the boot
> +   vCPU to restore the KVM clock as a precise function of the guest TSC.
> +
> +9. If KVM_SET_CLOCK_GUEST was not available or failed (e.g. because the
> +   master clock is not active), fall back to the KVM_SET_CLOCK ioctl,
> +   providing the source nanoseconds from kvmclock (guest_src) and
> +   CLOCK_REALTIME (time_src) in their respective fields. Ensure that the
> +   KVM_CLOCK_REALTIME flag is set in the provided structure.
> +
> +   KVM will restore the VM's kvmclock, accounting for elapsed time since
> +   the clock values were recorded. Note that this will cause problems in
> +   the guest (e.g., timeouts) unless CLOCK_REALTIME is synchronized between
> +   the source and destination, and a reasonably short time passes between
> +   the source pausing the VMs and the destination resuming them.
> +   Due to the KVM_[SG]ET_CLOCK API using CLOCK_REALTIME instead of
> +   CLOCK_TAI, leap seconds during the migration may also introduce errors.
> +
> +4.2 ATTRIBUTE: KVM_VCPU_TSC_SCALE
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Documentation/virt/kvm/devices/vcpu.rst:327: ERROR: Inconsistent title style: skip from level 2 to 4.

4.2 ATTRIBUTE: KVM_VCPU_TSC_SCALE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Established title styles: =/= = - [docutils]

Change this "underline" to use "--------------------------" (for whatever
width is needed) and also add the same to the 4.1 heading.

> +
> +:Parameters: struct kvm_vcpu_tsc_scale
> +
> +Returns:
> +
> +	 ======= ======================================
> +	 -EFAULT Error reading the provided parameter
> +		 address.
> +	 -ENXIO  Attribute not supported (no TSC scaling)
> +	 -EINVAL Invalid request to write the attribute
> +	 ======= ======================================


-- 
~Randy

