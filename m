Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8D1A8F97
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774685738; cv=none; b=Xp0+qJiIRTcA+SZp63idd3P0yn41z/IzsQ0nCjbjAc4AVM/JzpD5dxrhoyRzG3uAJXDSTbrNnS/PlzDsymW27y/CamcTHV5ehgKoa4VGGXdKA7+n05Dj8pKuRqwq8YIDm/Wv8h0Ry7ASFEQy+6WRseO8bLiRcCO4ivGlkgVg/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774685738; c=relaxed/simple;
	bh=s7Atd2vqrTKSV6MiiIS0nnvXCRNTYWK7+9Hgc4YaDDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GP2aI/2rjTCINOWCmdhS/we0FtUbKila3wLHucTiwAFL7x0fJTOSRFIVC1OCrCf9LxvHHu5d6EZ/5TCr1zfk53UFVyn2vmcnMY9ylJl9C2mVicuh45M/Pti7Hf8NCO3BDzSMZ9VmajoeLytz9MWD0VxTMOoG8WMwgUBc42FIWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uVvaxKlh; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uVvaxKlh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gi16xqKKiH8svPdgBHAe7YXrbh/cfUb2RRZNQYLS+tg=;
	b=uVvaxKlhbmZJ5N75cpv4b/X6sTd8tYpmOH1XebM6f0NdRuzRSrOMu7PQnGc741raL/Lho72Eu
	GWbwQo5juZadNhlLAFNQYRwiofNlpWj8BxqjP0C1wEKTiyxyGPiBIU/9w2L++BllpXAr9UIeNaf
	ymXEFxyRu+gH21rqHfnC57E=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fjVXd0tBzzKm5B;
	Sat, 28 Mar 2026 16:09:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 5039F4048B;
	Sat, 28 Mar 2026 16:15:30 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 16:15:29 +0800
Message-ID: <7c414c95-72a3-4519-b79b-49dd317c717b@huawei.com>
Date: Sat, 28 Mar 2026 16:15:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/1] vfio/pci: add PCIe TPH device ioctl
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "pstanner@redhat.com" <pstanner@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, Jeremy Linton <Jeremy.Linton@arm.com>
References: <20250916175626.698384-1-wathsala.vithanage@arm.com>
 <20250923180439.GG2547959@ziepe.ca>
 <8f4097bcffaafcf65ec9ee3b709bfc6d70d076e1.camel@arm.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <8f4097bcffaafcf65ec9ee3b709bfc6d70d076e1.camel@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 9/26/2025 10:49 AM, Wathsala Vithanage wrote:
