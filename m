Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795600299;
	b=xBJTyD2RfBGasK4urqnfoBr1c2B6bM9p32OrKyoIrPKDN0yjInvISxaNiY5v6Qc7j2ry
	 dlVeQZfBcFlfuHPj9LVRPN18BBJC4YJsQzyxY6UobpMzEeH+cKX5TYwOIW6bdcnHLwVhd
	 3TAogFwVyDgY5sIqziKtS8tGJdrru4vjVTebUcs0cRYLaqObaMlzrzkYZCvXX2DMKjxKu
	 al9dlLtVRO7kMhSAuCpodxdqTAutGyHG/UsQqQDwsS+41G6S/U2Jmmq5dKdbrNYV4C865
	 aYcx9j/oaDKKUCd3f/277MA7NzQTK9dAP2eQ1ibBytvteOrRbxmRR+jkXR8YARlRhew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600299;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=XA4NfthZREHVBBK+GMKZ4hNHzkA5dcuh+gHiw5AXPb8=;
	b=Jv7tz2f/701iDaow+Sirj+IcMvwBR4x/B4U9xShnYo3JLc6t/XnkkQtpfLOGBE7HPLvk
	 De3QMV84Rz3ThRQz9l9w84wzpJyQ3kfs1Lm6AdaZ/fjfj3V7IKShjE4zFEwITxVHHi3W8
	 AYe56E5jRKRpSDP63OAqY1HgQMuKHRpuh5vDTqoI+mPpD81tYiqtKjbucUph7EmmyvNm7
	 Mx/55eudoSxOKpBY/QoZonC+uMJB2FNm2TjWyCZu1m2/gH3ZQsXFYnd5AAUpg5i5uT45L
	 /XkyILhvIkXFrxelYvqGTIGzVqNZvZ5ce82he98M6AX6Z7kcqtP+U4rNmlFdQpZa+xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=e+zNvAxg;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=m54DFAAS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BC606A321;
	Wed, 25 Nov 2026 09:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54BC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=e+zNvAxg;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=m54DFAAS
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP5uhjU1675504;
	Wed, 25 Nov 2026 09:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2026-11-19; bh=XA4NfthZREHVBBK+GMKZ4hNHzkA5dcuh+gHiw5AXPb8=; b=
	e+zNvAxg0fi2Jfx7RbvZNxuqLDvTSN3HGLKJp15zt4PxvhMUVwnrN6HnD/fTCtCP
	k3Y/RSXlJD2eQc0PPqOLlv4M++eCBOBvyGfz2QYw+esHlABVSJA2hDQBR46MZfDm
	wPbO9lCwVQ+9wuHbEX7TWSmD/5sZ8jw6shTPkUwoRurXmtQ+ekOLrP+ZyyMxinTo
	EfsXJ9dZANTRy5F8ahSXCcnJfrSyUE0T84xOHylS6oadyHN09SXO1tmSByoVhWOW
	hyMY92YJw71cMRExhSAHEGaezp9edWH5PKq1UY/ytLebgjJedtHgpSIO7D44SX7L
	JvXZNJmVXinzkWHrrUhaOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34uq5nhd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 09:51:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mvO52881811;
	Wed, 25 Nov 2026 09:51:16 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j5vv818qh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 09:51:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCMGyEPNsxmxm4+Qg9vRj/X/jyiGCcrM1aUZ+7teRHngSGlqSspAjTeKY+SSBFv8fVLtNbkl818kMCR5bNKyrLiuuGeTAUk94IPLH3g0/pe4469+eCkhlVskP+0o2IRWR/SjftcuQxeFr7t/VF0NRID5T/icBkFr7F/FRghK407zhDkNyJDmuhqi/wY9JjUL/0my4zzHVeN/X4drUI5x3eCN1vD3gxvsRBdK/LucSjd1huv58k7P4Q4qYYfxAcVOo86RgySb0f+Ks//tBHnVHYbQRioKnd/GRhEp5Ql46JHHDji4csMPmW+ee7jRpUMlQ04XTVA/Zr/YP03l7dwjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA4NfthZREHVBBK+GMKZ4hNHzkA5dcuh+gHiw5AXPb8=;
 b=YBXecKzqE5wCnsY7FGSaYGdnoCgYHijHUuWmgw4y60IPOq0RaPLUXeiWrxFSW+vt/4TvHaGLRDFikFasTuMsWKzmbCr99W72LpWAEf/zTdpF7wQKcTqViWiJKgUZt6Wp9ucYPDVYMAI0CT3oNvqaw1vReIZ7muY5olFx79joNpDLKahxBQW6J0x5UQl73mdT1qruBbGbVxJoLQZltK3yH/dN57qAG6EzsOwSbzhAvqavFRVvp9jdC7B3s9hkY/jf9+befn3XPEhFFcoZygUpbFHFeMt7u856LcElTs+zVZR47nQAMIQtU1Pt8J6TT+PA9bEcQ6DF7PcLJc+bpLtl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA4NfthZREHVBBK+GMKZ4hNHzkA5dcuh+gHiw5AXPb8=;
 b=m54DFAASVpZydnwmD7v7CRosrXExYSxKLRf10lLh/GWDJiBuAAwK9f8i3AS6xlRq9B6yKXa6dOkN0pRI5k10NQdyz9BJ47GUhaVspJ9PPgCra+nhckeR/n9G144iB1DDl0fDG4N4LNKryBMn2XT0hP0dcjifkc/aPeuLXwCXuD4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 09:51:12 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 09:51:11 +0000
