Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC1F419A;
	Tue, 12 May 2026 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545316; cv=fail; b=rOrW1MKPKh/7VfdppWQIrOSYBzsVJI/VEWC0P1+T1YVuMne7CGRNi1sACNpzUwY98JdCGXOB7dj6obJwmw4f9FXFbr+7gQGM4YgD8j5gJo3WfvH0xmMRh5lClCFGbXmEAqcUQ7Xjp4lKcQnNOSsL3eGc4IC6VSB4JSSEEzpK2vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545316; c=relaxed/simple;
	bh=cjA4+LVYnqTwQNJb+d33YU3JdwGZ71Ee5haUR9l/ux0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sLHDJNHg4SF6ReqN5Nl4MYMmaSaMoogrqIegebvzh6f2fDGj7gSjcuJgJxY+kti2/MOLWLVw65HZwzIxN6jFShNvl1mEpC/YQgulCcFe5lEnbCAt+2P+c7Fx6hY/6rbZwV0va0R+HYVHVGw+XjwdxyzvhAQm1C1r8ZbyHwp3lt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X0Ah0sLB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pqZBmbOk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X0Ah0sLB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pqZBmbOk"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7uwx2002177;
	Tue, 12 May 2026 00:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9uI0XvivTetWzBA2CAPY0whwAWg9qlGpX2ZXF+Lg6/g=; b=
	X0Ah0sLB1xMChcAIRqvamv4NAvA0j3/rapcbWO8TW1zL8FUlpxJtSXfgTIVPdydf
	CL50r4RfzYCePh3eqgSB5c6lSSmX42GhsqUFTnMSCGDTx3E9tE1VMleiNmCWl9+Z
	0npVkJz0S6XIHOycSv1YhUSyyX4J+0fX2+EUeJ1PrBoOdCWww5xQKpxYTTUdr09C
	7qck976d0lTk7AiPuOoOoZzyScztAakTtworrtuIJf4CI9n2Vli4P3Sbv/RtV4Gy
	aRiRtchZ34xIL3Xofvca/QRSZswPJNplkIKPDEBP4hi3X/Js0ExlXJ3PSJdRsVZa
	rAim8ltLg1wn4jijuTE/xw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv8892b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 00:21:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64C0GD2Q012052;
	Tue, 12 May 2026 00:21:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne8rmrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 00:21:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr9dDoVvhVAY94iSJvtfvfE8qeEE2T3o9ezTX1tMh171PO8ZF4lieKDDnGar42J5NvWB/rVxtFSM5cEa3cYpneGP6Ls80VtTm40FIqWwjrNINfvM+/oMbPsQqUM2PStP//TjyXpPD+ZkdDK16DzzOYKzxCqs1GU9HF+yFQuHMI24D/cudmCo4RRkirR4IENQ/JUcyKLMeFWVrRo2vnZAIu7RluqWXB4InSrrQr1Ew9f3N3jNESSUYar6Z9UmyfUPR3L7droOtHlXjX6noniRjR+TFzqebeoBofqQDu5vFLSd6bcaEuLEwUxLYhjVDrfvHZxqOvXxlPzGGEhdfAtfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uI0XvivTetWzBA2CAPY0whwAWg9qlGpX2ZXF+Lg6/g=;
 b=KNZ4JzSmThZ+apFT9BCZ5MwNhpwb5Rmi+1zV777bajqGEtCtVt+Uwdu3QOHnNocZAzvWv+JgmI1Kc3P2jw3YIbrXYCO4L1w68N/10000kVlbXFUKIxiIKFomHvw/hgK5GZQ9rJeLBCL/fpxmU2JPQQa/u3j0KS4Qnh8qkcJjoRCYIoQeP4QJn/P7DJuBZT8pyDcj9chzIfxvMHKyArYNyPa5vWWMR4NbT7arGz4tSS7xs9GHVcW5btj0cP5d1m3nBPzTwS2WBzAzqoU3jVae6lkcn2GKPGIFUfHCdLX0Hg2l+r1PMUxE7z09kll2OlM6k/Fjv8agtcLcobVU8Qul/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uI0XvivTetWzBA2CAPY0whwAWg9qlGpX2ZXF+Lg6/g=;
 b=pqZBmbOkJx7m74/N1mgWBtnZYdsun9Fm5ySNxW02ZtWII6fQypfopd3xEq5hfe28OOMOZ5SVGU+kSSf10OLel4rQvwln9RunNLZt9juOuCDulqLXqZeNs1FcazsJ7uYR2PFuUwrFIicHw/dRA7/Y6XbbUd/OvH42Av9bamav9gM=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by CYXPR10MB7923.namprd10.prod.outlook.com (2603:10b6:930:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:21:15 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:21:15 +0000
Message-ID: <3363ed64-75f9-4a5c-93b9-882d72bfb7f2@oracle.com>
Date: Mon, 11 May 2026 17:21:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: conditionally clear
 KVM_REQ_MASTERCLOCK_UPDATE at the end of KVM_SET_CLOCK
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        joe.jin@oracle.com
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
 <20260115202256.119820-3-dongli.zhang@oracle.com>
 <f37f0ae0ae1dfce3ad3c6fce653f5df34adecc0a.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <f37f0ae0ae1dfce3ad3c6fce653f5df34adecc0a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:32::32) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|CYXPR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e38cb5c-f5ad-4b4b-ef24-08deafbc60d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wwQcZE9HQa31/tAK7AuK3GqLM7sxyQ/L+4rjYSpB/wWw/1UPzpgSC0y6/MMUicMNNl/mYsRWwslAaDAaspVRSrUc2zar1wqMBAFpLfNBXSJrwS4uvs9bt+d/5BZ3pbG7uHhf2iOTH/Iy54L1eACt14pxnzPmLmtsRruLsjcXzNVSsroVXz7jmPOB7ArIhcn1kGalXCMoqfkTV3AUwi5ezpakPdQLVrB2icydqquVcZrwL9kmA/PuUtBMPjbMSGTwRxRVFPXjIFX9yTk+lhnPm2FAt2AgDdwssHirfd7zrdOlSrgsqe4+Wi9t8BehtkLBOQSBIymF0r7o5yX7PlKHByKqn/hOBymG8q4Lt5a89hFqvoqORdeJ03CGcv1IVbmM1YOSWuRzv9VrjAhszZBSr076FB3Isc1NmKbS45WpUH889QfGNa2CQl2R+rQgCuQVNJBQLeonZ2Py40k/A6vey9vxamaCzvuffFB/Gd0JtxpH6xFsR7CALqd/RKQ1I6tY1TYacE9MaP+PwfGG24z1ytvcsNNoNaFKHVQ2JhTsllZyEJGzJ9IPfGep5mCGl+kp+LFFqpxIN2Nm2481lfG4w4hSxxWtUsLQeudBCGo5ZE7nfWl5ictPO5Sc8clyCV/7vEeCL9toJsILGPTq0xpqljpPibjPsg7iqkxAgS6+NqYUyU43HHOUCRlaqnAK9PPB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRMajFMdmQ2T0paZWxnaWJmbUx0ajZ0T3VZVld0L0oyMk0yUDAwN3hNRHFi?=
 =?utf-8?B?bDVhY3V3YUFyY1JRbUs2eWFGNFFIRGRmZkVZWENTL0V2RHBUOG0xOFBLMzd6?=
 =?utf-8?B?THJzRnk5SGVRTGx5ZzNWMExUNnhxTUo3TURNRDVJQ2xiZHN4d2xaK2lXWHM0?=
 =?utf-8?B?ZDYwckw3ZGJBbkl4VkZSZGRlU1ZVakdiQ0IzSUZoRmhHcGFFbjZ1WXRMZGdV?=
 =?utf-8?B?NHJTL1ZVYnBZZHlYSGVhb241SFlBRzg3b05lUXhVMFBxS1d5M2FhTGUrZW4z?=
 =?utf-8?B?d3ErczdXdEdwR2RKUUg4K0krMnJIY09WZFMrZmtIeGt1SEZUM0thOWJNMzZE?=
 =?utf-8?B?Wmo4QWFrajFNL21LQWR5YWxrSE55WTdJcEc5MHU2b0k1dkk5d2JhUS9laTFJ?=
 =?utf-8?B?RG1IK0hSakNDN3IzRm9OaGZSQ3lRb2l6Y0paRFhXL1VGemhqSzc0OVBNUzEr?=
 =?utf-8?B?SjJxVUlEUmQzbTN4RlN6OXNaRC9aWnl3NnpteUJqU0U3ZHVXSm5kVlZCNDlM?=
 =?utf-8?B?V3hJSXN4c2pFVElPSUZKelhleHdLc0QwREpQb2hVQ0NzVkI0Y3B3T3B1ODB1?=
 =?utf-8?B?amdTQTBIVWZ4RFMwbVVHdU1XVTFSRGZ5UGNjbFhlRnV1MGthd2hKNUJUQVBx?=
 =?utf-8?B?QjJuOXNEZ1dldE14MFVpOVRKdHF0Q0VCRTRmNno5YVkrTlpIZkpLY01lVndD?=
 =?utf-8?B?TXhVTzNLTk94NEIyN1l5L0FwTlZodVFSaFlUdWNhNG91UWw5eUM0ZEUvN0dU?=
 =?utf-8?B?UElYMithQWFNNHVPNTBKMjdQQnpMM3h0MDViSXlqK2RXdkpzck9NR2ttWUJ1?=
 =?utf-8?B?cGVUZjZEVnVQTWY2cW5XWVhFVU1EK3NzdnNwbzNBam80aDFTaU5MVGRuQnNy?=
 =?utf-8?B?OXZjRjhWbDBiNmNMMDF1WWpJbWpMVkZlUyt3aVZVQWwrNFpFdzZUTHZoaC9J?=
 =?utf-8?B?bWJBb3c1bU1PclFBVHJGOVRsWCtXazZvQmFLOENoVmJQakxIY21mLzkxSkF0?=
 =?utf-8?B?elZVdENtTFJ2SVBJTS80TXZZMXhCaCtIek5Qa0N1cjhzd29EdytsbXFPcTdD?=
 =?utf-8?B?dmlsaDFKbmhGZTFvZUxEVlIxaFc5VVMyN2JUNGM2bGVXRHVxcXhXUVVOMllG?=
 =?utf-8?B?enFUSnBtY0RLTjhMWGFxTG1oRGZ2eFRiQTdLU2lPcnRaYWxiTHpROFZDc1Qv?=
 =?utf-8?B?a0VGSnBxRWcwZ09DaisvYWpsaDRDOUlLOUVCekFoSlQzSXBKc2xxMlVNRkE1?=
 =?utf-8?B?bkhRajk5YkFqeTNYU0cxNU9EeDRsWUo0VjlHQ2NYYTNXTk5OcWJYWGZ6TE03?=
 =?utf-8?B?VFpwMEwwcDVFNjRjeFdQdm9LNE9zT21VSWc5Wk1IL2d5eFlQNzZuS24zZFRN?=
 =?utf-8?B?eCtLZnd5Z2orckJqUysyZkFTRHBxYWZ1K2Fwckp4Y3BKL013cGJpekt1enJM?=
 =?utf-8?B?ckNEWkNJa0krcHVXdmlzNzJaWFl4TWhqZG1QeGpvYXJ1c0VvS1J6d2U3RXV0?=
 =?utf-8?B?Z1c3d21RZEFjZHBsSEQvRVpPMEpKaFlqR2lhMTNXZFBmeHFhMHU0SUZBRGg5?=
 =?utf-8?B?Z0xpeStCUzZGc2E1S1RPaDduTmhuUzUyZHlXRHZoSUJYTXpKbEFPK1VuV1k1?=
 =?utf-8?B?MmtuS25vRDQ5eDNucDUwcEdsQTVPNWNHUzFsY2JvRk83SlFud2ltbi8yeW94?=
 =?utf-8?B?VUx5Y2xNVms2cENkbjdGazlJamZRZmJLcDBnYmNWN05LUEFIRHhQQWxlM3ZB?=
 =?utf-8?B?THFTbGJoN3RlOTluUFR5SkhOUXpCTHR1a0l2UWJTWnZid0xXSmh1dmttc2FK?=
 =?utf-8?B?dkhudDlTeTZXUHVYRXpRcGUwMy85REtvMUo5OUswT25UV3Zid3o3STJBbnho?=
 =?utf-8?B?VW8yaXNPMTJya0g2eUZBK0Q4T3FaeXlQdHNNYWtJc2piVjlKc1NKMnZqR2tO?=
 =?utf-8?B?RVZZdUloSjNHT05NajN6d1QyeFBqNXY1Vm8rcnQ0cnpQVHFtNGExMlhXKzFD?=
 =?utf-8?B?Q0xtRzY2UTZsWExieGhMSklZaG5XMFErYm4xWmplaTVVcTZiRVV2NnVuQjUv?=
 =?utf-8?B?TTRVM0o0ek1IL0l3MkEzUUhGN0tQeVlxM3Jpai9LUllLWEVrb3R3OWNqdkFO?=
 =?utf-8?B?VFcrZHUwN1dEclA0K251N3AwZ2FZTENFb0JjZUZ4VTh3T0NHcG9TcFBEdUZk?=
 =?utf-8?B?Y1NBcHZnakJqZDBncFo0NmxDdHJHUGNreEFBSFdFclp0emV6OGpwSDg2VU02?=
 =?utf-8?B?YlliWUxxVFM4bnMyT1pmVEdHcW0wczVtTmFEbUh5b3U4YWgwT0k0Z0NuTmd6?=
 =?utf-8?B?TTV4OTdXcUZSdFNPTDRRYzk4Nk9YZjdTdkFxbUE3S0UzTjR6bVl4Zz09?=
