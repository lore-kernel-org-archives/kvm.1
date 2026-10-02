Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC27414410;
	Fri,  2 Oct 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972759; cv=fail; b=U2FYgXpZJB/mZ0fbBt44o6ttMDMGDCzt6X1xoeqhd4EcaXOzmTeV0aeOdXlvBDvj8diLsqdfYYW2J+/rsCa8dKxWDVe5ELuEXVSbH8LyDlIfW/b/nMYEc86ATaANAepSyAENEJ2edkLB5SXgRGTMIiFw1CJVTn5PFOzGbJ6e/y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972759; c=relaxed/simple;
	bh=TWNVqGKkE9hzXvoQ3DaNTS+iufzKtFSpFVFaIzR/zHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyAeEiQCFjMRQoyJUmm61fZuPGt18x4eWOJzvX4KENK0SJScaVB28+1VarV+YvXpFfCkhte/Dxx8iFIH1EkkiVRFEpF0iaauv0M39WG20Fa/6cZb1UAvR73qhKAi71KPjAvSURia/FZ7qO8g6cragdCMK/X+AjPw7S4bojGITkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cbgQGmpQ; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cbgQGmpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soWd7P9lk6m8unCia8mHWlQHnScqfDuacyVy4P3gnBLxJpdneooL+Jalds2LUcYCUJUgHHwrCdmSwnhjTd41z/KrJO1jB/LRfMD3B5b40erudyIGiv19JWjBUn0H/qnjjZ0UfwuyPS93X2DWVJLXSCO0efqwtWnNdTWo/GeMVt8o6p/LjgTWKK8mQz8GWaGJdvOkIYB5Zsfp/l3bfsXiO/iPJUHnpAqKqBFEwmCZiVuoTFZsqc/zUna7NS3J3rkVpcoOedEyvlcrjQdfGG+WHdfp5RBCo31pAlvFW7RBCuarqWSqVbfiT/vubuT3E3C+IiIsB7HNcSWPkSdxrZAc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVLQ+T6uwKLHiEUckmQBuuq2KhTDKOFbNB7qJSRHf6I=;
 b=OrXaVe8hETl849yZ3T82DDR/EVxaevWiTFKepwfEwSIN34y1RVRPuVAwmZnNWxQY8/NO6valtJ8BomYiJeAyRLmpDge7RwcA0CrAt/ZVFGBWOhji/8jc7fm6QFPLa/WXEGl+wd+ay5aX47qVoIa/Ttzvat0iVSUAgXg2h4OWoKtVS814Mw5npQXCcxc3iJtBT6QYLmCKfqBIJLuuNp4lWp6tloC6VBqYGt9xpwX1TTAHhTmrDyo3F02h9g2pcePdoj0j0Tt19Ig5cI/dqV6eeyUzPwFthTUXqlQLTZMBmmH4xU6Pn0BtzNQjZYvWcKJZ1kAhjFaIF6lmcIznqX4q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVLQ+T6uwKLHiEUckmQBuuq2KhTDKOFbNB7qJSRHf6I=;
 b=cbgQGmpQ6LSxOGSPa6s++aiFFzLilx2R7MyI9FW8oKUeHLybzd/aaCEuZaL3M6k4Yp9TjE6PC74QfOmzsGc3+/SFpOPy/pe3bC4M2W9XCkMdiKejlZ3BvR48Vg+PrecuM2DkPQOTHrbeB87SD8dKBJgoY3wh8WEf97nRd9kmt0Luk5bizSoqDvatc24s4im6STssc+PWxoHXc2LElOuWH2C+7TPqaLKIHL7YZontdv28smGzteA/BJOWAGgIJFkkt9UaYnTmdCeTyXoae4UrOZT59QWVojkpKwAt7IcOomiq87ZimfGymOYqKEe9dGE10DwgALN76FS5YOqVWB/Jbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 20:25:54 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%3]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 20:25:53 +0000
Message-ID: <42019c49-813d-456c-9c7f-6b729d2e20c2@nvidia.com>
Date: Fri, 2 Oct 2026 16:25:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] vfio/pci: Remove the core dependency on driver
 data
To: Danilo Krummrich <dakr@kernel.org>
Cc: alex@shazbot.org, jgg@nvidia.com, acourbot@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
 smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, Alex Williamson <alex.williamson@nvidia.com>
