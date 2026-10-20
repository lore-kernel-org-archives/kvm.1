Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792455673;
	b=TbsRKniPbuzK0FtdAsGpHcP++CTwLLKfuXg/75TqClZImKI63bunsNMPfWIRhjD4Ar3U
	 hkf3VZjeIcM9ehpgoRxVz16XbQd51QWVW2cs1XiWUtFvugywMzeWTl+uSSWr38cYWWrfK
	 giDDfWnCJC2LNnr9JHalF68G9UQmdw+TKiaaZAx3USh4Y+CoqBgLjOn9xKMyrDB4FBhC9
	 qnjjyBfvKnsh+XkLM4J6ilwCWc9E+DEfwg2fEZvAnIKD48pe6k2gAMFnRjYkLo4CAKIY7
	 V2MeGBltfRsLyB0kAH3mRJRwS0Cosf2Ocd2C0UjC/3hc3hmpqGwVfToksH7Dm1qQbrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455673;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=rP57JUIIoDpL9pbG9P7jUPChtXNbvEIdYKCzK2H2xvw=;
	b=ilTq0P3ZKdm4ZJQbXuzmgUAHfar2ut/ZlZH1AvzM2G9+YYvrmcXsrSLA//5z67SsnJA8
	 QFGvhM6+8GAJWxSGdEBPs6AXpvFal93pi6cFIKb8f4s2YXpamBkONK71O2/d/uyePB6o9
	 vV61InZzLn59HOfJpKVhZnzq2bOLoyFYOVtFSYzINRxBRQIPzckq+S5qgIt2wtefcRcSq
	 XPnQxfBle845D+HeswDST/Tiug+80cGGeRrZSy+iVv4FOWSm+uxIC0/n9ec8PDskZ99Nv
	 EpW46wxu0lCBcHUZYcrKE6cwWFsYlC/yv5s2TX9UV3k5gc/fnkmTBYgCp0W78X3nPHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YXAFTTCJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14759606A319;
	Tue, 20 Oct 2026 00:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14759606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YXAFTTCJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqh3lJGLMSftpoEY/gTVLwtXC1ppCI6xANfLuUl6JsPPN0JAlL1rbZuwX4fmCb3fVuXjlG66FDbJm3LgESdvW9hHoGRi8cLDxk76tgs9tP33rQs9VtaDO2WDygeglAo8oXsuhQgIKS7q2IcvAzgxNECYxSnoUsYgFve/qYfJd01f9Ov/4wVJ1XAkIY7CuHnYOH4FKFy6FHpiaJ/JbdpH77IJbNBNgaea7PSv/soJPo1l+x/mRm7lkAoC1WIKZM+RTpDJUwyzfKzAf2fK+k/4jL2BiwyWjWbmeoyx6VvYhzMM3u/7kvniUmN5rXHL63278vDIeze4NI8xUKZjzIGPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP57JUIIoDpL9pbG9P7jUPChtXNbvEIdYKCzK2H2xvw=;
 b=YEBp6GWuRXsfMkwLqMLmNO/Y3XWwpUO4XTvc/eMueKy9Dpru2MnOeC4W7uHgKEzsqBs17b7THbtWpRb1f92CLDLHiVdY9Tf8PkT95sUFw9tWEEFnO4MFmwdNeZ5WhD3JKVr56/PtxUaoA3qoIlqyNo7FQOXPqz2+mOD9n4fbNaql+B5hy9Qj+FBvhOkk9OueqANny87iNkr8I8GE5kyIDi5Nr7HtnAOayaxRNSPAhfXPEoAIH4socnm2f1mvz8lNMhkLUVZ0H6h3b1SoyNBa7QyAwcXC7mePnl1FwsQZiManxGDXzXvdeRHn6FNMRhrMuQg38/rNqdWc3fAwDlYwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP57JUIIoDpL9pbG9P7jUPChtXNbvEIdYKCzK2H2xvw=;
 b=YXAFTTCJ0NgkH5XyL7YY6RBk2ozv5eFVplx4uc89kWdL14GngfBLQWAYdQQPDd/Houyyj7LzY6TQwbf2lywNu4iii/RCf1sTUGZ8voXhIk4fSXBq2xNYFAE/cWrLnZWOCywDw0sig6hCfTnBJmZ9g5SdVwc6fAq1wdVZczc6ip0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:21:07 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:21:07 +0000