X-Exchange-RoutingPolicyChecked:
	HC/7SZuX2aQnesL7JfDT4L7WYCIBTWBbsmL/L8MLoJnkCxS4exOtLVlSDn2SzRg0WmOL9lqz1y6ctKqmBwdUF0C177s/HDraDXuuF6grAE3v7ABncYw3+2jvpSYIjevQGD3JfFWplp+pf5z7Rz5n0f+14mlGmdl4yo2ItMIXvy+pumU9nZ5/wrQhS/A4tzmT6OxkRd+wSrHCekYUXyCr0+uVWAMrJmWBHtwHpoXwH1N+gftM+fGkWT7Pzf6LkDlO34n9qAaGTOYl6IK79oW/9OJjtMCh1iiEQuCrQSE3O5nKqWJBV1oLz6mobnA5QGJQZha0FnXyKF8CFi+7Gks0kw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XDdOE89k5i8APa49xzyhppeWpj/wQe3ngF76cZg6UgKLaciWFe0SpORtKAVdU5in0kfgAo/q0KWEewQVbqsDODAdUtCmk9Q6Nb+lB79ZHMZpc5D3N6gx/AFFBVbi7BBv3oLrf0Cr1IcQA61lrv6tI6KhUfcNQPtjuTPhWADpXEFa5oKxVAfL9iiuH37/cfenG5/sw8Lod1IPAbVHYUMkAnCSTurLxPvKRpWkaQZHIb6AM7+i6FqlqZ7g8sKrk/eec1q45hw5vJnVm0KF6NoCf07zc1PwnUi21kiX0Odz1lDbmGTNHUMIpEAZoKu1MA+DaDfnGOeTqRuma0IGw6sHwNgmIUsSux0NiFHSXsT76HmUqZVtxFH17+6k1UU//9bLJ5BrVNwLXr9apGujBfMKCnqrASRfDY8Voxz9U68J2WB+O3+t8HW8PndOgEE0l2TY9diOVjn3T+4VFXqzVecGcQOGwCNpb71+gqwTawOtmnp/JJGrOrhUkOoSl6/qFsBAXNwrK1+wdA7pia0QRWWHsJQMCpH6kWEjkBG9j5ycRRDxuKE6FbWn2srqBbkKX/3A08eaIsVsR8H/YbSMPXCfHXMCImnmFCrlnkmmom6ZM28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e38cb5c-f5ad-4b4b-ef24-08deafbc60d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:21:15.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrrRWbkLzNtnhu8nAsNUm7ZiUbZGDV6jpl+/4tZC1DAOx6yqzxgrIx0K0umDNM4DT4MPzUzLMeW0EGIr6OXA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120000
