Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794884821;
	b=IuHoaeKwWazhjG32K/LHi1u30P6r0vC6yRXjaVCk4250DEL9fsnwnzUwjr1iSQ/1H5pC
	 J/d4Yzqpc5qbf8uDzD8rfDdpnNexAwJq3ARc4LKunngwl/HUhWn4cBaTZqpENK0UX4q8i
	 EBTi63r/YUnrf+eFHeLty+XYemyNExerMVUrmfHXKYkGWoZrTtXS74RDokcNjHLpS6XBW
	 Nc4eLpzwoVJ0xoiHPBPf8ip5bEurtpKHj7SSbSnbI1a2eNJ5TViFh509Qfqjmkbz7Ox8o
	 BrTH4XzUPEoYQHhL+RKcvjfX0gYkHgNVwKPBizeNTzMtrLJWqKLgIKMHWagbtj2qRAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884821;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=sOhdfQoq69ElVt7wOSLvb0bMiErXQz2SrDCJYjLzKRI=;
	b=rrI8BhakkNVlu2HjksOnGLUPEGtlT6t4R8CE7LcjemCleQPMwKI3GzWwA066mHVhhlXn
	 2GAczp/yYsb1WfpCVRg1ZqBm2VJj8EBBWTjidnTEUi2UW/NBTOFRlW4PSMPgUdVNFR/co
	 6XBKWhKCB48UbCUvNrmSBdXhyI1Wxzy/ztbS7YPG4wQEckRUYfMuxhBDgFsRnNqNIzytL
	 jnqHa/Es5uIQh1Wd27khPRA8WHO2/o3SUtxNONeBWq7/410a1bPcEt42+xUeWp15UXGvz
	 6xDeCkzuwARx7B4AQ29u7aABfcyKmNkMioYUmgHdmY50Lc39prxHPyZvtMRJGdOzHxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kgjOA6iA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB49606A31C;
	Tue, 17 Nov 2026 03:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kgjOA6iA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXlJaVkNr7XmLZo6C2etfekBoAUv5QzRhWXVE7kiFaqhQ3PrUF+xV13XOi1r13NeQLYf6P6lcQTCskNkHimVr6XSS1DAp/oxHABJlzLajgRUSCsMRcED6kZfBgTe64ZEoHnv+jIAgUrUwbywGNpD0dd+keX6VWCUQK2Toof55sCW5cGPbNQpAkau5S8DV06IitejdoEBQQ5z2M/be4uBFiWjVrQwqTu9K55AqRhPp20dxUD2yk/gUVI41HJeswCiSqvK2Hbu/H3/zpJQ2FGjguqaSWPjySFdKj0am8ajxgi5LYI+KcS7BZrEwv3oYYu3GE2Y4TLoK6Hf8ZdaJyEI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOhdfQoq69ElVt7wOSLvb0bMiErXQz2SrDCJYjLzKRI=;
 b=sE++WU5U1heDNvxgnexKr2wAun8PBGa79wIXv+BX6rK7bHnAljasc0za4CRnmxn2VMOK6E0H9/bIw0M92Nep8VtHWqli7+cQ+XE/a84vkFFH19eVlaix29yTZeaTcVV+xaMqcaATlxZpmWbfKDabzTQAl/h1V73R8+RgNRWHqLNr5ETTJi5DNWr5oQGJGOT2EPns3FgO242iDL4+9TWMGPjjJf1yX0BUMnLeIFca+FKjFP2Yf5sNG2R0P2epiONRRcswcPk4tCgZPTJn6wnitL3cRn6nVhlIw7V3lauZf8krzlOEJqug7bK/6R0JAvKHpgVRyonZvgPz0qfr8qiwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOhdfQoq69ElVt7wOSLvb0bMiErXQz2SrDCJYjLzKRI=;
 b=kgjOA6iAMfPUQcBAZBV3vq6yBI6q7iGNPphXjSM43RIorKJL5mVGoqeeKKXBUMZs5sJWqXBuaB8oDD1PAQyD7hPtaGi+PdhMn5bokD5E//qsMfbDZjc7PpZQ9mKnaxF7R4t2E3TlHjDxAFaxlKyZq6h6BEgsuH1Y3bc0SbIoubM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CH3PR12MB9729.namprd12.prod.outlook.com
 (2603:10b6:610:253::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:06:55 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 03:06:55 +0000
Message-ID: <3c82411b-dfec-4b26-9e7f-777c8f1ecb6d@amd.com>
Date: Tue, 17 Nov 2026 14:06:47 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
 kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
 sohil.mehta@intel.com, adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com,
 artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0070.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::16) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: b4780fb2-42d2-42de-8f55-08df4457d627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003|261102124527099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	QRm3OvKMtyLsgxSLZE6B7QEFmZWlbQGtdOZS9P47S/V9CRVUSrOBleF/cNkKeWrLrj2uChA55QVNk/1ioB7DY/+19FxjrSJIHfkz9/ebxLfGZG4COQNiyrX/KXKR6yE9vLyJQlNPhbUHZFfk7KlZUzJ56h7/vNGFdwJYGbSHlYTQIy9jw1zAe9X8PtuNr6pjSY0Q77DcI+KLcgRHHS51UyNoUqDQwV1eIh4dR7uKCjnlxKxDD4N/oJKgYHihN0qAWWmeJ8y/qoHL8anZXCBcnSLDsY+nZn8rhIjcPIHFlt5n2nRztSkO3ZqJsiemU6Nsk9vn2pC4kDlzTN1z0np16nfXMtCLTThKVCKxYgv70KgX4yUq/+nG69BIE73Hrbdo9DtlfFeDU/ZJBkuEG6FcoxyjEmcF3dsFC5OZjMraFaj+keqK9UFHmX6aRyvqYWYITLQwvOr0gugYyffqloVd3Zkfj9L78Dt80qqoLOfbu/CD1BovSxMf0wxeG7sv1VE7EE/jqAZMutSHHBohi4gZwJHoQLiWDgmV4UEDY+nJhIcfjtzYSyEPRSwJ1GUomOxldoVu7ctR1nIWBjlDSWPfrERGRPD+msZ0wKyRzGfw8QrQMbIDezsSmN0RSY+nhs0XyrrFX7eBvOpyZIzKAdwBMz+X7igGgiSgjy0zUz7zlPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261102124527099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R29MRWRmc3o4RXZmWFk1ZGYrYjJIeHg4OEpFdjVFUmhHdjI0azFvdW9Zdjcw?=
 =?utf-8?B?UFlSTFoxa0FDK3dqWnhLYnhwNGlCc3JPMXJzMGFpdHhkL1ZjaGUydkNMMWhE?=
 =?utf-8?B?KytsWjluVTBKNFNoN1dqbUxBdjlGOVB2cXlna0VKV01VOHVMd2tPUndIWFZv?=
 =?utf-8?B?MnhIeXRuT1hhWGxBMUJNbm9PZ1dPTkxWSi9nS3VVb0xUWm5VQlhwNGJ5WDd4?=
 =?utf-8?B?Q0FIWUxGakpRVEZVUzdvWElQZVRqSjNxU1dnTnZWdThKb3hDcnUyem9kNWlW?=
 =?utf-8?B?Z1JvVnk3aVhtMWJsSWFra3VocjgzZzA0QzhsdG1wS21MNFl3TU9HRUEzS2F1?=
 =?utf-8?B?bFlUS29uNXhoUjBDY3pzbnY0djJUbXFSRXhLVGJ4MFNRcTd5ektqU09ib0JW?=
 =?utf-8?B?bDlGTmhhbUsrUFdkM3VUbzNlRTNDRW9DNjRlT3Q3L21Vc2dMNXlRNmdhU0cy?=
 =?utf-8?B?NDh6THMxVGJPR2xGKzM3S3N0ckNFTm5uUFFyMisvMlNGSmJPQmwrLzVBN2ps?=
 =?utf-8?B?OFllREhkYWRZNGxqcnE0MndIZEE4VzhPVWdXL1Bubi9ueUpRTU40TmpDYWo0?=
 =?utf-8?B?eVVMQWF4d2hDeUtRNXBjZERNWDY2aGJlcXU1dGk3bTZJeWNwTS9IRnhpQ1F6?=
 =?utf-8?B?cjFDczNPUnpOVVJxZE44NjY1RDlpM1V6QkJ1eWxNWlJrY2dpZ3RnYzBWSXVU?=
 =?utf-8?B?VE1Zei9lNEIvYW5rM0ZLYVcrS1Q2cC9La2xlem5kajVBYWh3NlByeXorSU0z?=
 =?utf-8?B?SVlvbmxJNzNvY2k3MklTWEVYR1RBT0lIcFZ3YmREMTJVQjUyMjVkT2ZPNTJW?=
 =?utf-8?B?RlYwMCtyb2dxb3JCZmZBR1FVQmc4MjdtU0pFVjVrOWo5a21mYk8zV1pDWFl0?=
 =?utf-8?B?cG1lQWhBeXJ1S1V1Y1JrNHlLQld1QXpmY2dKSUE5bFdkc3VvM0JHTjlja3Qv?=
 =?utf-8?B?OGdONkRQMXJaZzk4TnlURGlzU1pTZm9MUHJQNDczZFloMnliU3NzTG1URVFC?=
 =?utf-8?B?b25SOEhLRkVoWldLdlhtS09PMWRueDYrYnRKZnp6TDd6THlYbFlMN1U1U29P?=
 =?utf-8?B?Z3BKTTlMYTNxaVdaZzhhVnoveXJhbDMwVjlGZ21nZlh4WnhzRHNUZVREckY2?=
 =?utf-8?B?OGV4aEhlWWJ5R0RWT1ZPZjFDdmQrYWFLRnpSTjR2VWN6ZDdQU2xRc1grWFdU?=
 =?utf-8?B?VGlhTUwwcXhHdlFMSFhSb1JHOWlEN0lLQmJib0VObWlhM1NjNW9WR09nbmRQ?=
 =?utf-8?B?dTMzNlN1alU1MHZ3eHFscTZmNi9BVkcvYkNDaTRKMzdRTzNBYWZpejRhWVRq?=
 =?utf-8?B?Y3JtNzBGYkkzNU9TVXB3cWRvTWdPcXc0ZUtPZjA5aGlhbVlTZklWUjkwK1ZS?=
 =?utf-8?B?dnlXek0xdkdFL0VOR0FOR1N4bzgxZ3hlY2RaclBIc3dNUkxLQjlRcUNWN2hz?=
 =?utf-8?B?YXZQSGdZUFF1OHZLWWovc0FGZGxudUNlZzdIL0c5V1F0enZudEZXbm9LRXZm?=
 =?utf-8?B?WHRKSnhwNG9mOWtHL0pFWXkrZVNmemUvczErYlc1cCtiUC93RzAwdjdKbmVV?=
 =?utf-8?B?K3hQdHhhQ3RyajFRRzBrNFRzWVA1VXVIbUtCWFZNUFFWN2IxRzNPMXhkd0JJ?=
 =?utf-8?B?ajZRSWMyVk00TU5QTWxhQ1IxRy8wa2lqN3BUU2MreEI3b0d0TDVVYTJFSWxY?=
 =?utf-8?B?WnYrNkxyS2dtcHVPMjZzWlJkRDltS1B1YVFRT1hXQzBaTWpqSHBFS2tIZ01T?=
 =?utf-8?B?dVdZdWJKcXUzdFU4dHh4WTkwRHVYTVIrUmxzLzNYcUVBZ3RJc1YwcjloMG9F?=
 =?utf-8?B?Y1JESG9iT09SdGJueWRLWmx1aXY2Yk1QOXdGaFFGVlRMOFFlTysvZGhTRkNq?=
 =?utf-8?B?S2cydjczbUpxeDV1bWlkK0RWdUxMWkJIM1RaZUo4Mkl2VWJwYVBwR0dmM1Rr?=
 =?utf-8?B?VkpEWEVnOHg0VStYUFBHMXhuNCtYS3RGMHVtRmtkUkplS3hqdDJZVThZWWQr?=
 =?utf-8?B?OHZNbzcvRCtza2Ntb1VoMEQzU2VZZHJtWFd2cUcwdkZweDhvYXlVdWJMZDgw?=
 =?utf-8?B?dnZYR1dpbEliWDFXajRLaitzRzdSZDYvUkhuUEJHd2NsU2ZCcnBYWEZuYmJo?=
 =?utf-8?B?UVFnd0xOUC8rcVp6ME5RRmd0dWFaYVh4ZGhGT0JYbW8wZHRJaFQwaUlQM01J?=
 =?utf-8?B?V1hEN1lUZFZXMHRSWS9YdDd5aWNKYWIzdnZHaUtuL0p0cmdQQzQ4T2NKTUE5?=
 =?utf-8?B?MTFiMjdGUGJXenpkV2lHTHZOdUxDL0ljZjFJWlJDZVl1T3FWckxOWWVjb2NM?=
 =?utf-8?Q?IAD+YODrHC9t5KrEpL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4780fb2-42d2-42de-8f55-08df4457d627
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:06:55.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwGTxp/9ZavnnkeXnLEgPpMofrVsCyr5WvmrWnsRjqqnlZflSf42jOlbq2qqGLm6SgMoZ3kiGHdC3SshaZKYDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729

