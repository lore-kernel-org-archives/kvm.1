Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130154;
	b=2gmINpqGHlHU7mDCTDNfazJ8upwFx64zMHFrKDjmFcL/i8Qm8vdv3U6pNp0nyuQYA/OF
	 mHcoqlnhMp5NdvWlCgE5HRdEbGwXvbIPM2qsJQut7wXC7kfhKXpRF0g5xS+LZOLaDv8It
	 B6YToL++BWQsb/RDv/DjApGKMyR/iSQCgHkdN64DWqVSauPb3GG/D0p59Snih4seHDnCL
	 nGNiIG/ykfm4rGWv84LtN4XM8DrAt52zIlSdx6FKxmVo5iPkjl23oXSH24O20rU/kbjNp
	 XXnebRh0lI0GYrllgvBYjtXMGDdVJ8qHv9q1MvWnz9gdJrptHSt42lnLpmf9KexXOsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130154;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=JL6AHxIqJj7vzjqWmrEsTIC8ezD4W/8zK4oO5oQVI5Y=;
	b=ARFpThkyfwFmCqnqln1eWiDDYFkacitbXwQKZDUTe1fkypdRUiT9o7Co6n5/8XfA4qQh
	 dSL4OMvlH/Eh0EOkfmCs+ZRgCG0xTThPrQghXA/dETbd1HN/p1bK8WGu/qOM9Ez/nPyA0
	 A6hkxWb8WRQQ6p6tXJkjBs8+2JdkHQd5Ho6/NuHdYstBbLcd5xNbIVdszP9USc2ScdN5/
	 9JAwe7D2PrRY1Bh/1/9E9jxNO6eV/fmso/27lk/aAWZR1E9+ONesciGtKYzsQunWXLL5H
	 RAcn561twdAcSlVkEU/65eIganN8c4jRE41MMOpjgnZmndXCBVhV7t5y1OQ+ZKvGAig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=c51Lwi5+;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=h9MY5LHv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FE606A31A;
	Tue, 27 Oct 2026 19:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 431FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=c51Lwi5+;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=h9MY5LHv
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RInhVD2031986;
	Tue, 27 Oct 2026 19:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JL6AHxIqJj7vzjqWmrEsTIC8ezD4W/8zK4oO5oQVI5Y=; b=
	c51Lwi5+qXfoFimqQOXRiQ6SfbUwoYMx4AgwBGu/52tqWUmAsTa6HXsWOm/dfxjC
	/iiL+c9orpJbECRTJXcNghNOwvBf6M4Z1/NUfj9IX9ia5qfhxoaeCo0Zdh7CxV+f
	TdT0bX6erecD/rvIzhn4sjWklJ7rcw7MU0f6dQQp1SQ/wD0hdqMADwsxH52CQO88
	5GI9wMyb3GHNBBJTcmSYhye986BNTUsXQ12bGJPK7f9mtJ1C3L1nrTJqzMiRh0YR
	vaJkF6NkIE3ewXnxYwOwJIvjhdFLXOTr+yD8rl1bX5VVJcxPjtUebudMqlvP2+qJ
	ssBekZoUO4x9copFra6PAA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgkk94vsu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 19:42:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHvOr2412416;
	Tue, 27 Oct 2026 19:42:22 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hk0vyka1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 27 Oct 2026 19:42:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubBeY2NP4SWWoEyJPm6Wwxq13VnRvwikoUIi/73sfssiHcOR0C4K1xTUntFrmn2Gqfn8LbG50DWiStrncfnExWZPz8jtcu9jQWUc9BB7WVbbLzuigvCMr7uVU2I5DMa4qhTcAYnr9Ah7KNUx2PpR5J8wo/F2wxKwFN67HYfnS4+0JtEuOLpNpMz3XxMDgLHr2ykR6kY8+pa6jIrHawIxETHo9o/BUyA3PwB/CLnLfv1pUKE+4SUOnR5QKF2dRpbRCStU1fbLPUCj27OYFPxGBv3vd0vLZh3oEN/vUwaTO8M2mqrtcLCxmJaegyZ7I0K0AiELKU0OzRZa5XHGkovOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL6AHxIqJj7vzjqWmrEsTIC8ezD4W/8zK4oO5oQVI5Y=;
 b=MwG17002bFQXtkLizTXrjMXZlXxSLD16NyBdmPapaSYI7ag3jQRUWg37u7IqCOVJNZZBmDof4qFTbqKJwfjnCpsmyX9sCqTe1r7RvaO0bDKQRoqpe+oRMC5mS/o1K6AHBVphduPwfJ4857S5ohMb9FYvefvLjcRzu13ktr1SkAdssHlwqlKPUwyxG4lOz+64ws5MJeWruPggazl+zOCd0ej8+j1j/aL14AYlIGgHfNnBciT8lUZq+jGcXIj2BV4aELHhez2HnYKSEU1lgpXj+CThnyLBK0QL0/rIk4OuhU/zASGMDA7xCRyJfbR+4tFvsj1uJa+LpaI8/by6xSR9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL6AHxIqJj7vzjqWmrEsTIC8ezD4W/8zK4oO5oQVI5Y=;
 b=h9MY5LHvUNWhjfCcHxhbvxbXbsW1cjhCFUiPrRqqcaz0nRxaXr+Hci3ABs+ZkmwvjFlONAfwkza9wiTd/k1Xo+X4HCHYzC7PJyVSnzE0M5s7dzMnFGl+1uWYNxI3ELp/HoLeqKU22vr8uWSZ5haxrkv5wpATmvLEnhWG+2iJX/E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:42:11 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:42:11 +0000
