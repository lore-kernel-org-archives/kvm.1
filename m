Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792591103;
	b=c1sA9L1R2iEaI795SPBLmZ6mT33yCBG40gnIXqD9IedWng6cPnL9cGBlcFGCZf46vKgS
	 jux5jtVtUXUd4E+R4L3z+FUTO+MVRP6TEJaZGq1NL9zEv6mSHdikQPMUgaXW+4/6/b3Gn
	 wEmWex7iLkqaKlGIeWDl8JJ9qsxsxNXO9yN+1o9nTAqr5nUHne8WqStVSS5TkiMJfBkZs
	 9MHaJSzwvG6q3DduFBRvnoXJSDiGtny6zQJ1fjdTTXTyo1H5drjkZnLqBP0pNAxq2VKyj
	 2zOgdSsM+kgVbUzFSThDhI2SdXEyfyx7suzndo6a9lRtFxmbcIv5q6Kf9zX4n4WQ/bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DjBZ2b9z1KrL5tnHOgwqFWTUcnNzZQgSKTJQxda4nvI=;
	b=IhyP1USjUK0loeTQgM3NWia1xb2mZcap7BD9ykOtC0PpACmrxzyW6hez7Rb7PmTktME5
	 2rlSUuUewQf/hq+jejuH/hCU/s+VEq23bllWMy4YWQaYnXzZyCigz0pYzC/jHaTn+Z130
	 HXikaKq4ofLy172jxaEDo/m0642H0gO517hRrHAbz+TALRAWth2QbI9l1RYHl5WumJQ2I
	 Gx9rQK7rxw+x+aSCQArvB65iLWNmiw3OJri3Qx//YYL+BBL5YDiAXuZcBeFDd5iIbBJpe
	 5IXBIoS67YxhbNzGdezxQz0ZhX7ug85lDw7qX974xKsXj1XGOwm/9R7WYq065/a7+/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SIhZT5WX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB284606A31B;
	Wed, 21 Oct 2026 13:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB284606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SIhZT5WX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgaMHlJePnKzKL/N1UIuB+clZLlCLl5pNwVnJZC3slytK53l8ft+yYarJmyf97qJc5+ljqKF9CT+f/FuT7YWircdhJJb/Kw/B9o2gs9paEBuSTPKODDKfyqlWf4IDlgSv53Kot+fxZyUvXwqvKWsDtivtEd/CptcCVnNlolSmcj+gxs0Y997OIftVcHM9fOwrYqd387WJjA7PFcGCUxth3roOLir99NDI+hH8uDHLHhtu3Mcd/pZw58gM5QQHnM48EMrl02zHjgKYnPDm56g3mXZ68xNux85/SvLJ5qEJrQYTjudZEZa7EArLQiHm8FSYeL+pnOu5pok2KAgZonjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjBZ2b9z1KrL5tnHOgwqFWTUcnNzZQgSKTJQxda4nvI=;
 b=bkbQndbc24ShNhxWSlCEAB2tyuGeI0YWylqJYS+lxarr5jo9LKC4p0VqlPdrQRfHvUGvCrbwbdh3EyBTEAK06o32L6lX5gaO0unODz6hw7XbVHg5MjhlvgL29plEPWPO4aFRJGdgn/KRgXeXGMEJdVecuOKhj3eYw3RseTOClLDOKsbir9Zczb1z+q3gQHTYvp4JoDX4z8kl5Fl4wmdbqI9NT2+cmQtjLpaM36byGVw6a6lSYuKnM4B+32jF4wMSOLq1EwPANEWL6Z2D4F2087oW0esuF5yFjq7IjsdcGEYyn2J/0XEpratRv47NSyoHnqpWUBrZfdHjnoYcbqDFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjBZ2b9z1KrL5tnHOgwqFWTUcnNzZQgSKTJQxda4nvI=;
 b=SIhZT5WXpewTh+Jcjc5HM7fg/6IQQkrhstJT7DVUbXCnT2HgXL2YL9611zxdpnp2q0EwMRTktbvlHccTgLdyJ14D629v4wcVHSBBTzez5VO62Hbp7PLllW5lt93VI4WGV8nV8j0X0+MzHnXMq2LQwDcMNVWZRat7OB3Y0l9B5z4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 13:58:14 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:58:14 +0000
