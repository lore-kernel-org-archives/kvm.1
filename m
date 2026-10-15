Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEF47F77C
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061037; cv=fail; b=n4r7LXK7fVbK48r/196kT3RWnMDbA5hTEPXmz0U3jh+1BW2R9Qwk5Ns++YPUrCMRSSqeTUb9vXwrhEtV5S5ZGl5GlJXHQ4vFZS5hge4QZArnaDZs9eZX0p123ckhqaz6MeVQvl3UowRPqdTpMP5qV7ns3+FME1TjxkCSTRRTVec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061037; c=relaxed/simple;
	bh=buJQQBroP8xe9bxdF6jmdpcEhoiruSEfNzyXC64npXY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R9d761eokZRiDhvJIhcknuC9Lux1iaG/EscBalH+qeVuQSb9cEFTHxAHns7e8NJDk8lnjnTVqodMqRlTIGOylVTQgVB/XOsTVMNHwlL4HoXa6oWn0Gx2R1Al9nutM0AEY2XIdOyRhZuSlfsZZOKf/RQPgxEcddU6R61LQM9hiPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eHsYbSz1; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eHsYbSz1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le/WwH0U/EXaE0Qw6AfN1fY/CXu4ivhb3XPQyPVxXMhEJ9MPgSr6SOALP/FDt06+jxn2VomP2rbuFIjmQrREpABCHtkZYWh9zSgQaVfbBU9HdiadbiuNPmDJaOoH7kSmFuHMSJwISMkJsHRRUvzUfXGEu6HlFKmZ5pgJ8k91zw01gnc/oSBs46wAwAWHW81IDQeuGuAndodprTt0fdLf0dMN9B/vfQgSeR81JSmFxv9d5mqPc/Ijs6EfkIp9rhzqIB4opGG1xAutj61w1WfKGpgDpgvl7eF3EmOhfPrYihQ36nCEwp5C90I/luLmz7IluIHcbMXEhmW9yKzNLqeQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba/SjI+XfUR6p/yK+ZLV+ZKMh7hBsgYO9tUf/BJaUl0=;
 b=ySiXMPae1VzAMV0bpeMtxEj/VIyExI0OhK1Of0zQLUGPTCEVLJC0cCmpoyG5HI1chyfhPZk3n6WUsOJdsSYa5rK5Jjf76rGh8y7ueO1WFseW2wqT2qbGo0FDiooNSlIhwxCef7keGTnwWHbTu0c9hcDa4rsjzEs+7afN3zwBucs8AUqcmEQAz5I77tTCUtvqibavFBnlVYEbcI9Z5nqgJM6JjkwC8liEGRMgOkZ+IBO9BRKBNLGv/tCE7tH6OSzF+lDruwe8cZ+SLqBOTWegNddflB9grbq4eaPXzTIJaH2cEmFrtgMeHTjoVklA3pFM1lZVd4w8kVcec/f0Qv5g3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba/SjI+XfUR6p/yK+ZLV+ZKMh7hBsgYO9tUf/BJaUl0=;
 b=eHsYbSz1dt8ZN/Jp4UIb8OBZXAAe/Llgqk1V7HBd+Q+MGkh8yRBjvH5JNQmjQfBMweHmX3rRdBT+fbbASi8koR6bFormJE0XbFca3pWrAOeX+D0TqBUw45ciV7oF/2WJ5D8EaDTIa6PLHnXaovW2gU45tEcaGok8AkaKRQb758Y=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:43:52 +0000
