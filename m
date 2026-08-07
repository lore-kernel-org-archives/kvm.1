Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E619F40B;
	Fri,  7 Aug 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099711; cv=fail; b=lAaaimBzh4FRENborZiUW/tjaL1OZmn17b9UxrnF5ouo56hNe2OZbpVa1lQk5d7FtjHgjx9YdhxpX/PvmPDTSA9adTdgGW1kfVHxY/ljn8EJh82BVPEiczo4dxh537Odf6cjRARtWvfCWO4YZ9J+JY9B8KVDrOmCqMwuDFAYXM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099711; c=relaxed/simple;
	bh=F9CD/i6OU17xZPsA4MrJ8Xwklzlmzmc4Hgord3FDbGI=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rjn2KLdhj99xnQ00Xl4YKANNurTYPkPSKjq5o2fN/FmPgG6oJXxitXkgpbVeoVT28qSGmQ+1I1oPgxwvsbLxJCMqP4mIYHbve4PIJ9OcECPDZACF+n9xHN+9s943TVW8aago3/4rdKv954vTKNAAxvBttx2IrIlBj4MSrcWi9zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ow+VbWkt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLhs0ENm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ow+VbWkt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLhs0ENm"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777FohQ3045249;
	Fri, 7 Aug 2026 10:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1fhtm5Z4/Sn3mckax7HTdURLmW2vVjHHZTZ4XTsq1sM=; b=
	Ow+VbWktNJLEGKjg/o+6BZgk8s9qZbQVtgYS2Jw1UD9nU/FZoIYbKOQAfb3F9KS8
	L0+NumqQHUoBi2PCQT6K8b5lyFCKsgoJHD5fvpRWiAIWd237isAZeIsBMoyWQISZ
	bOeTFDTWS4fghQEBWt+I0OWJ50MJ8GvA46gOvO6jfWazDceOgSeuaVWIu3JlbiGN
	kLz12m3zrDml8ozctwaMTE6f4M7eGPgWnf408Tbt8+BzGOns6CGugvSc48PsVG3X
	zwAeQkfFwuarXlUxQ51pCMMgJAlYl7VCtA6ZRIXDwoV6WlU/waf/GYKdPeOAs//y
	2lB7IbnAyWDAr+IT7U97qg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9btfbvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Aug 2026 10:48:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 677AjfwZ020055;
	Fri, 7 Aug 2026 10:47:59 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78fkpbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 07 Aug 2026 10:47:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKJJVg9uuASUVcK8MO9D1ZZteNmAd8O2T0O9mIC9MIUjnQBJ8iyeVgUynqYD1Dt9WfC3HgP4isvKLZ4YSdLQzvM4whh9LRjVlI4vQ/u6MKHcRzI/oBaIns38oR6hx1MLeD7luzN+MQUPTjHG1JGSY7RDom0oGBBtx3J7SZ1u/KvlHx4Ux/v+HdUmiYaI5noQ9egLsWqHEgf+d656xveqWUKPB6elQHrRXM0jvR9LN2M7BSJPUGz82KAfU0w5eLYYI5F0P80MEW6iYN/5bHE41bbHbGtbgmMq0TYyVrzAI1lQnFPGBXFX0w35UN5Q5cZ46RzlFaJIdS35EtSK6uHufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fhtm5Z4/Sn3mckax7HTdURLmW2vVjHHZTZ4XTsq1sM=;
 b=QSATf02WNBMoztvbLRVkKgqAL6l5S37pYyg5GWKtIDu0H8lfEsoilJ9oZGOZWojfzfDyTbwgJ0+ffsyfQJC6C6UAfIvkK0hNDNOfhL2pqNt1fIzssrd2AhhrDDO4wzW2G7rwKNauiIRIwXcQ/O7bKgMNRY7qhdvzFlTz4zq4qC4KLoMiEL/lIG2JIaEOe0Ynyi0R8CRtwdemiQGDHDWuNhNiyh0lYSflar2hRQ9b48w8z9dlK9eDe8K1m8RrCCiUwXXf0G87WjKN5Ja4O7gNPPHO8e22M90OC6i0zmn10I5+jGqJH/tgcsAFS5+y0PIfS/97D/h2gHZ6zCZFfmmHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fhtm5Z4/Sn3mckax7HTdURLmW2vVjHHZTZ4XTsq1sM=;
 b=uLhs0ENmiJ3awcgr5iVJJ81VH2QBY+3byUkwjTSCxsmvYCeTLQ/5etsnXKyvZdtIEanoGUdjI636EN3NiTLttC5CH1Ed+LyO5MelQS7uHXEYYDiVkqoo/wJG3Qdf7yD5Pk+VYAvTr0t0lgxQ6GaCCTNgVZWK86hNBO//s47Htzk=