> Thanks Jason, I will address these comments in V4. Below I have some
> questions for you.
> 
> 
>> This should check the process has access to the given CPU:
>>
>>                 if (!cpumask_test_cpu(cpu_id, current->cpus_ptr)) {
>>
>>> +           mtype = (ents[i].flags & VFIO_TPH_MEM_TYPE_MASK)
>>>>>
>>> +                   VFIO_TPH_MEM_TYPE_SHIFT;
>>
>> Why this weird encoding with flags? Just give it a normal member.
>>
>>> +/**
>>> + * VFIO_DEVICE_PCI_TPH     - _IO(VFIO_TYPE, VFIO_BASE + 22)
>>> + *
>>> + * This command is used to control PCIe TLP Processing Hints (TPH)
>>> + * capability in a PCIe device.
>>> + * It supports following operations on a PCIe device with respect
>>> to TPH
>>> + * capability.
>>> + *
>>> + * - Enabling/disabling TPH capability in a PCIe device.
>>> + *
>>> + *   Setting VFIO_DEVICE_TPH_ENABLE flag enables TPH in no-
>>> steering-tag,
>>> + *   interrupt-vector, or device-specific mode defined in the PCIe
>>> specficiation
>>> + *   when feature flags TPH_ST_NS_MODE, TPH_ST_IV_MODE, and
>>> TPH_ST_DS_MODE are
>>> + *   set respectively. TPH_ST_xx_MODE macros are defined in
>>> + *   uapi/linux/pci_regs.h.
>>> + *
>>> + *   VFIO_DEVICE_TPH_DISABLE disables PCIe TPH on the device.
>>> + *
>>> + * - Writing STs to MSI-X or ST table in a PCIe device.
>>> + *
>>> + *   VFIO_DEVICE_TPH_SET_ST flag set steering tags on a device at
>>> an index in
>>> + *   MSI-X or ST-table depending on the VFIO_TPH_ST_x_MODE flag
>>> used and
>>> + *   returns the programmed steering tag values. The caller can
>>> set one or more
>>> + *   steering tags by passing an array of vfio_pci_tph_entry
>>> objects containing
>>> + *   cpu_id, cache_level, and MSI-X/ST-table index. The caller can
>>> also set the
>>> + *   intended memory type and the processing hint by setting
>>> VFIO_TPH_MEM_TYPE_x
>>> + *   and VFIO_TPH_HINT_x flags, respectively.
>>
>> I'm not sure if the MSI-X mode is really safe to expose to
>> userspace.. I thought the hack was sort of OK if it was used with a
>> co-operating driver that didn't try to concurrently manipulate the
>> steering tags.
> 
> Do you prefer gutting this completely or synchronizing access?
> 
>>
>>> + * - Reading Steering Tags (ST) from the host platform.
>>> + *
>>> + *   VFIO_DEVICE_TPH_GET_ST flags returns steering tags to the
>>> caller. Caller
>>> + *   can request one or more steering tags by passing an array of
>>> + *   vfio_pci_tph_entry objects. Steering Tag for each request is
>>> returned via
>>> + *   the st field in vfio_pci_tph_entry.
>>> + */
>>> +struct vfio_pci_tph_entry {
>>> +   /* in */
>>> +   __u32 cpu_id;                   /* CPU logical ID */
>>> +   __u32 cache_level;              /* Cache level. L1 D= 0,
>>> L2D = 2, ...*/
>>
>> Nothing reads cache_level ?
>>
>>> +   __u8  flags;
>>> +#define VFIO_TPH_MEM_TYPE_MASK             0x1
>>> +#define VFIO_TPH_MEM_TYPE_SHIFT            0
>>> +#define VFIO_TPH_MEM_TYPE_VMEM             0   /* Request volatile
>>> memory ST */
>>> +#define VFIO_TPH_MEM_TYPE_PMEM             1   /* Request persistent
>>> memory ST */
>>> +
>>> +#define VFIO_TPH_HINT_SHIFT                1
>>> +#define VFIO_TPH_HINT_MASK         (0x3 <<
>>> VFIO_TPH_HINT_SHIFT)
>>> +#define VFIO_TPH_HINT_BIDIR                0
>>> +#define VFIO_TPH_HINT_REQSTR               (1 << VFIO_TPH_HINT_SHIFT)
>>> +#define VFIO_TPH_HINT_TARGET               (2 << VFIO_TPH_HINT_SHIFT)
>>> +#define VFIO_TPH_HINT_TARGET_PRIO  (3 << VFIO_TPH_HINT_SHIFT)
>>> +   __u8  pad0;
>>> +   __u16 index;                    /* MSI-X/ST-table index to
>>> set ST */
>>> +   /* out */
>>> +   __u16 st;                       /* Steering-Tag */
>>
>> I don't know if we should leak the HW steering tag to userspace??
> 
> Agree, we discussed this in V1. I will drop VFIO_DEVICE_TPH_GET_ST.

Why drop GET_ST?

GET_ST allows userspace application (e.g. DPDK) to support PCIe TPH stash for cards like the Intel E810.

PCIE Protocol 7.9.13 TPH Requester Extended Capability:
1\ Device could support two mode: interrupt vector mode, device specific mode
2\ Define two ST table location: in capability struct, in msi-x table

PCIE Protocol 6.17.3 ST Modes of Operation
1\ For device specific mode: It is recommended for the Function to use a Steering Tag
   value from an ST Table entry, but it is not required.

So it is not required to use protocol ST table location if device support device
specific mode. e.g. Intel E810 [1], it only support device specific mode, and
ST table location is zero (mean it not present). With this card, we need to GET ST
from kernel and configured it in card by vendor's specific method.

[1] doc(613875_Intel® Ethernet Controller E810 Datasheet_Rev2_8.pdf) 14.4.5.2 TPH Requester Capability Register

> 
>>
>>> +   __u8  ph_ignore;                /* Platform ignored the
>>> Processing */
>>> +   __u8  pad1;
>>> +};
>>> +
>>> +struct vfio_pci_tph {
>>> +   __u32 argsz;                    /* Size of vfio_pci_tph
>>> and ents[] */
>>> +   __u32 flags;
>>> +#define VFIO_TPH_ST_MODE_MASK              0x7
>>> +
>>> +#define VFIO_DEVICE_TPH_OP_SHIFT   3
>>> +#define VFIO_DEVICE_TPH_OP_MASK            (0x7 <<
>>> VFIO_DEVICE_TPH_OP_SHIFT)
>>> +/* Enable TPH on device */
>>> +#define VFIO_DEVICE_TPH_ENABLE             0
>>> +/* Disable TPH on device */
>>> +#define VFIO_DEVICE_TPH_DISABLE            (1 <<
>>> VFIO_DEVICE_TPH_OP_SHIFT)
>>> +/* Get steering-tags */
>>> +#define VFIO_DEVICE_TPH_GET_ST             (2 <<
>>> VFIO_DEVICE_TPH_OP_SHIFT)
>>> +/* Set steering-tags */
>>> +#define VFIO_DEVICE_TPH_SET_ST             (4 <<
>>> VFIO_DEVICE_TPH_OP_SHIFT)
>>
>> Don't multiplex operations on flags, give it an op member if this is
>> the design.
> 
> +1
> 
>>
>>> +   __u32 count;                    /* Number of entries in
>>> ents[] */
>>> +   struct vfio_pci_tph_entry ents[];
>>
>> This effectively makes vfio_pci_tph_entry extendable, you should try
>> to avoid that..
>>
> I will try to fix this.
> Also, maybe it's better to have a single set-st operation per ioctl.
> What do you think?
> 
> 
>>
>> Jason
>>
>>
> --wathsala
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