Received: from PH4PEPF0000B60D.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9b) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 10:43:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B60D.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Thu, 15 Oct 2026 10:43:51 +0000
Received: from [192.168.1.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:43:39 -0500
Message-ID: <1bb1aadb-7414-4edd-9b84-5a4db33e1bce@amd.com>
Date: Thu, 15 Oct 2026 16:13:31 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 2/8] x86-iommu: Introduce x86_iommu_device_get() for
 x86-iommu retrieval
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Yi Liu <yi.l.liu@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
References: <20261014053433.24564-1-sarunkod@amd.com>
 <20261014053433.24564-3-sarunkod@amd.com>
 <e9162ee926e190d1fe7962d07a7c6e0b401456db.camel@bull.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <e9162ee926e190d1fe7962d07a7c6e0b401456db.camel@bull.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60D:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7d25a5-55ea-4826-1669-08df2aa9339b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|921020|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|20046099003|21026099003|6133799003|5123799003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info:
	Yx95fav1QwKUPqGGoOkXk6GBfXbUDIqFCy7KJjNYW+YdLjCRMptPg5CAPW8stb8cFiP1lGm+H3XneLsSwIvBRu6CqQqTTU9DI0KtENSvEzdnYa+MB0bGF+dC9ZDTna1qf0UYXL1iufLh6vT6r070cjvpSBRUtwQ1++RJGwT38h5qdukMfkPaWQQJEe6X9qgSXJKgdbxu+3OZIZ4bU+ULOhIpgFPW5i23WcD14fgn5v+S2rfoAnPaDT693XCMY30BweBvHkrPxdgxM27mKrwhJ+Q+qYONI2SMlldkRxROANR2PqGKBApm2BZm7l9xK/Q057VXtP0lzvZxFQDYhW3c3Q3xRToj6UrujhduewGqB7nqpVUJtjy8BRKXVIrBnH8LcpR0sPrOmda6a6niw2V8g1ARII1TV9yGaj+PB3JURJVF7jTMqzeuxrJM5yeLkznj8vTIK8TjTXMshjosyU+hCP8pToYaqolctq/sDmVqWlslJFRGY0cbkamFDKq1sujy1PrwNBPy/phbS/9jbaFgshp/fH1Gv6S2ds7C+pnBm8LBA48OyYE0PWLW4F6xHFD3YRY0jrm2hgF9h9QOiIYAvIhp32y/PmXJU9bDQ5oRnCf38YCIEcVcVmXYGYa/udERlJZ4RMHYN8VZS1eJc+iT9C/iIsxiBVkcx9k1ETrH72ZI0dUbNJYGdssqiwlGrWaomKl0QM1iSAVUTNUI8QvRFAsr7Ec4EMbNEJ1Vdyfdu1m0lmWW/45ylb2v4Kz4Wx2G
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(20046099003)(21026099003)(6133799003)(5123799003)(13003099007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uXbgZu+zfn3b0R93F6y3b3XacdWhea2V4P5sNg1w16mcsBPIkGuSdyfc9fiQ0XiadfOtoThYo5WTLHCtNlc9h9i8igScDZxs3A6rejwhgM6DLPKIKKzF6q86e8p7WlcX7i0gKzcCKoZBf1H4SgqTFIRS/3/qSAlqHhDRjPU9TGRyROfQUuvNj60BANAgHrUsUCk0iJMUWn8slyR0ZBTxy4c8EergaacSKGBefhj/0qekfDceW8Zq1a8Dj6akn957Ggf4mUyqQCve/kzdwlA5TO4Fx7tqFU3sHcbVli6FyYPl0d9qrom/zknZkro7k5H5PofuNPWJjVvWXpWavFL9/EJWZy0at3yobv8DcYYFUm7LI6LUfL3T5RtESOfsFqMqwwU7Nk/+og7U6e7OyfGXaJTR5OgnXFcCcCU3RI1MCa7V2vTa5uaujOP9ykC44tks
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:43:51.2411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7d25a5-55ea-4826-1669-08df2aa9339b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403



On 10/15/2026 2:38 PM, Clément MATHIEU--DRIF wrote:
> [Some people who received this message don't often get email from clement.mathieu--drif@bull.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Wed, 2026-10-14 at 11:04 +0530, Sairaj Kodilkar wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> kvm_arch_fixup_msi_route() and kvm_arch_add_msi_route_post() use
>> x86_iommu_get_default() whenever an IOMMU is present. This selects the
>> correct unit only when a single IOMMU is attached to the system bus.
>>
>> The following patches allow an IOMMU to attach to a different bus and
>> isolate the subset of devices below it. Each IOMMU then serves only part
>> of the PCI topology, so interrupt remapping must determine the IOMMU that
>> actually serves a given device.
>>
>> Add x86_iommu_device_get() to locate the IOMMU bus for a PCI device and
>> retrieve its X86IOMMUState through a new get_x86_iommu callback.
>>
>> Signed-off-by: Sairaj Kodilkar <[sarunkod@amd.com](mailto:sarunkod@amd.com)>
>> ---
>>  hw/i386/x86-iommu-stub.c    |  5 +++++
>>  hw/i386/x86-iommu.c         | 16 ++++++++++++++++
>>  include/hw/i386/x86-iommu.h |  6 ++++++
>>  include/hw/pci/pci.h        | 12 ++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
>> index 781b5ff92227..b0383d2290b1 100644
>> --- a/hw/i386/x86-iommu-stub.c
>> +++ b/hw/i386/x86-iommu-stub.c
>> @@ -32,6 +32,11 @@ X86IOMMUState *x86_iommu_get_default(void)
>>      return NULL;
>>  }
>>
>> +X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
>> +{
>> +    return NULL;
>> +}
>> +
>>  bool x86_iommu_ir_supported(X86IOMMUState *s)
>>  {
>>      return false;
>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
>> index a57445404ef8..601db5cfea09 100644
>> --- a/hw/i386/x86-iommu.c
>> +++ b/hw/i386/x86-iommu.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>>  #include "system/kvm.h"
>> +#include "hw/pci/pci_bus.h"
>>
>>  void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
>>                                       iec_notify_fn fn, void *data)
>> @@ -90,6 +91,21 @@ X86IOMMUState *x86_iommu_get_default(void)
>>      return NULL;
>>  }
>>
>> +X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
>> +{
>> +    PCIBus *iommu_bus;
>> +    X86IOMMUState *iommu = NULL;
>> +
>> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
>> +
>> +    if (iommu_bus && iommu_bus->iommu_ops->get_x86_iommu) {
>> +        iommu_bus->iommu_ops->get_x86_iommu(iommu_bus->iommu_opaque,
>> +                                            (void **)&iommu);
>> +    }
>> +
>> +    return iommu;
>> +}
>> +
>>  static void x86_iommu_realize(DeviceState *dev, Error **errp)
>>  {
>>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
>> index 0a1e1ba72571..eb575271e9d7 100644
>> --- a/include/hw/i386/x86-iommu.h
>> +++ b/include/hw/i386/x86-iommu.h
>> @@ -134,6 +134,12 @@ struct X86IOMMU_MSIMessage {
>>   */
>>  X86IOMMUState *x86_iommu_get_default(void);
>>
>> +/**
>> + * x86_iommu_device_get - get IOMMU device for given PCI device
>> + * @return: pointer to default IOMMU device
>> + */
>> +X86IOMMUState *x86_iommu_device_get(PCIDevice *dev);
>> +
>>  /**
>>   * x86_iommu_iec_register_notifier - register IEC (Interrupt Entry
>>   *                                   Cache) notifiers
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index f2448e941a0b..f3c4c3a4db56 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -698,6 +698,18 @@ typedef struct PCIIOMMUOps {
>>       * Returns: the guest physical address of the MSI doorbell.
>>       */
>>      uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
>> +
>> +    /**
>> +     * @get_x86_iommu: get parent x86-iommu for given hardware (AMD/Intel)
>> +     *
>> +     * Callback is required if IOMMU defines x86->int_remap()
>> +     *
>> +     * @opaque: the data passed to pci_setup_iommu()
>> +     *
>> +     * @x86_iommu: A pointer to store the x86-iommu object
>> +     */
>> +    int (*get_x86_iommu)(void *opaque, void **x86_iommu);
> 
> Are you using void ** because the X86 type is not defined when building for another target?
> I'm not sure if the Qemu rules are strict about architecture isolation.

including x86-iommu.h inside pci.h will cause circular dependancy as
x86-iommu.h already depends on pci.h

> 
> Do you have any idea about how acceptable this is?

At this point I am not sure and dont see any other way to do this

> 
> Is there a reason why we could not expose the API in the same files as x86_iommu_get_default?

x86_iommu_get_default() uses machine state to fetch the iommu device,
because of which it does not depend on device/pci topology. Whereas, the
goal of this series is to have a PCI device isolation, so kvm layer has
to fetch device specific iommu by traversing pci topology using
pci_device_get_iommu_bus_devfn(). Hence we cannot expose the API in
x86_iommu_get_default().

Thanks
Sairaj

> 
>> +
>>  } PCIIOMMUOps;
>>
>>  bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
>> --
>> 2.34.1
>>