Message-ID: <85b0e3aa-0b84-4a00-852a-821aed4a0649@oracle.com>
Date: Tue, 27 Oct 2026 15:42:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86: Select lowest vCPU ID for aliased xAPIC IDs
To: Sean Christopherson <seanjc@google.com>,
        Partha Sarathi Satapathy <partha.satapathy@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, wim.ten.have@oracle.com
References: <20261027051808.243000-1-partha.satapathy@oracle.com>
 <auDF9WpqW8OCu_8w@google.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <auDF9WpqW8OCu_8w@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::33) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
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
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8520c778-31bb-4da2-1614-08df346264ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|261026121527099003|261021121427099003|4143699003|56012099006|261022105027099003|261009223027099003|261021135927099003|261021123027099003|10067099003|261022075727099003|18002099003|22082099003|6133799003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	6oV2ZAw8ZcmsaUSB7A7gF9Uqidf1SNXG4K/8pkRGLe+Jx8jddxMHtPwCxQ7GvyI4ECrxi+q0sITK609LEEdKvJYTrYJJpVzjZmHbgPRKGYe4LFodQd8miT6b7rBQ91PBQ6hMwBa1V1khpfEP3t6UiywTpcLF9EsZfGXgZxBTeUSk2Nr13L0yGbkoG4Rr64pHnycmZnr7x/vlUyYDKxB7cTJP0bDMyDneUf4BZ7ZdOj/rJl2hM9XfR1ywfArgefl3sLDL+u9bW+4gfxZ8H0zaa+LTM/lrkqqA8P05cfqfM3t73QNgz2d3zNnfkrXlzvXyRl3Svg43X4vNiNV7T+M/Apb5aIQaPX1HZEThPPTPt46sV8oCTA4PRY98XPicbWdrcEa0nGN1UoTpdGBpZ5fx6ItNsBvUmbAmFBzypi6C8ZW0pXc3bROPQzf8obnT94nufUyoAoUuN5ffPiZyQE4o/XSoCUYogazKqFH7mV8t+2tMp7LExVUqHNZ/XU94+wb7ebB+p7pc6ZR9QcXb+brEAP0hHp6UURRCIzk+6w7eSpooUWltiiJRvCpcmDjO9WYD9gpGPB1VmkE7fzNJrOkM3HvKBJ/y9tcilEgrAWwGwcfym4NEApL69Blvdw2njRaX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5041.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261026121527099003)(261021121427099003)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261021135927099003)(261021123027099003)(10067099003)(261022075727099003)(18002099003)(22082099003)(6133799003)(3023799007)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1PcmpvalN2aTRwWlhXK3NvWk1RTVh0SWZLUGRhVHhSV1oxTFp6b1RaNmkr?=
 =?utf-8?B?Rjh6R3lJdUZsSHA4VEpKZDJFcVNHVWJQeEZ5c2lKZGl0UGdoTjMyWmxrL3JT?=
 =?utf-8?B?WXQwWWd4VlhKZ3M5enROdjRDSGZMU2wxN1gyQzRtYWpveHo3TDMvL1paWVZW?=
 =?utf-8?B?aWllVDVzWUNzd3NZWmI3L0JtKzZZTytXb1NrYUZPUHpYMHh3NG9UR0pHeXlD?=
 =?utf-8?B?R1JDZzRTcDh3WVQvNlBTSnpqdit0c2ZtVWZ1N2Mxbk1CcjZheHU5TTduVzJp?=
 =?utf-8?B?TVN1RXJ2Z3RNYmxsRHp3YURVWDgvd0VrY21TS3hrOUVkYVlKWHRLMmphYnBM?=
 =?utf-8?B?ci9RQWoyOUVIOWwrZ0xXVmQwZThwSElXQ0NPcVNnNi9Ubk9GSFZMazJveHB2?=
 =?utf-8?B?OUVUNHRTd0tKbkNnQURjTFdYUEgwdHNOQVBwRjFZdXErZ1RQU1BGZ0p5R2s4?=
 =?utf-8?B?YmFabHdHVUh1ck5DVExXdVVPMkUvYWRtd3NJaE1WWWpBeStwZENDQlh2UmVx?=
 =?utf-8?B?RGtzc20vSWRYaWUzM2JYK2FoRTE3aDNWMTdmdmVPZE93dE92WUcreVFoeGg0?=
 =?utf-8?B?d2syekFvaGZsKzNQbWxxZUNlYWxtbjJCTk5rQ3ovOWV5bGhJcXFkOWRlWHdZ?=
 =?utf-8?B?aXNUTnZuaURUWFdlRTBTOXBCSFRIWWNrT1cyMS92aFZndDNrKy9ZRGtFY082?=
 =?utf-8?B?UGdZL2tUejBkbzlUeEdmWGtXci8wMWUyNWY3L1c3UUVFV2RndGp2Yi83OTFO?=
 =?utf-8?B?d3pJbVVzNFVBSmt4cWVHckNoZi9yMjlXS2ljcFVpNXZjRXV0THhvclB2U0RD?=
 =?utf-8?B?Q2NSY0NMdlBRUzNFeWNRRHNBb1BoVGVBUEJ5R3BrN2tOQ2pEdTJrOFc0a3h2?=
 =?utf-8?B?OG1vd3VMaXVQZSt4TVNTU2ltYWZZYlI2eERXQm56TjZhblpvVnlqNjFVaUgv?=
 =?utf-8?B?YmFQV255M0VKL2VSL1cxKzgxeE9yYitpTmFUa1ArREgxYzBQUGZ6NWwxSDdz?=
 =?utf-8?B?RkkyaElTTlJ0T1VxREJaSUFSTjBYTGF4b0xWVUNnZG92MkJVcFo5cTRuRmpE?=
 =?utf-8?B?Q1hNMDJCaGtnekt1dFQxUXJHYWdKeWIwV2dBRHBXMnJSalJjMmo4ajRsQmF6?=
 =?utf-8?B?Q1hWYzVTMUpJNDl1dFpQV1ZteFVTZzBvaGZQSkdaT1R0dkpwdDl5VWJWM1pM?=
 =?utf-8?B?YnEvMTExbFJMRlRmTS8xL1R5QzhiZUlydTNZSG15ci9sdGVZcTdQWVJDSkdK?=
 =?utf-8?B?Nm54c0J1TXpGWEtGMWlOQmFtdCtiZ1R6UEZBTklMZ2cra3RlV1NKVzZzd0lw?=
 =?utf-8?B?SmZ1YXY0VkUxanF4Z1hDRjB0NCtIL003ME5DdEs1VUxFelRQdFhCd2MzUENo?=
 =?utf-8?B?QXlFOXY3alNRWFg1UDFtSTJnSGQ5S2hmcVovVlFSdHBaVkl0NFhlVFhvTnZ0?=
 =?utf-8?B?cnpYY3dJa28zMzBBZTdWdFgvKzdVV1pVR1VhemowNVBUaHB4NE5Mb2d3TFZ5?=
 =?utf-8?B?KzZQWGdtRTlxV0ZRWlplV0NUTVMrZmdBWUpVc0J2YkVEY2FxS3B3TFR1aTdR?=
 =?utf-8?B?aXNpeU9GTzc0T3Z4RFNjTStPUlpKazN0YlcybDNWekJvTlFoZ1ZQMncxSUdV?=
 =?utf-8?B?S1dyNS9EeTg0azBrNW4ycTJic3U2b1hUdllCVUcvQXUySCtGUUU1Qys5ZkpV?=
 =?utf-8?B?cXJ1MkdkZ1JxMVYyQTl1MVFjQUJnR1NseGF0RXBzUU00SWoxQ3JQRkUwMmVv?=
 =?utf-8?B?d0h1cHBEV1J6SGxGbURWNUtZRVZRKzZEYTRYK3JReDVFSHVtSVIyMVJ2ZjdD?=
 =?utf-8?B?R1Rsb3QycUQ2d2xGdFN6QXluMEs0bkdBZTQyTFlXbjFGcWJ5ZGNoVzZQY0tQ?=
 =?utf-8?B?OVFrWW01Tk9ycGhVcmFXcWk2QUxDSng4UjRoTmVvaFE1Vk9rRUdoSyt1cE9j?=
 =?utf-8?B?cnVDZVF5WHNlOWh5QVdvZkRQMTZCRVp4UVlLMFM0ckNnQjVVbnVOcXRBMm1q?=
 =?utf-8?B?T21sdWFRNFhoTHg1TUl3bkVYU2FjMnJjb3g3b1gxc002eUpINk00d3oyZWtV?=
 =?utf-8?B?TXdkeXNtb1doQzZCNTVVbFR2dE0ybUhKem5uN0hpNzAvay9uVlFrMHZWZjBY?=
 =?utf-8?B?dHBhR3NRUXUydnNxNTQzalduZXNDcnZZbHNjSFNJRDdoWXIrRWxzTE1mZzVk?=
 =?utf-8?B?UEt6MkFQY2M3ZVFRUTB6SUtQV21lS2xjV1lCNTB4Vk9KaVpZVXY1L0FYdXRn?=
 =?utf-8?B?UTZDZ21aOFlVbUo1dk1VZEdzT0pub0tYOXp6SlhGd24vUmd5S2pXUU9ETU5n?=
 =?utf-8?B?MVoyQ0VDZFNOS01MZlBPZWFUcDZjbmNKcWRaVUdCOUxEd3M5bG9tMUxXSE1D?=
 =?utf-8?Q?OAY6zsUhS3aJIBV0=3D?=