On 11/11/26 14:48, Xu Yilun wrote:
> TDX module extensions need memory for their execution environment to
> serve SEAMCALL leafs. The TDX architecture implements the extensions
> in such a way that they use the memory outside of SEAM range, so the
> kernel should add the memory upfront at initialization time.
> 
> Introduce a new memory adding process backed by a new SEAMCALL leaf
> TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
> allocates it, adds it to the module, and never gets it back. Note that
> the process requires Dynamic PAMT backing. A subsequent patch adds the
> support. This doesn't break bisectability cause the extensions can't be
> enabled yet without a feature that uses them.
> 
> The TDX module accepts the memory in the form of an HPA array. This
> array is passed via a single 64-bit SEAMCALL leaf parameter, which
> encodes two values: the PFN of the container page holding the array, and
> the number of entries in the array. Create a helper to encode this
> format and name it after the TDX module term: HPA_LIST_INFO.
> 
> TDX module extensions consume tens of megabytes memory that will never
> be returned to the host. Use contiguous page allocation to isolate these
> large blocks entirely. This is a simple way to avoid permanent memory
> fragmentation: requiring the full size to be contiguous is more
> expensive than needed but should be good during the boot time. Print the
> allocation amount on TDX module extensions initialization for
> visibility.
> 
> The TDX module provides a metadata field "required_pages" to indicate
> the required memory size. This metadata is meaningful only after the
> add-on feature configuration. Don't read and cache the metadata in
> tdx_sysinfo. Instead read it right before allocating memory for the
> extensions, when it is guaranteed to be valid.
> 
> The original changelog was written by hand. AI was used to help correct
> grammatical errors and polish individual sentences for better
> readability.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> An alternative solution is to use a loop that gives memory on a memory
> error code - TDX_EXT_MEMORY_POOL_REQUIRED, add one page per iteration
> until TDH.EXT.INIT succeeds. Something like:
> 
> 	do {
> 		ret = tdh_sys_init();
> 		if (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
> 			tdh_ext_mem_add(); //single page
> 	} while (ret == TDX_EXT_MEMORY_POOL_REQUIRED);
> 
> This approach is slightly simpler as we don't have to query the module
> for the total memory, no memory pre-allocation or segmentation math.
> But allocating a single 4K page per iteration may cause permanent memory
> fragmentation.

Why not allocating new memory in 2MB chunks, reducing fragmentation? Thanks,


-- 
Alexey

