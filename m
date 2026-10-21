Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599786;
	b=4zQzo2LZUNAz5cwIrTvlCb8NdYsnOG9gI+wVC8Kr9D/kdKil26TEGul3VsgK+fFZaupo
	 ILc/UEzXGlJ0vYEASdZ7LncSU/Wqca53j+lZXLewIxb1es2W0WQoermORI3BlAC9qG9Tx
	 HzAeT76UKrS0Q9rN3qv6wRWVBIS95MkhEiCCgxBSOfGAIVNiYZj+3nRzJ7sg/oCnQsJih
	 oDUbnrNcS5JsQyjk8/vmt4c2en1GtJdzBWY8cuTbqTbgVKcloM3ijPkA8J9abn7PSh/xA
	 KqWzHjJDFrg9wIRQAxk08OqFnm9J5hfIvzZRvWibD7fR6mFYsewLLXp488nXZk4l1bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599786;
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
	bh=O9mEig3jVt8VPVeW7VinQYSiFWnkI9dK6AUCpSQwbvo=;
	b=Kf59zOG6uONGKgGw08zRQxV8MmGa9bkm9CcEykuwLPobvzll//7jthBzQ7D3Jg0OS6I8
	 MSqUexu6yKnS49MyopOrg4zNWQkUX3D5GXg6Ha673rMqXvjDKndtz9exi2WDOqkv3L/w/
	 xeBSkVkdqQrFUF1DMTL9JHPo9jhTfm+fl7K2FFkNyZwRCPH8uIPym5rHnHgRtanB1YWEP
	 aFRci6fq4k/a1s9zht2n8Mhti3qGNiFWZaSfV8Ke8O8qN0baj0qF/lMfgDsk5kUImqDKy
	 GS7rzGsvPpHlktmQBVtuQz5oI2H1QfJufKzsRfnv2EX6Z6C6ue63kwIdJ/93A6TRH9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="4raqU/QN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.59
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2A606A31A;
	Wed, 21 Oct 2026 16:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4raqU/QN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYFIdJ8i6QhhE/pSoRgeyplEU4ZC6QEZeJAWQsF2lqeQGsPr6TJnld44BvhVJDGhvwZUlxX3wXEJ1eHCzwvY6ZRTdEmGX8nvh+nOfkZuoPtXpuSHyoEzvoQ3AA7c7RSS+nvmyDJpwxs+/PxyPox2X7EYcFEhJesH2WYeNhtyPP9F8z+hKv/siAKWmYBhaW29T34w93l03Z1EKQCwatVcAvcPw53egwB18vB2TJFFN5BzSJJ22VuUCdYuvDTyu5UCMaDqaKvvZp247tsMQndh8gH+sClYg6EHVdP7LOADq+i112hfu9ZWpNSA1YpCsRBPh7XiPigdY+SD6fVFXhsQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9mEig3jVt8VPVeW7VinQYSiFWnkI9dK6AUCpSQwbvo=;
 b=swhuRny4Qg4oi5RbGD0UCnPQvS8cn41MXehPSP6L4BqRJNyvazFX+Zfk9pi85VDvzhjqZx7mXc5vhaD2XH2GACUcmKiMhzWDegJJHpTQKe7YcU0tatsTinj6Kd/dEfa//JShTlM10k2VqqKXhlw3mdAHpG/O9XRV1GK5CmHVg3GxwcL2qr9Kc2fOsD1RIedr/4Y1lHgGTGE+O5thI0vuvYyJdNkFwPvumLAtyUqLCDE7PvXbdvNzBsmRtCYZsyzQzp3SfcxGOK+p+ySWqHjg3+1eKXJWV2qVztfo46QoXtRJaAs3Dipo5jkC1+83kEdmaZbP0IhPfqKMIrbqXay5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9mEig3jVt8VPVeW7VinQYSiFWnkI9dK6AUCpSQwbvo=;
 b=4raqU/QNbykS/r8WKEUKPtDODerINY7GajRN7MuwLJ5ZuPF6y316gekL3u1ETYKe/ZubSMueBYipbJY6eNJ8yJ/Xe8HDynmSOBjhNlLtXLYWoPlGhVkM+cjhCHmZlPVV/LTJ4NKR6iTLiStlH+L4sBNJkp8/w6DZ0wNVyFuuGi4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:23:01 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 16:23:00 +0000