References: <20260930143641.4160785-1-xinmengs@nvidia.com>
 <20260930143641.4160785-2-xinmengs@nvidia.com>
 <DLSU375MUCEM.QQ89C9WM16H5@kernel.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <DLSU375MUCEM.QQ89C9WM16H5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::7) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed1f183-10b5-408c-ff3b-08df20c35b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	JYcm9jkrcyQVEP0FS7Py6kjAvlMl+3GOi4lRsqnPTZlaj0mufhJb3I6vWP7MU/sNW1ql+yDXPUm/x5sSXXUgWVAE/4V792rHi+pD2MD+uqAh7SoAx7PIrDocGL6eyQBDlgD8G5Wu43k9QIRkcONpIObVkYWyjb962Bj9u2jn5QUSKFPitEqvTvadUecyyupzQU09PDQBnrMi9qjaaVmF74Cww4TCh4QQGGn1OSGnPUzlTdMd8yNY//BnZ0bfSZpLJHzhqTHBRXUAvyIAW8kBwObRfOwOKpwJW9jdmb6CeDci5Pr3cCkg2LrjH0dKbkgfO3UgPH28Nrf/ohUCu50Bl8hAwmPNwO0UQbSbgE+8xq9RGF7cyTJVy4T9H3h6E3/X5rHJagJHu1nw8hwhhIaeCKCyWW8Y3WplW7GCNPeKfuGlv/NN6pRFhJ8Qttbemxs+tNvZF9teD6eUlInHaNvIMwHCQT0xHEpmxox0HSrU/98s6zwOwmiE7Uxxvvp6Ftrg1OBExYt2je2AgAs0MOXP+8YPGPjGBFwg3QnKAOkdRJJ7tPHL5FV1leuS5Y0zapyC9ihPXk/c33y4vZd9OrbTIXBTIvN4hlcm0f1gQV+PkX2Q7F+YJLMpKfGkXBhxlqia06smhrpBBkxuXtJxmf7ukHtxu7VVgu/PH4o3yIxJ9I8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZySkR6ZDlHSU43TVRsaDUwK0o0KzF5a3RHS0pmVkdoaFVOWDdyRUF5WmEw?=
 =?utf-8?B?QU83WXgrKzZsY0RWMmxEejFGLzErNnhLYUlEWU4rYjdsdkFnUDhTZEhFSHd4?=
 =?utf-8?B?UnJnd0N0dVV2S3J6YWtxK01NMFRuYWJOcEpoUkFmWGZzQytEV1FiTkJ2SHhH?=
 =?utf-8?B?Y1NpOHhnTnM5TldrVHNwaDhXeER1V0lqd3J4TG0vMEMwTjFpWVdNdTZ5TmYz?=
 =?utf-8?B?Z0dtNFpBL0hOeWRDeVR4Y1RaVU9PajNVK0xxL2lZOVlLbE1uSzdvdlo3NUV6?=
 =?utf-8?B?cGplZUtPYmMwNEVpaUlCWUQwRHp0WDhJN2NpMGQxeFFVSmUyQVFCd2F4ZGpo?=
 =?utf-8?B?YTdsWklZQ0JmYlo5NUdsb3BxalFpT2NxNFFhMlJQdGlSejhkdGQ3c21UMzUr?=
 =?utf-8?B?VEpNNU55aTZYR1oraEhQTlorMyszQXBBczhhZG12aC9hc3J6RmtGbUIrTEo2?=
 =?utf-8?B?ZWlwTnFZNThvUzg4WW51NlRMYzhENndUN204Y2FEQWVUYWVXTGhtZHJEMFlv?=
 =?utf-8?B?ZU4ydFpBV04wbUtYZXVFNHlGZG1McUtubHgxVStFREtKZWMxTlJ4ZE91bzJp?=
 =?utf-8?B?RnlZbkpqTllrUDJwWmJMUTkzRnNKQUZvQ2pQZlZtemNlKy9GSngrcHVVaUwy?=
 =?utf-8?B?dUIyVVlFbWZsVEN0TmxON0thOW9zR0FqQ1JkVW1xdW9PWDhpRG1FNHVUdlYx?=
 =?utf-8?B?UHQ1REdsR0dmT3VseUFMdEcwWGcyNkUzVURJaS8yWmFqYmVkY2dpUXVXZ1px?=
 =?utf-8?B?dUwrUU12Sm90MSt2OGJyeUxFZTI3bnVUc3RRanJ1OExSM3Y3THQ1cmsyZzla?=
 =?utf-8?B?KzdGMUpYOFZaWDBGd3k5eXF3NXFzRWN2aWh1cTlyYUkvUW9Zc25lV09idmwr?=
 =?utf-8?B?MU9NWFY5SmxyMmN0eHB6UkgxTUhXL0F1VUJVQ3BwWUNnOEloZ09ORkpnd0xP?=
 =?utf-8?B?azdtb2taeHhKeFN5K2RoM0IxUG16M2Fzd2VCbk9KNVhtYXRxOGlRbXA5S0Ra?=
 =?utf-8?B?dTFmSFd6RnNuTFp4b1QreEVocHRISVhXbVFHVDJYR2RYZ21pbGVIemRJYld3?=
 =?utf-8?B?ditLR2VueFJaK1dyN0lWYWZuS2traHphUDRYUTR0VjFtUzNSWnFtUGYwaFA3?=
 =?utf-8?B?WlBLS2VyTmxPWEN4V01rL3ozNm1rTTFpUSs1d3pjbW4wMkdsaEZDQTFkYXZ0?=
 =?utf-8?B?OW9xN2ovK296NnkvQXhvOGs2YVRtbFdsOUJ3eGIrQlUyT3RrVDlhVzlDU0Nv?=
 =?utf-8?B?NDltK05rY3RsTkEzVVZtT2pZUHJRbnFmVzVrclZjVlFHNVoybGQ2TXcrNFBB?=
 =?utf-8?B?OTVRUm1rN0p2SGMxZzFBMDc5RUhxdWkydVlodGZQSVo3R1lNYThmOGVsOTBq?=
 =?utf-8?B?WVZzNXU0SndBdkhHQkVqNmh3QW5GYS9VODNPSnUydDByN25IbkMwUVRIbDdN?=
 =?utf-8?B?aE00VW4zMXF3MjhZeVdkbUdHSno5Qmc5WmhWWVFPZFNXYm9pbjlFYllJK3F4?=
 =?utf-8?B?R3BIQnN1UE83clRQVDlub0t5Rnd4cWo0VlpDa2tuZk53bThWdkNHZHJwdFhE?=
 =?utf-8?B?SUhldndqVE90UHlKUGw0ck8xSWE2OXdFYVdIelJwNVEvazlHc1ZQdVdPcTNj?=
 =?utf-8?B?TWJoMzN1eTZCWVNnQWRvVHdzMlM3NkIvWmhwNlBVUE11WURNNzBscFU1QzhM?=
 =?utf-8?B?QXpuRllmT2Uwd2RlU3RwYWowaTdEaW9aUXgxK1VxVTg5RHZxZ2dWSUM2Y2Nm?=
 =?utf-8?B?RkZ2b1VMT0pxTitTRHBjL3NTWmlsSTVJYTRPVFd4UlluVUVRSGlJM1Z2WmdB?=
 =?utf-8?B?MERxVm5ZRUFucTlMTzNFVS9CbkVUSUo3Mkl6enFoMUxsWFNxZU5Jb3phQThU?=
 =?utf-8?B?OXpVU2l4TDk2TDQ5elVSWWN0SzhvVHdneDZuZjVKY1V1cjJmNTk5RGxKQzNz?=
 =?utf-8?B?TFh1NEhhbDlhWW5qdG54WEsrbkF2RjhIVDFUbGVBbWRIZkZWSCt4SUs0TFJN?=
 =?utf-8?B?UGNoYk4rYmdwTzhPUFEyVGxHVFYyTEhscEppVUd0QVFkRGc0OFNGVWh2YWEv?=
 =?utf-8?B?cFlLeUJiT1JZVEZnODVRdS9DTVVuQWdrU25SNUUzMWtVV2dvcGJ1ZmtkVEg2?=
 =?utf-8?B?bkl6anhYajJKbUtmTzRYMjFnM29pUHhkbUpzTEZoSGpYWndYWjRRbkx3RW1X?=
 =?utf-8?B?TkpKTS95dzJmMUlBU3Z1ZDdVZVdPWHVFWUQrVmZ0YzF6dGN1Wk1EK3VHbUkz?=
 =?utf-8?B?d0F4ak9DUVNicldlZlA3OXQrWm9wZEpEV05MaEpIVW1rNlhjVTg1dTVyazFG?=
 =?utf-8?B?YlE1dXJsMHVHMDhxc3JydUJ0UU0vWWRKejR6OFc0TFBNcGlCNFNuZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed1f183-10b5-408c-ff3b-08df20c35b96
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:25:53.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0nWecXtcvvmsC789xfCyQM5JqVVUaPEIB1VDFO/5GztpgfmwOz0xZIDUNUP1lt/8EKUlgVrwEPijSSgUUQDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