Message-ID: <ba24a74e-8b75-4eb3-9eb8-48ab7d23a711@amd.com>
Date: Mon, 19 Oct 2026 19:21:03 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 16/18] fs/resctrl: Add interface to modify kernel mode
 via info/kernel_mode
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
 <e22be68142d869873532f21e42f049414e1cff99.1790867441.git.babu.moger@amd.com>
 <ad3808a2-14b6-409e-a268-4572e8814f55@intel.com>
Content-Language: en-US
In-Reply-To: <ad3808a2-14b6-409e-a268-4572e8814f55@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: d92bcf71-5986-4af5-3725-08df2e4008c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|5023799004|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	q0e3bMvTWHdPxcjlO0s9r940JeuAOdefUFU/HgtvwKn8CBAI2/7CcjBsO/oCKpw7dUSBu0kX1fDSt+M1jYnDNeWwEiKy6TfH7vZ9nPlmSAgQeAssspUV1RfRx2h/AzSiIIIvmB2npOj0GRQh/KHegRodKiu+ZaMEW2QevZDK4RJycefBD/vzbWouEBroV+xfP8mVY1KGyT6ya3tM3W6g8AdMQUsQb/hHdgyN+x3Qc0DnSowu+/+5b7Tp8ayKWxn3GTSD/aXf/Jd9+OskSgZYKHqSIv6A3DL8DzFw0enmLK2hpfZXoNr3mdbQ3GNjm7MUFF+WM6fOpb7acvl5qyFhx8EMm9dIjBzcQpki2plaQhrJazCOhQeKrvIt9Vvp2nnQFaHP/S+GUQV5BzES0dtjL55wDSYYZIU2sTbJrBxlopTp2h5jtHa2fLEUgzEFQrxTTOiO3PhagX0223wXu2+YhMlRrykNkzYUwR/Vq0rx+vFrClWJppPJmx6QaV7w0Ix9jQXE/Ok5LWbyJrbPhNNZe60FxveMyL5u+mklGO6K+YqCHLiFT7bmFfz3g34iJYuUUxwp5PnvaKseahotVZHp64glX8om4qgJne110Qv+JzdLSOvKtcmDYhPNE8lpi5e5mgExbzKjiGQnNEDNqrl31kJi18dicxX2SzZ4TsjPgnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTJVZzNBMGZwa1lzLzB0empibXZNcGtmRUhwYmt5b2hnQlpwNUEvQmIrUER2?=
 =?utf-8?B?ekhGbmdFZllFSVk5Sy9HRGR6ckE3YVp3Rm1LYjduQTRhcmROQVJuQXE4TnpW?=
 =?utf-8?B?Z1A3Z3MxV1BIaUt5dEswMHNhYnAxMTBBUE9hcGdkQ2RLWmtCMjZPUGllbmN6?=
 =?utf-8?B?LzM4NXNDUFAycFNyTHB5UmVOSXVRam1uTFFsVXAyc1kyMDI4UWhDV2pCTURI?=
 =?utf-8?B?bzRzOWJCSlE5a2dSR0wydFNCeW5sckhRZ2RpVGdMazF3Q3JNYTZPK2dGUWtE?=
 =?utf-8?B?R1o0NEU0Vk9jUmpJenhwY3A4QStjb0w2cGVhYXdWVmg4Y1daSTZHTGhFd2kv?=
 =?utf-8?B?YWxkL1dpWTQ3TTR6QkxJdUlkL0ZnV0diOGdvMjNITHVQTmFuMFU3TnZmd3Zq?=
 =?utf-8?B?UE10M1llcU5heHR2cXRpcWthVmI1bk1FaThSelhmNmU0MVRnRldob2R5V2dD?=
 =?utf-8?B?T0JPWVh6Qm9aeWNMVUhnQ3NLRmtVWWZOQm5SSi8xODNuaHJwbG5xeWsyT2J4?=
 =?utf-8?B?YUNGbjlJY0ZTWG11OGkyWWFZOFRlUzV5VmwyKzdtbllURS9NMVhGWXRyWGJw?=
 =?utf-8?B?WVNqcVhsT21iangrT1F1NVgxZGhTS3QzNkY4K3ZKZ3BJcmRDcm1TKzN5RnN5?=
 =?utf-8?B?aW1CdHVheSszTU41RkRPVThHOHNSRHFtKzNQWjZuZnczTElOSHJVTkx6bFhG?=
 =?utf-8?B?Z2JKKy92dUdOWDV1N1hjWW9zVUp4OGRUeWVUVXpDcS9GTU96YU12VllucGdU?=
 =?utf-8?B?eXZQVTZmcUhWOU1SaDJ5MHNwQnRlRzAzRmdaN3FvUkQvTlNWR0puR2xIZHNy?=
 =?utf-8?B?bC9iL0NOVEJ1K0doNVd5WUpjREcrL3EyeEtUVFUrOWhVK0RBcG9QZGFuNjFk?=
 =?utf-8?B?NTc3dHR0ZEwzTFBoSHM5c1JXMzRuaWNaaHpXNUhmZ1lqcFNwUlBvN2NuVFVS?=
 =?utf-8?B?cUdCYmNiLzlUb2JPOUNNN1FmN2NjdVV0ZEVmTmtSeWpkUG8xUVFHMkpCN05N?=
 =?utf-8?B?bXRrNW9aNjhPVFdDSEFjMU50eVlhR29xaE0zd0dVWkREZWdaWi9DbG93MHlT?=
 =?utf-8?B?cmFRc0Q3d08wcldnYlZDTytZSHQ2UDk3UTNVVGNKaFkwMTlwSDZkSzlpKzdW?=
 =?utf-8?B?MFNyeFlEVnRTVU9xaDhxeU5CMjFVbUVXQVJ5WnZaUzZmdDUxRTVQb3RyZ2hm?=
 =?utf-8?B?RTc4amFaRlBsbjlSZS9aNGY0SUJtdFo5S0MrTHVZbzdiWHVXMGZJdWM3czl3?=
 =?utf-8?B?aUlsT1JRK09vSHRSZ1lGNjhzdG1MZFBwK1c5aWF5dS9ramFjclI4M1dCTUhO?=
 =?utf-8?B?N0NpK1dGK04xSDlEYWFaTms4SmUwY1VlL2NyWUl0TXZYYjRRdk51eU56Y05D?=
 =?utf-8?B?dFVLblZZOWx1My9oT24wZ3A2QVExY0xIOEZTVzFmd1VTNkhpTHdVNU9wcU5i?=
 =?utf-8?B?UmRXckVQTC9XQjJ5Sk1BZUtaaC9VODBWZzh4TlJLOFZOT2ZjbjJ4TE5HcGd2?=
 =?utf-8?B?U1hHdWRJZXcvcXJ3RVhyZzFrSEdRVytGeURMMHNReEVKQ2JjRmtWNzFaMHZv?=
 =?utf-8?B?UFNUTUc3ZVBuWkMvT3F0cDlVaSsyekxSZ2NsVHozQ0xjakFKRWRKeTA1ais0?=
 =?utf-8?B?Ykd3MlVtbVlKNkRVSEFkOHNkSmZicU41ZXVGdXVSZll5T2ZIa2Q0K3R2dGJP?=
 =?utf-8?B?MDExWUt0YS81VFZEbVhOT0tPS1ZWalA5MW14cE5TSHh3TzQ3Yktrd3lQT0dQ?=
 =?utf-8?B?MkhOajVnMlhycVc5NXFTVVVmWHhGdExaMThOWEVya2dqNnVQTTlkK1NkY1Ns?=
 =?utf-8?B?RkhPM3FjWVN6ZEZJWkRiSEFoOFlJeS9GZ2tuTzlrc1pSbFpLbkt3YS9NYTZp?=
 =?utf-8?B?N2lGcVlnV3phc1UvdlovbUUwOXFsOGp6WU5lZ1VXU2pLUDd6dlhzRzNwR1JT?=
 =?utf-8?B?Z1VENm1maGtOSnloUTN3RGNCZDRKVWE0bWk0dVR2TjZtS3djZk1kNFd4VlJ2?=
 =?utf-8?B?UFc4YU1GQittZmpBK0xSUjlFQzJBRXpHUnlvUmF5ZWpJc3dieGl0Z1BKbWpl?=
 =?utf-8?B?Q3RjQ3prRmdWNXFwaVRFdXplQUo4eUR2dy9MTlV0aHJ2dERvb3BaQVMrQzlV?=
 =?utf-8?B?MkFtWDcwZjRqcVdybEh3a1p2VjZiOHZ3czhLSEdJZngyZVUyK2xDQXBTbkVP?=
 =?utf-8?B?eEhDM2VBQWtoTmJLMTIwYmd2cm53UmJsZjdKWGdmTzBJQWE5MDF5MFo4VFVQ?=
 =?utf-8?B?MTJEN3JOMzNhRHpjZk1hZWEvemZIYnFRdWY4dXdsaVZCdU5mWENpdVdmZHEr?=
 =?utf-8?Q?g3Q7fh5h91+ihDXT+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92bcf71-5986-4af5-3725-08df2e4008c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:21:07.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpy1Hmfa7lkHtxU21B6caA+lXCks6u8MsUTyKxl13gF+PXTy+hqAW+NMBpHBxaUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