X-Exchange-RoutingPolicyChecked:
	5ABcjFjVZVoXmxZ47GTnXPFTNrf7Thu0DqRdVwmKK0g33PR4ODmYjs9sFQcLUlYteA6Rq+HRz8hDScQKm50AaYKGsXlgrh3piAf5bvEdUoLj1Vg6QR1qJUPPQMyQ9/rnv+lpzvxLaC8hojdrV3PmJR+af9+PVn8jV5woMoglEIJleYpZLPyh9OioLmUKYAkDy66xLk+uZG71LmIOkClb047wy/SuQFqCR6LHzTczlSSpr8C2ZVGZDI7dK4Mc165yKKqJREtoDSqczHxexaQBKtN8HtOdHhKJQCeuFjU5KaIZIcUv2OROkE/r1+Z/+cRMM63C18Dv+PnXCA4Xa6K6CA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z4SulEU+HKs/hPXanPkqml+OkyEvFx39z9b0Xnr05b1wulW6gQS3TS0iXqX/3i1ymUq3URu8pKqdmXXOMt6bPJcRMQGM+efwgsQ04vW3ued+MRNxnpjEeAi9rX762F41cDvk86Z8xJo0n5Ih3q2tOfNXyI/xud4lklft7L3eEJZ3rLpWJihiGHHVoHYmoANJF+mFw6XBAHz/cIYztAc79KCOJLyVkdKYA+p7Fbt1uHp9oGC2nliZuBz1wflFz3/2Cn3LGJwl2GNqTVPhOl+kAUif8LuZAZxf8dEYgGOPz+4mAG9TalfIiXXHHvP4b+zJ6ikIxYp/3brkdoNQE6hO3rgpfUSWc36ORnRl+ExzYlBixCfORrh9JxXxHSrEChqDpKYGboW3yXB6pZN8jvaSTzpcrqyyzXw+Qz+rlOxaVbgoSkYq3FnBxsFdM6sN0ZJM481dSKrP9M3n/IKRzjNWmIjag6f1mANXh74pKmXAdCBIwvsbnCztirZd2IENb4BGumV27vUiXGzqlo5JWhJeevUvlT8dfu+HOi3sUVaK08aYEswIJGr92jqzmzGsxNA/1CnV4RX8Y6rlVwyWP3wYEySoZUi34cFA2KVgZwPeRV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8520c778-31bb-4da2-1614-08df346264ba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:42:11.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOgZGL/DdFlaa1PeEwjlrgdRCnZjXevOx/dmq6AmkDP5S56+ZgbYNyCCMfxC7ePhWDjaTVHx2lKUBlc/ecYySOK+m42c1bSjoHOPhWFSjdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
