Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793393958;
	b=SnFvLbEjRM0xYC/wpyIb7UIbhtnQph6k1mVc0g5rscEmojZmwMe2utAPDDm7tBYSTaxH
	 1pAUzSLwuV/FLTCQKF/CqltbaL8Oc2SoCc/TbxCG5DpSyKdUNhWboeTa+nxVbwlz/3WYY
	 NKDwwDuJP9/uWEF0nP3vz5QQmHXwfvR17Jh72xVt6k6XNXyWb2tpTSwjyDpUKRXRVlYps
	 NgDNCgEcT3Kme3GDb6amT+FRtPrkY5kebxaNvnwj9U+SSYIzzRfcVd7OYVffDHKk9fX1y
	 r8vtv9BFBdRko33Ui+c8LKuoxxy9ypp2Q6/K6aiYkZtGcUYZJaKUR/HH9W9Otif2e5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=zGCTCrGCXyFMY1lFm2yT9cr+R270KT/3CLgEAJkGoR8=;
	b=3hTu0P4k4bs2cJM3KTvy6S5QLyMDEOgsmr9DQzUGc2OzjV9aJSjoYOXGaQcKCV7i6wUZ
	 qwZV+h99kyGRf6RAySsQZIQvkkt6axiA7x3jBcsLDPBk01MRBNKe4D75VYr1EvKCD4yyw
	 lIbAkrxY3fYNajyJ64q0y7QbXPLcGbM0pcDWJ4lDPzffgu41/nSXenGs+q1tne56ATWDg
	 yNJ1HxKrtUD5RDA98129Sz+Rt/kRxUOzdvD2sTZt2dbPo6CWKu2HuZ97zFhryadgSJMBD
	 cybvU0SnJPXdgicQ1xiHhLHOeU+E4B+BVmy0l23NpnS8E+BzQVRF/CGBiW6yIi03mxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=X5DZlGpQ;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=C6iOFIhr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68D606A31C;
	Fri, 30 Oct 2026 20:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD68D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=X5DZlGpQ;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=C6iOFIhr
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UKq7KQ401276;
	Fri, 30 Oct 2026 20:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zGCTCrGCXyFMY1lFm2yT9cr+R270KT/3CLgEAJkGoR8=; b=
	X5DZlGpQ7rlNfbFZfFsRmF4bsi0vlditGv81m3VAhd/m8Y3NpSPMVab6TZK6Jp+h
	dUwW+a1AbbAb15Ear4daNMX+zN5ATSrEdy6GIm7oJH/sMDBPAKJKdhPlQsKaCSeZ
	POaRzSm8Azj11Tl4G+gJwCCv0frIcNjPXKuF9xvPqyFn48jzpjsvh+6mSbz+ENsR
	vzip0X3ZtMQJEvDDyZgB45iuzX67ugbMDcCK5yNr0e+45lTBJ08cDRTWn26spXMM
	MNyovQ2Z8RATAjnlvjZDlafKURfgvvpAzn4+IDMxgQOYYGxuTuTBmKiWo0YO7MzZ
	drUxCAYEanWUT1BKBFoK3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme61sfnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 20:59:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69UKJCFU2809305;
	Fri, 30 Oct 2026 20:59:05 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hn25wrudk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 20:59:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPkoQeyGrJ/3GAw0Y8RteO1jag1zFFEmpGvjhB4iCgjGelzGptBOFgzzAUjEvG1qAg1H9DmmY/ZXIRJJ3TUXm2qFbOojy9WPOqtFlf6p5wJ9Cs/9HXsa6WEWL4qWBZghM3AmER3QKe9fnISwkEujcpz8t0H1pqGW+m9r97nlsukMse/cq6uT9bmr2vpegJXGnQkNk/Jx2UA3FgPj7DLIHz06DZZSdaAYP01/jpNr1Q0U+pB4yH6ZydE0Si+3/d4mHlNuDxSlvkOH5SD3qaECf0asJsLIiJ7f68hOf/OqR74AWDb62hC0fI5e+O1QJIWURrVl3yy9dfePf48w/NhPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGCTCrGCXyFMY1lFm2yT9cr+R270KT/3CLgEAJkGoR8=;
 b=vNBKRYQkkxl4MY10dPC1nyUZquQHufi7FFESx1NpfDRNqYFqZ+/lKAywpD9Uj24D5gvGmgTaLRgjkzeeLUWobKDMlTs2Vn1/Y0t/8tB4LyeD4OU5q4P486JF/a8G6bkqw46WNGXkoeV8TOsukawI00mVv2r/WIvq8yRa8UFO5UZAGsgLkkXTkE0cuHRWVqwl5oMU/9CwaN53AsTct/qKb9k1C3zffG/dwsgu5/nD1JzYErdDWav0OKRU5bFLL27juNI3fD39YkSFHA6zSC4J60DV2ev9RWvArRY6mFlBJvjR/tLYdlBcQJ0Hm+9S7iPZruxLBQawj/Gq9mMoMzAJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGCTCrGCXyFMY1lFm2yT9cr+R270KT/3CLgEAJkGoR8=;
 b=C6iOFIhrMXcb202j0UPWO/Vf25ROwauXdVnPMF2lV9zHieGz8wSGkwzf7uYI180HVYR/oFspCG4xLfgegVoXbANxr/bfAUU5bAtHfVD9SOfHvywf/oXvLyeE3xbeLCEHWwCqNSSlY0dlkGNBL2Oxe9N9BcTzRpsmWgHE76nyAXQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by PH0PR10MB5596.namprd10.prod.outlook.com with HTTP via P2P; Fri, 30 Oct
 2026 20:58:59 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 20:58:59 +0000