Message-ID: <26a20220-c8f0-4c4c-8e26-142291336676@oracle.com>
Date: Wed, 25 Nov 2026 01:51:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC
 ISR
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, tglx@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20261112170604.1971438-1-dongli.zhang@oracle.com>
 <awABZ_BucR628XHj@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <awABZ_BucR628XHj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::27) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
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
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b51924-433c-4407-0e4c-08df4ad9a2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|56012099006|261026121527099003|261028144727099003|261022075727099003|4143699003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261026140227099003|261021135927099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SEW4wyW0mTmZ5zu2o2ZcE6lpqMUQC1XAi1s1DnmW8gbEcZ0hn+AqLeBeVcylkf0iXyUJOOcLhEsVj3vH+/V55oOvt0ZSiZjd5DasqYrubagjM35AsPxGC+dLDpJtQDSL2HeUY9tPuebHa6fqUMFyOTzomUgX7LnR3rh/YG+7AcXFCSuJJHiTcefB4EcrNl+k6ESUDYNYqIGQAZJqz8B7iqnm2zlpzWW+qnhjOwEa9Z+xAInqfTjuqleYJawpEfeaN9z1233jsAriZJT/QULlqtmg4YEVaXCAP8Wq1s+dYNXADBV9IARvjpXXdCZTm4BtBtlu0BL4WB14zVDizwWOd4hCqgsB0fKMnm3VMEfxC2f9XZ5W6S7DmAQTISJoVrBsnWfEaJYnWA06Jd2nOo8dQBpK3SdzMJUfaY3EShMTvZM1eStoojKnj9HUkTUORZNicTW98JKMsJjNNcV3zlpjQGBtl4EZpnXd5RoOo21alqBgevUD8roIVBsaHkeGik7uSILTKLCNT/9bcP/a5vlLUA9Ajqae2oWP7VZLbK7zXPYthEREuLLmuhguXydeufR+b+NLrQt146FqXRx5RW0V7YUiHjTDyIpWNDoc0ERAZr5SWKTApcjTw8T9xrRdO7Bm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(261026121527099003)(261028144727099003)(261022075727099003)(4143699003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261021135927099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDhlNTQ1VjhyK1MvUllLaVVKeGJ3cWRUMk1icmVOK0dGVjZTV2RweFViNXJ4?=
 =?utf-8?B?R2FWYk94YlptTllNSXhZUFhKLzFiLy9oUEVyQmNoZ3Y0SVVydG1PZEkwb1BD?=
 =?utf-8?B?SnpWdHkvQVZERHdoYm1GOTB1em9ic3h3N0RydHNCbDQ3aVQ2T3ZBSms3Nit2?=
 =?utf-8?B?Yzc4bmZQU2kwTjB2U1A3R1NUWXZ2Y2p1U1IrMC92R0cvSThhSGpWTTYvaW1Y?=
 =?utf-8?B?UWQwVWtpeWdxQnRuc0JaNEFDNXhPbUgzNG5HWVFhUU5mcHZ4ZHBSMi80N2Vq?=
 =?utf-8?B?MkYyYUJua1dtczBMQUg4cytXVkkyL1lUeWF0d2w4dXZnRTBrbVllQUVDY21w?=
 =?utf-8?B?RHNBSTZRRlBqMlVpQ3JjS2hMRmQ2RWlUMFd1OFA3ZFlsdHF6S2xzcEJZdjZq?=
 =?utf-8?B?enRnQmU1RTdKbXNsaXc0L1U2cXZsU0s2eXB6UlhGQnZzZ2pBZ3A2SVFhdXV1?=
 =?utf-8?B?MDRBS3c5d3hHV3l0UWNqRU5lckJocnB5ckFhMTJRbkJlN0dyRkFYcmFoYU1L?=
 =?utf-8?B?bXcraHJYNjlaWTlEQWx6RmNsMkZnKysycUIvNDFTNGsya0pyRWVvaXNnc3dr?=
 =?utf-8?B?TmFHb1I2cDFCeDY1SitiUUxMVDV4ZDRKTFJnM3d4bEh0THdzMDRmaERKZHBj?=
 =?utf-8?B?SElHbHlSS1VxcFVTZHlBQ0xIdXBOU3VkcFVXVXhNTjY5SlFLZHZzUVNUcFFl?=
 =?utf-8?B?NXZoNjVLN2NqQ3ZEclRKaXQzdmdCSDdWTXZuYmhXSWt3SWlRWDQwSkxtUS9a?=
 =?utf-8?B?YzlVVXJ3T2hVakMvd2VBbCtIYVh3REJaTXpDUTBHQXV2RENKMGRRU0t0d0M0?=
 =?utf-8?B?bEFBTzZPcWlnWCtNUnFoVXlXemRrdXBMalh2VXRwc1ErY2NkYmQ0S2QzMXNn?=
 =?utf-8?B?UU04c0xhK3pmSnZBUWZjak1Zci9ENFRlT25vandkSUxCa0l6bnFwTXJZSzU3?=
 =?utf-8?B?Rk5QcjFvMGxQWkI1TmZjS0N4cmVhRjEyR1c5OC85NldiYnBkaGxWTDRlcEpp?=
 =?utf-8?B?MVFXVURRT1Bucm56R0UwbmRZZTR0c2Q3WngvWWQwVWk2NEtXR2xNVnRod2hH?=
 =?utf-8?B?UHlsWDRrcmlhQXZIY21KNUNoa3YxNGhzTlpEMURaVnR3cW94bDQ1ZFZkOEV6?=
 =?utf-8?B?bU83T2M5dFRTdDlqN1FhcWhySDcySG80M1BWLzhvdEwzZzlmRzlaQWxoNS8v?=
 =?utf-8?B?YzhzSWl6b0F3dFJNZTlleGFjN3RSSmJvRE9OVGZQd0liR0NJbGlmaXNNcEVD?=
 =?utf-8?B?ZzV3UEJYK25sV3NGLzNkWk54ZVpoVmN3UVo5OHJUd1BnQ2ptS2ZVTE8vVUR5?=
 =?utf-8?B?RUpmYUxZcTJ0VU9NM2VlRE5Hay9pa1Q3aWdQTlkwemg2V2RVei9HUjlPNFc3?=
 =?utf-8?B?RGJmanp2b2wyWHRQdXJ0TCszWVl5NWhFQWNwNWhCUTNEZitqanJnVyswUzQr?=
 =?utf-8?B?Qnk4Snd4TE1maGlBYWhYV0dNTW1RNnUxa1ppYktqU3phR2YrVHN0UEFqRXgz?=
 =?utf-8?B?WVBJbk1zQjJCTVIwNkV4ZENoKzhqdkNkLzJhM0h1d2FqTEpNaFJlc2E2dk1H?=
 =?utf-8?B?cWVnWnJLdEYraDViUmtONVRsTFRhdmFDR3pZamp1TFUvRTNSY0ZVTUR5emYy?=
 =?utf-8?B?MVhLSkxLeDRONU9Bd2t6MnVCUmJvVDY3eHVIOERWakRQNytGam9WMXlGNUYr?=
 =?utf-8?B?NHYyaFl5anJwSU50REFGKzhycmR4V1JmcjdpRytJbUZhRmIyZ1hpcCtsV3A2?=
 =?utf-8?B?UmZ5NjVRWHNtZEM4V3hHeUhPSVh2Y3REV0h6TGNIOGlMN0VLMThPR0lsQkVY?=
 =?utf-8?B?SzUxVWJITVluSU5kY3duYlhab0pVaUhBTk5hSktzQ0oxOHZFbFk2UTErZ1ZL?=
 =?utf-8?B?SUdzVUNia0xuV3ZzbjJ5L0VxcEN4aTBvZ1ZqeldtZ1lhcmFvUTVaMHdrTEpF?=
 =?utf-8?B?ZitLb3Y3WjZEVTRVM0dvNUljblJMT1QvVWdEWE5MdytjOUlHSXdXRUZacllM?=
 =?utf-8?B?aVpHOS9Lai9XdWJqSXJndmNuSHpOY0sweVdELzVmWUdDNTlZOXlyTXF1VFlz?=
 =?utf-8?B?ZlBMN1JDdUh0VGZlT3EzTWxmOVArQ29qZmNRREJMU2hPQk9RMERWZGtjRWVN?=
 =?utf-8?B?L2hYZGhLM3gzZ254Y2lDNjBqd0tjNVRPWU9SR1dtSS9uekc5Yk9Md0hBRm9Z?=
 =?utf-8?B?OXR4d254a1QyRGFZd294bVh5V096VmNadW9ZWnBRY3I4dExZU0l3a1Z1MzJ1?=
 =?utf-8?B?QlRqTVY2Uy9mdlFSNG0yQUk0dmVlckVleHorWWNQN0JOc09XWVVQZmUrc1hK?=
 =?utf-8?B?S2lwUFBzK0pmcTdZbnNxalBoRHZ0YmhaaU1teUhYc043MU1lRDg1UT09?=
X-Exchange-RoutingPolicyChecked:
	Vnh5s/yQut7unPtpz6oMHbJ5iGai1ginMOXWr3jWMsO1D320O95J3NNo9URn25SXNyxG6pxCILjXPNfRoQmZ1LKkJnyfv38k0RDeV9Ug94zptfIkk1QLPNww8LRTuaQ3635DPHu0db0r+BEHThRIe+WJdBwkVcfi7qz1eOtI+hjB3v1jRS0XW/Dw6S/DBqcTICYFAOrI57fo/webCmgAzhtFZK8mdZrU1Vjccs1N/VAFyW1kVWC6GvBfRzkJL61ZJTX0XR8ouJK77Ctq7AoJvoikZ68vKH5ufMYGPO4LqBKwb/SAaJCoqF4b0g7z6FhH1R1j0qAt+iK7G8kQb7+MPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0eqwcQ0uOE5m+bcTPBLAkQvmrJ8TAKgbZ7zCGXDSFCaOBkm9rQ9diRypN5T/mc7atyMynR1HB08HbT1t/JkkPWE/wYKzGMPdCJgnDOdgRoGLzMlhjihvLv2jmq0FyoxwtSzyn0LqSt6LKq72FPgHBwha5rbCn+QIG/6jmsvEVlpV4s1MFq5zQ1psRGHWKyemsZfesZyyP/qzUC/XUZ/qqqq/s2ME4eVUWmG5pC/d0mUNqjplvy2qjICLLRCuQc++D/ZeF1lnUmKffrtI0RyKjWDn7AaiW9GhRmmrE3CXMXmQOGj8gagfWY2iemZjhSvHLO5T0dJGvn1HhDHmQ7oyL05aXShf+stRR2AQIVwc4w74/AgDaPItv90q3M2785ZrQh7KOiQ1cdgBkSDVnTYbiMMkShmbiyRA/lsy/AkmoK+l8Xy6SfGTnNHQ4LJdPt/FTMts3nnM8sOowNs0up/sx+rxpuz3YpZZSM4Zswk2nnuTBEUA0wc/Q08NLie1sbQpvTN8vrs/kFf5xCXHQzL58vp+HQK2AmjxVFb+KuoHrmoSc2Nl+my9BNawf246ED1FUEIDIsi3d4RE8cah4SgUYaJlXkVDk5RMndF6qXjvAxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b51924-433c-4407-0e4c-08df4ad9a2f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:51:11.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UIFWsyoNFcUW71pKMVjofJHcu5iggkYIZsu1Nuqxe3E56Y3ktQ/BGx9NzYIneYdI7rqg4q+gHCl50Toi+m1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOSBTYWx0ZWRfX6sHxPODyP2oR
 e+fHl6yrDADtB9ghIOPTd4Z5qcxpczgxQ3BTpV26n4fMTKPK4ovRsakqu0YE/bFLH1oUsomnIv7
 nlzxd/ZAgKyv4aBroK49+kZz3aIx01E51HLMW5OgC26k22pdJlShYsHPxcGW9+3B9KaZ99Jbv3o
 ep8dNhy8IZ6eNfXdeBINpGO/isDBDBdSo+K1gFi9DjJDxhKm2W93yCdRlNVkRewJm+410BolBBQ
 TBsNvBkyPoj3L10vNfozUF4H8H6lznSDRAdTZpN2cPRQElQZ9OF83ByL0gffAlyFDgL1D3wg15I
 MTDeIDxtVGB2oqJ7L5p3dgdI/1pqfJ/yPMQASZLs2RRa8kMSqpWsgIBZ/FysrFnPWraTHdO3+Fq
 cHCzEKUy+c/5GJ0mWp7oRFMo9Q/4BU9vRD90gOpWOteggS1hq3ioigZe8ZuMqybaGlCQjag4l2d
 ECr8B4xZ48kBWS6cNMV0841yov6mp4hI49iVXdU8=
X-Authority-Analysis: v=2.4 cv=ZoZ4uN7G c=1 sm=1 tr=0 ts=6b06af95 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=5tYaC8oAWBVZ8aMRyFoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: Nn4swWSmd0Tvdr64Ejm4CidHl38hZSeh
X-Proofpoint-ORIG-GUID: Nn4swWSmd0Tvdr64Ejm4CidHl38hZSeh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOSBTYWx0ZWRfX9DWSCbsasp35
 nxT6LUsnTAmcW/PSrQPt/KR2xEHZBn5y/i0NjP/TfxDbSmDy1mN8j6SVp72DSrM+xnVEo9aQ5wk
 ImXa/ypatw0yqrSHeX2GBPx20QExQjYcSkoRB+Uz4tRx5tbg3qgx

Hi Chao,

On Fri, Nov 20, 2026 12:14:31AM -0800, Chao Gao wrote:
> On Thu, Nov 12, 2026 at 05: 06: 04PM +0000, Dongli Zhang wrote: >This is to fix
> a LAPIC ISR stall that can happen in a kdump kernel, but can >also happen in
> other scenarios. > >The issue can be intermittently reproduced in a QEMU/KVM
> 
> On Thu, Nov 12, 2026 at 05:06:04PM +0000, Dongli Zhang wrote:
>>This is to fix a LAPIC ISR stall that can happen in a kdump kernel, but can
>>also happen in other scenarios.
>>
>>The issue can be intermittently reproduced in a QEMU/KVM guest when there
>>are large number of VMs on the same host.
> 
> Does your production kernel include commit 1b558e14f3c1 ("x86/apic: Make the
> ISR clearing sane")? If so, can you reproduce this issue with it
> reverted? It looks to me that the one-pass ISR clearing doesn't clear all
> stale ISR/IRR bits.
> 
> The changelog of that commit says
> 
>   2) If interrupts are enabled, then the APIC propagates the IRR bit to the
>      ISR and raises the interrupt in the CPU, which means that code _cannot_
>      observe the ISR bit for any of those IRR bits.
> 
> Your analysis shows a case where this doesn't hold, since the 8259A
> handler doesn't EOI the local APIC and the ISR bit stays set.
> 
> You can certainly still reproduce it by injecting an interrupt manually
> after the ISR clearing. But I think the multi-pass scan may be enough for
> any practical case.

This commit came to my mind at first because I thought it was a bugfix.

When we ran into the issue, the guest VM kernel didn't have commit 1b558e14f3c1
("x86/apic: Make the ISR clearing sane").

The issue was hard to reproduce at first. I added printk calls in many places in
the guest kernel to narrow down when it occurred. At many points in
setup_local_APIC(), there were no pending IRR or ISR bits.

Based on my analysis, the issue happens if the virtio-net interrupt is delivered
before legacy interrupt handling is handed over from the 8259A to the IOAPIC.
Unfortunately, apic_clear_isr() is called before setup_IO_APIC().

https://lore.kernel.org/all/e4070a8b-fa4d-4ba1-a333-e7cf72da416e@oracle.com/

apic_bsp_setup()
-> setup_local_APIC()
   -> apic_clear_isr() ---> clear pending irr/isr
-> ----> virtio-net interrupt delivered ...
-> setup_IO_APIC()

Thank you very much!

Dongli Zhang

> 
>>
>>Device interrupts can use the PIC, IOAPIC, or MSI-X. Nowadays, most x86
>>device interrupts use MSI-X or the IOAPIC. However, the PIC handler does
>>not send a LAPIC EOI, even when the interrupt it handles has set a bit in
>>the LAPIC ISR.
>>
>>For example, suppose there is a QEMU/KVM guest using virtio-net.
>>
>>1. virtio-net is about to deliver vector 52 to CPU 2 (APIC ID 2), but the
>>guest suddenly panics on that CPU.
>>
>>2. The kdump kernel boots on APIC ID 2, which becomes CPU 0 in the new
>>kernel.
>>
>>3. Suppose delivery of the interrupt is delayed, so vector 52 has not
>>reached the CPU yet.
>>
>>4. On the new CPU 0, init_ISA_irqs() initially sets up the legacy IRQs to
>>use the PIC. Vector 52 maps to IRQ4, which is normally used by the serial
>>console.
>>
>>5. Before these legacy IRQs are handed over to the IOAPIC, suppose the
>>delayed vector 52 arrives through the LAPIC and sets its ISR bit.
>>
>>6. The new kernel handles it as PIC IRQ4. Since mask_and_ack_8259A()
>>does not send a LAPIC EOI, the ISR bit for vector 52 remains set.
> 