Message-ID: <65f7340f-09d7-4662-b5df-13c29f709b3e@amd.com>
Date: Wed, 21 Oct 2026 11:22:56 -0500
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
 <b8ec67ee-3a5e-4c36-a1c6-2b291d013369@amd.com>
 <69748525-438c-48be-8876-6e6cf1ba88fe@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <69748525-438c-48be-8876-6e6cf1ba88fe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:610:cc::22) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: caa2ec39-13f9-41a7-c708-08df2f8f9332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|18092099006|10067099003|18002099003|22082099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BJ42u4izbGDVb9gtTjsybLR7MWSIFAzr0Xu8O0uZF+3lPEhRwS9DA4CKr5JSRSXQHDzaf8wHN5FXOPXABzVXdC7ui1L44HFzXn+GRZdbK/xGvXbtIIDaXncio9KdlsMeKHwGYUe+9fPDiS+eqsfxJyEOP6xnJvo4K7IgF8cIA88O4zir6975/OcvB8UR7RuT/oQe8bq/9/JceJvbR10y+5/AOLFtNp5tqG0n6fj/g+Iv/TFLcLXrhXLeXHfclsRMVxR4SVbGzGpPsRU+BrJtTcIzf/g31XFjzV3sfyCTtwig7Ct7bthPqvgjQiLSS9/ru3hCzIOEyRlFeWtaMaXA4FKEncJuQqiYNUxh6DI6pQOKSrpm4yXH8xvjpy8kY4zxUS0JnlVAU26MvMDHN4ocWtt0ODHgrZ7Ob0P1O1mTtGy+Rzv2/lRo4EzwqRGp3B2ryCH5L+M6fiEsdrZHyT65ChjQJvn5ZovotErokDfyej+1XXC+8bXHH+Hs2ju6NuVlyuolBGJD8hJVNbAEOWmzISIkV3LVRfp2I0UdV1Me0AfqfnIUY3ymljFckzltiDmyQkGDSy1WjEJs4WPNleV7KAHiaLuiFHuktdYeKOb7eMpkI/AvH6Lmka20bn/r/byWvigBRCVOAHxUlJ6xASr/vT9PVL8ueBg428eLf9qj0qw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(18092099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjJucXZMbkd1NThoZkFWQUR1VW1VZldrVFpGQU5CYUMyS0Y4RVlKWG94bC9z?=
 =?utf-8?B?RExvbWxQOHZSc240LzQzcHVjSFpCeUJ4U2svYXJ3dEdNUVVTS0dpbVFzU1lL?=
 =?utf-8?B?c3ZtYnk1cjFHelZJWGZ6MGtReGw3SEduV29Pc2hNcGZUSUMxbWNzVTB6anQv?=
 =?utf-8?B?OGl6cHB4L2JzWS8xSnVhYXE4L0xkZmNUWXFwcGhYd1BiYkdlS05lWkhQQ2NV?=
 =?utf-8?B?dThhdmJyMTBzWW5UcnpVQlhjRzRtM3BQbjAyYkxsRWlmRGJ6SzNuemJHUmpL?=
 =?utf-8?B?cDdaeTVqL3dFYmZSY3BzU3Z6RDdJd0pGZ2taTmM5QnFCajR5Y1RjV0l1MTFt?=
 =?utf-8?B?S1ZGVUhxRHU5YVFaTXZoNHhhR1lKekJIdUFyc0NETGcwL1dWM01xeGQ0aUxx?=
 =?utf-8?B?d3NpQVMwYi8rakJCaUU5ZHJnN2lTMW5NU0pXc0ZVSDNhcVU4alYzVXJneVBM?=
 =?utf-8?B?VExNTnM5QTlGUVVRSFdRbS95Q0tiQXFSUGZDalQwZVZQVzhkaVpCcW9sS3px?=
 =?utf-8?B?WjNOTVFBcmQ4RSt6Smc0L0JuYzFCYUpNdVpybDlLOGtqeHhSNktwWXNkQnkw?=
 =?utf-8?B?RWdlcUFtN21VYXBaZEdlOVpYdGRXcGxjV3VQZk9zN1IvM2crdVoxSTlZM1ZL?=
 =?utf-8?B?Y1diODM3WG12NTdSVTdpalpCT2U3bllBTTZ4dVZiWDZJczNkYTRsTFRwaTlv?=
 =?utf-8?B?dGNkdWQ3WWRwbFR0ekQxRjhPR3ZvNUZFOGM0dERsQVVTT1NvVE1BS1FkNWYx?=
 =?utf-8?B?NjhZei9Kck0vNHd4NTF3OXdlRHR6ajJrYTFRWDkwTUFPaUt2TEhEVHhZRjlN?=
 =?utf-8?B?YWI2dFNrTU1vc0MyUjQ3UG1LaSs3c2hVWkIxVnlOUEM3eStkUnpoWU9Bc3V2?=
 =?utf-8?B?UjFjWFllbGVRY0p6cTd3bHZXSVVQMWtsQzhwOVptMTg1SWpyMkdKbFpCZFFs?=
 =?utf-8?B?azRaRjUwMkpZMHg3c3lCbWFtWS8rUGhGeTlkV1REQzU4dUI1a1J5Yjc2eDhD?=
 =?utf-8?B?aTRzMmMrM1ZGa3dyU3VOTEltbkdYd003bFZ3WjVYOWdaRkpKV1JrN2NFcHNU?=
 =?utf-8?B?TzdhdEJIa2ZKR0ZmY2lTTW9TbFIrc3ZWWnFhdkZWS3BYVU1GUFoxL0V5c3po?=
 =?utf-8?B?dTdKZU1Yck1qczR4RnVDYzFYb3lmaUVCaUlMR040QU1XVitsVmFYWHZqdFV4?=
 =?utf-8?B?ckNaRWFsbEdoNERCbmovNWdJRDRRV1daenl4QUVNV09oVy9iUXo2b1VMcUo4?=
 =?utf-8?B?eVgzRUNtbWRZcVpSWmM0TGI4amwzWVRUUlc5N3pMM3VCU1VkUm5iV2xieHZk?=
 =?utf-8?B?ajhRTXV5TDRNTVpjOGZQdE9mQ1hTZUVlN0ljSzNtRlJTVEdXcHJVemFIN0s1?=
 =?utf-8?B?dXkvcFIrM2ltNjZPSlFXYlQ3M3ZqMFVBUjVpNzZPMlRtZnFLUDBJdGFFSUhi?=
 =?utf-8?B?aHd0LzJFN1BVQldIMnF4eGRZdzJkWEZOK1NXK2EwdWdqWjBqbFRjWmlVQjgy?=
 =?utf-8?B?aFQ0Z2VaYm1FTlU2VDIzZDBJaFBRZW0yenZ4UmFLSEE2dkJnL29LS0tBbnhy?=
 =?utf-8?B?b0VJVzM3bVpEaUNDVHZNTEsxUzVjNjR5ei91SUx1aTdHOHB6b25vcUdyeUlT?=
 =?utf-8?B?NWlqUHVFdFAyeHJMZE1yaVlEcFRhWjhSaFVGdXdFL2lzL25BRnNEclJ6bTBV?=
 =?utf-8?B?VExYMERBUko0dE5GOEMxaEhSUGMwOHpmV2Rjak9ZRWNNTTZXeElmN09VN3Uv?=
 =?utf-8?B?WlJoTzVpdkd2d1ZJYVZhald0UWFBdUQwdU1UQXBGNmVNamZQRzluNWZEQ2o5?=
 =?utf-8?B?Z0ZlajY1KzFOY25kUlBEN0ErMW5ERkUycFB1SzhtaXVocGorekZZYXg2cFRX?=
 =?utf-8?B?OWFmeEl0dDlRRXFVb2ZDdFIvNGhzajV3VUY2Z1Nka3NQSmFXZm5QRmtBdG0v?=
 =?utf-8?B?NjcxRUVuNDNVcytIMHZWSUV6TW90R0ppc29FeDlrNDFtOTFsNTdUQk1rN3NX?=
 =?utf-8?B?QjZiN3Qra2FsVVZmQ0RBWXMwNWFldWlHOEZCdlB0YWZhUGl0dGRRNkVYT0lV?=
 =?utf-8?B?VG9xSHA0aUJNVG9jS0tTTXBaYnFQb1RRdVBRbFp6VXY0M0xOaFllTmE1bVZP?=
 =?utf-8?B?NEV3MEtOalhncW4wSkc4SjEwbUhsMWx0Y3Y1TWgzWE40WlFDcC9FdVl0YTJU?=
 =?utf-8?B?WU16bFZmZmthVVZodFE2S2pRVmtXTERTSGRyU3I1MGsvd2FwTTZNK2ZqU1J4?=
 =?utf-8?B?VFhiNVlIdXh0OUNRRmpMVVBZL2F6dUxjTi9UT2lZa1lhdUpjWm9HWGtTc1lG?=
 =?utf-8?Q?JjuRsl9E9JO+naQegl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa2ec39-13f9-41a7-c708-08df2f8f9332
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:23:00.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcCy+MzMX3nm8QJlzcGRgeL5XsVydzm4XpAxifafy6Z2n8wmidcxMjmJNhGdP1fA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

Hi Reinette,

On 10/21/26 10:58, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/21/26 6:58 AM, Babu Moger wrote:
>> On 10/19/26 11:17, Reinette Chatre wrote:
>>> On 10/15/26 4:09 PM, Babu Moger wrote:
>>>> On 10/15/26 09:44, Reinette Chatre wrote:
>>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>>> Kernel mode work can use different allocation and monitoring associations
>>>>>
>>>>> Here I think "different allocation and monitoring associations" means
>>>>> different CLOSID/RMID, while other places "different allocation and monitoring
>>>>> associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
>>>>> MSR_IA32_PQR_PLZA_ASSOC.rmid_en?
>>>>
>>>> That is correct. Hope text here is fine.
>>>>
>>> I had to guess. This is the same topic as being discussed in patch #3. Could you
>>> please add clear definitions to eliminate the need for guessing?
>>>
>>>
>> Ack, rephrased the changelog to use CLOSID and RMID terminology to
>> avoid the ambiguity around "allocation and monitoring associations".
>> If you agree, we can use CLOSID and RMID consistently throughout the
>> series.
> 
> I agree, with emphasis on consistently.
> 

Ack.

>>
>>
>> "fs/resctrl: Introduce kernel mode enum
>>
>> Kernel mode operation enables a CPU to use a different CLOSID and/or
>> RMID when executing in kernel mode than those used in user mode.
> 
> Please take care to distinguish between the "kernel mode" that defines the
> policy here and "kernel work" that is what the policy governs. At this time
> this series even conflates the two in some places ("kernel mode work").
> 
>>
>> Architectures need a common set of kernel mode definitions so resctrl
> 
> It is resctrl filesystem that needs the common vocabulary.

Ack.

> 
>> can report supported modes and indicate which mode is active.
>>
>> Introduce enum resctrl_kernel_mode:
>>
>>    - RESCTRL_INHERIT_USER: Kernel mode work inherits the CLOSID and/or
>>      RMID of the user task.
> 
> This does not look right, it inherits CLOSID *and* RMID, unconditionally, no?

Yes.
> 
>>
>>    - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses a single
>>      global CLOSID and/or RMID association shared by all userspace
>>      tasks. The mode can be enabled or disabled on a per-CPU basis.
> 
> "shared by all user space tasks" is not right? The CLOSID/RMID come from
> the backing CTRL_MON or MON group, so they are shared only with the tasks
> assigned to that group (possibly even none).
> 
> Below is a suggestion that aims to address the comments. Please do not just
> copy&paste without verifying it for accuracy and that it matches the terms you decided
> to stick with.
> 
> 
> 	Kernel work need not use the CLOSID and RMID of the user task on
> 	whose behalf it runs. On x86, Privilege Level Zero Association (PLZA)
> 	enables a CPU to use a different CLOSID and/or RMID while executing at
> 	privilege level zero.
> 
> 	resctrl needs common definitions of how kernel work is managed so that
> 	architectures can advertise the kernel modes they support and user space
> 	can query them and select the one to use.
> 
> 	Introduce enum resctrl_kernel_mode:
> 
> 	  - RESCTRL_INHERIT_USER: Kernel work uses the CLOSID and RMID of the
> 	    user task.
> 
> 	  - RESCTRL_GLOBAL_ENABLE_PER_CPU: All kernel work uses the CLOSID and/or
> 	    RMID of a single resource group, which may also have user tasks
> 	    assigned to it. The mode can be enabled or disabled per CPU; on a CPU
> 	    where it is disabled, kernel work inherits the user task's CLOSID and RMID.
> 
Looks good.
Thanks
Babu
