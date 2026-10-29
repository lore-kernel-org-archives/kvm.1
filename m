Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793255605;
	b=cVpjxpf5c2HheTO8hvGyViahVYHV9I5VzPeODjcSQ6Q7EQ0UDH9Rm3w+P4D8PYFNcfJJ
	 jkM/R4nse+JZkfFvUY4Gw4ynwr2qekj8R9EL4+HSmbboeoIGB8R9K8TyHS3v3T614dU66
	 JzFlcexkzIEVNUyuELAPJ7/AQY+fwt1Z+9t8aWyshVH8b+eZT3s7l2S1Pqddzd9fsZ8oC
	 15OgCBs8fXo3kOHcUNIWHReuLnZ3D9S5AREoQdWJ1qwc96O53irD3n6pjeYXvMgApl+f2
	 F59kMPhBXgTb1Wf6iyECZTju+Zz3LAb4iMOLFFIGDHjtsQXPznUCPxbZoIqbb7Uk9oA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255605;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:client-request-id:
	 request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID;
	bh=taAe4oYGMKqOmjSzdM8Rq7mhcJXBoSvKS0vs2H/cJQM=;
	b=5K9+KiXChRbpB5abEhLK3uek3IZF0E2HwDf8NAvtQMA0PpI0XGG3Xp6y737zu4L2NjvY
	 GW3DHeKvBcOGvwg5akzmrJx9kVy80iIWTGQZFfUjEvFTKU0qigdJg4NL8NK+sNJ/iJbWI
	 CjYUTg5KD/cs3jofMv3VFzw17nsUC9650INF1Hxjwbw2nRcD6f0fVfr7UHzv4rJKkKEPm
	 T8bH8Z8mRFE/oIiuneJTyJFFT+Ecu4h+V/kz+qhxG/NrHjuudhmrcy2Ct+t2xYGD34eHl
	 6AE9vmSij9Ie5G2OBzaW/FsQkS1DnyTstaa5EmsinMNuTDBaW3w9slRv38ICw/WXecQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=V1VYaZPN;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=vpXZj5Do;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E6606A31A;
	Thu, 29 Oct 2026 06:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=V1VYaZPN;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=vpXZj5Do
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SMw8HH655469;
	Thu, 29 Oct 2026 06:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=taAe4oYGMKqOmjSzdM8Rq7mhcJXBoSvKS0vs2H/cJQM=; b=
	V1VYaZPNukFR/4GZd1FfYR7bBKdoUPzKUB+mPFggR2V5xDEztrRZytEp3f9jz3Gl
	hSgeubSKhS53zptCZU/fnME7TRIAqGYYtyfuZaPTy0+/VSq7/7nm7GOwhY9or7Xw
	eiCmOciJIE3kg+cG7S2sq8lEbUaJ0ui+rdiZnH4gmp+Ap2u3OuRF2mE0O9rmLO4O
	dCBPsrGwq/2bWMIOy1ydOIVFaldzLy/xBy1YzpC/9BK6zkF6/vVw3hJw0dLG4MrB
	wzbfb8WSjrHqgVDyTHMiWQAXJ0YIDEglZ32dsNtroRa4MysLNHq+IPUmexdXjqmH
	tHUNL2/DTXwaGRYeus+4nA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgkk971bq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 06:33:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69T6JsR91616810;
	Thu, 29 Oct 2026 06:33:16 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hm0sdgcmt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 29 Oct 2026 06:33:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB1h23dI4v9U3xmL8T2ehnFEFjOCBhi/6YmqlPQYEfcypJSyVNLNq2FV5mQprklmknU4lA3wWl3EaiM5i8AQJA7Z87aNdnD+gTpwPyakOMYUnAL1vn4zbxb3VQ5SDxH9MhkhhKrDX/hKg6DkL29NmiNq1EnRf4BzVw1OLtVP/zLDRmRJ/vbjeNfNOImtJPDXS2Jilh9Cxq8CBfjDktGx4j66OPFeDz27BOu1X6jNKqAxmazdC/gzLzRr4+GoUGp7+8B2IjDn5y0VWdnPHh+iZqlXdjsWJWaeycxXFmwhyW9NwcchVDQ4S/G17oxhlx1pHv4HrsDLFv8EGasZU7gV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taAe4oYGMKqOmjSzdM8Rq7mhcJXBoSvKS0vs2H/cJQM=;
 b=Zs+QfkYYVwKoOnaFSm9EBFJPB1JB3c4HFtR16MO9m8Wth+3NYF74HzAk3rL2WmQekYNb7v2XYpOyHpjcZwEXYzNSKdkS5AR79TS8XPVfkEENE2nTUDug40wWdfDMqOZ0cuV4iOa8iELwOanNEfEDQu3k7uSj+8oD6jVQ+YiwiHm75FJaCa2WWBZ+I37Kdu1kszrNGGXnJN7eL9E4+3LD0Z2P9vYcPHLS+WAgpXWiyHgUX14yg2srHVF8BySv9QJR4niWO6m44CQ4INBkVzI+fjZT/ypOC7Aqaew8dea6/nBKvCPfzrdCGnXMmDysM3Wr9En0GrFmbEG1hA2QsIYgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taAe4oYGMKqOmjSzdM8Rq7mhcJXBoSvKS0vs2H/cJQM=;
 b=vpXZj5DoNzPoAs160N2IreRIFvQpZEfz09+oejMhscGwRNfVxbaFY2dGYhcjqx2EIKnWe34EjtCKK3fMb/5fwy2vV2Vv4dfu3XOxLWeoiDFLK1QdcKwR7fbTKVJWptDmHEtvF6epoHdoHerLxL4M9x7EhDEB6khV5NQxzSZ9fXg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12)
 by DSVPR10MB997963.namprd10.prod.outlook.com with HTTP via P2P; Thu, 29 Oct
 2026 06:33:13 +0000
