Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58723C51D
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488684; cv=fail; b=ZQ6RqMsUUj4VAaUAg8IrKU8xyGIgbu7RGTvvtsZbvZLDWvspGYo329gh2snj0rdcBqd57jLIhbCmHw+4I/rlV0nXnE+oHZiDYxKj0qayKwtOKAtz2KwjuzjEvP4e2oBhHoOPNMHs7g8+6XpgfB+A2wsKA6wzPey1+cP7xCHp3Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488684; c=relaxed/simple;
	bh=L/VRYZ7vPBLpiEolFk6zFlE/xkRO3Ex50r6k/LQaHps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xed19Gbi9rb9/7rqe7SidhN2Crxx4MdqFkCmSFR3H4C/HBZhWdGAuVZ3l/lxon9meWeIPAVZYbO9njkZ9noW3JtnFLafi+6DGAj/fgcQktAQv+I9TslV+ig3jzsoPeqjUj8PbpuYAX+MPsGmzeuu5KsUsOY3ayVt/KqGR4RrgeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fwoN4JUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RumDbkVL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwoN4JUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RumDbkVL"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636CgBP64131118;
	Mon, 6 Apr 2026 15:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AI5UFHRAaV1c23ieLs9GiYbxS148dcPpnL107pA6vEo=; b=
	fwoN4JULSeipCJ34KzJroel6ya0pC5/h2pxIEld6crGwyQ0X/A4zvUU8d3z02PdE
	2jP+wRVzpzwvprBemv5YhzRTknMHKDgOs7p3EwWhoS43jZP12VgJdjrUzsUWWSA9
	6L5poaur+fl3z1cfF2vnFpb6ucYbXEcifoaopPBvWr2H5mDuUPzPKBuTQiKbMuk+
	dVPuraz4Sf6FYLwVlEZTtYUaCNzaXZWu3yKUEA+3oxhJrYdGou99it61xwlHvB9q
	HwzIloua4Q9Y9PEz2BoZd9eoTa2DNGc7F37MaPIK4m4xQjyRmo2GIwxRccmDyEgz
	HGTMI+/LgiYxPr2tH2jOUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dase12y59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Apr 2026 15:17:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 636DDZa9016064;
	Mon, 6 Apr 2026 15:17:50 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4das3en4am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Apr 2026 15:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt9j2PxAlDJqehg77/KZkC3whPQeyTah0J/HcMFwG2QVItT8y8F907bKA6rr4oRIznWqvYBcRgu5Pj9W0HK1O4XA1D7dfkOQXkMpaJ+aW7ZvO+kK9HPrjz4+pxpzn+JF6i1pvXVdnrOH10/7cKT7iI/VJDifSMjcMOrDde/KR6MgvCX0avQWwQu7ECD693JNaTn50Y2LHhP18+hLfG9YDgkNeWWFiWlj6NgVY6Q5svbMUgREbtmI90i1O0EN/NmHidoV7ULi9/VoZBno8wVdFzn5cioae61OYRIHR23KDPOvOaNw8MHLHGxKkPXeNPwowJ3ahsK53VabbhpDDoJm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI5UFHRAaV1c23ieLs9GiYbxS148dcPpnL107pA6vEo=;
 b=cFI5vfPF1DI373pBUAEW/wS4uLEHZjT7wpY2eZNDu5wbEtkIvrk7pFMaxQqB0davROJqyh+wczkutesYemsl2R50eLXKvApfJZle8NGyQEWumt+g4zY0TMO9PREfS+nHRl8fUx7RNoEjwf7HwIUizX/NNn60hfmBmFXdnPEkH2OTaCl8pqYhgpl6YtOYqrRr2AlUIsrf/0WuojqBLwUg/6Y9dkxc2FN/yMnKWZqR3u+r/n2SgFwd/g7Nd3H/McXTfn6/WnVLwRwzrxzU6HI+07Cah2TOQlY25Yk9vdagr9ljvg8K+fNofATbFHAI/IE4A+xEsBMg5WJ6iNdv/0EFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI5UFHRAaV1c23ieLs9GiYbxS148dcPpnL107pA6vEo=;
 b=RumDbkVLe2RG3ib5ZqcwZsKhqiUV94c7PSLrMeSnlYeTjB/XrjTaEM5zCNPSatl8bAu6f+EyjmREGHGZ9xk9w80vvT4essTZmEi2r+/4faD47c1wrKLs8E9je4HwVDtgN5lNrzCCmvZjd0DciMEqXJwt1Cq9UBzA3G0gApEG55o=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SJ5PPFCC3E08AE4.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Mon, 6 Apr
 2026 15:17:45 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 15:17:45 +0000