Message-ID: <b8ec67ee-3a5e-4c36-a1c6-2b291d013369@amd.com>
Date: Wed, 21 Oct 2026 08:58:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] fs/resctrl: Introduce kernel mode enum
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
 <6764525f-0245-4cd3-b35c-c2bbf4e65733@intel.com>
 <a23f9f1a-3c5e-4166-8956-86c3063a9e64@amd.com>
 <14e8bcd9-4431-4dba-887b-c5b5e156dea3@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <14e8bcd9-4431-4dba-887b-c5b5e156dea3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:8:44f::15) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: f443cdb1-8e27-42db-65b6-08df2f7b591e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18092099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bHO3Zj/RwaUJl5yERj0U54J6BDlKkn1oU/+VFUr+sqXXN0TKrc4d5aeT0LqQWwLvCBK9svSIAemFVdqSZzpVo8sc/hAcV+o579mLjEL6xdn9Jzi2fM0dMNH8hKrmMNg/8Xq8IpbKZ3dHkoTJIEfTpAtOzokWHkH8NQosQYOlNY8OtK68+AxCT3zXY7O0EbqMNHr8gBuDsLtVMPdovIKJSefjKTT4EFTn/RsxOv+MWuW0BFgZoHiiZP52t2gChcovF1AZKXkBURVNkDd9zOeuAOWUEPi0ATSApaomyKS9PHR5HZtugMw7l2gwW/BGPmKFf1B5dGvlFnu0covidAJlrQoc3112GT+pxFgmcLHz/jckhVw1Z0pjZMT1OoA43ev1bmN4CdqMVpS5iXqtqKO4VZZWSjaqDtOQ174pOHbjomTfED8EfL9b5IJG92AsY23iKmfCwXRY/DVd/RYBIWh2zU1Omtmp8HWp9m6fOLeiYVsXhtxK+dX9stIDd1xd97pHwfV/a8MvWzpyrKrt/MdjRugExPy1l1vLJCKw11vqlyCs31qbxJ8EOwptboGy09F4yWLXegmMZzpTK5GoU6SG8pnLKMopZrNrQdrAmSAmv2Eyitw9jXrBuKFrrtW0/m9yY+WCOjRz9LiYoOCxrSJ21PKQc6DPuaJtp7tgWhtDZdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18092099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVRFRFlQVDM3aGtCYXIyTkNVZlJFZkc4SzZycUdwaHlDQzQyeDF1THJuanc3?=
 =?utf-8?B?cmV2R2dkTVlaS3FHNldSb0hUVXRTMXJLTVR4RTlDU3lFb1hscksxUDFHcHZN?=
 =?utf-8?B?amtMWTk3WjFnTlE2K3VxQ2dEU0k4cEQ4VUE0YmhYaVJ5M25YcGxaS2Z0bW0x?=
 =?utf-8?B?bkZBZmtCU2tYS0FQWHJITjZrbEFGSVR3TU4wWGlTQ1dibkdxbzc4UXByR0pR?=
 =?utf-8?B?RFJxcUpJdlJuWGZUYThzT3FHd0IvOUR1cGtiSG1sUktpbk1QRVNhTXlEZ3hx?=
 =?utf-8?B?ekpYSTFFaC9xRWdCUkhOT29oY2l4bnY4RVZkOVZnSDFvVXJUMDh4RnlCV2hk?=
 =?utf-8?B?UkZvbEZnSHE4M1htK3lIczZmd1lmcVNYaDBQTjNETmNTUUdsR3JDc3J5alRu?=
 =?utf-8?B?aWFmSk9SNzhUZ1F1S3pVTThIZ0EyK3IyMytqUGhqWXVQcFlRZUMraGlrQU9Y?=
 =?utf-8?B?QWRqUkZoNWQzbjQ1aXlUTStQa2gxVFpYeTVqbDRWdHpiK01KV0RPUUhzOGg4?=
 =?utf-8?B?ZUU3SUwzMTIzcnFvTWErWVE4aDVNb0I3cGJJMWwrcy9DcG1EQzk2aXdFK0Y1?=
 =?utf-8?B?bEpDVFYvMm5kWHZ1dUZOcDdkSnBRVGkvckVhbVRUQ2RHR0dleU9BTCtPem93?=
 =?utf-8?B?ZGpYb2xRb1ppTTlaNCtjRU9xR3pWbTNva2xyRUhaNDZjN003bkE1bGlIZTRE?=
 =?utf-8?B?eFk0SFVYa0VyWGZaaDBIZldDYWtNV2NmV21GRGtXVndsZzFZcm9wY2Vtb25q?=
 =?utf-8?B?dVZ1NUtmOFJ0bm5GSUo1RGtGWFB3S25XREx0dFdzNXJucmxaMHZIQVBKbzI5?=
 =?utf-8?B?aTA1UHlqR1VRaWY4bE9ETjdqUmtqRktRK3cxYkNxN2xYc3NoYmxQQ1Flblh4?=
 =?utf-8?B?NmgzQ0RtTU5YeVYrUzRJc2tjS3RqQjFkSVBPNmhib2E0V3dodlR4NFZyWW5t?=
 =?utf-8?B?cy9Gc0o2Zy83OHF5bWYzSFl4UkIxKzNzSGtHS1VmbGdZQ2hWa0o2OXd1UlAw?=
 =?utf-8?B?dE9sTDkwVVVKWjJZT2tYMmNEK2lXWWV6Yjl0UXdZcUQvQ2tnVnVsc3gzSU1u?=
 =?utf-8?B?R3VRVzcwQmpoc0drcEFuR0p3Z0tTWCt3Q1hMeHZmK0VMQTg5VEQ3NTh3d3Qx?=
 =?utf-8?B?SitRM0Q1ODNjb0tBWldwN2YvK3FtbW1JY2ZydFJQdlpkOFZncWt3dDBLb1NO?=
 =?utf-8?B?dWg4dTg3ZW1qQlRJSWtZRzIwRTgxcXE1akp2NXZUVHpZMHpDTDBQcndwSkIr?=
 =?utf-8?B?N29oNTBEM2tyQzhoKzhTaVR5N3BweGUzYVlDL1U0R3NQY09DTWwyYThCbWRh?=
 =?utf-8?B?cmUvNElPc2YxNGVVV0RpblRtY1hrZGdubmtDVDgrQks5cDNncksybCtYMDdy?=
 =?utf-8?B?SVNXN1pDOWxCdTVDbGdOQi9laGV2WnRRWlhXQmhtSXRyakhyTFlneFA2MWFL?=
 =?utf-8?B?cWJZRnZNamMzV2V3ZW1kNm44Ylp4L0hpUWx4U3FrU0xrUDNMajNvZHRUVjMw?=
 =?utf-8?B?dklYKzdJOEVRQUhKWm4yZ1RiNGlVSVBmK3UxaW5pb0F2eHhBQ1VydnhnTFJz?=
 =?utf-8?B?aUdBZlpWYUJZK1huSHJMSDJ4ekppL2dHa3EzRjRURUgra1hRQXkzTEpXM3Y3?=
 =?utf-8?B?NHBIeVRWSi95c0FuUFNVMnFsMVBDZS9QNDNLTHhGdkFCaWFicTVtSFBvNVpv?=
 =?utf-8?B?QkFkZjdSdUtvWHVIdkRudjVyOGhFRk5KWC9HMzFpOEc3dXN0UW15QVJmMFpu?=
 =?utf-8?B?YjUwcTBuZVRKYjhHNUJBM2NSSVJ2OURXZHVGYXhtaVdXOS9sMjQyU3poNDNM?=
 =?utf-8?B?dDdtcVppN0hjekt6Wmp0VGM0Nm16TEI2ZFZGbTRwQTFyZkptMnJNVHVFT09O?=
 =?utf-8?B?RHk2TTkySUgrSS9yd1EwNWV6cEg0STQ5UWdxQUdEVDBNbGNqOWV6U1hEOEZT?=
 =?utf-8?B?VjJIdVhQUjB0Rlc3NElpbk95Sm5Bd1JraytCN253Vi83QTE2Nk1Ed0t0S0ZD?=
 =?utf-8?B?d1lGbG1Uc29lQXNTbHVzQ2hNem9nT0R2K2tPREIzTlJYWVoxdGx5NjRJaytq?=
 =?utf-8?B?RlYzNDFFRzE4anduNldjMVZYZGdaanpzd0tHTnRkeldlV2tzVDZPS2NaUkFx?=
 =?utf-8?B?RGlEVjRFNlpyeVdOMVpSOEJITlg1MnhDZGVLNnI0WG0zTkdwemdoT2VjU0lI?=
 =?utf-8?B?S3JyUUhMdzVWdloxRDlIcTZqb2pLUlRudWxwVW5zM3pGZnVsM0dFdDFkL1FD?=
 =?utf-8?B?Z2R0eDJ0TkpEemhReFhYMHVxcWp5MTlPMTVCTHNrMW1HMG5sMVdNYXZheWln?=
 =?utf-8?Q?vEDjuR2WFH0uf9o+1f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f443cdb1-8e27-42db-65b6-08df2f7b591e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:58:14.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVX/8Ct7oGW/Nx22d0s/1WSSQSgqxvVkv/7N/bUAVdKpHuY7Hw6X6KUakd5jsTju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

