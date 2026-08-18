Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC133BBCC
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096955; cv=fail; b=PSLf6iejN2EuoVwoSnZoO6Vx/4Rwv7TpIMmlz2GvaUgHwhSyNwpHBKdj3Buxz3J7W+xAUaTiUD041EqxU1+LrjJ809RHiB4+cra4NdOuZkDtM11ws78hZgYh3MivJm3GQPgaNBhhy79OyWVpaL18xbMcU+WNZNP1gMCXOMgjkzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096955; c=relaxed/simple;
	bh=ZdatXb6Gq66JiiRnuyq5kir9EMOMsftt6fmUmSMH5Lg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uv5bFXqluyRhasS/JwRA7PB1cAKVX1bACROu0oeVP8C4U3qnXFMFCjnFmbxZ980kzzE3DW5niDl8IAB3bkiif9KaX0H/VJexb7LlCWIs4icS/QB3rsOLKNnn0OT0y00hDlsA4YPBybdS2JbfCM5+8sA1M1vQPVZZ5i8D3epRA7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=leciOc5d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fnZ3ikIO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="leciOc5d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fnZ3ikIO"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ILWwT04112368;
	Tue, 18 Aug 2026 23:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DCnMbDEr2tX1xuBgQ3BjioXwexv4J0FEaH0zOM9DljM=; b=
	leciOc5dhwIDRf0OkEXwHIW1hY4d/Jm1mH0SbCatanUHk0fwTEhG71uhGLhmDME3
	G7/P8/o/tsdcU8i5mLbdKBH1hV62s7mxqBJ2iy0IR+JyGXS5ASBEl6l/AdRusShe
	FZ4S7JQqK5uFBJ2ChYBV0Ud20jzi2PNjKdguPXVre4S3LmCOHMuHnvFFdKcjPjAe
	/vl4nOopKOjLfFPetmnKI7o0U7AJ8KC+lhkjYgVV9qPoz0ql5mj81LfnOG8XRUfN
	tc+0YHtXK1qz+gxlldRvtYMZWlpiwnk4qHDaLIaOPYe0E/XWLfJun1Iz/z7UvvFB
	AZTitdY0sKZpG8b+UhICEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydeg4cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 23:49:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67INZeKp016385;
	Tue, 18 Aug 2026 23:49:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejr8s84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 23:49:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPsVadXlOD+9PXcy5Ob9FFMSdX1rOJD/qNeYRqpv4ihUSsZwoZK26PGn6ovALehGCd3k4GAivG6qbguTEEwBCufgNbaID0YYWn4vKvAgPAXVIcxiOoZLCv6IYRGK7fbAQWAfAc4HV8vlXLZnJsdd+Q/7T9gSrKTSrm6dAw5NJce81otHGk0UgQUSxB9BCZ0i/jcF2IVQjNgkRHmfItckkXogNDL2F1vHs5VvJij7fCVAVGguUovwpgpN61iaraQQQ/l4D1YB9t6g2X5ViF3MIYposFSZFz682EWE141Oq0gSEL8MDp4df9hEhfDxxrOW+We87zGhVOby0iLlQ9/tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCnMbDEr2tX1xuBgQ3BjioXwexv4J0FEaH0zOM9DljM=;
 b=EJNEMcDipno0aHwH744va+TJpCT1TiGPwJKJ8uel39ATnSAp4uWlm+6biOwVBRoNnLbZEzEuo+o0xFw0h/ndTs6q7kcyOH4MZBj8D2R9SUaGIEx4rM2K67ahsQDsl2GELGO/wEampv2KanyLOZk+IwZlM13OB68yIr/BQxOQ5sqSaGmltstY0ry+sBH8nBmTTJcM6zwoesJ2SSzKjFmiUGIaTXOhvjmWLn6aOREbclVT6IFRrG5lekNc26hYRPzVWi9iPkvBGo4EAq51kf57qCNHHoUySQdESPvklIo2ocZ9aqt88xKHiDAbwii3sxrQRI6VWJXnv9/rarh42xDgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCnMbDEr2tX1xuBgQ3BjioXwexv4J0FEaH0zOM9DljM=;
 b=fnZ3ikIOKgn17Xig8Sd4pOvHOstkbzCNiDKXys4fHanPh9AIZBCufm4QiXqYCRLOmQM4C8fZ9y7ulyUIuQ+9MMia2sdQ38tsxumd7IEFlxaqxzlUr/lkzFCC+QnzfhkUG5SY6/lMxm/PeqD59ZxPDdMvmPvl4GqD/GsHK4VuBkw=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by CYXPR10MB7921.namprd10.prod.outlook.com (2603:10b6:930:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 18 Aug
 2026 23:49:04 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 23:49:04 +0000
Message-ID: <b6310c05-e920-44f8-a47e-9f8f6e7125aa@oracle.com>
Date: Tue, 18 Aug 2026 16:49:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID
 together
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, joe.jin@oracle.com
References: <20260818234238.618158-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20260818234238.618158-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|CYXPR10MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: a58dc8b0-b528-45eb-d19d-08defd834901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|22082099003|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eyXh82Z8+DJX5StQiVSSIffTw675j9VRA65gBN5rBIJi/ERt5is9VxVCHso6hsLDjHG4ustewE4q+uQ7+Kz6OAQimCfDXR2Jk922oJBAb/3e+JbpFbLwyiFsT0NWEdedUdnHw4BzXsz8kFrEUfC/JoCsEPCwAeXVCpVbAaSDP9QWuoRJav5GJe6jgVAk+dpZrIG7itvMdw8iP7ZU0DIo2/Un7nBR+HLgV0jUDgcTyS5tW/K3N8bqGH7MxOv2+vSdgT8aus2hjY4Sc6FoKSNrwEuZ/dYk5VXZuambVTEw813Pi9CjoOjFF8nNf45aadTDUgcyhRhIaV+FrfF98YmNWzQMSkUqLnXf0ua5eWHR7XowqBS2IjDITWuSTaLMBDiBPK1LEKiY5Mjh+NlKTroAdrAkpjL9gzE+F2/RFQ/j6kIjpH6biKtrQfF56lSlw/+9ZBpOEK6iPFKpGpu46a1hlu01NeHJ5YLWXK/ah/6PE+k+VcjoNhfTIAWTC7NZ2OJ9Q5TkwOMWA8EFQBEv4fMVgD3CmDNinfABGarcf2fcB8lHM1vMuBKkrxVUMdlvdeMvPtk+f8UdW0BbiCtT1XHF/RT2sS0MKi3+l9QM2HXp+O61LFUcH/Qe2PS82FiZ3Wzt4Fkcdg+ydHJ8ahSSPnRrTXPzKpA6aVj7Uu+AWXneQnw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THkxZVNFU1JYR3M5YVZNNmJHbVV1bDFYcFZPT3NqZFRSSFl4V0NWUnRZaDFF?=
 =?utf-8?B?UExEdldFbzFEMlUxMElzcmlML2pIUmc5eERza0FxWGFoR29jUXpxZ3JjTnFt?=
 =?utf-8?B?dlBzVlJOTUVrVUhPU3lmbTF4dEV1UjI3N1Y5YkVJakhGTlcya2JBZU12K0xr?=
 =?utf-8?B?aGdudWRKN05qdk5FOWMrbHBmRnBBem95MlZBODc3bWczTjBXd1o1RkNadHZh?=
 =?utf-8?B?enp6QTJSY0pocnB6VzljRkNMY1VacUc2cmZlbnVSL1ZwcXhpL2djdm9pNmJD?=
 =?utf-8?B?bDlUdUd2V1Nta2ZQckpBM3YyZ3FHV0UxdkcvNjgzdHdSejJOd05HTmcvaGIr?=
 =?utf-8?B?eSswcndpR0UvL29pV1l6dE9pZDNIenRJakcvTlYvY0J4eC9iQU94Q1J5WDJq?=
 =?utf-8?B?WEpYM21tWkhSeHUrbGRGMWVaR29aK3V0TkJKQ3RiRnNndU14eHJQREVwdS93?=
 =?utf-8?B?cDVQRVpYZjFwRDJGSmNiMGI4dnZWVmNRZ2J0NklMQTFiZmNQUXRIZCtMaVFL?=
 =?utf-8?B?UlZIZ1d4b3puSjdQK2VlV3UxeS9PYU0rVUl0M0lxS2VBSFhGYkN6N0ZYS0xC?=
 =?utf-8?B?VDZHejVOVmozYkJMaHlVNWpxVFV3a3EweXZsdHFNWmJMb2ZERElOMXh0MVNr?=
 =?utf-8?B?MzV4SzJoRXo5amZ2c254L3JUWThTalgwakoraERLeWRPOTFxc2NIODliR3BR?=
 =?utf-8?B?UkdnbU5ISjNuMm5TU3hBbE5FUzJ4dUZ5Rk1uK3FwMm1Wem0wYldnYTdQWDdq?=
 =?utf-8?B?U3E0RmIzdWV4TldQY094dXF2ZnNrWkZZVEM3cVhsaEZ5MUFXWXpQU093dVFE?=
 =?utf-8?B?cm1FSSt6c3lxUExxNzFRRHhONHo5RVNueElVRncxbUgrbW8yN09xMGg2N290?=
 =?utf-8?B?dm1mQllEUXUybjJEbzcvTGJSTXVYOW5GZnpaZTVhQ3pRcDI3WnpYVEM4UGdm?=
 =?utf-8?B?dng4ejhZNHEwOFQ5Z1B0M2F2UW9ncWdZQ2hDanBOVkxYelk0RGJVc3MvVHV5?=
 =?utf-8?B?NTErdkdBQWJsOU1NWjAwREo1cEpUNVNoVlR1QTBMczlwR1gvcEhnZHIyYzhl?=
 =?utf-8?B?eFJ0Zm84ZEcvNkJYN1VCMkpPN3RUUDdoWmJmWUE2YWNWdjV4RDlXb285aWJo?=
 =?utf-8?B?NFcyalpqeGZaVlNzVndFTGRxaFFQd3RUWE4xa2lEdjBsNU5ZRHZMNHR0SGJD?=
 =?utf-8?B?U0NOb1Y4aVoybVBrQ04wU2x2SWlHbVZteENhVTdLQjhCV2ZOMTJPemE4eVVj?=
 =?utf-8?B?YkQvM3ZUYTdRdnhoelhVcjdGb0VoT3B4OTNVVklHV3AydTdjMWQybDExbVFu?=
 =?utf-8?B?Y0FIeStjQlJSQ1RXR1IzVlR0QTJFMkpnY3JQQ0VSbVZmR1l0VU1XaWw0elAz?=
 =?utf-8?B?ajRhc0pGZXRTbnl0ZkhrTEVJbDF5WjcxK1pPN2NlaklhOTI0UHFzckl2N1Fw?=
 =?utf-8?B?aHVieVF6Tktaby9XSEdJaWUwM0dMaC9oUFk0SFRxbkhvczdaZmdwZjE0MzJv?=
 =?utf-8?B?aWVrY2lFc3VPdEdNa2hiajJGUWxQUXRDM0lMcVdiR0QzU1dTaGtCNmlmREEr?=
 =?utf-8?B?L0lmZ3REQjdDMzJNVWVvdTMxbjkzQlB1dytmKysrK3lQeGlNYWdWNVg5aStL?=
 =?utf-8?B?UEoxMlpYTFVCWG5jS25Mb0pJcTl3b2lJTVVydWo2Q0F6djZmM3Y2MjVFamd1?=
 =?utf-8?B?RWNFRnZDNVAyYUppNHJSMEtNWGpMak9tUmZPdndIZ2dJMG8wdUY1UUk3elo1?=
 =?utf-8?B?aTkvNmZ1VWhIbW9QUkFQQXhGZFZBTjFtQ29hakZkVENhZHhaQkVLTjFzQ3dM?=
 =?utf-8?B?WHozOWNGa2JkcEU5WEhrYTFJcTNNMnVhcmZGRWJ1QU5FOHdGKzZ6YjBWcnFI?=
 =?utf-8?B?eEpRbzhIODdmUVFIT1dCUDk4cXBlWHpNbnZ4YStFU2gwRTVJTzlmT2dWZnRL?=
 =?utf-8?B?ZW5zWjlKTk5vV2dRaHJwSlRsMTRLOFhTSmtaTzhXWWZkellseVVqVXZDRHRG?=
 =?utf-8?B?NEZmR1d2VE5pQXB6TjFuTllORjF5c0o0OTZwSXpMQ3RCai9adXpMbDFWZFVr?=
 =?utf-8?B?NHViQkpWRDZTWkxVYjJwSlVxT09FbTZIaWo2VDcweVhOb1RubU4zMWR1WEdj?=
 =?utf-8?B?cFpjUWFVb2tLZlVqMStMN2QrUEVDTnA4T3dyNlMwMGRmYWs3UmtpRk4xYWdw?=
 =?utf-8?B?ZnVIdmpsU3pXaElMV1BDREFFSTNSUkw5VUFKeXhwaWVZa3Y4TXo1MEJReUg0?=
 =?utf-8?B?eXdHS0orUWQvd2JQcGNZeVZWTjdmcjlydjZzc1VHenU0dE4zaVFWRi8zcVVq?=
 =?utf-8?B?V1dhR2hCYUNDbWVub1BiM3ZZczZUZnlMMlBQT2hIQ0xMYThZTi9tWDlOUUkv?=
 =?utf-8?Q?XbnuuWlF2gy7BtiA=3D?=
X-Exchange-RoutingPolicyChecked:
	ClxEHsAnRR1hgRLSCxIIBUKFbVuDotVJ1u5HJj9f75xb+i9LzS6fHGlAdSt3T+zX3N2741Eux+/UYFVcYRrInuXSMXgjn329sazmA8XAX/mZQsWqG1ETfAiEbDNWSO6X0AehNBwQHhkRS9ozzni/J02m+fTKNCsT5LMTqNX/QbAbcRo8DaiIDNCIfejMzbChVwvZ2Fkh2H04dmle6Q1iYQNrXM3YgbOEy9uMkf5uIGcVQ+1C7UAbh+ay4si21OkYcv5jXPKYMHikBIt53lrEEDpYPo6gbZdz0mnpClfY+0U884XbdELItdFmCNLC/XnJNkOZvN1jjFRt7eFAm4nvLg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TpJgL0mZfaPQ73ZvoGtRD/+tGjjU06E1zUMDgOJi/y8z6GlAxq2+7VFUefcpeJCfbZcnsNRw1y+iPSQ4oi0Kz0p//ySCRZ6dV551GmfhKoDfO63L3jEsqA3jQUjcT/PmL9UQj4w25iVZKtXqpjtMhP7oGAiXw42OYy/YKNQr6wxGLHzxNTbvvvY3UkhEsCVjDEzwj2CZLTPe84kxgrXzL8a4phOyvk3i6vBePSpdaHKr/kqofibhr7PLzPqBM7snz1ufoFFFIq9+G9ryqei8C6mqoRJGuQT4zxFtdrpMK6BSLVARBpT8f5DmHf7Nwme8DfrJW9PKAi3jdAI+ruAvhEE+DLJm7vTywLHmjIGZDgNMhqojwDxnkMejiPY1utIx0yfPlncxLmMkQokDkNLQc5JjOkgJSNM5KtKDutmb5lEVSFBV3Jewh6kAOhM0Y4ubV+RugqIl/X1YkaEmCsdUKR8kMVE+gTq7V0BWDtKb9Gqw4YnOf72lK1ywiCkZogeuJCnLF7aQbKnAXqMdJ9QFRwW+9xImnena2o39uir8TyJ80scpQQXsdfQL43sWQymwXU/k+EdX9KwaO6uZZ9oVNoD24B6ayN+n2L8ULNxhS+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58dc8b0-b528-45eb-d19d-08defd834901
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 23:49:04.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkMGr+p7e54NcDdW18VxuIRPFDHTCfcpZXHi1GL1ENszFY3ttlj18GyOGfoNSXQIJis2Oo9bT8JMJOCqaWJ3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608180174
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE3NSBTYWx0ZWRfX9LLJyb/8zBwf
 iZSGTXcRcwD/R8/vYSKLgkOMrvMqWALX6mAOUJBJtq2McV7EsS0kapt5RoDLlrxjr+75Qp5XQHp
 W04SjVN4x9X8HT2T3S9vSfrWwp9u2IuLVYyTwTSneCvsRAfZA/zb
X-Proofpoint-GUID: QdmQ8UvUQTqE-8a2lT9NuKTubVF8A6OK
X-Proofpoint-ORIG-GUID: QdmQ8UvUQTqE-8a2lT9NuKTubVF8A6OK
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a84ef75 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=0OwApUWrgIfgC2oc0RQA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE3NSBTYWx0ZWRfX7UrSDx0fwZYx
 msMxbwWhzoa4FKEo2nRdxknx4BLOgkJmn1uZogRElMtq2FiD0RSTHfKDiO8wHRwY0e2LfabLVEO
 ACVgCNF25yMqdXKjPnaZsKFJqVCS6RATrOAGu8HBGCwb8v64BqqOINqkSpmn0RsfGcKL2l2as6U
 QDlIygLrRbzxSutaDzUNlSUcObFVG3WHz5eif0ub8C7z81TEkD7AIHbaLRb/Nc4TiTn+FBvDI8X
 ILTYc2fUa/+OYiC1PJvXTX3j5Yp6Jf0VB+lJoTqAG2jZvtp654fPqvXEnvJdQl8F8A+7EyKhHcm
 Pw1Ozk7ZAXbqAry1feB0PWFkgM3eesBXCRrSalQDfXC8W2ctA8Gy5P2y5RnF1h6wwT6kVWdeBea
 4esvXl3tqGAaATqSKHharzOOdMXivMRiyoz0AOAEuA3vqlbefK/sdsjwtO2+3KDOzK1ML00TSJ/
 QzJUcQjGer/G6EPnpc1pV/QbaRv0rVtwX0WsLg/I=

Here is how I reproduce the issue. Apply the KVM reproducer patch at the end of
this email. The patch intentionally adds mdelay here and there to reproduce the
race window. Install it on an AMD KVM host.

1. Create QEMU instance:

qemu-system-x86_64 \
-machine q35,kernel_irqchip=split,dump-guest-core=off \
-hda ol89.qcow2 \
-m 8G -smp 4,maxcpus=6 \
-enable-kvm -cpu host \
-net nic -net user,hostfwd=tcp::5028-:22 \
-monitor stdio -vnc :8

2. Add and remove two vCPUs.

(qemu) device_add host-x86_64-cpu,id=core4,socket-id=0,core-id=4,thread-id=0
(qemu) device_add host-x86_64-cpu,id=core5,socket-id=0,core-id=5,thread-id=0

(qemu) device_del core4
(qemu) device_del core5

3. Enable ftrace.

hv# echo "kvm_apicv_inhibit_changed" > /sys/kernel/debug/tracing/set_event
hv# cat /sys/kernel/debug/tracing/trace_pipe

4. Re-add the same vCPUs again.

(qemu) device_add host-x86_64-cpu,id=core4,socket-id=0,core-id=4,thread-id=0
(qemu) device_add host-x86_64-cpu,id=core5,socket-id=0,core-id=5,thread-id=0

Here are host dmesg are ftrace output.

[  435.984063] kvm: debug: kvm_apic_set_base() vcpu=4 wait ...
[  436.111019] kvm: debug: __kvm_apic_set_base() vcpu=5 race window start
[  437.991539] kvm: debug: kvm_apic_set_base() vcpu=4 done!
[  437.997618] kvm: debugbug: kvm_recalculate_apic_map() mismatch detected for
vcpu=5
[  441.121122] kvm: debug: __kvm_apic_set_base() vcpu=5 race window end

CPU 4/KVM-12339   [422] .....   440.424414: kvm_apicv_inhibit_changed: cleared
reason=5, inhibits=0x0
CPU 4/KVM-12339   [422] .....   440.424414: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x0
CPU 4/KVM-12339   [155] .....   442.448155: kvm_apicv_inhibit_changed: set
reason=4, inhibits=0x10 PHYSICAL_ID_ALIASED
CPU 4/KVM-12339   [155] .....   442.448162: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x10 PHYSICAL_ID_ALIASED
CPU 4/KVM-12339   [155] .....   442.448171: kvm_apicv_inhibit_changed: set
reason=11, inhibits=0x810 PHYSICAL_ID_ALIASED|LOGICAL_ID_ALIASED
CPU 4/KVM-12339   [155] .....   442.448171: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x810 PHYSICAL_ID_ALIASED|LOGICAL_ID_ALIASED
CPU 4/KVM-12339   [155] .....   442.448171: kvm_apicv_inhibit_changed: set
reason=5, inhibits=0x830 PHYSICAL_ID_ALIASED|APIC_ID_MODIFIED|LOGICAL_ID_ALIASED
CPU 4/KVM-12339   [155] .....   442.448171: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x830 PHYSICAL_ID_ALIASED|APIC_ID_MODIFIED|LOGICAL_ID_ALIASED
CPU 5/KVM-12340   [153] .....   445.570271: kvm_apicv_inhibit_changed: cleared
reason=4, inhibits=0x820 APIC_ID_MODIFIED|LOGICAL_ID_ALIASED
CPU 5/KVM-12340   [153] .....   445.570276: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x820 APIC_ID_MODIFIED|LOGICAL_ID_ALIASED
CPU 5/KVM-12340   [153] .....   445.570276: kvm_apicv_inhibit_changed: cleared
reason=11, inhibits=0x20 APIC_ID_MODIFIED
CPU 5/KVM-12340   [153] .....   445.570276: kvm_apicv_inhibit_changed: cleared
reason=8, inhibits=0x20 APIC_ID_MODIFIED
CPU 5/KVM-12340   [153] .....   445.570276: kvm_apicv_inhibit_changed: cleared
reason=5, inhibits=0x0


This is reproducer KVM patch.

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 48b019114c19..6db820edef38 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -46,6 +46,7 @@
 #include "cpuid.h"
 #include "hyperv.h"
 #include "smm.h"
+#include <linux/delay.h>

 #ifndef CONFIG_X86_64
 #define mod_64(x, y) ((x) - (y) * div64_u64(x, y))
@@ -280,8 +281,11 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 	 * 32-bit value.  Any unwanted aliasing due to truncation results will
 	 * be detected below.
 	 */
-	if (!apic_x2apic_mode(apic) && xapic_id != (u8)vcpu->vcpu_id)
+	if (!apic_x2apic_mode(apic) && xapic_id != (u8)vcpu->vcpu_id) {
 		*xapic_id_mismatch = true;
+		pr_alert("debugbug: kvm_recalculate_apic_map() mismatch detected for vcpu=%d\n",
+			 vcpu->vcpu_id);
+	}

 	/*
 	 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC IDs.
@@ -2796,6 +2800,15 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu,
u64 value)

 	vcpu->arch.apic_base = value;

+	if (vcpu->vcpu_id == 5 &&
+	    kvm_apic_present(vcpu) &&
+	    !(vcpu->arch.apic_base & X2APIC_ENABLE) &&
+	    kvm_xapic_id(apic) != (u8)vcpu->vcpu_id) {
+		pr_alert("debug: __kvm_apic_set_base() vcpu=5 race window start\n");
+		mdelay(5000);
+		pr_alert("debug: __kvm_apic_set_base() vcpu=5 race window end\n");
+	}
+
 	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
 		vcpu->arch.cpuid_dynamic_bits_dirty = true;

@@ -2858,6 +2871,13 @@ int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value,
bool host_initiated)
 	}

 	__kvm_apic_set_base(vcpu, value);
+
+	if (vcpu->vcpu_id == 4 && !host_initiated) {
+		pr_alert("debug: kvm_apic_set_base() vcpu=4 wait ...\n");
+		mdelay(2000);
+		pr_alert("debug: kvm_apic_set_base() vcpu=4 done!\n");
+	}
+
 	kvm_recalculate_apic_map(vcpu->kvm);
 	return 0;
 }
--
2.43.7


Thank you very much!

Dongli Zhang


On Tue, Aug 18, 2026 4:42:38PM -0700, Dongli Zhang wrote:
> The commit b2849bec936b ("KVM: VMX: Update SVI during runtime APICv
> activation") resolved the loss of EOI issue when apicv is activated after
> being inhibited at runtime. However, it does not resolve the cause of the
> runtime apicv inhibition.
> 
> The inhibition occurs because apic_base and the APIC ID are not updated
> together.
> 
> Although commit 052c3b99cbc8 ("KVM: x86: Reinitialize xAPIC ID when
> userspace forces x2APIC => xAPIC") reinitializes the xAPIC ID to the
> vCPU ID when userspace forces the APIC to transition directly from x2APIC
> to xAPIC mode, the updates are not performed in a single transaction.
> 
> If another thread calls kvm_recalculate_apic_map() during the window
> between updating apic_base and the APIC ID, kvm_recalculate_phys_map() may
> set xapic_id_mismatch and temporarily inhibit APICv.
> 
>        Thread A                        Thread B
> 
> __kvm_apic_set_base()
> 
> -> vcpu->arch.apic_base = value;
>    (disable x2apic)
>                               kvm_recalculate_apic_map()
>                               -> kvm_recalculate_phys_map()
>                                  *xapic_id_mismatch = true;
> 
> -> kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
> 
> 
> It is easier to reproduce without the commit 052c3b99cbc8 ("KVM: x86:
> Reinitialize xAPIC ID when userspace forces x2APIC => xAPIC").
> 
> In the QEMU scenario, when a vCPU is removed, QEMU parks the KVM vCPU fd
> and reuses it later. When the same vCPU fd is reused for another hot-add
> operation, its x2APIC is still enabled. Once QEMU tries to disable x2APIC,
> we may encounter the race windows described above.
> 
> Add conditional lock protection within __kvm_apic_set_base() so that
> vcpu->arch.apic_base and the APIC ID are updated atomically. The same lock
> is also used in kvm_recalculate_apic_map().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  arch/x86/kvm/lapic.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 48b019114c19..1d858c259ab8 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2793,17 +2793,29 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
>  {
>  	u64 old_value = vcpu->arch.apic_base;
>  	struct kvm_lapic *apic = vcpu->arch.apic;
> +	u64 changed = old_value ^ value;
> +	bool apicbase_enable_changed = changed & MSR_IA32_APICBASE_ENABLE;
> +	bool x2apic_enable_changed = changed & X2APIC_ENABLE;
> +	bool apic_mode_changed = apicbase_enable_changed || x2apic_enable_changed;
> +	bool need_lock = apic && apic_mode_changed;
> +
> +	/*
> +	 * Serialize apic_base and APIC ID updates with APIC map
> +	 * recalculation.
> +	 */
> +	if (need_lock)
> +		mutex_lock(&vcpu->kvm->arch.apic_map_lock);
>  
>  	vcpu->arch.apic_base = value;
>  
> -	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
> +	if (apicbase_enable_changed)
>  		vcpu->arch.cpuid_dynamic_bits_dirty = true;
>  
>  	if (!apic)
>  		return;
>  
>  	/* update jump label if enable bit changes */
> -	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE) {
> +	if (apicbase_enable_changed) {
>  		if (value & MSR_IA32_APICBASE_ENABLE) {
>  			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
>  			static_branch_slow_dec_deferred(&apic_hw_disabled);
> @@ -2815,14 +2827,17 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
>  		}
>  	}
>  
> -	if ((old_value ^ value) & X2APIC_ENABLE) {
> +	if (x2apic_enable_changed) {
>  		if (value & X2APIC_ENABLE)
>  			kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
>  		else if (value & MSR_IA32_APICBASE_ENABLE)
>  			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
>  	}
>  
> -	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
> +	if (need_lock)
> +		mutex_unlock(&vcpu->kvm->arch.apic_map_lock);
> +
> +	if (apic_mode_changed) {
>  		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
>  		kvm_x86_call(set_virtual_apic_mode)(vcpu);
>  	}