Message-ID: <228b7786-95a3-4bed-9564-0bfed5dc6fdd@oracle.com>
Date: Fri, 30 Oct 2026 16:58:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86: Select lowest vCPU ID for aliased xAPIC IDs
To: Sean Christopherson <seanjc@google.com>
Cc: Partha Sarathi Satapathy <partha.satapathy@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, wim.ten.have@oracle.com
References: <20261027051808.243000-1-partha.satapathy@oracle.com>
 <auDF9WpqW8OCu_8w@google.com>
 <85b0e3aa-0b84-4a00-852a-821aed4a0649@oracle.com>
 <auEI0B7QkIhg-lLG@google.com>
 <62e09b20-b839-448c-90ad-0c63233b523e@oracle.com>
 <auT6S-I5b5ordXy9@google.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <auT6S-I5b5ordXy9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:510:4::27) To BLAPR10MB5041.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|PH0PR10MB5596:EE_
X-MS-PublicTrafficType: Email
client-request-id: 82f0c347-66d3-4c12-b26a-9509403f1fae
request-id: 44c22c4b-0adf-441a-d7dd-08df36c89e4b
X-MS-Office365-Filtering-Correlation-Id: 44c22c4b-0adf-441a-d7dd-08df36c89e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|4143699003|261026121527099003|261028144727099003|10067099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	UgnqbnyXYLrv6cK3v92d1KkV5urYwDABDMkeM+EvnmosFUyCoNpq84fQHSPer3S4lNAo6iywNyd7ASiNAuj0PX73QZ7NON7gHPWM7r8sONlfRy2LhtydE3jqJV8sxlD8jKkeCkf9A1xqVRI+jWeT+k+g3Ac8PAD0mEBnJqoAF/tPKZpPB6gS7c0dxUdn7pWnPOXT9ASjD11rRYFutnJwjguYULzvnoLTgQ3AuLspBt5Ir20r3cGFtsYcy4kniOeoEKnuMLA4SOcw82dyzWFQikjL+vMGHjaKgJ+E/fMNbJz/ULC6YPCHSL616bznntTWMyP3s1c8B+WI2bW2dkRfk6AkPiUIdVQl3vPsZfqczBxLyqA+OBr4R9jp9tI4W1iTrL0b+rfKvEQczcxW3pckbRrelOqHrIefQzRUiqcPAz6Q1+00NjkgVeusHQE3WOwKgoBKjzooE96qAsfvr6Ukv6NPHhar3BLczEZJvhdobXQpjn8mpgKyogW2+2de3rci+gKTpC1nPue06XbEVPAR+i+j2GtxdIG8wbARuVAD6ic5YzQqmp04YpOSzp+LbISxwpQS9fJ0rkxG0qXEOpARAUoYjhSFyLBeskn3ttivp2n0s/RdAc9uzf4EWT7BDlhuX4hd143oX8wa4GoisjovLGr/gkq71jrRUSoi8gW8W+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(261026121527099003)(261028144727099003)(10067099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXI5My9HWG54ajRtVkRERk5mMHdIQjlvb3liM09hUWtJTmV0VHpnME1LcFdR?=
 =?utf-8?B?Tm9BY3VmbUlrWS9tSFp0NklINFk3MmNNeVNZZ2RsM0M5amFURXdxemhUZk5J?=
 =?utf-8?B?K2owV0dVakUwbUZZNGVEem94Q2ZUbCtZVEVtTTVYUVBETjZaZElGUmtqQVJ2?=
 =?utf-8?B?VHhHeDFoWHBBYXhPRWtRcnM4RjNwZnU5dm5tcitzaUlWdVNBektjSlNJVWxq?=
 =?utf-8?B?UDE4MXY5aCtORGYwSjhhZkEyQlF1UHZrTmpsRXVnWjhhR0s0c0dTelRxeCtU?=
 =?utf-8?B?UEhYVzNIQW5KdjUrV25ybytyUGdKWnJvMU5vRXBHKzJRSisxMnVXQTRydHps?=
 =?utf-8?B?MngrU1FqRzBQMHc1MlcybVJMREdGNXRpMThSV3p3L2kwQXJlMU5xM0xkbExl?=
 =?utf-8?B?WXlrQW5ac0tIS1pOWUpJR1UwOGdMZ1NGSkJ6WWZ4bnFxSW1sQ05LZGFlakRo?=
 =?utf-8?B?d2VZMGd0ck12eFBRUlNIOWprWmttVGZvZkt0VDJJbXdrb3R2dDdsS1dQU2Nw?=
 =?utf-8?B?T0hQV0VPTVZlYy8xcjA0dkFKb1IrdTg1TzJHR204OXo0UG1ybElyM0M5S3Yw?=
 =?utf-8?B?a2VTOUlGUkxkb1BFL0Y4QU9FY0VHQWtTNldJSkpDTTY4dVNOamo2c2VldGR6?=
 =?utf-8?B?UWtDakZ1QnkrNUk5dTBCSHlaNXNQYitoZG1NdnRMYnEyNStEQVlVL3hjZ240?=
 =?utf-8?B?Q001dnhmYThrLzBsZnVYQW1IbndHYk9oQWpFMjNyY0Y5Mkk0dy9lMWR2VEZC?=
 =?utf-8?B?eC9pTmQ2aklNaVVOS2VkM0pvVGFibHFVUUx3Y1dnZXVLTEMwanpENVpPbXZ1?=
 =?utf-8?B?RDdhSUJmaWdaa2pLTzJyNzd1UzJLVjhyaDhaNm5XZjg1ODBYN3BlSkN5c2hm?=
 =?utf-8?B?ODc0d2t6MkVPQS9WSzMvdTRncHFvVDFyeTlyMFdGRndjcjFkVFRWcEIwd0FW?=
 =?utf-8?B?bU9Zd3ZnbTZwc05zVFhGdDVXYlR1Mit4cVlRTFFmeEtQUzdFSEpnMFRQVmY2?=
 =?utf-8?B?TGF4ZG41MWxLNU03MGtZdERHRUttb09mVG5JaWpxYkxYUmxwMUJNb2d0bEhM?=
 =?utf-8?B?UVI4Tm9POHlsa1RKQkJZOEFMcDFQc1E5ZkVsZVVDQ0szMVEza09yMHVsaEhK?=
 =?utf-8?B?WU9jVnY4Mnl5ZFRjZDQ2V0dJZGRCbzFINE9PeWQ1T1cwREpmdEh6czg4TEVK?=
 =?utf-8?B?Q2ljaCtXclBwbmFhdlh4NUIrbFRJSVNZaEVPUVZQNHRuYjhFRG1vWDYxRmJC?=
 =?utf-8?B?ek8yZGVxVG9yMGpPUmR3RUc2RGh3bTdBcWRZcytva2UyNGlJQkVGOVdTREVR?=
 =?utf-8?B?bHlVNU16UDB0SFRLRWRPeXIxbFUySlhQb09QSnVUbnZLYTJIZk1CMERSVGdD?=
 =?utf-8?B?WDhrSk5CWk9QbTdCRFZYR1ZNanB2VDBnZDQ3WVM2QXpGWXF2TENnYVlaQnJC?=
 =?utf-8?B?QytnekRrclRHQXp3Q3doUE1ZM1BBejlIYlJsOVp5Q1V2R0lDZ1pqRFphNkcw?=
 =?utf-8?B?elRFR2lyZHdLbXlldkUySE9IeTViZng0SytyUENQL2RSRW5VRDlvNDVtaGpp?=
 =?utf-8?B?SFk3OXUxSjFDcStUazExQ3NtdXV6Q2JmbGZQekhST0NpRFBzZnYwa1hWNm5o?=
 =?utf-8?B?U3dKbm5aQVhlTWJ2ZU1kQWJoNWdrLzMyLzhTcDFBb04xYllCd1k1ZFlIYUk3?=
 =?utf-8?B?M0JJc0ZXWGp4Mk5NQ0ZhYUNkdWVSZjFmZjZtSGcrVmtZbFRrM00rZnl4WS9U?=
 =?utf-8?B?QU5KV1RSdTVUWGhCSUhldDE4dFZtekxGaTY4eEtqS2ZZc2RwOUNWWnc4VitP?=
 =?utf-8?B?N1hEQnVKdUY3ay9LKy9aY1lWbjRzcXZQbUFXVERvZjkrTnliUXBKVFhIOGU5?=
 =?utf-8?B?bDA0Ty9TZmQyTUhnU3RWa2JncEJJaW0xT0xvQjNaRmFwWWd4cGI0ck53UG5y?=
 =?utf-8?B?anQzWTVLV2JBSDJvaWZoSXFkMi9kN1p2eVd6bFJqSUdXbXdlZFlaby9oamNl?=
 =?utf-8?B?QlV5ZUttNFFkdU9kOEg5TlcxTEJybjZZT05jYitReGgycDJEZEdPSlAvZkpR?=
 =?utf-8?B?bCsxdUJKMkF3VjJRY3dKRW4rcUc5anh6eHhOUHlZU1NNUHBUNk1BemFOTi9K?=
 =?utf-8?B?NWJ4aHc0UzFjbEdJTExxdnd5YnJTQVVyRU93bWtGQm12MEV0YXdtN2lOOXMy?=
 =?utf-8?B?Y3VzS0Z6aHp2enB0Zm8vb1RUQVBTYXJ2dWhWNmZXQXJwQ2lSTDJYMnc3dFVq?=
 =?utf-8?B?TUphWFNTaExUSHp4a1o5N0lEOHBNQm9lRTJ2MFB4T1NMTjVnL2tDSEQ1bjhi?=
 =?utf-8?B?RXBKeUtlZDZWQTM2Mkw0ckRvWUIvMnFCY3lKc04veTNIWkZCYkNNcTZ1Z2hB?=
 =?utf-8?Q?o2KSuxLHjxV9m6oo=3D?=
X-Exchange-RoutingPolicyChecked:
	YYaF0wH9m/unngZ6skMmLzAuMOPzd/Mn09cjLrq5bT/D6J6zGBR+3JcEgtYJ/YCZ9WK5V6pVRl/8Tg6TId3mc814Diu/2sRJMRLjxggle6al4TDMrEvH6/38jmL3TxmdKPjOXVnFJYzOz9qlC24vQGgk/p535yBlHwTslFaZMgdWartKD5jo9qzmierw7nDqk9hO9qUBg3xXP/x1xoAAZ9mfiZjcjywLxBJdkHWMNtzIyoKus6QvMP5LfhoFRnC2J0iZBTc6s/kwiU2f+c2dfzM+SS7eujcvWNIrzyx5sh9Pk0gC/JjVgC7Jt5Vil43AH2uyeFeNJnVsAQqgmAhzgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yzgFimqixdd2B0aMTiEifAFZZsf1bCRLB1CbnHDOEUNvSk4eUwAtGUJMUk4tJP+B0t8HPXonBjxyLA1/mWGBjrAfI3vXlEyKpII2TIR8VcD1Y1lInfeNPyf4cDFR+xslPsmEcuc/drD0ioAU7vX+gWXHpZSZpw/bLpHkq6cgcuJl4M/edz5GT9jU59tb9wmkt8r812tR4zBzgxc9tEJwyJXKkMUDVWhRk/GHJ2nfvX4sHY0CYAQY4DuvVVJaEXgNpPnHAdGGWo1n6Vr7621bHbbj9EI1cnXfrauZIKj45jx9ePM+3OvAx4uDTS9Iej4IOxgkMCzxIptNOGNATtzjEBS1s+tEAu5DJPxUNYyBru+hYrWygAb3t2snoWUcbamh65xznB0Xivyb0p0+s1JloNZQbphnnHgv/mcnZCTe6GAFDTBdmtfdIHSlMFbt52JTNXrpvCfmODWz6DT4f+yrj8G3XTOlabDHYTraRigtND+Y92YC8Sj8t+dpqz2RSvSo9b6qEePLUUAJ/kEaT/6dCMBy6C8hN8CXxRDB3rRK+RiBBfoixkmjCu3LdMBdBpiZrdXqL0MgC3m5aOVnkjrntEtzEfId92kpvhJS1dFsn78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c22c4b-0adf-441a-d7dd-08df36c89e4b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:58:59.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ0myTVe60zOdJtK9xpI+7AoQTbsbtJJnQnQTo4Szn3S9SorUuOvx8+ctrm/gLJecyKl2WLPnpok5Vbc2fDrU7t/RxFU0CnuJ9gsKjTU0H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 spamscore=100
 lowpriorityscore=99 adultscore=0 mlxlogscore=-999 phishscore=0 malwarescore=0
 bulkscore=99 mlxscore=100 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610300083
X-Authority-Analysis: v=2.4 cv=L9qI0OT8 c=1 sm=1 tr=0 ts=6ae5051a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=qNFRBJHGmrZRSPS9MlkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: xwjhKNJhRRjAmP42Y7XhCmX3Cd6QfKud
X-Proofpoint-ORIG-GUID: xwjhKNJhRRjAmP42Y7XhCmX3Cd6QfKud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX/uneHRTr0qRw
 QKC9nYh/BPC0PhbzzJ4WaPPimdkDPWARrdj3AfbSS2o04joMLgO4YztMuI2GiOwl6doVKnuprTP
 NCOpgbt+G4KH7jqt/M8aXbI2SMxNokFHhAIkgCt1XqH2D7edJ07TrIZf8+yL0klGDps1py3hyXP
 8diug1cVmcUARMzEl3zDaN3N+DloGI2FXPiJ5X3P3Ski4QEJ0CQLqSIbo15Teup/5ZvM0KN7v2G
 K3SEebJds2tEPPUbadslfS0M5xFX3YDkTM0wE9MNFaXkM+4mYVzS9Y87VjWb/uc+pV61pPbFM/3
 M59sZ5hCjSuMAEOZDerSZahN/fLvkgeNShbIHP0tYnIEHXfL/A/SphGfaEPKN9pHPKf7Z7jBpD6
 /dRtvJwRPxYJ9kHTn0rIg+ulpfeqAzpIoEtR135vi4cIvuZHK+/8RwCP0jZ7Hca3MbkYoPK8lq+
 EOG9krNuGDFHurISQzjwasOYTQaeaE1UlcDLZtUw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfXw/ZcEx5Hrehc
 wYoX5z9a/EFrfw8WPBwkN9EOgtOaSc0HGz2mKv1m90HndJkaL18JsyFt5yHM1/l4KQ8nPaoc5da
 CAZKtexUJns/rqSj3tQuCE/m4c1L2zBxDNjo6a8TNdjRXs1Yu99M



On 10/30/26 4:12 PM, Sean Christopherson wrote:
> On Wed, Oct 28, 2026, Alejandro Jimenez wrote: > On 10/27/26 4: 25 PM, Sean
> Christopherson wrote: > > On Tue, Oct 27, 2026, Alejandro Jimenez wrote: >
> On 10/27/26 11: 40 AM, > >> The issue was triggered with QEMU and a tool
> 
> On Wed, Oct 28, 2026, Alejandro Jimenez wrote:
>> On 10/27/26 4:25 PM, Sean Christopherson wrote:
>> > On Tue, Oct 27, 2026, Alejandro Jimenez wrote: > On 10/27/26 11: 40 AM,

[...]

> 
>> In short, I think the original proposal of allowing a replacement of a
>> phys_map[xapic_id] entry only with a new "low" entry (i.e. one with vcpu_id
>> == x2apic_id == xapic_id) fixes the creation order issue while preserving
>> the existing behavior for the typical cases.
> 
> Agreed, though I think we tie the overide to "xapic_id <= 0xff" instead of letting
> the "lower" vCPU win.  I.e. to make it a bit more obvious that the goal is to keep
> the non-truncated xAPIC ID reachable.
> 
> Ha!  Yeah, looking at 5bd5db385b3e ("KVM: x86: allow hotplug of VCPU with APIC ID
> over 0xff"), it had:
> 
>                 /*
>                  * ... xAPIC ID of VCPUs with APIC ID > 0xff will wrap-around,
>                  * prevent them from masking VCPUs with APIC ID <= 0xff.
>                  */
>                 if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
>                         new->phys_map[xapic_id] = apic;
> 
> so the goal really was to prevent an truncated x2APIC ID from clobbering a "pure"
> xAPIC ID.
> 
> Actually, even better: what if we only let the vCPU whose ID exactly matches the
> aliased xAPIC ID win?  Unless I've gone into the weeds yet again, that's what we
> (and more importantly, userspace and guest firmware) really want.  It shouldn't
> matter in practice, but it lets KVM provide a stronger, and hopefully easier to
> understand, guarantee in the errata.
> 

Sounds good to me.
To confirm: we don't have to worry about resolving aliasing conflicts
between high ID (i.e. >0xff) vCPUs, since they can be addressed by their
full x2APIC IDs even in xapic mode (all hail KVM hotplug hack!), and the
map entry for their aliased xAPIC ID is not required to be updated to
always select the lowest vCPU ID.

But a vCPU with an ID that matches its xAPIC ID will always be allowed to
update its entry on the map, and the proposed code self-documents that.

Let me adjust the selftest, and I'll send v2 with the updates below.

Thank you,
Alejandro

> E.g.
> 
> diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
> index a9cf0e004651..09c6e6a29ae2 100644
> --- a/Documentation/virt/kvm/x86/errata.rst
> +++ b/Documentation/virt/kvm/x86/errata.rst
> @@ -63,10 +63,11 @@ When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activates a hack/quirk that
>  allows sending events to a single vCPU using its x2APIC ID even if the target
>  vCPU has legacy xAPIC enabled, e.g. to bring up hotplugged vCPUs via INIT-SIPI
>  on VMs with > 255 vCPUs.  A side effect of the quirk is that, if multiple vCPUs
> -have the same physical APIC ID, KVM will deliver events targeting that APIC ID
> -only to the vCPU with the lowest vCPU ID.  If KVM_X2APIC_API_USE_32BIT_IDS is
> -not enabled, KVM follows x86 architecture when processing interrupts (all vCPUs
> -matching the target APIC ID receive the interrupt).
> +have the same physical legacy xAPIC ID, KVM may deliver events targeting that
> +xAPIC ID only to the vCPU whose vCPU ID matches the aliased x2APIC ID.  If
> +KVM_X2APIC_API_USE_32BIT_IDS is not enabled, KVM follows x86 architecture when
> +processing interrupts (all vCPUs matching the target APIC ID receive the
> +interrupt).
>  
>  MTRRs
>  -----
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index d6e5fbc3c58c..e89c4fef1832 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -297,8 +297,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
>  	 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC IDs.
>  	 * Allow sending events to vCPUs by their x2APIC ID even if the target
>  	 * vCPU is in legacy xAPIC mode, and silently ignore aliased xAPIC IDs
> -	 * (the x2APIC ID is truncated to 8 bits, causing IDs > 0xff to wrap
> -	 * and collide).
> +	 * but make sure the non-truncated xAPIC ID always "wins" (the x2APIC
> +	 * ID is truncated to 8 bits, causing IDs > 0xff to wrap and collide).
>  	 *
>  	 * Honor the architectural (and KVM's non-optimized) behavior if
>  	 * userspace has not enabled 32-bit x2APIC IDs.  Each APIC is supposed
> @@ -312,7 +312,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
>  		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
>  			new->phys_map[x2apic_id] = apic;
>  
> -		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
> +		if (!apic_x2apic_mode(apic) &&
> +		    (!new->phys_map[xapic_id] || vcpu->vcpu_id == xapic_id))
>  			new->phys_map[xapic_id] = apic;
>  	} else {
>  		/*
> 
