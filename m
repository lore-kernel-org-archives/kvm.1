Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042232BB13;
	Thu, 19 Mar 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928308; cv=fail; b=hYTM8YTzsTbrUJMLHGj4rvERtWMqCLapG7ogh2CpVXS/ZPuksBz3w1BGL6M6w5JyQgrX/X0AMfHFVHJPULAzYuHaoOac/Z5eRhsbfq93VwZdEoZZsgmXowZlyxV4HmzFgn4LQRinQIEpHcnNxiPTg8iC3qKx/yEw/eBdzc2HFwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928308; c=relaxed/simple;
	bh=RwoDaSUwb395iN4GfVImjF7NfEGPYLgURjTxqffIHdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mFbR5LTy1rwpcSFjDFueGFBIWz+yoiWNgdKIWIrdiG/XqL2C2fD2sV3sQxcTZeMjn2fXgk2hh+u7nHiQBbgtsMLLktdjd4PtHctDOa0FPkQVza6jgCc3FIgYY9iOBD8CHTZ7CK2O2LjHsf6iCUPhEmLPqHJ58l2z36sUZqTWOcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eb5RJiKr; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eb5RJiKr"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JAK5ec3306616;
	Thu, 19 Mar 2026 06:51:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=HtGODS/xzWqDNFgRYJAbTQXSB8AF+T9T38weQ+ao54M=; b=eb5RJiKrqJSB
	gp/WEn//oO/zdKS6DceG892+ytoFbHScyM4q7tiIC5p3LoGtIkjG5HlPa5IeP+Ax
	QqldARjLhi+I5gcLCTUvSE5nXNfk4h7sJh6aZQl3XwoUBCUc3HuL+JchMqd7VAhe
	tfi0gAvQTnChRRRmfKU6Icsc7QVegJWxfvv2Jj5tp1jOfgT9RlkQ8ksp0QUWq0nI
	JmF7AQbiNSKgds0P+BM6c+rzzSIcfII9eWBVpXfR/+VveZn1bLu+oYvGTK7a6a8i
	LRbzFwKqttN1xUvyLfmt9ObJqAIgI3SzUWSYJ78D5LwxN1QPNN9W8Gr13rH3xxMp
	6ReS0T6mKA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d08ew79wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 06:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufvw/np48/iNzLIGXoI9FOWRojXbTubAtH/qJZZhlUGioN/j/lmOx8+53ezI8uhv6qGbzP4kfJOJD5sbjrmD7krzL1ga15/w7lMxTJo9qwYO8uZZOyJUA1EyW1PDHbdbVBQD2MwuRpnQkjPdxdtwTq3rbM5uwSeG0mvPAkjoPNhoEnXSOc3o4WFR0qiOB8hK84hN5BQNyuVRv+Y0/e1Q855cXYyGuyQ+yXER/OuzKWn4nmZTtmDY59dWGfAskLW+StZaPJ+qah15QkckNMyea1osQmCMl9N8Jb7+kI5V31KKZaRdc+scQ1sr/vieqH6J/VdcCeGcCNH3g4OyStGszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtGODS/xzWqDNFgRYJAbTQXSB8AF+T9T38weQ+ao54M=;
 b=juTqgyv08sEi75/YZIkLWD5nGR/0K5fDrXWT8Qo1jWLji4X/P0KCah4YcEJRayPxf+XGMsiawFuEaCneAgFyWLXQzXD0YErvxXP++0RZ5tx6OwHGb/FntPkpXY3m1mtbWC2dV+O8renTf+QzEw+E//gOF0SV1304CCD9MjlZsHsZAR92riMGTlQIiOxBSspgUekYw0HfKMPJBEwWPJM6S0So+gAgEv9X5q7GIvT5uOWHRuN7DwiVqRxxFcBnGcNrNjB1h6IJ65EXaGugMSZfuL4nmsE8fa3ahYwOqY9/HCsEy7ezuShOUhj8xAVmn7FuNMK5oU3hi+6MqtfCgaGGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB7038.namprd15.prod.outlook.com (2603:10b6:510:38d::10)
 by SJ4PPF27E1F3999.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::88d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 13:51:35 +0000
