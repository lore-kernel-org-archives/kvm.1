Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F2384229
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934041; cv=fail; b=V/HDZHisw/LcgZcLkLvaGRfyE+oTrxK/NihWtOfkpmHp0PI0olwb/ZYNrLaSxpEP681j7rE2rBqoCavls7lomL7V6w+QT386YeY0oUV1sE2ucYlOQLzRFAT53a7hZ+NMOyP3a2d1d6ZZvafcFJ7/BhrU8wb5malgwGf7nWI25q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934041; c=relaxed/simple;
	bh=IxzGudZF8/vIa6O+2whULe5+X/xUW6XLdgtMFMWW3Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jeqYElQY6JAQvTuSeyBTex56DtewjA6HIvyQ2V1ax4PqSC+sLl/gBRehSa/hu0vUEV/xKbkF1Z6rBv+g0Klz3UYSXE1A9+6H8sHNVBfPPa6dq7QRWQY/40Z0fL07lJE7SNriDaczOxTFPoRyX53HJr7jh9Ob1xZWCFqvM7Jf2k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6zC5/JA; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q6zC5/JA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKqGxnfG7j8YStEGK/d1q5+VhrrOzqdxVj+f+JfBevNu93jUc8r30yCEqTI8izAQDqfUF9pCjV2CLUPWYIX30eTis2nip091UFolnSSX0pWPiFAlgJ0/jJvnWarAQmA0+PrB7saT/RveCVLBhHRnVuP4MdQfTg0gedE4BvghgpIKFTuPwXpxLQc+fWMPMMpf/yY/WKeCKu+ZEHIKdivdn3HsIobKTNVdW9WgARpN8OFBHapAthqpm3cU+mtTP7eeXOXBspTMODuWQ8g6IR1A2Fb0p2+P1JPMBmG9S1tpqC32fNFtSTqFYCOMj44lWfkyRWPpn08YCjE/s1i6Sv4JKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjEKXJasXOPIUM2WCN1rhPi/cfE1vqxi4Y3CrSZK7dk=;
 b=ko4eadRDOWwsoSb9O8cCX8T2BfCRK4/Q1wrTalo1OffBOD5W6F+EkPmxpMhlbnqta69NxjAhDzgkvcOnyk7BrROrB25J+XDLDJYHc8tsr5a3to0MH0/qi21eGn9yMeW1BjgtJ+LfGd0x5PAWhpf3Aq0daTSDQ1oGsqDX1CJJ5C+DA+6Zh2JavT58HzcWaOPit0gTn+WGy/P+azxCdzreioSsfv1G0odLd911i26IxZP2+PEeN1ZVtX53f+WukND65agzFi+y2O/fyXRu1MU7JkAGDZPg5ev3ZiWccG88HqGcOnGnAFg+oi5mm6t8bh7MXVnzUesRJaENNHyY2ycdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjEKXJasXOPIUM2WCN1rhPi/cfE1vqxi4Y3CrSZK7dk=;
 b=q6zC5/JAmIQTwSb2bqhi2GW49m84jzFFCK2h10KscMZCeJ4KbGopGo5zsXzR5ojBhbe1OxNj/HTRkmsGmHHWTByiZdzy6nf/3mnY2X9n9/q7iK0elNc1j28pfx7B8aqIhyRJrj/nJ/rQTbfrYXt5vQWXTszqRRzhwM8kj+hYmrU00KnsJz9BUzz9QsZejCIHtmCIdrQfXN7Zl+w687OnoIW13EeJ+EgFeI5jciJKxjvrXVhUKvBXe9ACpAbekgSJpkOZJLvGg3g3WCRF/p0x/1pW9B6/bi4anlVfjUcLHF7Rj10inUZiywSrtEqPPWfAxhJ07WLrKrn0TJVvzLJiDw==
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 15:27:11 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::5c) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 15:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 15:27:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 08:26:52 -0700
Received: from [10.221.201.248] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 08:26:48 -0700
Message-ID: <f5188d47-b787-4382-b0cf-1fdf38781a30@nvidia.com>
Date: Thu, 19 Mar 2026 17:26:46 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 vfio 2/6] vfio: Add support for
 VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@nvidia.com>, <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>,
	<avihaih@nvidia.com>, <clg@redhat.com>, <peterx@redhat.com>,
	<liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