Received: from SJ0PR10MB5520.namprd10.prod.outlook.com
 ([fe80::8fba:9b1d:17df:f916]) by SJ0PR10MB5520.namprd10.prod.outlook.com
 ([fe80::8fba:9b1d:17df:f916%5]) with mapi id 15.21.0546.006; Thu, 29 Oct 2026
 06:33:13 +0000
Message-ID: <e4070a8b-fa4d-4ba1-a333-e7cf72da416e@oracle.com>
Date: Wed, 28 Oct 2026 23:33:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC ISR
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org, kvm@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20261029063112.203893-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20261029063112.203893-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To SJ0PR10MB5520.namprd10.prod.outlook.com
 (2603:10b6:a03:3fe::12)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:EE_|DSVPR10MB997963:EE_
X-MS-PublicTrafficType: Email
client-request-id: d35623d1-873f-436c-90ac-8ae561447762
request-id: f101b679-cdff-4903-f61a-08df3586820d
X-MS-Office365-Filtering-Correlation-Id: f101b679-cdff-4903-f61a-08df3586820d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|261009223027099003|261022075727099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261021135927099003|10067099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C3g9tJH0xt+yz/PHDatybANuG02yImGHGK0EbXBTK6e0Rzm5uwtHnDxWqghfe8L3+UZhFb1b7q5jDVZ7lC2Q3vTjeV0FkpTk3dn+0t85/8W6fj1HC1/NN6EbA7Dqps84/tRktdp3S+0cWSHhpfYJOnbFL72GhMjqhsoaxldtwlKRngBskvdn66K8YuKPxbAv2SNirmmn2fD81CPZGcEIIFRsF87qUG/yzTYla4JiJaFqWALNWoEW9eFPk/DO/fBdQuYOSrg8l0VtS5bdBqWv3vLlRehoZ7KCzDE0Fhm34vnkQkcFei8m+QFRVO8rv/JWAqxZTzTrQ2GB28rfJv4BFL8dDmRutNTKLLqGedJWUXBleT0tAmiQCSmOcFrzvvCA4dZfLDs0Gt1DpbZltWQDcE6QXYnNoQ1H9fpMkW50Z3HF4rmOTmHeQJYyYq2X+QeExYFv7P94Eb1aiVOyrvtqtkU2ERoLfwLLdB1sP6cllFadDZGotIgpNKhOUo4AL9dp97VZCiUURfGshbXsc4XyAy51EmeckuGcUNAU4Go392RrnkzHNujF6Kv6OZ8IYo4eQ6kSQVJe19WzXhYhVCUGvdR5+l/UKDJuAerEQ3rw0Sdgu5Vx2XtypGNQHIzNVWA/42ywTnyQw66HIJq1BI4qCVcYMHp8zRwqURnMHKX5oYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(261009223027099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261021135927099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk5qUDJqWVZ1YTU3L2NaaFRBT1dMRkZSbFljYURkcnB5ZGtJKzVxTmRvQWln?=
 =?utf-8?B?NVlOWFpFK1lOamZTMVBpNElKbTJ1SVk0dDlqS3FwQkFKbEh0a3F4cStUa25T?=
 =?utf-8?B?WXlSOEpmQlpQSkJPb2ZRdk9IcUVQSExJT1pMNmZQblVDelM4MjY2cUE1Unho?=
 =?utf-8?B?SFdwV3phblRYQU0xbnI4eGc4ZVRBMlNUR0dNdTRJd2tneG5jRElOOGVkc1VV?=
 =?utf-8?B?d2ZOMkpiaEdnRlVXUVlUSFJsK0IxQTR6c3pSME8xV2daSG1nU1NEOVN2bVhm?=
 =?utf-8?B?Z2JXM255NG5oVnVnQ09MYXJyZi9ieXhxWTZMNXBOUHZvc295b1Y4M0ErSGJK?=
 =?utf-8?B?YzU5N0doSWI1Wk04c2FsZ0k5dG9QTGo1WU1Dd1hETFVyMHZBQkxSTnhFSlN6?=
 =?utf-8?B?OHdsRWh4emZtVS8zTXZSaWFSYXZTZ0dZS0wrOGwvQzdCai8wMkVNMkN6R2Z1?=
 =?utf-8?B?MnpiYWlUNFZSYVZxK3VNcTBQL0dhZ1haU2hmMzdmTitPVm9qYnR4eUt3VHlu?=
 =?utf-8?B?aFdsRVUrNW9FT1hibjR0Q2ZNZGJ4eTU3emQyUjEzblp1cjAyMExRd3JLOGtq?=
 =?utf-8?B?SUpOZGFUV2VmWGFhdlJadnhFQi83NFh3Mlo4VDFwdzBramxEZTNRcFNzb0xP?=
 =?utf-8?B?bUFuNjloYVhOOHlsdFcweW1QNng2ZnN0Rytadjh3Y1lmQ3hKbHlmSUlSQ3Zu?=
 =?utf-8?B?TlVsalpPRlBodzNGeUpDemg2UUlqbWdFaU1lUm1mRFNuTUJSbVdpYjV2MllH?=
 =?utf-8?B?d2VhWVFzenc0b1VQNDBtMk1xcStCaFBPeW5OSjVXbkdwL2FFeG15R0xZaDFq?=
 =?utf-8?B?MGkvZmpZL2tJUUIva1JxS29rMmdpNEMyM29SdDVVbSttM3lXTlgrWml4dHpT?=
 =?utf-8?B?OWtBSHl0OUtLYlNtZFlUK3phaTRRNk1ZWTMzeDIyeEhDdW0zbUhtZWxsaU9K?=
 =?utf-8?B?WGpoMU1XVVE1ek55cnFEcHVNdVMxWkRiUlNpV3NBeDJrMDJjemtYTEI0ZXBn?=
 =?utf-8?B?U05pQkUyS0UwMURmaFF5TGRGbVVqRmsxaHJjdEJtZ3I3clpudys2blN1Wnky?=
 =?utf-8?B?QnkrK3pqakNIVUNGZVdlTEcxb3lNb0xiVTRyZUMxMUpQNHhpZVlyME5ZZi95?=
 =?utf-8?B?cG05NFJpSU1VbU9yZEZjeVN0Vm1JbUlnTE5GM2RxUldWb3hyOVVIbWlGeUhQ?=
 =?utf-8?B?d2dKeWt3MFE1aEhkMGIrNE5jaUNMVUJ4WHprdnBMd292UDBpUDc2VWZYcGNE?=
 =?utf-8?B?YjQram91MjVqZ0tkQ0ZKRzlPZCtRUXJxdlVZL093N3BnZElMTy8rMlBNOGIr?=
 =?utf-8?B?MEVxSWdGd1MwRndIbVQ0YjJqRTVuZlY4UWVpVWxzSFhJNlc3NjFOdzRtcXFH?=
 =?utf-8?B?dzhiZDhKWGRMN2k2bDB4NnFkY04yM2hHc3pONWxtM0NkR2pVTHBWRVViVEsv?=
 =?utf-8?B?c0U2eFNlOEpIK3RlWDlvejJ4VVk1MERFck9oRUdGRCtzbHRuSHQ2UXdSczNm?=
 =?utf-8?B?TlNGM28yb1NaZkVqVklQKytkdkMraDRHWS82YTVsUnpuTlk2OG4rYkpqQ1Jp?=
 =?utf-8?B?R3p3c0p1LzRpRW10RC9lTmpHWjRRbzN6QjlsMVRBcWdaOE9nNVpvdENkMTM4?=
 =?utf-8?B?Mis1bTJmV2xCa09JcEJhcFhjazdTQ0FPSUl2Z0JxRzcxbGZaZm43dGtjZzVL?=
 =?utf-8?B?SzJUU3ROeTUwZkZGN2o0djhIN2xpTEJXRTNBUjFwK2pheWhJZ1Q1cHo2cisr?=
 =?utf-8?B?cTdGMmxDZHAxc2lrRmNHNzJMd3BuV1YvZkRnd1BxK21WQ0NhcnlNdlVjb3NL?=
 =?utf-8?B?bXFhaEhmc2haaXJGSUdUSjJCL1A3M2o5V3lKQ1JSbmNKaUlSNzc2MTFXR0N0?=
 =?utf-8?B?UjN3SDVpVWNkbGkzQkVVd28xanJqalRRVDd2Vmk4d0tkVWxjMUVNcmxCSzM0?=
 =?utf-8?B?TXc3akM3eSs4R0hVa0QrRmJ2OWp1WnczOE9XT1BsU0Q4TGZsZHdydjBTUkVU?=
 =?utf-8?B?dERoSGQvR2tYLzRJWXA0TjVHb0lwRklDMlRlWllZVDF3SlVZdFpZNnZ6eFUx?=
 =?utf-8?B?NUFVMmlVU1Z0ZEFpbDl0WHYxMmxZK0ZRVVpTQmVtZHhKQUx1NVJDNGlJVEtU?=
 =?utf-8?B?eDZXbDFTSzRNVStxVlJPRWFYeXg5UmxkWnVCUkI0UEZOaU9DY2lmOGQvbDRE?=
 =?utf-8?B?djJVeTJDRGFUUFZnWEJ3U254MkNpN3ZEMzA1TmJxbGszdWU1MmFXZXJ3bndR?=
 =?utf-8?B?TzBGZHVVOTlCeUgvQmtnS3JjOHU1Vzl0cGJ0RE90ellZT1dsa0JtS3F0aFBY?=
 =?utf-8?B?QWVRTDFldXp1VFQ5dTFvazZGbXZ3ck9nMndoL2ZSZVpJa2k4NUV4Q2paQk5E?=
 =?utf-8?Q?GCbo0OikMW9yU25w=3D?=
X-Exchange-RoutingPolicyChecked:
	KqDK+p1sEi2LqciGY8MRwrAaEp36rdQagexTZ2lQV+G7q8VFevr25sE4rUX2BHTIfaVSRcW/Cj8rVcKbQ2QgZHGPzDpyZxEaeqTaltMSf0QnykWuSZmz1ZVQG+IUYILaNorAzKxOzmGj4Z6qOcuLEzDNGjBQgmgozjdZcigonwOq4fYUcW01lf7b+RhgXj8LCndApzFmVbhtbwDXJETUqkowvj4cbICjniCTWrjooqqEVWcYkgwM3pYniIb1PZ5v7QR/gF6BoodgOVjb82Tmac73WQXpj9awe9LrcHMQP1/IFM0g6eZfHoQs3x7siBBzZTyd1ZPnIKYEFUZA0Zi0Og==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vEaImhumg5I/shgk+HrzjFGqaTsQpeetPlQiBAIQ/epaZxaLVU2LX1iZEnfHSokd4WYNge8YdeiIRHlWBkZp9myahxNHL99ltjJ79AZYUO5LqZpi2j7N+S4Gkz+uJTY9jN5QUlBVbbaGc8RZSN9qvIDaQV9ZwMeLw7DBz6687kSFZ/wUuC1W9wZw57nl+53p2xKpBfEW+Jh9pPUwaLcpo6sxkFDFX5KXaoc9aWEyMDCRxTsm8VVfZ+tZo/CXhpIT+5B53gqWodBK9kHdg4gl+/UWsRuv4CLj5ZhHficqmvWPlaTs8aBTjo2Vj1v6p0jRyGfr7gxTbP82U+nrHdaOiEcW0QJT1otWVYKr1cSPOdjiDwg3jr91k9mxlMu5uD0YVRkg0al+OdlCxrIVZMvP09k1V5tVz1Ni7IV44HSqophRItm/DMLimIIVNfzbUuOJU7MX8misdWBZN7MyZ8+ol5xvkC1uew3t2nosFkzJPlXqvEIvXmFl9d/WPzSc9jD5CUaSiF1wSWGR1aaY8PYv55/NISak0pF79LqnrFsOnCkG9+sbAI3Y9+pw1aTpsaWMI7oDbNfFipnSqgBgA6ILNWykhq1MXkP6gUm15RjvFkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f101b679-cdff-4903-f61a-08df3586820d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5520.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 06:33:13.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llwuWNO2yN0GI9rqUJ30ZUCTkCeu79w2yA1c8rLDniXBoOZjwrjWPq4WUApcMksx0I39N+SgLqfCQm57+DJ2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 spamscore=100
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=-999 lowpriorityscore=0 mlxscore=100 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290023
X-Authority-Analysis: v=2.4 cv=D7/SufRj c=1 sm=1 tr=0 ts=6ae2e8ad b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=WEYkAtlc4yVvl4RBVUkA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: DP6glVOKgQmoljcoCMsY7JZZbRMHaoBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX5WdKBJkSxiIP
 E8fy+9mJ3UYpXtmqehcxZsAiRjzGq9PWVcMC7pS0J10Fk3dxtGDYX9zNouKktn1IedXFz4KIOJk
 0HZBZOImL3+/sm7QxZr9b1aYI0xuH9kB8VtqDUl4YXybZy3t2wlD7kL38/vka0z0yleUBqkr7Wu
 7I08d8NiAivgHoduIPdIjVhVMgprmZNmCdfqM4bPki99FjoNseXrvMEbXzW0e3VSj0ipuZ/8DdI
 e4WBFiXHpKEe7MMzeci1/o/khLblKEV5Bn5/y0pe7XD/m+dt8LzSqO/m4AOnQG9ts+w8UkvFvFW
 xOTNk5gI0VN2YJKj36xzrFRMeVi/Nb1s6Q6ycUBI1SQwSxAexjorZH9Wli8uV6zySwWDEGJp1YE
 YNzXdfASG/gJ7pae55to97eG2bAQ2mzEFkAEmqNUt+wH3wsOyRUGrlSKCZ2EhUebVich6zkxavi
 hw0lankE+YUGU+9jxltQt8FQbQWHId1tr/ebScjg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX1EhdtBlXb+DU
 bN6+3WiTEUga12zblUO20hLRGeurd/NRA+2ydvvrvh6zhPmGYdW+yLifsx0sBYMDVBTdg/TLNOp
 /3i5tQCLM3+fzvgdogJbiLOKM5iz6jMyuzKlYxyi8uqtarVBSrT/
X-Proofpoint-GUID: DP6glVOKgQmoljcoCMsY7JZZbRMHaoBW

Here is how I reproduce the issue on purpose in a KVM environment.

Apply the KVM patch below to the host kernel to add a debugfs interface that
lets you inject an arbitrary vector into a specific vCPU through kvm_apic_set_irq().

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 0074a56e45b4..11f94421a797 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -8,6 +8,7 @@

 #include <linux/kvm_host.h>
 #include <linux/debugfs.h>
+#include <linux/limits.h>
 #include "lapic.h"
 #include "mmu.h"
 #include "mmu/mmu_internal.h"
@@ -56,12 +57,38 @@ static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)

 DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops,
vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");

+static int vcpu_set_apic_vector_inject(void *data, u64 val)
+{
+	struct kvm_vcpu *vcpu = data;
+	struct kvm_lapic_irq irq = {};
+
+	if (val > U8_MAX)
+		return -EINVAL;
+
+	if (!lapic_in_kernel(vcpu) || !vcpu->arch.apic)
+		return -EIO;
+
+	irq.delivery_mode = APIC_DM_FIXED;
+	irq.vector = val;
+	irq.level = 1;
+
+	if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+		return -EIO;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vcpu_apic_vector_inject_fops, NULL,
+			vcpu_set_apic_vector_inject, "%llu\n");
+
 void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry
*debugfs_dentry)
 {
 	debugfs_create_file("guest_mode", 0444, debugfs_dentry, vcpu,
 			    &vcpu_guest_mode_fops);
 	debugfs_create_file("tsc-offset", 0444, debugfs_dentry, vcpu,
 			    &vcpu_tsc_offset_fops);
+	debugfs_create_file("apic_vector_inject", 0200, debugfs_dentry, vcpu,
+			    &vcpu_apic_vector_inject_fops);

 	if (lapic_in_kernel(vcpu))
 		debugfs_create_file("lapic_timer_advance_ns", 0444,


Here is my QEMU cmdline to create the guest VM.

/usr/libexec/qemu-kvm \
-machine q35,kernel_irqchip=split,dump-guest-core=off \
-accel kvm -name debug-threads=on \
-cpu host \
-smp 4 -m 8G \
-monitor stdio \
-device virtio-scsi-pci,id=scsi0,num_queues=32 \
-drive file=boot.qcow2,if=none,id=drive0 \
-device scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=0,bootindex=1 \
-netdev user,id=net01,hostfwd=tcp::5025-:22 \
-device virtio-net-pci,netdev=net01 \
-no-shutdown -vnc :5 \
-kernel mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda1 init=/sbin/init text loglevel=7 console=ttyS0
crashkernel=512M" \
-chardev socket,id=serial0,server,path=serial.sock,nowait \
-device isa-serial,chardev=serial0 \
-S


After the guest VM boots, inject vector 50 into vCPU 0 to reproduce the issue.

hv# echo 50 > /sys/kernel/debug/kvm/*/vcpu0/apic_vector_inject


(qemu) info lapic
dumping local APIC state for CPU 0

LVT0	 0x00010700 active-hi edge  masked                      ExtINT (vec 0)
LVT1	 0x00000400 active-hi edge                              NMI
LVTPC	 0x00000400 active-hi edge                              NMI
LVTERR	 0x000000fe active-hi edge                              Fixed  (vec 254)
LVTTHMR	 0x00010000 active-hi edge  masked                      Fixed  (vec 0)
LVTT	 0x000400ec active-hi edge                 tsc-deadline Fixed  (vec 236)
Timer	 DCR=0x0 (divide by 2) initial_count = 0 current_count = 0
SPIV	 0x000001ff APIC enabled, focus=off, spurious vec 255
ICR	 0x000000fb physical edge de-assert no-shorthand
ICR2	 0x00000001 cpu 1 (X2APIC ID)
ESR	 0x00000000
ISR	 50
IRR	 34

APR 0x00 TPR 0x10 DFR 0x0f LDR 0x00 PPR 0x30


Another way is to apply the patch below to the guest VM kernel.

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7d7175d01228..16ce4aa4c3c5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2273,6 +2273,10 @@ void __init setup_IO_APIC(void)
 {
        int ioapic;

+       pr_alert("debug: setup_IO_APIC() delay 5 seconds ...\n");
+       mdelay(5000);
+       pr_alert("debug: setup_IO_APIC() delay done!\n");
+
        if (ioapic_is_disabled || !nr_ioapics)
                return;


Inject vector 56 on purpose during mdelay().

hv# echo 56 > /sys/kernel/debug/kvm/*/vcpu0/apic_vector_inject

(qemu) info lapic
dumping local APIC state for CPU 0

LVT0	 0x00010700 active-hi edge  masked                      ExtINT (vec 0)
LVT1	 0x00000400 active-hi edge                              NMI
LVTPC	 0x00000400 active-hi edge                              NMI
LVTERR	 0x000000fe active-hi edge                              Fixed  (vec 254)
LVTTHMR	 0x00010000 active-hi edge  masked                      Fixed  (vec 0)
LVTT	 0x000400ec active-hi edge                 tsc-deadline Fixed  (vec 236)
Timer	 DCR=0x0 (divide by 2) initial_count = 0 current_count = 0
SPIV	 0x000001ff APIC enabled, focus=off, spurious vec 255
ICR	 0x000000fb physical edge de-assert no-shorthand
ICR2	 0x00000001 cpu 1 (X2APIC ID)
ESR	 0x00000000
ISR	 56
IRR	 32 48


Thank you very much!

Dongli Zhang

On Wed, Oct 28, 2026 11:31:12PM -0700, Dongli Zhang wrote:
> This is to fix a LAPIC ISR stall that can happen in a kdump kernel, but can
> also happen in other scenarios.
> 
> The issue can be intermittently reproduced in a QEMU/KVM guest when there
> are large number of VMs on the same host.
> 
> Device interrupts can use the PIC, IOAPIC, or MSI-X. Nowadays, most x86
> device interrupts use MSI-X or the IOAPIC. However, the PIC handler does
> not send a LAPIC EOI, even when the interrupt it handles has set a bit in
> the LAPIC ISR.
> 
> For example, suppose there is a QEMU/KVM guest using virtio-net.
> 
> 1. virtio-net is about to deliver vector 52 to CPU 2 (APIC ID 2), but the
> guest suddenly panics on that CPU.
> 
> 2. The kdump kernel boots on APIC ID 2, which becomes CPU 0 in the new
> kernel.
> 
> 3. Suppose delivery of the interrupt is delayed, so vector 52 has not
> reached the CPU yet.
> 
> 4. On the new CPU 0, init_ISA_irqs() initially sets up the legacy IRQs to
> use the PIC. Vector 52 maps to IRQ4, which is normally used by the serial
> console.
> 
> 5. Before these legacy IRQs are handed over to the IOAPIC, suppose the
> delayed vector 52 arrives through the LAPIC and sets its ISR bit.
> 
> 6. The new kernel handles it as PIC IRQ4. Since mask_and_ack_8259A()
> does not send a LAPIC EOI, the ISR bit for vector 52 remains set.
> 
> The below is an example when vector is 55.
> 
> (qemu) info lapic 2
> dumping local APIC state for CPU 2
> 
> LVT0	 0x00010700 active-hi edge  masked                      ExtINT (vec 0)
> LVT1	 0x00000400 active-hi edge                              NMI
> LVTPC	 0x00000400 active-hi edge                              NMI
> LVTERR	 0x000000fe active-hi edge                              Fixed  (vec 254)
> LVTTHMR	 0x00010000 active-hi edge  masked                      Fixed  (vec 0)
> LVTT	 0x000400ec active-hi edge                 tsc-deadline Fixed  (vec 236)
> Timer	 DCR=0x0 (divide by 2) initial_count = 0 current_count = 0
> SPIV	 0x000001ff APIC enabled, focus=off, spurious vec 255
> ICR	 0x000c0400 physical edge de-assert all
> ICR2	 0x00000000
> ESR	 0x00000000
> ISR	 55
> IRR	 37 38 39 40 48 56
> 
> APR 0x00 TPR 0x10 DFR 0x0f LDR 0x00 PPR 0x30
> 
> This is painful when it happens in production. The kdump kernel stalls, so
> we cannot collect a vmcore for analysis.
> 
> The issue is easier to reproduce with a customized KVM host kernel that
> allows arbitrary vectors to be injected through debugfs and
> kvm_apic_set_irq(). I can stall the guest kernel by injecting vector 50
> into vCPU 0, even after the guest has booted successfully. Vector 50 maps
> to IRQ2, the cascade interrupt between the two 8259A chips. IRQ2 is not
> taken over by the IOAPIC.
> 
> For other vectors, I can reproduce the issue by adding mdelay() at the
> beginning of setup_IO_APIC() and injecting the vectors during the delay
> through the modified KVM host kernel.
> 
> In theory, a normal kexec reboot may also hit this issue if device
> interrupts arrive late.
> 
> Fix this by checking the LAPIC ISR bit corresponding to the PIC vector and
> sending a LAPIC EOI only if it is set. Cover both normal and auto-EOI
> modes.
> 
> Assisted-by: OpenAI Codex
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  arch/x86/kernel/i8259.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index f7a86b94a0dd..73939edb8c2b 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -144,6 +144,16 @@ static inline int i8259A_irq_real(unsigned int irq)
>  	return value;
>  }
>  
> +static void apic_eoi_8259A(unsigned int irq)
> +{
> +	unsigned int vector = ISA_IRQ_VECTOR(irq);
> +	u32 isr;
> +
> +	isr = apic_read(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(vector));
> +	if (isr & BIT(APIC_VECTOR_TO_BIT_NUMBER(vector)))
> +		apic_eoi();
> +}
> +
>  /*
>   * Careful! The 8259A is a fragile beast, it pretty
>   * much _has_ to be done exactly like this (mask it
> @@ -190,6 +200,9 @@ static void mask_and_ack_8259A(struct irq_data *data)
>  		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
>  	}
>  	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
> +
> +	apic_eoi_8259A(irq);
> +
>  	return;
>  
>  spurious_8259A_irq:
> @@ -224,6 +237,12 @@ static void mask_and_ack_8259A(struct irq_data *data)
>  	}
>  }
>  
> +static void mask_and_ack_8259A_auto(struct irq_data *data)
> +{
> +	disable_8259A_irq(data);
> +	apic_eoi_8259A(data->irq);
> +}
> +
>  struct irq_chip i8259A_chip = {
>  	.name		= "XT-PIC",
>  	.irq_mask	= disable_8259A_irq,
> @@ -386,7 +405,7 @@ static void init_8259A(int auto_eoi)
>  		 * In AEOI mode we just have to mask the interrupt
>  		 * when acking.
>  		 */
> -		i8259A_chip.irq_mask_ack = disable_8259A_irq;
> +		i8259A_chip.irq_mask_ack = mask_and_ack_8259A_auto;
>  	else
>  		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
>  

