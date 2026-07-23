Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F9403AE8
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845164; cv=none; b=gI4vBHQ2A/Oi4lhgdF6emY6U/XcbXQ9K60Km8FH1sbnSEQY4rJaKu4oDT1jBTmwL1NzKTCbiYpHNwtMPcHMki5Vp/wLiuoMBkkI0ZTnspSNrRHJzqM1VZzR2c/jSn9UHP3t+AsxkiChVR0KUu2oDVOg1Yj6I+PL85ucHEd9ZOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845164; c=relaxed/simple;
	bh=vbCpfCx3Aq7wfU9CTsT5wSlReo5n7+uxb5BNMsNykao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYEMVAhGvo//qOW2bZA+0uhGnFd3F8xcDY6mtsHXug1Fx7/k+ZUVWAkvv7dgO6MnBMm7+uNGUGA6R9bgD+lrWqlMZwQcOyYDlz0PYcw81x6FV/sMuT172MTsKbDLS0dXf1P7enPJONtg1vac9++OPcywyyxMe5WDV38jb6x6zF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1hEm5gq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1hEm5gq"
Message-ID: <cebd1045-5dd7-4f35-8750-9c39790ceae9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784845145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0SzsDUN/BFXoWvc6OI68QQ0aGQFC3X7Tv8gtb7Mzg8=;
	b=o1hEm5gqbSFXjNQ4yIfcWqVF8F2VgF7agEYdG4EH8wmp+G1vDgDZuukjZsNrRRZEMTLDn8
	e2RghIzHx5oniMfYsrV4kpaicQc52zsfUQFC/Lj9EgU93DFRi4xAAwgenWevULM+oLxJIs
	Z9M3QnjiLFjyIalbt7oDxrbrLyVCbiY=
Date: Thu, 23 Jul 2026 15:18:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org,
 amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
 chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
 dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
 jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
 kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com,
 lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com,
 parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com,
 pratyush@kernel.org, rananta@google.com, rientjes@google.com,
 rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
 schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com,
 vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
References: <20260714151505.3466855-1-vipinsh@google.com>
 <2c03ac97-60a6-4352-a942-27dcebae8d22@linux.dev>
 <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
 <20260720163452.GC1191959.vipinsh@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260720163452.GC1191959.vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/20/26 10:08 AM, Vipin Sharma wrote:
> On Thu, Jul 16, 2026 at 06:22:07PM -0700, Yanjun.Zhu wrote:
>> On 7/16/26 4:24 PM, Yanjun.Zhu wrote:
>>>
>>> On 7/14/26 8:14 AM, Vipin Sharma wrote:
>>>> Testing
>>>> -------
>>>>
>>>> Tested using VFIO Live Update selftests in both QEMU and bare-metal
>>>> environment (Intel DSA PCIe device).
>>> I want to make tests VFIO Live Update selftests in QEMU. But how to
>>> select a PCIe device?
>>>
>>> what device do the PCI ID 0000:00:04.0 and 0000:6a:01.0 mean in the
>>> following testcase?
> Sorry, this was my copy-paste mistake when combining things from both
> qemu and baremetal. You only need one device not two separate ones.
>
> For testing using QEMU, you can use QEMU PCI test device.
>
>    -device pci-testdev
>
> In VM, use `lspci` command to find the BDF of the PCI device. It will show
> output like:
>
>    00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
>
> Then prefix the domain (generally, 0000) to the BDF and use the testing
> commands.
>
> `0000:6a:01.0` was the BDF of the Intel DSA device on my host. I
> incorrectly mixed two devices during my copy-paste.
>
> Limitation of qemu pci-testdev is that it does not have the DMA
> capability. I used physical host with Intel DSA to verify that the
> device performing DMA during live update gets reset.
>
>> In my qemu,
>>
>> 00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest
>> Service
>>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
>> <MAbort- >SERR- <PERR- INTx-
>>      Interrupt: pin A routed to IRQ 20
>>      Region 0: I/O ports at d040 [size=32]
>>      Region 1: Memory at f0400000 (32-bit, non-prefetchable) [size=4M]
>>      Region 2: Memory at f0800000 (32-bit, prefetchable) [size=16K]
>>      Kernel driver in use: vboxguest
>>      Kernel modules: vboxguest
>>
>> I am wondering if the above pci device can work well with this patch set or
>> not.
> I think you should be able to test Live Update with any PCI device which
> can be attached vfio-pci driver.
>
> `vfio_pci_liveupdate_kexec_test` will initiate DMA if the VFIO selftest
> framework has the driver for the passed device (Intel DSA) otherwise it
> will just skip over the DMA flow and do the remaining things.

Thanks a lot. I'll run some tests with QEMU's `pci-testdev`.

If I understand correctly, when using `pci-testdev`, only the DMA test 
case is expected not to work, while all the other test cases should work 
correctly.

Yanjun.Zhu

>
> Let me know if you still face some issue in running Live Update, I will
> be happy to provide more details.
>
> Thanks
> Vipin