Received: from DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) by
 CH4PR10MB8050.namprd10.prod.outlook.com (2603:10b6:610:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:47:55 +0000
Received: from DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e]) by DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 10:47:55 +0000
Message-ID: <40bc3192-d489-4843-ba03-40c740187741@oracle.com>
Date: Fri, 7 Aug 2026 16:17:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] x86/smp: reject hot-added CPU with conflicting APIC ID?
To: Partha Satapathy <partha.satapathy@oracle.com>
References: <20260807104237.4093260-1-partha.satapathy@oracle.com>
Content-Language: en-US
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Partha Satapathy <partha.satapathy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260807104237.4093260-1-partha.satapathy@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::6) To DS7PR10MB4990.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4990:EE_|CH4PR10MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: b285f04a-0ae1-4d15-a562-08def4715657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+TWUgDdqwiOfz4frSrh1Nb8PHW6H0yLtufWQ8ZQBmpJT/k7INZ+PoL+IQzFWO1f9o2l1OOfZvtgAifPhDr+zn7omqd4Wylba/KOn7EJITi9w203EMO3zVCEGDZ3Z1L/7wsY+s2wpNI2I40iu3e7cXcFbKbTIbSP7wMyqF3+Lm/GU19QARWYemb+mn9dWgRkrDgikhzN6baRZMYQSoAro/MKvFgM8E7uDueCV1yttGDD3GxAEKstwTBCWVFd+vgk4zdgm1tfV8cgb1u0EtOrWQiu+XWZkFMJ47SBMYj3tAqf3UeyPIAwQWj8pxRC2yelCf5a5yQmlT/8OSXQW7xC2dBtC1f6UsnUvuwtCQUYUX00RnKuLYBIqZ6lTysl0P8NvUMLrxvSuPyr2v3wlMqsvYeHyx8X5S2Wc9UbC7tPpGiTJipu2ZFwWH48kxtRenC/EdsAwa+SW541eKV9RW6CJE4cx4gqzyy226UHbYGSpwxCaRLILYKp84ci9rE+o/elNxG8rp3x9jS//OdRwLsHhKMggTNDzWMo4s4PHFqaZL+jJrg5UCaHqFoagQk+DQICB0WgEGfPLQxVW8m33h10b/X8lWyGfHf/Jz7C1QxGpJtaZmgSV5kab6+tWI6a+L7XtHt4hER6aKa7vc2Z5ZZDXjk/Pn3CaiYm0Emi/GMYthb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWErWFUvdXFpUlNOMU1HN01QdWhtSE9kUTdJTDBrSHNDOXp0NjNZWFRYOW0v?=
 =?utf-8?B?MkFueEtyeVRrdFRHQnpWcURjUWhCWVFlbXpHRnV1NHBwWUg0NkpTVjJnMTlH?=
 =?utf-8?B?VlEyQkRvQ2tYWGUyUkFXZ012UFVuOEFOYUpIelZreXBOZklkWFdReWM0Ymhh?=
 =?utf-8?B?OHZzYS9PMWVNVHRBamlrNmdrNGN6M210bGJkTGdqYVVaVlFwTnhMMWp0RlJB?=
 =?utf-8?B?TzVzOXZVaEZubW8zYy9Td2p0RnlwNXNtOUdzK28yTVlKNm1NRlc1aWdPbmdk?=
 =?utf-8?B?Y0c4MjFUUmRZSDBpT2Y4MTBwZ0xpUGtqLzlyNUQxclRFb1NNM2FidlRrRUFN?=
 =?utf-8?B?b1pOc0NkUzYvUEpML29odTVrR3pGMklvaFduTHFraTUzUVladDlRT2xyRHZh?=
 =?utf-8?B?WVJ4emp1eFluSHY3eTMyWTgzcWZLY1ZUZVlMZ3Y0REwyd1BYMDVHeEczc25h?=
 =?utf-8?B?UWFVNDRFem9yY1F1bWVMamhNU2Z0VVN3SldQdVVacmFmNlRiTzRpdm9Cbk9m?=
 =?utf-8?B?THV3d3dxSXV6RmVVTTZiMTNtUE5kWm5jejVzVU5hOHhKbmI3QkRLbzlxNmpU?=
 =?utf-8?B?L3gzR1A4UUczcDh5aWFHT01lZUZNelRZZm5CUTIzUEgxODRvRExTVTVvYVI4?=
 =?utf-8?B?N1dFTW5RdEd3VEVpRjB1Mm80UUs4SHZUc3V0ZUlqdVQvV1Y2QmpsMmREZEVN?=
 =?utf-8?B?angxZWVJZTJmc2xGRjdIVnpHS1hxR3NjNnQ5Qk9nNE9vK29hQkc0Y2NOUytq?=
 =?utf-8?B?dWZjTDJaN3FzQ3BDUmVhTzVXSW9yNWt2aHJsSWkrbytlaGlSbVNJUFJTSm8r?=
 =?utf-8?B?TTdUalo1TlNkaUxETERiMU1pZWVJbmJZRk5TR05tbGw1T016eFM2T1V2MHVi?=
 =?utf-8?B?TmYyU1ZFeENsZXpFd2NWcEo5WEVOVXQ3WWkzQXpNcTMydVppbmo4TVZIMU9U?=
 =?utf-8?B?dlJFSVVqM0NGTXA2dXlaZWpRRTZNSHprRWVYcWUwNk0zYkJ6SlNXc1NTZVJi?=
 =?utf-8?B?M1J0NnpMS0srb0ZCWkJHRE42d2dVYk5WaEVnL25HL0ZCczBoT3A4VmtjMlFF?=
 =?utf-8?B?bDc1UEtwMy81V0xWRFJMRWFsTlBpaDVvQ0wrUEF5b0sxVlFML0dsMzEwOXlH?=
 =?utf-8?B?MWVPbzY1THBOTUpqenltamNpSmdjaDNUdzlEamVsd1pwZkU3VE56Nmg1bkVa?=
 =?utf-8?B?WlFsSjlPMVhpTkhlNG8zNEdBbEQ4YUhDNHh4cnAxM2NMOEpRUnErb2Q2b2Z4?=
 =?utf-8?B?amxoZVVENzJXQ0dtK01WVnZEMjFBNGRMVFRnKzhFcnF1WWZTTkI3Z0pnYisw?=
 =?utf-8?B?V1BIbm1XeCtqSW85NjVXajB0NHJsUEo3OXhhVXgveGhVYmdZak5Va250RUNB?=
 =?utf-8?B?R3hjVlhZZHN1dEtIZjhtVktiMU9uSnl2cjF5Vk9Wbmt6YzI1bmh0OU1pYnBS?=
 =?utf-8?B?UlQ0QVhyTnJDd2x4eHEvcWJlOXpEUzNmLzZKeUpRcXZuUWVsUkZHYUJqL3Vt?=
 =?utf-8?B?Nmo4U1BrOWVROFNGNnF6OEZQc2hNdGRmdUJVNHV0THlJVi9CMVVmZlFsWkJQ?=
 =?utf-8?B?WDZXMGJhVjRSVG1FSzI5ZDNCMWdYQTcycUFYeTZQYURHR29vQU03b1o3UTB4?=
 =?utf-8?B?NWdMTHgxK1lIWVlwWnlyNm51YmFqSFR5VTFlRytuS0RFQlNjNXBaTlNNTWg0?=
 =?utf-8?B?QVRXbXNYdGVrb2pWdVdiZ3V5MHU5MldDTkpaQWMxV25zeDgrYUFxTkFYVTI0?=
 =?utf-8?B?S05VQ2pQNTdPK0hkS3orMDUvOVNYempqL0I5UlMwL2FRbVJYWDhqNWQ2SDA1?=
 =?utf-8?B?akxENWFPS0F2STNYZUdLWGxpZTBhS2RWNzhETk9uKytBTWtlcUw2bVhRS2Zp?=
 =?utf-8?B?Wnlqay94WFVXMEFqMlVCci9FVWJwS0Z4dkJxbTFEOXRybXlKMFdXbHJlaEIv?=
 =?utf-8?B?S0NhMno4eXpWbjE5Vi9DZ1luZTVpZHRzZGg2SHpvNnhtc2Zac2kwQ09nK1ht?=
 =?utf-8?B?NnA2MVpLQnRnTXhiMlhDWi9WM1VCakhtMy9hSXgxR3NyZE1sazFtbnprK2tl?=
 =?utf-8?B?VElkbUxoalhLSGxVTmJ4NVJUQkxSVzBiN1dqbmJmSFdRMzRlQ0s0M3RDbzNk?=
 =?utf-8?B?VUFyVndhYWh0NVlCTXBXTzVNU0dnNEZZNmR1elV0WUtaTVA5cDNmaGl4WFZZ?=
 =?utf-8?B?L2RKWW9oSWk1eEFZSm11ZTZtVm9FZUpWZ3RnWGNLOGZnZDdrNjAxVjN4cEdB?=
 =?utf-8?B?UENaQ2VTaXBPZE1NN3JKYzh3cG1oZlVicm0zNXp5VCtoWStkZk5HcHhJckxZ?=
 =?utf-8?B?WFB6QUtSUFhISElONldzU2NRYkRnYVAyUG01VFhGdkZQQU85cWQrUXdjUnFL?=
 =?utf-8?Q?ZNsi7yWgXDZ73qLw=3D?=