Message-ID: <683add92-c9ba-4a21-b1f8-12e40a9a99d6@oracle.com>
Date: Mon, 6 Apr 2026 08:17:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
        "Liu, Zhao1" <zhao1.liu@intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        "Chen, Zide" <zide.chen@intel.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
 <CO1PR11MB5091E0F44CAC1B8DAD9EF085F356A@CO1PR11MB5091.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <CO1PR11MB5091E0F44CAC1B8DAD9EF085F356A@CO1PR11MB5091.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:510:339::29) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SJ5PPFCC3E08AE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 9deafa8c-eff9-4e8b-e83f-08de93efa7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UQJLV+aIc0Z7jNb/OSjhoBb8Ejyne5EhXCCxCvCxxmbxkFpkvTqc/msOzHD041vzfkaclFI96+iOFFSM/JmTaHUHtxWslL8/CQK0gOEkZHydivGhfGUIWdDaBnA+oLH8cvWafMB72R/MZxoQjDsOCfdGP3Ughs1yt6LT+0KaQiapIUZzqBkEowqPEUz/HX9IWYK1m5qv2Pyqzv5nUJCItDQKR2c49htgMoC0sxeaSQkbyrCWc+bWAaMisP6Z1gQxTkZDFxiBikBtq9P82Z72K3cPU7bJdI0Fdym39cAEt0Z9bacI+EWmPAD9VSg03So1gFag9QNzIKWHvRvom8LQtKejLL1k1gyfIDx17VIa6u7zuHjlcIbqJYgjF5/RlswG+la9eYUo1fFcrMQi9Y0yR8W+BkCsFZL7EoIhYLDcOrBgvVnpUPtkOTvktFo8opO72R7OO+mCMC5NJG+ctEpj69tX2z/pafh49wrmDgfCcKiCbnosjkaPqmQTLnrSrq0nEVcTff5gOwYU6sw0FaUQseelUCKPJVRa7ceRpKOxXrtS/2tWX8LbyaGupHMtLOsMWb+bB7gLrNv71gqhx0A/vLDjycud0SPn//uz9SMgsXutq203hGqnC9NL5KEj0dczvw5L4fQbjPk0j6toIJuUeNOXvMyC8R80sHChb1RojL3C9Q32pUeKlhgjfTIdcKskSpZnaLAXc4dM3MyQ9s5Kok9iXoQV8GmvQEN0oS0caCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTVUODM0eTNCdXhRaThNQ1pWM1dTRXdyQ3hyYlVma09YdUpTWFMybDFXQWFt?=
 =?utf-8?B?TXByT1NLTkdQUkV3UWN1UXFyakJQc2JJTDlUKzN4NEpRcUlPUStGNU1ONmVG?=
 =?utf-8?B?VGZKeGxidU1ZdFdUUHo4NFlXL2l2YXpsOGVpV3lRQ1BVTzFxRHlQRU1EK3hr?=
 =?utf-8?B?NDhXUHUzYkN0NmtvQ3NMdFNqUkllZzF2eVJKNFByTWJkaVVQVGl5Z0YyRUhG?=
 =?utf-8?B?UHJTVk9pd3AyaXZHenBTZ2pBaU8xbGVLNENLRCtQMUNvUlNVQzhwUGNvV0NP?=
 =?utf-8?B?YjV3STdCTzNYS0I1Tzd2RlV3WTM0amh5eFhNOHdjR0pNUURLdjBmbW9xdU5x?=
 =?utf-8?B?Qk4rbExsWml0OFBNOUgvbnMrUCtBWHRwUDRMQW91aDRGMlNDa2ZQdlFxeE4r?=
 =?utf-8?B?SUJXa2NER2l0Nk9mZTRleWEyUnhKM05nOWJ6MnAwUWpnY3U1SUpQSkIrK2xp?=
 =?utf-8?B?cmJlekZPUVhtNGVOajRKWHQ1WUd0OWVYejhITUVjMG1kL29Jd2wrdWxIRHMv?=
 =?utf-8?B?RHFMTTh6VEZhbTFaOXo2dUNucHRMcDlNZFZmdG9XRzZNbDRvUkVJUlArRlEr?=
 =?utf-8?B?UXl0R1ZHMmJJY2kvaWtGUzVvTlBWNjRtR3N3UGpUMm1TVy9oWWF2RXhDU2Ra?=
 =?utf-8?B?RWRiS1kzWVBRdmpzSVRwY3cvV0FUR3ptYUtTWUJLU0ZKY0FKU2NCRkNZbEpa?=
 =?utf-8?B?MnZpTFlMYllKTWNNWWFFUEdrS2U3M2YrWXk3ci8rSXBMZzJsTmFoSFA3QmJQ?=
 =?utf-8?B?bHcxbEpDQ0I3ZkFyckc1dkRRT1BZazVKUU9pZk5XdkVISTZwRDRTd0Z1cERq?=
 =?utf-8?B?MTcvSXM5NzBYZ2JqVHlYR0w2U2Zoam90QnBFblBlWnB0VnArNnQ5d1dyeFNI?=
 =?utf-8?B?WVJhak1vNHkzMkdFMmcxS2lSaW9oTVNQSmYwV2EvNDM0TjhSbVp2V3BTOFUv?=
 =?utf-8?B?Wkg5eUJXSm00aU5rUUx1eXEwbVZoMGoyVUR6QnU1VHZPYU0yYUo4R1NNcHB6?=
 =?utf-8?B?Uk9tS2dyNDI2OEJSVTBHVXp0OEZCUFhUSW16NjVCdkFMdzR6VmtFeWJPbUJ4?=
 =?utf-8?B?YWE3SE1ZeHc5TDk0alFPNlNXbUJNYlNSRVhRQ1RINkJsSlc2VVBvMTRNcE81?=
 =?utf-8?B?Q0JONHZydzFVc3c2RHd4eVBVY0cxcjQ5NU5zWk04VW5EV2k2VWIwZHJ5Z2x6?=
 =?utf-8?B?QS90SmJUQ3oxcHNUdmlJRGRYN2pIY09wd1JodzU4REhvR3piL2RYL1c0eEI5?=
 =?utf-8?B?andyUnlmWC9taFQyS2YrMjY2ajZjYmt3WjVJQVlhVmQwTDFlNmJab1FjK0tS?=
 =?utf-8?B?NnNlREY1VDh6ZmpuamwxRVkvRndwdVczcTJOVFVJRWkrQ1BxeWFaZkFocm1E?=
 =?utf-8?B?RmRaaTNxOU5JUCtkeWhuSDZURHJpUmViK3VOMFI0QTBRSk9Jekl1QksyS05K?=
 =?utf-8?B?N25ZMHloT01KRmxUaEtZOVl1YURvNVdYTUZ0bjB5QktqUlcyalNxZmZPaEQx?=
 =?utf-8?B?Q2daWFZRUVMwam55ckd3VmFQbmJaNi9HUXZxcmZCb2VVd3NGYk9UYm13NFBH?=
 =?utf-8?B?aTdlY0NyMllmUXJHTTV0cEdvQSt6cXQyNm9iYk1xSHY3VzJ1NVh5VTBVM1dq?=
 =?utf-8?B?STVsZU1qRFZvVVRxd1A0QzdaTWlBZEpGUVRVNFViNndDSHhUVlc0Zi9qaFZn?=
 =?utf-8?B?R1ppbzRoT3g5eGIxbmczOEtWT3NpejlzZHBockt5dnNEeS81U25wN09IM0p4?=
 =?utf-8?B?aDVNNEFKUjM4TEx1anpzT3FTZ1hKc2x5cm9ZTk9nOWpZK3JxcWg0WG81eTNP?=
 =?utf-8?B?SWViRlpHbGFBN1NMWUFpVEk3Ym5CeXZJbmpCWHpubjdDbStvSG11eml2UGNq?=
 =?utf-8?B?RTYrbFQybEwwamR2WVRRdFVML2RvNmZKL3JYa1M3Vy9BYkNlN0xTRTM2ZEtM?=
 =?utf-8?B?Y2tYdjhCVGl0QmRRU0t3anZDZU1iSG5rNHVqM3pkdFYrWXlFd0VmUXY5dDRt?=
 =?utf-8?B?YWQwMFU1WmVxZzBpVC9xRWFwSDJjWHVlNk44TlExOEplSkc1SUk0aDBrQmky?=
 =?utf-8?B?bk5ERWxseUd6dnhPQXF1cmZ5cDEwcGFjUEdVRkhpZVdxVFhKcEpLQ3VySHZX?=
 =?utf-8?B?QkdudlJJQVM3UFJMUXhmeGJ2L1lyb2NWNnNzWTlMekdOSTgwSDYyU2lwd1VM?=
 =?utf-8?B?RXZpRkRMN24vMHVIUnN2SjFCUjBlU0x6YVdkNjArMjZYWTZzTEsyTkQ0b0I5?=
 =?utf-8?B?OEtMN0ZpM1h3a3VVRUpHNjNWTHhmSERXMndKczlmNnBLY3hScnR1MFBsMDJH?=
 =?utf-8?B?eXFEVGJOOWVWS2FORXJFamZtZDE1eVBudVR1aTgxRlVCZlVCWTlyUT09?=