On 9/30/2026 1:40 PM, Danilo Krummrich wrote:
> On Wed Sep 30, 2026 at 4:36 PM CEST, Simon Song wrote:
>> vfio-pci-core currently has runtime functions that interpret pci
>> driver_data as a pointer to vfio_pci_core_device, and enforce vfio
>> variant drivers must set vfio_pci_core_device to their pci driver_data.
>> This constrains variant drivers' private-data layout, including the
>> typed driver data used by the Rust PCI infrastructure.
>>
>> Added VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
>> each vfio variant driver, update vfio variant drivers to store their
>> private strctures in driver_data and use generated wrapper to pass the
>> vfio core device to helpers.
>>
>> Select the vga decode callback during vfio_pci_vga_init based on if
>> vfio_vga_disabled, the callback only use pci_dev and does not require
>> driver_data
>>
>> Assisted-by: LLM
>> Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
>> Co-developed-by: Alex Williamson <alex.williamson@nvidia.com>
>> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> 
> I like that this moves the PM ops to static initialization. One nit below, but
> either way:
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> 
>> @@ -2332,10 +2324,9 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
>>  
>> -pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>> +pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
>>  						pci_channel_state_t state)
> 
> The state argument is unused. Since this is not installed as a direct PCI
> callback anymore it technically doesn't need to retain its signature.

Thanks for the review! Agreed, I'll drop the unused state argument from vfio_pci_core_aer_err_detected() in v3.

Simon