Hi Reinette,

On 10/19/26 11:17, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/15/26 4:09 PM, Babu Moger wrote:
>> On 10/15/26 09:44, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> Kernel mode work can use different allocation and monitoring associations
>>>
>>> Here I think "different allocation and monitoring associations" means
>>> different CLOSID/RMID, while other places "different allocation and monitoring
>>> associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
>>> MSR_IA32_PQR_PLZA_ASSOC.rmid_en?
>>
>> That is correct. Hope text here is fine.
>>
> I had to guess. This is the same topic as being discussed in patch #3. Could you
> please add clear definitions to eliminate the need for guessing?
> 
> 
Ack, rephrased the changelog to use CLOSID and RMID terminology to avoid 
the ambiguity around "allocation and monitoring associations". If you 
agree, we can use CLOSID and RMID consistently throughout the series.


"fs/resctrl: Introduce kernel mode enum

Kernel mode operation enables a CPU to use a different CLOSID and/or
RMID when executing in kernel mode than those used in user mode.

Architectures need a common set of kernel mode definitions so resctrl
can report supported modes and indicate which mode is active.

Introduce enum resctrl_kernel_mode:

   - RESCTRL_INHERIT_USER: Kernel mode work inherits the CLOSID and/or
     RMID of the user task.

   - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses a single
     global CLOSID and/or RMID association shared by all userspace
     tasks. The mode can be enabled or disabled on a per-CPU basis.

Signed-off-by: Babu Moger <babu.moger@amd.com>"

Thanks
Babu