References: <20260317161753.18964-1-yishaih@nvidia.com>
 <20260317161753.18964-3-yishaih@nvidia.com>
 <20260318160337.1fa2b3d8@shazbot.org>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20260318160337.1fa2b3d8@shazbot.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: c36aae57-a877-4143-2b54-08de85cbfd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6UTXCXa2LD+nIcfo2KSodgFoSvOfBGYtPzSLeEsnTeNmgVou4P8uLNPw3l4y1eucjqJQNyWpD419kw0pLQQCGazDSARkCDByCTVrDOrT5Z7XPplMZNJ+mcrgjAiNV4nuousfxb2vNyInx5XP05KaPKMUEpj+KzAhC2DMSPn/7vnyRvTRfFkYzFawj89W0/ABumlUBzt4WVO+pjtbFs97z4HBqiw8MeprtqynqipMAh2sKricoxqrGkfZfZI4cQOEAS83RU7EMpSHrMqU64s6YzIX9tOfPiJJHNcYBSzd5agjmguLLMlyjpjQ0G0aJkwoQBMfvqeK2FLGxkEYhFZTy/y9/8enMhhNJ3h0mzQXvwmfisB9ic0Dc880uV/Ee98zl2mB2mxItdzgwFbFUWQjj1HhYTHAO9Fm1FDOuEcMeI5Hm2UcPA22C4MZIKA7k1byegTENrrxtZJQRMTvdPj0UwLeaHeDTBERkZg+lPVJRNfEvFmtGm8UKuuhMMCyD3S9Rl0luMFB3qzdRC16O/Lqs4gmZJY2SZLOouCTip3IAwlaaV3CBsbAF96wRzXI6oYQXSlZCgd0oqxcSCpriDjEcJfK5zubLr0ucxZ7kZdF97LRGbWc39DubY1NeH4V+9WTnOiih1GPxfCw1DV82DrWKb9gkUoV9xd2f/98Xl2QPVLK2dizPCXe0uvi2vD6rO9F3d6suLX0RF0qtlcIoNNsuRfvjsZA+Fi2VAZwlJB8LUomREbNqgURZrJesRWrUcJTnVCH9Ip72xFsp91IiGnbsg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z9rrqPf8i01u8IQ6GRbfl5pB7yLOtR+6mh8dAYo3aJM4U4CwBj3yQ0KXSl7Dc4053AOvRFSgj41OMC68vbUsksfG2Yn9D/D+CUJwPSbUkXi47GcSRVYvrkY2ZnCZP2TKe9pLXTclpVRaWJhwRaE8uMVQmx5O9jdXC7TmuN96oaQ5zMTt/astBH++LDFGfS0uXYWr+od7rOt7H2zSFpOlHnkp9PYabuxwAJNvBfItXsJdwfSdCuOvIwltHzASUrvsUAhVNEhBE56bR/yoBFITxxHFFVCtmWtXXJ28c5onPZsAkkn/bKIWkhcHtjtkAsOMqQblZjzqrP32T3DVQJdncUD9/P2H4uv76LSfXXG0Ou7osEzWCoI2aQp7Lw5aZc5FsFZ95ECupqALA5aND3mWBa7l4jl9DZqWrg42lyzE5d7v1+lnaWyH7dA8Vb7QP6zc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:27:11.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36aae57-a877-4143-2b54-08de85cbfd9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086