X-Proofpoint-ORIG-GUID: hQCFUNS-_cTZmqEZtWRZNxX90Xu0vBSC
X-Authority-Analysis: v=2.4 cv=bYVbluPB c=1 sm=1 tr=0 ts=6a027284 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=pBOR-ozoAAAA:8
 a=yPCof4ZbAAAA:8 a=MRADIi9n7Kqya49Bx_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hQCFUNS-_cTZmqEZtWRZNxX90Xu0vBSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAwMSBTYWx0ZWRfXwZBfRHc/dKFi
 4PDan7zniKXIGpj0ulaESs13R9cHuu3zVmQ5+Oziq9d6UIPrekCUHxGPis7faUmTPus4qWQgYdP
 3cuBjsgNsfsTPLFAx/l4fy5EuLiJ4rBTgtpJerBjfZ3wIZm0oJ/Ep0hhJnNkmxj+mCQtPqPc8zK
 vw6Q5hCr/wy6XGVfz9wM4MPbRLXS7j5LfwaGYUZViU8JeVKc+LhjSmn1qGC/KX4uT/NRS7qYMax
 obiv2/Pnylt8Zhm2QOaUV/QUzBBD2n0bJc428v61U48xbsdLcX4MxUMT/BA42aGdVV/nzD928Ll
 S1COP1ULdZg0o9FvkkyDWWGUK+2+Wyyf8wsEUtRlyMjUqW5sI6sqaqJ9GnGg3oNlb/8JkzvAnWi
 Lkoq2KwYYyK0niZMtxc+whl7zev5ViZScntGy8xaxUiwgsgC35xKOL2zu6NF8fWgoZajmFyp/xq
 uvIEeIB5s5IvyewInxQ==