X-Authority-Analysis: v=2.4 cv=D7/SufRj c=1 sm=1 tr=0 ts=6ae0fe9e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=K_PsqQkFJH4STHmAPr4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: -F8Hq4vK_uUiei6VE6GcVNGQTtvBvzcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXyzTFKGofq2ta
 HCeGW4ZdIqTtNE8OaPohUNkC9DlryyaGo43s5D5JJ6Nso1SVD1TdgYdli+li6Vq9i5j5Xq4agzh
 dEObPypRvB6Ir5OwM/vxwWG2MgRpO/YT/wG6rmug5nY6x+j2jGk7SmhWXzwCzwz3QF2zXPuC7We
 235+VwGAx1qZsCOhs4JRfsERdDJV634eRHoFZ5QtEbgSlPXIox4uqG7SgGsux1FceUQ6w9AFpbs
 G+jFJFunahmieu/ezT2oZn0A54my1DBvS5FjIrl9GDnlXOED4/bw2V6ozB1modMQDpPT/JaX6s2
 /Wm68pMbo4IEP2+ortWea11CsMF+LaFSSRFWuNu9cADm8GVpChYeHDiwgctSnyHKNjSd4fQnwbv
 xoNf6D3/Sx9M/+iBlyQ04W63xNzN4XaL0RMQjkBF0dGrqkmdYL1k3oQt0cCinE2b83TODBQeVBA
 nuE27LaU7URL3PjRIag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX/LekqtLC4G4w
 dxBfIO/yxe2p/VbAyTQA2G3DPxdncsRDXbuP2+QXHlLkwZPjWdSqtjdyJy0ojdRJjRyOZqXf1YI
 5MzFm+xhnveZ6glaE0OF9P0z0IXMPfeLVbVZ3z3iuN7DCCu995cX
