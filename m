Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479735;
	b=KMHmsNxz/rgA6CNyTg6D2e5eUDA1JXWC3+KBlEKCEhEO3fhhoijvzn2p1u15WopMN1ve
	 v8MvNsX26aO+P9B9VJObMZBe47H/cq2Twq3O7/wy3h4q0B+dBTMI79azj3iMEu46WLvMi
	 vW7h70Bp2b9ynCjbocEwQqKBL0RADdQpU+3z71EBOrwJ92c90n3PY3Ircfo9hFkcih8FP
	 nG21lYiZMOvSUQfrF4zn8vyBHFGiuy14zOux8aUdZY+9xwiR0P5PU30nL6UAEoeV4fxSm
	 5JKZ+2ZhWEQ2JRaolV+Yyj5K3fQClai/jCpv995MBSgK71govtLPBv1/Kb52JYOSWZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479735;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=VJkPV7lNk38SGRScAvIW0BX8z5gERRhP1UbVTgxBjvw=;
	b=XrmTu3aux2k+X2lZBBY2PcEIukCbhye7fxR5FRcalXrY5PRasd4jN4uoE3+wvo3TPdFt
	 ZJaMKWbT4JyFOO4ASYZbbvlHNxwO+wjpUqKvnYZyW5ghzP9abo+PrIMy5MtE+okgHjgPD
	 u17IpHFTGMqXI6Sc9s/vaNRqI+uzbHUdpcExPrYDG362XwHtDc5t+0CoYQVHRM/qY+1Kt
	 WUhToX+pK88wTiv+QpMBRELqjrH0ywf1XEo438AepjsZb98G5fZStHCbA7SAg9fJWHqfh
	 hz4X6mzmH0KdAjeJY0U/5wvVZw5dRo6pvak+IEpk+OCPMSO6C13pylxFY3W1etxzlGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SQ5gA1S5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.23
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A44606A31E;
	Tue, 24 Nov 2026 00:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A44606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SQ5gA1S5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIxFPhm7sBx/htR3UkZ9VYUmMsNxR2e6CY1fzJlOM23bj363GqS+Z8cE3RYVRos2BqE9sALYf4nkERmY5ZxHMRwhefqCpDXJa6v5X1sJjdCMW4tL0kGDg11XsusemEfqnjtBY522pHMzQFhBLbJr/MOYnOz3zFt2B4885Fvo8KxbbVo0TiSyJJlFK1yTQTqs3ZdmFDJ2CCf1GB9WGk7kpkI9N15pqMlg3xUmN4CKzm+t3msh7kQkljc7jdZ6YVB3NGLKSkyNMoAxonGFdaogohHGLW3zuG/xPlATPSMKOivPDGx//a+WxQBtufXOv5RnyqqEeevF0pYAiIKQjn5IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJkPV7lNk38SGRScAvIW0BX8z5gERRhP1UbVTgxBjvw=;
 b=ylh6j6QCUMBa8AS4g7T3/pRlBRln+1TP4gxnzQW+muAUZsLMS3M36WAqfT0ffK8UlfHn97OaS3+ltVZwM23CZVKCo50Xadent8s56nA9o4O0umM4/0Re5lElb9GZrrVyX0arSCTLuxcFNO3rGKNxhTyr/EPIFE8o/xeR/ixWYmO+Xoxt4/6w+e14xIKxbZQEtl96t3hdS1FyD1VIQr7OBy1mSp6JNn0SKd60aMCe43QQHmHQWkhz4jXN/n1QGZz+wbYg9ojSj6FEq4EFjwXUTZAXTREdqmbVf9dP9UMl09KG42Rnhu7v/iFa/g4cYKPEwOA9dylmc9Y9+KB6hDzVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJkPV7lNk38SGRScAvIW0BX8z5gERRhP1UbVTgxBjvw=;
 b=SQ5gA1S5qlQ5V0t/L0M+p0SxhrPyDl4WiA9dAQz1kB391wnLtN6NUWBX8yEwK1OoRLEMCZP4TVhAbTpv7IDHN1Og4MJ3k5R16EDFXjbmuAh+kXczbmUa2l9btfzIJqsJ5+m3HI66DwnYYkm4gE0KF+cXb+OvRpPEDOPxGIaI9Gc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 00:22:12 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:22:12 +0000