On 5/9/26 1:04 PM, David Woodhouse wrote:
> On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
>> The KVM_SET_CLOCK command calls pvclock_update_vm_gtod_copy() to update the
>> masterclock data.
>>
>> Many vCPUs may already have KVM_REQ_MASTERCLOCK_UPDATE pending before
>> KVM_SET_CLOCK is invoked. If pvclock_update_vm_gtod_copy() decides to use
>> the masterclock, there is no need to update the masterclock multiple times
>> afterward. As noted in commit c52ffadc65e2 ("KVM: x86: Don't unnecessarily
>> force masterclock update on vCPU hotplug"), each unnecessary
>> KVM_REQ_MASTERCLOCK_UPDATE can cause the kvm-clock time to jump.
>>
>> Therefore, clear KVM_REQ_MASTERCLOCK_UPDATE for each vCPU at the end of
>> KVM_SET_CLOCK when the master clock is active. The 'tsc_write_lock' ensures
>> that only requests issued before KVM_SET_CLOCK are cleared.
> 
> Hm, I think we should do this in kvm_make_mclock_inprogress_request()
> instead.
> 
> Currently, things like pvclock_gtod_update_fn() and one or two others
> set KVM_REQ_MASTERCLOCK_UPDATE for all vCPUs. Not just one, because we
> don't want *any* vCPU going back into guest mode before doing the work.
> 
> So they could *all* end up calling into kvm_masterclock_update() at the
> same time. I have a vague recollection there was once a mutex there,
> but now there isn't.
> 
> So all vCPUs can each, in parallel, set KVM_REQ_MCLOCK_INPROGRESS on
> all other vCPUs. That's an unhandled request which just makes a vCPU
> spin (preventing it from entering the guest until the clock update
> completes).
> 
> Then each vCPU tries to take the kvm->arch.tsc_write_lock in
> kvm_start_pvclock_update(), and from this point they'll be
> serialized... but every vCPU will go through the whole of
> pvclock_update_vm_gtod_copy() for itself, updating the masterclock one
> more time for each vCPU in the system?
> 
> I came here to say that kvm_make_mclock_inprogress_request() should
> probably clear KVM_REQ_MASTERCLOCK_UPDATE on all other vCPUs, since
> it's about to do the work, and the other vCPUs will no longer need to.
> 
> But... it's more broken than that now. 
> 
> I think maybe vcpu_enter_guest() should call kvm_update_masterclock()
> if *kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE)* (i.e. not *clear* the
> bit by using kvm_check_request()).
> 
> And then after getting ->arch.tsc_write_lock,
> kvm_start_pvclock_update() should check if KVM_REQ_MASTERCLOCK_UPDATE
> is *still* set, and only proceed with the update if it is?
> 
> I'll play with it some more... something like this perhaps?
> 
> From 91e37d74ee267c722bc2c8f26754fcdfbc040e29 Mon Sep 17 00:00:00 2001
> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Sat, 9 May 2026 16:54:01 +0100
> Subject: [PATCH] KVM: x86: Avoid redundant masterclock updates from multiple
>  vCPUs
> 
> When a masterclock update is triggered (e.g. by the clocksource change
> notifier), KVM_REQ_MASTERCLOCK_UPDATE is set on all vCPUs. Without this
> fix, each vCPU independently processes the request and redundantly
> re-executes the entire pvclock_update_vm_gtod_copy() sequence, serialized
> only by tsc_write_lock. Each redundant re-snapshot of the master clock
> reference point introduces potential clock drift.
> 
> Fix this by having __kvm_start_pvclock_update() check, after acquiring
> the lock, whether the requesting vCPU's KVM_REQ_MASTERCLOCK_UPDATE is
> still set. If another vCPU already did the update and cleared it, bail
> out. Otherwise, clear the request on all other vCPUs before proceeding.
> 
> The caller in vcpu_enter_guest() now uses kvm_test_request() (non-clearing)
> since the clearing is done inside __kvm_start_pvclock_update() under the
> lock.
> 
> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>


Thank you very much! Feel free to add me as Suggested-by or Reported-by.

I will also help test your large patch series.

Regarding the issue, I would like to confirm whether there can still be any
KVM_REQ_MASTERCLOCK_UPDATE after KVM_SET_CLOCK_GUEST.

Per my understanding, I would expect KVM_SET_CLOCK_GUEST to be the last point
where the masterclock can be updated (during live migration or live update).

After KVM_SET_CLOCK_GUEST, any further masterclock change may cause kvm-clock drift.

Dongli Zhang