Hi Reinette,

On 10/15/26 11:07, Reinette Chatre wrote:
> Hi Babu,
> 
> nit: subject states this adds new interfaces but that is not true?

fs/resctrl: Extend info/kernel_mode to modify kernel mode

> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> ---
>>   Documentation/filesystems/resctrl.rst |  28 +++
>>   fs/resctrl/rdtgroup.c                 | 274 +++++++++++++++++++++++++-
>>   2 files changed, 301 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 73ccbb9594f5..bf9d34d6a335 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -575,6 +575,34 @@ conveyed in the error returns from file operations. E.g.
>>   	  [inherit_user]
>>   	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
>>   
>> +	Writes use the same line format as read, without square brackets and
>> +	with a trailing newline.
>> +
>> +	inherit_user is written without any parameters.
>> +
>> +	For global_enable_per_cpu, the parameters are optional. An omitted
>> +	ctrl=, mon=, or group= keeps the value currently shown. Parameters
> 
> "keeps the value currently shown" -> "keeps the default values"
> Text as suggested, or similar, will connect this text with the earlier
> "When the mode is not active, the parameters are the defaults ..."
> Although, please check earlier comment about the "parameters are the defaults"
> text.

Sure.

> 
>> +	may appear in any order. Empty values are rejected.
> 
> More on this later but I do not think it is possible for parameters to
> appear in any order ...
> 