X-Exchange-RoutingPolicyChecked:
	HJzy0R1Zbgb3D75OMHrO3RFse6M6FLuFaIqom2LXN3zWi5KTdH/i52AcGnz1VVsrQLSSsouDBuOOdPmC36A4N6wIfJAIbZaws5CbTyW+3Hf/jLJsY0ei1PpREgj/wUQsYg+MRxJ2zLbK9jvRxut4G68338rMUxg4xj9/aRQ88+qq4F+zUbMQnHfc4zFLseoAOik5Wf2QTFuvyYcHsl80l/ZzYKxpavBaZsXwYL7efKrYczb1qt07RvydKrXYSqWJ+WtAJAjdJdGgB/lxVAPf7tdj+IqCPOO4LvBYgJtWdaKOctmnHHTqo0aoaWpHDFLGOmecR9oty3shPtJRYROSQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SobzQqCwK2kaqX9nGZmwN/KQIEoQQ7ga7h1VNmK1hi20XcQYxLcyQMlM83HvBFsRpzk0Kr8TSIv8mCDqlLqKfdQ3gZYFwaxU7kmVQPT3/3b7wzDKyji7i+PVf+vH0UgC72kcQ4iJU3DY4ggxRiiIJLUgVWnFsMRIq9EcXrUhLAFcxl9+za07W7z0NgIXTX3C09h26i/k7Rgx1p49UDX7dZQJN5Pu/bQ97qM811gxx1i/eOAYtEikD0aTI4aTM/GFbklhtAYRrb7e/7qpsvSSUfAZ28h0ckmAunNS5OKsesymf8052xx79PwIqwXdPsPCm7ut9QzeFzxdW1926DtohVU3lUZJxDYhnGRdwwB2iMLGH+yA8wK/IsIp+pjOqbTiHKM55TFxWAi+vP8wdkjUEopUORJ5p2iIWo9VXHN8g93ijepWeygGcDVAklbKR2EtqrRGdrMBbb27gB6GdteA3ky8+UoxMKu2w2kl1hhugohRYohoa0uv8ZHcvqW1IaAR4osGEqYIBWYmWJusY9uGGnF6Tm5AOlWzHoxTebVNyDA51bWxTYvuAYmF/u+yajxth1DNGxbY7nlVNZKMdxSxO+Ra9gGzO6g84K01bxtpI94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b285f04a-0ae1-4d15-a562-08def4715657
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:47:55.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOcN3IRI72AcbQYeUkxnjMXNAJd2CKGNtz1l4Bx1Qq8gKJKW2fr1YOuOB6kIwEUMQWLJnCGq2x0aRibncSJyXfMRK9cWM0RmaLbI53HSyus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608070082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MiBTYWx0ZWRfX4Kn6+RFar2lt
 dQfMrXztiAQSxTOUrTF7bbbYwuwoIjqegUi8B4r4L7A9o5b2HmSnsPOrGQWOvlK9JT/8/pQkpNz
 VZAlGKqmqNZ0xFB9ZYf4iVuBhmYgH/iPcKryvvaoe6LvLPdGV8pBDjJzHgR63w0zQ0DNgfzuEvr
 hYhcFZ1FkiZniO9cKVapXh+ByoJFwX7VPtAiWdRYBxBrGAOoQsfzU3ONu65pGZ0T1241hHmvAjS
 xT39Hu5X5dqvL7S7oT2d/7twGj1ES9cUX6qRBPMBWvJDn3EOe8w75qMOndjEvcZiMVf5uJQ8OcH
 mIy6914uCJgUL5ee32mFee2iOri9VeylkknF4AQ2B5DY2SwR6G7YLheEwGtaTYEgzR0APZFpUEJ
 rLIoUQ04hWAfSiYYr+FHikFuxEDmjeOVDfldDqFMNX5SkIitHaAVsp9EBxY0OUn7mGTxUel/S9W
 Po71nkp4wb4srxa3WQw==