Message-ID: <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com>
Date: Mon, 23 Nov 2026 18:22:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: Borislav Petkov <bp@alien8.de>, nikunj@amd.com
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, thomas.lendacky@amd.com,
 Srikanth.Aithal@amd.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
 <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:5:330::15) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
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
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: ddebc612-2197-4e4a-757e-08df49c0fbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261026121527099003|261022115727099003|261021121427099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|261022075727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QZm8/4mxr8O1jWzXL6CGcTNB3at6/89WKIFXIiLgdao9qF8e3QrrOOVwyk9Ey003qrAwjouWqZv1ULob6FBCOkQOMpY6XtBthfkcOg/3z7VAT7QHcleApe2yYweDnkGUW5cabEa9tW/CRWlIjuJP9tBFya7P9lEIXKf8jn04XhnWDRCdtxSDPe9PmGdAUxUOCoyOJhJqgN0KWwnuX1QDnLI2dgq+ac82B8FpzUtS2Sva5Rd9Mb1/icIvfkR/yNeujen1Ek7r4zoDtQ6T/xqrtnzgf9itqUEwJ+q4HQmA7foO+HN8ZLh0QuOe/g8o1MHhpPRtDdnxHXJS49SU9oZA9AHxj938XVPe28ZFkoRKKZuh7pytrFzCBMJI0EN2amqLe1KeQNmL02E8m6TPLbmqiLriKsauLuZgtmkOoGDg3k4fKmTTwOpALKX9DxO5y4L3Zw/3T6fftb/0lS3XE8PXzhPlnBcB1h9j/IsXX0R+bemtJaHWVow2NtgnqfkO0CN9b8CJhx4sBf0AVBHWtOWfumu13DMPnnBZkLic1EzyvV/7QHMZuitq/BHKTS9mDT6StgnpGNTIAXHgl1wjMPYkogbLL6PmhKD2rYje/9YV7g6QqYRAxLZsUoAOc2C1CuY+G+hbPtFq5XBxM2QW0DM+jCV4dlz1dPcfNbSFkFqm7yY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261026121527099003)(261022115727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261022075727099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTg4bkZVWE9QdG1TYU5Ya01DY01pRTBHK05MR3FWaWF5eUlZMTNYMEJuUFk4?=
 =?utf-8?B?V2ZnZStReEl0YmJhQktnUXh6bjRnTEpqMWE5aE5KblRiVnJnN3FMU1ZPNmVh?=
 =?utf-8?B?U1RkL0dIcHdRQ0RPZDY1Yk5YK2wyMWhjYmN6UkNKcnQyMk9LQVkvZ2ROZ0ps?=
 =?utf-8?B?RDhkMnpXNUw4TjhKTGlFejNvcWJQLytxTFlaVmExRVBWd203SlhORDRNVUdK?=
 =?utf-8?B?cmFWSTFtNmlHM1BWVk1xWElZQXJkc1FkTGVZZm5kZHA0bkh2YmJhSFhNMXhJ?=
 =?utf-8?B?YnFobVpVMlVXT1pINUk1ZFBIWHQ4VkF1Q1d6Y1FhczFlRmVIb1VSR3FDaWdx?=
 =?utf-8?B?VUU4ZFhmYXhPeEFFdVNtWkcwemI1RkIwd05UUEx3TVFRNE1RMzlUdURFZThQ?=
 =?utf-8?B?TCt5eUI0TEdkT3JOSXBXL3BiSVB2UHEwby9ibTFSS2loUzkzVW4xM3RubXJZ?=
 =?utf-8?B?dmtSemxpbmwyVDJPWTFpNStrWk14cFJuTUVnM3FjanpQVEdhVjZwMGtFRHdD?=
 =?utf-8?B?bm5VQjJYVkF2UStnajNaTVVkaENRdElVdzc5Z0MwZmZPMDlvd2ZiVWV1d1Aw?=
 =?utf-8?B?MmZGY3Rack0vRnNqQmF0UjJHSDVaSHpRY1dCeGFyYVRpaDdGM1I2TUlLdFdV?=
 =?utf-8?B?Q2hFWjkxT05iT29ad1pETTFXUXpnWTFzZGJXd3AwektTQkRjZ2tYZnU2dHpW?=
 =?utf-8?B?WXU3aXZ1aGxZTFZ0aU1lM2E2R3dZYUxvWVoxaTNpWXlUYkRCajdRVkJSUlJt?=
 =?utf-8?B?c1Ztckw1WVkyTWIwSlFHbmM4L0ZVTC9ndVVVMlJSNmRoU1B3Y1NsTXprTTJq?=
 =?utf-8?B?Y1ltN2JiL25xN2NGYlZyMG51KzBZSTNEeHNyUVZhWkZ5ZHNRbUJadWFSdjlG?=
 =?utf-8?B?K3g3dHlFUWJxQU5iaHBXdzgrSFBmVlQzazhENXVWRE53UHJBa0o3dDl6bU9t?=
 =?utf-8?B?ZU5NeTlqeFR4cVhzcHJLSTMvWjNDd0pNakM0TWJZL1FuZEQ4aXROTmJTYTBW?=
 =?utf-8?B?UkNERGJ0VVMyMTBucVBSRm42emxabGgzRWxHVmhCQXdNdkpxY1hZWVFrSjM2?=
 =?utf-8?B?cUVHNkFLSkgyT250S05PWXFRR3h6RWNYNkU1MUVLVEI2UjJTMk1hSitYVWo5?=
 =?utf-8?B?ekVIcmU2aEd5aEFQVmdhVmVISDRwMGFmeUdpY1lmaStyQ21QZmNTQ2p5OTBV?=
 =?utf-8?B?Q21ya3NicVNHamZOazdWUk1BVWJUNmduZ29mWFFUTzRNb0ora2JaNkNNTkdN?=
 =?utf-8?B?eWF6YkpDcWx2U0pJcG5tUkJsdGdFRk5hMXk4VVhtTkkwemZ4OEYvWXY3U3Ev?=
 =?utf-8?B?Z0F4WjZGRUNObmZCUlN2Nzc3SW52dTk0bUl0MFJTYUxsTGVPRnFyMDZIWlg3?=
 =?utf-8?B?VUplSWtxUFdQYnowaW1CVG9QenpzakJoWFhXSG9YWGNXbk5NSC8zU3BrNWpW?=
 =?utf-8?B?eGlhWUFGU3FGZkhDNXM1OFR6eHJvOXZ6dS9SWTJYY0ZBVlVuU2plcm10ZjNv?=
 =?utf-8?B?bFFDTlBZZnVKUmpCVHc4VU4wTTY1b052eThhVWtVSzFOMkJMWGJYOHBPbnVT?=
 =?utf-8?B?ZnM4d0lkbFlXeGFTdHhabnNEcG5HZlZVcWdjeGp0UE1Qais4OExPN3MyRHRK?=
 =?utf-8?B?c0ZFTkpmREIxVEx6c2twSXNFQ3l4WTZkMWVNSEluMGVyL2FSeVF6UjFvall2?=
 =?utf-8?B?MlRRTlZyUG0yZTl4cmNCMEcvclhjaXJRUkU3dU15UkFHbTFLbUZteFpkVHhG?=
 =?utf-8?B?ZmVleGt3WnFLcmJJTkxXc3lXUlBsMXRIVXR6dlYvdGtEVHhjTEs2eDlZV0R5?=
 =?utf-8?B?d04xYWFPS3QrUDA0WmZvelVBM3pmRFJCRGhVUWpYUHU3RldaQVMrUnh0YlE0?=
 =?utf-8?B?OThhT1lsUmZqdXFONVNmbUpTdnhSVXkzQThxbUZNdzdaZTZHN1VyZ2ttNzJ4?=
 =?utf-8?B?S0tSR0VlTlJacG8vcXVDcCsyUHRGUnVPdzJVVjlEd21oTEl6SjlSL2JLR05Y?=
 =?utf-8?B?cHRmRW1QOEk0U0pDeW1QRUY3UnBSUTVmVWx4UWdVQjJYZGk1K1dMVnNzYWUr?=
 =?utf-8?B?YWFOTjZWUE5BOVBxOVFqOVlnUFloRFhSemt4eVdjQWd6SDBqTTFYZzdSZGp3?=
 =?utf-8?B?SDJOcTJlTHZwamdPUW5ScS82eUV4V3NVdHlNdkYxcVlCd2tlWndzWGgxU2E0?=
 =?utf-8?B?dDJ1RVRmZDFsLzRYdWhTV28wck9QZ3ByUVdIRjdOZHpyb09rZWNqbjBhcjlH?=
 =?utf-8?B?dVRZRXZRak5zSGFpZk80WGlWa1dVUHBDVzJnWVE2NmF0dEMvK2RTcGh2bUJN?=
 =?utf-8?B?aFVCaUtnWkVkVmhkMGJTUUZnQWJEaTVLUFJTay9pL2pQdUw2bnJLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddebc612-2197-4e4a-757e-08df49c0fbf7
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:22:12.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6meVHGGcFtLjiTsLZsXresMHzWhCtcAn1yHA+MFiztoyDntfm4fffbqNsYHyZnm3Qrfq6qwiWRf8Ox7uFkpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508

Hello Boris,

On 11/23/2026 5:43 PM, Borislav Petkov wrote:
> On Mon, Nov 16, 2026 at 11:03:35PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
>> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
>> intercepted and delivered to the guest as a #VC exception, which must be
>> serviced through the GHCB.
>>
>> By the time machine_kexec() runs, snp_kexec_finish() (called from
>> native_machine_shutdown()) has already converted the per-CPU GHCBs and
>> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
>> GHCB infrastructure. The DR7 write therefore raises a #VC that
>> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
>> fail.
>>
>> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
>> Fix early boot failures on SEV-ES/SNP guests"): that change makes
>> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
>> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
>> rejected but survived) into a NULL dereference.
> 
> So, before that patch from Nikunj, __sev_get_ghcb() would return the per-CPU
> GHCBs which are not initialized. That was fine for the kexec case - I don't
> understand the bogus VMGEXIT thing - but apparently it worked there.
> 
> For Nikunj, though, that didn't work because FRED can't have early #VCs with
> those uninitialized GHCBs so he falls back to the boot_ghcb.
> 
> Now, however, boot_ghcb is already cleared and DR7 writes cause #VCs.
> 
> So something about the lifetime of those things is still not good enough.
> 
> So it looks like this, AFAICT:
> 
> ---
>                 cpu_hotplug_enable();
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();			<--- destroy GHCBs
>         }
>         
>         kmsg_dump(KMSG_DUMP_SHUTDOWN);
>         machine_kexec(kexec_image);			<--- DR7 write needing a GHCB
> ---