Ack.

>> +
>> +	Selecting a new mode, parameter, or group replaces the active
>> +	association. A new global_enable_per_cpu association sets that
>> +	group's kmode_cpus to every online CPU. Errors are reported in
>> +	"info/last_cmd_status".
>> +	Example::
>> +
>> +	  # mkdir ctrl1
>> +	  # echo "global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//" \
>> +	         > info/kernel_mode
>> +
>> +	  # cat info/kernel_mode
>> +	  inherit_user
>> +	  [global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//]
>> +
>> +	  # echo "inherit_user" > info/kernel_mode
>> +	  # cat info/kernel_mode
>> +	  [inherit_user]
>> +	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
>> +
>>   Resource alloc and monitor groups
>>   =================================
>>   
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index dcf9f26540d6..73749e5a4ad0 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1216,6 +1216,277 @@ static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
>>   	resctrl_kmode.mon = KMODE_ASSIGN;
>>   }
>>   
>> +/* Program @rdtgrp on every online CPU and show its kmode_cpus files. */
>> +static void rdtgroup_kmode_global_activate(struct rdtgroup *rdtgrp)
>> +{
>> +	cpumask_copy(&rdtgrp->kmode_cpu_mask, cpu_online_mask);
>> +	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, true);
>> +	resctrl_kmode_global_files_show(rdtgrp->kn, true);
>> +}
>> +
>> +/**
>> + * rdtgroup_by_kmode_path() - Resolve a "<ctrl>/<mon>/" path to an rdtgroup
> 
> It is a contradiction to have description read "Resolve a "<ctrl>/<mon>/" path"
> and then the control and monitor group names are provided as separate parameters
>

ack.

> The function name also includes "path" but there is nothing about a path in
> the implementation, the caller parses the path, no?

I can handle all this in resctrl_kmode_parse_group(). Dont need a 
separate rdtgroup_by_kmode_path().

> 
>> + * @ctrl_name:	CTRL_MON group name, or "" for the default control group.
>> + * @mon_name:	MON group name, or "" to select the control group itself.
>> + *
>> + * Matches the path syntax displayed by resctrl_kernel_mode_show():
>> + *   "//"            - the default CTRL_MON group
>> + *   "<ctrl>//"      - CTRL_MON group @ctrl_name
>> + *   "/<mon>/"       - MON group @mon_name under the default control group
>> + *   "<ctrl>/<mon>/" - MON group @mon_name under control group @ctrl_name
>> + *
>> + * Return: Pointer to the matching rdtgroup, or NULL if no such group exists.
>> + */
>> +static struct rdtgroup *rdtgroup_by_kmode_path(const char *ctrl_name,
>> +					       const char *mon_name)
>> +{
>> +	struct rdtgroup *rdtg, *parent = &rdtgroup_default;
>> +
>> +	if (*ctrl_name) {
>> +		parent = NULL;
>> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +			if (rdtg->type != RDTCTRL_GROUP)
>> +				continue;
> 
> All entries of rdt_all_groups are of type RDTCTRL_GROUP, no?

Yes. That is correct. Will remove this check.

> 
>> +			if (!strcmp(rdt_kn_name(rdtg->kn), ctrl_name)) {
>> +				parent = rdtg;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	if (!parent)
>> +		return NULL;
>> +
>> +	if (!*mon_name)
>> +		return parent;
>> +
>> +	list_for_each_entry(rdtg, &parent->mon.crdtgrp_list, mon.crdtgrp_list)
>> +		if (!strcmp(rdt_kn_name(rdtg->kn), mon_name))
>> +			return rdtg;
>> +	return NULL;
>> +}
>> +
>> +static int resctrl_kmode_parse_state(char *val, enum kmode_state *state)
>> +{
>> +	if (!strcmp(val, "assign")) {
>> +		*state = KMODE_ASSIGN;
>> +		return 0;
>> +	}
>> +	if (!strcmp(val, "inherit")) {
>> +		*state = KMODE_INHERIT;
>> +		return 0;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static int resctrl_kmode_parse_group(char *group, struct rdtgroup **rdtgrp)
>> +{
>> +	struct rdtgroup *grp;
>> +	char *mon, *slash;
>> +
>> +	slash = strchr(group, '/');
>> +	if (!slash) {
>> +		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
>> +		return -EINVAL;
>> +	}
>> +	*slash = '\0';
>> +	mon = strim(slash + 1);
>> +
> 
> The reason why we picked the <CTRL_MON>/<MON>/ syntax is because "/" is the
> one character that is not allowed by kernfs to be in a directory name,
> additionally resctrl rejects \n in group names.
> 
> This parsing should thus take care with stripping spaces and just parsing
> in general to support all the different resource group names that users
> may be able to create (it may even contain ";"). Because of this it seems that
> it should be required for the resource group to be the last parameter provided
> by user space since it will be terminated by \n that cannot be in a resource
> group name?

I hope I got it.  We should generalize the parsing to here to handle 
special characters. Yes. It makes it easy as the group is the last 
parameter.


> 
>> +	slash = strchr(mon, '/');
>> +	if (!slash || slash[1] != '\0') {
>> +		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
>> +		return -EINVAL;
>> +	}
>> +	*slash = '\0';
>> +
> 
> The user should not be required to provide a monitor group when
> "mon=inherit" or if system does not support monitoring.

Yes. that is correct. This code need to change.

> 
>> +	grp = rdtgroup_by_kmode_path(group, mon);
>> +	if (!grp) {
>> +		rdt_last_cmd_puts("Group not found\n");
>> +		return -EINVAL;
>> +	}
>> +	*rdtgrp = grp;
>> +	return 0;
>> +}
>> +
>> +static int resctrl_kmode_parse_parameters(char *params, enum kmode_state *ctrl,
>> +					  enum kmode_state *mon,
>> +					  struct rdtgroup **rdtgrp)
>> +{
>> +	char *key, *tok;
>> +
>> +	while ((tok = strsep(&params, ";"))) {
>> +		tok = strim(tok);
>> +		if (!*tok)
> 
> Please use the same string parsing patterns as the rest of resctrl. Specifically,
> please use the familiar (to resctrl) comparison against '\0' as in "if (tok[0] == '\0')"
> instead of pointer dereference like above (and below).

Sure.


> 
>> +			continue;
>> +
>> +		key = strsep(&tok, "=");
>> +		if (!tok) {
>> +			rdt_last_cmd_puts("Empty kernel mode parameters\n");
> 
> Not sure how accurate messages should be but this is just duplicate error message
> of when there are no kernel mode parameters when the issue is actually that "="
> is missing.

It can be "Unsupported kernel mode parameters"

> 
>> +			return -EINVAL;
>> +		}
>> +		key = strim(key);
>> +		tok = strim(tok);
>> +		if (!*key || !*tok) {
>> +			rdt_last_cmd_puts("Empty kernel mode parameters\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (!strcmp(key, "ctrl")) {
> 
> Should this not fail on a system that is not capable of allocation?


Sure. Let me verify this.


> 
>> +			if (resctrl_kmode_parse_state(tok, ctrl)) {
>> +				rdt_last_cmd_puts("Invalid ctrl= parameter\n");
>> +				return -EINVAL;
>> +			}
>> +		} else if (!strcmp(key, "mon")) {
> 
> Similarly this should fail on system that does not support monitoring?

Yes. Will check this.

> 
>> +			if (resctrl_kmode_parse_state(tok, mon)) {
>> +				rdt_last_cmd_puts("Invalid mon= parameter\n");
>> +				return -EINVAL;
>> +			}
>> +		} else if (!strcmp(key, "group")) {
>> +			if (resctrl_kmode_parse_group(tok, rdtgrp))
>> +				return -EINVAL;
>> +		} else {
>> +			rdt_last_cmd_puts("Unknown kernel mode parameter\n");
> 
> nit: "Unknown" -> "Unsupported"

Sure.

> 
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int resctrl_kmode_global_validate(struct rdtgroup *rdtgrp,
>> +					 enum kmode_state ctrl,
>> +					 enum kmode_state mon)
>> +{
>> +	if (ctrl == KMODE_ASSIGN && !resctrl_arch_alloc_capable()) {
>> +		rdt_last_cmd_puts("ctrl=assign is not supported\n");
>> +		return -EINVAL;
>> +	}
>> +	if (mon == KMODE_ASSIGN && !resctrl_arch_mon_capable()) {
>> +		rdt_last_cmd_puts("mon=assign is not supported\n");
>> +		return -EINVAL;
>> +	}
> 
> Does this mean that user can provide "ctrl=inherit" on system that does
> not support allocation and "mon=inherit" on system that does not support
> monitoring? That does not look right.

Good point. Will fix that.

> 
> 
>> +	if (mon == KMODE_INHERIT && rdtgrp->type == RDTMON_GROUP) {
>> +		rdt_last_cmd_puts("A monitor group requires mon=assign to use its RMID\n");
>> +		return -EINVAL;
>> +	}
>> +	if (rdtgrp->mode != RDT_MODE_SHAREABLE) {
>> +		rdt_last_cmd_puts("The group is not in shareable mode\n");
>> +		return -EINVAL;
>> +	}
>> +	if (rdtgrp->type == RDTMON_GROUP &&
>> +	    rdtgrp->mon.parent->mode != RDT_MODE_SHAREABLE) {
>> +		rdt_last_cmd_puts("The parent group is not in shareable mode\n");
>> +		return -EINVAL;
>> +	}
> 
> I think it will be useful to organize the "kernel_mode" resctrl.rst portion
> for writing to "kernel_mode" similar to the portion for reading to clearly associate
> the above rules with the "global_enable_per_cpu" mode.

Ok. Sure. Will add few lines about this in resctrl.rst.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void resctrl_kmode_switch(enum resctrl_kernel_mode mode,
>> +				 struct rdtgroup *rdtgrp,
>> +				 enum kmode_state ctrl, enum kmode_state mon)
>> +{
>> +	if (resctrl_kmode.rdtgrp)
> 
> Please do not use resctrl_kmode.rdtgrp as synonym for and interchangeably with
> resctrl_kmode.kmode_cur == RESCTRL_GLOBAL_ENABLE_PER_CPU. Please check
> other places too, like in resctrl_kernel_mode_write()

Sure. Will do.

> 
>> +		rdtgroup_kmode_global_deactivate(resctrl_kmode.rdtgrp);
>> +
>> +	resctrl_kmode.kmode_cur = mode;
> 
> Now looking at how things come together, what do you think of renaming
> "kmode_cur" to "active"? "kmode" in "kmode_cur" is redundant and "active"
> looks to be a good match with existing documentation ("... with the
> active mode enclosed in square brackets") and code like
> rdtgroup_kmode_global_activate() and "active" used as local variable in
> resctrl_kernel_mode_show().

Sounds good.

> 
> Similar to this, could resctrl_kmode.kmode_sup be renamed to resctrl_kmode.supported?
>

Yes. Will change it.


> 
>> +	if (mode != RESCTRL_GLOBAL_ENABLE_PER_CPU) {
> 
> If this is needed please make the test explicit to the "inherit" mode.
> 
>> +		resctrl_kmode.rdtgrp = NULL;
>> +		resctrl_kmode.ctrl = KMODE_ASSIGN;
>> +		resctrl_kmode.mon = KMODE_ASSIGN;
> 
> Something does not look right here ... function parameters provide values that are not used.
> If any reset is needed, should it not be done as part of rdtgroup_kmode_global_deactivate()
> especially since it appears that the contract with architecture is for disable of
> global kernel mode to mean that inherit mode has to be enabled?

Yes. Will remove resctrl_kmode_switch(). Will handle this in 
rdtgroup_kmode_global_deactivate().
> 
>> +		return;
>> +	}
>> +
>> +	resctrl_kmode.ctrl = ctrl;
>> +	resctrl_kmode.mon = mon;
>> +	resctrl_kmode.rdtgrp = rdtgrp;
>> +	rdtgroup_kmode_global_activate(rdtgrp);
>> +}
>> +
>> +/**
>> + * resctrl_kernel_mode_write() - Set the active kernel mode
>> + * @of:		kernfs open file
>> + * @buf:	write buffer
> 
> Could this be more specific about what the buffer represents? For example,
> 	Kernel mode line written by user space

Sure.

> 
>> + * @nbytes:	length of @buf
>> + * @off:	unused
>> + *
>> + * Return: @nbytes on success, negative errno on error.
>> + */
>> +static ssize_t resctrl_kernel_mode_write(struct kernfs_open_file *of,
>> +					 char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdtgroup *rdtgrp = &rdtgroup_default;
>> +	enum resctrl_kernel_mode mode;
>> +	enum kmode_state ctrl, mon;
>> +	char *params;
>> +	int ret = 0;
>> +
>> +	if (!info_kn_lock(of->kn))
>> +		return -ENOENT;
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n') {
>> +		rdt_last_cmd_puts("kernel_mode: Invalid input\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +	buf[nbytes - 1] = '\0';
>> +	buf = strim(buf);
>> +
>> +	params = strchr(buf, ':');
>> +	if (params)
>> +		*params++ = '\0';
> 
> Why not use strsep() to be consistent with other parsing in resctrl?
> 

Sure. Will change it.

>> +
>> +	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
>> +		if (!strcmp(buf, resctrl_kmode_str[mode]))
> 
> The whitespace trimming is inconsistent. Whitespace is trimmed from buffer,
> but before looking for the ":". Looks like something like
> "global_enable_per_cpu :ctrl=assign" fails with "Unknown kernel mode",
> while spaces around ; and = are accepted.

Sure. Fix it.

> 
>> +			break;
>> +	}
>> +	if (mode == RESCTRL_NUM_KERNEL_MODES) {
>> +		rdt_last_cmd_puts("Unknown kernel mode\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +	if (!test_bit(mode, resctrl_kmode.kmode_sup)) {
>> +		rdt_last_cmd_puts("Kernel mode not available\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (mode == RESCTRL_INHERIT_USER) {
>> +		if (params) {
>> +			rdt_last_cmd_puts("inherit_user has no parameters\n");
> 
> nit: Just in case resctrl needs to add parameters later, could this be
> "Unsupported parameter" instead?

Sure.

> 
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +		if (resctrl_kmode.kmode_cur != mode)
>> +			resctrl_kmode_switch(mode, NULL, KMODE_ASSIGN, KMODE_ASSIGN);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* Omitted parameters keep the values shown by reading the file. */
> 
> This comment does not seem to match the show() that always prints resctrl_kmode.ctrl.
> Should rdtgroup_kmode_global_deactivate() reset relevant resctrl_kmode fields?

Yes. rdtgroup_kmode_global_deactivate() will reset the fields now.

The resctrl_kmode_switch() and resctrl_kmode_detach() will be removed.

Thanks
Babu