X-Proofpoint-ORIG-GUID: 5r4zFQEziKwzmNkJrznNZ1AP2cUtM_rw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MiBTYWx0ZWRfX9PKrnZYh1R39
 jKCt2xATTUU2SIisteFpb3/rmYrOSc/ekJDInniCbFGKG+gKAO5syHRpcWi6up+FiZTxRx6s8cd
 RU3EeEEZ0BzoNTwT9YTIPVozWPkUzSWvRcT9Y9F1MMvhzW3gXk2l
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a75b7e0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=8PBb4QELvbztoSMJnSMA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 5r4zFQEziKwzmNkJrznNZ1AP2cUtM_rw

Adding the relevant maintainers,
whom I inadvertently omitted from my initial message.

On 07-08-2026 16:12, Partha Satapathy wrote:
> From: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
> 
> Hello,
> 
> We are investigating recurring guest hangs following vCPU hotplug on a KVM/QEMU
> system. We would appreciate guidance on whether x86 CPU bring-up should reject
> a hot-added CPU when its runtime LAPIC ID differs from its ACPI/firmware APIC
> ID, especially when that runtime ID conflicts with an existing CPU.
> 
> Hypervisor system:
> 
>   Kernel: 5.15.0-318.199.3.5.el9uek.x86_64
>   CPU(s):                      384
>     On-line CPU(s) list:       0-383
>   Vendor ID:                   AuthenticAMD
>     BIOS Vendor ID:            Advanced Micro Devices, Inc.
>     Model name:                AMD EPYC 9J25 96-Core Processor
>   NUMA node(s): 2
>   NUMA node0 CPU(s): 0-95,192-287
>   NUMA node1 CPU(s): 96-191,288-383
> 
> Guest system:
> 
>   Kernel: 5.15.0-318.199.3.5.el9uek.x86_64
>   Machine type: QEMU Standard PC (Q35)
>   Guest CPU model: AMD EPYC 9J25 96-Core Processor
>   Guest topology: 2 NUMA nodes, 2 sockets, 95 cores/socket, 2 threads/core
>   Maximum vCPUs: 380
> 
> We observe this issue regularly on the same hypervisor platform.
> The guest topology has maxcpus=380. A group of vCPUs is offlined and then
> hot-added.
> 
> For CPU 17, ACPI/firmware assigns APIC ID 0x011 on node 0. During hot-add,
> however, the CPU reads its local APIC ID as 0x111:
> 
>   [64830.401824] smpboot: Booting Node 0 Processor 17 APIC 0x11
>   [64830.402255] [Firmware Bug]: CPU17: APIC id mismatch.
>                    Firmware: 11 APIC: 111
> 
> CPU bring-up then continues through start_secondary() and
> set_cpu_sibling_map(). The runtime APIC ID causes CPU 17 to be decoded as
> socket/die 1, core 8, thread 0. This collides with CPU 35, which has APIC ID
> 0x111, and results in:
> 
>   sched: CPU #17's smt-sibling CPU #34 is not on the same node!
>   [node: 0 != 1]. Ignoring dependency.
> 
> The CPU is allowed to proceed to the CPUHP online path despite both the APIC-ID
> mismatch and invalid topology.
> 
> Approximately 57 seconds later, the guest stalls globally:
> 
>   - migration/stopper threads wait in multi_cpu_stop() /
>     stop_machine_yield();
>   - workqueues and RCU stall;
>   - CPU 0 has a pending call-single-data request for CPU 17;
>   - CPU 17 does not provide a valid crash-NMI register note;
>   - eventually panics the guest.
> 
> We have observed multiple instances of the same issue.
> 
> Reference dmesg :
> [64830.401824] smpboot: Booting Node 0 Processor 17 APIC 0x11
> [64830.401985] kvm-clock: cpu 17, msr 1071a01441, secondary cpu clock
> [64830.402255] [Firmware Bug]: CPU17: APIC id mismatch. Firmware: 11 APIC: 111
> [64830.404886] ------------[ cut here ]------------
> [64830.404887] sched: CPU #17's smt-sibling CPU #34 is not on the same node! [node: 0 != 1]. Ignoring dependency.
> [64830.404899] WARNING: CPU: 17 PID: 0 at arch/x86/kernel/smpboot.c:434 topology_sane.isra.0+0x7f/0xa3
> [64830.404965]  <TASK>
> [64830.404967]  set_cpu_sibling_map+0x2cd/0x63a
> [64830.404970]  start_secondary+0x5b/0x152
> [64830.404971]  secondary_startup_64_no_verify+0xc3/0x0
> [64830.404976]  </TASK>
> [64830.404976] ---[ end trace 956bce4479c9bf6d ]---
> [64830.405334] kvm-guest: setup async PF for cpu 17
> [64830.405337] kvm-guest: stealtime: cpu 17, msr 1197a74080
> [64830.405470] Will online and init hotplugged CPU: 17
> [64830.651019] smpboot: Booting Node 1 Processor 35 APIC 0x111
> [64830.651133] kvm-clock: cpu 35, msr 1071a018c1, secondary cpu clock
> [64887.589563] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 56s!
> 
> 
> Questions:
> 
> 1. Is it intentional for x86 CPU hot-add to continue after this ACPI/runtime
>    APIC-ID mismatch?
> 
> 2. Should CPU bring-up fail if the runtime APIC ID conflicts with an already
>    present CPU or creates invalid SMT/package/NUMA topology?
> 
> 3. Is there an existing mainline validation path or known KVM/QEMU issue for
>    this case that we should use instead?
> 
> We are separately investigating why QEMU/KVM presents the incorrect LAPIC ID.
> That may be a hypervisor/firmware defect. The kernel robustness question is
> whether Linux should permit CPU hot-add to continue when inconsistent firmware
> and runtime APIC identities result in a conflicting logical CPU topology.
> 
> The relevant UEK code path is identify_secondary_cpu(), including
> validate_apic_and_package_id() in arch/x86/kernel/cpu/common.c, followed by
> set_cpu_sibling_map() in arch/x86/kernel/smpboot.c. We would appreciate
> guidance on the corresponding current upstream validation path and the
> expected behavior for this condition.
> 
> Thanks,
> Partha

