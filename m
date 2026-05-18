Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC4494A15
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123304; cv=none; b=n3FUSWg/cQShYWdyjRsAkM8JrrXdYxRLXqri5u6JFRUol6F7xXPer0R/+amNjNSOAX3ABhgbp5eVVo8AgaFpUrwjJ5MXttiVBq5V+PydVCzlw4gnEWTvU/4/fT5T9fIfIBPMH8RdBmcWpurIzjoXPysJmoHN6oM1SZ2gJOP89wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123304; c=relaxed/simple;
	bh=uLzwi/WCQNnI3a9r0Mor6iinE3d+0njf87UPy8a7WLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGbA+HfDFodkUkpl2b9Dg8GvGCICMC3ifuf1Zu1J8SBYkodeivlfO3ta/uiwJn77PiVoUwQ7nKUYkdvTUTrrxihPmyVj+1OExclrM7eQ6c47iU38TxB0+Km7olRm847KklWWeAVSLhvm2/u7jKZ+JRSqF87apwmjl48SFLB8xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XN8JeS87; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XN8JeS87"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HNI4d51449052
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:55:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZLY9yfLbRBjpxy+2SZZ2QJ1skamsrrS9MpjOO7Diwus=; b=XN8JeS877jEd
	EB+ZxD27YIsRCiVSeSY3lAZcZeFfFdxQF+qfF4CTddtmCk+K2U3049kfL4nFlmH7
	SL3cBbF1DhT0/mKioDrKiQNuR8X/wF49z9HY/X3ZO25Px96ZXMmw7UGd0yozk487
	BHNo/ja8XUZxE3NcwBWwhA5pmfG/2rItk5Uheyxl/ozsVbHucAmJ+60On9h5ljfT
	gsTgOrcXmoUn6KVcUVg0XrKksIyHrs9ANc/am9s32d/a/zIvHdMsuKPx/fJ1J80A
	0nwLeVfHhVfOp9GSZfmcFsGcbp6H2Lm7tfODKhxJrvgT4pMpk4jYBf7t481ofi8A
	u89jy8cs2A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e797hpwnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:54:59 -0700 (PDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so5002207eec.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123299; x=1779728099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLY9yfLbRBjpxy+2SZZ2QJ1skamsrrS9MpjOO7Diwus=;
        b=gWxvquqZTQ1XWaJwFDCIWOkK60F7d9of9zz3/pEbzanUbuEshK6Rlc5Sa7bf8QPEuR
         IQCL4wJyE6UciwF8n/ZT+hbQSLsAYuzpEt81qa7Rz/XijX3QU4NNwKa07r0e88ZlnDMq
         1afQ1xBKcJ9v/vGFIU1ZNUcAuDOXcYySZp+yReoLxje5fx36y4YD0o50jUgWkyffrf3K
         oV9Kea0wfmeQdjKJeA2+pam2HG7Xi5aCbRPN3aE5HZTNtnrMZZLBFMZIrfDUkVMVetQq
         Mp1349cnzFgLDClMKn9nq+4DZdQP2xP+hswNF9jGV70fUb9pDhqGAQNtZBMYw0Ybw2Uj
         gkdg==
X-Forwarded-Encrypted: i=1; AFNElJ8ABzp1NC6Ptt59i0LOJb+VuQOXcsgg14quYd3kzVrYwBEzqQxISYPKbZF3vjFhQOhepX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9bDQUbAe35e+P5KoFwYhJoxrkYshLExqkjtfwQkhDPryUIQz
	wea7Yi5XjQRXPaRE3HC+jDdw55lU58LTZlKyB1Ex3azzxUXa5xGKaNfwhTKXCqASN8hb4xx3aBW
	6szwtQNDP6cyE81vyi72HvRY8MgAf4KeXhkOwugCTKxGJbCvJALcB
X-Gm-Gg: Acq92OEG7KxqKojX/qgCUlOZiWqCVQO5kD/18lkX4ekcRx4ei8etLggpxenbB0J6sEf
	Ar7uYlaNwzdQwWIjkK1FVmU6/F70G4Cp8j3D3+khqPg0h3Sw4bqz4G69ksZ2NPs7LoSAmHrpOlS
	ySgyAUyUNH/f7q6DfK043SbFfJkrry5SIRnBw3TNtM7kgGEQvqfLeN5Xff6FgR35auBdNrtiBsm
	KIBdVShFeE+i/T/F5lmuPIvf6CNRw/7Dxol4MMPJUwPtrEMAB19MS7HR84FG7yP/kFCoq0QAc1s
	PJedNYy9R5Qyygg09gO8hCQN4umGFusKe9ceQemFJA8G3aI8OtM+O9fHF/tXrH2SGL97It9abuD
	CmqeJ3kULj9UmGJvQ5IYGCrgKCG/Y6w==
X-Received: by 2002:a05:693c:2c8e:b0:2ee:f85:ec3c with SMTP id 5a478bee46e88-303986b0490mr6401858eec.30.1779123298666;
        Mon, 18 May 2026 09:54:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8e:b0:2ee:f85:ec3c with SMTP id 5a478bee46e88-303986b0490mr6401843eec.30.1779123298106;
        Mon, 18 May 2026 09:54:58 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm15797561eec.15.2026.05.18.09.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:54:57 -0700 (PDT)
Message-ID: <e90b20b7-3189-4395-b2a8-6391b5958936@meta.com>
Date: Mon, 18 May 2026 17:54:52 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-7-mattev@meta.com>
 <20260501171919.42659174@shazbot.org> <20260505105822.GC11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260505105822.GC11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfX4amNZ/zypJOi
 X42DZKUCUjpGqhLbnhenUta+Gdt3XVeplf1YroLfA4KP8oG0Yv1y5u+6aVK90b6P8OyXSczU6CD
 oFg/MECv3VFPbClO+ihDT5dvBMesRoFGIbITOm4bnVDFbt5kcceuWkvhT5AC7jNmTcpZNmAIemd
 bNrz/iEglR7BAZjjioFUdzmjhgtIiAVCi8Tu4eCJgdMxKa8UmzqyZdzzLuqz8yBtK2iMXZjeErJ
 Awkr7WeNH3YFzMeX5Uxz0G+KhTrQ628eLrwQQHY2nPpXZYepwHnxDdJmaSYW581QNjguFl9/lLG
 LEPt/AtJnvExcSJ+Qsu2QKFIWfdn49gqvV7kFG1TL1ONmbLNID3KQp3wOwus8syS21/JqE7uTDL
 rjhmgzo72e62mTv36iFidaOZUL5ZkmNtAGmjwRCcjekPXbljYP3pkxtwBXCUsKHqAgLcQhXxjEB
 6XMswYcm699ANMMCSRA==
X-Proofpoint-GUID: yhKvtvHrT5LwXX7rnCmCZYMCOwO-F13-
X-Authority-Analysis: v=2.4 cv=VscTxe2n c=1 sm=1 tr=0 ts=6a0b4463 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=GEBLkO6eNKYXaKtmIbgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: yhKvtvHrT5LwXX7rnCmCZYMCOwO-F13-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01

Hi Leon, Alex,

On 05/05/2026 11:58, Leon Romanovsky wrote:
> 
> On Fri, May 01, 2026 at 05:19:19PM -0600, Alex Williamson wrote:
>> On Thu, 16 Apr 2026 06:17:49 -0700
>> Matt Evans <mattev@meta.com> wrote:
>>
>>> Previously, vfio_pci_zap_bars() (and the wrapper
>>> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
>>> calls of vfio_pci_dma_buf_move().
>>>
>>> This commit replaces them a unified new function,
>>> vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
>>> and the unmap_mapping_range(), making it harder for callers to omit
>>> one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
>>> the write memory_lock before zapping, and adds a new
>>> vfio_pci_unrevoke_bars() for the re-enable path.
>>>
>>> However, as of "vfio/pci: Convert BAR mmap() to use a DMABUF" the
>>> unmap_mapping_range() to zap is entirely redundant for plain vfio-pci,
>>> since the DMABUFs used for BAR mappings already zap PTEs when the
>>> vfio_pci_dma_buf_move() occurs.
>>>
>>> One exception remains as a FIXME: in nvgrace-gpu, some BAR VMAs
>>> conditionally use custom vm_ops, which have not moved to be backed by
>>> DMABUFs.  If these BARs are mmap()ed, the vdev enables the existing
>>> behaviour of unmap_mapping_range() for the device fd address space.
>>
>> What's the plan here?  Is this a temporary FIXME or a place to prove
>> that dmabuf for mmap works beyond the core use case?

The larger picture is that I havne't converted the nvgrace-gpu driver to 
use DMABUFs for its custom mmap/fault handler code.  (It's not 
straightforward to test, so I don't want to hack that.)

This FIXME is added to vfio_pci_zap_revoke_bars(), saying that for this 
specific sub-driver (or any others that do custom mmap) they still need 
to flag so that this wrapper still performs the unmap_mapping_range().

>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>> ---
>>>   drivers/vfio/pci/nvgrace-gpu/main.c |  5 +++
>>>   drivers/vfio/pci/vfio_pci_config.c  | 30 ++++++--------
>>>   drivers/vfio/pci/vfio_pci_core.c    | 62 +++++++++++++++++++----------
>>>   drivers/vfio/pci/vfio_pci_priv.h    |  3 +-
>>>   include/linux/vfio_pci_core.h       |  1 +
>>>   5 files changed, 62 insertions(+), 39 deletions(-)
>>>
>> ...
>>> @@ -1229,7 +1228,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>>>   	if (!vdev->reset_works)
>>>   		return -EINVAL;
>>>   
>>> -	vfio_pci_zap_and_down_write_memory_lock(vdev);
>>> +	vfio_pci_lock_zap_revoke_bars(vdev);
>>>   
>>>   	/*
>>>   	 * This function can be invoked while the power state is non-D0. If
>>> @@ -1242,10 +1241,9 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>>>   	 */
>>>   	vfio_pci_set_power_state(vdev, PCI_D0);
>>>   
>>> -	vfio_pci_dma_buf_move(vdev, true);
>>
>> This seems subtle enough to be troublesome.  I wonder if Leon didn't
>> intentionally place the dmabuf revoke after the device is in D0 to
>> allow the driver to interact with the device.
> 
> My intention was to place vfio_pci_dma_buf_move() as close as possible to
> pci_try_reset_function(), so the device is known to be fully operational
> at that point. It looks like calling it after the transition to D0 is the
> right ordering.

Thanks for that, I had missed that need to have D0 at the time of the 
revoke.

Getting the lock in the existing place (before D0 set) but doing a 
separate vfio_zap_revoke_bars() here (replacing the bare move) seems 
right, though for the sub-drivers which still need the zap (nvgace-gpu) 
then the unmap_mapping_range() would happen after the D0 now.  I believe 
this is OK, but I wanted to flag that difference.

Many thanks,


Matt