X-Proofpoint-GUID: -F8Hq4vK_uUiei6VE6GcVNGQTtvBvzcD



On 10/27/26 11:40 AM, Sean Christopherson wrote:
> On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote: > From: Alejandro
> Jimenez <alejandro. j. jimenez@ oracle. com> > > When
> KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug > quirk
> allows events to target a vCPU
> 
> On Tue, Oct 27, 2026, Partha Sarathi Satapathy wrote:
>> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> 
>> When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug
>> quirk allows events to target a vCPU by its x2APIC ID while the vCPU
>> is still in xAPIC mode.
>> 
>> In xAPIC mode, APIC IDs are truncated to eight bits. Consequently,
>> vCPUs with distinct x2APIC IDs can share an effective physical APIC ID.
>> KVM's x2APIC erratum specifies that an event targeting an aliased
>> physical APIC ID is delivered only to the vCPU with the lowest vCPU ID.
>> 
>> However, the optimized physical APIC map does not guarantee lowest-ID
>> selection. When rebuilding the map, KVM retains the first xAPIC-mode
>> vCPU encountered for an aliased 8-bit xAPIC ID. Since vCPUs can be
>> added in any order, that vCPU need not have the lowest vCPU ID.
>> 
>> For example, vCPU 19 has x2APIC ID 0x013 and vCPU 275 has x2APIC ID
>> 0x113. Both expose xAPIC ID 0x13 while in xAPIC mode. If vCPU 275 is
>> created before vCPU 19, the map retains:
>> 
>>   phys_map[0x13] = vCPU 275
>> 
>> An INIT/SIPI targeting physical destination 0x13 then starts vCPU 275
>> instead of vCPU 19. vCPU 275 executes the secondary startup path for
>> the firmware CPU entry with APIC ID 0x013. After vCPU 275 enables
>> x2APIC, Linux observes APIC ID 0x113 and reports:
>> 
>>   Firmware: 13 APIC: 113
>> 
>> KVM hardcodes a vCPU's x2APIC ID to its vCPU ID. When populating an
>> aliased legacy xAPIC entry, retain the vCPU with the lowest vCPU ID.
>> This makes optimized-map selection independent of vCPU-add order.
> 

First of all, apologies for the confusion since this is an earlier WIP
version and due to a miscommunication it was sent as v1. The selftest also
has changes that are not included in Patch 2. I will send a v2 after the
discussion on this thread.