Received: from PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19]) by PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19%3]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 13:51:34 +0000
Message-ID: <0cb46c4d-90aa-4ef3-9098-9c5554714982@meta.com>
Date: Thu, 19 Mar 2026 13:51:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: selftests: Build tests on aarch64
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>, Ted Logan <tedlogan@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
 <20260318165513.49c3830d@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260318165513.49c3830d@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To PH0PR15MB7038.namprd15.prod.outlook.com
 (2603:10b6:510:38d::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR15MB7038:EE_|SJ4PPF27E1F3999:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bca068-872e-4630-5603-08de85bea1dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hLA3+6a3zXHOAQ/j3lJkI26o7Nsb95KQppg1n0W8nayvYz8FQQBLJCg5ZmEcYft0uKXjnHisoIup+V/gZQAfdNrccB6l1ty0hO1NfQYCwtsDT582XqKDZIK8M3AEn+dtXuSYwRCcPzma++y+EZZ0hNlkgD85oOWbcfvCutAnwGqxYVymHsC5HAfnJTvc3qk3Lfd+s3et5Fx3sZo13cgGMmuxibITQrJafcZHY/hOUzAZMG3bXm6ygd1ES099arCp84JfnbokOlHo0tPHhrPsh5WnDmyCbOVn0uFLsuAwRQm6Urq6n0qxMGWFqcOblspp8+u5kzslk3B8Ku/5wzB7Nr9EG/FllIFRHDMG/kUz8MkJKbQxjezOk21ozvRYaE8riDwrCmhstug0AVT0keqcPqzN4j73aCGqjvnF8vAEyyomTJFilnmd6xXHEjzQNCQJwy5TRzWovJXH7neGRZrNd/tNFNYCQGdtRDXM9Dn6kx8quExrYz4NQQiPVjCRNm9AvYF16PTwLqmAE+W14Vgb3NneJni/+Vd4rKpJx1agBZfqAfVrSeCZdNIwdzsz9gmj/ar+gU9+MWiZCf9WD5jP1TCsBKxGR9gFrBFjqO6yLaoLdtswCcvQ9iiEEI9I9GWyiNbOcxOwjZ+T77uoH3whCLVH4FCcOBIbQGDRK9c7a0HyddbbkYYltGfNjhCZm/PEHy+g0XXpFNpGybuiVCbumNovJp0qxBS9LlgFeniqVzccoAplVNJNeLE4cTDKao/i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB7038.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L01VdmswYU4rdVkySWJSaWU4czRld25KVklUWDFVZTVWUlB3eEQ3WVlweVVL?=
 =?utf-8?B?WVplWHpncCtxQitRYXdlYndtVjdJNXF0M3IxcnAzMXV0U0NOVml2VXJmQi9F?=
 =?utf-8?B?TkkwRnRRb0tlUDF6bjFwdGFIOVp2a09Bdlhua2RpSlZzZ0ZuYWxjNUFBQlRU?=
 =?utf-8?B?aTVxMkdNSWdVTnU5aWhhVkFxQklvWmhpQk5HQTlHN3N3elhVR0dkODYvdHQw?=
 =?utf-8?B?MUtnVWh0UXRiTERaSlh0bDZkblNmeFM5YUIwSVB4K3hCQkZRMU9HQnY2SUQ4?=
 =?utf-8?B?VEs1ZVpHcFdXaHZrekZzcFAwM0xic0JZWkY2eXVabTU4ZUUxY3UvNWRwMlRY?=
 =?utf-8?B?MTk3eUpFeWNiSVd4Y21aQjJqUTdmTTMzdkxSd2R3d2puV1JGbGdaZTdCek0r?=
 =?utf-8?B?dTJxdlhHN0pOTHRYZGFDS1RqVnFUWSs3QU5JVDV5ZE9TS3hseDBORXVLK2hS?=
 =?utf-8?B?b3QrYzdlN0lhREJMSnhRcUhlU2RLRTMxZFo2WVkwRTZlQjRKcXF3Mk9CZTVG?=
 =?utf-8?B?anlOQWV0ZmVlM2pTQlRDS2tUODRYQVBFV0xxcDlicmpLaGZwdjBQcTk2UHZi?=
 =?utf-8?B?SUhEekpHeGhEdlIzUS9IenVGcVozNFBPN0Q2bWRuYVZNUmdYZmRvREVDcXkz?=
 =?utf-8?B?VlhVdERaOHRSTlYwbDA4aFEySVVhYkIyN3FzVE9pVlFta3JUTTYyYU4xUlZn?=
 =?utf-8?B?YlB4YTRDeDV5VHM1TkZwaHJoWnRUN2JHV2FYc1FnYVk2aE1iN1BVdWxNL2dR?=
 =?utf-8?B?TTlJaG5IZWZOTHdBaWd4VWVkZVJjU1lCVUNYZG10QVcyKy9VY05jbWNKM0Vo?=
 =?utf-8?B?NktBdkJTbTV1R0dUMHJRbVg5Y010L2FXaXd1Ylh6WTc5Y3R6Z1EvQlIza3Js?=
 =?utf-8?B?NExUZHl6UjFMaFhFeERVYzBXNU1lR0FNSlptUzVtSDdTUkllZFNKSnZpbzZv?=
 =?utf-8?B?MHBkTDdvQjdva3Nua3QyeUpHUFU1cDRZUDhQUlJlMWFJV0pmcGYrSDZuM01q?=
 =?utf-8?B?cEszQm1rMnc2UHdaeGFrOWc2OFk3UjRycWJxTVo4Z1V1NVIvMGF5WExHYW4z?=
 =?utf-8?B?MWZ4cTBrS3EwOWNzcE0wdHBlZFJDWjIyc05WL1J5YS9rbWRvMUdWRUpkdGpt?=
 =?utf-8?B?aVRGUDFKZHU2dk9BVnowY1haUTRabS9JaG5wZ1lJTHFhSE5UTWpLTE51OWhH?=
 =?utf-8?B?cldDc25VSVBSaE9FR24xeTBCMFRUV25IckpCRGxrek9iaEdZenY2bkxreWFH?=
 =?utf-8?B?bVVCYlMrbTRUV2d5Yy9ibzd0UUw0bmZoMS91TnhUZGY0cUJWdjV6elhYUnUr?=
 =?utf-8?B?U0diTlRrWGxvS1NqYm1HcmJLclJOeVQyODJiK2U0TjhmOC8zblROWVFxb21O?=
 =?utf-8?B?ME5HWXM4Z2lvZm5RbjFEV0sxSjJLamRxcDZzN250NU1icWJ2MWZKaWdBQnFG?=
 =?utf-8?B?RkpUck11RjFZbFVjRG10OG4raWt0S29pREVMTEx4RkQyaGZPaFZ4V0U5bmJl?=
 =?utf-8?B?RmVoSTV2bjg2aHdqaDZnSk1MaTh2akY3cURCK2R1RWhsYjhONWpaN05tbXlV?=
 =?utf-8?B?c2Q2ZzFpeit2d2hwSHlqc2Izdi9MVElmSlpodjJJK0szM2daa0FoQmNBL3BW?=
 =?utf-8?B?UGtmV1BkVVRMRElvd2U3VDBaTEdQMlZoQSt3cmVnT1h5bXRqekNyc2FMV2Fr?=
 =?utf-8?B?UWU0d0hEUi9CWUxWeHErQVo5RVhObkM1UkRPRkhJVHRCQ1pKU2tISUhIaEZX?=
 =?utf-8?B?Z0kyZURremRETHpRNzEyemlrMU1QTG9UdDZPdCtSM0tlSkhUVVBWQjNrTHE3?=
 =?utf-8?B?TlBmTXJkcXpjbHFEV0F2YmFqVFNwckk3TENXYnVRcDRJcVdMVE0xSEd1VGRT?=
 =?utf-8?B?TWdxNmgyaHBJRmdNVWEwdy95djZUWmJyWndzcUttbTUzNlhhbmR4djVDYndC?=
 =?utf-8?B?K2hnTTZobmN0YytoVHVwbTVlT2FoL1FSUWFaOFNXMDA0YUJNZ0FwSFpKbE1q?=
 =?utf-8?B?bGlIcW9hS1lhZThrWWVDcERjVk1zRFFpYklTbGxpaGd3aFVNaUsyNTlNbll1?=
 =?utf-8?B?d1kwQ3FPK0JtcHhGT3VjTHRjUmFPcEV1UnJNNEswbm44UmF1b2FjUlpycDgw?=
 =?utf-8?B?L0g2Z1ZTR1UvSlJWbFp0OTdTY2FVek9lanIwM3JndWh2UCtLOWt1ZVJmTXMv?=
 =?utf-8?B?QzFVaEJKb3JzZTY5UFhOSUNGWWZlTU41Z2EvMVJPMXArTWk3WGFtTmQrYk5I?=
 =?utf-8?B?Z3k1Uld1SWlrbFF6V2J6WkpHQi9XbFFLTDFlMVh1ZHpWYWt1NERXa256QnJR?=
 =?utf-8?B?SDl5SCtHY2ljSG9LK1VRZWJ3VURVWjdsNFFYUkZCMXNCQnJZRWhydFpBRy90?=
 =?utf-8?Q?9lc+xnrHXoYjD6E9sFVnT504mmKK7xAd5UkQP?=
X-Exchange-RoutingPolicyChecked:
	fi1ibDbgT1ULeGiQlp8YgdodwqW/711xxz7hR99rNxHdW+pBwPWSkp/3h3Be1CNDYIezHPQ3TPkLDj+PxzUqwq+wXfs1kLQlAJHbGMQsNmRwRd1ZiLzT/5y+Dd/eqOi7uKCCAlFsfWK+HceXtcU7wW42nyd0nMSPekc9aa/j+eRLVjkrBBLbEWl4Dl2YBORxo7TkdkE+KdN4+Wkwfy0jmZdSP0NV45E71iBCUh4ySMBAkqe3oyhw4et83jIaAjt3Xq+3+Kk7d1ZtqsNQ+sLUnU6P8rBrgkh/EA9x+Wne+gqR6bbg56/ZilYtdRyd4IAsaeXV3BIN5cL/maxgYcJZpw==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bca068-872e-4630-5603-08de85bea1dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB7038.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:51:34.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzbuGttJOaozK5JHrRQEs0xuigbRz6ImWWe6Jcz+E+GaS7+7CRAkynx9XUic3YbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF27E1F3999
X-Proofpoint-GUID: x729_IDcn4gioCSOZAl70gXOR08aTn5E
X-Authority-Analysis: v=2.4 cv=Fco6BZ+6 c=1 sm=1 tr=0 ts=69bbff6a cx=c_pps
 a=9H9ADJ10uJ0pYmVeXPB43g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=FOH2dFAWAAAA:8 a=iymWCO9zHlrrySkie5UA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: x729_IDcn4gioCSOZAl70gXOR08aTn5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfX7EdPt8LF3ld1
 tHEkrYuSSGUOKMeGAkvlRbyimi78QRvtZRpcUehxRqGSiCgVkA1DFQCkCeJ/XQax+GjEJ5NaFgn
 Sz2kpFfQZNerj2gPBI8RyFoVzjeXnl/9xNFWMDI2k8I8leKAXW+Ac4jCK/t7OjeOHqHCTbvlPhN
 hMpOjw2xVV7gFy3ekL3+m7Ps7XOEUo348O5aaM148Dx4rB76rl9TLXNRqlrWC/pOZb3RG6WXeko
 zfTVwymIbf7J98bDUIKx2cDC5byAxyTqauPABdXTlzDBXFdzv8jAFPQaNDPULqvN7PAlWVezoAf
 i73RzVUz7tsG82XU/eGmrSLHWVhQtTZUolhbzdOPS3+02Uaz4GKnph1dRM5bBP32gVfYGcIP3iW
 jwl/nP4A9Z+tSqW2/ag8IBLTBmhCduT7DDlPOG7PzrX9VYYikHT4EtxYn+Nw1wip5WsZ1Qsv2/m
 w10F4hIhEiSargcSKeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01

Hi Alex,

On 18/03/2026 22:55, Alex Williamson wrote:
> On Tue, 17 Mar 2026 16:25:18 -0700
> Ted Logan <tedlogan@fb.com> wrote:
> 
>> Also build vfio self-tests on aarch64 variants, in addition to arm64 and
>> x86_64.
>>
>> Reported-by: Matt Evans <mattev@meta.com>
>> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/ 
>> ---
>> Signed-off-by: Ted Logan <tedlogan@fb.com>
> 
> Careful, this is a good way to get your Sign-off lost in the tooling.
> 
>> ---
>>  tools/testing/selftests/vfio/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
>> index 8e90e409e91d..98bc8d6271a4 100644
>> --- a/tools/testing/selftests/vfio/Makefile
>> +++ b/tools/testing/selftests/vfio/Makefile
>> @@ -1,4 +1,4 @@
>> -ARCH ?= $(shell uname -m)
>> +ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')
> 
> Are we intentionally enabling aarch64_be with this glob or is that just
> carry-over from similar in the mm selftest Makefile?
> 
> Big endian ARM64 support is really not on my radar for vfio, but it
> wouldn't be our first foray into big endian systems.
> 
> If it wasn't intentional, maybe just add "aarch64" to the below filter
> list directly.  Thanks,

I think that won't work for cross-builds passing in ARCH=arm64 "from
above".  We can just drop the `.*` part of the sed regexp, giving
ARCH=arm64 or arm64_be (the latter would fail to match in the filter below).


-Matt

> 
> Alex
>  
>>  ifeq (,$(filter $(ARCH),arm64 x86_64))
>>  # Do nothing on unsupported architectures
>>
>> ---
>> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
>> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674
>>
>> Best regards,
> 