X-Exchange-RoutingPolicyChecked:
	UYEOYzwRgkG0UmcRNy+zloHUfu8tt6vDEPUMtohA3ZFR9yw/IPOhWEnsUdlbKCwezynKPkQAWYZW/Eqs1W6Mt7RNruZvmx1Il2In14zcYEcOM15WbgUxUYul0uZ30wWCKe1DigTrevEFc6Nb3MWlC4VbTfuoGnCwqPtrwMDYMbSNMRvS6pfFfgSSHmD/UITyou6pZFgykddZv0Lc5WFHVPjqCHJpokhMkqL9W6DE7JQgiakOk+65aR2Y2FWVcCBWTxqkhgflf6ly9cykFygkL11JVT5a9A+wdVaxknaiTTvAuQlda7+tCIydCzIBrZoHqjytUZgZIvQvDAWb+Kpbfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vf71LaNw1krihzYJkUkkUnEADrECah84iIULJ0cyxPj5wCJ38ZVOQIswoDfJ3TM5q+AhUKjae6hbJ/96XuAXgseP+OvDINBYKVq/SrdaP824I0sNzVUJn38L0U2rVaiXWkj/DRnsiHu+h9dTqdNOGALUgWV6RsUC1NQgm8kAWrJhs769GGWaKz/F9fqa+I+MhEhjTQrQ8y2mmJH+MR6ULIsJ+1u8w/OGHRZRUo47DQOlBtPwFUU9kC963NsL/9I6/vrzdeJRYTnqIGgk8t73ATUs+KQ2tRrkJObvT2taALxR3du8sU6Rv7nu93og7yKJmnWB1GQdpdbOuI0cMEIXICLIEOX2KexNbH1TAnkTt9tqjqv3+a639FN7jtxDVfAyHdQ0+ZJQZuFgmrj7tCYgmWrpftLg/1l7qNg1Ut55AKiwyJGfPsj7nXWBPiK1dotSrHq/03s3VbDz46xzLqBH+TMJ4Jk7wj7UZ5h6zDgUNbPtEpuJwDHdlQIr69CGBd6UxBNV+5vte40hzLHOHuX4477zRzE4SLq1C9xWxipqB+MolUFc5Vm9cQgwzvHXQi2yidDhkyf2vLvDsGKg4iOiOub5bARgUpjtIeE1X/0Nczg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9deafa8c-eff9-4e8b-e83f-08de93efa7dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:17:45.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik//QvkHs2o0MFKoLFUNt0v98Jpye0VmpwQIJEMOTBaSCDgrG8htz7Zw3st2l6n5wCQnAAynOpwdNJmum91caQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC3E08AE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604060150