For this patch, the intended commit message is phrased/focused on
maintaining the stated KVM hotplug hack behavior i.e. the commit should be
more like:
--
When KVM_X2APIC_API_USE_32BIT_IDS is enabled, events targeting an aliased
xAPIC ID must be delivered to the vCPU with the lowest vCPU ID. However,
the optimized physical APIC map does not guarantee lowest-ID
selection. When rebuilding the map, KVM retains the first xAPIC-mode
vCPU encountered for an aliased xAPIC ID. Since vCPUs can be added in any
order, the initial entry does not necessarily map to the APIC of the vCPU
with lowest vCPU ID.

Compare vCPU IDs when populating aliased xAPIC entries and retain the
lowest one, making destination selection independent of vCPU creation
order.
--

> I'm genuinely curious.  What VMM adds vCPUs in a "random" order?  I agree a fix
> is needed, as KVM should be internally consistent (kvm_apic_match_physical_addr()
> will always try to match the truncated ID).  But this also makes me wonder exactly
> what userspace is doing, and why.
> 

The issue was triggered with QEMU and a tool that uses libvirt API for
resizing guests and balancing their vCPU allocations across NUMA nodes. I
am not sure if similar work has been published upstream, so I'll defer to
Wim (CC'd) if you want more details.

A basic reproducer (besides the selftest) simply uses QEMU to issue
'device_add' QMP commands and starts with a vCPU placed on socket 1,
followed by its "alias" on socket 0. e.g.

{ "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
"id": "cpu117", "socket-id": 1, "die-id": 0, "core-id": 11, "thread-id": 1 } }
{ "execute": "device_add", "arguments": { "driver": "host-x86_64-cpu",
"id": "cpu017", "socket-id": 0, "die-id": 0, "core-id": 11, "thread-id": 1 } }

I wondered initially if this approach was breaking some convention, but I
have not found anything stating even a "random order" is disallowed. So
here we are...
>> The separate full-ID entry remains unaffected, and destination 0x113
>> continues to select vCPU 275.
>> 
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
>> ---
>>  arch/x86/kvm/lapic.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index 1597dd0b0cc6..5dedffddebec 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -245,7 +245,9 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
>>  		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
>>  			new->phys_map[x2apic_id] = apic;
>>  
>> -		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
>> +		if (!apic_x2apic_mode(apic) &&
>> +		    (!new->phys_map[xapic_id] ||
>> +		     x2apic_id < new->phys_map[xapic_id]->vcpu->vcpu_id))
> 
> Hmm, I don't think KVM should always override a smaller ID.  It should be a moot

Why should it not always override the smaller ID (in cases where
KVM_X2APIC_API_USE_32BIT_IDS is enabled)? I interpret the wording from
x2APIC section in:
https://www.kernel.org/doc/Documentation/virt/kvm/x86/errata.rst

"KVM will deliver events targeting that APIC ID only to the vCPU with the
lowest vCPU ID"

as having the consequence that we should always replace an existing entry
in the map with an incoming lower vCPU ID, but the potential corner cases
in this space make my head hurt :).
I think xAPIC ID is unfortunately writable, so perhaps that is the sort of
scenario you are thinking about?

> point, since xapic_id_mismatch will be set if "xapic_id != (u8)vcpu->vcpu_id",
> i.e. if the incoming vCPU has a smaller vCPU ID and a true xAPIC ID collision
> (not due to truncation).  But to match kvm_apic_match_physical_addr(), I think
> it would be this?
> 
> 		if (!apic_x2apic_mode(apic) &&
> 		    (!new->phys_map[xapic_id] ||
> 		     (u8)new->phys_map[xapic_id]->vcpu->vcpu_id == vcpu->vcpu_id))
> 

The above works for the case described in the commit, but going one step
further, I think it doesn't behave correctly in this case:

vCPU 531 (0x213) is created first
vCPU 275 (0x113) is created after

the map is not updated and will still point to the lapic of vCPU 531.
Reversing the creation order above leaves the map with vCPU 275.
If my reading of errata.rst is accurate, then vCPU 275 (i.e. the lowest
vCPU ID) should always be selected regardless of creation order.

Thank you,
Alejandro

>>  			new->phys_map[xapic_id] = apic;
>>  	} else {
>>  		/*
>> -- 
>> 2.43.7
>> 
>> 
> 