On 19/03/2026 0:03, Alex Williamson wrote:
> On Tue, 17 Mar 2026 18:17:49 +0200
> Yishai Hadas <yishaih@nvidia.com> wrote:
> 
>> Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
>> assign info.flags before copy_to_user().
>>
>> Because they copy the struct in from userspace first, this effectively
>> echoes userspace-provided flags back as output, preventing the field
>> from being used to report new reliable data from the drivers.
>>
>> Add support for a new device feature named
>> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
>>
>> On SET, enables the v2 pre_copy_info behaviour, where the
>> vfio_precopy_info.flags is a valid output field.
>>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c |  1 +
>>   drivers/vfio/vfio_main.c         | 20 ++++++++++++++++++++
>>   include/linux/vfio.h             |  1 +
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index d43745fe4c84..1daaceb5b2c8 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -736,6 +736,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>>   #endif
>>   	vfio_pci_core_disable(vdev);
>>   
>> +	core_vdev->precopy_info_v2 = 0;
>>   	vfio_pci_dma_buf_cleanup(vdev);
> 
> There's a minor discrepancy here, enabling precopy_info_v2 is a core
> vfio feature, but clearing the previous user's opt-in is only
> implemented in the core helper for vfio-pci and associated variant
> drivers.  This should be moved to vfio_df_device_last_close() to be
> common.  A follow-up fix rather than a v3 is fine if you agree.  Thanks,
> 

Sure, up to you.

We can consider also using the below fix-up chunk as part of merging V2.

diff --git a/drivers/vfio/pci/vfio_pci_core.c 
b/drivers/vfio/pci/vfio_pci_core.c
index 1daaceb5b2c8..d43745fe4c84 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -736,7 +736,6 @@ void vfio_pci_core_close_device(struct vfio_device 
*core_vdev)
  #endif
         vfio_pci_core_disable(vdev);

-       core_vdev->precopy_info_v2 = 0;
         vfio_pci_dma_buf_cleanup(vdev);

         mutex_lock(&vdev->igate);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index dcb879018f27..8666f35fb3f0 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -553,6 +553,7 @@ static void vfio_df_device_last_close(struct 
vfio_device_file *df)
                 vfio_df_iommufd_unbind(df);
         else
                 vfio_device_group_unuse_iommu(device);
+       device->precopy_info_v2 = 0;
         module_put(device->dev->driver->owner);
  }

Yishai


> Alex
> 
>>   
>>   	mutex_lock(&vdev->igate);
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index 742477546b15..dcb879018f27 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -964,6 +964,23 @@ vfio_ioctl_device_feature_migration_data_size(struct vfio_device *device,
>>   	return 0;
>>   }
>>   
>> +static int
>> +vfio_ioctl_device_feature_migration_precopy_info_v2(struct vfio_device *device,
>> +						    u32 flags, size_t argsz)
>> +{
>> +	int ret;
>> +
>> +	if (!(device->migration_flags & VFIO_MIGRATION_PRE_COPY))
>> +		return -EINVAL;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	device->precopy_info_v2 = 1;
>> +	return 0;
>> +}
>> +
>>   static int vfio_ioctl_device_feature_migration(struct vfio_device *device,
>>   					       u32 flags, void __user *arg,
>>   					       size_t argsz)
>> @@ -1251,6 +1268,9 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
>>   		return vfio_ioctl_device_feature_migration_data_size(
>>   			device, feature.flags, arg->data,
>>   			feature.argsz - minsz);
>> +	case VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2:
>> +		return vfio_ioctl_device_feature_migration_precopy_info_v2(
>> +			device, feature.flags, feature.argsz - minsz);
>>   	default:
>>   		if (unlikely(!device->ops->device_feature))
>>   			return -ENOTTY;
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index e90859956514..7c1d33283e04 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -52,6 +52,7 @@ struct vfio_device {
>>   	struct vfio_device_set *dev_set;
>>   	struct list_head dev_set_list;
>>   	unsigned int migration_flags;
>> +	u8 precopy_info_v2;
>>   	struct kvm *kvm;
>>   
>>   	/* Members below here are private, not for driver use */
> 