X-Authority-Analysis: v=2.4 cv=d4r4CBjE c=1 sm=1 tr=0 ts=69d3ce9e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=4aTtcmQ7ZoC8a4R_zZwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13825
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1MCBTYWx0ZWRfX/sxPmS2bQt1v
 sFxriwZqifoDq0OKy1RG3yl3dMHK5+bZba9KSjHSYVEOS652AcNi9stuFre79l4eD0em87MkmIw
 igcd00xmye39sZuopPtjK87uQ4LFp73HY1q68nkfThgB3tO7oHtRxFhaBjG04Q1Y/ZTt4X7H2aX
 u+B1b+QPSrHUnVNHjUsv+eREhcOK4Rj88p+H/gku1WzN15mj4OdYREcW3xMUn9CUa85uM/S0Ibm
 KMzS9arcbIwVm/apxtwtkVNbgyx0LP0Ebpc1FWn9lwmvn+eDL74mDj31ed7zxAEnTqBbCIgWgBl
 LdRvYHIZ6F45LcgI+mDi7Ipo+QkR4CPoUv43DtnFd1uw1WH5w32kzixPj4ZAzpAgVL8lKypfduX
 A3N4ls8At8feUjXJbFnEsPvTpb0I74hRzonLJPlyeQLsvpfOH2NUQLf18HTijMPjwIHW16hmN78
 9Osic6fXk9JTWcafIKBm3oLRDX79fX0asQOOQuqY=
X-Proofpoint-ORIG-GUID: GLT8hog266Hw7txNXPcKn0k8KIaNz65H
X-Proofpoint-GUID: GLT8hog266Hw7txNXPcKn0k8KIaNz65H

Ping?

Any chance we can merge this bugfix? This change fixes AMD vPMU live migration
for the upcoming v11.0.0.

Thank you very much!

Dongli Zhang

On 3/26/26 9:44 AM, Chen, Zide wrote:
> 
> 
[snip]
>>
>> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
>> reset")
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
> 
> Reviewed-by: Zide Chen <zide.chen@intel.com>