Right, the window is: snp_kexec_finish() tears down the GHCBs in machine_shutdown(), and machine_kexec() still executes instructions that #VC.

On the "bogus VMGEXIT": before Nikunj's change, __sev_get_ghcb() returned the per-CPU GHCB, which snp_kexec_finish() had already converted back to private. The host mapped that GPA, read ciphertext (exit code 0) and returned GHCB_ERR_MISSING_INPUT, but couldn't write the result into the private page, so the guest saw its own stale contents, treated the call as successful and moved on. The DR7 write was simply dropped. It worked by accident.

> 
> And snp_kexec_finish() does this:
> 
>         /*
>          * Switch to using the MSR protocol to change per-CPU GHCBs to
>          * private. All the per-CPU GHCBs have been switched back to private,
>          * so can't do any more GHCB calls to the hypervisor beyond this point
>          * until the kexec'ed kernel starts running.
>          */
>         boot_ghcb = NULL;
>         sev_cfg.ghcbs_initialized = false;
> 
> So here we've switched to the MSR protocol.> 
> And the MSR protocol is supposed to be valid at any time, exactly for cases
> like that.
> 
> And we do have a rudimentary do_vc_no_ghcb() for when no GHCB has been
> configured yet. After all, that's the point of the MSR protocol, no?
> 
> So, long story short, how about switching to that no_ghcb #VC handler instead
> and dealing with the DR7 VC exception that way and actually using that MSR
> protocol for what it has been designed?

As for using do_vc_no_ghcb(): the GHCB MSR protocol requests are meant for specific guest-initiated operations (protocol negotiation, GHCB registration, page state changes, termination, etc.). The only one that corresponds to an intercepted instruction is CPUID, which is why do_vc_no_ghcb() handles only the CPUID exit code and terminates the guest for anything else. There's no MSR-protocol equivalent of a DR7 write, so the no-GHCB #VC handler can't handle it.

Thanks,
Ashish

> 
> Instead of piling more cards on the already unstable house of cards?
> 
> Hmmm.
> 
